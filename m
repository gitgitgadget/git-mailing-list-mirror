Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D815D20281
	for <e@80x24.org>; Sat, 30 Sep 2017 06:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbdI3GW7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:22:59 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:49277 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdI3GW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id l188so793223pfc.6
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hhHhusRAfaammRqmtXeG8sAE4rwJ/bYw/vY6qo8xklk=;
        b=aQPClbA2qu/E3UWJl56FmCB7YtPCHzZBd4wnpGMntEN5ciNk4QSSaslHstRPvh+QfS
         EarX0XwN1ZmiP7LcSgM9KDUeg7qU3OtDqAdtQ/qZ15Nok7aLITpfWdxS935eESNIWcbV
         2f/tVOjgOBlqPThZRaRyu2schLryxP5AdOH89/wXQ5zh5tjoK50tasbDdLq1sYUUzCkU
         42D6B1B4ttPgAS7VO2EtvU20R1mlCyBAhNwC73HKAM0wtyBTCYncblEwlrS9Hg+sDPcF
         acSrAjWQboR0C0/uhNokSFu2fMMSsFgfev/78db4G19JGQcGV6Xu1dty+fPPZoKpj3YR
         pdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hhHhusRAfaammRqmtXeG8sAE4rwJ/bYw/vY6qo8xklk=;
        b=AS0wr3/dK+nsU5fjvuSSkl5XnSlew2SjuMRsczGvWgRT6kkjYcCRXfLVFrvw872W7Y
         j9yUeZeMwyzB/36hQA2U4W3KIRCDkHCMm5eUYE6VGorIHsscBgWaLDM6e8oC1wrD8IO+
         OkP/YrpYWFvX1dmV34HIlZ4vVsouAE3mduUXmyZ2yj8Dz7dElTFPIw7RCJHoHPGceglr
         R+gODi0AmiaQ2QXN68ZZnlR5Il5Bb4uQ5RkJNowKHmbvJAmO7HXRBUXRyGlrimg/8GLI
         9wUAMp/mRKns+8vLXC5k0eeDnUIT5Ji6uXF4/p/lMO5p+oYE9eUIEc2XZCJhT2WuCKP6
         maIA==
X-Gm-Message-State: AHPjjUhQtCSHpZciwAxREdIv8iPcezANQ8f6YZZEujO1ljIOlzOUgbsI
        fvaNIwL5UhsMFXyFN9kjm8msJnoQ9mU=
X-Google-Smtp-Source: AOwi7QC/KIwHQ52a4yl1Cy45qCTIvIrR+f4tvXlbkJyw9hygN+JqMpuuR4h/kBw88iwlX1YvztXRNw==
X-Received: by 10.159.208.5 with SMTP id a5mr9334003plp.436.1506752575206;
        Fri, 29 Sep 2017 23:22:55 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id d23sm9507746pfe.115.2017.09.29.23.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:54 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/5] ref-filter.c: use trailer_opts to format trailers
Date:   Fri, 29 Sep 2017 23:22:37 -0700
Message-Id: <20170930062238.87077-5-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
References: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation to support additional sub-arguments given to the "%(trailers)"
atom, use 'format_trailers_from_commit' in order to format trailers in the
desired manner.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-for-each-ref.txt |  6 +++++-
 ref-filter.c                       | 31 ++++++++++++++++++++---------
 t/t6300-for-each-ref.sh            | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 03e187a10..b7325a25d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -213,7 +213,11 @@ line is 'contents:body', where body is all of the lines after the first
 blank line.  The optional GPG signature is `contents:signature`.  The
 first `N` lines of the message is obtained using `contents:lines=N`.
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as 'contents:trailers'.
+are obtained as 'contents:trailers'. Non-trailer lines from the trailer block
+can be omitted with 'trailers:only'. Whitespace-continuations can be removed
+from trailers so that each trailer appears on a line by itself with its full
+content with 'trailers:unfold'. Both can be used together as
+'trailers:unfold,only'.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index 84f14093c..8573acbed 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -178,9 +178,23 @@ static void subject_atom_parser(struct used_atom *atom, const char *arg)
 
 static void trailers_atom_parser(struct used_atom *atom, const char *arg)
 {
-	if (arg)
-		die(_("%%(trailers) does not take arguments"));
+	struct string_list params = STRING_LIST_INIT_DUP;
+	int i;
+
+	if (arg) {
+		string_list_split(&params, arg, ',', -1);
+		for (i = 0; i < params.nr; i++) {
+			const char *s = params.items[i].string;
+			if (!strcmp(s, "unfold"))
+				atom->u.contents.trailer_opts.unfold = 1;
+			else if (!strcmp(s, "only"))
+				atom->u.contents.trailer_opts.only_trailers = 1;
+			else
+				die(_("unknown %%(trailers) argument: %s"), s);
+		}
+	}
 	atom->u.contents.option = C_TRAILERS;
+	string_list_clear(&params, 0);
 }
 
 static void contents_atom_parser(struct used_atom *atom, const char *arg)
@@ -1035,7 +1049,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "trailers") &&
+		    !starts_with(name, "trailers") &&
 		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
@@ -1060,13 +1074,12 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_TRAILERS) {
-			struct trailer_info info;
+			struct strbuf s = STRBUF_INIT;
 
-			/* Search for trailer info */
-			trailer_info_get(&info, subpos);
-			v->s = xmemdupz(info.trailer_start,
-					info.trailer_end - info.trailer_start);
-			trailer_info_release(&info);
+			/* Format the trailer info according to the trailer_opts given */
+			format_trailers_from_commit(&s, subpos, &atom->u.contents.trailer_opts);
+
+			v->s = strbuf_detach(&s, NULL);
 		} else if (atom->u.contents.option == C_BARE)
 			v->s = xstrdup(subpos);
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2a9fcf713..2bd0c5da7 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -597,6 +597,9 @@ Acked-by: A U Thor
   <author@example.com>
 EOF
 
+unfold () {
+	perl -0pe 's/\n\s+/ /'
+}
 
 test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
@@ -610,6 +613,43 @@ test_expect_success 'set up trailers for next test' '
 	EOF
 '
 
+test_expect_success '%(trailers:unfold) unfolds trailers' '
+  git for-each-ref --format="%(trailers:unfold)" refs/heads/master >actual &&
+  {
+    unfold <trailers
+    echo
+  } >expect &&
+  test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only) shows only "key: value" trailers' '
+	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	{
+		grep -v patch.description <trailers &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
+	git for-each-ref --format="%(trailers:only,unfold)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:unfold,only)" refs/heads/master >reverse &&
+	test_cmp actual reverse &&
+	{
+		grep -v patch.description <trailers | unfold &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers) rejects unknown trailers arguments' '
+	cat >expect <<-EOF &&
+	fatal: unknown %(trailers) argument: unsupported
+	EOF
+  test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
+  test_cmp expect actual
+'
+
 test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
-- 
2.14.1.145.gb3622a4ee


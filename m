Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1095F200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755541AbcL0QXp (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:45 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34820 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755440AbcL0QXk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:40 -0500
Received: by mail-pg0-f67.google.com with SMTP id i5so12839684pgh.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yhdP2FjGsjG0MODeBxwj25zsuLtao7U2Cbj7xRiLDdY=;
        b=dQoGsFDzZVB/a+ao47TUwT15cztTogjlalrlSvamA9DEStBF58JeX0FQ/yZESibr5U
         csCA/JHWl0bJoQuvWV69Yigf1bBcp9XiKo/pKfOC7N2tOHer5x86kMs8AYRQp/YYfk6h
         dKz1mKQfdPHEu+7Ie0x/8LDSSc0QZsyCFN9VJqx/KBTRUPnbyK3p3uheFW+RlNIi4JKv
         b5gheRFKM23XPUdDG+vkTbwzTqUDeRIooqhY35tHdxAHvG3kVloeuvJZ3J3ozcjq/ZaG
         7Z1nXDsNjZNUXZSS8Yvm71DNz4DvhZ7AH3mzY7NsI7CD7LDmwGHOb3lcGAUCPOporgRz
         rMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yhdP2FjGsjG0MODeBxwj25zsuLtao7U2Cbj7xRiLDdY=;
        b=RA7KJuQXh+g9fQrS6JQs/iCRR+2Yax5GsObHHpv4+WPtr3b/jfQkHwuZR1SNpsBXq8
         9Ma1XSTVhdbem+v5qXBSN+IXb3g+OiIzwndq/fx6Pc2Nm8WpZ5tOKNtdt9KfxemYQ2Q/
         jaKWt/TdFjW/ADaoDB8PZwKjesqAKcs38myd1B83RMO05WD6X7HUDMeMGNIdP9RMVZki
         tbFtNYES/GduegmVRWUbS17vhSIjUlSWwjTnOH2ZN59K0qXn6ccIRfqAjjZmnXkOuIe0
         2h7hb8/A0dcO2+4faAXX7trQuiujIXaav8JlQME8jbTZLRJoOvDspJbLUG+gaQ4RMc4Q
         YQfw==
X-Gm-Message-State: AIkVDXJPTqWhRlt+c+PsQ2t7aeyG+cGoUerTSIoqSWKkEbIOevYed/bnuVyyu4VZ88eOFA==
X-Received: by 10.84.210.233 with SMTP id a96mr67533497pli.72.1482855814522;
        Tue, 27 Dec 2016 08:23:34 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:33 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>,
        Karthik Nayak <Karthik.188@gmail.com>
Subject: [PATCH v9 09/20] ref-filter: make "%(symref)" atom work with the ':short' modifier
Date:   Tue, 27 Dec 2016 21:53:46 +0530
Message-Id: <20161227162357.28212-10-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

The "%(symref)" atom doesn't work when used with the ':short' modifier
because we strictly match only 'symref' for setting the 'need_symref'
indicator. Fix this by comparing with the valid_atom rather than the
used_atom.

Add tests for %(symref) and %(symref:short) while we're here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6de0927..e98ef4b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -352,7 +352,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at].name, "symref"))
+	if (!strcmp(valid_atom[i].name, "symref"))
 		need_symref = 1;
 	return at;
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index af76dc5..7663a36 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -38,6 +38,7 @@ test_atom() {
 	case "$1" in
 		head) ref=refs/heads/master ;;
 		 tag) ref=refs/tags/testtag ;;
+		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
 	printf '%s\n' "$3" >expected
@@ -566,6 +567,7 @@ test_expect_success 'Verify sort with multiple keys' '
 	test_cmp expected actual
 '
 
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout master" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
@@ -600,4 +602,26 @@ test_expect_success 'basic atom: head contents:trailers' '
 	test_cmp expect actual.clean
 '
 
+test_expect_success 'Add symbolic ref for the following tests' '
+	git symbolic-ref refs/heads/sym refs/heads/master
+'
+
+cat >expected <<EOF
+refs/heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref) atom' '
+	git for-each-ref --format="%(symref)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+heads/master
+EOF
+
+test_expect_success 'Verify usage of %(symref:short) atom' '
+	git for-each-ref --format="%(symref:short)" refs/heads/sym >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.10.2


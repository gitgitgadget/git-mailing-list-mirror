Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8D31F488
	for <e@80x24.org>; Fri, 10 May 2019 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEJShJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 14:37:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38276 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfEJShJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 14:37:09 -0400
Received: by mail-io1-f65.google.com with SMTP id y6so5283780ior.5
        for <git@vger.kernel.org>; Fri, 10 May 2019 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jFWxrcWH8E3ZDoOSj7OapKDs2GUM09ZtgWu5pJkv2c=;
        b=r2iOrMa4rVH8+yi9v1l716dmjv3swPdISgJ4vqMNoLTnA56vczzrf18hhBuWolHEzO
         WAg2Ygy3cRRQ+iLZ5rcGiP0SLe3knjf6qGg9KFoQ/CHnK5foMSynWO66zAu3a3EZ+FW7
         vHqG/s+/AYset9HvfRVXWrV5KsoIcvr/UZbibWXUnRByHYhDCf9kfRc1d98GmSyu+ESy
         ICGk/GT5RYBAJN8MoEllFsNlJougxzhIx+RIiQJidPYu/ciPX0IAv55sr0t24+frEQc5
         iIjkE30vMhlP0wm6x0Nj1lcMbeFr/+NQpqk1jHcwyL5Z70PBSay6afQH70RF5mznGPTB
         bPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jFWxrcWH8E3ZDoOSj7OapKDs2GUM09ZtgWu5pJkv2c=;
        b=UVZPVX/rtZCrNiqHz0mJGtevFKqb4H4rmspQiedEhzzgHEtwi0n1SJ/3p57gVsSaN6
         0uwM0oXbC2L3aJrGjk4xxx00HoASfLhYSXbdkREwfut1w4W+3C9mP9ZcS5SrNwfUulrn
         F8GUn4B+Q0nu0Jwx+Ynt5kUvByAxESnUeu1nnFTn0IT7lZLHny30RySi+G2bCdA2jPAJ
         ogOSvQ5j1X/4aywuWoM5fyW8dl23hwfjQib2UWj4I8eEAos4uuN2JsNkkAxYZEpxWyQZ
         SOeNvXqckdtp+Vo8Z3TMnM9YGr4xJF40vxrE7MjZPwQp6I1cTRkNsFOjvzIZKQTKvC+E
         2UNQ==
X-Gm-Message-State: APjAAAW4qKBplET/BFBa39SsF9oM27TuSEmm0UJxKbtkndrRtbzI290k
        Jr+6DVefb1SAPcjgDvZNKvyTHzSr
X-Google-Smtp-Source: APXvYqx+d9eRwEUEC5R3XQ3scwaz/HH1r0ZqBKSQ5lDWIa76hJrWSaPWVZ+qB/sLngfJIf9wRaOP2g==
X-Received: by 2002:a6b:ef07:: with SMTP id k7mr7471461ioh.276.1557513428088;
        Fri, 10 May 2019 11:37:08 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id w194sm725686itb.33.2019.05.10.11.37.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 11:37:07 -0700 (PDT)
Date:   Fri, 10 May 2019 14:37:05 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 2/2] format-patch: teach format.notes config option
Message-ID: <df864c4adf4dcab5f959007f87b1c4d0eafecb52.1557513353.git.liu.denton@gmail.com>
References: <cover.1557327652.git.liu.denton@gmail.com>
 <cover.1557513353.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557513353.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch, notes can be appended with the `--notes` option.
However, this must be specified by the user on an
invocation-by-invocation basis. If a user is not careful, it's possible
that they may forget to include it and generate a patch series without
notes.

Teach git-format-patch the `format.notes` config option. Its value is a
notes ref that will be automatically appended. The special value of
"standard" can be used to specify the standard notes. This option is
overridable with the `--no-notes` option in case a user wishes not to
append notes.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    | 13 ++++++
 Documentation/git-format-patch.txt |  3 ++
 builtin/log.c                      | 18 +++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index dc77941c48..e25f9cfc61 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -85,3 +85,16 @@ format.outputDirectory::
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
+
+format.notes::
+	A ref which specifies where to get the notes (see
+	linkgit:git-notes[1]) that are appended for the commit after the
+	three-dash line.
++
+If the special value of "standard" is specified, then the standard notes
+ref is used (i.e. the notes ref used by `git notes` when no `--ref`
+argument is specified). If one wishes to use the ref
+`ref/notes/standard`, please use that literal instead.
++
+This configuration can be specified multiple times in order to allow
+multiple notes refs to be included.
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 2c3971390e..9ce5b8aaee 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -275,6 +275,9 @@ these explanations after `format-patch` has run but before sending,
 keeping them as Git notes allows them to be maintained between versions
 of the patch series (but see the discussion of the `notes.rewrite`
 configuration options in linkgit:git-notes[1] to use this workflow).
++
+The default is `--no-notes`, unless the `format.notes` configuration is
+set.
 
 --[no-]signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
diff --git a/builtin/log.c b/builtin/log.c
index e43ee12fb1..9d26e0f248 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -779,6 +779,8 @@ enum {
 
 static int git_format_config(const char *var, const char *value, void *cb)
 {
+	struct rev_info *rev = cb;
+
 	if (!strcmp(var, "format.headers")) {
 		if (!value)
 			die(_("format.headers without value"));
@@ -864,6 +866,20 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			from = NULL;
 		return 0;
 	}
+	if (!strcmp(var, "format.notes")) {
+		struct strbuf buf = STRBUF_INIT;
+
+		rev->show_notes = 1;
+		if (!strcmp(value, "standard")) {
+			rev->notes_opt.use_default_notes = 1;
+		} else {
+			strbuf_addstr(&buf, value);
+			expand_notes_ref(&buf);
+			string_list_append(&rev->notes_opt.extra_notes_refs,
+					strbuf_detach(&buf, NULL));
+		}
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1617,8 +1633,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
 	init_log_defaults();
-	git_config(git_format_config, NULL);
 	repo_init_revisions(the_repository, &rev, prefix);
+	git_config(git_format_config, &rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc44..e0127282ba 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -738,6 +738,76 @@ test_expect_success 'format-patch --notes --signoff' '
 	sed "1,/^---$/d" out | grep "test message"
 '
 
+test_expect_success 'format-patch notes output control' '
+	git notes add -m "notes config message" HEAD &&
+	test_when_finished git notes remove HEAD &&
+
+	git format-patch -1 --stdout >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out &&
+
+	test_config format.notes standard &&
+	git format-patch -1 --stdout >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --notes >out &&
+	grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --notes --no-notes >out &&
+	! grep "notes config message" out &&
+	git format-patch -1 --stdout --no-notes --notes >out &&
+	grep "notes config message" out
+'
+
+test_expect_success 'format-patch with multiple notes refs' '
+	git notes --ref note1 add -m "this is note 1" HEAD &&
+	test_when_finished git notes --ref note1 remove HEAD &&
+	git notes --ref note2 add -m "this is note 2" HEAD &&
+	test_when_finished git notes --ref note2 remove HEAD &&
+
+	git format-patch -1 --stdout >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note1 >out &&
+	grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note2 >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note1 --notes=note2 >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+
+	test_config format.notes note1 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out &&
+	git format-patch -1 --stdout --notes=note2 >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes --notes=note2 >out &&
+	! grep "this is note 1" out &&
+	grep "this is note 2" out &&
+
+	git config --add format.notes note2 &&
+	git format-patch -1 --stdout >out &&
+	grep "this is note 1" out &&
+	grep "this is note 2" out &&
+	git format-patch -1 --stdout --no-notes >out &&
+	! grep "this is note 1" out &&
+	! grep "this is note 2" out
+'
+
 echo "fatal: --name-only does not make sense" > expect.name-only
 echo "fatal: --name-status does not make sense" > expect.name-status
 echo "fatal: --check does not make sense" > expect.check
-- 
2.21.0.1049.geb646f7864


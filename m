Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3726A1F461
	for <e@80x24.org>; Thu, 16 May 2019 23:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfEPXOS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 19:14:18 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54376 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfEPXOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 19:14:17 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so8977255ite.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eE+r8JJGMHu+pgzloroHn4CUjFFV7Q37uFcy94XPYCo=;
        b=TXBYHYJSedZvzNmYc+PwP8LX+phu2o2/gBGYH876yg5el64dUUtGx+NfhcWCZte6UQ
         0/a5DOaAYrIHiLDYB1EyrTDWnEQThWLVynNTrtA/vO2CH4/8EXhucPpNsDQSF/sPmo/5
         kIRY6jkOqst0D6xp2C9w+PhLtjy2+BD0SO1oJRGBhx9Ag5IfNDeZ68Dh6hA6JpC86z8V
         wDDlMxdNS0FJsZZxnt9e72p/oaTQ4U7b+22Eel8JFH1XycKvSC/gA0u4vKgSWz+1v8ZK
         1bI3AuA6a7xP6FoXSibvUrR1bGchnbxzu9dJ5MqDZhOglUDuG23AWHH+9f7ZA4DQ8rNr
         b39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eE+r8JJGMHu+pgzloroHn4CUjFFV7Q37uFcy94XPYCo=;
        b=SLJldYcFM16gxOAgPlZJZsfDxLBbJwQQ/MnRLgdUqOD1I4e/Ilwh6qx05tv41JDWoV
         y2ljfGeT+G46bAEmPIlmB3M1cRfaKd5Q7zqPWF8LwqqVEAygYC7or7trmMQaH3jiwhod
         SvKcYvlxB1P7XUFu3En3f3Fzb97SASkU7hthmSWyCsAoxHP3zhHghg6VNI3xNzCmpd5V
         Xh7egYHIDTR2O7Eop4hD1invPFtlrsHvA+su8hJiLtcqWwvopbM0M8xmmzdoIWgYfUjT
         QfBdwIV29OevWoyCXS7QsgPXGZHnws5/F3JPsf/B99nwGwix5i3rXTZwhBGdqAbyNgZK
         k9ug==
X-Gm-Message-State: APjAAAXxiI37hyKu8F3fJ5yVE53MAKzKVqeX8u9YFdsgj15Fdmb5Ipgc
        XX1yrt5fdouUotha/wQoK5RdxopK
X-Google-Smtp-Source: APXvYqxM4/nppnKAaPPx7m4SEQ1G17BtwnHsP7KPq03FtROGauYePBoiSRDHDARG24u2hEMBFUqZHA==
X-Received: by 2002:a24:8a83:: with SMTP id v125mr230243itd.168.1558048456462;
        Thu, 16 May 2019 16:14:16 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id m30sm2340185iti.41.2019.05.16.16.14.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 16:14:15 -0700 (PDT)
Date:   Thu, 16 May 2019 19:14:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 2/2] format-patch: teach format.notes config option
Message-ID: <7cb770e190f235accf50e4af3ec9a964f26358c5.1558048212.git.liu.denton@gmail.com>
References: <cover.1558048212.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558048212.git.liu.denton@gmail.com>
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
 Documentation/config/format.txt    | 15 +++++++
 Documentation/git-format-patch.txt |  3 ++
 builtin/log.c                      | 20 ++++++++-
 t/t4014-format-patch.sh            | 70 ++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index dc77941c48..414a5a8a9d 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -85,3 +85,18 @@ format.outputDirectory::
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
 	format-patch by default.
+
+format.notes::
+	Provides the default value for the `--notes` option to
+	format-patch. Accepts a boolean value, or a ref which specifies
+	where to get notes. If false, format-patch defaults to
+	`--no-notes`. If true, format-patch defaults to `--notes`. If
+	set to a non-boolean value, format-patch defaults to
+	`--notes=<ref>`, where `ref` is the non-boolean value. Defaults
+	to false.
++
+If one wishes to use the ref `ref/notes/true`, please use that literal
+instead.
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
index e43ee12fb1..dad63cffc6 100644
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
@@ -864,6 +866,22 @@ static int git_format_config(const char *var, const char *value, void *cb)
 			from = NULL;
 		return 0;
 	}
+	if (!strcmp(var, "format.notes")) {
+		struct strbuf buf = STRBUF_INIT;
+		int b = git_parse_maybe_bool(value);
+		if (!b)
+			return 0;
+		rev->show_notes = 1;
+		if (b < 0) {
+			strbuf_addstr(&buf, value);
+			expand_notes_ref(&buf);
+			string_list_append(&rev->notes_opt.extra_notes_refs,
+					strbuf_detach(&buf, NULL));
+		} else {
+			rev->notes_opt.use_default_notes = 1;
+		}
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -1617,8 +1635,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
index b6e2fdbc44..4d5719fe2c 100755
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
+	test_config format.notes true &&
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


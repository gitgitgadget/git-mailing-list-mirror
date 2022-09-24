Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63B3C32771
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIXWwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 18:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiIXWwf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 18:52:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FDE4507F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:52:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y5so5054660wrh.3
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date;
        bh=NvFZzeRVLB22TtUrYAW4qaBYueJhuyMBwQlip9rVOss=;
        b=mOjCWmMJ7F46Fst9hTAy1BE0oVmOIS/z8/Gw/jftsmNdja2EnW978A/0Rlii6goipb
         EXdK/GyKcZaEUN2iwoPgHmcgHKC/8s1mYGRAMxtARENKQeOI7eCQOgjakRrwyuoj9KKX
         s5ZegOMhF91Rt9a79e/zjIdqDBBU7+fHc15eD/HZzwBesvbpa5BQ5SZvy4na40BQFsLH
         1IWpG1Z2TT55eraoEAfyb1ftSfRY113gf7M0fULdYHPMTZ/vlrr0FISk2evmU3u26cmJ
         KMoCsNeMmhTM573SMlBymY5YrSFJZt2ZTK9pooybdpUKjZSApOlSY5BfNfxD6mzgeq5J
         hrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NvFZzeRVLB22TtUrYAW4qaBYueJhuyMBwQlip9rVOss=;
        b=1SVP5nE+JzYimq0Luh1etL+Xk8OmxtLuO9JU1hIVyG8zAwHJ1tdB819e9cDZedLW0E
         zou9CmAlQt0JiDVYQkk+3FevML44lYxUsNYdOUMDC6hS8nE38wyAtEE8C+sopWG6h6AE
         TdcSLbOtZueMOLXzDe8xz5vOt9OQY8W99xbIu54iUKg/1rPUszCdP8dlXZWmqlLVTQ2V
         ZRJsLVA92107FxLNQLBB6UflinhG3/NaALMvzhZkhoTSMbmwyFnZ0WhBPVvjsZ7N+U6d
         CF3lniXfbo/LxKhSEH2jHDtpFMyGKcErDSN3NjtqvPnFqqBiERLYjxsuXwLWCpJI6YNS
         LhMQ==
X-Gm-Message-State: ACrzQf1Bf5CE2RWxwQSyaEDQByVSjbQZ2Q4gAF19O0gIjMivMqplT3W+
        qa8kdk5EhRGzFcD34v7pATXnyu89zS4=
X-Google-Smtp-Source: AMsMyM4NyvpuMf6HmtB1cqkEgkPwjkPwdUdPMqF0cVZuf9JUfAoVuIKacz7P6FLd6hFDHrupRlBQAw==
X-Received: by 2002:adf:d22d:0:b0:228:7882:a57a with SMTP id k13-20020adfd22d000000b002287882a57amr9039992wrh.429.1664059952237;
        Sat, 24 Sep 2022 15:52:32 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d558e000000b00224f7c1328dsm10494761wrv.67.2022.09.24.15.52.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 15:52:31 -0700 (PDT)
Subject: [PATCH] branch: description for non-existent branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
Message-ID: <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com>
Date:   Sun, 25 Sep 2022 00:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the repository does not yet has commits, some errors describe that
there is no branch:

    $ git init -b first

    $ git --edit-description first
    fatal: branch 'first' does not exist

    $ git --set-upstream-to=upstream
    fatal: branch 'first' does not exist

    $ git branch -c second
    error: refname refs/heads/first not found
    fatal: Branch copy failed

That "first" branch is unborn but to say it doesn't exists is confusing.

Options "-c" (copy) and "-m" (rename) show the same error when the
origin branch doesn't exists:

    $ git branch -c non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch copy failed

    $ git branch -m non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch rename failed

Note that "--edit-description" without an explicit argument is already
considering the _empty repository_ circumstance in its error.  Also note
that "-m" on the initial branch it is an allowed operation.

This commit makes the error descriptions for those branch operations
with unborn or non-existent branches, more informative.

This is the result of the change:

    $ git init -b first

    $ git --edit-description first
    fatal: No commit on branch 'first' yet.

    $ git --set-upstream-to=upstream
    fatal: No commit on branch 'first' yet.

    $ git -c second
    fatal: No commit on branch 'first' yet.

    $ git [-c/-m] non-existent-branch second
    fatal: No branch named 'non-existent-branch'.

Signed-off-by: Rubén Justo <rjusto@gmail.com>

---

Just re-sending with the Signed-off-by label. Sorry.


 builtin/branch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..5ca35064f3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,6 +538,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
+	if (copy && !ref_exists(oldref.buf)) {
+		if (!strcmp(head, oldname))
+			die(_("No commit on branch '%s' yet."), oldname);
+		else
+			die(_("No branch named '%s'."), oldname);
+	}
+
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
@@ -805,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
 
-			if (!argc)
+			if (!argc || !strcmp(head, branch_name))
 				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
@@ -848,8 +855,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(branch->refname)) {
+			if (!argc || !strcmp(head, branch->name))
+				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
+		}
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
-- 
2.36.1

Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466FC43215
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EADF206D4
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7tZ7QnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfKWTzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:55:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38559 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKWTzl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 14:55:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id z19so11478030wmk.3
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bmJq5oREAQMGRVnm24JtRONNptbbulSpf0qjRI28EuM=;
        b=X7tZ7QnKkTasTlSKX/fKMJQO/+AQztBd8w9jkPxoXnWLEun9irDFNwjEOP5Z7VYexx
         hn5rD7Nr9MPhRi32DO4p9bUNzgjcUYgshyIR7xFW9kLS2KaELFeYWVKEAkLwjkEAjH8b
         R8TAxlCj/J+CHhJhVqObUOLMpSgplkK+PI/ei5ohluf2lC7w4toLLUXDpQe7w6R7LTvS
         kBOy3pEJNJV8nix12zCisPhGeQNdEQZ0zwXL41yhxsOu+v5GPZj49fKpxmMRcjkJCkbC
         P7X40Tx8QP+o8RpUhyiOMJTsJkkAg/mPJqkhbd2XmEk8kWJaAUrGmmCL5JOJ5/d/RB5W
         3nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bmJq5oREAQMGRVnm24JtRONNptbbulSpf0qjRI28EuM=;
        b=Ub5Vo/fP2ms03qcryS9E0DnIkaco9Y4YWpXCH4VXzErXQ8ZEXY6gY78GBUXqcg0b5E
         tJHoRVPrid/R78dMhcPCtcnTygFVQaa0sN3rhEfVMXPwARgTMPWNA3aBAEh2Z4qKTX7O
         97jsO0Jp2aepy0+YiU6vneo1hGnDQRbTut5bRQopGS6RGNQyU61XnIg0PDox8oW+OO8z
         RAdlOuXS08h4TRhE+i3Ef9t4AjuJh42cmgINIqcnptRJgccs3ZXMozcUk5Ul6EJNtbjy
         jiEGgXz8rVcJuKpXwT/v11wXANVJ0nfwlNhpqZKB//pc/aLAF84LH69jkIO+9WjKFcyv
         bzIA==
X-Gm-Message-State: APjAAAVmKRALv3O2klpuz64cYuePniwh10mNou4W5auZgalGZBuOj6Pd
        psZ7ws+MrWxbIqQuo6nNymg4iMpX
X-Google-Smtp-Source: APXvYqxyen75fIRMInLYxzjcxel201y0qpiok5zEiDMhHNxaz0jbMQoIy/0IC4oX4wV1u0OhLjtx2g==
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr23178049wmi.64.1574538938783;
        Sat, 23 Nov 2019 11:55:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j67sm2955806wmb.43.2019.11.23.11.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 11:55:38 -0800 (PST)
Message-Id: <338c2777f711ac21a30a7f890a8a11708e9a4fa6.1574538937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.474.git.1574538937.gitgitgadget@gmail.com>
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Nov 2019 19:55:36 +0000
Subject: [PATCH 1/1] reset: parse rev as tree-ish in patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>,
        Nika Layzell <nika@thelayzells.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nika Layzell <nika@thelayzells.com>

Relaxes the commit requirement for the rev argument when running
git-reset in patch mode without pathspec.

The revision argument to git-reset is parsed as either a commit or
tree-ish depending on mode. Previously, if no pathspec was provided,
the rev argument was parsed as a commit unconditionally.

Signed-off-by: Nika Layzell <nika@thelayzells.com>
---
 builtin/reset.c        | 2 +-
 t/t7105-reset-patch.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index fdd572168b..5cbfb21ec4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		oidcpy(&oid, the_hash_algo->empty_tree);
-	} else if (!pathspec.nr) {
+	} else if (!pathspec.nr && !patch_mode) {
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index bd10a96727..2a6ecf515b 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -38,6 +38,13 @@ test_expect_success PERL 'git reset -p HEAD^' '
 	test_i18ngrep "Apply" output
 '
 
+test_expect_success PERL 'git reset -p HEAD^^{tree}' '
+	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
+	verify_state dir/foo work parent &&
+	verify_saved_state bar &&
+	test_i18ngrep "Apply" output
+'
+
 # The idea in the rest is that bar sorts first, so we always say 'y'
 # first and if the path limiter fails it'll apply to bar instead of
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
-- 
gitgitgadget

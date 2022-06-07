Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF97C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387324AbiFHAaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456640AbiFGXUj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:20:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D113DD479
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 14:24:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k16so25807552wrg.7
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MzqzrFP//05CGN8j5tZtJ/8mwQyA3Akt6m31Gro7X50=;
        b=jB6fKazIe1aqoIJHLLJX1tFExcybQtQ16zSi4KBI9s93J6aK1eHOx0U/ni6NCsr2Ps
         m6BHRFU4s0dAl8k7BJiyxPg6wYW4us5fYiUV5+xmZaVL40KqCFX2u4JzmeINVCKU6GDq
         CKg+0+xbralwFaOTOZALbN8yZ0lAUZGwJ1QGtaXhqR7hh1nlKc4T3yL85SAc++ZWWJ9Q
         gxAO3HXLTLoOQDEE+ezYDIi3aOXUZKrJuwyo5fDoFWCfLmFyIuosmdV02ye+hiDeOU4w
         KZUVpGxfkCv6UYtqe/w4SHOLF8q5q9VmDeW9V+bvKxPiqpSpCeQPzXD6H+UdheZO0ga1
         OZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MzqzrFP//05CGN8j5tZtJ/8mwQyA3Akt6m31Gro7X50=;
        b=RfheygNfsRizuIGeJTZ0OMGi2ddArAfgaT6TneZOQZWOnK90mQAv5rscdHvQdT0ZT6
         +RU8zo/PbaPFiOicE2WRi58kCuF6JH9QAM160gFGyTgjz+wX8SVKCJzN5PUIxt2c3WGM
         6oyhoE28o+sg69oGKgux6gpt2IFbeUdjfXH9u9qNEgHbgujKmqz9GEDmbwK5QM5vmKX3
         lULkFotgbNmbpb4R6QCDOjO7QRcTasPoGLmJY1cRX19jsAIvxhUel9Z5yav8EmvvKIjS
         Z7YP3D7Z3sDw9jpcsJ74CGDv6Vagc2SJdRWdqmDrB+ig5wiqFD/b8hrE8LXAVWIGk/+F
         Qg0w==
X-Gm-Message-State: AOAM530aoKqKLPlIOis4MDGcUQdrexJsikv9vogo4b9O4uIbx8MKQgoO
        KclfX75skpBJ96IMsmRPpD1twjZuVGJGOOmE
X-Google-Smtp-Source: ABdhPJzL+dE3smVP4ZeScWKMlkFe8n0A4og/ETdqVJjgw8fAfMJ8Gin9U1HcjQz1emGbekiz1ha9Sw==
X-Received: by 2002:a5d:69d2:0:b0:217:5ad1:e61f with SMTP id s18-20020a5d69d2000000b002175ad1e61fmr15910707wrw.602.1654637046392;
        Tue, 07 Jun 2022 14:24:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b0039c45fc58c4sm11988841wma.21.2022.06.07.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 14:24:05 -0700 (PDT)
Message-Id: <pull.1274.git.git.1654637044966.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 21:24:04 +0000
Subject: [PATCH] config: document and test the 'worktree' scope
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Test that "git config --show-scope" shows the "worktree" scope, and add
it to the list of scopes in Documentation/git-config.txt.

"git config --help" does not need to be updated because it already
mentions "worktree".

Signed-off-by: Glen Choo <chooglen@google.com>
---
    config: document and test the 'worktree' scope
    
    While I was digging through the docs on config scopes for
    discovery.bare, I noticed that Documentation/git-config.txt doesn't
    mention the 'worktree' scope, but the usage string does.
    
    One might assume that since we have CONFIG_SCOPE_WORKTREE, the omission
    from Documentation/git-config.txt is obviously accidental. But, when we
    first added "--show-scope" in 145d59f (config: add '--show-scope' to
    print the scope of a config value, 2020-02-10), we noted that
    'submodule' would never be output from "--show-scope", even though
    CONFIG_SCOPE_SUBMODULE exists.
    
    This patch adds a test that shows "git config -l --show-scope" can
    indeed output 'worktree', and adds the 'worktree' scope to
    Documentation/git-config.txt.
    
    This does not conflict with gc/bare-repo-discovery.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1274%2Fchooglen%2Fdocument-worktree-scope-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1274/chooglen/document-worktree-scope-v1
Pull-Request: https://github.com/git/git/pull/1274

 Documentation/git-config.txt | 2 +-
 t/t1300-config.sh            | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index bdcfd94b642..9376e39aef2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -248,7 +248,7 @@ Valid `<type>`'s include:
 --show-scope::
 	Similar to `--show-origin` in that it augments the output of
 	all queried config options with the scope of that value
-	(local, global, system, command).
+	(worktree, local, global, system, command).
 
 --get-colorbool <name> [<stdout-is-tty>]::
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 7dd9b325d90..d3d9adbb3db 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2024,8 +2024,17 @@ test_expect_success '--show-scope with --list' '
 	local	user.override=local
 	local	include.path=../include/relative.include
 	local	user.relative=include
+	local	core.repositoryformatversion=1
+	local	extensions.worktreeconfig=true
+	worktree	user.worktree=true
 	command	user.cmdline=true
 	EOF
+	git worktree add wt1 &&
+	# We need these to test for worktree scope, but outside of this
+	# test, this is just noise
+	test_config core.repositoryformatversion 1 &&
+	test_config extensions.worktreeConfig true &&
+	git config --worktree user.worktree true &&
 	git -c user.cmdline=true config --list --show-scope >output &&
 	test_cmp expect output
 '

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget

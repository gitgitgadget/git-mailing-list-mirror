Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73337E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjJHGq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbjJHGqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC2D10B
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32487efc319so3359357f8f.1
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747543; x=1697352343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JfTEJu5b6B/t5bl6+NSO1MlnZ6SlW7AgCM23btgWpo=;
        b=OxVG3BKJHZX543P2yStf5F1tmku0HZbHMMs+DVz4V120fVtibOiKkl98CM0A7LNuh1
         fVKEDC8itm4N+OmJzxa291tmHiEV0qM4ptkdd5yV3o5YJVmAvNvhCgSSPB5UdMIEHumr
         PoGpwF+4JJJFepTVQYklN8Af22W8VKU2gbyBmkL4MSWgZxzXOtEsP21mb0ClzB+piM5l
         XcmyeNK4Blf9I5VXG6TTSQ9ACP01A7huvtD91+62fEP3yutJV/2DHrr/aEVHwB+45Wpl
         cL9j/BJ1f8uofniCXB+k/rNSvZ96CMZtPQ7xLxTHtVR/zGxtRMKqBiwkfZjfy9KiLSDP
         Tt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747543; x=1697352343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JfTEJu5b6B/t5bl6+NSO1MlnZ6SlW7AgCM23btgWpo=;
        b=Gwq2rrp22MC900bBIRYJNMQY/OScL2tNkIl/NumBUs70Z4Zwb84NoX4BP3N2HUcy8i
         iCq4PADLbbmyB+cLcbF2cSESSdhKDAh1pyUP9wHqGeR0nwjqgStW6wZlQSh4Egbid/cv
         0wmvugpGkor0DBYbtlAEl4b2zp5SgH2cELYqXXam2lm3pWIZowe0lZg6Ycc/qoS0fL7M
         YegCB32oDqYQRJK/kk+Bre77HMOzQRnpOdlBQUAK8SddCq5y6dBX7k8rKoa0LVZeIoR+
         6toUscXxbJjAWDqq9lorHMEktB1Insm2lbkdhOmf/R5UBWuZ8odwy/e/TAoCkrbnF/pI
         0ITQ==
X-Gm-Message-State: AOJu0Yw7aht3VmEVWcm9uMg83hC4kNEbbB09/vNDezwqiwDaADHLWS2J
        DAxlZUX46wQ7EHzz2q3yDKznWrvgCXY=
X-Google-Smtp-Source: AGHT+IGKsDol1g9gKpZCRdKdXBs/0B3edzFTCLFbTZNN2o08lXmgAV1wOY5yjUbXrzAKR9572CQf6A==
X-Received: by 2002:a5d:42d2:0:b0:314:1b36:f440 with SMTP id t18-20020a5d42d2000000b003141b36f440mr9423109wrr.70.1696747543645;
        Sat, 07 Oct 2023 23:45:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b00327de0173f6sm6007022wrm.115.2023.10.07.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:43 -0700 (PDT)
Message-ID: <7c8422b0ca1e4b1c27d59846e5807c0363ddcc67.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:22 +0000
Subject: [PATCH 20/25] documentation: fix capitalization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/checkout.txt        |  2 +-
 Documentation/config/user.txt            |  2 +-
 Documentation/git-diff-tree.txt          |  4 ++--
 Documentation/git-hook.txt               |  2 +-
 Documentation/git-mergetool--lib.txt     | 10 +++++-----
 Documentation/git-stripspace.txt         |  2 +-
 Documentation/git-update-server-info.txt |  2 +-
 Documentation/technical/reftable.txt     |  2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index a54faab238a..a3230229938 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -30,7 +30,7 @@ checkout.workers::
 	all commands that perform checkout. E.g. checkout, clone, reset,
 	sparse-checkout, etc.
 +
-Note: parallel checkout usually delivers better performance for repositories
+Note: Parallel checkout usually delivers better performance for repositories
 located on SSDs or over NFS. For repositories on spinning disks and/or machines
 with a small number of cores, the default sequential checkout often performs
 better. The size and compression level of a repository might also influence how
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 2bbc8e929f0..c1347fa7bcd 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -40,7 +40,7 @@ user.signingKey::
 	your private ssh key or the public key when ssh-agent is used.
 	Alternatively it can contain a public key prefixed with `key::`
 	directly (e.g.: "key::ssh-rsa XXXXXX identifier"). The private key
-	needs to be available via ssh-agent. If not set git will call
+	needs to be available via ssh-agent. If not set Git will call
 	gpg.ssh.defaultKeyCommand (e.g.: "ssh-add -L") and try to use the
 	first key available. For backward compatibility, a raw key which
 	begins with "ssh-", such as "ssh-rsa XXXXXX identifier", is treated
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index c2772a566a3..22380d5c829 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -34,10 +34,10 @@ include::diff-options.txt[]
 	matching one of the provided pathspecs.
 
 -r::
-        recurse into sub-trees
+	Recurse into sub-trees
 
 -t::
-	show tree entry itself as well as subtrees.  Implies -r.
+	Show tree entry itself as well as subtrees.  Implies -r.
 
 --root::
 	When `--root` is specified the initial commit will be shown as a big
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 25237330b5c..f6cc72d2ca9 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -32,7 +32,7 @@ OPTIONS
 -------
 
 --to-stdin::
-	For "run"; Specify a file which will be streamed into the
+	For "run"; specify a file which will be streamed into the
 	hook's stdin. The hook will receive the entire file from
 	beginning to EOF.
 
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 3e8f59ac0e4..0726b560d43 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -28,22 +28,22 @@ to define the operation mode for the functions listed below.
 FUNCTIONS
 ---------
 get_merge_tool::
-	returns a merge tool. the return code is 1 if we returned a guessed
+	Returns a merge tool. The return code is 1 if we returned a guessed
 	merge tool, else 0. '$GIT_MERGETOOL_GUI' may be set to 'true' to
 	search for the appropriate guitool.
 
 get_merge_tool_cmd::
-	returns the custom command for a merge tool.
+	Returns the custom command for a merge tool.
 
 get_merge_tool_path::
-	returns the custom path for a merge tool.
+	Returns the custom path for a merge tool.
 
 initialize_merge_tool::
-	bring merge tool specific functions into scope so they can be used or
+	Brings merge tool specific functions into scope so they can be used or
 	overridden.
 
 run_merge_tool::
-	launches a merge tool given the tool name and a true/false
+	Launches a merge tool given the tool name and a true/false
 	flag to indicate whether a merge base is present.
 	'$MERGED', '$LOCAL', '$REMOTE', and '$BASE' must be defined
 	for use by the merge tool.
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 6b92cc7de78..a293327581a 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -29,7 +29,7 @@ With no arguments, this will:
 In the case where the input consists entirely of whitespace characters, no
 output will be produced.
 
-*NOTE*: This is intended for cleaning metadata, prefer the `--whitespace=fix`
+*NOTE*: This is intended for cleaning metadata. Prefer the `--whitespace=fix`
 mode of linkgit:git-apply[1] for correcting whitespace of patches or files in
 the repository.
 
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index ff32986d4c5..6bc9b50d89f 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -23,7 +23,7 @@ OPTIONS
 -------
 -f::
 --force::
-	update the info files from scratch.
+	Update the info files from scratch.
 
 OUTPUT
 ------
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 6def498efd5..82d919b2615 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -175,7 +175,7 @@ log_index*
 footer
 ....
 
-in a log-only file the first log block immediately follows the file
+In a log-only file the first log block immediately follows the file
 header, without padding to block alignment.
 
 Block size
-- 
gitgitgadget


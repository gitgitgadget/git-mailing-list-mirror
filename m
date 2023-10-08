Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3E3E95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjJHGqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbjJHGqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:08 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F7F7
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3226cc3e324so3431799f8f.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747543; x=1697352343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld8rhH1oYb8Bu1+HmFd11/JDhyLVLQC3xEA9QwCOfHk=;
        b=fwTe8b9iqgsBxlx9RJIp4sVRKk2wklhN3M7IRKMUaYpQQpbrHO4G9T/nTaDh2qNV5L
         ugSWTczNVZGxvXruPpojLqhA5MrSLof9F0tSJALNQkEkuhQ7SUvE8GmpZ3UDY69blCRj
         Dq9kZNjJs/K+bzz5xMPvF8VKfVm32+MzuLLffKMLzhcvfK5iwaOA8SfQBY/uFPMolEO+
         rF2NiBrIkk471XCWGtQwWjxw7ROuw0BEhLRxuvU6/S4AK1nfu+qIhWs8xve4VUEfgIPn
         hyCwD9S7hpwzjd6hK9jpminDQ/aV2FRoqsYesqjp5+b5lNBapzyp2lFL9N2tTl8lwsfc
         khEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747543; x=1697352343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld8rhH1oYb8Bu1+HmFd11/JDhyLVLQC3xEA9QwCOfHk=;
        b=TKroR+BJqvHkYBYBcYDDUPDKeAu3jYaY89AwvTS7dCUqqPZ/LCU0cZBj/LhF9c+GeH
         qVtcsJuTAb0ChNCGxL7hqWf2Ny0zNnYUdRDRklyOdCl/0X0PEjpT7S/x75binXC8+Dkn
         mITNCeaFzEpg6d/CbFraSmLynNqNwnpHeZmL7P8GT8AQo+HOeOJcfoVoX3cMOYyGhk8D
         uNf9g1RtdZIy5tyZr12ZlEUkxr/rC1+mtG0vIfT/hEVDPhsHj0Ow/S2jHKMDLFo5t7S4
         lLMB8dmnfGymTmBFgLp57qZB2xgnqaNZ9xxzo68DIE+y+3oLQaX+3HPdSDpuD/48x7bi
         Nkcw==
X-Gm-Message-State: AOJu0YwwZgujmDVfbl72pjl9kZBuGDzvEI9od30rcsSXGrn7WWBCETXu
        ph4BNfL27b6VSWQW63dT3rhwAiG8vzk=
X-Google-Smtp-Source: AGHT+IHdwUoDNOJs/tNWM3EPTPAE92IYavpBA4Sf3diUuCd/6z2OdpJ0LVoiAIbkYa81R2+vgtkJwA==
X-Received: by 2002:a05:6000:707:b0:329:7073:179f with SMTP id bs7-20020a056000070700b003297073179fmr4115342wrb.70.1696747542924;
        Sat, 07 Oct 2023 23:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6851000000b0031779a6b451sm6010078wrw.83.2023.10.07.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:42 -0700 (PDT)
Message-ID: <aea6805028bc6b4f96e8bbc579d61ea359e389ed.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:21 +0000
Subject: [PATCH 19/25] documentation: fix punctuation
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
 Documentation/config/format.txt         | 2 +-
 Documentation/config/fsck.txt           | 2 +-
 Documentation/git-fsmonitor--daemon.txt | 2 +-
 Documentation/git-init.txt              | 2 +-
 Documentation/git-ls-files.txt          | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 8cf6f00d936..c98412b697e 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -68,7 +68,7 @@ format.encodeEmailHeaders::
 	Defaults to true.
 
 format.pretty::
-	The default pretty format for log/show/whatchanged command,
+	The default pretty format for log/show/whatchanged command.
 	See linkgit:git-log[1], linkgit:git-show[1],
 	linkgit:git-whatchanged[1].
 
diff --git a/Documentation/config/fsck.txt b/Documentation/config/fsck.txt
index 57114161063..2384c8c94d6 100644
--- a/Documentation/config/fsck.txt
+++ b/Documentation/config/fsck.txt
@@ -62,7 +62,7 @@ uniformly configure the same fsck settings in different circumstances
 all three of them must be set to the same values.
 +
 Older versions of Git (before 2.20) documented that the object names
-list should be sorted. This was never a requirement, the object names
+list should be sorted. This was never a requirement; the object names
 could appear in any order, but when reading the list we tracked whether
 the list was sorted for the purposes of an internal binary search
 implementation, which could save itself some work with an already sorted
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-fsmonitor--daemon.txt
index 324299bfe9b..65c7b4641e8 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -83,7 +83,7 @@ but not on network-mounted filesystems, NTFS, or FAT32.  Other filesystems
 may or may not have the needed support; the fsmonitor daemon is not guaranteed
 to work with these filesystems and such use is considered experimental.
 
-By default, the socket is created in the `.git` directory, however, if the
+By default, the socket is created in the `.git` directory.  However, if the
 `.git` directory is on a network-mounted filesystem, it will instead be
 created at `$HOME/.git-fsmonitor-*` unless `$HOME` itself is on a
 network-mounted filesystem in which case you must set the configuration
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 3c3c1e730c3..6f0d2973bf4 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -29,7 +29,7 @@ to use instead of `./.git` for the base of the repository.
 
 If the object storage directory is specified via the
 `$GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
-are created underneath - otherwise the default `$GIT_DIR/objects`
+are created underneath; otherwise, the default `$GIT_DIR/objects`
 directory is used.
 
 Running 'git init' in an existing repository is safe. It will not
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 60d1cca1496..f65a8cd91d4 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -62,7 +62,7 @@ OPTIONS
 	matching an exclude pattern.  When showing "other" files
 	(i.e. when used with '-o'), show only those matched by an
 	exclude pattern.  Standard ignore rules are not automatically
-	activated, therefore at least one of the `--exclude*` options
+	activated; therefore, at least one of the `--exclude*` options
 	is required.
 
 -s::
@@ -141,7 +141,7 @@ OPTIONS
 	Show status tags together with filenames.  Note that for
 	scripting purposes, linkgit:git-status[1] `--porcelain` and
 	linkgit:git-diff-files[1] `--name-status` are almost always
-	superior alternatives, and users should look at
+	superior alternatives; users should look at
 	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
 	`--name-status` for more user-friendly alternatives.
 +
-- 
gitgitgadget


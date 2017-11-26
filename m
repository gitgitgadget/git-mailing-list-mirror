Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12ECA20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdKZTmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:35 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37204 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdKZTmf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:35 -0500
Received: by mail-wr0-f195.google.com with SMTP id k61so24481551wrc.4
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZaCFqASh/XXuNy5aBtVmByeoWGouxfEqnxot3BFKowk=;
        b=PDaKgsYP8uVBT0v2aA6rIJPMfFSvDV3pdrjGDxeIpGTjua8FITg0YOLZgJmzNVq6ph
         i5eOwHHQakiga4rrAdz5bSMGCxYVjJtSwNyKXOaoF7i3jNrY7WNVuRh9KAsExk4pgLKH
         U4tqXbMxdfXMb98hD36fGMFGgwhhil2hhksZRqSrvViuygtJ0H4synOtxeyPWO3ETdYB
         GPIZvZk/VyQvQMSp0VG2/xGz3ogWCsRiaYczsKY+TlvfHdyEnjPEHC3n/EcsNCkuzepn
         wyrjZZkOBg0F/tzH41L2W3bZEbQPLF17Ny7X3QI+oKvRk+dChOq9jcmHe7MZfKPplEj7
         Pe1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZaCFqASh/XXuNy5aBtVmByeoWGouxfEqnxot3BFKowk=;
        b=hGZqNzVyzRIoXX+qTILG5VzetCdwZU1h9UFzQZAAkM6bR4n1jXgXdMeW/MK5TeIR7d
         7xXCNScSVT/XbYG8eWA4iAJ5w0n3p2rIeRDMflw/7viMTA1Vq/XV7cUrzaYgPesWZ7W0
         tRgW5fcojoJ0xGf6d910ykPhU0W2qQr5rtcnltLsCG/uuT7TK4vCWrtM89gNABKxnn8u
         lH1NkIP0UqfAhI/GK/9oguvZ6M04LeOmMpqQ7DTzw3kp7fc38JGaWSni1YPn3xc/vx7y
         YPYbAOwAWmCaFWX7rdZAGcJCVdUxAsfcnxZR3L0j/RjNVxXGStFUGVeNgeXU0gHegVRt
         skgQ==
X-Gm-Message-State: AJaThX67oMYxinp5ohsMzRhX/iv0wQG/r2L3XRSJU1twUHjw0fGcdmv4
        FdrDwFDBqeW3KEPMkefiusFS7HjB
X-Google-Smtp-Source: AGs4zMY6Om8NOyKVzjKVai3wCsoKnAFWjqn4SD90F44f7b1RHTijdOVB7PdjFe8cgX3mRy7ki53q2g==
X-Received: by 10.223.156.133 with SMTP id d5mr13863641wre.43.1511725353557;
        Sun, 26 Nov 2017 11:42:33 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o22sm55099004wrb.40.2017.11.26.11.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:32 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 2/6] worktree: add can be created from any commit-ish
Date:   Sun, 26 Nov 2017 19:43:52 +0000
Message-Id: <20171126194356.16187-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add' is documented to take an optional <branch>
argument, which is checked out in the new worktree.  However it is more
generally possible to use a commit-ish as the optional argument, and
check that out into the new worktree.

Document that this is a possibility, as new users of git worktree add
might find it helpful.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index b472acc356..121895209d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -45,14 +45,14 @@ specifying `--reason` to explain why the working tree is locked.
 
 COMMANDS
 --------
-add <path> [<branch>]::
+add <path> [<commit-ish>]::
 
-Create `<path>` and checkout `<branch>` into it. The new working directory
+Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
-specified as `<branch>`; it is synonymous with `@{-1}`.
+specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
+If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
 
@@ -84,25 +84,25 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<branch>`
+	By default, `add` refuses to create a new working tree when `<commit-ish>` is a branch name and
 	is already checked out by another working tree. This option overrides
 	that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<branch>`, and check out `<new-branch>` into the new working tree.
-	If `<branch>` is omitted, it defaults to HEAD.
+	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
+	If `<commit-ish>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
-	`<branch>`.
+	`<commit-ish>`.
 
 --detach::
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
-	By default, `add` checks out `<branch>`, however, `--no-checkout` can
+	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
-- 
2.15.0.426.gb06021eeb


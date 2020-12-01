Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C2DC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8D206C0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcLu8ol4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbgLAJr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgLAJrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 04:47:25 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D06C0613D3
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 01:46:45 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t4so1597483wrr.12
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ZBqxgjA8OSm4aQxJwV1Od4oICDSiGQvt16HpF6hufI=;
        b=WcLu8ol4XC/T13KKVCsNvu21M/mBiOkRdC/14RbmLg0nlEMEvpRZteUwl7fz1fGha7
         UzZkruyTNZyFvjoBFPiizP56Z4mJvMh+ecg/opiHMqkWY+k//vDQB9gMNCyN3Kw142wP
         2pe3xqnM/MgG+MxxIzLy3Oo82tZHDysLcf/+rXNWmPEvHT2ZNklLB0PKhRjn3PWpj338
         EPp/MrHEQAMgQq2JWJUo3Wsk/Cf5jyiQu9P0mmMDpCQPf3fU2IB8oJWBntI2yl1saaDR
         4ueKkudE5ZGq3dJZrH/RM9mcm9yxF9zMONFYQ2RrcCBuBjwG9BYPPLo7Sxp4yDSaLYSd
         T/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZBqxgjA8OSm4aQxJwV1Od4oICDSiGQvt16HpF6hufI=;
        b=dqL7lnuWv+sEz/ayjVE8ZZp+03oZRB0zIWqsw1QOBb8iofT59m4sBekQ+aYVG/Ewv4
         gce7uKixNSUK/tbzKWCL+ZFsgtXufWd2QOwI6LWo9L99pVdgKGe/QU1wajkF5+bNNWFg
         ut9fN2Qdv1FFgBHAgb2oW+62XaTzL4cd6jmONZfCtUzkYxzXdq7zvGS9ezbp83Pjd9zD
         Tx/YKAkpjgFQC+YJLQX90MnNWBR2i+rVxrBIhe7dl1Xyv2bg7RkVCsgn4TB2zoi5wTCh
         KM53nDP/FiOjH+gbDpUe92mC522XZ3SZ99N7jPAEHZflTV5X4OoreDR3M0gQ81Lmx44z
         fJNg==
X-Gm-Message-State: AOAM532WIAkP6mUs+1L1gIKLAfju6g4O8uBcb0qkabA8JfgY9vsm9FPm
        SBfu/ypEqtZzA0ot+QhQCLMDbeOx6zI=
X-Google-Smtp-Source: ABdhPJwsusqLL2MwFsmBLel7YhPccAKrX3EhJgok+f2iSlhi/RBgRnUkjWxHvPjfdmUoXyKYa3HLfg==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr2744526wrm.4.1606816003720;
        Tue, 01 Dec 2020 01:46:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w186sm1996596wmb.26.2020.12.01.01.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:46:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] cook: add github.com/git-vcs/git as a URL
Date:   Tue,  1 Dec 2020 10:46:23 +0100
Message-Id: <20201201094623.4290-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I maintain this mirror, but hopefully we can make it semi-official. It
has the same refs as the GitHub one except for the GitHub "pull" refs:

    $ diff -u \
        <(git ls-remote https://gitlab.com/git-vcs/git.git/) \
        <(git ls-remote https://github.com/git/git/|grep -v refs/pull)
    $

Although I had to delete the stale "pu" manually just now.

As an aside there are also https://gitlab.com/gitlab-org/git and
https://gitlab.com/git-vcs/git which mostly mirror but also carry some
GitLab Employee topic branches.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 MaintNotes | 1 +
 cook       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/MaintNotes b/MaintNotes
index 0dc03080de..bb3064e9ac 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -136,6 +136,7 @@ My public git.git repositories are (mirrored) at:
   https://kernel.googlesource.com/pub/scm/git/git
   git://repo.or.cz/alt-git.git/
   https://github.com/git/git/
+  https://gitlab.com/git-vcs/git/
 
 This one shows not just the main integration branches, but also
 individual topics broken out:
diff --git a/cook b/cook
index 03ac0cfbe4..2258390114 100755
--- a/cook
+++ b/cook
@@ -295,8 +295,8 @@ the integration branches, but I am still holding onto them.
 
 
 Copies of the source code to Git live in many repositories, and the
-following is a list of the ones I push into.  Some repositories have
-only a subset of branches.
+following is a list of the ones I push into or their mirrors.  Some
+repositories have only a subset of branches.
 
 With maint, master, next, seen, todo:
 
@@ -304,6 +304,7 @@ With maint, master, next, seen, todo:
 	git://repo.or.cz/alt-git.git/
 	https://kernel.googlesource.com/pub/scm/git/git/
 	https://github.com/git/git/
+	https://gitlab.com/git-vcs/git/
 
 With all the integration branches and topics broken out:
 
-- 
2.29.2.222.g5d2a92d10f8


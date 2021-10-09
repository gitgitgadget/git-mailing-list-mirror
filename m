Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED6AC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C6160F92
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhJIIdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 04:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJIIdl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 04:33:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910EC061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 01:31:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t2so11781699qtx.8
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1fwmODZjfKOcdZFIiODT3vr++LLF2wIEXxe6Qed+LM=;
        b=P9cf9nQTN5lTqe3uERSKJM83fCx0SfZE35BjqbYdTuR3rT30siKQOFvFho4xJ6mEuv
         019xd8XB41NHaOJ08nNhtxQeUa81cfB1Tb0XT8i8uYgaqBPRrhyr/F6zXgMVJ3C2RJBJ
         Qpi8LfDHML8mcEL5FSohRLoM0Y9grYwucbCBxuDgW0OA7/UB8yazi628fk+vKbVOejfy
         nS8SmvprkkO08sbM4Ivpb2ot+fTNEXtbCGnVNpNbNRlUc7DeiSDKQk6+XmkqHZkoyyOZ
         3q4vxHd53h4SDBtXpYrxha7SRepJfK7wtiXYxL1Yir8+SaRkETt/JMy75HUIJNGdsqVA
         hR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1fwmODZjfKOcdZFIiODT3vr++LLF2wIEXxe6Qed+LM=;
        b=SrQEPe4tcdA3uD80Rg1+xuZcUY19tBjsQrv3W76oeaaOz4AZ1HOCZ/gHiUNq7gHZyF
         OzfidqkW0eO/Aq7wmkCxZxnK8s3zJ7bcVi7ykqME9X1/Q9qNSe13ztu2O+f3iWgLIESf
         gOzpBFdLSR2agKvN2tX55t2Dws02En0kQMTbmxbVEd0UGEJxdTRSaRIY0cJzdYYCuq5K
         5TenxFuoMkEhiRvlnxDOZkAOr2rlMOLHkWSawYcFlBNfWZsPKYV0Z3dvxdkJS5jiB7ac
         UM02RxtviBT2CnP99KGYtJcpULFZ35UXQO4Tag64hUWewmf/cAGr1Pi5LZLGEw8+uQx1
         MNbg==
X-Gm-Message-State: AOAM530FTkslEDsVc4O3ktqrBRtX8CTHvYNhiJnYwwciUsAzASLtiAUV
        cb2sZmSSPZQu5SzPmfD3+0CKImKOdY3iyA==
X-Google-Smtp-Source: ABdhPJwdDTTjzRCcL/3rk2jI81SGy/ZfSi7rd24mYyjTYKgD0GHI/uKDuw4Gf5cuIGKTjdjCv9tWsA==
X-Received: by 2002:ac8:7145:: with SMTP id h5mr2795889qtp.240.1633768303924;
        Sat, 09 Oct 2021 01:31:43 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id g4sm1138596qtp.43.2021.10.09.01.31.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Oct 2021 01:31:43 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     tbperrotta@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] Documentation: better document format-patch options in send-email
Date:   Sat,  9 Oct 2021 01:31:33 -0700
Message-Id: <20211009083133.4446-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1081.g099423f5b7
In-Reply-To: <20211007033652.80793-4-tbperrotta@gmail.com>
References: <20211007033652.80793-4-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thiago Perrotta <tbperrotta@gmail.com>

The use of <rev-list options> in format-patch is confusing because
it is meant to represent instead a subset of options from format-patch
and a revision range.

Change the documentation from both git send-email and format-patch to
better describe the list of options that are expected.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
This is an alternative to patch 3 which include most of the suggestions
by Junio and Bagas, while also trying to minimize the change or the need
to link to even more pages (which is why the suggestion[1] to link/use
rev-list options was avoided).

I expect it to be consistent and clear, but might had gotten some of the
terminology wrong, and probably could have better grammar, so hoping for
some feedback to improve on that.

[1] https://lore.kernel.org/git/CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com/T/#m396f2a42936ec9a3191658d4b40d9043dfbc59e2

 Documentation/git-format-patch.txt | 20 +++++++++++---------
 Documentation/git-send-email.txt   |  7 ++++---
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fe2f69d36e..fa2377d5e9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -64,15 +64,17 @@ There are two ways to specify which commits to operate on.
    to the tip of the current branch that are not in the history
    that leads to the <since> to be output.
 
-2. Generic <revision range> expression (see "SPECIFYING
-   REVISIONS" section in linkgit:gitrevisions[7]) means the
-   commits in the specified range.
-
-The first rule takes precedence in the case of a single <commit>.  To
-apply the second rule, i.e., format everything since the beginning of
-history up until <commit>, use the `--root` option: `git format-patch
---root <commit>`.  If you want to format only <commit> itself, you
-can do this with `git format-patch -1 <commit>`.
+2. A Generic <revision range> expression that describes with
+   options and revisions a range of commits.
+
+If you give a single <commit> and nothing else, it is taken as the
+<since> of the first form.  If you want to format everything since the
+beginning of history up until <commit>, use the `--root` option:
+`git format-patch --root <commit>`.  If you want to format only the
+<commit> itself, use instead `git format-patch -1 <commit>`.
+
+If you want to affect a set of commits, provide a range (see
+"SPECIFYING RANGES" section in linkgit:gitrevisions[7]).
 
 By default, each output file is numbered sequentially from 1, and uses the
 first line of the commit message (massaged for pathname safety) as
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..16d8d19cf5 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<send-email options>] <file|directory>...
+'git send-email' [<send-email options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -18,8 +19,8 @@ DESCRIPTION
 Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
-last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+last case, a revision in a format accepted by linkgit:git-format-patch[1]
+as well as relevant options must be provided to git send-email.
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
2.33.0.1081.g099423f5b7


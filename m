Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C05C2D0D2
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF40F206E0
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvjBKW0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfLPPsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50562 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfLPPsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so7269390wmb.0
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=hvjBKW0v9Qq0NRHw0+761E9gKvGH/0Z+idTxKwIAC2Vun17PdZl5VZKHKZF5ruG8R2
         eo2ozVF5ieC4wQ8X2MQ2dsZDvQyGjE54pwxaJAvbYPylPnQndPTg36ausme2cbqrXnhc
         upMmIWQujlcNjPt508g55+2sITmDShFGSYcejiBF2XOTUxg+sa5VWYOQVT973u84Cvgu
         WFQgtr/CsyXDYEvgmEgpvav86+bwk5PGaNcvuAVjsTLzspx/urhVLbfAtz6VFJBT6eXZ
         l6Yg+DVsQmQ7IEuOSOWOTKOri/25BNL+bC/pB1KHghal82ejY2tqn3qUHCYQvf4EeRB9
         2LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=laJcgAnzodDwrij/aez0KRKVRcPTfwN/pWIhSh92tXLkNoVNIWLXmxkN+P0FaQWS2k
         GuopY6BhXzlyWISByX3lSrnQO1KJ3b/Ix9qXFf9tnkIxhAmC04XEHiEc5w/D6F8lgWhW
         1aXkh+epheEImIPzcn+qsg+6n93leXV4n2mexq91hZMZXiwR4MzAz6xHbU0xcYnBdlby
         ZDkv6Gz/hqTDBUD4U1gbkLA/Ol/ToeyU1vJ04cqmOsfLDBiL/YHLxUAXgc+LmuuFjauA
         LaX7x97O3su8zWruFmMgy8nfYKkq5wx0FOObgz/XSpMo71XCPkM8ka6LOyw7CCBZxEea
         UqDg==
X-Gm-Message-State: APjAAAXk+57ANtB2VyKK3CbdlO/u9Bj5jSqkC+JpZXP1kZjuEBC/DuL9
        SCXAsR0nnz1jh7lpZljM6Otx42+r
X-Google-Smtp-Source: APXvYqxLFsFanFfd4yfW/frtx8PA6ZhNUWhXp+jgfYDuEcnvyPJJAHi4x1qlmiGpBmYE/LMxUtNwWA==
X-Received: by 2002:a7b:cb02:: with SMTP id u2mr29998344wmj.142.1576511292905;
        Mon, 16 Dec 2019 07:48:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm22000564wrr.11.2019.12.16.07.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:12 -0800 (PST)
Message-Id: <3d0fcf6ba5afce860c6ecec4ca7d3a21ba49a3a6.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:55 +0000
Subject: [PATCH v2 07/18] doc: checkout: remove duplicate synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

It was added in [1]. I understand that the duplicate change was not
intentional and comes from an oversight.

Also, in explanation, there was only one section for two synopsis
entries.

Fix both problems by removing duplicate synopsis.

<paths> vs <pathspec> is resolved in next patch.

[1] Commit b59698ae ("checkout doc: clarify command line args for "checkout paths" mode" 2017-10-11)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index cf3cac0a2b..2011fdbb1d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,6 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [<tree-ish>] [--] <pathspec>...
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
@@ -79,7 +78,7 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...::
 
 	Overwrite paths in the working tree by replacing with the
 	contents in the index or in the `<tree-ish>` (most often a
-- 
gitgitgadget


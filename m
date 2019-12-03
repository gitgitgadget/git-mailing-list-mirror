Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F753C43141
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B642073C
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX8hwtg2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLCOCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCOCa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so3804291wrt.6
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=hX8hwtg2d7G83sb8P/UPpzKDvia7+GdaWZnnUrF/JScofvrV2mjVTKism4W3Jlo6yd
         NrV2QJUi8Sd3qytIyrCsJxOwID08lGM+e9cSc0TIon3C7nCKzqjx2tPT6nwHToYWPTwh
         BsnfcoaTFoaaLMTroo6BVDmlXhIYreKzzSfJfgmr4azQBRMtaL+Ki6MY6OU0Eva0mmYw
         a6GVL0zbwjyKqEndett4XYvt6vs7jDww2NSHyyL52PE4Yb/KDTtmIQKQ23iwg1/wEBMw
         GWooGMjzw+aZwR/rV99Cbcrby2ZyNTBaAKG7y8Fteg6IZYfs63xuwVxSxruHJCEah5Jm
         I1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=Mwife4hWfu/KLcAVil+UyvzJwt2UiqZtLFGTohpSVj0XdFO1s0Kq+hwG01KoSdVyLQ
         9IO6KGSLao2KYvILsnL53x7TRVZ8fiTRRjK0xp16ukjdCD3N5DL6NOikk0EVIiG9sUBY
         +jECKXv0N6kDrFYjvF30kixFcsog98Sx2I/OMhjnhI69vtCnzie0adapRHreMZV8aG+0
         g9v3fkFpPFbd6i7YCJv/9SIPumOo9zo8Tdq1VpdR4TCM08pvzqy6uB0RlQtrhfBKjWb8
         FKvyEXllxXbPfF6JwY8P652r8cTifkKCCVcWSR/7enAvkopqlFe/NUmUeawofXScRhwf
         JPrg==
X-Gm-Message-State: APjAAAVQ5Pbfrk1bQM8UOLaY01Lc1nNmWRfa0zdkpNho8T5PI9qnKjPi
        D6IoVQy5hmyooEQqnww56aKlk+VG
X-Google-Smtp-Source: APXvYqxER1GRDEi/zKYnqpHAZo9D1DXdg4IZQGBOtk2kYn21Gqh2pGWUp2mt/wdS1S0s+m5gjB721A==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr5539554wrw.25.1575381747808;
        Tue, 03 Dec 2019 06:02:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm3216545wmt.38.2019.12.03.06.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:27 -0800 (PST)
Message-Id: <5e449c8d29cbade125bacac6c04778ea85e3b0bd.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:14 +0000
Subject: [PATCH v4 09/13] doc: checkout: remove duplicate synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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


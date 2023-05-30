Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE1C77B7A
	for <git@archiver.kernel.org>; Tue, 30 May 2023 10:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjE3Knu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjE3Kn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 06:43:26 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE8518D
        for <git@vger.kernel.org>; Tue, 30 May 2023 03:43:15 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 05BB5320090B;
        Tue, 30 May 2023 06:43:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 06:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685443394; x=
        1685529794; bh=flxRXHiWmvYZ5SmJ1/zzuIPbi6d51FDLOhvoUpIBFNQ=; b=J
        NJ3xWyATonJ8I29DgmtTe72p4wg1SD+iLthoYG4PoLxMmpCFFycPZnt72fmY7zYu
        WysEGQVxVzyYsZhmHdfL397Mq9zeN/HCRoaBKB8ZEPG3vXzqIH3IH+/3IU517uVA
        BzRlkgfS/IInCHUBCNqOcUMrkcVqW3KxhXEpdSQQEVRDABijK51neXS7FGtr2Uma
        nPJ9we2BpWfHfZqdn0NjWoA82YYv02N9HtKLdL94ZpaMAf+N3zdGp6yfpu8C2wWP
        nUthBEZwJMrORXolcDNctw6vpkZvD5GS/Zudeh3xg9lsstZm768AKSz9qBEagRA0
        Xl92ZOyY7A4ftZQlGBwvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685443394; x=
        1685529794; bh=flxRXHiWmvYZ5SmJ1/zzuIPbi6d51FDLOhvoUpIBFNQ=; b=o
        w9Au6OX1Npl4Ylol5/x/XOLv1VlvGU+yCz/TIxyMIG2uHfuJWiUOfphC0Bmx9xoS
        Y9VY+o1dydmssUsgzCy2vIuA8yyLPu76K+uvOs3wSLKPiGMXf58T4L9/a+q70OtX
        /g18UDeN7dZ74HfS40x27dCvhp3HJ8G63lcY0ZytJscwzfjtq3Zv8/tJNjwi8cIT
        nUQJ+FOp83jhGWC3FM5i57Umr0WjhvGqX32x6ZheExXzlq2fSf+ZVmOkRap8FlAp
        16VMTb/pFrK8TNwD9ftmHJacbjVSFhi40EY8T78t60rbz61Gvjt6rd/L/gM+mKCr
        4BNGW2z9GcLb6d0SwBmyA==
X-ME-Sender: <xms:QtN1ZOC9rleIYKg1lY9EV-cFlzIpzXlCGxuvXCghtQGoT2gwRygOkwo>
    <xme:QtN1ZIg0dOZtms6-SPXmlvhrYwZnceutY3JlmMcT5tN9UM9iMIqHs8sEuEZLjOOb_
    ACHM_aY5fks21wFuA>
X-ME-Received: <xmr:QtN1ZBnmbNtKxh3xST3D2-HaZBV27-6k83nBEXe1TOqsFH7uT-8qson45tKqOhKAjGhRCxsiGitdrhodprqV8rjs4F1jL5OFydAnYvHaLwuP6Ap6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkuceotghouggvsehkhhgruhhgshgsrghkkhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeetudeiheeguddtgfduveekhfevudeiieetjefh
    ffetiedtgeejieehtdfhjefgteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:QtN1ZMzaB1YeSyREk6OhkHntPfB1s4MrFGU-jdlujIVGmQVTc2Zc9g>
    <xmx:QtN1ZDQ1P4iJgMchC3FVwZnP9SB7tLjxM1kpN9VObLy2vLjtspOdUw>
    <xmx:QtN1ZHb7jHHObkqKzSjBtV_zckFfMoPpqY0agEmshHN0u4GPnZGUOQ>
    <xmx:QtN1ZNcZEbs5LOQ5KaCWhdgJC7hiID6-_sD8SYJmyFn8iYV_mIkzTg>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:43:13 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [RFC PATCH 3/3] revision: comment `--no-standard-notes` as deprecated
Date:   Tue, 30 May 2023 12:41:31 +0200
Message-ID: <29ce1182134cd031b3e05a5e2774639d3d9a7cdf.1685441207.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.41.0.rc2
In-Reply-To: <cover.1685441207.git.code@khaugsbakk.name>
References: <cover.1685441207.git.code@khaugsbakk.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We still use `--standard-notes` but this option has no use and is no
longer documented anywhere.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 revision.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.c b/revision.c
index a0ab7fb784..24219c741a 100644
--- a/revision.c
+++ b/revision.c
@@ -2529,6 +2529,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		enable_default_display_notes(&revs->notes_opt,
 					     &revs->show_notes);
 		revs->notes_opt.use_default_notes = -1;
+		/* Deprecated */
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
-- 
2.41.0.rc2


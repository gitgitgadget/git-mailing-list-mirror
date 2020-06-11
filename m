Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2A0C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 577D82075E
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loeM6f9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgFKPvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgFKPvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:51:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A47C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:51:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p5so6665544wrw.9
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1fj6WCwspkkE0ti7a9JhjfMj2gPWF3M73H3Ud1iHgbw=;
        b=loeM6f9Ue5eNtRFP5jy1b4YVPqLo3T2vjo2RwVQ3iuYZJHQT+xbRN4QgNOkeArn9Y4
         Pcng4c5/GkZLzsTePec4Hv9Y73tLzRxvNAIczM4y319wxWec1oqxPt4cLB2bu8j0/6t/
         5l4o5hAT+2tQi7Gh1LS961g6WAQP0Kt1gPxjv+MxSatQZw3veLviisJdZp/qoq7hRYVu
         KFCNKEA29TUpTjNRcLfVbcRrGVzPFdlebPEqE8kdD0wMRu3WcxBRquq7lS8Tk8XCLoqB
         Ss/JF8hAgPaXoW4wGKmOXidNrhB9k+oDf0xLl8GSd6kJVUeGiL6K5Tde7nbMwEK5wUD/
         Soew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1fj6WCwspkkE0ti7a9JhjfMj2gPWF3M73H3Ud1iHgbw=;
        b=EW7o925htGONFHjbl3nRg+Oly1nBhHk535gVOAU5SK7KMkJHcfTtOmunU5yZpEtZmr
         el4rQnqV3Bg0x14RFeIEcCFHrBtBWHQXNB+ZFpZ8gSUImeRmKBvWfbuHchp7nCoASMMD
         JLT0IGu0q1ZFz4n8KRTF1C35Ejcg857cnVSiDpc4k/jAZmDZy8K/4u05ksVaxEBu31G3
         /xvqVzexeZezgaGemOYfIGV+tRZ8HZzSwRshcMsmUdLS3TeMeNnKl3nijGzpAtgUrwO+
         YhYdXOc3nyzbBYu7lMu1kFJDJY5k8FgktkhXa0Go7z0OIPW0/BpsjKnRqbtrytE+3Ykv
         Bhng==
X-Gm-Message-State: AOAM531LlAoMF1Wh2V2Jz5a9ioj9ZQeHkeAiG/FzRX3KPx4oP5lwaB+i
        gRlMpryHIwOJDZmLQ1rKLuG7gOxVNpxQEAgueJhXwvFfYxs=
X-Google-Smtp-Source: ABdhPJxJg2VGj27aVza1pvqryLjjPMqM7pMfGAsVaPicZulo3F6yONrxcHWI4J6cGJEwsD4Zp4jsgvi1Iowga4vS6Kk=
X-Received: by 2002:adf:f30d:: with SMTP id i13mr9667743wro.146.1591890676147;
 Thu, 11 Jun 2020 08:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
 <pull.804.v3.git.git.1591888511.gitgitgadget@gmail.com> <60aed3f9d6543a5f66ff75a50c86cf626ec04ed4.1591888511.git.gitgitgadget@gmail.com>
In-Reply-To: <60aed3f9d6543a5f66ff75a50c86cf626ec04ed4.1591888511.git.gitgitgadget@gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 11 Jun 2020 08:51:05 -0700
Message-ID: <CAPx1GvcvDCoOHrSOgybDpKawMTPSHs2FUq6-sWVOmwAS_GRKzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] git diff: improve range handling
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 11, 2020 at 8:15 AM Chris Torek via GitGitGadget
<gitgitgadget@gmail.com> wrote:
 > +                       if (lpos > 0)

Ugh, this and the rpos test are supposed to be >= not >.  Will fix these for v4.
Otherwise seems review-able.

Also, I forgot to update the GitGitGadget "changes since",
It's changes since v2, not since v1, of course.

Chris

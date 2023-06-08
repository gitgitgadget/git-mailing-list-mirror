Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53837C7EE2E
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 05:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjFHFLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 01:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFHFLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 01:11:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49426B3
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 22:11:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b2439e9004so396515ad.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 22:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google; t=1686201096; x=1688793096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m7A0Tw7Mp60yFLwacUgpa6O4Q5MedyhYtrLW2r8TddA=;
        b=c+RT25MPuc+YtsPq+4kf5aAjHleQw4XYHlcuVNfYWitdH1Wd9uoH54gGVS6wyaGbHf
         F8W0xdhaS7a5TGh1u5C8/YSNr6R6qW214XPt3OXR54KtHM9eFU0JR1rjQzBL8d/SMq6m
         lvuAtsIaVnsP2VKUZAnF2BSHyFOoc9iTVNIWlaC59HisjK26YYxpDYf9oaTGVyyz4Fvs
         wEy8ym9VfuZ0AZaH4tylcwqQv6WA9UaboLNWocJhdob9cd1jxc8E31l5V61TsOgE03Qu
         En9GoKfdJreJVJ7W2PHp9VkjILi/7egyeqfYPxRDv/POYvtXZK9cTTFmhfKqxa2opJVD
         Lpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686201096; x=1688793096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7A0Tw7Mp60yFLwacUgpa6O4Q5MedyhYtrLW2r8TddA=;
        b=cQS4sZJbhaJe0fRB3ecrlZDUzlDDdJLueinXq9zVcD12zXvpn0oXi7+p/NFn4DYy9r
         syH6h0CPY/P3LOQmhw9ZQK7KJetZgsz2CV9d/GuyWxW8ylvQr9gK4KmLoa6IozHJ5ZS9
         iY0MSWVdB60HaNMuxdnLU0GpQf5yISvlLPkcyLBeXlguQsoHmG/51uN4uuVjNKC0NkdM
         wEbL+0+5Vmr2TppIzGR5V2GUKSjXi2wR0xPeuRFULjofty0ZWjiOssmgCVeCe1jx2fAm
         q3k+4JCJYosy77tVT2IaJdV0kUBKXFXxR1+AZbvLhLqqooUEAsB9/tEZeg7nwqiXMVSb
         iKUA==
X-Gm-Message-State: AC+VfDzcb29ahxLck7V9F0GkHTKGslU84XRDqXXtQORpKU6ESDkCojbp
        c9covm/UQpowvfqJYNgkwbnMzYjbH020E/AcNddqviOz0bXPGxHhX/U=
X-Google-Smtp-Source: ACHHUZ7XuxEeaWsAk7+eI+fJMp9YFmJfF3SoJO8hNVxEomrM8yi54xvDpWlXmDEneKys9XmmMmm1PGcODPV9FFUL7Ks=
X-Received: by 2002:a17:902:da8c:b0:1b0:5ca0:41a8 with SMTP id
 j12-20020a170902da8c00b001b05ca041a8mr4144570plx.39.1686201095895; Wed, 07
 Jun 2023 22:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
 <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com> <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
 <cc93b0ed-1167-a017-2138-181a490d26e2@gmail.com> <CABPp-BEAnB-6ogcohMWMmktr9SrwMtM0-dw1pypcJedcMMcsCg@mail.gmail.com>
In-Reply-To: <CABPp-BEAnB-6ogcohMWMmktr9SrwMtM0-dw1pypcJedcMMcsCg@mail.gmail.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Thu, 8 Jun 2023 06:11:25 +0100
Message-ID: <CACoUkn5OsWNMzUe=O_ObjJoDk=ULnRij90idYutgn42Z3-cWgw@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     Elijah Newren <newren@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Anyway, if you want a low-level do-a-merge thing, use `git merge-tree`.

Elijah - please accept my apologies for my belated reply.

Thank you very much for this detail. I will give the custom merge
strategy approach another whirl!

Best,


Paul

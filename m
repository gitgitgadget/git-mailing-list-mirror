Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966AC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 04:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CCD61360
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 04:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFWEU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWEU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 00:20:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701AAC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 21:18:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w1so1847676oie.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Xmaq7G52YXbgzp+pycK/6HQFu94QTiratX2p07MXUik=;
        b=lXndlNq8m888bCLBLkY7sAwahwmjG6RQQhVfEoBRRwXf2wThP27ehzhCutDjJ+Q01D
         IsJX8fHSkHRWFK1Wmp6DmWjgZZJUx1FZ+Waw+47F/9rmakyDY4At0giab4cA99RzMCha
         Wh4bMCyFA+mAWf9LRwqDaTwoZYYEO7sq68xooByLvgT9ZqN7DNYrzK4ViYpKbBlu+7ge
         unsnlEyYDxIoOoKZwHRoUlv3KJM11M7bP/oUa9py1XZ9CyooeVrpoj90Jh5uAun6JDFQ
         VhfkFTXetganBjV1+orqfBsVaHRi5YluJIVzbHzqBGmBXiDp0U09AeAQBmvJ6HxAMwCe
         SGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Xmaq7G52YXbgzp+pycK/6HQFu94QTiratX2p07MXUik=;
        b=KWao3lbesjKzVDQ7WcV9UqCMYaWDo9lBIW7+GkWUq2uXdm74odGS5j7PJNnMHdO+ad
         eEjooeelTuGEjfp3Ku7W9D1xEWc4KWH8ltkkFryuKZ5uevtnO1dkAAhpApRiC37PzzKf
         aHDRhY5CSKqrEbKjVgo1a0jsY1FidISdOjN/RQo50Ry+72Mw4zMu1qOXDK691WwNS3QJ
         pEEO0Zg359pkXyKOAqifPj5uN+klQ9qCXTHeaYNPL/VvG65Yfnv0A/qWdsTPVdTrmGD2
         QPiPR+N8Zh8wcYrMZJ8XwKZ3kfiy55W8j3w1z8aF1sqDeF7hD/fMtIjSXERK/+W5NXzW
         D+XQ==
X-Gm-Message-State: AOAM532YaNdNQZZK5fmCaWojgcja/CBhx8nJudG3z5GsZfk73OdnGC/W
        YxUsLDXTp3hxKnvcx7rX3O4=
X-Google-Smtp-Source: ABdhPJyIF8yDhmreRfd0lz5nxvOprTIH4Yw/ca7wUmSAlMyyENNrnOhfamA2G9UKgBTb61+l/ZYY2A==
X-Received: by 2002:aca:4288:: with SMTP id p130mr1740528oia.80.1624421889896;
        Tue, 22 Jun 2021 21:18:09 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y13sm343877ots.47.2021.06.22.21.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:18:09 -0700 (PDT)
Date:   Tue, 22 Jun 2021 23:18:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <60d2b5ffc23af_1b53208aa@natae.notmuch>
In-Reply-To: <CABPp-BEnPrg_tsqLtmj7Ag6JnR6ku_K3Uv65rdRu-j9_qMYhmA@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch>
 <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com>
 <CAMMLpeTmYcJHf1t7VpOBakMZ_vtk+9bmLRTMA9ueghG6WwCRtA@mail.gmail.com>
 <CABPp-BEnPrg_tsqLtmj7Ag6JnR6ku_K3Uv65rdRu-j9_qMYhmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jun 22, 2021 at 2:22 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> >
> > On Tue, Jun 22, 2021 at 9:06 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Mon, Jun 21, 2021 at 8:15 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
> > > >
> > > > My only serious objection to this patch is the instruction to merge if
> > > > you don't know what to do instead of asking the repository maintainer
> > > > what to do or reading the Git documentation. I don't have a strong
> > > > opinion on the rest of the patch.
> > >
> > > You're not alone, Alex; I objected to that part as well.  (See e.g.
> > > https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
> > > and various other emails in that thread, ending with "agree to
> > > disagree" later).  I still object to it as I did then.
> >
> > Thanks for the link, and sorry for not having followed this
> > conversation closely enough to have seen your previous replies. While
> 
> No worries, you were trying to be a good citizen by reviewing patches,
> and the patches didn't come with links to the old threads

That's not true. This patch series [1] came with a link to the previous
patch series [2].

I didn't, cannot, and shouldn't contain hundreds of links to the hundres
of responses to this topic over the past 10 years.

[1] https://lore.kernel.org/git/20210621175234.1079004-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras

Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6FC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA4120663
	for <git@archiver.kernel.org>; Fri, 22 May 2020 21:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkZgH3Be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgEVVGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730963AbgEVVGg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 17:06:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED12C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 14:06:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w10so14377657ljo.0
        for <git@vger.kernel.org>; Fri, 22 May 2020 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YuX7fFV0ITOs1umDunJCBL3YXyG3wVc0ml228mPrg7Q=;
        b=MkZgH3BeOcB3c+IIwmTSbXTiBVtXFZCCNtou9TNEImqPhWYrI9OHxv9nGe5EZS4WQv
         32pcPUNQhKjzoUDm4u18D4wlnNEzP/SWQ0HwV2SRvr3JsV5ynhbh1qIAXIWuOnjNRykY
         6+75dWh0Iw0ceuw0fdbYukx3625M8eGWhntkkKhhpfchSMTARPpbL5WH9x2BoX0fmQLj
         GtVy00WkqgtfYltp43TtgZYTwfxQBrZ/kp2IDoJJPmkIkJHebhQ1y5EAjuTbklGx5l+t
         jFkadZ/S6OWRLSluHuOGtds1zhjcHaPQQrMFEYC8y78HR23JEIBnmEfQjLoOxBbpPvZh
         8m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YuX7fFV0ITOs1umDunJCBL3YXyG3wVc0ml228mPrg7Q=;
        b=Nvb5HbxNDUIBkNAoDSknqDJ4AjKqVKf1hfdg8Fa6lota3Kg4Dq54rYosaoMTrYVJIQ
         QuTbHFT6o97LFf+YHErE2+LyspszFrjhV1Gce12b3q2R0Idx2tNax6QVUEJBnWG3tHdC
         aXMqNzgjUqYz2Ze7LhRF9hFR81ilOPbtaO4e2/TIZbp7U/Qla+vhO9283ld35lhGbkrp
         WYG41MumlkNQQrdjX7UCybSAJThvVEFe7o9ZbYU4lmBOk/Y1gbD8GOMi5nCRNEb6jOw0
         6sNsRbRNDsTNYQq9Qad0+3qGqk6QoAx28ixWX15utXB6O1PcQ7rJwuX/xQm9nhx0iuh7
         iHyg==
X-Gm-Message-State: AOAM533hCQuuUBzL45kghySu09uDXJOLXele4QEP9ks9WIquKbOkcqWz
        QNdJOfiuO2sGC7jpWUyauHLnJK8dZYzaHqDhlUGtsg==
X-Google-Smtp-Source: ABdhPJw2atzJU27IcL6ld8E4+RWKVIMS+cT7weITmoe4lR9Zcjx+puCFuvfmF5bq3hXctiKXh0FuW8SahgglCLkp1po=
X-Received: by 2002:a2e:9047:: with SMTP id n7mr8857366ljg.263.1590181594398;
 Fri, 22 May 2020 14:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
 <CAGa9yXq1FwLJdFqnnino-34pMtTcvu8pZWhgHPoBY6mJBd=yfQ@mail.gmail.com> <CABPp-BEjrViPSXVg9h_1wCHzRSB3uG-93_nsjOOgLQ4mVhnkRA@mail.gmail.com>
In-Reply-To: <CABPp-BEjrViPSXVg9h_1wCHzRSB3uG-93_nsjOOgLQ4mVhnkRA@mail.gmail.com>
From:   John Carlissi <johncarlissi@gmail.com>
Date:   Fri, 22 May 2020 17:06:23 -0400
Message-ID: <CAGa9yXpz3Z=F3k_BXXoySBEWU26UjzzrMoxT3P1ZMcMSSL4pNw@mail.gmail.com>
Subject: Re: Git stable releases
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 22, 2020 at 12:55 PM Elijah Newren <newren@gmail.com> wrote:
>
> These mails from the maintainer may be of interest to you, though I
> think they lean towards there being no formal definition:
>
> https://lore.kernel.org/git/xmqqwo5luj6r.fsf@gitster.c.googlers.com/
>
> https://lore.kernel.org/git/xmqq8t8bvz6x.fsf@gitster-ct.c.googlers.com/

Thank you for those links.

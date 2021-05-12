Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BC5C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 11:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0279D613AA
	for <git@archiver.kernel.org>; Wed, 12 May 2021 11:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhELLGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELLGq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 07:06:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F82C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 04:05:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id f184so1687559oig.3
        for <git@vger.kernel.org>; Wed, 12 May 2021 04:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wu1+t0HWsUFFiLNtdjC8Re2X5zi/BlZGjKqJzGqWN0k=;
        b=KeEmLGwe96KmX+fFFdrkHVyVTNAAJMfPMD3xji2LA+ySWWMMEFfxZiFJda3G6MWGTt
         zT1ACh1/NnuDBeDcXNzEnziU12f8bGYV1R2sg3e6/U87sWYLyVjXLER12epsnnsQ00kL
         6el9P7JomTseXcXzPJB5eouFTZklBn0QcKbNMYBMvghxjxKmcRN+UrWUq8tEtrpBbyrt
         LQMoIx+XL50/fWMcncHlnemmMPOVxOW5SF0Vaj74c67hAzXdk02T9El26vm8siL89lfR
         V8/+KK15NX87dlKTaDg0zqGHDHP4PgYT4QSENACMVL1m7HUhm61EKWW6spSB08ify872
         4HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wu1+t0HWsUFFiLNtdjC8Re2X5zi/BlZGjKqJzGqWN0k=;
        b=Q8uYg1AD+iosSG2O5JHXy3kwywyg48J1y5h4kXFodmeMSGpREqgEDDc+PbrZUWlB9i
         mXAm1xIZqWCuNs42svHQJVHpzEll/qjRxcYLlw1mlP0H27Pnh6niH/bmiSJ+wf6HxT7f
         yg/RsduGg6GvcoA8+jr8Ll9RsZBi65y87ueGsQHOZd5ICmrBd7n3kVT4pg+R5OTGlI84
         iHhk9uECfieJTYSH49rs+jpylTVKDJBPqjCtkqP6s4VcsXeZCNnyiENEgWmtUJhlUvoZ
         u1rWB+saOHOJ2WhFR+4MOGhHYyUjYUHcIMXkoO8dIrGdHZu9CLfxNv/GKJh1kgaXYDsH
         IKxg==
X-Gm-Message-State: AOAM532Gc+s308klLzDa7scZ2XchySUT8H/7qhq/Q5KsqPn4/OYtiwH/
        B4Pey5IEgfNFrWXc06hNmJ2oYKDm/ru5mg==
X-Google-Smtp-Source: ABdhPJwgJuwTEoLrr7ofoOKh0eygYoHCei340v91+dNheacM3Ze7gN9mSnixU+tjrPA/bwh+fgc6Zg==
X-Received: by 2002:aca:c714:: with SMTP id x20mr25163604oif.85.1620817537240;
        Wed, 12 May 2021 04:05:37 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a7sm1420077ooo.9.2021.05.12.04.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 04:05:36 -0700 (PDT)
Date:   Wed, 12 May 2021 06:05:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609bb67c96463_70eac2089d@natae.notmuch>
In-Reply-To: <20210512100855.GA8544@kitsune.suse.cz>
References: <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <609ae224aa509_6064920851@natae.notmuch>
 <20210511202502.GM12700@kitsune.suse.cz>
 <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <609b9ab0b1120_6e4e9208cc@natae.notmuch>
 <20210512100855.GA8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 12, 2021 at 04:06:56AM -0500, Felipe Contreras wrote:
> > So... Can you answer my question?
> > =

> > Do you have anything against the word "affect" in *any* instance?
> =

> Yss, the Merriam-Webster dictionary also lists the meaning
> "to cause illness, symptoms, etc."

I did not ask you if you could list one definition contrary to the
intended purpose of the word "affect".

I asked you if you have something againt the word "affect".

We can use your same logic to find one definition for the word "impact"
contrary to your intended purpose.

That's not the intention of the question.

-- =

Felipe Contreras=

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4689C433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B556188B
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELCtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:49:19 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8432C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:48:12 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so19757696oib.5
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4lQovy4/Uygeek+FM0G+Ha0Gl0RC3ovLxj362MHVOBU=;
        b=qsp9d7G1WFprt2WzqxdJuoR+kc4PjRCBT6JHhvj1m+OM/C2lz3yO978QMSaStSokLo
         xVOFf8L3EQI7FpjH/5zQVjjOz3+0N0i3E4qrNnU2md9OQwxCSBGNvcfXY+cz3TGe3c8p
         tuJZ5oUXJQfeToAWl1CuVWOxcpUSXTF+w5HHqaX/6EVHCChzLadq3EBf4XydvLtQX8qU
         JSnCDg9hf4mdUmTwTEtUxDetPgwu6aQAETfdCfRmXQZHQXt6DybzbYrf4AShq4AcfgWP
         pTHDdc2d0jZDy3CKN4umtqJ1FetUv7yOSmSt8fy0t90pF99yb4AiexXMdpzDup83zC+R
         MHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4lQovy4/Uygeek+FM0G+Ha0Gl0RC3ovLxj362MHVOBU=;
        b=iQyW6zE/PakgGSA6tWSV0nW/MtYdlNUBGpPaKx4rQKscxqGzk7BfcCyV6/o97HaIJV
         nzVsifpqx1BYyWGLCXYN/cxtSKB3cU1IfExuzDp8xDHRdAsNF/2mYtUv6mbr6Hnuousi
         CggvjK0rfZ966e88wQz5QbaGwG6qfQ91MSCABuvcCIwDEp2TASUCzKYuYxTLhdi0GLVN
         lXpHvAzNnxSyH9PnqJug6FIgVym3lp5IhhkjlibBpG/SeUKxGqIv3g/b7kiehFJb37AW
         CS+imHTQJ1bkxF4MWIlDPcFxx5s8xPi5YO1aTr71T17Umc3HetRUC5U3JnhBYRI0BnOU
         EDsg==
X-Gm-Message-State: AOAM531oAGBuqhdv7HEcrJ47VIpm5mzRXOnmOFvcXPXbKhgS3vtGfoOn
        LjCxjno7Tz/XOWzvIKy9LRyP2Bk11NiaCQ==
X-Google-Smtp-Source: ABdhPJzuMyKlWVgrc+cMbRIGUED24Zf3NSOdlL8MObyaVgWBX+AKNTVAyrzNNt62P7pR62I5lfdKFQ==
X-Received: by 2002:aca:df55:: with SMTP id w82mr5943650oig.25.1620787692256;
        Tue, 11 May 2021 19:48:12 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id q1sm4309820otc.21.2021.05.11.19.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:48:11 -0700 (PDT)
Date:   Tue, 11 May 2021 21:48:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <609b41ea9a75a_678ff2085d@natae.notmuch>
In-Reply-To: <20210510173502.GH12700@kitsune.suse.cz>
References: <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
 <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz>
 <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
 <20210428184956.GS6564@kitsune.suse.cz>
 <CAD2i4DCLpvAuwp5UEDcPA0wzr4Eg_qhs_xXDW1eLiOwYkUvL1g@mail.gmail.com>
 <20210430075924.GB6564@kitsune.suse.cz>
 <CAD2i4DBSajgNFCwMMDv_tyQwuKDU095avmHs=BHcrAY1GbCqwA@mail.gmail.com>
 <20210510173502.GH12700@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Mon, May 10, 2021 at 12:19:05PM -0500, Varun Varada wrote:

> It refers to redundant changes to the codebase which do not improve it =
in
> any way.

This is not the codebase, and what does or not "improve in any way"
the status quo is relative to who you ask.

> > As for there being no distinction, there's no gradation within the
> > semantics of this context; this doesn't change the semantics of the
> > words themselves. Using "impact" when what is meant is just "effect"
> > or "affect" is incorrect in all such instances.
> =

> That's your opinion not shared by the authors of the text.

How do you know? Have you asked them?

Just because person A wrote text X doesn't necessarily mean they think
their version is superior to any and all future suggestions of
improvment.

> The authority you refer to is MIT which is known for technical
> brilliance but not as authority on linguistics.

The MIT hosted Noam Chomsky for many decadates. Are you really arguing
Noam Chomsky is not an authority in linguistics?

-- =

Felipe Contreras=

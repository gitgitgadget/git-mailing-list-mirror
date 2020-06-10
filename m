Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF273C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9E32070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591806668;
	bh=9TwRDIW5M+crMS7Pyv0uNePeZmf19xxErRsfIoPHY+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yftp6KZ/lvmZNK9HhaWE7PUqwg6kawodhO+yGFTHetCPyYZ8srMbkXeNBiwRmQ6yx
	 7PqbJJNlO8d15308rusKXOm7UjoDmTyvn9O+N+A1koT46dDPbiSb37hlteU9Ms1hht
	 fCYXosFzxwgSPYe/Y41EEpfQskrNoDkbANfXsy7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgFJQbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgFJQbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 12:31:07 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D6C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:31:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dp10so1288472qvb.10
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TwRDIW5M+crMS7Pyv0uNePeZmf19xxErRsfIoPHY+U=;
        b=hMBCF6s04loE6u5rDN8ZenBj/hgFszDhfd2uL4XEwLPEjR/seR8/N5Hk5B8nfxQfBJ
         6/O2oF4uGCuUCl2xm7nYhe/k4VM2u0SAWc5227KHwCdBIMnCav45QX0pxSb3aSNm8P9R
         xmhXASA0hz0qNLRyTjFKRqkoSMkqD+RYmoy08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TwRDIW5M+crMS7Pyv0uNePeZmf19xxErRsfIoPHY+U=;
        b=If1eHVogQ0BNbn7qnZzH6qRPanRVMbWoCY44vAK6n9EIWGb6Da0cFIoSVTmTePZ2Eh
         f2Rnu/pHl6u1P9Q/Arv4XK3DCXTiFXtkt+2nZwESifFKpY/us+PT/QbelknfnH00tLGL
         KrAFMFDJvM9U71qsjG9XlxjIAeYPDo9Ss+YVIRW/KRWj5xIpUGscRhvcl+JAaSk67Ng9
         8PrBzA578VQACsLRsWqeqTNNZjCqhaDy5K5kta2lxy25ru0UdImHyTVi8pNN/7/lj5ga
         2bD20MXp3MPUQLCbTNjzy432RR5VH2aypXEA+mcmdzjMVI5+uaVuyHZtyrPNAMWpgTRh
         6d9Q==
X-Gm-Message-State: AOAM533MRivfkDHuYk0hlA03F4nmYA0lYOqFEqw/T4Uaeg/9o8DqjCW0
        TRHfXZodV3JghDLNwYUVyf5bZp6yoPzD9rtDh0JuwS3n
X-Google-Smtp-Source: ABdhPJyjnF2tecZmMPObkU3I/XMXJ9NWI6+QMH45WM7wFYgcA4flAzjR1jBpPTFCISGeH+dVBZA+ul9omfukaiB9YPE=
X-Received: by 2002:ad4:5511:: with SMTP id az17mr3935655qvb.146.1591806663608;
 Wed, 10 Jun 2020 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
 <xmqqeeqoi5wc.fsf@gitster.c.googlers.com> <CAOAHyQzxG7Lc6+PLBtM6oe9vSoEEAmuXAaKF2VzO_phtkfGRVA@mail.gmail.com>
 <alpine.LFD.2.21.2006100549070.3771@localhost.localdomain> <CAGA3LAed-QZNiMhEPBmjV2noVgLON4ciJZNsmZ5ZhTFSC2WeKg@mail.gmail.com>
In-Reply-To: <CAGA3LAed-QZNiMhEPBmjV2noVgLON4ciJZNsmZ5ZhTFSC2WeKg@mail.gmail.com>
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 12:30:52 -0400
Message-ID: <CAMwyc-R181SwjocmfHvG5U00GYu_D0MVvo7L=6KpPUDOObe9iQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Don Goodman-Wilson <don@goodman-wilson.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Simon Pieters <simon@bocoup.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Jun 2020 at 08:18, Don Goodman-Wilson <don@goodman-wilson.com> wrote:
> If this were the _only_ effort being made, I would agree. It's a small
> thing. But lots of small things add up, and they make the big things
> worse. So, because it is small doesn't mean it's not important, or
> that it can be ignored. Indeed, that is a sign of privilege, to be
> able ignore the small things that seem unimportant in isolation. Thus,
> of course this is not the only action I am taking at present, I take a
> multi-faceted approach to my activism, and I encourage you to do the
> same.

Curious, what are your plans regarding your Master of Arts degree?

-K

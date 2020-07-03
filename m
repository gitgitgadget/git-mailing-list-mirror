Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C98C433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7505A204EA
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa50oczj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGCG3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCG3T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 02:29:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE7C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 23:29:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j80so27959445qke.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7PjBBIfPgOBffUaZBv6oJAhYgxQGGmNcsOHNk1Yqjc=;
        b=Xa50oczjwTfltGdZbboQsthkhGQRsmRQZUqxjiZ2DGclVIT6u3PH6yJY4NgWoUCj7s
         4POuJKdhW1Gd+SdsYzo80e06ZE4kftPVa251pbkdH6GfeUlW2ao8P2BsBy0a3xr/ADcs
         lYKbt1qZFnDm/HRi3YiMtGkGqlkPrXCgPE0l1HSp+z7FJD0HvremW7rw8TjkEsX3yGF3
         YQiTxjtYVGjqowtsyupZvqBNfHFNQvRlzWzqrE3g2r4MPl3t7mW1F74clbx86ZOuwXWp
         1CwMaG9rxVnR61BaWGRqQLqGZprLHR49JrhGhqp0GXKiRHQR/9Kudp/quoWKvSxq0Ro9
         GuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7PjBBIfPgOBffUaZBv6oJAhYgxQGGmNcsOHNk1Yqjc=;
        b=AaCBH7J/6kZguKE+qEGjp3xfsASTP3M8/bcTerMRURJ28zcPUHT2KvGsi/GymlYssO
         Yf2PVqfcrKS9Thi3fAL9RLH2s6uxTa+WyrgckeMU4Nn3GYur4Z8OaO0dDmgxl7orZYRY
         gSYmSet7FaD5yo7bU1YRXgsbYj4Ckni7E/9ubudxPVQ3fdoMB1eWL7ZLY4ppdUhE7gwN
         G6zpyGi3D6WOaS6XnaDDvQVuhD5N522KFnGukLKejZJLRX8kaIJWCs6Z9rrSLv71yv/K
         +9PPRlgQXqDR+7I2mH7RUPmiVg7d9E0wbPN6Owi16l4p03dCZlYY9QNPj1+gqP+2i/rn
         dZww==
X-Gm-Message-State: AOAM532tK76zZYkzT/mNDXzB7KF/PjOhAEykpjfCs+HXDWbrarMFBv/u
        yIu0b1qvR/Kx1GcvOA+wN/QwK9cTTZYzbmqod/lKpg==
X-Google-Smtp-Source: ABdhPJzp8S3ICUKYZ8zsI6XWhZIUcdzgV2d45j3p+6fBXue/LNHvaM4GfrsD73RARMRx1phpQCpJnbue+wDCAHyUyUM=
X-Received: by 2002:a05:620a:12b8:: with SMTP id x24mr25948064qki.158.1593757758370;
 Thu, 02 Jul 2020 23:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
 <0e9801d6508d$c1f55560$45e00020$@pdinc.us> <CAAF2pWb8Namk1rpm4==PUrq4ft9fp4eD=t9WyMLv56dPZuGk2g@mail.gmail.com>
 <03bd4b4e9b172c4ee6cb44653bb9c5b26df76445.camel@mad-scientist.net> <0f0e01d650a6$9a5b5b80$cf121280$@pdinc.us>
In-Reply-To: <0f0e01d650a6$9a5b5b80$cf121280$@pdinc.us>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 3 Jul 2020 08:29:07 +0200
Message-ID: <CANgJU+X2C157XCxbcdrGf1rRWY10o9UGtXMaqafgJBLORucEkw@mail.gmail.com>
Subject: Re: Is git compliant with GDPR?
To:     Jason Pyeron <jpyeron@pdinc.us>
Cc:     Git <git@vger.kernel.org>, Matthew Horowitz <mhorowitz@pdinc.us>,
        Jakub Trzebiatowski <cubuspl42.1@gmail.com>,
        paul@mad-scientist.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jul 2020 at 21:27, Jason Pyeron <jpyeron@pdinc.us> wrote:

> > On Sun, Jun 03, 2018 at 04:28:31PM +0100, Philip Oakley wrote:
> <snip/>
> > You provide a lot of arguments about why it is not a necessity to have
> > this, but let's assume it is; is there any actual problem you see with
> > the proposal, except that someone would have to implement it?
>
> It's the strawman problem. If it was a real 'real issue' then it would have
> already shown up with companies clamouring to pay folk to fix our (git's)
> latest problem. But the haven't, so I think it's a much more balanced issue.
>

I don't agree. These things tend to come in waves. Just because the
first wave hasnt hit yet doesn't mean it wont come. GDPR is still
super new, people are still coming to understand it. Over time this
understanding will lead to more people exercising the right to be
forgotten.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

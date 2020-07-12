Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F1C433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D9BA206F0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594585597;
	bh=MhlLhW0CR0JZNB59Ltgxid8f2PjjExyvUFfBZ7nQkBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PKiA+VquMRdJ99i0ycSSlqqWd4l4lnRGDvp1q9WugVocMtC25LjpuVDTr0VrwXkyW
	 ciNwoHQ+px4M6jSWXiYEtPaRBUjyseaQ56HjsqXS9YDAVG1FUnSD74CGWTtLmrHDeA
	 Pz/O7DSEdLqxL8rvB/tyZxv4TqbX9C2iPN3PUfzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgGLUZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgGLUZI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 16:25:08 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B0C061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 13:25:07 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id dm12so4927236qvb.9
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 13:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHUw9mUOUyU/gKez5u/QIHVqnXVFA9AU1M60mjJpCrI=;
        b=A8BB73jyVvRk5gK3qqqn8c8A5QSOCS3i40g7xXPR2ulscje9imrmLzB3MuzrJ5aG4G
         MCijYiYihnB5KsVsoPFljKOo98hUg/yu/+sDYv1lCJRls2h+lxbgwkuPK9zmwZT4pMBG
         8gU6LgFFO4uL7bNX18Czv1h2QAwzzG8huswbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=mHUw9mUOUyU/gKez5u/QIHVqnXVFA9AU1M60mjJpCrI=;
        b=LAQfoMtxknR4dAZvhTGBL9x/yDI1e1I1jU9EY3RMCBf1Ly2ejAdmHDwvCU/4FJGAoI
         xyL4FODB+UuVY9+0tBDIyIvt5vQ4ynwSXEzAC+82Iz00Gi9rXzyKn4OOq5kuBredRt+X
         kclo326i3jMC3GvVIeRENjKxQL4POfgT8IFZBzKnnQkaBXlEzSYa+eFcGDaQchWZBDHO
         PdLAVZq0FhKhSCiXaC7ILbl66ZjxnvYZRBVjv/evlp6fkI0+U/odBZ24Rl+IHGhxQtbO
         y7/QuUzmJhIAVHxP2/3sz4A+hZqs4zDn4NDXEpwPWm4eEvs+TLwb0RZucff3c9QWs87P
         f5mQ==
X-Gm-Message-State: AOAM531rWpHTMh7k3Nbx6Ufs/rL6kHZtKFVM+VJNdrApbskN552f3Wz8
        wdP4j46OOYPYOArcfjJZSKQvaw==
X-Google-Smtp-Source: ABdhPJx1fFOsChCDB3prlXPTZuCCYvQIsZeSALYCFEzWuL7ccC+d9QgLZYm5GYaNwjBaXU9Jjv0FAQ==
X-Received: by 2002:a0c:bd2c:: with SMTP id m44mr79082413qvg.195.1594585505632;
        Sun, 12 Jul 2020 13:25:05 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id j18sm19389080qko.95.2020.07.12.13.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 13:25:04 -0700 (PDT)
Date:   Sun, 12 Jul 2020 16:25:02 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblkkr63u.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 12, 2020 at 10:33:09AM -0700, Junio C Hamano wrote:
> >> So, unless your script depends on the presence and/or the contents
> >> of FETCH_HEAD, you can safely remove it.
> >
> > Excellent, that just saved me 20G per each mirror. :)
> 
> Meaning that minimum 4k per file adds up that much due to 5 millions
> of repositories, or something?

Gosh, no. Only 28,000 repositories, with many FETCH_HEAD files being a 
few MB in size.

I also discovered that symlinking FETCH_HEAD to /dev/null works as well 
and thus saves a few IO cycles.

-K

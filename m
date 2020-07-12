Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274B1C433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B8C2067D
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594590878;
	bh=NTfRpoNVJ9Kz0gMvVJzviW335xEzGxak39pPmu6ixbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g6V52wPPbOh56Rlv1sTLKufgREEhEuCBlIhs8gjJJubjAeVQg/vLofysxoCBP2XBl
	 sVZPPl98wyFULXpQiM2fx8gBj48ZoHEgCOMZ3KVTHvcfZkSUyK1+TVPCLRitdJ+QX3
	 dOmQP9LfxmVcFJsQoWO/06zHV0InKXcKqlYdt4/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgGLVyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbgGLVyg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 17:54:36 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C01DC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 14:54:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 145so10489523qke.9
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aMSeTAICtB2644/IXuB0kvx0bijw7oyaLgKOzKuMc4=;
        b=K3zIBv74MBbdbntAeYS/xX8ykYhPE/E80Sut/zN34Wa4xNpO5fCEm6WcW2ADJvNFXa
         XO86uXDOv65pChdV6H5oIrtCL99uj1NcuCAb0thVwml2N7UUgHIapNJ/6F4+AbRW3d3K
         +B450Cqon4oBN7OiVkhxS8a1+CO6O3+dmM1wE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=0aMSeTAICtB2644/IXuB0kvx0bijw7oyaLgKOzKuMc4=;
        b=qyTRln+5AO88jAMnMQu0x2k8ji0pDNJ8lZvQxaM1lVMqFRUYpzDZNYcGckZGbDwoIY
         GnELnBmH8SQtE6zT0Yn2Ar0OBVeNItC6V9yOmVQZt2Idqg7ncM+jVkKhHxDfgMEFZHo3
         9Nc9jxGsU4xJJx49Sl4SVS8H7BEWkiRCa2rmOFqnVgqfYcnDSJ0CFjF+ayujKUwFK9Ju
         YSyQSqyWtNsXswnSzYzlulF5P3qFYAu3Fc+WrGav1OmaMVNn8g6QiNlwPcs45Mh6HCtY
         Xc9aJL6s6Mtk0PXXT8yArUNtxx4RGKtFxpd/Gja/LD5VLcrrEDHWYpVtVXWFXu/FlghT
         jM8w==
X-Gm-Message-State: AOAM531yK9FYcAMYXCKH3R5cGJXwWvriHkG+gU2cT3FWBcu2HJ/gYQyx
        dN0sDukwbCBnzyMhZE/w+sXWT/jkNCQ=
X-Google-Smtp-Source: ABdhPJytxXVpq2vihZrmJ/MEnCKRABklPGsnACDPHvo8TKap3pU9hBpqr9w+bhjDfYhH68TeCKl3rg==
X-Received: by 2002:a05:620a:b8a:: with SMTP id k10mr79786818qkh.32.1594590875645;
        Sun, 12 Jul 2020 14:54:35 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id f4sm600345qtp.38.2020.07.12.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 14:54:35 -0700 (PDT)
Date:   Sun, 12 Jul 2020 17:54:33 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: FETCH_HEAD files and mirrored repos
Message-ID: <20200712215433.cfjyqzaepsuktny2@chatter.i7.local>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 12, 2020 at 01:52:17PM -0700, Junio C Hamano wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
> > I also discovered that symlinking FETCH_HEAD to /dev/null works as well 
> > and thus saves a few IO cycles.
> 
> We could teach "git fetch" a new "--write-fetch-head" option and
> teach "git pull" to pass it when calling "git fetch".  It is very
> plausible that some folks rely on "git fetch" to leave FETCH_HEAD
> without being told, so the option must default to on for a few
> development cycles before we flip the default to off, and for those
> who want to live in the future a bit earlier, we can also introduce
> fetch.writeFetchHEAD configuration variable that determines what
> happens when "git fetch" is run without "--write-fetch-head" option
> on the command line.  That way, you could drop 
> 
> 	[fetch]
> 		writeFetchHEAD = 0
> 
> in say /etc/gitconfig or in ~/.gitconfig of the user that runs the
> mirroring automation.

Yeah, that would be great for me. We can simply leave it on by default 
to preserve existing behaviour and just provide a way to disable writing 
it for those in fairly unique situations where that matters (like mine).  
One downside of symlinking it to /dev/null is that it creates a 
potential pitfall for software that expects FETCH_HEAD to always be a 
regular file and can behave unpredictably when it finds anything else 
there.

Thanks,
-K

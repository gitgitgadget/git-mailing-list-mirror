Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D0C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 22:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhLNWMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhLNWL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 17:11:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1DC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:11:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so14698624plf.3
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MT3M1uhtzCMocrIpPnJuAmRjpw/EjZTdMPhQ1MTByM=;
        b=rgYBPtaMBz10XUxMfKhqEgSn5o07I1ExwTMY7j2wQ36ADC2tDvz0UTLM098dL4HiN/
         EYwNS+K1H5XFQ+nTI0diF53X0Vdy3JLtYGmRV4kEOTVi3huJ8ASWO/Q+q8rvOyux1NIs
         jrJ9rasjgXxuMbSupTgJwgsdFvHGnJI4AqGyoPvgERFJ711+uLiSq4ZREDtsVYN/3gBH
         QaZIjBu4B7Hxg0gZkDiPDZ+ibp6IyYFdfX1ypAtdxcng4BVSYriPGmKC1x8bOR77VAMl
         kyg6AyRQ4C6YCRvHnnrPAeNx46P2VCtCN5nX/0YP3dz6CCot2Fek79cdftGiPu40+GBi
         zgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8MT3M1uhtzCMocrIpPnJuAmRjpw/EjZTdMPhQ1MTByM=;
        b=W7WY4Dq6xCZqyHpK3eU8VVUEyNY7mv0abDa04ECY9Cc4/rgFMFJC/U27wS/e57edNM
         01Brh7/V0YyLnVgeg9G2+SPH62pqz7+TLwEeQ8V4kJfDcEyHLWepdQMIfqkxp9ihS/Mz
         QvnmkCRdxmKnpSV75gYgW/oZZkiW/ShfUtlaJSX9zWQxaFG4IH0XTXJ2L2Lt8Kz8V118
         q0BbfOTUbXylsaRTTYy2PiXqIQ8N1u4PwsP54EEfsHHf1h0rhLTWMCUTIwHMFpXHa7ZA
         KyuWc8NV/RF8m8tY5ZjqBZK0E++u+Yg/9munrmXxqc9sW81V48QOSzYujMvTiObA1Sa2
         RDjA==
X-Gm-Message-State: AOAM530P5lXfR6c6su+lB3bmKSVkcF2mWC+xKvrpXpfVOKt82aRRlJWN
        ww7nVzi7P9hNgEMmyT4nl+2gFBCZPstB7Q==
X-Google-Smtp-Source: ABdhPJzR7W2p1cDTjmvZavybdDAK6+U+wpo7O6eh+0O2HKSxwXpY7cW/f5omWvfWsbFCCsLRKZK2og==
X-Received: by 2002:a17:90b:1a8b:: with SMTP id ng11mr8419478pjb.3.1639519915377;
        Tue, 14 Dec 2021 14:11:55 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b37:fbed:ef52:5dca])
        by smtp.gmail.com with ESMTPSA id lk18sm2238549pjb.39.2021.12.14.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 14:11:54 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:11:48 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, emilyshaffer@google.com, avarab@gmail.com
Subject: Re: [PATCH v5 0/2] branch: inherit tracking configs
Message-ID: <YbkWpIQSpT+7b31z@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        chooglen@google.com, emilyshaffer@google.com, avarab@gmail.com
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <xmqq4k7k8cz3.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2112102344370.90@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2112102344370.90@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.10 23:48, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 7 Dec 2021, Junio C Hamano wrote:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> > > I've addressed feedback from V4. Since 2/3 reviewers seemed to (at least
> > > slightly) prefer handling multiple upstream branches in the existing
> > > tracking setup, I've gone that direction rather than repurposing the
> > > branch copy code. None of the other issues were controversial.
> > >
> > > In this version, I'd appreciate feedback mainly on patch 1:
> > > * Is the combination of `git_config_set_gently()` +
> > >   `git_config_set_multivar_gently() the best way to write multiple
> > >   config entries for the same key?
> >
> > IIRC git_config_set_*() is Dscho's brainchild.  If he is available
> > to comment, it may be a valuable input.
> 
> The `git_config_set_multivar_gently()` function was really only intended
> to add one key/value pair.
> 
> Currently, there is no function to add multiple key/value pairs, and while
> it is slightly wasteful to lock the config multiple times to write a bunch
> of key/value pairs, it is not the worst in the world for a small use case
> like this one.
> 
> So yes, for the moment I would go with the suggested design.
> 
> One thing you might want to do is to avoid the extra
> `git_config_set_gently()` before the `for` loop, simply by passing `i == 0
> ? 0 : CONFIG_FLAGS_MULTI_REPLACE` as `flags` parameter to the multivar
> version of the function.
> 
> But that would optimize for code size rather than for readability, and I
> would actually prefer the more verbose version.

Sounds good, thanks for the advice!

> Ciao,
> Dscho

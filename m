Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A200BC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbiKNWyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiKNWx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:53:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB410B5B
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:53:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p141so9398406iod.6
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPQzzm+CwC+66TM26tI3Xvqepc7mpU6eqy8LpLvyobo=;
        b=WVpRie/90MsQhhJcrW4nBPgru+XFbqGM9CuwHYtTdlY8VVv5MVVDFDoUXmiJneaEYj
         QixmnaQmLwYQoWZ8gY0gNhoQr63eZCO77QSQ2xP+tyMWNYPMXZcNMfHfG8PxpFfz0CMe
         HavF6OuaOTsVWdUEe6G0Tba3BDkWNHOuknTx0g3Pvl5ewzOeq2gJRQ+ie1SSPM2xRdtP
         Q1gLDFxhg5s4nOwD0Gg0AlahVbkDVE69GqYqGVok5jWN6YxlTraFzeFs5Wz/MHNgZBDH
         eJ2p3bPck0LjN+xAqhg7DcAF0sCjhptLmt2X4K5RCFDL9pNQZmvGs3uSh9p4h9L9+m7M
         fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPQzzm+CwC+66TM26tI3Xvqepc7mpU6eqy8LpLvyobo=;
        b=NXO0P2NAfKPOvPy9Ywv+AgY6IjOicl8HhkT34qWnZaQvO0mmBDHSF4BYjbcUaFW6Ts
         Tda79iy7jXoD6bi5jX+gYpYRlAazKPEwn0/s/f0JjW0OVr3D2ItGD2jL5GXzR/TbOvkX
         H8tzIFfgmaeXLJzGWEqFPbxyGV4cnWa+aWZZ/rVo2mh3wdfHdfWe7a8xDzDx1QiV8r4P
         1MiFo/N2guqI8iRXGqNhqYAwC/EiBI5WnUFWMnDA8yqtJ3M925eNHF5tgeuNznrwQqPE
         6O62bayF2DlIQfc1ShSFasUUOOykF1LaBFkfZZNmaQMP49qV5ZT0dlkNFhd/22MGEmGC
         kZyA==
X-Gm-Message-State: ANoB5pk7eTqCL4axayn0Vy65AzdQfO+CwYdGqyES0QhcmyRxCzmTxqIe
        mAZP/WzrKFVfzfFXDVOhaRSyOqBY9AmaKw==
X-Google-Smtp-Source: AA0mqf5+qmCaMeX+3SZnq+qYdq7mJUwIL18RaHzIe4KQPKIM3Hu8TI1fGsJ7XEjJe044XsdRuN+ONg==
X-Received: by 2002:a05:6638:223:b0:375:b099:e48e with SMTP id f3-20020a056638022300b00375b099e48emr6287714jaq.319.1668466438170;
        Mon, 14 Nov 2022 14:53:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n22-20020a027156000000b003722e5b561csm3844567jaf.52.2022.11.14.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:53:57 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:53:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v2] maintenance: improve error reporting for unregister
Message-ID: <Y3LHBL3PpwufjjFx@nand.local>
References: <20221111231910.26769-1-ronan@rjp.ie>
 <2c78ee6b-0ee1-8955-a692-384a238d0f64@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c78ee6b-0ee1-8955-a692-384a238d0f64@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 10:04:38AM -0500, Derrick Stolee wrote:
> On 11/11/2022 6:19 PM, Ronan Pigott wrote:
> > Previously the unregister command would only check the standard paths to
> > determine if the repo was registered. We should check the provided path
> > when available instead.
>
> Thank you for following up on these items. I appreciate your diligence.

Thanks, both. Will queue.

Thanks,
Taylor

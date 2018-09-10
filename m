Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BD41F404
	for <e@80x24.org>; Mon, 10 Sep 2018 16:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeIJVhY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 17:37:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32976 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeIJVhY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 17:37:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id r1-v6so5920029wmh.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=H64MPAPRu1op6yBJVSFGPdRjaU5DFs+Mwvk+0GjzRLw=;
        b=tHwrROMGC0cq8JuKc0CYDLoXCtgRd6x/6IAwHXHbGMR795EWv2dMaFe6tniJRkWBHb
         w1EaHYWdr2JNruQItyDh006DBLcl6hyUxcxyj57Pbqo4907fEZX2Kxos1l/24xbbbG+A
         vxxM3fLd+nVy1R2JMDefqHgdYuce490YjivDEwwq1Z2UIpNJOks8QUqAhI7V0tg3nLMC
         HTjSGpvUPfYVGAln6f4TytTx+7rrp1q5TO7Yq52d7LwfA0A4Ypg2JPN4uhDtXo/oUxys
         kJAilVnWWOgxnvNyn1O56uU6oJ7waF+5OkfhL4mh+i6zIOkBE1DtXvTl6mIV7FRQoFuY
         RMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=H64MPAPRu1op6yBJVSFGPdRjaU5DFs+Mwvk+0GjzRLw=;
        b=Ot6tnasxSi2qYgTEF51b8YnsWK19LoAvwCTc80AzEdVXSLYZr5RPHz+vK3iH2n1GNj
         ItAFj+17yI7IKRhuvq8l8A3MQDs0HpbkLA/CO8hPfuT5jj9OZVhExfZJnxyGKhR7CRln
         BsgBmpxcx/PEswc0IM0sjG5OgvVwoaZMqmZ8n6gS2nD6eGiOal76hDtp+i0FguEvdW8N
         lZoDdjSZfDnK+/zWDOn7EsxU4D7YRYNsvwlkb4slJhkNjGeazA60QWFalMoKlXLJvJQX
         MmEh8IROPkSVD7yqpVsf/z77C8jPNi+oe+Ez8kgmuiOApvY9iarYWh5wzqrf6jZ+co6D
         p77w==
X-Gm-Message-State: APzg51BTULumJ3EZXTKmc5H8rjlNDNmMxlov09+LGSySYBGNxRgItdY/
        UtmfJuFv8AbqLn8b3H9M2DlY8izl
X-Google-Smtp-Source: ANB0VdZA4j0kDI8uaFc8CY0QqwhEClecuo2u99ChFm6WKhiZ0UookV5rY+wDTto2Gjm6Gd9madvS/A==
X-Received: by 2002:a1c:f0a:: with SMTP id 10-v6mr1309164wmp.58.1536597746775;
        Mon, 10 Sep 2018 09:42:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p89-v6sm26893280wrc.97.2018.09.10.09.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 09:42:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] mingw: fix mingw_open_append to work with named pipes
References: <pull.35.git.gitgitgadget@gmail.com>
        <f433937d55974b75750cfc7d579a6a56109259a4.1536344387.git.gitgitgadget@gmail.com>
        <1c524f56-2021-a961-168f-e5c6d7914ec2@kdbg.org>
        <f207bc28-a303-5d63-e9f4-da8e4d466bd5@kdbg.org>
        <0d38ec8e-3f4b-c0fb-ba6f-e2cef39e4db4@jeffhostetler.com>
Date:   Mon, 10 Sep 2018 09:42:25 -0700
In-Reply-To: <0d38ec8e-3f4b-c0fb-ba6f-e2cef39e4db4@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 10 Sep 2018 11:44:56 -0400")
Message-ID: <xmqq5zzduwwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Yeah, this whole thing is a little under-documented for my tastes.
> Let's leave it as you have it.  I'll re-roll with a fix to route
> named pipes to the existing _wopen() code.

OK, I have these two patches in 'next', but let's postpone it for
now.  Windows port will be built with extra topics over what we have
a the release anyway, so your improved version may become part of
that and then can come back to benefit us in the next cycle ;-)

Thanks.

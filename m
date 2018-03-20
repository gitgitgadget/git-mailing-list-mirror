Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E866A1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCTQ75 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:59:57 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:50527 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTQ74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:59:56 -0400
Received: by mail-wm0-f46.google.com with SMTP id f19so4873816wmc.0
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JJvflirCSDGLQpXuavX5/rw27nz4gT9tXYekWGX8JUU=;
        b=gMGcVYvyvepAdbVtXdChtdscpQBopB4XmuE5xDgd+YZDoKcwM4oBCDQ5K0Hh5tLkec
         rimSTkBtO5YQQ25nGYtICU/1OBWqs1f+0ORVJKVl44QO4K4fh+S5xFXw4DzZIvnSewZf
         8XZ2wiC5tXDgNjOAyeiEtQSZeHjRRW1DX4SJUIo97wxR5pmjumIPYK5vQRmvbYs0aYmi
         TpygqnIOoMHonAwrlbPtbAJe6zULQ3/uEJjBkLRn5W87z5YQbt/bGZ14aORI2etB9sbc
         WKz8s3Ll2/pwKsy40qtBA28frlWnLH5DYMAD1i41N07K91HEMW3hSNBSFafe6lMeWAbh
         fieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JJvflirCSDGLQpXuavX5/rw27nz4gT9tXYekWGX8JUU=;
        b=VZqQO2K9xNAwQBxqS3J27KoUP8/Al8meL/q5oDR44aQ1NcGylLcN8+gL4yk6j9uPzx
         8/AsTBD9N6GOv9RUjcTG1y73KNb8OvrxIXLSmNH9WRFippwfFpgse+y1oqXsRGMjPxGB
         FfQEq77pCjipPhy3yutQwQrQMq72NN+10vjYkvu3G2Gy12UEiM5cAaIvOEJ7f/ghAzaq
         g+48A2Hx/1Yw+eHi96kqlNSiwsCfwZaODe+uLfPds5knVL9x7Qdkfce14DE5AACJu/t3
         zX6ZDfd4LbrIlMuwe5GLfxXB62h/9UF6wqJercJatZ3jBUtFHfgU8cbTtkosIdNvSLXs
         084Q==
X-Gm-Message-State: AElRT7F77VlI0le23EjSfPzVLQUICs4AlBQ0akBUsccmWddWqCr9aHsQ
        YUOOF7e302mD2Akvko7Fyzc=
X-Google-Smtp-Source: AG47ELsszR0as9xphfdGFrDtkcleTt6VN/mh0dJKjYx+i2mehXpE0aDNSZhJ07eFyokACFPW1ei+XA==
X-Received: by 10.28.136.18 with SMTP id k18mr288229wmd.111.1521565195252;
        Tue, 20 Mar 2018 09:59:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m7sm2139354wrb.86.2018.03.20.09.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Mar 2018 09:59:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: PATCH 1/2] -Wuninitialized: remove some 'init-self' workarounds
References: <946e0ff9-307c-6886-6ade-7bd37cc9f97f@ramsayjones.plus.com>
        <c9748dfd-4293-140f-e753-8736bc196ab0@ramsayjones.plus.com>
Date:   Tue, 20 Mar 2018 09:59:53 -0700
In-Reply-To: <c9748dfd-4293-140f-e753-8736bc196ab0@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 20 Mar 2018 01:33:54 +0000")
Message-ID: <xmqqvadqsmwm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> You may not have noticed that I messed up the Subject line of
> this patch - I managed to drop the '[' character in the patch
> prefix string. :(

I did notice the lack of '[' while reading, and then totally forgot
by the time I started queuing various topics.

Thanks for reminding.

> So, the commit 7bc195d877 on the 'pu' branch is titled:
>
>   "PATCH 1/2] -Wininitialized: remove some 'init-self' workarounds"
>
> Ahem! Sorry about that.
>
> ATB,
> Ramsay Jones

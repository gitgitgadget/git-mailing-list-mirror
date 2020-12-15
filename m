Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94316C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F8F207B3
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLODez (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 22:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgLODEj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 22:04:39 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22598C06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:03:59 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w124so18638873oia.6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=/5MH8D6HfE6JufCaRO5bk/WI4WyQw1SoLodWrzWzXHk=;
        b=nAzkrZgLM2Oh++jxhT3byuiHNoJay89tgxvsnNeC6OPnbnPRlhDsfjuSh8z10QcjVn
         x1gSKnV3AlNI3w3FuiQ3eXy9JKr0SYrgQYoUBog7+f1PtSzqGrIOcpZMdr/9RnT8FLYl
         snXJKF3gX1cq679LJuXYxVCIbSdbf5u0ZhJme8287e8tgYodeGbCzToKZELo/6ZQSORh
         Lk9rHXaRU/A2Cj+XbtR7p3Jm4YECWv3+hki9TCxPQwm0WcyvW4Ts1l30ArqL/k6bJPke
         yNROjni5T7J9gzlUMYMaijMVfpfqDS60EZRiXhNuEIi3oyrxbve7VoFEFOR+Z1Or4v+u
         N6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=/5MH8D6HfE6JufCaRO5bk/WI4WyQw1SoLodWrzWzXHk=;
        b=WgF7dXWnAUgC9FvH2zo7OiQWaGpPWlr0da6iJ7vhsXfUQ6tbFIq4kwVG5oNHH4RDGv
         DM6yV2VysZy6KpEYKijIlVj+DkZhfSrrqLjBdP3hWzD2kwa/Dtfv2sC5h7yPvjdEUyrO
         U1/VL292+FT3LCT21N/yfsNY1Ekn1Xtl55jmayKlpsuvQFLB7nhmMhuQHwpa3TarLd3t
         mHx1UuJFitiwU1+OWMr3cUgbauCAr3GJez93Rv4qHn/+vfjB8cKyYAaXgaTtP7E4luhc
         aev/aPAVEdWJGRPS7d8DLAe20m2tHVUnAWoPF9TU2my/xFs5b2uXR4s0RNdne1pc9mX/
         6YLw==
X-Gm-Message-State: AOAM533yJqYXCe5X8V615/W49MP8x99MIiuatZ6yFZ1UhXL1oFzG2ttY
        xs+xmFFhdDj2t39lD0+ZWaw=
X-Google-Smtp-Source: ABdhPJxurOmQJx73avS5qDSxZgy2l0bypPpQEQJ8Hkeqw9RFWqwtfa22en2vxI+hJYWniH7PPqdLSg==
X-Received: by 2002:aca:4a84:: with SMTP id x126mr19945321oia.111.1608001438620;
        Mon, 14 Dec 2020 19:03:58 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i1sm100988otr.81.2020.12.14.19.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 19:03:57 -0800 (PST)
Date:   Mon, 14 Dec 2020 21:03:56 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Message-ID: <5fd8279ce0696_d7c482087@natae.notmuch>
In-Reply-To: <X9gT57SAHzGm3ET2@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9GbIG9vZbK1pEoi@camp.crustytoothpaste.net>
 <CAMP44s33J6F60W=2Yd2WSGE78VT0XBkewi8m3unXvathBH2TOQ@mail.gmail.com>
 <X9Lf1p++YktzZMWe@camp.crustytoothpaste.net>
 <X9gT57SAHzGm3ET2@coredump.intra.peff.net>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Dec 11, 2020 at 02:56:22AM +0000, brian m. carlson wrote:

>   - it doesn't suggest any actions that might be bad practices. I agree
>     that the instructions for auto-loading this .vimrc are more
>     complicated than necessary and might have security implications.
>     Carrying a file in contrib/vim that says "copy this to ~/.vim/foo"
>     or even "copy these lines to your ~/.vimrc" seems a lot safer. And
>     it makes it easier for people who prefer to adapt the config to
>     their own setup.
> 
> So I'm not opposed to carrying some vim config, but I think it's best to
> focus on simplicity and providing human-readable instructions, rather
> than ad-hoc plugin infrastructure.

Generally I would agree, but do you know what such instructions would look like?

In particular what instructions would look like for a person that
contributes to more than 3 projects with different C code-style.

I can assure they are anything but human-readable.

Cheers.

-- 
Felipe Contreras

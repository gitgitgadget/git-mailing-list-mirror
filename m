Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E7C63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 06:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E261264
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 06:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhGVFrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 01:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGVFq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 01:46:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8090C0613CF
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 23:27:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so2861485pjb.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xLU0mq23x8stiioj+uzlsEsPaVjjohyNag61vRDxC7o=;
        b=sedqRzwf0icuiz8pyzHyP94a4PVMEE6N8+TNXJU2zEGcJaT+bKAnD6+aMpFGSJo0BG
         0siljTQdMp0LK1z2UFTuV8317qeqJXG+5Sqh+Ppcnp6c7jC2tQsK3i0BD5UImoM3ScM4
         Js8+blw9rpuJ2+Xn0Bu8dsJb4LqaFnsVd2sZ550uNofV6klrFd7aA6tEwmxID/jnLDVA
         XpDnHd9VrSJdcLxJGFnScSWgjMZJBL8V8DmjsNFKSveFXTaVYJQE8ZdevEWfxyGtgA+c
         jgx9YdpAw+1n9JCME1oaZdg6Bvein5jEbzuoJairCl6StUivaVC72GpbI4nDU1uyYVhO
         grpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLU0mq23x8stiioj+uzlsEsPaVjjohyNag61vRDxC7o=;
        b=AoEaYJx/qePnfHQ198wZ75ldd3j18mqJWavbV9A3wq+lhD9OyrFDVO6KJA+2Z0l8HC
         krrqFv2mNR0BJGyhmjPH3jJrP/mcW4fJdWIvzLt/n5x9dtRlyBnOuwOVwDq6oMXiuql8
         QrsawSTlTa+uBS0rLQtnHc18spa04sSl/o/TTM5sKDrR2wGPkqQf0ortnezb+v+DW7ov
         GotPr3/uLAVQq3CKu8Qy5TtPp84607iaNQf0qHRFIsuvu/Jm9DEI02UB4AN7qsblFg/c
         YBy8hZSfZZs6VeKPSc+SZbtvBrACJ0B/tkRHcj7S9/M2Q4D9MK0D8NJnrNLRLJEqiyVi
         DA9w==
X-Gm-Message-State: AOAM530nZIt46Ag5ROpjpBJ4ommiyYsrvWcN+kJ817xcxP0H6Lk4ZT5J
        BqFIzj/b9RrU4kXIV0cNb1I=
X-Google-Smtp-Source: ABdhPJyNCxf3V4RYS6B1/VLWLdfawsXPB4Gj2XeSBFJ+h97SdJZ9usdkZInD6Sk2K4QwT66LfHeI1g==
X-Received: by 2002:a62:dec1:0:b029:32d:1f6:3890 with SMTP id h184-20020a62dec10000b029032d01f63890mr40149310pfg.13.1626935254265;
        Wed, 21 Jul 2021 23:27:34 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-13.three.co.id. [180.214.233.13])
        by smtp.gmail.com with ESMTPSA id v13sm1863817pja.44.2021.07.21.23.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 23:27:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3fb05d7e-fbce-5f13-406e-95218abe87f5@gmail.com>
Date:   Thu, 22 Jul 2021 13:27:29 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/21 05.22, Ævar Arnfjörð Bjarmason wrote:
> This series simplifies the http code by dropping support for curl
> versions older than 7.19.4, released in March 2009.

But INSTALL says:

>         - "libcurl" library is used by git-http-fetch, git-fetch, and, if
>           the curl version >= 7.34.0, for git-imap-send.  You might also
>           want the "curl" executable for debugging purposes. If you do not
>           use http:// or https:// repositories, and do not want to put
>           patches into an IMAP mailbox, you do not have to have them
>           (use NO_CURL).

I think it's worth mentioning minimal required curl version (7.19.4) there.

-- 
An old man doll... just what I always wanted! - Clara

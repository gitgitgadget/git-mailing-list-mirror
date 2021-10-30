Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4381C433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 12:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39F66101E
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhJ3M1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 08:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhJ3M13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 08:27:29 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8508EC061570;
        Sat, 30 Oct 2021 05:24:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso5638382wmd.4;
        Sat, 30 Oct 2021 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n5vtpGuLbWV3CAAtiuCfLxZukTrhBGK1wk/ITta9g68=;
        b=gzovDBlSZzJIGhFopwqQi4MOl7H/Be364dnK/MhVgp3E07p8zSHQi/HfddUZ475DQ4
         YTjJle/eQZsdObhoRM4h4ecjOoDgeKRb0SZn8BYphSr7ew7D7+m/a6lBtOAY/Z1VzDDV
         k7jjWhMtwuKso5cMKWKBQoSwpqkdR+NJt5kaUichQyqRtcj/OkT/OnfGA8qZ7Fr+87kl
         V5yyhJHhUOz3VyzDRbacdXg35fgwLhOIKtNpALfTJ2ZTdls7i5awhb846+MsjX7Vlz1S
         ZAEickRTz7QVk43GVHDRDOIVtDeJqoZSoQnHF4bkB1MVa8KZo+M6vzPcg57Ej0zVlSF1
         ZdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n5vtpGuLbWV3CAAtiuCfLxZukTrhBGK1wk/ITta9g68=;
        b=re5Y3TYIFAXqMgV+6ZgA/iD7gpGo+MvYxGeG65SJI4Bt5W+8nRELFqhUUwC5LJGPbp
         9EUm9gUuDnYZ0tMk5N2XBTdnoc7yGxAf8UUXOAukKqjizrtgVV3wGD3CxNE/TtlxSkCz
         Ew4hbN60NG76pswWai4t+i7lz/kM2IKzi4EIjvIQGDa/e/wqq/cKg1zxOQwykg+LQLJN
         bTm4jVQpNuWoY1hNrRCJKujmGwcnyeY1cunuCfn6n0eaPsPInTUfoeTiUy9rzGuz9di6
         zeHWRbLaawCpfNZ8hNkfeEcmlm1/uazv5/kbN3plCK3GpxO6kkOuIAwSKiywlr+EIY9A
         ovhg==
X-Gm-Message-State: AOAM533vALYxlcMZWKOVV9Ahkzg4+lF0YEXKgJdtWJcLfs2CzzVjFd2q
        a7+m7HCREtNoPyh27UqgV7o=
X-Google-Smtp-Source: ABdhPJxLtTWS3HR1G33spvL37/GL3ZcmCM1ODBLKUtjZcBgixghvpKcNDllGvDYaCIGMqa0NKaJ2Cg==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr3584110wmb.90.1635596698145;
        Sat, 30 Oct 2021 05:24:58 -0700 (PDT)
Received: from [10.8.0.130] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id n9sm7836834wmq.6.2021.10.30.05.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 05:24:57 -0700 (PDT)
Message-ID: <fd78c241-c51e-03c6-1e6b-641536245fbd@gmail.com>
Date:   Sat, 30 Oct 2021 14:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Is getpass(3) really obsolete?
Content-Language: en-US
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Libc-alpha <libc-alpha@sourceware.org>,
        "tech@openbsd.org" <tech@openbsd.org>,
        Klemens Nanni <kn@openbsd.org>,
        Benoit Lecocq <benoit@openbsd.org>, git@vger.kernel.org
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <211029.86r1c43uwj.gmgdl@evledraar.gmail.com>
 <865e5899-b991-918d-8bc6-ced65a67a566@gmail.com>
 <alpine.DEB.2.22.394.2110291627330.1788146@digraph.polyomino.org.uk>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2110291627330.1788146@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joseph,

On 10/29/21 18:31, Joseph Myers wrote:
> On Fri, 29 Oct 2021, Alejandro Colomar (man-pages) via Libc-alpha wrote:
> 
>> The broader context is that I was trying to make the deprecation notices more
>> consistent in the Linux manpages, by using the [[deprecated]] attribute where
>> appropriate.  While doing that, I found a few cases where the
>> deprecation/obsoletion is not so clear to me, such as this one
>> ([as]ctime[_r](3) is another one, since it is deprecated by POSIX, but not by
>> the C standard, but I'll start a different thread with that; and isascii(3) is
> 
> See the discussion of deprecation starting with
> <https://sourceware.org/pipermail/libc-alpha/2021-May/126356.html> (C2X
> has also deprecated those functions).  The comments in that thread
> supported marking the functions deprecated, but it needs someone to send a
> patch and I don't know what breakage might result in applications using
> those functions.
> 

Thanks.  The latest draft for C2x that I know of is N2596.  Is there any 
newer draft that I can consult for these things?  I see many proposals, 
but it's difficult to know which have been accepted and which not 
without an actual recent draft of the standard.

Cheers,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

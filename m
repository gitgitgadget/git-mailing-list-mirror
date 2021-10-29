Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C636C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15111610CB
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhJ2OrW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJ2OrW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:47:22 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E393C061570;
        Fri, 29 Oct 2021 07:44:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d3so16481452wrh.8;
        Fri, 29 Oct 2021 07:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X9JfUFySD69ZAlm7cX2XXMcyvmRiyxLOKbxqcPiQuaI=;
        b=qSltCmlUF9WRfPYMvhWViWQ90P20nfHqBgSJ6l2lhZynt0kJ/N0ciDY/EtaATHPO0H
         URHYqmREjJtJwfhVXe+AhZFEkMc1FGfXyIsR4iy5qNT9dcij9lVqtPrgouAY2/Ax573A
         WSNuPF9+QNTSp1BPPIcNvWDsi1bsDONsf5EaKnVnf4AgCczmyDfkQm/oo01TJPls0G1P
         WcL1ZZQWBk0KMeESaVg3omTQ/xZQVaz4KEpA0YLShq9JjPg6AY39xsex7Jo4ajZ/4mgK
         BrjqpWc4SHyJng7rYXu7R24Zqbi7DqPPW9dM+BBpPi/Qw12Uy8jv9zWZHjH9UQufj0YC
         1WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X9JfUFySD69ZAlm7cX2XXMcyvmRiyxLOKbxqcPiQuaI=;
        b=shXCVfqkbHq/5NCoCuKlwaItXW05FZtSUnc5gTLohJfXlxg+PysMgi+PMSQkllHCgD
         2nXVAKJxVpJGWS1WaUaxkDbNKAoRc/JF7ra4Kr095SZOMVTO9/Fg8PFWlygAgLfF8Duk
         ADf8zecAMZD6FsVuMz1sckE7vl7IjzPcBvFTcu+QzPT2MZpfqN2iWgPFJvIbQQiMhxdv
         hjHPXZGTrwgUZI7xvDssXrFgSCGsDVmDSSMdGmWRjuer7J6rHi9tQP03Y/9ntviLcxpe
         DoLcy1SqKSZeHfVLfYQXeCRRB8+FCphE6BAG3UvK/DykiCdQlKExXqKAYiE9GhxmGsyR
         pgBw==
X-Gm-Message-State: AOAM5327i95xPN7oG3TlzmzPZUqMuVHBd4UA7DCxpinNbgoixErVPTVi
        Rr9+8gQRuBxyLedS8FG+vRuqYRFr3+0=
X-Google-Smtp-Source: ABdhPJxfQmLftsafwLmjRN2t1KvHmBiDiHKuGw10lwslV89x0rXUWvKOcxe08Umz8VR0/dKEwVj1+Q==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr14655483wrs.262.1635518692022;
        Fri, 29 Oct 2021 07:44:52 -0700 (PDT)
Received: from [10.8.0.130] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id p11sm10197704wmi.0.2021.10.29.07.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 07:44:51 -0700 (PDT)
Message-ID: <326e75f9-f732-a7a8-22dc-5fc304601b39@gmail.com>
Date:   Fri, 29 Oct 2021 16:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Is getpass(3) really obsolete?
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Theo de Raadt' <deraadt@openbsd.org>
Cc:     'Libc-alpha' <libc-alpha@sourceware.org>,
        'linux-man' <linux-man@vger.kernel.org>, git@vger.kernel.org,
        tech@openbsd.org
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
 <00e401d7cccf$ccde0d40$669a27c0$@nexbridge.com>
 <73029.1635517278@cvs.openbsd.org>
 <00e701d7ccd2$058b9070$10a2b150$@nexbridge.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
In-Reply-To: <00e701d7ccd2$058b9070$10a2b150$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall, Theo,

On 10/29/21 16:33, rsbecker@nexbridge.com wrote:
> October 29, 2031 10:21 AM, Theo de Raadt will write:
>> <rsbecker@nexbridge.com> wrote:
>>
>>>>> getpass() is obsolete in POSIX.2. However, some platforms still
>>>>> are on
>>> POSIX.1,
>>>> so replacing it instead of providing a configure detection/switch
>>>> for it
>>> might
>>>> cause issues.
>>>>
>>>>
>>>> The community finally had the balls to get rid of gets(3).
>>>>
>>>> getpass(3) shares the same flaw, that the buffer size isn't passed.
>>>> This has been an issue in the past, and incorrectly led to
>>> readpassphrase(3)

That seems a good reason to keep the "Do not use it." note in the manual 
page.  I think I'll add a recommendation for readpassphrase(3bsd) for 
the moment which is the only alternative available in Linux.

>>>>
>>>> readpassphrase(3) has a few too many features/extensions for my
>>>> taste, but
>>> at
>>>> least it is harder to abuse.
>>>
>>> readpassphrase is not generally supported. This will break builds on
>>> many platforms.
I found readpassphrase(3) in FreeBSD and OpenBSD.
It is also present in libbsd(7), which is available in most Linux 
distributions.
I also found it on a Mac that I have access.

NetBSD has getpass_r(3) instead.  It is not in any other system I have 
access.


>>
>> Of course moving forward takes a long time.  If a better API is supplied then
>> there is a choice in 10 years.  If a better API is not supplied, then 10 years from
>> now this conversation can get a reply.
> 
> I checked the API 10 years from now (check the above date) at it's still not there 😉 In the meantime, compatibility is important. I checked the latest release (last week's) on my platform and readpassphrase() is not available. Let's please put a compatibility layer in.
> 
libbsd(7) is probably the compatibility layer that you're looking for. 
What system are you on?

<https://libbsd.freedesktop.org/wiki/>

Cheers,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/

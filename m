Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A659CC433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJJQdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 12:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJJQde (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 12:33:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FA75490
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:33:29 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h203so1191404iof.1
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM8o/oLTtTWZzzwhpHlQzyCWtBHb1tOeJf2f0oQDzgw=;
        b=gttKWFtC/s1pkisTs5pnGxiHezfqMLWXIbVNphY/JkALo3L0JHycdAg4mEa2s2Rl5X
         HopPMAi7En8NomUjsmWEf6coMlCMIe5O3qmjvoUvX4WrwUj/aguBC0hBkzgcN3/dlczR
         CuC3GcpcTZ6etfr50VzaKdawIjZY0Ztwux0Ld9Q7gSzBC4exrSTX5b42Dr+e3Hv8veyC
         54wQaBd/4lKzic52N78/H/rz2teTNYnvbLtgXbSvuANA3r6H3n7uV5MsSsWnhsPmHf7k
         DmXxF/vogFc/mHgttIhDNg6iIGQvJddMNLY6RfICmWbfqD9Ggb7USEMdv8QZ5CcNcell
         kLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM8o/oLTtTWZzzwhpHlQzyCWtBHb1tOeJf2f0oQDzgw=;
        b=Zo8djKDSwLeCP4LZxtuPYc8rkjRH4+THbz/UksVW7VMLJV0Dla/9oDYGQekB81X9g7
         fZ5ekDrf47dBVkaM7EOqS4TfTKRAqx6vxuJw870JCNe3HJ96p6fYaaDZseijl1SBRnvf
         yG43lG4wbcJXyAWIeD9IfCJlYtw/uFjFXo0MhRW5JSD7p9nTrdqcDHsL3/HR6Zu0ADfZ
         cTLyVAl1dwxdQZL5uulvFyptum0LijjoVo51gCBRXMpXRyJkqAMu2A2m6jMdv6Tn16vs
         eqZpid+RD0G7hAn9rINXH9duu3r5XhQsQqqtIfVByPwJQT5gaOU52cbWqYw4kUEgv1vy
         9llQ==
X-Gm-Message-State: ACrzQf1JkNx1JpkidHGBBfeRmcHMxA3921xpUPU8AoyHpNwfnygq7Bx4
        XMU6jCik5NQ02Ru23bHoF40h
X-Google-Smtp-Source: AMsMyM6GAkSTmvcxHy6fmIhc6aAfQVwb/+B00NjKhvdXo9tjBUbyzYHfaq7v2i2Ww7F5ZR7wPdnJHw==
X-Received: by 2002:a05:6638:498c:b0:363:c532:8a3d with SMTP id cv12-20020a056638498c00b00363c5328a3dmr1394143jab.291.1665419608495;
        Mon, 10 Oct 2022 09:33:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2102:4070:cf6:fed2? ([2600:1700:e72:80a0:2102:4070:cf6:fed2])
        by smtp.gmail.com with ESMTPSA id n15-20020a92260f000000b002fa7b6e9cf5sm3904844ile.31.2022.10.10.09.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 09:33:28 -0700 (PDT)
Message-ID: <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com>
Date:   Mon, 10 Oct 2022 12:33:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Outreachy] internship contribution
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
References: <CA+PPyiEvfkqZYq6uESMt3QYnfMDZDmPbGiQ5Qkeb77rtLV5Aug@mail.gmail.com>
 <CAP8UFD1o5qxSvbV05DK_J=zbU=D_+HS0Q2ufEFSQVaBoWw_7Ow@mail.gmail.com>
 <CA+PPyiF5KK6p7rv57YL_wsDO+WPifoRp1oe0F-6mo5NxLAwDWw@mail.gmail.com>
 <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2022 12:22 PM, Christian Couder wrote:
> On Mon, Oct 10, 2022 at 2:19 PM NSENGIYUMVA WILBERFORCE
> <nsengiyumvawilberforce@gmail.com> wrote:
>>
>> I see most of the articles are UNIX based, does it mean that I should
>> have a UNIX based operating system in order to contribute?
>> Currently, I have windows installed 11 on my PC
> 
> You can install a Linux virtual machine on your PC and develop in this
> virtual machine, or you can install the Git for Windows SDK from:
> 
> https://gitforwindows.org/#contribute
> 
> It might be best to install both development environments. I will not
> be able to help you much with development environment issues if you
> develop on Windows, but if it works for you, that could be Ok,
> especially if you use GitGitGadget too.

The git-for-windows/git fork has some information that is helpful
for developing Git on a Windows machine [1]. This also includes
details about recommending a Linux VM with Windows' Hyper-V system
because compiling and testing Git is so much faster on Linux.

[1] https://github.com/git-for-windows/git/blob/main/CONTRIBUTING.md

Good luck!
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CBE610A3
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 19:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbhIIT5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 15:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhIIT5D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 15:57:03 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D164C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 12:55:53 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso4012818ott.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 12:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fyGO8GJUKeR20sHl6ZOXFiFNbL0ND3jpXK4J6+PmBWA=;
        b=Mhuug3q/MHBjE0S7uZMEdufXxW8tH9U9zpRIxhsUvp8Ww0XUVdv/N0yb17XWVu2Vem
         AG8QWRWff+YMPJsyhD4S468xA8UeK9Q2nOf+K+zYGqe2cMpcmdddlKVPxeBQlry9pQ/v
         xbav/WPhG8O2Vpe6wxoOPGoeP2CddJqsjZOg8jzNvD9+Xj4KohJHrxNicvrbb1s9p76p
         55aFN1RFXN1ADq5P3YeEpsjE7rzH5XqS728VK7vsr12+iU0L06jba3W9S7R6vYXhhgIe
         oMutQrTkLQpWl0ZMjzGBjUKDhnSk9WzAgNVnH1hwljlP3sIb8pNrCyRr7nhbnQk0E/MB
         BSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fyGO8GJUKeR20sHl6ZOXFiFNbL0ND3jpXK4J6+PmBWA=;
        b=VtilxAYXFmfbdNueZ5azauRLOva2Ly5IIhsSdlnSwgcBNCjo4y3rf+TyLY0w3YGZiO
         sVxuENct+P3eXg6m0SVf1bvOZydcP1ONTXYRPrrKCD69sSrnTfb26BHe89WHTlCcJlyh
         jhf8u9TuSEP8QuxdqHiTK0l2Ww3jRtUBvzl5b+QYMqeGyyZflDZcvlO21Ynwx9cPGelJ
         tSy+QbTaqibUPfqiPa/1T0R8uWuUN6poqVQ3A6qOluFFQWMGzAoW73UD4c8iVaG/wXFX
         0bYU/KETPka/X7XtMRiDtP5xdMGnVkZ2dnOMuN7mXqKK2k1PrMTTExuIIP/y0UNCF8MP
         T7Uw==
X-Gm-Message-State: AOAM533Lgmwy67GJ108ervydrAZjKPzV1yZ3GJNARNyMgin2cO+Ijh5Z
        EDHHZ0VGC+Wu4OBWx/mmGmE=
X-Google-Smtp-Source: ABdhPJyBF6Dw64cv8qd0O1j3y6eJL+m8ZvWXnQR32u+fqSwG8808mvIgJmN54BbkF2a+jEfoEKGvXg==
X-Received: by 2002:a9d:ea5:: with SMTP id 34mr1385067otj.258.1631217352844;
        Thu, 09 Sep 2021 12:55:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4481:ae58:ef22:e37c? ([2600:1700:e72:80a0:4481:ae58:ef22:e37c])
        by smtp.gmail.com with ESMTPSA id q13sm694847ota.17.2021.09.09.12.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 12:55:52 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20210827210255.12565-1-lenaic@lhuard.fr>
 <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com>
 <4c0c1fd4-f3f4-5e3a-abd2-0350c18b18b7@gmail.com>
 <1749747.rkkkC1iLqI@coruscant.lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d1a8684-65c9-5229-0cd5-2e3f4a0914f3@gmail.com>
Date:   Thu, 9 Sep 2021 15:55:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1749747.rkkkC1iLqI@coruscant.lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2021 1:52 AM, Lénaïc Huard wrote:
> Le mercredi 8 septembre 2021, 13:44:26 CEST Derrick Stolee a écrit :
>> On 9/7/2021 12:48 PM, Derrick Stolee wrote:
>>> On 9/4/2021 4:54 PM, Lénaïc Huard wrote:
>>>> Hello,
>>>>
>>>> Please find hereafter my updated patchset to add support for systemd
>>>> timers on Linux for the `git maintenance start` command.
>>>>
>>>> The only changes compared to the previous version are fixes for the
>>>> two typos in a comment that Ramsay Jones pointed out [1]
>>>>
>>>> [1]
>>>> https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ramsayj
>>>> ones.plus.com/> 
>>> The changes in the most recent two versions look good to me.
>>
>> I recently tested the 'seen' branch for an unrelated reason, but found
>> that the t7900-maintenance.sh test failed for me. It was during test 34,
>> 'start and stop Linux/systemd maintenance' with the following issue:
>>
>>   + systemd-analyze verify systemd/user/git-maintenance@.service
>>   Failed to create /user.slice/user-1000.slice/session-44.scope/init.scope
>> control group: Permission denied Failed to initialize manager: Permission
>> denied
>>
>> Now, this test has the prereq SYSTEMD_ANALYZE, but for some reason this
>> later command fails for permission issues. I'm running Ubuntu, if that
>> helps.
> 
> Thank you for the feedback.
> 
> Could you please share which version of Ubuntu and which version of systemd 
> you are using ?
> 
> I’ve just tried to start an Ubuntu Impish 21.10 which uses systemd 
> 248.3-1ubuntu3 and to test the `seen` git branch.
> 
> All tests of `t/t7900-maintenance.sh` passed including the one which is 
> failing for you.
> 
> As `systemd-analyse verify` should only check a unit file validity [1], I 
> wouldn’t expect it to fail on a cgroup manipulation.
> 
> [1] https://www.freedesktop.org/software/systemd/man/systemd-analyze.html#systemd-analyze%20verify%20FILE...
> 
> I tried to run 
> systemd-analyze verify /etc/systemd/system/sshd.service
> and it didn’t produce the error you mentioned but if I `strace` it, I can find:
> 
> mkdir("/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-3.scope/
> init.scope", 0755) = -1 EACCES (Permission denied)
> 
> This makes me think your version of systemd is wrongly considering this cgroup 
> directory failure as fatal.
> I’d like to know more precisely which versions are affected.
 I am on Ubuntu 18.04.

$ systemd --version
systemd 237
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid

I tried upgrading with apt-get, but that did not get me a new
version.

Thanks,
-Stolee

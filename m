Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28569C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 13:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2631239A1
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjKT/iR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIVNiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 09:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVNiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 09:38:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E58C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 06:38:07 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so3376092wmj.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XIVRWNhNIzTqV7XdUHf3xszDc9QJ6KATzz2BsbkWvQ=;
        b=hjKT/iR8vdMFf0Jm+ffkXsfc/1Tu8p2/oMIyy3TQeC3kMLA2XAFMkwX42r1HCFy0Zi
         +CkyBNrtJ4OhhPXeSXe/tynDcZOOWsfO6u86HvnVGD8d+nwAIV7K/Qgb+V0fzxwtJvIM
         XHdo7nRhe/4Rl5vDs3Ssm3KfhatW9sCaD2v+/242JK3WpA5jyL8ZE0zntXftErLFqRi2
         KnR+ri1wyop05WDThaq+Sw0rBGbbzCKxpuQcRkn/xUUH/oWryTqUDH0HdQd3xygvv8Qd
         IbVXiIoPeAtBnLKT23Mndsxu7Y7e5vYyu+1MunF0+W0xbWwLAe++4WnH4HmtK6kOfuLV
         BAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2XIVRWNhNIzTqV7XdUHf3xszDc9QJ6KATzz2BsbkWvQ=;
        b=VCzT2WcllBbEkdzjTnmKdNk2Di8M3j6t9veA/2pk7XFIzySvUgFEMSTCGnIaOnlcbo
         CJbXD7UzVkclCOpqZ2BAQSIVnkQRDOV6j+zl4fK/HSLgeuCWb6mDo92JKL/nPo68oWHs
         4/ntrdwA9bN/1Rqu8eAmk1tf2+dNQ4hq9copMSEW8GMt5VpOfmlVVdVx1aT+hn452Gxx
         Mee5+1vXP9Ws1cMxc3G2D6q7kkD9Z1+q0RxTnmGlcJRQO0Mo2jxJYrNGQzfyhwpbWyJu
         4oCdvI0f0mpJJXvdnS5WPCX/ccbmzSnrQV7RmQACxyM5RSXhsYFjL7UdP8zsgAmpqqZ6
         uGpg==
X-Gm-Message-State: AOAM531wfgMXydNcQqT+XmKNp2izAi8h5uh5onagFuPmptlRX3ZSpdcW
        oACTTzyAHOrKuUHFe+GEOog=
X-Google-Smtp-Source: ABdhPJyJ1T8bLyMHJkl5F2n3iwFLLjvwrhn2cWbq0VEu6vH9Uv94zdQJZLYYdrt3qJjvq04P/9G25w==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr1186689wmi.140.1600781885847;
        Tue, 22 Sep 2020 06:38:05 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id f14sm5107094wme.22.2020.09.22.06.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:38:05 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
 <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
 <CAPig+cQNiB8nw-JwwFweHzeFYcozGA06pPKr=0N9Metp8PBbSQ@mail.gmail.com>
 <6da3752f-5e45-1381-b54c-64a81d642b72@gmail.com>
 <xmqqeemvexr1.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <52217e7a-5a51-48e4-5496-96ac68602200@gmail.com>
Date:   Tue, 22 Sep 2020 14:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqeemvexr1.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/09/2020 20:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>> diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
>>>> @@ -713,4 +713,60 @@ test_expect_success '--dry-run --short' '
>>>> +test_reword_opt () {
>>>> +       test_expect_success C_LOCALE_OUTPUT "--reword incompatible with $1" "
>>>> +               echo 'fatal: cannot combine --reword with $1' >expect &&
>>>> +               test_must_fail git commit --reword $1 2>actual &&
>>>> +               test_cmp expect actual
>>>> +       "
>>>> +}
>>> These error messages are subject to localization, so you'd want to
>>> use
>>> test_i18ncmp() here, I think.
>>> Same comment for other new tests.
>>
>> I decided to use the C_LOCALE_OUTPUT prerequisite and test_cmp rather
>> than grep so I could check the exact output.
> 
> I do not think it is a good idea.  Dropping the C_LOCALE_OUTPUT
> prerequisite and using test_i18ncmpw would be more appropriate.
> 
> A test run without GIT_TEST_GETTEXT_POISON will do the byte-for-byte
> comparison like test_cmp.  It is only the poison test, whose purpose
> is to catch commands that by mistake translated their messages, that
> would want to mark a test that checks end-user facing messages like
> this one as special with test_i18ncmp.

Thanks I wasn't aware of test_i18ncmp

>> ... I should probably check that nothing is printed to stdout in
>> these tests
> 
> Perhaps, but that is not the point of "do we diagnose options thare
> are incompatble with --reword?" test.

I think it depends if one views the test as checking "do we diagnose 
options there are incompatible with --reword?" or "what do we show the 
user when there are options that are incompatible with --reword". For 
the former we just want to check that the correct error message is 
printed, for the latter we want to check that only what we expect to be 
printed is actually printed.

Best Wishes

Phillip

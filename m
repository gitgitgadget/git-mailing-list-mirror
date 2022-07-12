Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14AC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiGLQCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbiGLQB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 12:01:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58761C636F
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:01:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso11907922pjc.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Kf1ZrTxsNquj+8HmY+9BNF8akGssrqY/D2f970GbMw=;
        b=c+ir5RdU49udOWl3bnAyRZqMen0qNJ3RZQKqKEgtjZd3ZJ8Dz2w4BgzrumlV3fg7wJ
         +C04Nw+65NMDlsk5QoAyshtCDndHPqSsRXWCy47nWXp+KIzOHUV0fAeACT8tM6bHL9Qr
         wEoQts4lQ7VNtNwa1o1xVUpXgZU3v1dA6eE+NLG+GrctRsYzhRRwg3of5R/XhD2PP10c
         e0Op1uCxsZB56iq073yGsZAfnpN11RFN65OxLrek1p6sberJumkEl8IhpaYOcOz+s1sP
         85Cf4y/SwznGC137DLKzMNsoHOj4toyj9eAxWbG5PiAHhXDHIhdDJM6KdGWGRGAKZ0JI
         DCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Kf1ZrTxsNquj+8HmY+9BNF8akGssrqY/D2f970GbMw=;
        b=MO1iKuTlUsA4jw3tyfwPzQgROs46uia5Ev5p8HqWD4vg46TExbzMK2WBbgzPkCX58m
         MY8lBaWFoGC4Kzm+GeJUkHtvFycg8iF1AkRwG6IOm4Em7CK0G3t+g3CbzDmLWZcf6Zkb
         VfLutkgWiiatsAZm1DMLgXQCQsubLELavJeo+coBwdTDaFOm81WK5U1Y6d1IudW2ChJv
         J4VUnh8kbUNJ7JifR1opAPq5Qn6FlDPLpwUTnlaSTcRiY0SvdIqUyGpuVAz4Hk+XBtLw
         f+oYpboCpT8Zl9+yIxQY7GC9EnogVouG4CsfuTx6rajK1QiV+6ggzLiNdR1pwqplceDn
         8W0Q==
X-Gm-Message-State: AJIora/b7qDRHu3S60IZsDD8uaBj1ZIdFEOmX+oX5WpcETYBJcoE0ZjT
        5/8S2KVAjBCbrju9OKVJIrWmD1hLS8byzN0m
X-Google-Smtp-Source: AGRyM1tcGVfgl5WJQh5m7tK4sUmVAqAtFvkp8V/Buo9iWZiNH/fX57QmJJalX0hAQoJb7Pg7KZ9LUg==
X-Received: by 2002:a17:90b:4f4a:b0:1f0:65d:d888 with SMTP id pj10-20020a17090b4f4a00b001f0065dd888mr5296194pjb.136.1657641717658;
        Tue, 12 Jul 2022 09:01:57 -0700 (PDT)
Received: from [192.168.1.7] ([223.230.62.254])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b00163ffbc4f74sm7112058plk.49.2022.07.12.09.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:01:56 -0700 (PDT)
Message-ID: <3167df9e-574c-cc00-1e00-43e81b049b6f@gmail.com>
Date:   Tue, 12 Jul 2022 21:31:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/4] Add support for mailmap in cat-file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        congdanhqx@gmail.com, christian.couder@gmail.com, avarab@gmail.com,
        johncai86@gmail.com
References: <20220707161554.6900-1-siddharthasthana31@gmail.com>
 <20220709154149.165524-1-siddharthasthana31@gmail.com>
 <xmqqv8s5sf8x.fsf@gitster.g> <50s3714q-8p5n-2379-65r4-17304426rp93@tzk.qr>
 <xmqqwnciifgv.fsf@gitster.g>
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqwnciifgv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/07/22 19:46, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> This patch introduced new test cases that rely on the side effects of
>> the earlier test case `set up symlink tests`. However, that test case is
>> guarded behind the `SYMLINKS` prereq, therefore it is not run e.g. on
>> Windows.
> 
> Ah, that explains why it only fails there.
> 
>> Let's fix that by removing the prereq from the `set up` test case, and
>> adjusting its title to reflect its broadened responsibility.
>>
>> -test_expect_success SYMLINKS 'set up symlink tests' '
>> +test_expect_success 'set up symlink/--use-mailmap tests' '
>>   	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
>>   	echo "New <new@example.com> <orig@example.com>" >map &&
>>   	rm -f .mailmap
> 
> OK, this sets up
> 
>   * one commit that can be used in a test, authored by "Orig" person;
>   * the "map" file that maps the "Orig" person; and
>   * ensures .mailmap is not there.
> 
> with the intention to make a symbolic link that points at the "map"
> to use as the mailmap file in later tests.  This step does not require
> symbolic links at all, but because the point of this set-up is to serve
> the later tests, all requiring symbolic link support, it was OK to have
> the prerequisite.
> 
> The cat-file tests does not have to use the "map" file to do its
> thing at all.  In fact, these tests prepare their own .mailmap file
> inside them.  But because it chose to run in the history prepared by
> previous tests, it broke, because without SYMLINKS, the sought-for
> commit does not get created.
> 
> Makes sense.  I would have retitled it to s/set up/prepare for/ but
> that is minor.
> 
> Thanks.  Siddharth, please squash the fix in when rerolling.
> 
Thanks a ton Johannes and Junio for helping me fix the test :D
Will squash the fix in v4!

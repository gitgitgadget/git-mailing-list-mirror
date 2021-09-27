Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D39FC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7584E61166
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhI0J0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhI0J0L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 05:26:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA6C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:24:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c21so20811862wrb.13
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z9XTytBPegBaUaDSIDRMNudZMavDQGUjCIlJcYLXaMg=;
        b=AT0RU4SgSVnDAnxKU6M91yHQFYIRFpAc2waLEjbqPcsilEQC9Ugatg8TxT1z989jGm
         Nb4Um3GMxdR+SJ3mGJ26Zk2ccp6UnXzCEgsZWulkG1R6aW8RgVyyU+iJPicG91ozFLAW
         jCOjVJpQlH0ossxXaXl+YxMLHJlOdU2Clpbyqm4XJEQNSNKwooY2cFa1uYT8VwFkQoW3
         7mj5mZ2GFnsRHyCozdp2akiOpWYDG1VJaRSxbK4c1lQns8ylKPCxsp8eXjeLpchsxY6E
         qk1o+ydvVA0/pERtc3y7NiYpIl9TKvoxI3G2mXGa4KeDTM5O9pC26cOkV2utVFibFPER
         g2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z9XTytBPegBaUaDSIDRMNudZMavDQGUjCIlJcYLXaMg=;
        b=TguBUEg4gI/z8LawyW+c9agTNKsahvoVqz/Dry31nhO+TnhKkbtcDMn/kMqEzkxj2/
         RojT7EHHo+9HmnMGxt9bmhaA/WG+QTzqCAOMQUBxmRaxEgwcmk1LyupXFrUaG76foBts
         aV7xQxnRHH9S0vJfD/spIMnp9X035SntA7rjfmdksKU+k7nTJl58QnywhRv9w8wxhdZN
         IrbzGrzos2b7sW4XQQlo/l34O5QFmH+sxqJ2x/xP/X+kVToRYj8PQ5D0TcKiDeF/txUi
         nj6EtQEFbntwvTyfejuqL5xsd7lOXriO96QCaKFXYpU4hcXxrU5zzgi1TsRkTcwSyqDG
         F+jg==
X-Gm-Message-State: AOAM530YzMqr8691M1qklQiml7pw2CuimdAPYbVfTO/LwvVNg6urjISB
        qqwAKo+ZjvEx558l9ayeMGc=
X-Google-Smtp-Source: ABdhPJymaR9v7n4yCyhbpXfeqrxPjwLXNUkgPqMS2qI62WyKOo3xFPBLHh57gKXm1udd+SaUmYS7Sg==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr14565351wme.13.1632734672226;
        Mon, 27 Sep 2021 02:24:32 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id k19sm15612250wmr.21.2021.09.27.02.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:24:31 -0700 (PDT)
Message-ID: <e0feb87e-4f8e-04c7-5533-3b10d82403e4@gmail.com>
Date:   Mon, 27 Sep 2021 10:24:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
 <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
 <92471ff9-7573-c3e4-e9fd-63a5cbf5738f@gmail.com>
 <87fstt3gzd.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87fstt3gzd.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/2021 20:30, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Sep 24 2021, Phillip Wood wrote:
> 
>> Hi Ævar
>> On 23/09/2021 11:30, Ævar Arnfjörð Bjarmason wrote:
>>> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
>>> new file mode 100755
>>> index 00000000000..6d4e56d1a31
>>> --- /dev/null
>>> +++ b/generate-hooklist.sh
>>> @@ -0,0 +1,18 @@
>>> +#!/bin/sh
>>> +#
>>> +# Usage: ./generate-hooklist.sh >hook-list.h
>>> +
>>> +cat <<EOF
>>> +/* Automatically generated by generate-hooklist.sh */
>>> +
>>> +static const char *hook_name_list[] = {
>>> +EOF
>>> +
>>> +sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
>>
>> POSIX does not support using a semicolon after a closing brace [1],
>> grepping our code base with
>> 	git grep 'sed .*};' '*.sh'
>> does not give any matches so I don't think we're using that pattern
>> any where else. Replacing the semicolon with ' -e' would fix it.
>>
>> Best Wishes
>>
>> Phillip
> 
> Does this fail on any system you're aware of? If so what OS/version (and
> preferably version of "sed").

I'm not aware of any such system but I rarely use anything other than 
linux. As this departure from POSIX is not already in the code base I 
thought it was worth flagging it. I did wonder if it would be supported 
by the various BSDs but you testing shows it is actually quite widely 
supported.

Best Wishes

Phillip

> René's downthread <d5f297d4-9c64-1ff9-8422-054979bf8cfa@web.de> seems to
> suggest that this is fine.
> 
> Both beforehand and just now I've tested this on AIX, Solaris,
> {Open,Net,Free}BSD, HP/UX, OSX and Linux (a few distros/versions).
> 
> All of them are able to generate the same hook-list.h using this version
> of the patch.
> 

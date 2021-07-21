Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C893C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E654D61222
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGUXNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhGUXNp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:13:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C79C061575
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:54:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l1so4537891edr.11
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=s/rFxv1j2hv6D0soCLAb5KHPhZSxQTmpgl9CwaXCjdc=;
        b=Svb6ewrIs2jSHq6K/r+S7OZxoa7Xq4R5bJ2dEtV6XxzW0JR1i/YfeWA8f0yX1vFLNG
         sO/MB2jkKaz9Z2MFt+oUeT8I2Babrpbw38GpwQgaFT1yYANaMHAGPV5ap4DQIxYhv/8a
         5mMAZ63uTia8i/j15xJk8sHFgSGgNlUBWUiweDGRytwH6s0SRv8OJo1FAUWZj80BCXSK
         pbEZPG4cAldwcaT/Yrsxxzpnsmun/zqYy6lIBj9FuvH10HG1nq4D0nbJhD064SdWTDBb
         FrRZ8T4fJGpnQ+KIu2JNMOTWW0uTb1OaqmlklbGXAO9dMJ9za5lXxLnAz0+Tr1+ztywt
         A03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=s/rFxv1j2hv6D0soCLAb5KHPhZSxQTmpgl9CwaXCjdc=;
        b=if40snotq7+Sy7sOoPVUWBevcQxrK9iGIxrv4PBVhFWRcVMtX5eZA9r2HISEg8zSY6
         jpBXBEYTb76aX9W/8i15o6wnpimZ2MJ09IXzVB+FJtU8n/JlPCzzBsOpNTljHboICCFK
         S5lyVwQkL/CpUN1sffTM7yiNvTiQ84/BxyAlRfsKj62ddYlz2Z2IVWk4Vm60whu68eZC
         0xjk0zuQFsmUwPiScCUWOS52M5qwk5aeQv8cTwfKefEvsznjprIabVFdmvycUaxyQLX7
         OedsyoQfQvh9p+d14AIB0I2xKaVkzZ8hmMkqZV9MyU9PUHk28PpmAa0MSmdsLjDFflmv
         Hm6A==
X-Gm-Message-State: AOAM530XcstuIpWTJWPcoUW7kcnwMPyfIgma979BeztAoa9BWu8XGzYg
        4cgUx6dfSUABOGHJeW9p6N4=
X-Google-Smtp-Source: ABdhPJzAPT4Wr9NJsqXcEM5d+bD/B8J3IjksqepnafwcEbVRZ8A+l0l8ityVgrZX5axX+WWpEKZWxQ==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr51160898edt.381.1626911658872;
        Wed, 21 Jul 2021 16:54:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m15sm11459184edp.73.2021.07.21.16.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:54:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] bundle tests: use test_cmp instead of grep
Date:   Thu, 22 Jul 2021 01:53:54 +0200
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <patch-2.2-062f34abf1a-20210720T115052Z-avarab@gmail.com>
 <YPcE24InpY4evFyE@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPcE24InpY4evFyE@nand.local>
Message-ID: <87fsw7ussi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 20 2021, Taylor Blau wrote:

> On Tue, Jul 20, 2021 at 01:52:09PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> So let's use test_cmp instead, and also in the other nearby tests
>> where it's easy.
>
> I took a look at this patch carefully to make sure that this
> transformation also improved the readability, too.
>
> Looking around, I think that this was a good improvement in readability,
> but also hardened the tests (for the reasons that you mentioned). One
> tiny note below.
>
>>  test_expect_success 'empty bundle file is rejected' '
>> @@ -67,11 +83,33 @@ test_expect_success 'ridiculously long subject in bo=
undary' '
>>  	printf "%01200d\n" 0 | git commit -F - &&
>>  	test_commit fifth &&
>>  	git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
>> -	git bundle list-heads long-subject-bundle.bdl >heads &&
>> -	test -s heads &&
>> +	cat >expect <<-EOF &&
>> +	$(git rev-parse main) HEAD
>> +	EOF
>> +	git bundle list-heads long-subject-bundle.bdl >actual &&
>> +	test_cmp expect actual &&
>
> This is quite readable, but the assertion below gets much more
> complicated as a result of the change.
>
>>  	git fetch long-subject-bundle.bdl &&
>> -	sed -n "/^-/{p;q;}" long-subject-bundle.bdl >boundary &&
>> -	grep "^-$OID_REGEX " boundary
>> +
>> +	cat >expect.common <<-EOF &&
>> +	-$(git log --pretty=3Dformat:"%H %s" -1 HEAD^)
>> +	$(git rev-parse HEAD) HEAD
>> +	EOF
>> +	if test_have_prereq SHA1
>> +	then
>> +		cp expect.common expect
>> +	else
>> +		echo @object-format=3Dsha256 >expect
>> +		cat expect.common >>expect
>> +	fi &&
>
> Here we're setting up expect, but I think flipping the order might make
> things a little easier to follow. Maybe something like this:
>
>     rm expect &&
>     if ! test_have_prereq SHA1
>     then
>       echo "@object-format=3Dsha256" >expect
>     fi &&
>     cat >>expect <<-EOF &&
>     -$(git log --pretty=3Dformat:"%H %s" -1 HEAD^)
>     $(git rev-parse HEAD) HEAD
>     EOF &&

Thanks, I used pretty much that as-is for v2.

> Or, if you wanted to go further, you could do something like:
>
>     cat >expect <<-EOF
>     $(test_have_prereq SHA1 || echo "@object-format=3Dsha256")
>     -$(git log --pretty=3Dformat:"%H %s" -1 HEAD^)
>     $(git rev-parse HEAD) HEAD
>     EOF
>
> which is arguably a little tighter (although I find the
> echo-in-a-heredoc thing to be kind of ugly).

This one won't work because you'll have an empty line at the start under
SHA-1.

>> +	if test_have_prereq SHA1
>> +	then
>> +		head -n 3 long-subject-bundle.bdl >bundle-header
>> +	else
>> +		head -n 4 long-subject-bundle.bdl >bundle-header
>> +	fi &&
>> +	grep -v "^#" bundle-header >actual &&
>
> Here I would suggest getting rid of the bundle-header intermediary and
> instead writing:
>
>     if test_have_prereq SHA1
>     then
>       head -n 3 long-subject-bundle.bdl
>     else
>       head -n 4 long-subject-bundle.bdl
>     fi | grep -v "^#" >actual
>
> and then having your

Thanks, used that.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 15:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhLHPRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 10:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbhLHPRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 10:17:37 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1906FC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 07:14:06 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso901125ooa.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 07:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+Vp23cVyghUMOCTRknBikMJ8QxbeVabeGYuwPdkE5FA=;
        b=XxYfhrdAazHbF9C8p9DTg4xCypF/OXowx+vckUN6HU4d7QA7PtA/+8ch8kOVYwvXiw
         B/LaJ1mpNixfX8nfPFjkU8gnRb4m4PVTeh9qB38dpinT2HTpRQpN5KgjtyH9pE3E6IPc
         P3eT41neuchP4OyMA9kdVt+8HskfsFaoQPkkKKDhbl13cAQ3rOK5sUb6Tvnt4zMp78hm
         4Dv8PNW0Mrf2P+xdGVxY9Izw5Er3cbg9zXkdMFRu2z6AldzOvglzb2NEfWGGVYJLs9oo
         AJgQIzzP34LB8pj7jKUx33TErZl87fO4LFvIMAQBW7EIZXKzj5+ALnO/544LKiS3Vg5U
         zWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Vp23cVyghUMOCTRknBikMJ8QxbeVabeGYuwPdkE5FA=;
        b=lJjC5fRfGYroyn659nc/Vfz8tCzyYSkYY/9wfsFAlSA5mcrNeEmtx2FM+OLpEmTDwt
         DGvFq/AeZHeguFz2GG0ACDHdEEf0ldCm95Kq0WNR1zphG4C67aIDZA160Gof88kT+38Q
         0C5WqXBR6PsmhdxCQty5p600WVJNf4fCbrzuKLhr/ceGl9xVjc3ElnOiQ4NYSFZH8sE0
         7D5b5oR0nhv9e+yH0THdDBsCiVbN1o2xmSi5g3dxHmT+GjtDeK87/33E6aW9k/ss7vqG
         TkGFEianMvjYMcvAxWouQhHanG94DIOU1Hub+f0DOVJCDtQ9pgO8CmCCJAi8PSRhAez7
         jyVg==
X-Gm-Message-State: AOAM531JBix4pJWaS9rN3dQIxKahX2zpinYxxzaked7OUZwsuEqgt58z
        LgDLmr+onyL7jjoXkDW0zm0=
X-Google-Smtp-Source: ABdhPJz+M6C+ZuSOj5MKkGeGqWVYxXpiRU65obYsdMZ28/DleGkiL046zhceCQU11wv1g+EcYygqRw==
X-Received: by 2002:a05:6870:a70d:b0:a8:8535:5975 with SMTP id 586e51a60fabf-a88535694fmr90426fac.92.1638976445063;
        Wed, 08 Dec 2021 07:14:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5056:be20:f10c:bfd5? ([2600:1700:e72:80a0:5056:be20:f10c:bfd5])
        by smtp.gmail.com with ESMTPSA id h26sm506003oor.17.2021.12.08.07.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 07:14:04 -0800 (PST)
Message-ID: <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
Date:   Wed, 8 Dec 2021 10:14:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2021 9:07 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 16 2021, Derrick Stolee via GitGitGadget wrote:

Things in the dependent topics are starting to simmer down, so I'm
back revisiting this topic.

>> From: Derrick Stolee <dstolee@microsoft.com>
>> [...]
>> +test_expect_success 'ls-files' '
>> +	init_repos &&
>> +
>> +	# Behavior agrees by default. Sparse index is expanded.
>> +	test_all_match git ls-files &&
>> +
>> +	# With --sparse, the sparse index data changes behavior.
>> +	git -C sparse-index ls-files --sparse >sparse-index-out &&
>> +	grep "^folder1/\$" sparse-index-out &&
>> +	grep "^folder2/\$" sparse-index-out &&
>> +
>> +	# With --sparse and no sparse index, nothing changes.
>> +	git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
>> +	grep "^folder1/0/0/0\$" sparse-checkout-out &&
>> +	! grep "/\$" sparse-checkout-out &&
> 
> I think all of this would be much clearer both in terms of explaining
> this change, and also for future test relability if it did away with the
> selective grepping, and simply ran tls-files with and without --sparse,
> and then test_cmp'd the full output (after munging away the OIDs).
> 
> I.e. the sort of output that's in my just-sent reply to the CL:
> https://lore.kernel.org/git/211123.86lf1fwrq5.gmgdl@evledraar.gmail.com/
> 
> We really don't need to optimize for lines of tests added, and having
> ~30 lines of plainly understood diff output is IMO preferrable to even 5
> lines of tricky positive & negative grep invocations that take some time
> to reason about and understand.
> 
> I.e. something like:
> 
>     cat >expected <<-\EOF &&
>      100644 blob OID   e
>      100644 blob OID   folder1-
>      100644 blob OID   folder1.x
>     -040000 tree OID   folder1/
>     +100644 blob OID   folder1/0/0/0
>     +100644 blob OID   folder1/0/1
>     +100644 blob OID   folder1/a
>      100644 blob OID   folder10
>     -040000 tree OID   folder2/
>     +100644 blob OID   folder2/0/0/0
>     +100644 blob OID   folder2/0/1
>     +100644 blob OID   folder2/a
>      100644 blob OID   g
>     -040000 tree OID   x/
>     +100644 blob OID   x/a
>      100644 blob OID   z
>     EOF
>     git [...] ls-files --sparse >actual.raw &&
>     [munge away OIDs] <actual.raw >actual &&
>     test_cmp expected actual
> 
> Would test everything you're trying to test here and more (would need 2x
> of those..), and would be easier to read & understand.

I don't think it is that hard to understand "I expect to see these
lines and not these lines" but I am open to more fully verifying
the full output and demonstrating the change that happens when the
flag is added.

Taking your idea and applying it to 'ls-files' (without --stage to
avoid OIDs which would change depending on the hash algorithm), the
start of the test looks like this:

test_expect_success 'ls-files' '
	init_repos &&

	# Behavior agrees by default. Sparse index is expanded.
	test_all_match git ls-files &&

	# With --sparse, the sparse index data changes behavior.
	git -C sparse-index ls-files --stage >out &&
	git -C sparse-index ls-files --stage --sparse >sparse &&

	cat >expect <<-\EOF &&
	 e
	 folder1-
	 folder1.x
	-folder1/0/0/0
	-folder1/0/1
	-folder1/a
	+folder1/
	 folder10
	-folder2/0/0/0
	-folder2/0/1
	-folder2/a
	+folder2/
	 g
	-x/a
	+x/
	 z
	EOF

	diff -u out sparse | tail -n 16 >actual &&
	test_cmp expect actual
'

I can make similar adjustments throughout the test to match
this style.

Thanks,
-Stolee

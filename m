Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A5C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiF1Reu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiF1Res (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 13:34:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6DD2DD50
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 10:34:45 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id p10-20020a631e4a000000b0040d2af22a74so6890302pgm.5
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=iYixbFiHPC2YUHtS4eTp1S16DiKJfhT/WJGRX6S3KQk=;
        b=YLM2lDvFN4CcF0Fp2IHyyrfAlpjb0bhmCPDgRbQA2u6E1ePpkWVJ/ZAdsNUCFy2w/m
         4zZA04GXGGO6iWrzFutnaR5qCtQBwAf7PN+Vacuk789e9mieFsL6LzQIRYBT7h5WtznO
         AwP3cRiD3A7WqkDGSfiXEjnKWolkWCMNtQoiOxDK6a+BzDPAILGUCyqi0F727xyIn97a
         dLuWcndtj4bBvUIDOC124hwxDL5+USmHGXmDedGxtC+Pq4UOuZWTlb72RmrOxnW/W1rp
         dNZU035oHFhoooGbUGgrILIwiDWLZK5VhPq+bKVjuAo5pinS1s9yiT4Iaa6T5YFdT/wg
         ouXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=iYixbFiHPC2YUHtS4eTp1S16DiKJfhT/WJGRX6S3KQk=;
        b=O4k4KSMb+3v9h5fB6Yyzv0/SnhJO2feK40XJMaQjLIBMQDGew43WDw/jTHEc7BpEKj
         HdVOxnyk5jXfBkylN55EwEYd9d3vncJBnegwbdxJgKXUX83vT4AR+mwM/+BNxABa8gUt
         F7F5SSSRiD991ureBqNw02KWW8sxu8LZeMMUJP5c1LttKUC0FdAPAnRVeZpeILUqu/e4
         rV2K1w6yMdcbVZ5om7j4KYYtLDRRFRphF6mjh7Ukj6HeBZq7bcm1I/6vbqA7w1jmZO73
         mWR9b2z++0EKysDCpC0BNFzQ1L3YYndjUf0t4MB/pikv9WsZf7Z1lBWswaA44GlMeiJt
         7uNg==
X-Gm-Message-State: AJIora/AiTNJ+lzKVTv4Aynu4vUHjc+ybSsu432iTNqIcGLa1VmaRov9
        7FKxuxF8TgB2dBZJqIssTKd2GS4FcVvBvw==
X-Google-Smtp-Source: AGRyM1sANBQrRBl6gZVnhDNX8IBpoOfmkhubi0DgnTfX1YrBA1i0pbrfLwl+0H3CuOU4qjLu0ShWcJ5vjeSaLA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:22c9:b0:16a:749b:16d6 with SMTP
 id y9-20020a17090322c900b0016a749b16d6mr4754991plg.32.1656437684552; Tue, 28
 Jun 2022 10:34:44 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:34:42 -0700
In-Reply-To: <220628.861qv9gpg5.gmgdl@evledraar.gmail.com>
Message-Id: <kl6ly1xghetp.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <473548f2fa473b9b94fcc099a81613c622a32022.1656372017.git.gitgitgadget@gmail.com>
 <220628.861qv9gpg5.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 1/5] submodule--helper update: use display path helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks! Everything not mentioned here seems like an obviously good
suggestion. I especially appreciate the translation/compiler flow
analysis pieces (I hadn't considered either).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> There are two locations in prepare_to_clone_next_submodule() that
>> manually calculate the submodule display path, but should just use
>> do_get_submodule_displaypath() for consistency.
>>
>> Do this replacement and reorder the code slightly to avoid computing
>> the display path twice.
>>
>> This code was never tested, and adding tests shows that both these sites
>> have been computing the display path incorrectly ever since they were
>> introduced in 48308681b0 (git submodule update: have a dedicated helper
>> for cloning, 2016-02-29) [1]:
>
> I think the tests should really be split up as their own preceding
> commit, so we're assured that this "git rebase -x 'make test'"'s
> cleanly.

Hm, I'm not sure how this changes the result of "git rebase -x 'make
test'", since these tests will fail prior to this patch. I could modify
the tests to demonstrate the broken behavior though, which would save me
some effort in describing it in the commit message.

>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> index 43f779d751c..e1dc3b1041b 100755
>> --- a/t/t7406-submodule-update.sh
>> +++ b/t/t7406-submodule-update.sh
>> @@ -1116,4 +1116,63 @@ test_expect_success 'submodule update --filter se=
ts partial clone settings' '
>>  	test_cmp_config -C super-filter/submodule blob:none remote.origin.part=
ialclonefilter
>>  '
>> =20
>> +# NEEDSWORK: Clean up the tests so that we can reuse the test setup.
>> +# Don't reuse the existing repos because the earlier tests have
>> +# intentionally disruptive configurations.
>
> Yeah this does seem a bit repetative...
>
>> +test_expect_success 'setup clean recursive superproject' '
>> +	git init bottom &&
>> +	test_commit -C bottom "bottom" &&
>> +	git init middle &&
>> +	git -C middle submodule add ../bottom bottom &&
>> +	git -C middle commit -m "middle" &&
>> +	git init top &&
>> +	git -C top submodule add ../middle middle &&
>> +	git -C top commit -m "top" &&
>> +	git clone --recurse-submodules top top-clean
>> +'
>> +
>> +test_expect_success 'submodule update should skip unmerged submodules' =
'
>> +	test_when_finished "rm -fr top-cloned" &&
>> +	cp -r top-clean top-cloned &&
>> +
>> +	# Create an upstream commit in each repo
>> +	test_commit -C bottom upstream_commit &&
>> +	(cd middle &&
>> +	 git -C bottom fetch &&
>> +	 git -C bottom checkout -f FETCH_HEAD &&
>> +	 git add bottom &&
>> +	 git commit -m "upstream_commit"
>> +	) &&
>> +	(cd top &&
>> +	 git -C middle fetch &&
>> +	 git -C middle checkout -f FETCH_HEAD &&
>> +	 git add middle &&
>> +	 git commit -m "upstream_commit"
>> +	) &&
>
> E.g. here the mixture of "cd" and "-C" is a bit odd, can't we just use:
>
>     git -C middle/bottom ...
>     ...
>     git -C middle add=20


Yeah admittedly this is quite odd. I was hoping that this would be
more readable than big chunks of "-C", since I personally find those
quite difficult to follow when the directory changes from line to line.
But, maybe it's just better to be consistent in just using "-C", and
I'll find some way of organizing the lines that keeps them readable.

> I also wonder if this can't be a for-loop with the right params

I suppose so, though I think there isn't enough repetition here to
justify the readability/correctness trade-off.

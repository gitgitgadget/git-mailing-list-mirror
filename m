Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C4CC433ED
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409EB610C7
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 14:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhDROP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDROPz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 10:15:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE0C06174A
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 07:15:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so42244593ejx.0
        for <git@vger.kernel.org>; Sun, 18 Apr 2021 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=OeYdArGTYv28yVsjnhd+ocw3MO1WowbJ7g/flzkbiGM=;
        b=ixjS7XAlmt54Ik5DJ0TfpTwOtvARF6O/6T8A9V0MzFIHcPaCplWXZjlS4H6Zz827C3
         X5kiA48c/onBQSJfCCMi5TvTZYiaSPphTzN9yvvNaElL93onM1dhXZxgAvq45V3DAi6d
         ZbErAZqiKChnOQHonNiet3oY1gEZBc1o+0jG+dbscPXQfcr6r2COkk3/iMkvzmjQGQzX
         CpS2OJqD455iG7QSheGO5kdAR2Bt6bggRavnWRazQdtj8i90uoOAPciIeQsq18hSLL0n
         qbm4M0ge4tP7fCGBQFzZ0pgb86tS9amfGPclRYCN7ugjfF8Bf229tO1rYblK2cuxk7bP
         8Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=OeYdArGTYv28yVsjnhd+ocw3MO1WowbJ7g/flzkbiGM=;
        b=g269CZWh+6z27TmN2znEZ/D843LCLTcRq6uDXBvxiRsLrFyjsNuG35g71Nc3DQ0C6m
         fo1J74H4/PbRIj/KSngTNN28r5OZtGGdtkkfr4m6JWe6kW4mQAE6xJZcE/HIw3lxWNnE
         Sp7hmd4XkstU4kqzooPRF0yVv7+y5ozPaW/AbiVTR7zXLvev9wvdyCdDrL9IKTkHZ4jk
         KnMCMyBe+4Msaa13YrBp3DH8VMKWTBht0ExzFj4NHkaFgP/vWoOQ5S3OspiEUwVrcrtN
         7XVOiEYr8Xsq+bT4PDszrCGwUeh5KQVKWSLz/IdZmDKlzXAzps6GPeZrsCLHMLdVJ9+V
         5ruQ==
X-Gm-Message-State: AOAM532ui0D/MMrYgypBihYs8ntPfB5bmKzyd5/lqaqhiAXrY4NEp2BB
        LxdZDssBI5q14W6ueSANuAw=
X-Google-Smtp-Source: ABdhPJyPO5dYnELpjQJBadVBhCDuKjy4nxbUcVGKYCaNRQzvhWIHqg8gRb1begrVIJr8H911dwZ4Vg==
X-Received: by 2002:a17:906:d8cb:: with SMTP id re11mr17178273ejb.204.1618755323466;
        Sun, 18 Apr 2021 07:15:23 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.115.143])
        by smtp.gmail.com with ESMTPSA id v1sm10646542eds.17.2021.04.18.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 07:15:22 -0700 (PDT)
References: <20210414191403.4387-2-rafaeloliveira.cs@gmail.com>
 <20210414235027.4064035-1-jonathantanmy@google.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] repack: teach --no-prune-packed to skip `git
 prune-packed`
Message-ID: <gohp6kr1j8nmdv.fsf@cpm12071.fritz.box>
In-reply-to: <20210414235027.4064035-1-jonathantanmy@google.com>
Date:   Sun, 18 Apr 2021 16:15:22 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thanks for reviewing this patch. really appreciate it.

However, in the v2, I decided to drop this in favor of just adding a
trace2 event that emits all the loosened objects. This is to avoid
adding user-visible option just for the sake of testing it.

Jonathan Tan <jonathantanmy@google.com> writes:

>> The `git repack -d` command will remove any packfile that becomes
>> redundant after repacking, and then call  `git pruned-packed` for
>> pruning any unpacked objects.
>
> s/pruned-packed/prune-packed/ (note that there is no "d" after "prune")
> throughout this commit message.
>
> Also, if there are any objects pruned, they are packed objects, not
> unpacked objects. Maybe better to say "...for pruning any objects
> already in packs".
>

Thanks for catching the typo and the clarification.

>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>> index 25b235c063..728a16ad97 100755
>> --- a/t/t7700-repack.sh
>> +++ b/t/t7700-repack.sh
>> @@ -127,12 +127,7 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
>>  	git reset --hard HEAD^ &&
>>  	test_tick &&
>>  	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
>> -	# The pack-objects call on the next line is equivalent to
>> -	# git repack -A -d without the call to prune-packed
>> -	git pack-objects --honor-pack-keep --non-empty --all --reflog \
>> -	    --unpack-unreachable </dev/null pack &&
>> -	rm -f .git/objects/pack/* &&
>> -	mv pack-* .git/objects/pack/ &&
>> +	git repack -A -d --no-prune-packed &&
>
> This is great!
>

Unfortunately, with the drop of this patch in v2, we no longer refactor
these tests. However, this still might be possible with the trace2 event
information that is now-added in the v2. Of course, if this doesn't
impact or weakens the test in anyway.

>> +test_expect_success '-A -d and --no-prune-packed do not remove loose objects' '
>> +	test_create_repo repo &&
>> +	test_when_finished "rm -rf repo" &&
>> +	test_commit -C repo commit &&
>> +	git -C repo repack -A -d --no-prune-packed &&
>> +	git -C repo count-objects -v >out &&
>> +	grep "^prune-packable: 3" out
>> +'
>
> As for the test description, I would prefer "...do not remove loose
> objects already in packs".

Yes, this is an improvement of the test description. 

-- 
Thanks
Rafael

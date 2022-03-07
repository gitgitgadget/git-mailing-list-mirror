Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A09C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244905AbiCGS66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244906AbiCGS65 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:58:57 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C374160C
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:58:01 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id x193so16290894oix.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 10:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ul8+fr/RnuUE5bLTYf571tdCAX4RFTjBHjI3GOnB77s=;
        b=YnoFsxhyNO44Lp1o7E21uGsy0olz6YK6dU9fECqBntTnYkfjm3f9bayfUDFSRRRWTs
         3ThROp83SQMUOYjnK5yN/+2t6FdI2oZqdVlAmaHGIuBbhAnbJWKERIK4pI5reJZ9SI96
         VEsJtIVs10GMk0hpFfWcFTE/yHkXXpq4HutNsGSaCOGNX6m4mzhTjt81JY3E21r4eaGG
         QXv5gj+uw7kYVCL5pSDsotas+46FDsBrdBPRvQBHCbvEaZ2pHOKYbrb7Gq3VrBLYtnEj
         65sMyW44iOa5xWUhHbsEvRDPZTG44nP9Y/g6+6tvVG709wUeV8LEUZV7JJitpSSlFHdf
         /+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ul8+fr/RnuUE5bLTYf571tdCAX4RFTjBHjI3GOnB77s=;
        b=LoZmdvQShi6SsWii/JLjS3zq46KHTAjXrIeS3p+XynqBXmZPjcHKVNLmYtsZe6bcF6
         eo43cEaYi1zoOCxtuJT8mBdWm3SiCngzFO9nXbCZTL4lg36Faw2veWF5dnNgNqN2xVXG
         CeHdyXJOgOCzu9iFwjYCEOnSQpH0N1PyK9TdCMshiY4b4ovzWBZwvbq+owntqEoLJXbO
         QuUFwyg6fvuardT1WCQd1Vg2d0kU70Elkt7cSyrsIXipPn0CnNxw2oKua5KH7KcMG6tH
         G7lCGc4LfmKxgdjYVMtxlg6yIxzWh+xWi2GmtfOo7a0/6zRzbpFZJZP8jlEnS6jFH8TY
         Debg==
X-Gm-Message-State: AOAM530hQkTqO4F3cHyxWrHX38JUHbPQrgk7RrsbsKbWXe3DwGYOXxoJ
        jAZDzsvqnyGC+KrzPvOt//UV
X-Google-Smtp-Source: ABdhPJwa7THZREvlU6V2MuMmUoZtHTWrNFSzW/QeJ7kgT0VR5Fzk75ThSTfIfgzjVSbbER3zduEORg==
X-Received: by 2002:a05:6808:238a:b0:2d7:1878:9623 with SMTP id bp10-20020a056808238a00b002d718789623mr231212oib.1.1646679480697;
        Mon, 07 Mar 2022 10:58:00 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n110-20020a9d2077000000b005b229876a11sm3146613ota.66.2022.03.07.10.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 10:58:00 -0800 (PST)
Message-ID: <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
Date:   Mon, 7 Mar 2022 13:57:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
 <xmqqzgm5wafu.fsf@gitster.g>
 <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
 <xmqqv8wpu2fq.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqv8wpu2fq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 11:56 AM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> Of course, looking closer at it... "git bundle unbundle" doesn't
>> actually store the refs directly in the refspace, but instead only
>> outputs the refs that it used.
> 
> True.  I was more thinking about equivalence between
> 
>     cd src_repo
>     git clone --no-local --filter=... . ../partial.network.cloned
>     git bundle create --filter=... partial.bndl
>     git clone partial.bndl ../partial.bundle.cloned
> 
> The two resulting repositories should look very similar except for
> that the remote.origin.* of the former would expect that it pushes
> back to where it was cloned from, while the latter would not.

Makes sense.

The one downside is that you list cloning form a partial bundle,
but that currently does not work, even if we avoid a checkout.
It fails because the clone command is not parsing the filter
and properly setting repo-global promisor information. (Again,
this is a bigger change to make this possible.)

I also had some struggles getting this to work since local clones
were actually ignoring the filter. I didn't think it was worth
setting up an HTTP or SSH server just for this test. See
workaround below.
 
>> +		git init unbundled &&
>> +		(
>> +			cd unbundled &&
>> +			# This creates the first pack-file in the
>> +			# .git/objects/pack directory. Look for a .promisor.
>> +			git bundle unbundle ../partial.bdl >ref-list.txt &&
>> +			ls .git/objects/pack/pack-*.promisor >promisor &&
>> +			test_line_count = 1 promisor
> 
> And can we enumerate the objects we have in .git/objects, both loose
> and packed?

I can enumerate using 'git rev-list --objects' to compare the
unbundled set to the full clone (adding --filter=$filter to the
full clone's run and --missing=allow-any to the unbundled one).

>> +		) &&
>> +
>> +		git clone --filter=blob:none --mirror "file://$(pwd)" cloned &&
>> +		git -C cloned for-each-ref \
>> +			--format="%(objectname) %(refname)" >cloned-refs.txt &&
>> +		echo "$(git -C cloned rev-parse HEAD) HEAD" >>cloned-refs.txt &&
>> +		test_cmp cloned-refs.txt unbundled/ref-list.txt
> 
> Likewise here?  I think the two should match, and that was what I
> was wondering if we should enforce.
> 
>>  	'
>>  done
>>  
>> --- >8 ---
>>
>> I also attempted doing a "git clone --bare partial.bdl unbundled.git" to
>> get the 'git clone' command to actually place the refs. However, 'git clone'
>> does not set up the repository filter based on the bundle, so it reports
>> missing blobs (even though there is no checkout).
> 
> Understandable, as cloning from a bundle, if I recall correctly, was
> done as yet another special case in "git clone", differently from
> the main "over the network" code path.  And from end-user's point of
> view, I think updating it is part of introducing the filtered
> bundle.

The reason I did not include that here is because of the lack of
repository-global promisor/filter config. I do want to loop back
and make those updates, but perhaps for this series we should add
an error condition into 'git clone' to say "Cannot currently clone
from a filtered bundle" to help users understand the issue?

Thanks,
-Stolee

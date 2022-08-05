Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB7C25B08
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiHEO15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiHEO14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 10:27:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E0C286FB
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 07:27:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id q184so2869486oif.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j380EP+/PuL4mRrvUq1pnAZ4dLcvmiT//+uyOe94C9s=;
        b=XjX2lANSSy7tzPbxbLWLHOH4iCJdw6uK+izUy57smcI8VELS48tvpvB6jh5AjC2li2
         vQnvZZPzWoCYPOUTQz0lyLTTqum6LbD6QRbuobigqlJ5NycmYreLN67kzHegY+1OSV8w
         iWspxC10DCJJfFENYpoghAB+DqSePBpDTqo+XauqmPtUpiG35PmAEm9BM7X3FanjCFDu
         N5F1f7jOdJjI0Hgjb1YRPyi4QH9Stx/WSVdpS6Jk/gjuuMPeZzi4x1ONnvYj8MmPYHHW
         lJljzb1FPAkdGVMXwkia/kZzQAaopl90bWo69nGsmE0x/GHOs6Lr/ZvY1/y9NcfoItNA
         UeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j380EP+/PuL4mRrvUq1pnAZ4dLcvmiT//+uyOe94C9s=;
        b=ygElRMkShlKQh3zXrV7Hq8oes8V3Xk9xRnI8kXOHxMDrVwVdf4kRlohAk5Ds55F6KD
         q5YxUx/RFWRZ5vVd0wjX6T1mLkfhzGz2zvTSAARO9BJVZ3OYDdnNuImI95aR27DtzQFo
         qhvcOVW8UzGCFBEFkvHmsfb7DonRQmezwZ8Ow9DLmcbq/+8chxMMcuBFl43YOeZ/shke
         JFY3zUiqvssN8yVbtDk7kza/tK2F6nykXQgw0HU+E72VcWn6EjfLnji6ZA6x/zejYLBG
         9Oilh873kMCEPa6F1sNnlN8jEnwWRVlidAvTcdBaSWbvO91E9d72ej4kYc0lAY9jmMYT
         gsag==
X-Gm-Message-State: ACgBeo2G7ongl8SIgKzGfnx9P3lQmLr12nfH3oGbwqhxWC5WLaXo5a4T
        qhZJyJMCruw5EZ9YniXqCiaGQYGF3HJt
X-Google-Smtp-Source: AA6agR4WItqrITiWGQ5GpR8NTmrCyd+35OgKjc29cnpr19ZVfZ6tkyy01bK9mauKwoHer68Esp1J9Q==
X-Received: by 2002:a05:6808:124f:b0:321:855d:5b19 with SMTP id o15-20020a056808124f00b00321855d5b19mr3069254oiv.30.1659709674773;
        Fri, 05 Aug 2022 07:27:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id x19-20020a056870a79300b0010e5a5dfcb4sm720085oao.0.2022.08.05.07.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:27:54 -0700 (PDT)
Message-ID: <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
Date:   Fri, 5 Aug 2022 10:27:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
 <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 3:08 AM, Ævar Arnfjörð Bjarmason wrote:

> There's no lack of "stability", because the ref hiding only act on
> what's known to be something we can ignore, because our git version
> knows about it.
> 
> If git v2.40 knows about refs/magical-1/* but not refs/magical-2/*, but
> git v2.50 knows about both it's not a lack of stability that v2.40 shows
> one decorated by default, but v2.50 shows neither.

You are describing how the behavior changes between these versions on
the same repository. That's what I mean by lack of stability.

> But it's not just that I disagree, I genuinely don't get your POV
> here.

I'm optimizing for non-experts who never need any refs outside of the
standard set. Now that this version removed the notes ref from the
decoration, the stance for inclusion is simple:

  If Git offers to color the namespace with color.decoration.<slot>,
  then Git decorates with that namespace by default.

>> +test_expect_success 'log --decorate does not include things outside filter' '
>> +	reflist="refs/prefetch refs/rebase-merge refs/bundle" &&
>> +
>> +	for ref in $reflist
>> +	do
>> +		git update-ref $ref/fake HEAD || return 1
>> +	done &&
>> +
>> +	git log --decorate=full --oneline >actual &&
>> +
>> +	for ref in $reflist
>> +	do
>> +		! grep $ref/fake actual || return 1
>> +	done
> 
> I haven't tested, but isn't that last for-loop replacable with:
> 
> 	! grep /fake actual
> 
> ?
> 
> Or do we have other "/fake" refs we want to include?

This is a nice efficient replacement. Thanks.

-Stolee

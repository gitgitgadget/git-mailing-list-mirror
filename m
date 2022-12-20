Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD6C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 13:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiLTNyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 08:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiLTNym (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 08:54:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED4A1AF16
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:54:41 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id pp21so8287602qvb.5
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xt+flUKzTga4aYK+oTOpycq0pZrVVQVHqXpqtIP0BeY=;
        b=KU5cCKfxwbGN6q8Ue80AGwdOsRvqbFr8eRebTHLTPxq2Z37fFckuXFtiD1mHhqrj4M
         F/xQ/iqOEVWsdkEmED3A1YElGOVe0UQPAaPRt1CySpn8t6SJDGOPcKzi8aauZ7GjcRK1
         tU9t12KYhwyh1q2c56wqe2VOAjIEQu5LIV2FHMD/VbzSFQWjNIoQn0YQPPK9YWS8hcrl
         FVYKYrAtAMKpmZsWNacOJ9UBLmxDyHRuyPxpAXuHq54JUInPkJTjcOg68tYClJwXcQSz
         jxmsBKdGBuqqDuycjalCo5njKtuPyVL7QNBVhEXmzavHInYQDeXqjB6M5tjthjL5Hbqo
         Ai0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt+flUKzTga4aYK+oTOpycq0pZrVVQVHqXpqtIP0BeY=;
        b=jDMxGiv9arM2/9HjwCt7Nd9T+jrU58gwsKCfrutbe5Zvn36Gd2f3dkpw600KuV82j7
         qYUI6Vd5Qk7h3QkjEKomWeY5gjF2LogTuTYkxmhEj8V3v3GUcHUA/Gu/5MoEPBPzC1uX
         I0lvl27bvBNntvGIuhdbJLsVldd17FNWDqIRQKJsKjUnBHgOy6ZKzMWV6gLHvPvBgvSP
         JYIJCVfTLSoG5MAmXBOIEec7hfb+09sh6Ih17hm1mbbDRJgS4NOQAfL0VmOebqJXvbML
         /PuUWY146OgaIVXb6O6pG+C06MW/39CAyQC+aeY3FTppgcgQk9Yl1nrXqS6KyWkTvfs6
         40rg==
X-Gm-Message-State: ANoB5pkHdXMcjxzkft0+n8tqQXcKPlvHDCPif7Rahuw4wlkjOyp73jNU
        6F8aRFiP70Ys1kSJq0LBBXaXdMgV9em6Evs=
X-Google-Smtp-Source: AA0mqf4t9/R6vVLoDpYV9dxMLP88jg3Z6Gljjj9FIGcPkbuk/EEreRA5q7VoZaWbrvi+6Cmfinmk4Q==
X-Received: by 2002:ad4:4f43:0:b0:4c6:d886:2680 with SMTP id eu3-20020ad44f43000000b004c6d8862680mr63454354qvb.40.1671544480761;
        Tue, 20 Dec 2022 05:54:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:6103:2a44:3e02:702f? ([2600:1700:e72:80a0:6103:2a44:3e02:702f])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006eee3a09ff3sm8782791qkm.69.2022.12.20.05.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 05:54:40 -0800 (PST)
Message-ID: <49eb61a4-2b5d-c695-25e1-621bac6f3421@github.com>
Date:   Tue, 20 Dec 2022 08:54:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] bundle-uri: advertise based on repo config
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <857d1abec4cf124e011c7f84276ce105cb5b3a96.1670866407.git.gitgitgadget@gmail.com>
 <221219.86pmcfzm7g.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221219.86pmcfzm7g.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/19/22 6:04 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> The bundle_uri_advertise() method was not using its repository
>> parameter, but this is a mistake. Use repo_config_get_maybe_bool()
>> instead of git_config_maybe_bool().
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  bundle-uri.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bundle-uri.c b/bundle-uri.c
>> index 8efb4e7acad..5f158cc52e1 100644
>> --- a/bundle-uri.c
>> +++ b/bundle-uri.c
>> @@ -610,7 +610,7 @@ int bundle_uri_advertise(struct repository *r, struct strbuf *value)
>>  		goto cached;
>>  
>>  	advertise_bundle_uri = 0;
>> -	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
>> +	repo_config_get_maybe_bool(r, "uploadpack.advertisebundleuris", &advertise_bundle_uri);
>>  
>>  cached:
>>  	return advertise_bundle_uri;
> 
> This looks good, but as with another parallel topic of yours that I
> commented on[1] leaves us wondering if this had any effect.
> 
> I.e. is this just for good measure because we have a "r" parameter, or
> did we do the wrong thing for submodules before this change? In that
> case let's add the missing test coverage.
> 
> Or, if it's the former let's update the commit message here, saying e.g.:
> 
> 	While we should use "r" for <good measure or other reason>, we
> 	already did the right thing for submodules, as "the_repository"
> 	would be set to the submodule because <reasons I don't
> 	know about...>.

As I mentioned in another thread, we should always be using a
local 'struct repository *' if we can so we aren't contributing
to that particular dimension of technical debt, but submodules
have a lot of work ahead before these kinds of things can be
tested individually.

This is especially the case when working with server code, where
we would never be in the submodule, but we don't want to block
future removals of the non-repo versions of these methods.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5555ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 15:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiH3PJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH3PJU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 11:09:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD01037F9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:09:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso6337385wmb.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=3PED6PdTfNjNQchz5+tOIzPkSTWHLh4HkebB0VAH2No=;
        b=pCTFA+lIeJHUkk/y3/bpAu1xavZCgyOsMc4JLKTsXdJmzngi+P272V6oLrAr+a/WKl
         RgTM3f2NSqJx547P9QY6lRZjaIqZ9WrA6jQHi/5i47A9vC86mTQqOT9+xoi2S23yeKmG
         ZaxZFeGGENGENYbK3gw9I4pomvkWKZxnFYUiO0fVebYtRW+gEEfdi1TkS5lM+MiOF49g
         yNq6n5jPSwcQWQyNPRfOsuPB4trorBDw87Zmf3BnIbxa4QhSOoIPkMv/ivwJIaCEPa3o
         wgEPbdbCXnkn51XByj304hmYd/VcXiaFEh/ZB0bAYhT1kdFa+w5RIVeGdNirisPjNqpM
         1Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3PED6PdTfNjNQchz5+tOIzPkSTWHLh4HkebB0VAH2No=;
        b=rIFKnSrgVXYD8TvR4Vr27HXgzafppdl4Ngw1M72dULB4RquCkqO4ibIdAfDfW2dlsn
         DvYa7np6rr/TIwoITiqfccz/o00Yat5Y96OqsgMpIn+EhnQFsNtshZn+R1iKVUwRPCpB
         yTYPuKsto99Cgup8QQ9GeqJD6wCAEh6QBg/fo8VMeEIcop0ilvLbV13m5jI/uvrCsXvS
         m1MdzUxmRjz0yN5F69+/woT37glxhBRHEQlW7d9gGHiT1XZUGLGTYV78LQQ3aJ4tiwZ2
         ETxObVc6+P9BsN9jRi5NVxNS/PKZBXXJfG1rH3e+ZFPWKEbEKP7m7nE6nF6pu4XAhDcp
         ThSQ==
X-Gm-Message-State: ACgBeo1qum0pe11NvHVZw+foeoS2MGlJnSuVwQfk0K0HWBstR4m3T7QM
        FYThl1Pr9oFteIj2P/T2818=
X-Google-Smtp-Source: AA6agR6sXygJnEBcaqVVVYddvig1Ta4um2coq4zwKw8xM672ItiscoXe3ABQtJJoMjy1ASdsdU4YFw==
X-Received: by 2002:a05:600c:1c8d:b0:3a6:9d60:faf0 with SMTP id k13-20020a05600c1c8d00b003a69d60faf0mr10202016wms.82.1661872157891;
        Tue, 30 Aug 2022 08:09:17 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id l23-20020adfa397000000b002254b912727sm9954349wrb.26.2022.08.30.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:09:17 -0700 (PDT)
Message-ID: <85278536-0c81-f903-bb87-1ff14d5dbafa@gmail.com>
Date:   Tue, 30 Aug 2022 16:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/5] rebase --keep-base: imply --reapply-cherry-picks
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20220824220945.1683473-1-jonathantanmy@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220824220945.1683473-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 24/08/2022 23:09, Jonathan Tan wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -1240,6 +1241,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   		if (options.root)
>>   			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
>>   	}
>> +	/*
>> +	 * --keep-base defaults to --reapply-cherry-picks as it is confusing if
>> +	 * commits disappear when using this option.
>> +	 */
>> +	if (options.reapply_cherry_picks < 0)
>> +		options.reapply_cherry_picks = keep_base;
> 
> Here, we set options.reapply_cherry_picks to 1 if keep_base is 1, but...
> 
>> @@ -1416,7 +1423,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>   	if (options.empty != EMPTY_UNSPECIFIED)
>>   		imply_merge(&options, "--empty");
>>   
>> -	if (options.reapply_cherry_picks)
>> +	/*
>> +	 * --keep-base implements --reapply-cherry-picks by altering upstream so
>> +	 * it works with both backends.
>> +	 */
>> +	if (options.reapply_cherry_picks && !keep_base)
>>   		imply_merge(&options, "--reapply-cherry-picks");
> 
> ...if we implement --reapply-cherry-picks by altering upstream (and
> hence not need to rely on the "merge" backend), shouldn't we suppress
> the setting of options.reapply_cherry_picks too?

I'm not quite sure what you're suggesting. We only alter upstream if 
options.reapply_cherry_picks is true which happens below this hunk, are 
you saying we should clear options.reapply_cherry_picks when we change 
upstream? I'm not sure that has any practical effect as the left hand 
side of options.upstream...options.orig_head will be empty so when we do 
the revision walk to generate the todo list.

Best Wishes

Phillip

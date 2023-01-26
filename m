Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CD8C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 14:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjAZOzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 09:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjAZOzp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 09:55:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099A129
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 06:55:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so2076001edi.8
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSMDLN1ewh5SQ0Ck29vj3FQ2Xnfc5dEyqeiFLcqJHeo=;
        b=hpohY6/vCs9KI4eyWY+LMIrzGqTfzhU3k+p5+3TO1QCnqWYSrRaQyOMvO5gv4+h6py
         +hDVF3SHjMJ1GIMeY+9AR5w8+ZE5huLOf1Haoia/7IMeTuv6OhHdLgGoxUlqN+Bxs+p0
         zjgWAu/NaYSmke/9JOg+mxOKPzrw/yG0lROK7qCgPpljJxh31EVrBdvHEXoAg4Uj+f0V
         j5mRQpdiIEqdhMNlLw3DcxXQ4yXAtUcfkreNBLytUg9fnS9WOixu/tCZmXuhuNDrIAcd
         QIiiTuvaa8+AUbHnskWWz54baB/FRYhylA4Lv7nISRa++5wFMXuYs5aZAGLnSG/k3c2v
         zKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSMDLN1ewh5SQ0Ck29vj3FQ2Xnfc5dEyqeiFLcqJHeo=;
        b=j0MVGgIU1F5hRaSY/UVWFu6YMXU2Ux4zO/ywvBfkx4L+e4itBcHZvpPngs/EAesuaI
         sV+vFmJPvDVg6LC/9aPSMX5szscbRHcoN0+d7kNScooxXjnjoQv2QJwYt2j2urTu27B9
         Fc9v/Pq1bdaKK9jq+NKtN8E7j1i5+YEnBEGOL+srE7APr2hWpB7YVsANTejfKbh7cyPQ
         PAROxUvpC1cwzqdLXYw7sD8yMPTNcwy9zWZeofLPwF4trMDONeFgg3EOIO9sNF43WDrO
         hkHfnRc3DD+2JK8xYpsjqZlcouY7swNZ9FvH+2Qx5UhuhUnMOWtr7DTdf8JJ3jD/yTSC
         nxcQ==
X-Gm-Message-State: AFqh2krrWtxU4tzBrY0CuCDxQtmgq+zuJI30G7J3mZsE5qskWDv74HGY
        Q9Vk/Sdas/MlsJRa8BPjru+EKnxFdmIpZcnUaRI=
X-Google-Smtp-Source: AMrXdXv2O09P2ZNpzEmewBr8oJZRRyhUvmaOO1AUs4LYNS33l25KGf88wMKkBm1wZAgYg9FK2NJh6Q==
X-Received: by 2002:a05:6402:35c1:b0:46f:f36b:a471 with SMTP id z1-20020a05640235c100b0046ff36ba471mr51910091edc.22.1674744942080;
        Thu, 26 Jan 2023 06:55:42 -0800 (PST)
Received: from [10.45.33.196] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id g4-20020aa7c584000000b004a0e23a2eebsm701592edq.10.2023.01.26.06.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 06:55:41 -0800 (PST)
Message-ID: <d96e6ab4-2302-5326-3a0e-bffecc24a295@unity3d.com>
Date:   Thu, 26 Jan 2023 15:55:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
To:     Victoria Dye <vdye@github.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <7ccf7b17-4448-5ef4-63b1-9073a400e486@github.com>
 <569043fb-9766-037e-c587-1545c2978e7d@unity3d.com>
 <42e14dda-cd2b-09df-dea8-246b3fcfac42@github.com>
Content-Language: en-US
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <42e14dda-cd2b-09df-dea8-246b3fcfac42@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/01/2023 19.32, Victoria Dye wrote:
> William Sprent wrote:
>> On 24/01/2023 21.11, Victoria Dye wrote>> I haven't looked at your implementation in detail yet, but I did want to
>>> offer a recommendation in case you hadn't considered it: if you want to
>>> allow the use of patterns from a user-specified specific file, it would be
>>> nice to do it in a way that fully replaces the "default" sparse-checkout
>>> settings at the lowest level (i.e., override the values of
>>> 'core_apply_sparse_checkout', 'core_sparse_checkout_cone', and
>>> 'get_sparse_checkout_filename()'). Doing it that way would both make it
>>> easier for other commands to add a '--sparse-patterns' option, and avoid the
>>> separate code path ('path_in_sparse_checkout_1()' vs.
>>> 'recursively_match_path_with_sparse_patterns()', for example) when dealing
>>> with '.git/info/sparse-checkout' patterns vs. manually-specified patterns.
>>>
>>
>> Thanks for the pointers. I'll see what I can do. Do you mean something
>> along the line of the following?
>>
>>     set_sparse_checkout_file(filename);
>>     init_sparse_checkout_patterns(istate);
>>     _ = path_in_sparse_checkout_1(some_path, istate, ...);
>>
> 
> Sort of. I mentioned separating the options into "specify the sparse pattern
> file" and "restrict the displayed files to the active pattern set, if there
> is one". For the former, you might add an option like:
> 
> 	OPT_FILENAME(0, "sparse-patterns", &sparse_pattern_file,
> 		     N_("override sparse-checkout behavior using patterns from <file>"))
> 
> Then do something like what you have, right after option parsing:
> 
> 	if (sparse_pattern_file) {
> 		core_apply_sparse_checkout = 1;
> 		core_sparse_checkout_cone = <???>;
> 		set_sparse_checkout_file(filename);
> 	}
> 
> If this option is specified, but the repo already has sparse
> patterns/settings of its own, you'll need to (carefully) override the repo's
> existing configuration:
> 
> * 'core_apply_sparse_checkout' & 'core_sparse_checkout_cone' are set based
>    on the repo config. You'll need to make sure those values are overridden
>    before loading the sparse-checkout patterns, and also that they're set
>    *after* loading the config.

This sounds a bit easy to get wrong to me, but I assume I can trust that the
config has been loaded by the time 'cmd_ls_tree()' is invoked.

> * Speaking of 'core_sparse_checkout_cone', there are a bunch of ways you
>    might configure "cone-" vs. "non-cone" for your patterns (user-specified
>    with yet another option, always assume one or the other, try deriving from
>    the patterns). My preference would be to always assume "cone mode" - it's
>    the direction Git has been moving with sparse-checkout over the past year,
>    and still automatically "falls back" on non-cone patterns if the patterns
>    can't be used in cone mode (with a warning from
>    'add_pattern_to_hashsets()': "disabling cone pattern matching").

Alright. I've had similar thoughts. But I ended up deciding to respect the
config value since there wouldn't be any way for the user to silence the warning
when passing non-cone mode patterns to the command. I don't feel too strongly about
it, though.

> * If the repo is using a sparse index, the existing sparse directories may
>    not be compatible with the custom patterns. Probably easiest to force use
>    of a full index, e.g. with 'command_requires_full_index = 1'.
> 

OK.

> Fair warning: this probably isn't an exhaustive list of things that would
> need updating, and it'll need thorough testing to make sure there are no
> regressions. But, extending the underlying sparse-checkout infrastructure
> will (ideally) avoid duplicating code and make this behavior reusable across
> other commands.
> 

Alright. I'll give it a shot.

> For the other desired behavior ("limit the files to the active
> sparse-checkout patterns"), you could add an option:
> 
> 	OPT_CALLBACK_F(0, "scope", &sparse_scope, "(sparse|all)",
> 		       N_("specify the scope of results with respect to the sparse-checkout"),
> 		       PARSE_OPT_NONEG, option_parse_scope),
> 
> ...whose callback parses the string arg into a 'restrict_scope'
> boolean/enum/something. Then, wherever in 'ls-files' a tree or the index are
> iterated over, you can gate the per-file operation on:
> 
> 	if (!restrict_scope || path_in_sparse_checkout(<path>, istate)) {
> 		/* do something with <path> */
> 	}
> 
> Note that you should use 'path_in_sparse_checkout()', *not* the
> internal/private function 'path_in_sparse_checkout_1()'; you also don't need
> to explicitly 'init_sparse_checkout_patterns()'. Regardless of whether you
> specified custom patterns or are using the ones in
> '.git/info/sparse-checkout', 'path_in_sparse_checkout()' will initialize &
> use the appropriate patterns.
> 

Yeah. And I wouldn't need the refactor of 'path_in_sparse_checkout_1()'.

Thanks a lot (again) for the pointers.

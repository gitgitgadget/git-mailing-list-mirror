Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CAC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjAYSco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 13:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjAYScm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 13:32:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506845AA4B
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 10:32:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id v3so14006149pgh.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 10:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ8ex5wEULHd2KTr9eD07PsDAMJYIaroGFo5EX5H4qQ=;
        b=g4BEq1vy9zhjG5k3vTKc/Rl852U/7c/MpuH69zywTfGIj+3gQYwcguv/TEZ28tJwR/
         /Z4NUw5tbKiK2FDw38FNKTBlqjOAkRHiHx+tXXjHCrKZfeiY9EaLphNVFXxW9GsDnMob
         WSnG5o5CdU0qwTT3bUr5aEd8bGwhqyNSc1bkAfBMoO+dkrpx+Y182H/zmB4uXaKe3+wQ
         BLL2wYFJJP7+Jhv9c0RAsw/yOu6MaXLGavRGUr881Ui87zR3K94+98ZIxIPSYx/clIIw
         xnYVkX/55dMRZx59Oe7Ld4WzXECzGJObpXlUxJQzGp6zWHEtrXIB+ASy/eG+WUPQnCYY
         im8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ8ex5wEULHd2KTr9eD07PsDAMJYIaroGFo5EX5H4qQ=;
        b=MGZdugXYGh+r756LefSD+pwncsUUmR+9aNOsjJzrML/bht+8EahMZjRhKMwEbHiVf2
         0kK0X3TyRwaBOfWN4LcjKT7RGxYkDZgNSLB+LKpxGnKl5OrjUqhQsoIlZShsioJRr0ne
         Wuk+QCMqwwkjrHWjJztLGOCSzMKO36MHfLThhbvdP35SQdcavKRS0DsyMSrsvk+8HSey
         IbVWi34kNrvamDy5BAsIAgFDS1gRMgAQtTJWQVgRjHWKE5ROEAFKkzJlE89ikFi7ObHd
         +j5jmTAyfNCNbR8GqMwJep2tWs32+L2FwDpoe3M4xc2T8OFWb9IEuOl0FJNDwTTlG0hq
         xZRA==
X-Gm-Message-State: AFqh2kqq+d+jjXq1dmZ0PN/AvLLyd3cWy95eBYEtPInJ9eP28QaKUyNP
        Puqyl6cOKAiL7GajSmitCOxw
X-Google-Smtp-Source: AMrXdXux8eW3lo6mMDljBuegfiCDCBRMd59RjXBxU83Vw33V2k8n/r0Os6anmUDUwrrdVyGKvAHbLQ==
X-Received: by 2002:a05:6a00:1c8c:b0:589:af4d:43a5 with SMTP id y12-20020a056a001c8c00b00589af4d43a5mr32259543pfw.4.1674671559725;
        Wed, 25 Jan 2023 10:32:39 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z186-20020a6265c3000000b00581fddb7495sm3917712pfb.58.2023.01.25.10.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 10:32:39 -0800 (PST)
Message-ID: <42e14dda-cd2b-09df-dea8-246b3fcfac42@github.com>
Date:   Wed, 25 Jan 2023 10:32:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     William Sprent <williams@unity3d.com>,
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
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <569043fb-9766-037e-c587-1545c2978e7d@unity3d.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Sprent wrote:
> On 24/01/2023 21.11, Victoria Dye wrote>> I haven't looked at your implementation in detail yet, but I did want to
>> offer a recommendation in case you hadn't considered it: if you want to
>> allow the use of patterns from a user-specified specific file, it would be
>> nice to do it in a way that fully replaces the "default" sparse-checkout
>> settings at the lowest level (i.e., override the values of
>> 'core_apply_sparse_checkout', 'core_sparse_checkout_cone', and
>> 'get_sparse_checkout_filename()'). Doing it that way would both make it
>> easier for other commands to add a '--sparse-patterns' option, and avoid the
>> separate code path ('path_in_sparse_checkout_1()' vs.
>> 'recursively_match_path_with_sparse_patterns()', for example) when dealing
>> with '.git/info/sparse-checkout' patterns vs. manually-specified patterns.
>>
> 
> Thanks for the pointers. I'll see what I can do. Do you mean something
> along the line of the following?
> 
>    set_sparse_checkout_file(filename);
>    init_sparse_checkout_patterns(istate);
>    _ = path_in_sparse_checkout_1(some_path, istate, ...);
> 

Sort of. I mentioned separating the options into "specify the sparse pattern
file" and "restrict the displayed files to the active pattern set, if there
is one". For the former, you might add an option like:

	OPT_FILENAME(0, "sparse-patterns", &sparse_pattern_file, 
		     N_("override sparse-checkout behavior using patterns from <file>"))

Then do something like what you have, right after option parsing:

	if (sparse_pattern_file) {
		core_apply_sparse_checkout = 1;
		core_sparse_checkout_cone = <???>;
		set_sparse_checkout_file(filename);
	}

If this option is specified, but the repo already has sparse
patterns/settings of its own, you'll need to (carefully) override the repo's
existing configuration:

* 'core_apply_sparse_checkout' & 'core_sparse_checkout_cone' are set based
  on the repo config. You'll need to make sure those values are overridden
  before loading the sparse-checkout patterns, and also that they're set
  *after* loading the config.
* Speaking of 'core_sparse_checkout_cone', there are a bunch of ways you
  might configure "cone-" vs. "non-cone" for your patterns (user-specified
  with yet another option, always assume one or the other, try deriving from
  the patterns). My preference would be to always assume "cone mode" - it's
  the direction Git has been moving with sparse-checkout over the past year,
  and still automatically "falls back" on non-cone patterns if the patterns
  can't be used in cone mode (with a warning from
  'add_pattern_to_hashsets()': "disabling cone pattern matching").
* If the repo is using a sparse index, the existing sparse directories may
  not be compatible with the custom patterns. Probably easiest to force use
  of a full index, e.g. with 'command_requires_full_index = 1'.

Fair warning: this probably isn't an exhaustive list of things that would
need updating, and it'll need thorough testing to make sure there are no
regressions. But, extending the underlying sparse-checkout infrastructure
will (ideally) avoid duplicating code and make this behavior reusable across
other commands.

For the other desired behavior ("limit the files to the active
sparse-checkout patterns"), you could add an option:

	OPT_CALLBACK_F(0, "scope", &sparse_scope, "(sparse|all)",
		       N_("specify the scope of results with respect to the sparse-checkout"),
		       PARSE_OPT_NONEG, option_parse_scope),

...whose callback parses the string arg into a 'restrict_scope'
boolean/enum/something. Then, wherever in 'ls-files' a tree or the index are
iterated over, you can gate the per-file operation on:

	if (!restrict_scope || path_in_sparse_checkout(<path>, istate)) {
		/* do something with <path> */
	}

Note that you should use 'path_in_sparse_checkout()', *not* the
internal/private function 'path_in_sparse_checkout_1()'; you also don't need
to explicitly 'init_sparse_checkout_patterns()'. Regardless of whether you
specified custom patterns or are using the ones in
'.git/info/sparse-checkout', 'path_in_sparse_checkout()' will initialize &
use the appropriate patterns.


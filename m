Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC150C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjCHPav (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjCHPas (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 10:30:48 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E1FA4B2D
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 07:30:47 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id o6so15710305vsq.10
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 07:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678289446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wir3mzR3aapnA6nswqr4GsILZkMJeePq10s67ybQwB4=;
        b=WVtmmoKDzrMp5ZKJQRAMgdUSGocHkhRODkMkNvwvR3iQ16VWRTvBHRDXKQ5YKzb7IZ
         al98JOKBTaDU/8hrYo0zoOwheWk3Or2edZuoIDsrR6vMPRUn7ZiUQJdkF0oWyCOym3S1
         qWoOnngGH2SKxWtQF1f9xrg62MZY+Pqn0owfh68PuKB1nvAQSH1dftB9VgHkmH9xm/Vd
         lEphna0HZOkQC+S/iGZiEm8suKHkZGVd6UKGc06telH5XTYNFB+SHkfK2DODznhcD807
         D2koWeHwM7Qw+89mzhZ8yZCQARjQ3u9LvWwhLVTAYnUvSVy/bfRcA0losugoevrS1AXI
         50WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678289446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wir3mzR3aapnA6nswqr4GsILZkMJeePq10s67ybQwB4=;
        b=4oWywbbwoBsVg0CzYQTaCb5eNDBNIOPd4PCpftvraifPikBq/vaEHjqkb70jGLr4cm
         v3MNcOvUgMFw/LTd6RC6Y7jkfJlSh+zETd3SgYhmSXlC1BDdvnn/oQkJrMFmxaFZOiog
         uqr4SXHcwntNplDDKmSDKPgGuLPCGviAGlqivorbTVgXO2xunPks9C376MCUTMkBzlzl
         wmIHLC1ERdIkLId0+aDvp9zjmNHeGPxqk2cnQ+5Y3NOle4qVwwSOlEZzwTtaYilP6IeA
         epqAY+AFMC+nZeazDWKfmc+47hs45OaP0k5HBqTdGQ4GKmmVhcheDbvjH13yWJejgVTX
         WENg==
X-Gm-Message-State: AO0yUKUVuJTZ5hFR/c5J/iIhWchPOggk3XeHutTxs1wN/AarcqK16oH3
        lPV+z0COXkR+NiWWtPAYMYd4
X-Google-Smtp-Source: AK7set+Mc2TmUANVD5sF91uKxudtd/s194lnuvgGa1EyfbITQ7H0ySOKQO6AWgKKByUefYKJn9T32A==
X-Received: by 2002:a05:6102:3e23:b0:416:adb3:5caf with SMTP id j35-20020a0561023e2300b00416adb35cafmr10600643vsv.28.1678289445965;
        Wed, 08 Mar 2023 07:30:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d0dc:3668:fb01:9900? ([2600:1700:e72:80a0:d0dc:3668:fb01:9900])
        by smtp.gmail.com with ESMTPSA id e3-20020a05620a014300b00742e61999a3sm11695447qkn.64.2023.03.08.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 07:30:45 -0800 (PST)
Message-ID: <d102dd22-778d-add6-faf9-20bf87d107c7@github.com>
Date:   Wed, 8 Mar 2023 10:30:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] blame-tree: add library and tests via "test-tool
 blame-tree"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
References: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
 <4ab0b2b0-b045-2346-ccc1-19f9b23d0a02@github.com>
 <230307.86o7p4zm4s.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <230307.86o7p4zm4s.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2023 8:56 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Feb 10 2023, Derrick Stolee wrote:

>> All this is to say, that I'd like to see this API start with the smallest
>> possible surface area and with the simplest implementation, and then I'd
>> be happy to contribute those algorithms within the API boundary while the
>> CLI is handled independently.
> 
> I hear your concern about leaving this open for optimization, and in
> general I'd vehemently agree with it, except for needing to eventually
> feed a command-line to setup_revisions().

The most-correct way to build this, with full optimizations, does not
involve revisions.c at all, so this "eventually" is incorrect. It's
only something to do for the "first" implementation, as a reference.

In order to do the single-walk approach for every path simultaneously,
we _must_ have full control of the commit walk. There was a time where
we had done a single-walk approach by letting the revision machinery
walk all commits that changed the base tree, then looked for changes
to the contained paths. However, this results in _incorrect_ results
because commits that would normally be ignored by the simplified
history walk for "<dir>/<entry>" were not ignored by the simplified
history walk for "<dir>/" and thus that algorithm presented _incorrect
results_.

For that reason, doing a single walk that outputs the blame-tree
results for each path must have full control over which commits are
walked and which paths could emit a change for those commits. This
means we must not use revision.c as a base for full control.

> Ideally the revision API would make what you're describing easy, but the
> way it's currently implemented (and changing it would be a much larger
> project) someone who'd like to pass structured options in the way you'd
> describe will end up having to re-implement bug-for-bug compatible
> versions of some subset of the option parsing in revision.c.

The subset of option parsing is "a starting revision" and "a base tree"
and _perhaps_ "is the diff recursive or not?" (and this last one isn't
even in revision.c yet). That does not seem like using revision.c's
parsing is actually helpful at all.

> Isn't a way to get the best of both worlds to have a small snippet of
> code that inspects the "struct rev_info" before & after
> setup_revisions(), and which would only implement certain optimizations
> if certain known options are provided, but not if any unknown ones are?
> 
> That way those who'd like the faster happy path could use that subset of
> options, while the general API would allow any revision options. We'd
> then error() or BUG() out only if we fail to map our expected paths to
> OIDs.
 
This option requires examining the long and ever-growing list of options
to struct rev_info which will take much more work than parsing a starting
ref and a path from the command-line.

> I think those are all good ways forward here, and I'd much prefer those
> to having to re-implement or pull out subsets of the current option
> parsing logic in revision.c. What do you think?

I think you are skirting over the difficult part about upstreaming the
blame-tree command, which is the biggest reason we have not done it in
the past. The way it is implemented in our fork started with this "just
parse args using revision.c" because that's the easiest way to implement
the naive implementation, but we were able to make optimizations on top
only because we had full control over the callers not using any other
options. We would not have been able to make the assumptions that allowed
those performance enhancements without that control. Actually building the
interface in a way that guarantees the behavior will be stable and
understood is not easy, but is worth doing well.

Thanks,
-Stolee

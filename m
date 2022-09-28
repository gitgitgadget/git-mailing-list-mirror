Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E916C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 18:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiI1SKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiI1SKI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 14:10:08 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781167471
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:10:06 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id v128so10784934ioe.12
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=67xXDMS7bxsnpyrYcQEzYA9XpocWE9oRSWmkPyq+63w=;
        b=CsGNHpY74AN3Ps9gQLZXNLz0W0rHxFjLUdY3ST/Vf9nAKDs/UxJp5M0QOoj8NhVJ7k
         sXizE3cfR5IEM4wgbAe9QrdVv8mzVMmpbqEaOJwyFc5bbba9bi891z0J8r+8MIqNbVMJ
         FqNMJNM+EnUsvGMQ/0NpA+I4dplJa5xlgSo7lQavn6NtuysvAsryCLNVRvHQ+BPGIe6m
         mkMSvE/8jm+rpiAXRclj+QNqDDZ1/QHDF46hJkJoZVhnZTlyYlLP0KbSHdb91KvsxztR
         kohxRdO53KBaxSaVgVOjV/mXZwDQljl+C7aOpezk/SJS7y4PJ7DpB3FUB5eiyR6K4hSe
         3eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=67xXDMS7bxsnpyrYcQEzYA9XpocWE9oRSWmkPyq+63w=;
        b=cIrQ08crGyi3qooJRb39+hn8Dqbf5r0F8h9gTYuOMwQgMpX/xmUenX2eJPOKk+mbtb
         cQv3mhlfiA43YAJ8RR3FOEIdbv9wN5i+t2KCZS1i+SkZ4Fl/DpN/UPVm0V/Ftlz9dwHB
         mLtlqXijhQ3xTgvwmmerrMTs2rSa474PHKYSm4RD+wpiwWRpGTN6w2nz/zSzuRUI+Ppv
         KKPvMkdpg+ZVaU9nUI3zCye053ljLA5C9c7mQjcoyRfpY5csQBbi+2umGnxAWUXgWO9k
         XURZzmZJpZpslPwPr7TXF2u5Zqo+1xrHyFXX1VEv1Q07V5SM7WXPPqXbTODbllW0htuz
         1+XA==
X-Gm-Message-State: ACrzQf32rsh1OhrqvbUETMdoH00m9WfbDTiKVktrPxqaUbA+5ALZn69D
        aeQskHfIcskEv19I0LDn66C6Udqd94Bu
X-Google-Smtp-Source: AMsMyM6WpmKnLudwaFs7jGmH/949B+yXIu6/qE9rvkcVH30tEV+oQ8FB3EpoULCVuMS3hUsYRinIPA==
X-Received: by 2002:a05:6638:f83:b0:35a:d85:ab65 with SMTP id h3-20020a0566380f8300b0035a0d85ab65mr18093727jal.240.1664388606177;
        Wed, 28 Sep 2022 11:10:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e862:ab6a:f799:c583? ([2600:1700:e72:80a0:e862:ab6a:f799:c583])
        by smtp.gmail.com with ESMTPSA id e66-20020a028648000000b00349c45fd3a8sm2081691jai.29.2022.09.28.11.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:10:05 -0700 (PDT)
Message-ID: <31ceb36b-3c60-c4c2-c6fb-3f602eb9d4ea@github.com>
Date:   Wed, 28 Sep 2022 14:10:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
 <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
 <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
 <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
 <26b3c9ef-5dd7-18f2-89c4-8d210a409ce4@github.com>
 <220928.86y1u3wnaz.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220928.86y1u3wnaz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/28/2022 10:37 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Sep 28 2022, Derrick Stolee wrote:

>> If we return a negative value on an error and the number of matches on
>> success, then this change could instead be "if (repo_config....() > 0)".
> 
> Hrm, I think you're confusing the worldview your series here is
> advocating for, and what I'm suggesting as an alternative.
> 
> There isn't any way on "master" to have "an empty list", that's a
> worldview you're proposing. In particular your 1/5 here removes:
> 
> 	assert(values->nr > 0);

Yes, I think the lack of a key should be the same to an empty list
because it is logically equivalent and an empty list is safer to use
than a possibly-NULL list. That's what started this whole investigation.

By no longer returning NULL, we can eliminate an entire class of bugs
from happening.

> More generally the config format has no notion of "an empty list", if
> you have a valid key-value pair at all you have a list of ".nr >= 1".

The critical part is that you have a return code that has three modes:

 1. Negative: some kind of parsing error happened, such as a malformed
    'key' parameter.

 2. Zero: The 'key' was found with multiple values.

 3. Positive: The 'key' was not found. (Are there other innocuous
    errors that fit in this case?)

This "positive means not found" is very non-obvious.

Even with your goal of exposing those parsing errors when the 'key' is
user-supplied, I still think it would be better to provide a non-NULL
empty string_list and only care about these return values:

 1. Negative: some kind of parsing error happened.

 2. Nonnegative: parsing succeeded. The string_list has all found values
    (might be empty) and the return value is equal to the string_list's
    'nr' member.

In these cases, I see two modes of use.

First, check for an error and exit early (empty list no-ops naturally):

	if (git_config_get_const_value_multi(key, &list) < 0)
		return -1;

	for_each_string_list_item(item, list) {
		...
	}

Second, ignore errors. Care about non-empty list:

	if (git_config_get_const_value_multi("known.key", &list) > 0) {
		...
	}

But this is just a matter of taste at this point, and I'm getting the
feeling that my taste for reducing the chances of NULL references is
not very popular.

Thanks,
-Stolee

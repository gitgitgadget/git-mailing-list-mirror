Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FBDC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiKPOJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiKPOIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:08:53 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2E25C71
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:08:05 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id s20so11646828qkg.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ys0+MejAgjdBVOuJliCZYQX3tPB72BLf/hqHn1sygwk=;
        b=isi0/NUwXuuGAE+YAeQRTaEcFN3z+FRNwFTWVptQsfCOyr2GYD0dOx4GgbZdsdQWfz
         285lxkCQkdt3L8IW+S8FcdrDDTRqs7Ebw7Ze2qxbJVDkqMvBloYjh9xWa932TPErdfbu
         gXJpEBcMFoxrca9EmVi/S/cZ5RxbAYyi3U3z129ChkeDRUQiuHuWND4WWl/OLRnGdwO8
         Fg2EPTpTcDDOK5qUdv1nYn7DRtk1dwVd82fgTFKTymtYPER0P8dRg1dgPX0kS5mNq+ys
         SnEmXWXtCz+wL9dI343Xnd6jqWOuKsex6Rgyn+5Wh9L7OWCEwApfKXeI3MV4qIKKVLhe
         ZVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ys0+MejAgjdBVOuJliCZYQX3tPB72BLf/hqHn1sygwk=;
        b=wYugdElvxeS7r1XZ1et4Ly5r9G8cxb8aBzWmTt7wML2urgzclWbsvJi3sfWtlMrHJ2
         +CQAjxUCNQDlo5ToJio1Uv8CclMUhzz9Cu1OnQzI635voKRtOVQOpsC+Y5h8YY6sFGX4
         gq9iLQGmMCZAws+x2z12kSuv9LU6M43WRh4O1ibAiOkE8tmVbpoTC2/6IKhCMr/NGfnr
         Q+5fzokyAqt/1riC0jplxPE34Fz4KwOHzF+pfSMwBg52LBCHva4h+seVL3Aef5TUViWf
         DvagkUGGDGyRw8q9Sn9chknuvKdnhaXUKg3aBmN3bu4OGzGkSu0gmu0V795xrWfpobcQ
         L+mg==
X-Gm-Message-State: ANoB5pk2yLNdxxGPAVnYOjMCx7sKi4pJ95LDzVQ0GajZk7/dpAH5CZcJ
        xnmpwzBctuq2Xgkkg1PSMNgd
X-Google-Smtp-Source: AA0mqf79ZT03wl9I2t+tOKfGanAIE1JZa+zrjcxn/4rHdPGaxmUWFOVsSEOHk4XPbwY1ieu08iOkMQ==
X-Received: by 2002:a05:620a:c43:b0:6fa:6423:65b6 with SMTP id u3-20020a05620a0c4300b006fa642365b6mr12326216qki.324.1668607684029;
        Wed, 16 Nov 2022 06:08:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f553:9f0c:85c5:38e1? ([2600:1700:e72:80a0:f553:9f0c:85c5:38e1])
        by smtp.gmail.com with ESMTPSA id bk8-20020a05620a1a0800b006f9f3c0c63csm10113596qkb.32.2022.11.16.06.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 06:08:03 -0800 (PST)
Message-ID: <ca11478b-7b44-3018-04d8-0b84c4f43b56@github.com>
Date:   Wed, 16 Nov 2022 09:08:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] protocol v2: add server-side "bundle-uri" skeleton
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <a02eee983185815d94ba1124b43eae43280aa963.1667264854.git.gitgitgadget@gmail.com>
 <508ba524-09d2-81f1-c5f8-815ab766791a@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <508ba524-09d2-81f1-c5f8-815ab766791a@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/22 8:59 PM, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
>> +
>> +PROTOCOL for bundle-uri
>> +^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +A `bundle-uri` request takes no arguments, and as noted above does not
>> +currently advertise a capability value. Both may be added in the
>> +future.
>> +
>> +When the client issues a `command=bundle-uri` the response is a list of
> 
> nit: comma after `command=bundle-uri`
> 
> I misread this a couple times dropping the "the", so it read like the
> `command=bundle-uri` was the *response*, not the request. I think the comma
> would help avoid that?

I think this should be

  When the client issues a `command=bundle-uri` request, the response is...

>> +key-value pairs provided as packet lines with value `<key>=<value>`. The
>> +meaning of these key-value pairs are provided by the config keys in the
>> +`bundle.*` namespace (see linkgit:git-config[1]).
> 
> What does this ("the meaning of these key-value pairs are provided by the
> config keys...") mean? Are the response keys in the `bundle.*` namespace? Or
> do the client-side `bundle.*` keys provide some kind of translation of what
> the keys mean?

I can elaborate more here, but the intention is that the protocol defines
only how these key-value pairs are delivered, and how the client assigns
meaning to those values and acts upon them is defined elsewhere.

>> +
>> +Clients are still expected to fully parse the line according to the
>> +above format, lines that do not conform to the format SHOULD be
>> +discarded. The user MAY be warned in such a case.
> 
> Why "still" - is there some reason they *wouldn't* parse the response line? 

"still" is not needed here.

> Is "the above format" referring to `<key>=<value>` in general, or restricted
> to/guaranteed that the `<key>`'s defined by the `bundle.*` namespace? I'm
> guessing "still expected to fully parse" == "MUST parse" (using
> MUST/SHOULD/MAY nomeclature), it would help to call that out explicitly to
> be consistent with the rest of this doc.

Using MUST simplifies things a lot.

>> +
>> +bundle-uri CLIENT AND SERVER EXPECTATIONS
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +URI CONTENTS::
>> +The advertised URIs MUST be in one of two possible formats.
>> ++
>> +The first possible format is a bundle file that `git bundle verify`
> 
> I don't think "format" is the right word to describe this (I'd reserve
> "format" for the literal format of the URI string). Maybe something like
> this?
> 
> 	The advertised URIs MUST contain one of two types of content.

How about...

"The content at the advertised URIs MUST be one of two types" ?

> 	The advertised URI may contain a bundle file that `git bundle
> 	verify` would accept...
> 
> 	...
> 	
> 	Alternatively, the advertised URI may provide a plaintext file...
> 
>> +would accept. I.e. they MUST contain one or more reference tips for
>> +use by the client, MUST indicate prerequisites (in any) with standard
>> +"-" prefixes, and MUST indicate their "object-format", if
>> +applicable. Create "*.bundle" files with `git bundle create`.
> 
> The last sentence doesn't add anything that you don't know from the `git
> bundle verify` note in the first doesn't already tell you, and feels like a
> bit of a non-sequitur as a result. Although, it tangentially raises a
> question: do bundle files *have to* have the '.bundle' suffix to pass `git
> bundle verify`? If not, are they expected to when coming from these URIs?
 
The files do not need that extension. This sentence can be removed.

>> +WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION::
>> +If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
>> +of the bundle(s) the client finds that the ref tips it wants can be
>> +retrieved entirety from advertised bundle(s), it MAY disconnect. The
> 
> s/entirety/entirely

Thanks.

> And to clarify, by "it MAY disconnect", you mean it may disconnect from the
> main repository server? Or the bundle server? 

The main repository server, since the bundle server is not speaking
the Git protocol, but there is definitely room to clarify here.

>> +bundle-uri PROTOCOL FEATURES
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +As noted above the `<key>=<value>` definitions are documented by the
>> +`bundle.*` config namespace.
> 
> Same comment as earlier - this is a confusing way to phrase this. If you
> mean "the keys are part of the `bundle.*` namespace documented in
> linkgit:git-config[1]", I think you can just say that directly. If not, it
> would help to clarify the relationship between the `bundle.*` namespace and
> these keys.

Will do.

> Overall, this document is quite thorough, especially with respect to edge
> cases/error handling. I found it a bit confusing at times (at least
> partially due to my unfamiliarity with protocol v2), including some
> potentially ambiguous phrasing or scenarios (especially those in the
> disconnection & error recovery sections) that are difficult to clearly
> describe in generic terms.
> 
> I think some sections (especially "PROTOCOL for bundle-uri" and "bundle-uri
> CLIENT AND SERVER EXPECTATIONS") would benefit from examples of what "good"
> and "bad" request/response values & behaviors look like; they would help
> illustrate some of those more complex situations. The rest of the patch (the
> implementation & tests) looked good to me. 

This is an interesting idea, although the examples of "good" and "bad" are
probably best left as the test cases. Looking through the rest of this
document, this section is already much more verbose than the others, so I
hesitate to add these examples at this point. Perhaps there is room to
improve the whole document with such examples as a follow-up.

Thanks,
-Stolee

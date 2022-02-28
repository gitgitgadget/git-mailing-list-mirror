Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37323C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiB1PwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1PwK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:52:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217F7B542
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:51:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so16126072wrg.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuE9RquUXbFoMqNlKJtiMjtyxdz/02nozdRVNegPAsM=;
        b=Yb2Z3eXf4KKRJ7bEEbsbBYbTVO5dkKiNRane7SxaxmF/evc2lIQBRKbacPAubC9Nuz
         mzzTSW4j2hv+bd5Njsg8i5ajV4xuTMBFTqN6WhjWASdY2uwS/IhoGEOUDBgJbHLepoEN
         PbCf7fq2hQT1YcbnK9MGa9EKRCYR5JzXXLYIKFRsMZYvOfsh1pzQOnEPO97QQ/adWd4g
         MHg9DAP4/+bpUuR5YJB/oip/XCEIfFXCbQz3NwgheJk8mdSGrQSt7+Px8KpZukRVYmPK
         nHzYjkWff2WZv+w76h8T/N2rI2dONyRwjxEMqGFFBAsDerMrp37CZwedJsD7Ix8gJQN3
         O0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuE9RquUXbFoMqNlKJtiMjtyxdz/02nozdRVNegPAsM=;
        b=52t1Ri16zViGuT6xq4zIdeEEV/BQRB2R+OZJjAMp0X4SeUPLKQJCVHJgP6Q0Qws3y9
         jSpJkpcm55ltw1EXqUkETjXfzrABGyNE9x3tPwLuij2rxH2ZxeK0NXvuYoZbPSyHfxZS
         8cMgeSqhEvfV1naSKxg/C5m6uaqfxHcX1ISgrwntLiGige2bvNXKXwIfUy5mSB5L+YR7
         VV3SmkEVA1PuWKKKeIekw78PlRsjNKPxOxg82kzgpbozlpPGRXt5yH3gV2CB7ljgNqRQ
         2WVZANKMLLkP/GebNqLv3CpC6nHVqCNruI1b3rWONWqwta0UHEhGoF3EzKoW85FhQSJG
         shJA==
X-Gm-Message-State: AOAM532Hcb802HcL7pmwIIYCoa0pgFl98EP1fcmFlB0pIfrSu7dgB7NJ
        HXf4n9xQNLcGqmmCzrGv0io=
X-Google-Smtp-Source: ABdhPJz6/SAOQONZXdrGNhtmsKrmlmqVrzMKTT9b52ZX0l+fg+kUiyXZ97c0gLbQqKR/Kd95d9paJA==
X-Received: by 2002:a5d:64c1:0:b0:1e4:987a:51b with SMTP id f1-20020a5d64c1000000b001e4987a051bmr16613411wri.471.1646063489320;
        Mon, 28 Feb 2022 07:51:29 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm15039965wme.29.2022.02.28.07.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 07:51:28 -0800 (PST)
Message-ID: <90d23574-a211-1294-c842-9e033757972d@gmail.com>
Date:   Mon, 28 Feb 2022 15:51:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
 <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
 <faa70086-3c15-1187-93a0-88f1e1120dbf@gmail.com>
 <220228.867d9f5jat.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220228.867d9f5jat.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/2022 11:16, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Feb 28 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 25/02/2022 09:04, Ævar Arnfjörð Bjarmason wrote:
>>> We have various behavior that's shared across our Makefiles, or that
>>> really should be (e.g. via defined templates). Let's create a
>>> top-level "shared.mak" to house those sorts of things, and start by
>>> adding the ".DELETE_ON_ERROR" flag to it.
>>> See my own 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR"
>>> flag, 2021-06-29) and db10fc6c09f (doc: simplify Makefile using
>>> .DELETE_ON_ERROR, 2021-05-21) for the addition and use of the
>>> ".DELETE_ON_ERROR" flag.
>>> This does have the potential downside that if
>>> e.g. templates/Makefile
>>> would like to include this "shared.mak" in the future the semantics of
>>> such a Makefile will change, but as noted in the above commits (and
>>> GNU make's own documentation) any such change would be for the better,
>>> so it's safe to do this.
>>
>> I was confused about the mention of templates/Makefile in this
>> paragraph, it seems to be saying that the behavior would change in the
>> future if we included shared.mak in templates/Makefile but this patch
>> does exactly that.
> 
> Yes, oops! It's a zombie comment that I forgot to adjust from an earlier
> version of this where that wasn't the case. Will adjust & re-roll.
> 
>> Also does this patch mean we're now using .DELETE_ON_ERROR in places
>> where we were not previously using it?
> 
> Yes, we'll now use it in those other Makefiles as well. The commits
> referenced in the second paragrap of the commit message argue for this
> being safe, and I've reviewed the logic myself & don't expect any
> problems with it.

Thanks for elaborating, maybe it is worth spelling explicitly in the 
commit message that this is turning on .DELETE_ON_ERROR in places we 
didn't previously use it. I had a look at the commit message you 
referenced and it seems to make a good case for using .DELETE_ON_ERROR. 
Having a shared makefile for common code makes sense and the speed ups 
from some of the other commits are nice.

Best Wishes

Phillip

> As the GNU make manual itself notes the cases where that would cause
> problems are really obscure, but it's not the default out of an
> abundance of backwards compatibility caution in GNU make.
> 
>>> This also doesn't introduce a bug by e.g. having this
>>> ".DELETE_ON_ERROR" flag only apply to this new shared.mak, Makefiles
>>> have no such scoping semantics.
>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> ---
>>>    Documentation/Makefile    |  6 +++---
>>>    Makefile                  | 13 +++----------
>>>    contrib/scalar/Makefile   |  3 +++
>>>    contrib/scalar/t/Makefile |  3 +++
>>>    shared.mak                |  9 +++++++++
>>>    t/Makefile                |  3 +++
>>>    t/interop/Makefile        |  3 +++
>>>    t/perf/Makefile           |  3 +++
>>>    templates/Makefile        |  3 +++
>>>    9 files changed, 33 insertions(+), 13 deletions(-)
>>>    create mode 100644 shared.mak
>>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>>> index ed656db2ae9..ba27456c86a 100644
>>> --- a/Documentation/Makefile
>>> +++ b/Documentation/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../shared.mak
>>> +
>>>    # Guard against environment variables
>>>    MAN1_TXT =
>>>    MAN5_TXT =
>>> @@ -524,7 +527,4 @@ doc-l10n install-l10n::
>>>    	$(MAKE) -C po $@
>>>    endif
>>>    -# Delete the target file on error
>>> -.DELETE_ON_ERROR:
>>> -
>>>    .PHONY: FORCE
>>> diff --git a/Makefile b/Makefile
>>> index 6f0b4b775fe..d378ec22545 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include shared.mak
>>> +
>>>    # The default target of this Makefile is...
>>>    all::
>>>    @@ -2194,16 +2197,6 @@ shell_compatibility_test:
>>> please_set_SHELL_PATH_to_a_more_modern_shell
>>>    strip: $(PROGRAMS) git$X
>>>    	$(STRIP) $(STRIP_OPTS) $^
>>>    -### Flags affecting all rules
>>> -
>>> -# A GNU make extension since gmake 3.72 (released in late 1994) to
>>> -# remove the target of rules if commands in those rules fail. The
>>> -# default is to only do that if make itself receives a signal. Affects
>>> -# all targets, see:
>>> -#
>>> -#    info make --index-search=.DELETE_ON_ERROR
>>> -.DELETE_ON_ERROR:
>>> -
>>>    ### Target-specific flags and dependencies
>>>      # The generic compilation pattern rule and automatically
>>> diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
>>> index 5b12a437426..6fb5cc8b701 100644
>>> --- a/contrib/scalar/Makefile
>>> +++ b/contrib/scalar/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../../shared.mak
>>> +
>>>    QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
>>>    QUIET_SUBDIR1  =
>>>    diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
>>> index 6170672bb37..01e82e56d15 100644
>>> --- a/contrib/scalar/t/Makefile
>>> +++ b/contrib/scalar/t/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../../../shared.mak
>>> +
>>>    # Run scalar tests
>>>    #
>>>    # Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
>>> diff --git a/shared.mak b/shared.mak
>>> new file mode 100644
>>> index 00000000000..0170bb397ae
>>> --- /dev/null
>>> +++ b/shared.mak
>>> @@ -0,0 +1,9 @@
>>> +### Flags affecting all rules
>>> +
>>> +# A GNU make extension since gmake 3.72 (released in late 1994) to
>>> +# remove the target of rules if commands in those rules fail. The
>>> +# default is to only do that if make itself receives a signal. Affects
>>> +# all targets, see:
>>> +#
>>> +#    info make --index-search=.DELETE_ON_ERROR
>>> +.DELETE_ON_ERROR:
>>> diff --git a/t/Makefile b/t/Makefile
>>> index 46cd5fc5273..056ce55dcc9 100644
>>> --- a/t/Makefile
>>> +++ b/t/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../shared.mak
>>> +
>>>    # Run tests
>>>    #
>>>    # Copyright (c) 2005 Junio C Hamano
>>> diff --git a/t/interop/Makefile b/t/interop/Makefile
>>> index 31a4bbc716a..6911c2915a7 100644
>>> --- a/t/interop/Makefile
>>> +++ b/t/interop/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../../shared.mak
>>> +
>>>    -include ../../config.mak
>>>    export GIT_TEST_OPTIONS
>>>    diff --git a/t/perf/Makefile b/t/perf/Makefile
>>> index 2465770a782..e4808aebed0 100644
>>> --- a/t/perf/Makefile
>>> +++ b/t/perf/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../../shared.mak
>>> +
>>>    -include ../../config.mak
>>>    export GIT_TEST_OPTIONS
>>>    diff --git a/templates/Makefile b/templates/Makefile
>>> index d22a71a3999..636cee52f51 100644
>>> --- a/templates/Makefile
>>> +++ b/templates/Makefile
>>> @@ -1,3 +1,6 @@
>>> +# Import tree-wide shared Makefile behavior and libraries
>>> +include ../shared.mak
>>> +
>>>    # make and install sample templates
>>>      ifndef V
> 


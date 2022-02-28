Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA61C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiB1S2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiB1S2n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:28:43 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E57E4486
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:11:50 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 17-20020a170902ee5100b0014fef809980so5129219plo.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=J93nlxVGqTmyJVtxJRMuzGNHoty7+jRmxp8daxmiFPg=;
        b=PNBkqr//Vaz38NJ9K2Kgda0CJ86KNWBStuflWMQMa/0GM9+X2UEKvGvFQwyw3ijeKZ
         v6Mp/+aQbXRPmEoZvJoaR1g3UG6P5gJK9WqZRB5MqrgfJ0MvwX4quah6COq4rNfhaBAW
         hRxRjss9SY7mQDDabA3JQU2Ipcy5f91QwPVFIKIcPj5hloByP2jB/TCC4CjcPxWDfudt
         rPcOZ9EBi0qzijvsf1x2jjK90rUGDwmU/TJ0uyk6qwZbWzo12pGy51XF3Lyi6qIjFh7I
         /EnSCWL7P/6TruG59MD5A9Ufs09UWSTbWWrmpLygXGnBkH1T/lvdSkA/CYcE9TWaHkv8
         1tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=J93nlxVGqTmyJVtxJRMuzGNHoty7+jRmxp8daxmiFPg=;
        b=5HtcbxQohpOJGuK5o6vBiUs/mWN6dvNba85lVKNWbpDkCB5ifQ9aBqnIw3CavBATyO
         c7/liA0WFIya6EXZy7JjVLGT+0PBXaqjPZv3wXUUc6ZdK8r5Iu1/3Mpt8uqYsygPtXET
         e3s9i+auZ3TPjQ/5OSgmrhU+OODlcCR3oINF+5S2JyB/grJpAjU4I8mPJYfO1jQv7nZN
         GsacsCPwIAFmoEvZ8R03jvDqN21UPqaK3zFBEsDe1bgQgQf4lKaOcqlgeIOSEaxLkiYZ
         fCB1yRBLThcXMMjpgtybp9Su1Od3QTabzfxQRli1S/6RX+WftDa0cwJdPUhGvcReMgcx
         3TVw==
X-Gm-Message-State: AOAM53225qhpNNPtpWfmgcTl8SNjtFQNTA5VrbyonKS5ryAOnMKdUbEG
        2JiTOzfYFEg/WV07KiQu8yRmG4GKiBhdqw==
X-Google-Smtp-Source: ABdhPJx+7JGohPTnCLqMw8oa/KBh6krHYbrACvNFALe3zkBKbz+EaI4782NioT24E05lmpsjH2/yjyt40JzF9A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4581:b0:1bc:d215:8722 with SMTP
 id v1-20020a17090a458100b001bcd2158722mr17909195pjg.149.1646071901716; Mon,
 28 Feb 2022 10:11:41 -0800 (PST)
Date:   Mon, 28 Feb 2022 10:11:39 -0800
In-Reply-To: <220225.86pmnb8931.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l8rtuq2sk.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220224231420.2878760-1-jonathantanmy@google.com>
 <kl6lfso74pzm.fsf@chooglen-macbookpro.roam.corp.google.com> <220225.86pmnb8931.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v3 03/10] t5526: create superproject commits with test helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Feb 25 2022, Glen Choo wrote:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Glen Choo <chooglen@google.com> writes:
>>>> +# For each superproject in the test setup, update its submodule, add =
the
>>>> +# submodule and create a new commit with the submodule change.
>>>> +#
>>>> +# This requires add_submodule_commits() to be called first, otherwise
>>>> +# the submodules will not have changed and cannot be "git add"-ed.
>>>> +add_superproject_commits() {
>>>> +(
>>>> +	cd submodule &&
>>>> +	(
>>>> +		cd subdir/deepsubmodule &&
>>>> +		git fetch &&
>>>> +		git checkout -q FETCH_HEAD
>>>> +	) &&
>>>> +		git add subdir/deepsubmodule &&
>>>> +		git commit -m "new deep submodule"
>>>> +	) &&
>>>
>>> The indentation looks off. Also, no need for "-q".
>>
>> Ah thanks. I think the "-q" is there to suppress the detached HEAD
>> warning, which is very large.
>>
>> I'd prefer to keep it unless there are stronger reasons than "it's not
>> needed for correctness".=20
>
> FWIW I was going to comment on the -q, but didn't because you're just
> moving this around.
>
> I think even for large warnings it's fine to omit -q etc, since that's
> what --verbose (as in the test-lib.sh argument) is for.

Ah interesting, I didn't consider that. Thanks!

> But in this case it's probably better to leave it as-is.

I'm also leaning towards this because I'm just moving things around, but
I could be convinced otherwise.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF50DC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbiCaOut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiCaOus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 10:50:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250AF9D055
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 07:49:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1838364wme.5
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t0v+qQaMKfYbOKciRAvfuw5eSjgfN4Yk/i2EhjL0CLM=;
        b=gPiFVnZeGtHcPvVgNu7jhErJiSdoH1JNXio+gKtAUJGUj8EV7EQZCAQKX+H3nDiTdD
         6Vljm0/Lh8Q7jdKEUDZG/PhLiS0sThZNJJnfyo/a5zH57xJnqA9Qf9kmmkrgn6ZkNNwh
         vx0uX2V0rXohmOVPOngB80VCfTpqOIFHTvWrPf9/BIG7ROvpsTUEhVDMMQbSNjPccRED
         +nLbid9JxK76zeK8qbvJNnLRztyCZq+1oRzK4aAo2U+k64fVcGsJt5s3Ky841vXwf/Ce
         8eCJUoSIiAGrjJhPwkUlMK9fOGqgBGrRTjucAzDfzk1nHEH5HbcjC5tJgZFpfQuKiJ60
         YlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t0v+qQaMKfYbOKciRAvfuw5eSjgfN4Yk/i2EhjL0CLM=;
        b=kmwb7rzsItqMZlyja08IfIdsLv5Yg7sqZGjR4LrApgppVkqwOFFBhTnL3Aai3Fh3vw
         pQ82qnYFlvP/O0OZslpQzo1Hbbh+Vs+lSKRAKlcfzNDIK41UR/UASac+FgRZ3l1wEj6F
         l5+VlKerLdyqpCUwuE25N6C8Z8IkYC5XzTVqDdbcfbW0kSwknEqsesn8rUKxGSFNTwxT
         XXSoaF2q9Lee0LonswcWMso8nhanJs3fShoYcyoWghg4QDlpE4UOiwNEv6o7QcYIRRmP
         QbzAJRAGLE8t6CRKDZpQO5wLQ0SGuDlJQQzbeoqbwZesVkTU8/HKvdEd+q0aJUCg5XKi
         KryQ==
X-Gm-Message-State: AOAM531M54efcz03k8JlfgXAx6BNgoX3uFVaHpaWy8Bglerou5Ad5MJs
        Q6FWDR5Q93Tkkyy4Ya2huzg=
X-Google-Smtp-Source: ABdhPJxtYkuf0lhlvr2K7sWlD3Scf96SwiwMy8z8xPTj3waPkmVIKHQVoCUqSn0vhIaf9+lAYIkjoQ==
X-Received: by 2002:a7b:c778:0:b0:38c:9064:89fc with SMTP id x24-20020a7bc778000000b0038c906489fcmr4934604wmk.175.1648738138645;
        Thu, 31 Mar 2022 07:48:58 -0700 (PDT)
Received: from [192.168.1.240] (179.2.7.51.dyn.plus.net. [51.7.2.179])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00203fb5dcf29sm19615714wrx.40.2022.03.31.07.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:48:58 -0700 (PDT)
Message-ID: <bf44f83b-0d18-8132-58cf-13155bfec40e@gmail.com>
Date:   Thu, 31 Mar 2022 15:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] CodingGuidelines: give deadline for "for (int i = 0; ..."
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqy20r3rv7.fsf@gitster.g>
 <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220331.86v8vuqv95.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/03/2022 11:10, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 30 2022, Junio C Hamano wrote:
> 
>> We raised the weather balloon to see if we can allow the construct
>> in 44ba10d6 (revision: use C99 declaration of variable in for()
>> loop, 2021-11-14), which was shipped as a part of Git v2.35.
>> Document that fact in the coding guidelines, and more importantly,
>> give ourselves a deadline to revisit and update.
>>
>> Let's declare that we will officially adopt the variable declaration
>> in the initializaiton [...]
> 
> Typo: initialization.
> 
>> part of "for ()" statement this winter, unless we find that a platform
>> we care about does not grok it.
> 
> I'd think that waiting a couple of releases would be sufficient for this
> sort of thing. I.e. contributors to this project already have
> access/knowledge about a wide variety of compilers, especially the
> "usual suspects" (mainly MSVC) that have been blockers for using new
> language features in the past.
> 
> So I'm in no rush to use this, and the winter deadline sounds fine to
> me in that regard.

Agreed, I think it is worth waiting so we don't get into a situation 
where we end up having to revert changes that are using the new features 
because we discover they are not supported by a platform we care about.

> But on the other hand I think the likelihood that waiting until November
> v.s. May revealing that a hitherto unknown compiler or platform has
> issues with a new language feature is vanishingly small.
> 
>> A separate weather balloon for C99 as a whole was raised separately
>> in 7bc341e2 (git-compat-util: add a test balloon for C99 support,
>> 2021-12-01).  Hopefully, as we find out that all C99 features are OK
>> on all platforms we care about, we can stop probing the features we
>> want one-by-one like this
> 
> Unfortunately this really isn't the case at all, the norm is for
> compilers to advertise that they support verison X of the standard via
> these macros when they consider the support "good enough", but while
> there's still a long list of unimplemented features before they're at
> 100% support (and most never fully get to 100%).
> 
> We also need to worry about the stdlib implementation, and not just the
> compiler, see e.g. the %zu format and MinGW in the exchange at
> https://lore.kernel.org/git/220318.86bky3cr8j.gmgdl@evledraar.gmail.com/
> and
> https://lore.kernel.org/git/a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.com/;

That's a good point, it was a surprise to me that the problem is with 
MinGW rather than MSVC.


Best Wishes

Phillip

> But I think we're thoroughly past needing to worry about basic language
> features in C99 such as these inline variable declarations.
> 
>> (it does not necessarily mean that we would automatically start using
>> any and all C99 language features, though).
> 
> Yes, particularly those that the standards committee backed out of or
> made optional after C99 would be good candidates for avoiding
> permanently.

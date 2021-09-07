Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358CC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B910E61102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbhIGNtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbhIGNtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:49:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DBC061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:48:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so10013538pgm.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Jjh5Rjy2dM2fpXwPZmgkGUhYcNJMzNhmpm3aamhhFbc=;
        b=FItafL5kVtFUrzQrsIK+dU3hAsG2fT1xzuS3GHrtjMOb45Q5QfRGfSLkw79fmmQjCu
         8MeH/JJiAdCi19oD9/4S3sBHnFRrfkBvBSRa8nM6v8bng4DKXVz/ZS7uDLJRZ5tEiNJ1
         MAINczoeYxLEnuOgMwtnGMmUL5QSgnQ4kNO1akQGHkjyWIv9XFW6+8c+Q34fkEHgZWNn
         gB7JMMvzeAalznGK86vPxqSSJ2swwQchKf4fboM4JzFcBp+odhqJDvEIogkPFiFOwyOJ
         H9aZvtOvfwd8RUkInCpgZx9lGd9yzHGw8CNGoKXZLvVfKaj47tYmrJRw0hnCJkT+iZNj
         Miyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Jjh5Rjy2dM2fpXwPZmgkGUhYcNJMzNhmpm3aamhhFbc=;
        b=UxVLT3NlytLeQhFTAXn5ZMMoQMZy5FN2GSqWoI1TnJIdT9bWTfXDje2MA8fuH/1foo
         USLgkdYeySIrr27hnnEmf3gnI16gDZ8TBMJaZ3du1u3Jfns/1KUomuwN4MH1YjepksQn
         VYdMDpqI1aDMF0YBgdGWsJUJ6i6/N9JsLbSIB4wMnmps5ryiU5kfNKX1nwcGqwLM4/qH
         h2cO+kj2gKMTLUqB9RIfD6wftGUVliWtVZPVDD2Oj8xWrwDxDpFPVqZlcrONNyE9U7w3
         7GRM0R7IlEtqWSLJ49pcpCJu8mDp7YY7arTH/ZNAIJjkEcUGZk9CSmijjinNLp5pctbn
         k/7g==
X-Gm-Message-State: AOAM531nJUwQLaoT/Bt5XC//0brPX84XU68ETVFeaDKVZAQdu+EXiKx3
        R8+yqalujz4iEwZGgPi41VY=
X-Google-Smtp-Source: ABdhPJx7heRqSd25q5Yivl00Eb7ibpLlYwHYSRywjzSWVk68cDrwRvcIzXXNzqN9G4x5pOO3Wn9TIg==
X-Received: by 2002:a63:215c:: with SMTP id s28mr16795381pgm.99.1631022519820;
        Tue, 07 Sep 2021 06:48:39 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id 15sm11018800pfu.192.2021.09.07.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:48:39 -0700 (PDT)
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210907115932.36068-3-raykar.ath@gmail.com>
 <871r60muge.fsf@evledraar.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        emilyshaffer@google.com, gitster@pobox.com, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH 02/13] submodule--helper: get remote names from any
 repository
Date:   Tue, 07 Sep 2021 19:03:48 +0530
In-reply-to: <871r60muge.fsf@evledraar.gmail.com>
Message-ID: <m2czpklcnh.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Sep 07 2021, Atharva Raykar wrote:
>
>> `get_default_remote()` retrieves the name of a remote by resolving the
>> refs from of the current repository's ref store.
>>
>> Thus in order to use it for retrieving the remote name of a submodule,
>> we have to start a new subprocess which runs from the submodule
>> directory.
>>
>> Let's instead introduce a function called `repo_get_default_remote()`
>> which takes any repository object and retrieves the remote accordingly.
>>
>> `get_default_remote()` is then defined as a call to
>> `repo_get_default_remote()` with 'the_repository' passed to it.
>
> I'd find this easier to follow if this were just squashed into the next
> commit. Both are rather small, but following the context of first adding
> a function, then using it, instead of just adding it, changing the old
> users etc. is harder than just having it in one commit.

I am in two minds about this. I initially had both these changes in one
commit, but Christian suggested I split the changes into a part that
refactors existing code (this commit), and one that introduces a new
helper (the next commit).

I guess I will squash it for now and see how it is received. Maybe
bringing down the "/13" might help get more reviews ;-)

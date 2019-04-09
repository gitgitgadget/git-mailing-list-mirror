Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD2720248
	for <e@80x24.org>; Tue,  9 Apr 2019 08:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfDII3a (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 04:29:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40147 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfDII30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so2232230wmi.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4xvRj1fvFWl4EtzEk4OxBkEwVVPN9GHGuLFuzq4AnSY=;
        b=iX7I7tULwQHNPsaVVpaQwf+h9fxqIJBC0E1pUbWaeg0DEf7jmey5PrVM3HIaImX0hn
         o08T8jWyM+/jtmCxJ7BS+rDh7wtagPB/LTn0lMjtOA1usIr/f5+m0A0USCG57qZAa4Qh
         YimDJnLYRjDZDZzw6tH/eiHR3GDkU+F+e0ytVtbc+Za9OLDv2sf2bp6pEM8ik9XlNK7J
         X9i6J8yzj7b5VRt1GyCS2ZKhdUvaop0hS0zdWNDXpw/4PVQLnPuOIyGD9rlhnYiiCQJk
         PpsGwPGwAAWzIPNMovSBQeuUWm5LWWCSaclt11laf4JatdqO0dGB6DIMQosVeVDeUy1J
         8eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4xvRj1fvFWl4EtzEk4OxBkEwVVPN9GHGuLFuzq4AnSY=;
        b=c6jZD9coTJqW7pn5W2Ovc+EtsPjBdJY2cRZb6talVmymcBeUlwCt+vjhKsnawm7bQD
         b221fzPYhY4ZSjJrRsWM9gUYc1Bb4lG0i1F9hrT2aPNykxuhMYjVy5ThYDPhXnjv0E1s
         Z0vUQSlLlk2CBHmxTFlpJ5oOcfAumP1jn+Hs4w3d0WsKnAO1s2oEfkBNmUxFp28YcpSW
         6aIgwDZBmLy35HblPcitcl75GI/V1W5gLec1zanYbBO0UktE+pFjFEzcLrE86uCkRh1E
         GniUomqJ12kpsBg8lCaitp4+GYS+DxMWGKo3gaAAmwGNKvJhh/yKt/6KmVRI/iWhgH/y
         FNtA==
X-Gm-Message-State: APjAAAX3GK8HApIR6spYktfS1oeHpPXji2P7IXc2uHtgmyeeeFt53kYz
        sNKM0K1xjTvmp9v4luZyVKk=
X-Google-Smtp-Source: APXvYqw2xbIvcHzTsvKqAPiOi70rFA3dgn1m1KMJY3+deseBh7waGz1qVWtoDidT6L8EL3Fdz2hXHg==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr19968701wmb.23.1554798564433;
        Tue, 09 Apr 2019 01:29:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j22sm99378980wrd.91.2019.04.09.01.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 01:29:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com>
        <20190328200456.29240-1-avarab@gmail.com>
        <20190329134603.GB21802@sigill.intra.peff.net>
        <87pnq9aipl.fsf@evledraar.gmail.com>
        <874l78a3rz.fsf@evledraar.gmail.com>
Date:   Tue, 09 Apr 2019 17:29:23 +0900
In-Reply-To: <874l78a3rz.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 08 Apr 2019 17:57:20 +0200")
Message-ID: <xmqqef6b7fa4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>>> +test_expect_success 'print "error" on non-existing alternate' '
>>>> +	git init --bare I &&
>>>> +	echo DOES_NOT_EXIST >I/objects/info/alternates &&
>>>> +	git -C I fsck 2>stderr &&
>>>> +	test_i18ngrep "does not exist; check" stderr
>>>> +'
>>>
>>> All that said, I don't really have an objection against this patch,
>>> since it's just testing the current behavior. Anybody who wants to
>>> change it would find it pretty easy to tweak this test, too.
>>
>> Yup. Just wanted to get the patch to test what we do *currently* out,
>> might loop back to finishing up the rest of this.
>
> Junio: *ping* about picking up this trivial test coverage improvement
> (missed in the latest What's Cooking).

I went back to the original thread to see what the patch was about.

I actually am fairly negative on casting the current behaviour in
stone for this one.  Isn't the current status something like: we
notice that we say 'error', we suspect that we would want to demote
it to 'warning' or even silence, but this is not too pressing and it
is OK as long as we do not make things worse by turning it into a
more severe error.

I do not mind if the last "look in stderr" step did not exist,
though.  It is good to make sure that fsck does not die when it
sees a non-existing directory listed in the alternates file.

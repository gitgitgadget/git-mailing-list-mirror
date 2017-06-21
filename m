Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B71120401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbdFUSpi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:45:38 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35252 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdFUSph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:45:37 -0400
Received: by mail-pg0-f45.google.com with SMTP id 132so46983600pgb.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2Betq/p4deAvJKOOildTAB8fsQU3tj2iR1KQjcQWrEM=;
        b=qf/BxQDD/wpIEJzuTJoxV1agtD3xTl1c0i63qhMqgw4cMVipZVrL4aWNq5diva8F6S
         laQh9h1nX/+O6E0mtSQ5GDgqgDIWNPYXUQmsmufwizEUoAk5ozn+MS16dkZ4fx4kPWPy
         mOJFdwgnFhDTMKUIxLlVHSLxbE2gQx7U8tWTVg3/5dgV+qa/t9+TUHZAq7SFe+mIvaJd
         Chl4y9j+6aeaQ+bZAs/qjcXg+2q/7jrzcih26Cigk/j8Hhgh//Xw46eiGf+O5glpx7/p
         2VtkTac+RvGn2imbhbZP8B3vA9cndeYfD8WSpB68Wn1uKK+Sxgq1ZRaQ5ZoGgxeL08xW
         f/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2Betq/p4deAvJKOOildTAB8fsQU3tj2iR1KQjcQWrEM=;
        b=aznk/+iF5wrY7qeWNB8qkYqfNsg4V8IsYSxOLO+8g3qIqpM4KMoP0Zr511LXEm0vAb
         Q5ljOId9MPdconq4PwE5JWOzQ+BrEZ3ELy6WCryzXego+g4xE3cLPT0PQKn709NxlI4Z
         YannFBc84jNdjaP2L0hT0L2pA+jGv4AzFqZCqGgQMQ2h3z9gxGx8bBmCYvCvknZltnik
         +HCrQuS+7kwvKYi0wrJblek1PGafc67UYqrCamOrUrvWDMK6yM/al8np0GhpPpp9fViU
         eVbsnZycIR3aS4wBjbnRQPq9kemk83DmPnZ27qJwIKaJc9UBlc5Ke+9tsUvHjvUttzVI
         rt2g==
X-Gm-Message-State: AKS2vOyYKdBRB7qZE3Nm5LhdEyKzhIHXDgZrlmXsOXl7N5CvMpeUABNU
        S6/bX5QWanKuZg==
X-Received: by 10.99.99.193 with SMTP id x184mr33629790pgb.13.1498070736843;
        Wed, 21 Jun 2017 11:45:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id o6sm31970205pfb.110.2017.06.21.11.45.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:45:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH/FINAL] status: contextually notify user about an initial commit
References: <1498012463.1487.2.camel@gmail.com>
        <20170621023729.3200-1-kaarticsivaraam91196@gmail.com>
        <1498055714.20886.1.camel@gmail.com> <87fuet8kbs.fsf@gmail.com>
        <1498067135.32360.3.camel@gmail.com>
Date:   Wed, 21 Jun 2017 11:45:35 -0700
In-Reply-To: <1498067135.32360.3.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 21 Jun 2017 23:15:35 +0530")
Message-ID: <xmqqr2ydp4c0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Wed, 2017-06-21 at 16:52 +0200, Ævar Arnfjörð Bjarmason wrote:
>> No, this is a bug in your patch, the test suite should pass under
>> poison.
>> 
>> The issue is that you changed the test code I gave you (to also add
>> more
>> tests, yay) along the way to do:
>> 
>>     test_must_fail test_i18ngrep ...
>> 
>> Instead of the correct form:
>> 
>>     test_i18ngrep ! ...
>> 
> Yeah, I did it after reading info about 'test_must_fail' in 't/README'.
> I thought it should be used for tests that fail which seemed to be a
> misinterpretation. Thanks for pointing it out. Fixed it!

Actually, test_must_fail _is_ to be used to expect that the command
being tested to fail.  The issue is with i18ngrep, where it is
rendered to a glorified "true" under the poison build.  By writing 

    test_must_fail test_i18ngrep ...

you are saying that you expect test_i18ngrep to fail, but the point
of i18ngrep is not to fail under the poison build, so...


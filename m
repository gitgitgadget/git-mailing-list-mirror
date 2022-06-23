Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851FCC433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 16:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiFWQMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 12:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiFWQMm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 12:12:42 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459D457AA
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:12:41 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v12-20020a4a314c000000b0041b65c7e100so4100464oog.8
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SPpGVbHf/cY240jHk7eZMhmfeoqwjQw1EnRyCO/JD2Q=;
        b=Q71zJACxDNh7qxeK3lNsnDQWtXrF5lEDhtKUAjb95EC/yoC/9BkdFNH2R7hnjXa2g/
         QuNcvvGeb7L67F0ys8BCqiRy2ynpEuUs9+Nu7PIxvNGbOF7+DkuC7gRb761jHa+oWuCd
         ddyyGXwYnhbbCvOfotjaC3I/owGvWZ3EIpTDDQVFQV3B5sfIqpwTr9HRWdRNb3Rkt0z6
         UGKCvpnb15AkzncaR4JBmp/1kxMjTwKpl9wNGLw8aaUlBD0qKmOUSI+nHkwvmFbIi1SG
         qugJ3FN9uH5wHzYyHbCWy4Y+n4TxUZCO+9qASi9Rj/9/fawala7bcmROE/ACA7j6EFsk
         g6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SPpGVbHf/cY240jHk7eZMhmfeoqwjQw1EnRyCO/JD2Q=;
        b=FiClUpPldGQhVQChosxzlSpUqGLMro9BiqHD4Ft7ejgoulZuvDQbrnpfLVP58y6HH4
         V9U3uL7VTuCmvGNhPypcNLHn6dUXxQz6pa48SUP4BikhIyHGyTCP1HrcDi3bTZOVgNhM
         /RNtDTRJnl8cWgxQohw62VyOrljOFEe/tbyOGfZslM9o1v9Pq9q31Yb4oMWwNcDOl5je
         ZXg3blYLt1+b/AQb4Zxzoxjj1tJVSr+AxgxDzToLvbZFkk7PlVZf2yeSnGtFC2VbEtZh
         k3MXJh1H1rrBpBmgKpDMAB3+u+qceDhp4QtQU0QKek29d4i/fvb9hwqCxj+jzefx1dEI
         oCKw==
X-Gm-Message-State: AJIora8Z2aBxCZgSbYmQFaW9vj2QAHSyveUG5VA5wYUuhnFbitvpG34M
        KMAarSbw9ZRf7sPn2QGqI4z7
X-Google-Smtp-Source: AGRyM1v96H8jZ0oPJ8f14qv20Aj7YQVuvdc/nW5aNSryCSilcUf7h8AH0onXbQ1viQLVN8igjOxXKA==
X-Received: by 2002:a4a:e5c2:0:b0:421:2d98:955e with SMTP id r2-20020a4ae5c2000000b004212d98955emr4037710oov.38.1656000760801;
        Thu, 23 Jun 2022 09:12:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id v36-20020a056830092400b0060bffcb1ecesm13049598ott.78.2022.06.23.09.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 09:12:40 -0700 (PDT)
Message-ID: <c93c8e75-6c88-ac99-d8c3-1e2e7dd06ea3@github.com>
Date:   Thu, 23 Jun 2022 12:12:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/1] scalar: move to the top-level, test, CI and
 "install" support
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com>
 <cover-v2-0.1-00000000000-20220623T100554Z-avarab@gmail.com>
 <2f3067e1-43fb-26b3-83c4-6ca0722149a0@github.com>
 <220623.86k097js9k.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220623.86k097js9k.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2022 11:30 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jun 23 2022, Derrick Stolee wrote:
> 
>> On 6/23/2022 6:26 AM, Ævar Arnfjörð Bjarmason wrote:
>>> This one-patch series integrates the "scalar" command to the
>>> top-level, meaning we build the "scalar" binary by default, and run
>>> its tests on "make test" and in CI. We'll also build and test its
>>> documentation. We now also have "install" support, both for the
>>> program and its docs, but you'll need to:
>>>
>>>     make <install-target> INSTALL_SCALAR=Y
>>>
>>> I'm sending this out now to avoid needless duplicate work.
>>
>> As mentioned on the list earlier, Victoria is taking over the
>> remaining work to complete the Scalar project. Nothing has been
>> sent to the list because we didn't want to cause a distraction
>> from the release window.
> 
> I was on the fence about sending this out, but given that the "CI"
> thread was going on until the start of that window, and wanting to save
> her the work of re-discovering the subtle issues with the integration
> I'd already fixed I thought it was better ot send it out.

The CI thread was halted not just because of the release window,
but because of a change in who was doing the work and taking time
to revisit the plan of record. This was communicated on-list [1].

[1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206132246010.353@tvgsbejvaqbjf.bet/

The point is that the end goal is still "Get Scalar out of contrib/"
but the questions that are still being worked out are things like:

1. _When_ do we integrate Scalar into CI?
2. _When_ do we move Scalar out of contrib/?
3. _When_ do we implement the remaining Scalar features?

All three of these questions depend on what the final result will
look like, and Victoria is still working on developing her own
opinion on that before presenting it to the list in a complete
form.

Your patch here is interrupting that process.

>> Victoria is taking time to incorporate your previous thoughts on
>> how Scalar is built and its location in the codebase and create
>> a complete narrative of how to get from our current state to that
>> point.
> 
> I wasn't sure she was even aware of it, and given that the WIP patch I
> saw in my "git fetch" was pretty much a subset of the upthread v1 it
> seemed that there was needless duplicate work going on.
> 
> It seemed clear that that WIP patch was attempting to head in the same
> direction, but hadn't yet discovered some of the hurdles with
> e.g. documentation building & installation that I'd fixed
> already. There's also the CMake integration, which I finished up for
> this v2.

Poking around in people's forks to discover what they have as WIP
is not a good measurement of what work is being done or not. A lot
of mental energy is being spent in this area.

Saying "What I see in this person's fork isn't good enough" is not
a reason to move forward on your own. WIP work is WORK IN PROGRESS
and is not assumed to be complete or up to expectation for review
on the list.

> FWIW I have this local change queued on top of this v2, it's all
> cosmetic, but probably a good idea.

Please stop motivating current patches by work that you have been
playing with in your local tree. You do this frequently but it is
not helpful.
 
> The $(SCALAR_SOURCES) bit is something I missed, but which Victoria
> didn't in her WIP patch (I stole it from there).

You also mention this in your cover letter (but is notably absent from
the patch itself).

I can only attribute your insistence here as a lack of respect for
your fellow contributors. There is no rush for this to happen immediately,
so the only reason is that you don't trust that it would be done
correctly without you submitting the work.

Thanks,
-Stolee

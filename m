Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5067BC4346E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 04:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F3D23899
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 04:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Pt7bh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIXEtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 00:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIXEtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 00:49:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82220C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 21:49:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c62so2214383qke.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qB0+SluFzTH0CouFsKDegpKI0lw9Ug1n5V8LWBpOu0Y=;
        b=A5Pt7bh16V44DaXUVjySaY/mVzyUdD8Q7PjBrDPEVk8na+fMVggWd4aaOHIFSUhTyr
         scrCIqZKl4kBKu5bw9E+GI1WuUgU9F2nQQVAhyd//rsCphpDOEXMZDLAJ8Ig7r5P3aFF
         JY/Cx0L0BVWESl/lFshVW3zgkeWjy1lDl5Ex70ruREBqjca00WepgudGVfDbV1Q0Ip2w
         ghE8ecw91Lztkqq2EjjEktXbd85JNHJ0YOBMK1CPuOp2NmuCPG9cjYWdAhTlWXlwaRI/
         Kc2/91DXH6EPpYJhI4mp29HkldHvyLJNyrEhI1GLEYwXTRKzOtdx0V4XntnKpJ/xqhH2
         Bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qB0+SluFzTH0CouFsKDegpKI0lw9Ug1n5V8LWBpOu0Y=;
        b=POCTjG9Zi3YmHKN0yX3BCZ17hQ/Bx5TlPGD+vvi/QazVvVit5X+QBU3pNrAyOe1juU
         4HNqe77nsz50DBK6+Co3z4uL8NbAUHROKEMPMUaTPKKbvfewdmwfl+y9yP/2vVRo/atS
         Ab1Hew2CtSS7Hx+DFIjzcvUOATEPnvfjpMQq/mVqmgEQFQMBDvP8RRmmrBR7tKuWlTd2
         ItqGkAMC4SVzcMpzbZ2T5PxJ+Z4ss9XRH2YhBo4xZQMNpZ5Y6v9/gB77Ad/I02/LB7A5
         yor2HblcJ4SnAp91veqPOmXMNbYoohpQ1ajvhyaXgKn1ApwwlwCofJAHGnKPy2Eaqh+q
         TczQ==
X-Gm-Message-State: AOAM530d9EOnTUruD2IS6lEDqSEL0Pag2RbjAJyJXsb/Nly+wlc7yQDF
        tdaLkkuJtywrCNl2Np/nRjg=
X-Google-Smtp-Source: ABdhPJwYebfg6jr6QC8pcZXUYiTuRYbABYiDh5zlgwm9YN9u+7cMNaOhn6pdJy2cX4+x9ViCnCaBEQ==
X-Received: by 2002:a37:a0cf:: with SMTP id j198mr3257558qke.408.1600922948509;
        Wed, 23 Sep 2020 21:49:08 -0700 (PDT)
Received: from [192.168.67.200] (dsl-66-36-136-92.mtl.aei.ca. [66.36.136.92])
        by smtp.gmail.com with ESMTPSA id g203sm1464521qkb.51.2020.09.23.21.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 21:49:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Guyot-Sionnest <dermoth@aei.ca>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
 <20200918172747.GD183026@coredump.intra.peff.net>
 <CALqVohcZrBcjmonw-peVxUNM1kgEheCr3nAk9ZvajGpbpXsNaQ@mail.gmail.com>
 <xmqq363fm02a.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009231709340.5061@tvgsbejvaqbjf.bet>
 <xmqqk0wki9fh.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1d0a60c3-d15e-bcbb-f042-2f8ae06f0de1@gmail.com>
Date:   Thu, 24 Sep 2020 00:49:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009232244000.5061@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 2020-09-23 16:44, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Wed, 23 Sep 2020, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> I believe that that is exactly the reason why we want this:
>>>
>>> -	same_contents = oideq(&one->oid, &two->oid);
>>> +	same_contents = one->oid_valid && two->oid_valid ?
>>> 		oideq(&one->oid, &two->oid) : !strcmp(one->data, two->data);
>>
>> Not quite.  The other side should either be
>>
>> 	one->size == two->size && !memcmp(...)

Thanks for all the feedback, that was enlightening. Although I have been
silent the past few days I watched this thread with interest.


So as Junio pointed out this is merely an optimization - the range-diff
test that I corrected also showed two 0-line diffs and I realized
there's a block further down that should explicitly removes them, under

    else if (!same_contents) {

We can even remove same_contents entirely and everything work just fine
after adjusting the range-diff test - the logic is correct and
underlying functions already DTRT.


My next patch simplifies the test down to:

    same_contents = one->oid_valid && two->oid_valid &&
        oideq(&one->oid, &two->oid);

My understanding is that oid_valid will never be true for a modified
(even mode change) or out of tree file so it's a valid assumption.

I'll also rename that variable to "same_oid" - the current name is
misleading both ways (true doesn't means there will be diffs, false
doesn't mean contents differs).

Regards,

Thomas

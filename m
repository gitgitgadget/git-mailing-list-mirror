Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CBC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiKGT2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiKGT2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:28:09 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8904286EC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:28:08 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id z1so7803817qkl.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj2sokbH20FrlxB4HRAivxGzWVW4dz/MbRhesFHn180=;
        b=bujCB9+ccAdslqO40BtvryXh6RTxt+YUl9UafXoI5PQ10bBstHVOwBHO778xympe8V
         hMnI0Eo7JS/2dEdBkhoVDcRfrRAfHNy14xO292IeQ7UEHwu3XESh++EuWx+4Hv47KHgO
         TLDY90ktvNsa0gNYjfEPZorJkpMMloLY6ZFYBGDWEfYC0POGvSR0b/Q2hFm1vOTFWh/+
         PXLZwcKtk4zWnAsjBE2NiQqifTjDALeZA3jhTA6c8XObVBHbhdNhjRpm1epbhRXRLjWf
         7zxR3Vo4ItqcDR5wucelZIL0F51QCAouPXShZbTghTQAldA0QrhDjrGxRParffpYYCBR
         NtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj2sokbH20FrlxB4HRAivxGzWVW4dz/MbRhesFHn180=;
        b=AGxwmFABSF8objSSwrFuyXI9SMU+EqZ+E56wmqMyyXuSslFshz+wKxtRZM2DsFd3cr
         DQw5gZaixNHF5atE1QpbYDoTaZaCOAGfaPNapJc1Ue9hTjiYu1Baopg5xwKckUtCwLMr
         q4bMjYwShbsaRg1EP9sR3iNbup0Yj/CzZUv7Dcl+HBo95pZdRawSaNvm5r7w/ijxoELl
         rVoBEtxYVAurfVAXkypSpA45Oa5md+4IAzu5sc4S1iaDpEUVLKLl/1IhCbQMNalDKBq5
         SNXfgQo4j7giksRB5GquHmPM0LqBQ7VpmvL1tr0ZwVCkg/xw4MNoWBP36qcxlk8nqy2Y
         ZV4Q==
X-Gm-Message-State: ACrzQf1iAjo9nhXMhoJdNbCgfFNDCSsVsWBFp4o+5ZX7qhIVw+tz16oX
        Gp6ICPuhEOqj5BunSksYBubC
X-Google-Smtp-Source: AMsMyM5CG3KP5GCyBHrGUF4xWCtzA4uQnW292+1ndvZAU27xMrcGzsX5SE96oI29xtY0h51PmaKIvQ==
X-Received: by 2002:a05:620a:20d4:b0:6fa:49f6:7613 with SMTP id f20-20020a05620a20d400b006fa49f67613mr23785949qka.215.1667849288052;
        Mon, 07 Nov 2022 11:28:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id fy17-20020a05622a5a1100b003a50ef44a77sm6584957qtb.28.2022.11.07.11.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:28:07 -0800 (PST)
Message-ID: <fbb7b151-e808-ff3b-7c32-ded0c5f51cb7@github.com>
Date:   Mon, 7 Nov 2022 14:28:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] builtin/repack.c: pass "out" to
 `prepare_pack_objects`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1666636974.git.me@ttaylorr.com>
 <1dd4136f6199ac050cec5eb671c36ae05fbf3bdd.1666636974.git.me@ttaylorr.com>
 <xmqqa65lrltc.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqa65lrltc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/22 4:47 PM, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
>> `builtin/repack.c`'s `prepare_pack_objects()` is used to prepare a set
>> of arguments to a `pack-objects` process which will generate a desired
>> pack.
>>
>> A future patch will add an `--expire-to` option which allows `git
>> repack` to write a cruft pack containing the pruned objects out to a
>> separate repository. Prepare for this by teaching that function to write
>> packs to an arbitrary location specified by the caller.
>>
>> All existing callers of `prepare_pack_objects()` will pass `packtmp` for
>> `out`, retaining the existing behavior.
> 
> It does make sense to allow the caller to specify the name of the
> temporary file to be used, but is "out" a good name for that?  The
> other two arguments are self explanatory both by their type and the
> name, but this is of type "const char *" that does not convey what
> the string is about at all, so giging a good name to the parameter
> is more important than for others.
> 
> The patch text itself is very straight-forward.  Thanks.

I agree that the patch is nice and simple.

As for a name, this parameter specifies a file prefix.
Perhaps 'pack_prefix' would be a good name for this?

Thanks,
-Stolee

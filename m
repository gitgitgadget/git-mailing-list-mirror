Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D68C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 19:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIRTtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 15:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTtE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 15:49:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC72101
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 12:48:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-404fbfac998so23791375e9.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695066537; x=1695671337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pJkFU625PoYIBB6+PEk9GXwwJK7BG2DxLMlTyk8Oh3I=;
        b=VQj2WS2zMO/GXhLJ9Tzm4zgsg+CwbKk2yM5ZbqPLcjxYQd2/YC2+Bemju0yYAhgvMf
         Vy4D7HNqARKYAVCtGPQBOEe63/kIqzd3YI2SeRLZSMuqPGXXHxfPw36tZhFrGvdzR+AJ
         NBQe2IOWx+OcF4+8tmoxS8FVf4/HKOGRvSIImAPKiMBwtCGQr6f4iSX/Kyf/noFqyG88
         2KD6JAWr8Gjuv1c82KXwKpyTzn2t0zhY6BFeYKdFi7pdBGDAMPXTRRwEcwo/RJjCj0xx
         //AODaDYTmKc+0RSqWncM0weK3pDpq8zWLcVxqf0ltsFk2QeAZrqsH/GavMT1XcO+XZ7
         hhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695066537; x=1695671337;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJkFU625PoYIBB6+PEk9GXwwJK7BG2DxLMlTyk8Oh3I=;
        b=uMLwcQnDj6hHmOBePsV6b8Uyas1DBmx3h8T2z5ZSaY/jhGJutMEF1G4GbdMjGNeEyt
         nw8jj49BbfTPobGSOBiGWjOUFQbOPOQPlHVKEMJlhLp0ey3L0aSY1oE80r3GypYQCEDo
         ogJd6ccVKsMpydbFOAUhHXW/wQ7QuW3nkIFYSIR2jPJK3bXSu36OpsDb5lF4iNF/Q8ia
         TnQnZsOmh1wbLwGqhsxjbZYmw34QXgb6l8Hl/MDYm3iVC2nVXeNfll1Lfo7Q+Fvx5bUS
         8AGFfNUXyPR9gl3ppVnpTGxNDonUDHpKxl8ahcSj7F9798PgpiJiZ69i/jffeIqC+pyf
         kBcQ==
X-Gm-Message-State: AOJu0YzLBWibcVWdyuzkVZ/weye0zZQpP419Sk6TA2QVfdKHBljzPAkI
        lFDwc5MOkihwm09voNq0rUM=
X-Google-Smtp-Source: AGHT+IEpmftiLSpdOdCvc4KBMJZiLWNsBE1Z/4Zx5s5QJQ9kX60xS3fDkiCD6IhzEtVF41duAv8bsQ==
X-Received: by 2002:a7b:c407:0:b0:401:dc7c:2488 with SMTP id k7-20020a7bc407000000b00401dc7c2488mr9311394wmi.11.1695066536717;
        Mon, 18 Sep 2023 12:48:56 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003fe407ca05bsm16161036wmc.37.2023.09.18.12.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:48:56 -0700 (PDT)
Message-ID: <000ff1b9-e7a5-4dd6-bc61-4b6761f66997@gmail.com>
Date:   Mon, 18 Sep 2023 20:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
 <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
 <20230912084029.GD1630538@coredump.intra.peff.net>
 <xmqqa5tmau6e.fsf@gitster.g> <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
 <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com> <xmqqedivl832.fsf@gitster.g>
In-Reply-To: <xmqqedivl832.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/09/2023 18:11, Junio C Hamano wrote:
>> Then in builtin/am.c at the top level we'd add
>>
>> MAKE_CMDMODE_SETTER(resume_type)
>>
>> and change the option definitions to look like
>>
>> OPT_CMDMODE(0, "continue", resume_type, &resume.mode, ...)
> 
> Yup, that is ergonomic and corrects "The shape of a particular enum
> may not match 'int'" issue nicely.  I do not know how severe the
> problem is that it is not quite type safe that we cannot enforce
> resume_type is the same as typeof(resume.mode) here, though.

We could use gcc's __builtin_types_compatible_p() if we're prepared to 
have two definitions of OPT_CMDMODE_F

#if defined(__GNUC__)
#define OPT_CMDMODE_F(s, l, n, v, h, i, f) { \
	...
	.defval (i) + \
		BUILD_ASSERT_OR_ZERO(__builtin_types_compatible_p(enum n, 
__typeof__(v))), \
}
#else
#define OPT_CMDMODE_F(s, l, n, v, h, i, f) { \
	...
	.defval (i), \
}
#endif

Best Wishes

Phillip

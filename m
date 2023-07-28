Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B4C001DE
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 09:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjG1JpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 05:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjG1JpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 05:45:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E8C2686
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 02:45:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f25d045cso1206410b3a.0
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690537515; x=1691142315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h1SLSa3yoE788Mwl6V1CXjyTbvDNy7yRaoXyMFngNr8=;
        b=oj88xmTJWC0IBxI1R/xt3e/oVoXJMijskShknfPmPQirr6UV4UpaYAKqDoo+G84TTe
         Y+hZXeThTXrmRz240vy8PRlPz29SZ+jeHwYbkZiHwgD7Ub5tuNIc0Waf/3wWAtTQZ7xk
         7d4Cv/IxXF3Dc2A81Zf5zt90kU8ddh7gB7wEU8xx+lkUuOZ2q7A38xvGe05hcLbtG+Hl
         bn2jkVO1rAhosPuAiRS8LPzZnw5pJZk8Pg+d1X0rQIzFc1hd/Cekf0xpDtZI42gnd+9p
         GV26G9+wdzKHwDj0eBiyDy7bIwYcaygcVnGp4U0N8X5bPBE9h4e1i75PLwvO4AlDJlKN
         lk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690537515; x=1691142315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1SLSa3yoE788Mwl6V1CXjyTbvDNy7yRaoXyMFngNr8=;
        b=Kv9FEGRlT1bsBi/1aGlSirPgrsdBSoGaDu1v//T1JsC/pHXNNMH0LiPgUjbSJ2L6Y5
         FFS7sbKWLUr/1KmKJ5IBa3t3GooL0NnoZ6mNNwINcgTitJp0DMD1R2Azr7bgYHOEtzW2
         Uv+f3ekJXtfEY9z5DqNrYffzIAn7+41mA6Op1RaAaA6WmUyo+U8b2djpzjBKJGVVNvBU
         T4MgXTaQQAZDC6D5EirZMETQ0YZ5i7BXpEOggFk4IBQNUycHIpG0IGvRlUsydAsf8BUT
         skGlKq9qvrzAYX1XN510HmRHjl70xgf5FTlivsjLFaNEVtlxBz70pzycl7Kzb55oiIcs
         jDvA==
X-Gm-Message-State: ABy/qLb4HJmGMgN3ygDeRFp6TvWi1/qlrNellKhsdogWloKd/4GJeqPd
        3hsC4h9elxrs0PDllAC8id0=
X-Google-Smtp-Source: APBJJlH/UG9/V0NQny1+tir5rFQ9JrBGrT0uLg+HhCIap5U30ps1Wd1735+5IZbESlp+Vpl2CqaA6Q==
X-Received: by 2002:a05:6a00:22d3:b0:687:1604:39d2 with SMTP id f19-20020a056a0022d300b00687160439d2mr479203pfj.10.1690537515230;
        Fri, 28 Jul 2023 02:45:15 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7904a000000b0068285a7f107sm2899859pfo.177.2023.07.28.02.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 02:45:14 -0700 (PDT)
Message-ID: <b17b4f6b-199f-973b-3aa9-ef995a61bb3d@gmail.com>
Date:   Fri, 28 Jul 2023 10:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ls-tree: fix --no-full-name
Content-Language: en-US
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <1535f30e-3cf9-1a0a-04af-4ba4a7c46d15@web.de>
 <xmqqr0oxnnx4.fsf@gitster.g> <9e8225dd-1e8b-8af2-c3e1-0c5834694244@web.de>
 <xmqqh6ptnies.fsf@gitster.g> <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <a19879db-d45a-ee42-1ad5-497e4e9eb8df@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/07/2023 07:12, René Scharfe wrote:
>>> Right.  Perhaps --[[no-]no-]doubt?  Looks a bit silly with its nested
>>> brackets, but it's more correct, because it documents all three accepted
>>> forms, including the no-less one.
>>
>> It may look a bit silly but looks very tempting.  Also it is not
>> much longer than "--[no-]no-doubt".
> 
> Yes, it's quite compact.  But is it they still legible?
> 
>      --no-index            find in contents not managed by git
>      --[no-]no-index       find in contents not managed by git
>      --[[no-]no-]index     find in contents not managed by git
>      --[no-[no-]]index     find in contents not managed by git
> 
> The last two document all three variants, but is it still obvious that
> the help text is supposed to be about the one with a single "no-"?
> That's something that has to be learned, I suspect.  No good making the
> short help too cryptic.  Hmm, how about:
> 
>      --no-index, --[no-[no-]]index
>                            find in contents not managed by git

I think spelling out the positive and negative options separately makes 
it much clearer, but in that case I think we'd be better just to show

	--no-index, --index

adding "[no-[no]]" is just going to confuse users. If we had a 
convention of "[<short>, ]<positive long>; <negative long>" then I think 
it should be clear to users how to negate a given option

     -v, --invert-match; --no-invert-match
				show non-matching lines
     -I, --no-index; --index	find in contents not managed by git

Spelling out both versions is a bit verbose but I think it is worth it 
to avoid "--[no-]no-index"

One other thought is to mark options that can be negated with a symbol 
like '*' and add a footnote saying those options can be negated.

Best Wishes

Phillip

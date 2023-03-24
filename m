Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1244C76195
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjCXSKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjCXSKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:10:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3310E2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:09:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id cf7so3269887ybb.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679681399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHdUae6TBlm4Kqeix8IuhAI7NYvEzwlAXe7D4wqawng=;
        b=PupRbiAu03Rwr+n8bglwD9O+JG3tKBsqb1oDrNnVcyTd6ePy2N1Nssr7mMe63PX+NI
         tlUhLh9HAngkFxBIUwc7wyNSMwF1baSMdnKVK89FUluMwM8deE3AsYvN270O0ULdWWnL
         gYIzOHTUpOZ2MN+HyI+nOYMV+LNtUJhD0+BhKIbawyT2PHgq6BxbDUB5glS5nx9roXaU
         jmy25NCQ1SUGt8pgk1M5bW1nA+aSrZ1mS1NH7hhd0Ya75gCJLuTJT2eO6LisBeKUCS2n
         vKqxc4ZQsDYwoyrmBv4kJXcbtGJgrtZ2t0Zd2l6muR/PgVqwx6f+0+0394RN02oUb7YJ
         Baxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679681399;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHdUae6TBlm4Kqeix8IuhAI7NYvEzwlAXe7D4wqawng=;
        b=UHrSBLza8i/40nBWImGtuGtjSM0Qnk3cgSbgYXMHM8WUoTnLKrOsBacS5qda2HvgPb
         w3ENHyTOkTnBGg45nx23Bt+vyCjJc3/6nUBMJn+fh42YG63cXIg21FtvjX9PzL4qNvuA
         V9xmzCaCjWf8u8Je9p8BJNpwYEKfUMMJ2xap4Z8de/gY4BRYTBPXeVaDTgPnt5bnhaPA
         eXhkuo7Sdl8AznsP52riZfFdEjzD1swi10JhYRW7it6fG1xp1kjqrpGbs2I89IWEvXAQ
         Fgs/e3tOW+WsweYs/cfXjhpytTUbrdRBtTehZFeFoFyX77RXpyONS6bHWvqw78P554DK
         E0/Q==
X-Gm-Message-State: AAQBX9cxn59EtM1/PqveeYrJakT7y1/HaY21zW4j/rImOzr+P2J04RoA
        sF2T55bAcqJmFHyu22byFSFv
X-Google-Smtp-Source: AKy350Z+p7PgVLWLqGCCeoHsj8zDV2U8aUfi54eUekkN7quxvhLI9lCG3SKVIgk/1VEEJPP/mL177Q==
X-Received: by 2002:a25:ab34:0:b0:a3f:191f:dfb4 with SMTP id u49-20020a25ab34000000b00a3f191fdfb4mr3061942ybi.58.1679681398585;
        Fri, 24 Mar 2023 11:09:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id r17-20020a25ac51000000b00b7767ca7483sm582826ybd.32.2023.03.24.11.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:09:58 -0700 (PDT)
Message-ID: <2ac96251-1b91-3470-b0a1-cbe8fa0cc4bb@github.com>
Date:   Fri, 24 Mar 2023 14:09:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6/6] pack-bitmap.c: factor out
 `bitmap_index_seek_commit()`
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover.1679342296.git.me@ttaylorr.com>
 <82049ed09e1695db644d1d4cf17557214e54dcea.1679342296.git.me@ttaylorr.com>
 <20230321181315.GH3119834@coredump.intra.peff.net>
 <ZBn0iFE5qOJKVeel@nand.local>
 <20230321182732.GK3119834@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230321182732.GK3119834@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2023 2:27 PM, Jeff King wrote:
> On Tue, Mar 21, 2023 at 02:16:40PM -0400, Taylor Blau wrote:
> 
>> On Tue, Mar 21, 2023 at 02:13:15PM -0400, Jeff King wrote:
>>> I'm not 100% sure on where these offsets come from. But it looks like
>>> they're coming from the bitmap lookup table. In which case a bogus value
>>> there should be an error(), and not a BUG(), I would think.
>>
>> They do come from the lookup table, yes. I'm not sure that I agree that
>> bogus values here should be an error() or a BUG(), or if I even have a
>> strong preference between one and the other.
> 
> The usual philosophy we've applied is: a BUG() should not be
> trigger-able, even if Git is fed bad data. A BUG() should indicate an
> error in the program logic, and if we see one, there should be a code
> fix that handles the case.
> 
> Whereas if I understand this correctly, if I corrupt the bitmap file on
> disk, we'd trigger this BUG().
> 
> In many cases I think one could argue that it's kind of academic. But in
> this case we should be able to say "oops, the bitmap file seems corrupt"
> and skip using it, rather than bailing completely from the process.

It's not just academic. BUG() statements kill the process without running
important cleanup steps like deleting open .lock files or outputting the
final traces. This can be especially problematic when we count on those
operations in order to recover a repository from such errors.
 
>> But I do think that trying to make it an error() makes it awkward for
>> all of the other callers that want it to be a BUG(), since the detail of
>> whether to call one or the other is private to bitmap_index_seek().
>>
>> We *could* open-code it, introduce a variant of bitmap_index_seek(),
>> make it take an additional parameter specifying whether to call one over
>> the other, *or* check the bounds ourselves before even calling
>> bitmap_index_seek().
> 
> I'm mostly unconvinced of the value of bitmap_index_seek() doing
> checking at all, because it is too late in most of the cases. In fact it
> is only in this case that it is doing something useful, which makes me
> think that the check should be open-coded here.

If we universally check whether bitmap_index_seek() works, then there
is value. It avoids the existing ad-hoc checks in favor of always-on
checks (as well as avoiding potential disconnects between the check
and the seeked position in the future).

Thanks,
-Stolee

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD7C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDROzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDROzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:55:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC214F7B
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:54:52 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f6a796bd0so346414767b3.12
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681829690; x=1684421690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LdKI/SFw02nacV7jx+Pn4euKvQDkF47DIGlRrOq0f34=;
        b=CvfYM+S4bd1/28MVTR8gXaULBTcp1TXy4G9XC3Je6n31ZSuY6zRCf2OCSCeGPeVCLt
         oyam6f6GUWEBiB4m06KByf9xHLH4LlAgj4Ldn1oVnMGg3hOo+vzaQQj5Iq/6kxY9E5Ub
         kPlkjA7ybxBPTxWGTmDLq6kCUOCf5RbDoGSJCsMVRa10f9hApYEtljZBySGfOk6Vau/B
         BlSW+Xw1A9Ux/unTCHVU0tSQRqYsbOo2T0LJwEN1BLKs1BwABb2qvWLmItAcWMkseBy9
         5AkRUFtV9vs48FCqrIf1ulB9jjCIt2v2p7Wr/naCieGxuOxfbtK3P4SlXfWHPndZQpUZ
         c1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829690; x=1684421690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdKI/SFw02nacV7jx+Pn4euKvQDkF47DIGlRrOq0f34=;
        b=ca0qO10VL8XjuDkQ5cTXfFmQ2NxQjnTxVMUNAmaaADYB4eU8fX5QRHDhHaITi62vPx
         faoEDSTKvuEJ1EJ14ZJ0R0MXY31h/2ebjpCupRGov4QVNdTXaSHgpZjyYARuXpxVtQkY
         Bf9ZyWcSjdO8JcSv6krrsBu74EfAPyvVB10YsczFqn/UN7S1hVMZSvlLmO+YGAweNDS2
         kWKZNYZyxIDMTvLiKEpv8Hzo3Ugo+dFg9X1VDuuWamLGcjctf3WNy4RyV993oEL7EM5+
         cQL+d4WXtqbj7d8n5e2uB6Hty5HOzHCrvAsxeJwkzT3am9+KQMbZpHwyl0u9rsMc3T5d
         JGUA==
X-Gm-Message-State: AAQBX9fgvg8VyeCZrp57Dh6DtNgOrMuiyPd7GVev4eHdyP1zEuogHqeg
        FggPvTvSBPrsWDPFizvphJ1olhMZSsigviEmEA==
X-Google-Smtp-Source: AKy350Y4qBBtnH031P1F402UgbvTxw0iXONjNGk3VKjaqUQF9RDgPh7s1dN9+JCWVG1wwV57A61jlQ==
X-Received: by 2002:a0d:ca16:0:b0:550:65b4:ca60 with SMTP id m22-20020a0dca16000000b0055065b4ca60mr120654ywd.8.1681829690318;
        Tue, 18 Apr 2023 07:54:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id a206-20020a814dd7000000b00545a081847bsm3860352ywb.11.2023.04.18.07.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 07:54:49 -0700 (PDT)
Message-ID: <64e238fe-b69b-d670-6224-930b32bab9a5@github.com>
Date:   Tue, 18 Apr 2023 10:54:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1681764848.git.me@ttaylorr.com>
 <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
 <xmqqildui0gk.fsf@gitster.g> <ZD3QLMs8/+DLKZM6@nand.local>
 <20230418103909.GD508219@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230418103909.GD508219@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2023 6:39 AM, Jeff King wrote:
> On Mon, Apr 17, 2023 at 07:03:08PM -0400, Taylor Blau wrote:

I agree with the prior discussion that gc.bigPackThreshold is
currently misbehaving and stopping it from caring about cruft packs
is the best way to fix that behavior in this series.

>> It is possible that in the future we could support writing multiple
>> cruft packs (we already handle the presence of multiple cruft packs
>> fine, just don't expose an easy way for the user to write >1 of them).
>> And at that point we would be able to relax this patch a bit and allow
>> `gc.bigPackThreshold` to cover cruft packs, too. But in the meantime,
>> the benefit of avoiding loose object explosions outweighs the possible
>> drawbacks here, IMHO.
> 
> I wondered if that interface might be an option to say "hey, I have a
> gigantic cruft file I want to carry forward, please leave it alone".
> 
> But if you have a giant cruft pack that is making your "git gc" too
> slow, it will eventually age out on its own. And if you're impatient,
> then "git gc --prune=now" is probably the right tool.
> 
> And If you really did want to keep rolling it forward for some reason,
> then I'd think marking it with ".keep" would be the best thing (and
> maybe even dropping the mtimes file? I'm not sure a how a kept-cruft
> pack does or should behave).

Generally, it's probably a good idea to (later) create a separate knob
for "don't rewrite the objects in a 'big' cruft pack unless you need
to". For situations where cruft objects are being collected and not
regularly pruned, this helps avoid repacking all unreachable objects
into a giant single pack, even though only a small number of objects
were discovered unreachable this time.

The important times where we'd want to consider a 'big' cruft pack
for rewrite are:

 1. Some objects in the cruft pack are being pruned.
 2. Some objects in the cruft pack need updated mtimes.

However, in the typical case that we are adding new cruft objects
and not changing the mtimes of existing unreachable objects, we could
create a sensible limit on the size of a cruft pack to be rewritten
during normal maintenance.

My personal preference would be something between 2GB and 10GB, which
seems like a decent balance between "size of cruft pack" and "number of
cruft packs" for most repositories. Since none of the objects are
reachable, we don't really care about them having good deltas for things
like fetches and clones. The benefit of reducing the time spent in 'git
repack --cruft' outweighs the slight disk space savings by having a
single cruft pack, in my opinion.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59105C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9676138F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 21:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhJEVFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhJEVFg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 17:05:36 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0EC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 14:03:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d8so1589739edx.9
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EvGOpTSRxBfdtcb9izRUKxWFE0YsmcvMVbJvVjMOwnA=;
        b=KRHcgAFHKQ1MZM+qMnN3GGhMrXC8meZzrj7Dtw8gsd0XBMa1UPROA3ccn3klAOq18h
         66mHUUBlv0fvYjYbfmXgO2XPqjnTDudcR93gl+iLNSxN9TbO83N/SMplUZlw7h8tYuQZ
         bmESMsW0nnxZFpopRCVU1y8aSuES4cV29vW8mGYy4DcAtCzbrZn3/+Ck3Jpka8SbAnq2
         puIAMktCN5S4jXAsTRntH4tfyBPZ4Zhc97F/ccJe98GvYHbZ227Q4ZMc89bUeBc966U1
         p9liIkhz7q/+EeVPMhEydhYs9nrqngZx6oA6JxAugMXBRsMLqCmBSLFiQgVYSagPDiRP
         hS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EvGOpTSRxBfdtcb9izRUKxWFE0YsmcvMVbJvVjMOwnA=;
        b=LXXn8aP6xyHR0QWjLd5XArXASOFksMIn+jekdwToSNr5HVqvrzWIs0NudbA7L5O/MA
         Asm6MgEiCQSuqnaxTnz9O7vmH0IFRAsYosjYcCpcA50bZb1KkzoXDHGwn+vMBzHCafAz
         miz55DC4+8u3p2S+WZu8h5A3BY6lBdgPZ6deGDV5J6bcwcXtVx/vap5vhrpE53nfHoY1
         iOwXFA1OLUJjOEzU3D3FA5IoewdHTzNbqMwolI+duqse1paFhl5MeScUypoiCovlWMyV
         oMNXx/CUXJsl0wUn63tIPf5jf0HMoWrjulr/9iF6EbGCBVJ/tWAbLXtB8A0SS5oNhILF
         xEAQ==
X-Gm-Message-State: AOAM530zCApQozRrHYeoLuzAlEwcDnNFL4NsyPhYBKe7XcskQMjBUfpX
        dwsmbm3Y7z32vkP14q6j66c=
X-Google-Smtp-Source: ABdhPJy/cUP6RfDBXM3GuPexTnhlxdNHuKUaHsVFNSVSn9r7B/UXJpM/GncGhoxfa4IjWxJmPC/4zw==
X-Received: by 2002:a05:6402:142d:: with SMTP id c13mr28736494edx.390.1633467823707;
        Tue, 05 Oct 2021 14:03:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm8223311ejh.62.2021.10.05.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 14:03:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] cat-file: mention --unordered along with
 --batch-all-objects
Date:   Tue, 05 Oct 2021 23:02:38 +0200
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
 <YVy2DNd+XemykKE0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YVy2DNd+XemykKE0@coredump.intra.peff.net>
Message-ID: <877derjia9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Jeff King wrote:

> The note on ordering for --batch-all-objects was written when that was
> the only possible ordering. These days we have --unordered, too, so
> let's point to it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not strictly related to this series, but I noticed it while I was in the
> area, and I'm about to touch these same lines, so it seemed better than
> spinning it off into its own series.
>
>  Documentation/git-cat-file.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 4eb0421b3f..6467707c6e 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -94,8 +94,9 @@ OPTIONS
>  	Instead of reading a list of objects on stdin, perform the
>  	requested batch operation on all objects in the repository and
>  	any alternate object stores (not just reachable objects).
> -	Requires `--batch` or `--batch-check` be specified. Note that
> -	the objects are visited in order sorted by their hashes.
> +	Requires `--batch` or `--batch-check` be specified. By default,
> +	the objects are visited in order sorted by their hashes; see
> +	also `--unordered` below.
>  
>  --buffer::
>  	Normally batch output is flushed after each object is output, so

Since you're doing while-you're-at-it anyway: Isn't the --unordered
documentation also incorrect to reference --batch, which I take as it
lazily using as a shorthand for --batch-all-objects.

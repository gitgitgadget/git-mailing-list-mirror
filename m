Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B2DC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E5461422
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 09:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhDVJRg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhDVJRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 05:17:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E68C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 02:16:59 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id x12so46951266ejc.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uDovlxrclJKbAyoJ2/po9hDCiH3oF+9lsdoNOdOI3mI=;
        b=hA415wABGKCSUtSw+VEKvrMNkIB5XwpZGxPaM+2sPJ0tO1noXHtpQx6OHzdfPXIhuG
         smUW8lrtA3T/6rsaUDjapFp96R6I3HWPrvr73kz1TzqjY2YJLhMNSIiW26GrnlMlpNXA
         M5ZklKg1Dj88TOS3fppKZbWqPODLmDFuOglA7Cn3eiiHrlimUWcoVbInhFanlwckJBS2
         MIetFbECjurJ0ux2+wPsLlcdIzjMN+fev1U5BtsIDMKLJkKyrFvoM4LHEFe64QcF63+t
         I9dNwfUmaKpTQt9KWRQuE/cRn+1+9V/k/yh9Obr1ooJ3vabUMX9zhmoY1cPAuG5f3/Tf
         iXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uDovlxrclJKbAyoJ2/po9hDCiH3oF+9lsdoNOdOI3mI=;
        b=oTPxIn8SRVyPF+7Wn0ZDpTpFX34iz/uJvzGnug1zRenmXKRT5Z8m6jYSio3Am1dmJV
         UcqmId6pxpBB5yKMKv2+eicDQpwGnbWpyYbT5qKa+qi5KRvC60qtGQpBPlZOeOK7O12M
         X8Smu73WvX66vMG33eWVwjL7v7n0I6slco/GUAvvkLR5+w1taYbi0WomyQWyAEKN/WJ5
         PWIknAuEzz2MILGWRSqK3FS8cdtCSq2tn8+G+xR+MJk3Fd9cb/EKYRXJfa6SsjnmompT
         rOuXt9cHgs1kY2xJ9vkTGszgyLDBzc/xV+R9nj1tqHJ8hF/wcf9dMPFDg2eaiZl351jd
         VhrQ==
X-Gm-Message-State: AOAM531MFqrfhsxyLj5S7yuh8cX7KgsYfM251denAdAo/Hxrhn9cPR8P
        Cge2lVlAzA7BvspZRvzv734=
X-Google-Smtp-Source: ABdhPJzsIXs3cWLY3mueqyinTJJylgSAERy/YuSqDJVIuvP4le0anREmt/xg0hq3famTJ/MHrdnv4A==
X-Received: by 2002:a17:906:cc88:: with SMTP id oq8mr2430097ejb.66.1619083018456;
        Thu, 22 Apr 2021 02:16:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id 16sm1502561ejw.0.2021.04.22.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 02:16:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Strategy to deal with slow cloners
References: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Date:   Thu, 22 Apr 2021 11:16:57 +0200
Message-ID: <87y2da1xx2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 19 2021, Konstantin Ryabitsev wrote:

> Hello:
>
> I try to keep repositories routinely repacked and optimized for clones, in
> hopes that most operations needing lots of objects would be sending packs
> straight from disk. However, every now and again a client from a slow
> connection requests a large clone and then takes half a day downloading it,
> resulting in gigabytes of RAM being occupied by a temporary pack.
>
> Are there any strategies to reduce RAM usage in such cases, other than
> vm.swappiness (which I'm not sure would work, since it's not a sleeping
> process)? Is there a way to write large temporary packs somewhere to disk
> before sendfile'ing them?

Aside from any Git-specific solutions, perhaps the right kernel settings
+ a cron script re-nicing such processes that have been active for more
than X amount of time will help?

I'm not familiar with the guts of Linux's swapping algorithm, but some
results online seem to suggest that it takes the nice level into account
when deciding what to swap out, i.e. with the right level it might give
preference to swapping out this mostly idle process.

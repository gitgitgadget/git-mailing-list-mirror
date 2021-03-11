Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4ECC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6831564FC9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 04:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhCKEui (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 23:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhCKEuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 23:50:08 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2308C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:50:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id o22so12084441oic.3
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 20:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r4nQxQmSAXBDXzZ/vs8OSoWBHt5YFo4pnUJCTQWKunU=;
        b=dLZlZ8o+NBIqOqLqBuJ3YET4lG2B4G+NIvI6XRE9Mkij1VojTAVISnS78kQOkNLf7+
         SkbWyBg9SqGoPDjmRojC1rcMJkvKL9YYaDfFn/yjbWP4rTWRMZ7nC8gUFfzCZv7LmlM2
         uoeBhTQQTixbS3Y0UWv+qRPICV5VrvGxl1ZQJcyz3/wnmeR+lGiGvY5CK9+6XTZkuvPn
         1ndMiU316Zku4Wx/IQEMpB7UgdgyQYO7H3Fkiwje4y9tIrwFaECERrrjrJAt5OS1oeGQ
         vzsTaFsKxl9gRUih8CmS9AmliJahWgr82ZSWXs4o2EaXoGDopuN11ERUUd+S1wP8ms5x
         qh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r4nQxQmSAXBDXzZ/vs8OSoWBHt5YFo4pnUJCTQWKunU=;
        b=oAUHDwXQhkApjcwfFUMf7axLVixrx7Z3/M9/10GFU4RCrMI9AJiFrnbVL6se7YrXDg
         2tOAIWQo6pPAgzwDNglC03kQfQeKrxN3hk9rnmKbpJRHzBMhc+dgmy2EmRUQ+Do8NlEq
         q4jclgmPfktZjH/uu6E/tXsMbnPnnQ9wP2jgvbC1kL+Roy9Eh5Sl3lxn4OBerf66X9pt
         QSZiLlaexq9Q3Uyt5JLV7G0w2Vepv5vovel62hoO2vkBPz16VxaaS8RfwfIOVHB7aDf7
         LHxYFQ4MdOCmoNknYu/QiiQQty8qCyUKEZbC0wfEGOJfl6g9j6lpz77+5ky/bht8CJZ/
         qX1Q==
X-Gm-Message-State: AOAM533S5i9vBB9h/tLOhFl5KkKZoomdcFpPl75wPbu6X2ZqpFJRSG6Z
        ORiRrxWYHlEYVHgptrcycjnmnRy6iwHFZKIUUZ4=
X-Google-Smtp-Source: ABdhPJwOAosHpcjcnWBVMgReTwp8q8twRxHd0PWGlyZEkwfyB0lpHWyizndwfuOkxeKf2OwMfmn8Wya0TlSUfYq2Paw=
X-Received: by 2002:aca:b489:: with SMTP id d131mr4989321oif.39.1615438207048;
 Wed, 10 Mar 2021 20:50:07 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmtvafl62.fsf@gitster.g>
In-Reply-To: <xmqqmtvafl62.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 20:49:56 -0800
Message-ID: <CABPp-BHxj8jS62mVH4qgmoh1v48ciz8CRswz3+twSnuxUo7Rmw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 7:05 PM Junio C Hamano <gitster@pobox.com> wrote:
> --------------------------------------------------
> [New Topics]
...

Is there any reason the topics at

https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.com/T/#t

and

https://lore.kernel.org/git/pull.973.git.git.1614905738.gitgitgadget@gmail.com/T/#t

haven't been picked up yet?

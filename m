Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1881EE8018
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 15:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbjIHPx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbjIHPx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 11:53:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB9ACCA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 08:53:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so2135967f8f.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694188402; x=1694793202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2SsZrDvPgl5biY5W7sVeMX29tJR/40UylX1fqM5yUsE=;
        b=bp9NI0cH8lpgf4P9Nd0tCZw9MQkmNBpftLQo3PwD00ol0zORBy274lii4nvWedb/3g
         vkMnz6uHyTbGT2QP6zkzcloXSmVi7BVUOLGYLVO3iLQxjG4mNRe2Ku281Ggd5zXZycVJ
         7H416HQ3BXyEyuzCf3FKhNWLVa5nXOWKKzH/p83HzlPdtqpR08FoW/jy/MGsrDPoyD4c
         FHNpPGBpvtwX5KBpBSeboi72bvg2WTdOmWJIURyN6lR6qXVl+d6UVNHiLFl8f/5qDWYv
         VRwuL0dYIxlqIc8V+z4l+7idLqIPWwjZYPXLPLpIJMXYB7JwUyedgdE7khs0OlnhYyC4
         COaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694188402; x=1694793202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SsZrDvPgl5biY5W7sVeMX29tJR/40UylX1fqM5yUsE=;
        b=XGSxRSiu1ejt/KLyEN4jc1ueJccoJroJ5hAJqMJlAsOaZLrxXZMgDmF31l53gBz+09
         R8QVhq6Jxf9oWOa+5DyhQwprAH2iarYgFLQXMxMNUBU66BwX6CN0u1ZAJJ5vhnDuD3IE
         8lf3ZaP5I+NNpppoUAoOi1IV7BHGnYywOrbIhQWVfNKIAxdrl1syDDKtP3phPNW7Mf0A
         RFr5ZUXXkX7ZSjfMe9YX3oAN+hAoOoBYt3qE5JeiijTEU2QDTTrjbgZrKrgK41Kg0eH6
         vjpN+CYbBjgTNB0glJ7zovzfm+7cqHcKcdC/N7xZUdb2GEl7hv6gjk5HioqBBxxS++8U
         7SvQ==
X-Gm-Message-State: AOJu0Yw0FvIKYb9hYxrqYC92AbG8oscY9/VFR9qyz8DINmBmuxXhGFv2
        x58rkXHGHU08qWnuajH33uAHeDp96gT13Q==
X-Google-Smtp-Source: AGHT+IEfS5W6bAIPyRucn1Ag4eypvT5v3cvUoVz3BF4JE8JDz5EVVTnA7vb2ceghzFinHobxtAmlrQ==
X-Received: by 2002:adf:e189:0:b0:31a:dc27:dfd with SMTP id az9-20020adfe189000000b0031adc270dfdmr3079751wrb.6.1694188402240;
        Fri, 08 Sep 2023 08:53:22 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id b13-20020a5d634d000000b0031c5e9c2ed7sm2399854wrw.92.2023.09.08.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 08:53:21 -0700 (PDT)
Message-ID: <ba69ab35-3204-4360-a36d-3253680b2479@gmail.com>
Date:   Fri, 8 Sep 2023 16:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] start_command: reset disposition of all signals in child
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1582.git.1694167540231.gitgitgadget@gmail.com>
 <xmqqedj8vfht.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqedj8vfht.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09/2023 16:42, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> [3] This is really a work-around for not moving the child into its own
>>      process group and changing the foreground process group of the
>>      controlling terminal.
> 
> I am puzzled, as I somehow thought that "does the user conceive a
> subprocess as external and different-from-git entity, or is it
> merely an implementation detail?  many use of subprocesses in our
> codebase, it is the latter." from Peff was a good argument against
> such isolation between spawning "git" and spawned subprocesses.

It is and in those cases we do not ignore SIGINT and SIGQUIT in the 
parent when we fork the subprocess. What I was trying to say is that in 
the few cases where we do ignore SIGINT and SIGQUIT in the parent when 
we fork a subprocess we're working round the child being in the same 
process group at the parent.

Best Wishes

Phillip

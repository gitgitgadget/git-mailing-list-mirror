Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0C51F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbeGXT35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:29:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32847 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbeGXT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:29:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so5083185wrp.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9yzvfnAxgzkq/2fpC78zKLWIbJWo9FEgZytZXcREoEE=;
        b=fA108J0TIsbazSPiaG/0G3B1H1cpC6iocG3aIwuDQriB8Oevr3xbGWwlCJH/TB7ng7
         a/1FFC1aoPr/9gn893u8puYQtg/HrzuhgAt8OEIKr2dBeaIYaiLrZd4tiIIcF/AcrvNi
         YKkkFrdMViHipA7nLyNxPRpDq+eu3lVF7VhEyU+zzOV+qlkvzXzumkp/sWdEZL9F+GOV
         WwTub7+acVfV1cwP3qz7cJLH0MXh7NQsK56VDRv7apm7wEBlMO3c+96XqEZ6a7lRBHPB
         zkJ5ztBoCafSXuBgQXkhprfM/2/fG9EFkhY9dQnv++Ei2szPbkHVEeS3gwoe0C9jNyGJ
         F5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9yzvfnAxgzkq/2fpC78zKLWIbJWo9FEgZytZXcREoEE=;
        b=Z9rvXgZjOJbim+Al9MbiupY2FpcLWWepT3WarwYbdRhlPGRl8nK3cabkOfJmBTgmPm
         Fibn84CE5Ujj51M8E5zO12QymVpDHTEqcGXAjAddWJiv6n408D41y+SWq6eD1FaYwvK2
         JEm8RlErCUxACxUnxRA4XJ4XXDAVMHeBkcEVHkrCxhRYGEdQothQ224rmPdY63DQw+t/
         Uof69G17195jBt/OkxNWBBBtUywU7KSVmMkQn3cVqwIXNqJP72Ipkf7QNkiKWgjXgjod
         Yel8T2Ka8HHXWyJmwZk+AmnTH2Y1K7N+j9uZlHrxMdD7rwDkZ2uTwROGS78Vv1b/2Nf0
         zPrg==
X-Gm-Message-State: AOUpUlGPU53/GSaJIbjz8Q4kJhs698vw6b6gnf0vO93kU+cDHG0mburb
        cK7K1xml7nTxq3aWGiCfbg0=
X-Google-Smtp-Source: AAOMgpd/D7qUA5Cl27pgMnjhw+vNpypmEXH2rutOJTOfzEg1YIbjKC7jEnmg/5IcV1EoSA4+mx/6UA==
X-Received: by 2002:a5d:4acc:: with SMTP id y12-v6mr11561767wrs.132.1532456532719;
        Tue, 24 Jul 2018 11:22:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b13-v6sm20376876wrn.17.2018.07.24.11.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:22:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        me@ttaylorr.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1] config.c: fix msvc compile error
References: <20180724153010.6693-1-git@jeffhostetler.com>
        <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li>
Date:   Tue, 24 Jul 2018 11:22:11 -0700
In-Reply-To: <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li> (Beat Bolli's
        message of "Tue, 24 Jul 2018 20:16:45 +0200")
Message-ID: <xmqqwotkxzn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> Hi Jeff
>
> On 24.07.18 17:30, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> 
>> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
>> to builtin/config.c to define a new function and a forward declaration
>> for an array of unknown size.  This causes a compile error under MSVC.
>> 
>> Reorder the code to forward declare the function instead of the array.
>
> This was already fixed (differently) in
> <20180705183445.30901-1-dev+git@drbeat.li>.

Thanks for saving me from having to dig the list archive myself.
Yes, it is already applied to the tip of the topic that originally
caused the breakage.

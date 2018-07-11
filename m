Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3CF1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbeGKQkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 12:40:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53262 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeGKQkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 12:40:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so3017791wme.3
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hI4VkouVL4RikOof0xTvFQ5MY5AAsIu7aMDfW6lBoe0=;
        b=T1OVlYbwbDi8+kxyCseYfKzoUsDkQCnxD/4/QhQoj/ILgtWpOsgwdkbj1VG/mSJzxh
         oybTWbvh1muolPaPhROUJ2Uvov665MmLpv4o0LylUXCcRAMSrH7u7qYQM1Z1w3GH3vw1
         cU1r1doCaxPzj61WhiLdKLIsWB53m4bY8VXvMW111Q2vgXmYPGdKIruCJve+vYS5mZ5n
         JMwHTc2/L1BRCC8Hz3LfZ6Uiug2JQHjc230YdNN0iv280wXc5IFiDrUeWXo4GCJCbN0D
         6/bdoHOk2+1HnkjmW+8jIdg8rLA6YRYl3a7g5n310TEfd8pc7+FLGncf0H2McerGXkn7
         np3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hI4VkouVL4RikOof0xTvFQ5MY5AAsIu7aMDfW6lBoe0=;
        b=iLpCn3UOwkGK66pzdrbsutMD5JQ7vfKInlLLYT4tCZSxq3c1cwBGiQJQo8+xbi71l3
         uhHIwfkqsZnQOT1XFzvN3F7DhvW5RjwmVqRUN6W994yS4FzEfEGHO4IHIL0MBKczVFhb
         EfOQMssXwi+LJAYzZSbrcPyY/3xYj5/hdGf8QpooLsmqhRoo3alyt0WvaEY89FEaYKAH
         SjnycbISccC3NNpfKPCNl2gIxkk1Bbo5y3/FWRDw9eCuWkrudqynH8E6ADW6gFwHnybA
         cx6NYOQLSmLTQxyTALzHZOJKvIyBWAOpcZOM64dHpL/YXzs2pMPbkiIfVPz0pFDj1MAh
         nK8A==
X-Gm-Message-State: APt69E19TEvlcdMEI5KhHs68jzIaI+qHzsfc7LmOsf4HdniYmZx1nmYc
        YhT3QKr7L3Ijy12uU1x8pL03BZnJ
X-Google-Smtp-Source: AAOMgpf6wDTmOp2GB0Wuy93ajCNLdYW8DqyagdBhVY643OVpYyzxQLEgCBelrGuE1x+aDiVYgMWptw==
X-Received: by 2002:a1c:70b:: with SMTP id 11-v6mr17095317wmh.151.1531326893272;
        Wed, 11 Jul 2018 09:34:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v5-v6sm8567011wru.60.2018.07.11.09.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:34:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     William Chargin <wchargin@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] sha1-name.c: for ":/", find detached HEAD commits
References: <20180710154106.5356-1-wchargin@gmail.com>
        <xmqqwou26hcv.fsf@gitster-ct.c.googlers.com>
        <CAFW+GMAP6hwU1frm-FUVqx4pokpSQajWz7N6mGtMC-EO+01m2Q@mail.gmail.com>
        <20180711123213.GA23835@sigill.intra.peff.net>
Date:   Wed, 11 Jul 2018 09:34:52 -0700
In-Reply-To: <20180711123213.GA23835@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 11 Jul 2018 08:32:13 -0400")
Message-ID: <xmqq601l4toz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 10, 2018 at 11:18:22PM -0700, William Chargin wrote:
>
>> > Also, I am not sure if "or from HEAD" is even needed when we say
>> > "from ANY ref" already, as we count things like HEAD as part of the
>> > ref namespace.
>> 
>> My two cents: with the docs as is, I wasn't sure whether HEAD was
>> intended to count as a ref for this purpose. The gitglossary man page
>> defines a ref as a "name that begins with refs/" (seemingly excluding
>> HEAD), though it later says that HEAD is a "special-purpose ref". In my
>> opinion, the change adds clarity without any particular downside---but
>> I'm happy to revert it if you'd prefer. I'd also be happy to change the
>> wording to something like "any ref, including HEAD" if we want to
>> emphasize that HEAD really is a ref.
>
> FWIW, I think the clarification to include HEAD is helpful here, since
> it took me a few minutes of thinking to decide whether the current
> behavior was a bug or just a subtlety. Your "including HEAD" suggestion
> seems like the best route to me. But I can live with it either way.
>
>> After reaching consensus on the change to the docs, should I send in a
>> [PATCH v2] In-Reply-To this thread?
>
> Yes.
>
>> Peff, should I add your
>> Signed-off-by to the commit message, or is that not how things are done?
>
> Yes, you can add in any sign-offs that have been explicitly given. It's
> normal to order them chronologically, too (so mine would come first,
> then yours, showing that the patch flowed through me to you; Junio will
> add his at the end).

Thanks, agreed 100% and I have nothing more to add.

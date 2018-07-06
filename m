Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48BB21F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934750AbeGFTYp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:24:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934493AbeGFTYo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:24:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id j33-v6so5141006wrj.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kbJu8WIldo1s9QGBUJQ5H5xB5kjijmjpoJ+9c3AZUNM=;
        b=lsvowSA32vCiCypNHxTnQqfKY+F2pNoLTONXc8qZ+20aHJ1OBVGF84/LKWoXzOpGG7
         k0RNQujDHj3iajroVD9a5K45ug6YBsWPfTXq6AfX2rVRsrA6b+izwyZ6rSWPWuSEPQVD
         xvOdVDEogem/O2AUsUzIau7BP70r/7r6fK7XOdz0AbC0CmE7jm4US2FbNKDZcAxSl59/
         Jv0velrWVy4r5yZ6k+zMAUlcL4ozcQQHlZUL7StLcOJBIJTGGn2TZhzI0mb7lyRQgU5y
         QXlaWLc9CJKkDFL8uV7nY26CQQ9ShziMTRtlbgd7bTxWRNoMU3rThbyBjRst3vOvFD2g
         SyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kbJu8WIldo1s9QGBUJQ5H5xB5kjijmjpoJ+9c3AZUNM=;
        b=aoUMRH6TokHgpbxE1o9NrJF7cxfFWdN+0MpDgBjYoSlvKo9IYJ94vYSJkiCwoclUSC
         YCYiF7aTaE+Q6EcyLCmgxeOkVzgMNggRE4DilhU19rfN0NDfGLZxet+0mbtcn+VAAYFE
         bFMGa83pbKN11mZ3jEHyjJlnaTspXwR8tTG02ZWQoxHYLnmx2ONBg3b86xwAZTfRz+D7
         lAnzN0XZfoUZPs6WqdLrSyHjqJ9Pph5Th2e6rlOfQR36uWKK5ZKKdBxizPv7Dl64oTHl
         es9RiGnXu2mdUzQHubcRPdz1iCL9sR76yOKgrjpJymg5m9kGZ1F2jrgruxJOqpfRhove
         759g==
X-Gm-Message-State: APt69E1OonYwEJ/Mnsa/SkJVTqnIIkqD+6ByRBashO0e1NNfhQ4U5s64
        dn+tXulhAhc49Fy4Csb319Q=
X-Google-Smtp-Source: AAOMgpceI5K9E1C+JZp0Qjym4g6ovtVo8TSgunGXopceiTTqKqNYilSLCpM7999b43CfOKMeHu2k5w==
X-Received: by 2002:adf:9063:: with SMTP id h90-v6mr8922377wrh.147.1530905082943;
        Fri, 06 Jul 2018 12:24:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t140-v6sm23175wmd.14.2018.07.06.12.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:24:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config: work around an unsized array forward declaration
References: <20180705183445.30901-1-dev+git@drbeat.li>
        <20180705193807.GA4826@sigill.intra.peff.net>
        <phlsmp$mot$1@blaine.gmane.org>
        <20180705200205.GA29861@sigill.intra.peff.net>
Date:   Fri, 06 Jul 2018 12:24:41 -0700
In-Reply-To: <20180705200205.GA29861@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Jul 2018 16:02:05 -0400")
Message-ID: <xmqq1scgkw06.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jul 05, 2018 at 09:50:53PM +0200, Beat Bolli wrote:
>
>> > Your patch is obviously correct, but I think here there might be an even
>> > simpler solution: just bump option_parse_type() below the declaration,
>> > since it's the only one that needs it. That hunk is bigger, but the
>> > overall diff is simpler, and we don't need to carry that extra wrapper
>> > function.
>> 
>> That was dscho's first try in the GitHub issue. It doesn't compile
>> because the OPT_CALLBACK* macros in the builtin_config_options
>> declaration inserts a pointer to option_parse_type into the array items.
>> We need at least one forward declaration, and my patch seemed the least
>> intrusive.
>
> Ah, right, so it actually is mutually recursive.  Forward-declaring
> option_parse_type() would fix it, along with the reordering. I'm
> ambivalent between the available options, then; we might as well go with
> what you posted, then, since it's already done. :)

Among three, forward declaration of the function with reordering
that nobody has written except for in the brain smells the best, and
turning an array to a pointer that points at a separate storage looked
the worst.  I also am OK with what's already posted, too.

Thanks.

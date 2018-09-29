Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E83D1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 17:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeI3AJP (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 20:09:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35300 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeI3AJP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 20:09:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so288598wrt.2
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WuExWfszUoiuMKXR5ozIMIKfXW9ol8YAxcnnA6XMOjs=;
        b=SMtJhiqwnTnaKOpjvWhx7M8sV7C69aFzaydCvZgS7fIkozmTZsXu3GNGhpiz/F6imD
         gP5MBdS/1vpcEjTITOysDWvU+bQ7AHZtzW0CQfjNXqncoUNUkt+u98eElR60+cJzPXHm
         yATrpjUdRmBkwGGLqm+m5ggFAHqkyKPWbGNG9+J7oLJDAVD+BSRz2j2707RYdityvvsD
         iBuI4YMIvNJrhBK8asn4xwho3RPg5Xr+6Dn6kHt7KMuXegMi5vdu9N+/vSTwjQ2O2I2h
         mYBQCdXdmjsi6oeCk7tqEjR9dzUvCsr+7KAj5RTS5iyvJriAvjV5tacclq6mKKnghWwH
         yeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WuExWfszUoiuMKXR5ozIMIKfXW9ol8YAxcnnA6XMOjs=;
        b=GtzUrtmFQGUKZ1cdiof8j6vGAPCPwcCRPF7zELcpW0dSq4LCIcvt7CVnYNrz1WK8so
         wTpO0Kd1389lpdeSI2DhqwKA8ZLZXchlMMohu1WD/qFseiRIrwskVJen8YsUd9B2Oi2V
         xIAX69o3UWgUzagvc1cQLsP3x9jHQVErjnZJyttgHTqbmBMqIDtO8txwt21vCwaOBaV5
         aJvetOK5WzQFqSDBxhJ8DzOqKr+IdX0rkxMGnBv+AmmTKFAZ+MHk4AGaJao4Lrp2Dqo2
         2wFyGMi8pfV3irQDDhGsDlGdYOPFdkklkXZrS/gwgk56OwR6oMNM4JrIPdDOvWveXi/Q
         8N1w==
X-Gm-Message-State: ABuFfogLdBx3GXM6n+F2eZdnU1li31x/BKBKtiwftrRq72k+z7D8YpG6
        ybCKAGlasiFMC+fVKbPvd07C2TbD
X-Google-Smtp-Source: ACcGV604E2PazOHrMpg1+xPdCKVlqbfyPI9Ac2WcokpAcsej3rBz6x5RpOLcOx0tisnFZJ54ywY/sw==
X-Received: by 2002:adf:c3cd:: with SMTP id d13-v6mr2552795wrg.68.1538242796909;
        Sat, 29 Sep 2018 10:39:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g15-v6sm1183927wrp.56.2018.09.29.10.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 10:39:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
        <20180926184914.GC30680@sigill.intra.peff.net>
        <3677a12b-5b9b-ad2a-1e3a-7de251baa40d@rasmusvillemoes.dk>
        <20180929082108.GJ2174@sigill.intra.peff.net>
Date:   Sat, 29 Sep 2018 10:39:54 -0700
In-Reply-To: <20180929082108.GJ2174@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 29 Sep 2018 04:21:08 -0400")
Message-ID: <xmqq4le89p91.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Right, I'm proposing only to add the extra message and then continue as
> usual.
>
> It is a little funny, I guess, if you have a script which doesn't
> respond to "-h", because you'd get our "foo is aliased to git-bar"
> message to stderr, followed by who-knows-what. But as long as it's to
> stderr (and not stdout), I think it's not likely to _break_ anything.
>
>> >   - "git cp --help" opens the manpage for cherry-pick. We don't bother
>> >     with the alias definition, as it's available through other means
>> >     (and thus we skip the obliteration/timing thing totally).
>> 
>> It sounds like you suggest doing this unconditionally, and without any
>> opt-in via config option or a short wait? That would certainly work for
>> me. It is, in fact, how I expect 'git cp --help' to work, until I get
>> reminded that it does not... Also, as Junio noted, is consistent with
>> --help generally providing more information than -h - except that one
>> loses the 'is an alias for' part for --help.
>
> Yes, I'd suggest doing it always. No config, no wait.

While I do think your suggestion is the best among various ones
floated in the thread, I just realized there is one potential glitch
even with that approach.  

Suppose "git foo" is aliased to a command "git bar".

The best case is when "git bar -h" knows that it is asked to give us
a short usage.  We get "foo is aliased to bar" followed by the short
usage for "bar" and everything is visible above the shell prompt
after all that happens.

The second best case is when "git bar" simply does not support "-h"
but actively notices an unknown option on the command line to give
the usage message.  We see "foo is aliased to bar" followed by "-h
is an unknown option; supported options are ..." and everything is
visible above the shell prompt after all that happens.

The worst case is when "git bar" supports or ignores "-h" and
produces reams of output.  Sending the "aliased to" message to the
standard error means that it is scrolled out when the output is
done, or lost even when "git foo -h | less" attempts to let the
reader read before the early part of the output scrolls away.

Even the first two "better" cases share the same glitch if the "foo
is aliased to bar" goes to the standard error output.  Parse-options
enabled commands tend to show a long "-h" output that you would need
to say "git grep -h | less", losing the "aliased to" message.

At least it seems to me an improvement to use standard output,
instead of standard error, for the alias information.

In practice, however, what the command that "git foo" is aliased to
does when given "-h" is probably unknown (because the user is asking
what "git foo" is in the first place), so perhaps I am worried too
much.  When the user does not know if the usage text comes to the
standard output or to the standard error, and if the usage text is
very long or not, they probably would learn quickly that the safest
thing to do is to

	$ git unknown-command -h >&2 | less

And at that point, it does not matter which between the standard
output and the standard error streams we write "unknown-command is
aliased to ...".

So I dunno.

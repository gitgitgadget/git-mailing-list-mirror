Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF55E1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756563AbeFOVI5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 17:08:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38251 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755493AbeFOVI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 17:08:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id 69-v6so6004267wmf.3
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=axUX10b0mIrN8FMj2M6ed9pKEyN+mMTJ/BfwUrT+8nU=;
        b=lNPVaCiHzjMBGdESibSczbV5P8qPm0Xq+YrhdGOCY64/vrmXwFBCyrUm1iLxfP8mrm
         k2J0LDnkMnJ+BZZZd5bNH6FpuCtiKblQEIB8+r6UGROCRgtlvPOPeYknHKKZSIKwLCKM
         N+31QpyzWdr5fcZNAWWWFH+8F69Q62PSS6Bt+3iEJjPXEy3mtdxTluyDcKsamOmnlGCB
         qMwSCXkNXOibYaNelXC7Yv573oJlHuq7uJoODYrrKwVWN5uwfU1j+WCM0Bt8qbbQL9vU
         ywwkcELIT5eU8g166A1U9RMosPDgc3i4p5oOQ0AVSe97k6DX48YNMqgiBaPQnDe37eLi
         TYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=axUX10b0mIrN8FMj2M6ed9pKEyN+mMTJ/BfwUrT+8nU=;
        b=dl6VEb3B2YDBJVguMvrI70LYxVpReoINBHzu/NqcUCmmQn26IywyqkJ9bj2mE9uxYg
         mFVamlwxvpqB2rIuyicoru8qMhpHC9mbyjlajw1ji5Npt239ymQrdcA8Ez9PQy99Mdg3
         pjQqBH3r0nGsFg/0GHhXeXc7gIO91DUaX2kfx1m+YY+sMLr9mgll762dIUvzHPk0mzP0
         UYFtKRZD1lv4N2yQ5R8iXmODneeSul9bHN0Kxjj8gEGWKoNeF7enwu70BgN0fXYfu09i
         sTpk1zPzqSSDs4EZBuTGe2ZIKq501BieZ/pSQZhtPi2uS8qnQaYA8PNjqhyaacjEInyN
         SHzw==
X-Gm-Message-State: APt69E2TxlxoOUhCjjYzmAG/H/GaP3tXyEeiCLAYSRbLR/kxsuGlbpB7
        g4YAepsWkWjW7iHHMsY7XBk=
X-Google-Smtp-Source: ADUXVKIhtQY4aWi5gkCM1t4IUtrsRnm5oBTUjc8dYe4FIa/CC4WuS5CYAkckhKORW2/JBgt10UpmZg==
X-Received: by 2002:a1c:28c6:: with SMTP id o189-v6mr2468104wmo.102.1529096934549;
        Fri, 15 Jun 2018 14:08:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i6-v6sm9120585wrr.2.2018.06.15.14.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:08:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
References: <20180605175144.4225-1-bmwill@google.com>
        <20180613213925.10560-1-bmwill@google.com>
        <20180613213925.10560-3-bmwill@google.com>
Date:   Fri, 15 Jun 2018 14:08:53 -0700
In-Reply-To: <20180613213925.10560-3-bmwill@google.com> (Brandon Williams's
        message of "Wed, 13 Jun 2018 14:39:19 -0700")
Message-ID: <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Currently, while performing packfile negotiation, clients are only
> allowed to specify their desired objects using object ids.  This causes
> a vulnerability to failure when an object turns non-existent during
> negotiation, which may happen if, for example, the desired repository is
> provided by multiple Git servers in a load-balancing arrangement.

In other words, your "git fetch refs/heads/master" initially
contacts a mirror A and learns that its refs/heads/master is at
commit X, starts negotiation, and end up with getting served by a
mirror B that is slightly beind mirror A, which wants to give you a
packfile that brings you up to say commit X~3.  You want to be able
to say "I want to update my refs/remotes/origin/master with whatever
is (close to) the latest at your refs/heads/master", not "I just
learned refs/heads/master is at X from one of you, I demand getting
updated to that exact commit."

For that, you'd say, after getting ref advertisement, "I want
the tip of refs/heads/master that one of you have, whoever ends up
serving me eventually".

> +    want-ref <ref>
> +	Indicates to the server that the client wants to retrieve a
> +	particular ref, where <ref> is the full name of a ref on the
> +	server.  A server should ignore any "want-ref <ref>" lines where
> +	<ref> doesn't exist on the server.

But when you said "I want some version of refs/heads/bo", is it
sensible for me to say "Oh, among 7 mirrors, you unluckily ended up
with me who is most behind and do not even have 'bo' branch yet, so
I won't be giving you that branch (or history leading to the commit
my 6 friends may have at refs/heads/bo)"?  

What is the end-user visible effect of "ignoring"?  Does your "git
fetch bo" that were unluckily served by me who do not yet have the
branch error out?  If so, preferrably the conversation should faile
before packfile generation and transfer.

I am guessing that you do not want to fail the negotiation if your
"git fetch bo" happen to contact me (who lack 'bo') first, as long
as the conversation continues and switches later to one of my
friends who can fulfill the request, and that is why you are
forbidding me (who got initial contact and saw "want-ref bo") from
failing the whole thing.  But it is unclear who is responsible for
erroring out the whole "git fetch bo" *if* unlucky you ended up
getting served by the most stale mirror that does not even have
'bo'.

The story would be different if your request were 

	git fetch refs/heads/*:refs/remotes/origin/*

in which case, you are not even saying "I want this and that ref";
you are saying "all refs in refs/heads/* whoever ends up serving me
happens to have".  You may initially contact one of my friends and
learn that there are 'master' and 'bo' branches (and probably
others), and after conversation end up talking with me who is stale
and lack 'bo'.  In such a case, I agree that it is not sensible for
me to fail the request as a whole and instead serve you whatever
branches I happen to have.  I may lack 'bo' branch due to mirroring
lag, but I may also have 'extra' branch that others no longer have
due to mirroring lag of deletion of that branch!

But then I think your "git fetch refs/heads/*:refs/remotes/origin/*"
should not fail not just because I do not have 'bo', but you also
should grab other old branches I have, which you didn't hear about
when you made the initial contact with my friend in the mirror pool.

So, given that, would it make sense for 'want-ref <ref>' request to
name "a particular ref" as the above document says?  I have a
feeling that it should allow a pattern to be matched at the server
side (and it is not an error if the pattern did not match anything),
in addition to asking for a particular ref (in which case, lack of
that ref should be a hard failure, at least for the mirror that ends
up serving the packfile and the final "here are the refs your
request ended up fetching, with their values").

>  The response of `fetch` is broken into a number of sections separated by
>  delimiter packets (0001), with each section beginning with its section
>  header.
>  
>      output = *section
> -    section = (acknowledgments | shallow-info | packfile)
> +    section = (acknowledgments | shallow-info | wanted-refs | packfile)
>  	      (flush-pkt | delim-pkt)

OK.  In my initial reading, I somehow failed to read this piece
before going on to the next hunk ...

> @@ -319,6 +329,10 @@ header.
>      shallow = "shallow" SP obj-id
>      unshallow = "unshallow" SP obj-id
>  
> +    wanted-refs = PKT-LINE("wanted-refs" LF)
> +		  *PKT-LINE(wanted-ref LF)
> +    wanted-ref = obj-id SP refname
> +

... and wondered how the reader knows where wanted-ref list ends; we
will see a flush (or is it delim?  either is accepted?) where the
list ends, which is good.

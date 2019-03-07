Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E25720248
	for <e@80x24.org>; Thu,  7 Mar 2019 05:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfCGFpX (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 00:45:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40451 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGFpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 00:45:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so7898358wmh.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 21:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gJp4jYVoUIPOfPbj5y72tUibp6eX+/xrY+eB1nEPEpk=;
        b=qLhUnpI55A+LZq0fm/gk5naJNtpSQpEyt59H1TbGXaBXjvduTCa0V2pelpoWYMEpDT
         pd3nDEQQmcBtsohB9UgQDwi+bLYzFEJguPpK6aHswM1w7w7khOvMWUeOkrst5JHgM9fR
         e/aI45xckh+F8PhSR5YvIMteHVMzx089OrB6Ma7DUxbmyEbU+3CdJDid4Rw+dlZ+H+ie
         Nv5BbISQqrNApcZCh2RsOog5XeIKpncktQc49nChwKjCpbKGk9u25NT/YUSHLpdQGjpN
         xAbZfuZZebI3xad1vFvC554RTb1RGWl8bu9qM369P9Mwfwp4DTSP0faDGnhtCJtKPeK7
         DLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gJp4jYVoUIPOfPbj5y72tUibp6eX+/xrY+eB1nEPEpk=;
        b=ERBIW3PSyqUkKZXC6UQSw72yTcj/OGYDU6N2gqvzl+eAuB+2xfwdZgedfwa4CJ1bXW
         DCwBjTXKxbM5vgesHfzxvMH9xUzxlG2BxZCg/kMJqVtjlluqJvVH2v82wqtYWrypY6aU
         JT0L2n4UeMo8vAl1gcsVAXoBjiLr7Xlci2kXZ2uWsbYa7XMOma4sdeTBTtTnAzFhm+0r
         cv1M+nLY+Svl3lktv4sXVyOx6WHh3z/UKiAZxAxqAwoQruYyr5HjnapVpIpoYSb+yv/I
         aN7tW57SC6hw6HTMjarR5BazTEiyOVE8AzNnW9eAs3stk+Mwy5w4n1XuqtgYR1HYVpKc
         83KQ==
X-Gm-Message-State: APjAAAVBZr7DeL+UpG7EAbfmF7/7E0+EkDswMC8CigQZqHyzcUBqmAGV
        oDe0dwcdk0lDEgwTAJetidAkT+lPO7M=
X-Google-Smtp-Source: APXvYqyGtHaA5lTQCaOVQ4pM91f8Xc4ohogpQZv5qw75rcneVFQFkE1JpsUkmup2IyW7ElxTqMhZ9Q==
X-Received: by 2002:a1c:b38a:: with SMTP id c132mr4270434wmf.49.1551937519916;
        Wed, 06 Mar 2019 21:45:19 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p1sm9354829wmi.9.2019.03.06.21.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 21:45:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit that moves fewer files
References: <xmqqimx03fo6.fsf@gitster-ct.c.googlers.com>
        <20190306002744.14418-1-newren@gmail.com>
        <xmqqh8cgr4tf.fsf@gitster-ct.c.googlers.com>
        <CABPp-BF=GFgFRfgdG2rFK89x1tYrJO8TpECyv6BoTgz9q3Rb+g@mail.gmail.com>
Date:   Thu, 07 Mar 2019 14:45:17 +0900
In-Reply-To: <CABPp-BF=GFgFRfgdG2rFK89x1tYrJO8TpECyv6BoTgz9q3Rb+g@mail.gmail.com>
        (Elijah Newren's message of "Wed, 6 Mar 2019 20:14:37 -0800")
Message-ID: <xmqqzhq7me4y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'm not sure I'm following well enough to answer any your question(s),
> so I'll instead ask a few of my own:
>   * Are you referring to stage #2 and stage #3 of the old path or the
> new path or one of each or both of each?

If they moved the sole neighbouring file X/A to Y/A, while we added
a new path to X/B, I would expect we'd have two blobs with the same
content we added, one at X/B at stage #2 (because that is what we
wanted to have) and the other at Y/B at stage #3 (that's their wish
the heuristic is guessing).  If it were the other way, the stages
would be different.

>   * Would this be consistent with how normal renames behave?
> and, as a partial answer to your question:

The use of the three-way merge logic at the tree structure level,
unlike the "because neighbours moved" heuristics, gives a more
definite answer.  We see that the contents in the original at path A
(in the common ancestor version) is now at path B (with or without
slight modification) in their tree, while we kept it at path A
(again, with or without modification).  Or vice versa.  Either way,
at the tree structure level, that is "one side changes, while the
other side does not modify" which is resolved cleanly to "take the
new path the side that modifies wants the file to have".  So we do
not need to use the stages to represent "these sides wants to place
it at different paths, which one is correct?"  Instead, we'd have
stages #1 (common ancestor), #2 (ours) and #3 (theirs) all at path B
(i.e. the cleanly resolved structural change conflict) to help the
user reconcile content level conflicts (iff needed).


> I would prefer to tell the user they can resolve the conflict with two
> other commands.  I'm currently thinking of something like these two:
>     git add $directory_renamed_path
>     git mv $directory_renamed_path $original_path [&& git add $original_path ?]
> This pair assumes we write the working tree and index entries for
> $directory_renamed_path and leave $original_path empty in both the
> working tree and index.  We could alternatively reverse that, with an
> equivalent but swapped set of commands for resolution.

Yeah, the final version may have difference in detail, but I think
it is sensible to leave a state, from which the user can go in
either direction, with a simple command or two, like the above one.

>> ...  With that
>> attitude, we may be able to get rid of choice (a) altogether, which
>> may make things a tad simpler.  IOW, we assume the heuristics would
>> suggest the right solution most of the time, just like we assume
>> rerere gives a reasonable resolution most of the time, with a knob
>> to accept the result blindly, together with hints to recover when
>> heuristics makes mistakes.
>
> I like that analogy.  I think that aligns well with my possible
> conflict-resolution commands, and further answers the question about
> whether to put the new path or the old path in the working tree and
> index.
>
> However, we do need some form of choice (a) for commands which can't
> provide accurate tree information, such as git-am.

Yeah, if we are not even running the heuristics for that case (a),
hence it is not sensible to expect to offer "if we were doing
directory renames, this path might have gone to that other place",
then I think I am fine with not giving any hint to change their mind
(after all, they can "git reset --hard" and retry the merge, this
time not using the non-default (a) mode).  And keeping around the
simplest "we do not even attempt to" (a) mode as another option is
fine by me.

THanks.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C041F5FB
	for <e@80x24.org>; Sat, 25 Feb 2017 06:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbdBYGTY (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 01:19:24 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35077 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbdBYGTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 01:19:23 -0500
Received: by mail-pf0-f196.google.com with SMTP id o78so321360pfj.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 22:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HN6v6dxd1o2EHyvtnr/4V9ttLRTnQPzg26yBRbCkwmE=;
        b=FLJxEEUS+2WSnHHeiLDO+/nR8PtS6N9MYB5ypiNuS2+Rlh3zO7F7huJJk35jo9+Q/l
         HhoVTwAv0Cfx6Vvi5XhbGaeFqC1ENEk45/fZIpDogkaZrUh7MnlrTtaWDwfOIlaWqgMm
         fMj36X8GRczTAQKYDaR3twNPR6yZDIwtWkJAGBnZhZ927SAZ7sO2SbHsXXELuugfrll/
         Ll6QAJGtKjtFqUKZR0XxamK1Nyxq2803nkczGLeVF5cltAaj6hp1qC4smzhUhd8r2GwG
         e9ZFzJ2hWuz6MxkeBqGsisy8T8N7tCDTaIhtuU6GFs27/KQlSgliFU5kEw/KndfnOjl8
         kCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HN6v6dxd1o2EHyvtnr/4V9ttLRTnQPzg26yBRbCkwmE=;
        b=fGSasTRmELgKhdmRTW7aQ5303wev9wgep70gTCKIebcqE/i4pKt0OVfpnFacksKo83
         YKADNMeEPZuvvxz/krbQesHrEu43Qa8gcbUW4LQ3vhcA4S5xgUaprTHdeAZajqCCYxeQ
         wIOrhuzufxaZNRy7vCyXrhH6G2umpZnIsQdttlsz8uk9zqz2jpva5U08T9bhExu5kfsl
         ZPQ6PaOatuiYICD3payDnbN+aJstrTlbi29ad6IEFCVN4eyrcnnJHq7yPJuIsvGe2k5I
         kiaP3ZK+OYpDMAn6j0TLgbMHJw01enjKukQhvJvbB/0M9VdibbxJuiccmZ2LUz5TzwCE
         M6EQ==
X-Gm-Message-State: AMke39nq/h1094mU60Ee4TESVJG3eouaUzEigMPsdFj1klEiFziJryD93mw2aNu1QyFdhA==
X-Received: by 10.99.193.17 with SMTP id w17mr8381575pgf.124.1488003004109;
        Fri, 24 Feb 2017 22:10:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id u24sm18208949pfi.25.2017.02.24.22.10.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 22:10:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
        <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
Date:   Fri, 24 Feb 2017 22:10:01 -0800
In-Reply-To: <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 24 Feb 2017 16:39:45 -0800")
Message-ID: <xmqqinnyztqe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For example, what I would suggest the rules be is something like this:
>
>  - introduce new tag2/commit2/tree2/blob2 object type tags that imply
> that they were hashed using the new hash
>
>  - an old type obviously can never contain a pointer to a new type (ie
> you can't have a "tree" object that contains a tree2 object or a blob2
> object.
>
>  - but also make the rule that a *new* type can never contain a
> pointer to an old type, with the *very* specific exception that a
> commit2 can have a parent that is of type "commit".

OK, I think that is what Peff was suggesting in his message, and I
do not have problem with such a transition plan.  Or the *very*
specific exception could be that a reference to "commit" can use old
name (which would allow binding a submodule before transition to a
new project).

We probably do not need "blob2" object as they do not embed any
pointer to another thing.  A loose blob with old name can be made
available on the filesystem also under new name without much "heavy"
transition, and an in-pack blob can be pointed at with _two_ entries
in the updated pack index file under old and new names, both for the
base (just deflated) representation and also ofs-delta.  A ref-delta
based on another blob with old name may need a bit of special
handling, but the deltification would not be visible at the "struct object"
layer, so probably not such a big deal.

We may also be able to get away without "commit2" and "tag2" as
their pointers can be widened and parse_{commit,tag}_object() should
be able to deal with objects with new names transparently.  "tree2"
may be a bit tricky, though, but offhand it seems to me that nothing
is insurmountable.

> That way everything "converges" towards the new format: the only way
> you can stay on the old format is if you only have old-format objects,
> and once you have a new-format object all your objects are going to be
> new format - except for the history.

Yes.

> So you will end up with duplicate objects, and that's not good (think
> of what it does to all our full-tree "diff" optimizations, for example
> - you no longer get the "these sub-trees are identical" across a
> format change), but realistically you'll have a very limited time of
> that kind of duplication.
>
> I'd furthermore suggest that from a UI standpoint, we'd
>
>  - convert to 64-character hex numbers (32-byte hashes)
>
>  - (as mentioned earlier) default to a 40-character abbreviation
>
>  - make the old 40-character SHA1's just show up within the same
> address space (so they'd also be encoded as 32-byte hashes, just with
> the last 12 bytes zero).

Yes to all of the above.

>  - you'd see in the "object->type" whether it's a new or old-style hash.

I am not sure if this is needed.  We may need to abstract tree_entry walker
a little bit as a preparatory step, but I suspect that the hash (and
more importantly the internal format) can be kept as an internal
knowledge to the object layer (i.e. {commit,tree,tag}.c).

So,... thanks for straightening me out.  I was thinking we would
need mixed mode support for smoother transition, but it now seems to
me that the approach to stratify the history into old and new is
workable.

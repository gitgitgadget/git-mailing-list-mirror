Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2BF201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdBYAjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:39:48 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:33207 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYAjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:39:47 -0500
Received: by mail-oi0-f43.google.com with SMTP id 2so18519149oif.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 16:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ee7FPMg44oahh2N2HAeZWDWBf/l43jwtM/6Z7t2awfs=;
        b=NSdxFI7BMHg/i7jKh9SrwYB1DhEsvB+g20H5+iV9Iizt7na1UrXhBIUAYw0Qe+cVz4
         xzu4NEUHzRygavVHA0Z2EfqBfFJcYIoKXSsixRh99L8wR9KARt1sd7nNs3ZzCMomU+S0
         uiBtkIN4ivMgyIgEogMC2q4ObQf34cQz/jGKs6QA9IM2ijd1r9E3/XJVpsxQXU5waaht
         LrCLiiKjXCI91V8W6QVbeatqQeNasW1wTOxmEqV6ykBpjPLgYv2adgJYXjmtDZtTFMbs
         ajs7bB9wLCKiME3Oj2nQBVKckxcGywlvfhirQ3dB/jC9CwnaPirbXaB2DurQP/Aclb2/
         0uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ee7FPMg44oahh2N2HAeZWDWBf/l43jwtM/6Z7t2awfs=;
        b=DPKBG9j1VyM/Gi7b+/o03B/4WygSU4R8mkw84gdH2Zi5I9EZTL+xPkj/+So2YPM4Ve
         HdrSjdvinkxXMfVK0dzOLw8DEljPuTGX+jo8VhS5ScwOA3OUmgJlT44i0vy442MUZyA0
         B7grQ/iJojdRcxTeLqiI6LIegvZ8Cbgzl5Y9rN/sAu7a7CAemq5cTRcHrx6ECWInGrrZ
         QakmIla7sJLEZVYzfTVj2LBZL+Bck2ugn7iMQrcqxykZoIcOQSO/wEuPj06Y6xbqLi+m
         EPjMsmHUZIs6eno+DnT1Qa888ZZndrwLThpJkjxcfLgueaUIvjUsthwYU7/ieAHFdQyL
         VM6g==
X-Gm-Message-State: AMke39ljgblXyOgAFdg1CyVZ2eINEI4VBp6WcMj507tvrua3SUC2yj7lRPQ8Kzz8Pxn7meEZ2ERb16oMw/x2WA==
X-Received: by 10.202.242.8 with SMTP id q8mr3159280oih.129.1487983186189;
 Fri, 24 Feb 2017 16:39:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.164.66 with HTTP; Fri, 24 Feb 2017 16:39:45 -0800 (PST)
In-Reply-To: <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Feb 2017 16:39:45 -0800
X-Google-Sender-Auth: TrHTAnR5DkQryGUg_zUIH5gdPic
Message-ID: <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 3:39 PM, Jeff King <peff@peff.net> wrote:
>
> One thing I worry about in a mixed-hash setting is how often the two
> will be mixed.

Honestly, I think that a primary goal for a new hash implementation
absolutely needs to be to minimize mixing.

Not for security issues, but because of combinatorics. You want to
have a model that basically reads old data, but that very aggressively
approaches "new data only" in order to avoid the situation where you
have basically the exact same tree state, just _represented_
differently.

For example, what I would suggest the rules be is something like this:

 - introduce new tag2/commit2/tree2/blob2 object type tags that imply
that they were hashed using the new hash

 - an old type obviously can never contain a pointer to a new type (ie
you can't have a "tree" object that contains a tree2 object or a blob2
object.

 - but also make the rule that a *new* type can never contain a
pointer to an old type, with the *very* specific exception that a
commit2 can have a parent that is of type "commit".

That way everything "converges" towards the new format: the only way
you can stay on the old format is if you only have old-format objects,
and once you have a new-format object all your objects are going to be
new format - except for the history.

Obviously, if somebody stays in old format, you might end up still
getting some object duplication when you continue to merge from him,
but that tree can never merge back without converting to new-format,
so it will be a temporary situation.

So you will end up with duplicate objects, and that's not good (think
of what it does to all our full-tree "diff" optimizations, for example
- you no longer get the "these sub-trees are identical" across a
format change), but realistically you'll have a very limited time of
that kind of duplication.

I'd furthermore suggest that from a UI standpoint, we'd

 - convert to 64-character hex numbers (32-byte hashes)

 - (as mentioned earlier) default to a 40-character abbreviation

 - make the old 40-character SHA1's just show up within the same
address space (so they'd also be encoded as 32-byte hashes, just with
the last 12 bytes zero).

 - you'd see in the "object->type" whether it's a new or old-style hash.

I suspect it shouldn't be too painful to do it that way.

                Linus

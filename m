Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC41F207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 13:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755411AbcI2NB4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 09:01:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34829 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755545AbcI2NBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 09:01:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id 6so3576104pfl.2
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=ULEop57gmUSLvPbEXUXslmYGdAwUCowifoBDz32XZlU=;
        b=qq4WJJq7ldSDicRyV/PA6UaF1IM3ImbVDwOFn5jUNAXkzO2zXHHZaKGFT6W24jza7w
         fOLJVBwCIEXChCrEjY6DvgPkCkcKOvoIXuyQtKmOagBGiQUEi8aKKZfdg/sO1Ifu33JO
         c+iExZ+Fe5OK0DtNpNg09PF1XB2+BypFl4csn9r0xIGkS1sY02Hsc1M50eMrpxcuysm4
         OwImSY3U79TxIThIpEBiBnodgmnrc5UjyxECOTf0joa8q0nmkMwBXuWzzzQgjsW+c+Yo
         MJ1e7axRBSsL7KckEmCi+/xvAJnFy8MRsfZlrFXmxQ6ZuzuR4UFOzTcm4RDbs0Q6NGLh
         aLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=ULEop57gmUSLvPbEXUXslmYGdAwUCowifoBDz32XZlU=;
        b=lIxAWXEF2lvzBuSUp3LR8G48P5EG+ZjwFZwwh7FjUARvF50zHFW3u076yBGYc7l1VI
         QTK9R4EcYmCDIWbuucmZXVW9u+eViqQfIye3PZM988kNNvjCQh/74LIzdFLQyuFih9Xa
         X2eygbxl0Aqn+xNQ4tx/7IbMuSlw1tFAmgeAGpdgx2Cn8CbzBDfYClG7eR9oerQte2Ei
         WOCT+YP3rQJUqLBuITGk90zSNw4wDgtchDcshRwYZnssS2CHcvOtUm29cBkkBya01Vwo
         VI+HdVmpB044S25gG7j911VXWRJnkOcF2xrnhszdF8mTfnrJiedZb/juT+WtLLU7QwIA
         tPcg==
X-Gm-Message-State: AA6/9Rl+olL5uYeWI5TJQvQx8LK1xFQ3bvp7d7lR8T3M0f5tN147JqUKqUXmR8d2RSDB3w==
X-Received: by 10.98.61.203 with SMTP id x72mr2287500pfj.50.1475154113139;
        Thu, 29 Sep 2016 06:01:53 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id i8sm20342821paw.25.2016.09.29.06.01.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 06:01:52 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net> <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net> <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
Message-Id: <841D4FC2-9673-486A-8D94-8967188CCC60@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Thu, 29 Sep 2016 06:01:51 -0700
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 26, 2016, at 09:36, Linus Torvalds wrote:

> On Mon, Sep 26, 2016 at 5:00 AM, Jeff King <peff@peff.net> wrote:
>>
>> This patch teaches get_short_sha1() to list the sha1s of the
>> objects it found, along with a few bits of information that
>> may help the user decide which one they meant.
>
> This looks very good to me, but I wonder if it couldn't be even more  
> aggressive.
>
> In particular, the only hashes that most people ever use in short form
> are commit hashes. Those are the ones you'd use in normal human
> interactions to point to something happening.
>
> So when the disambiguation notices that there is ambiguity, but there
> is only _one_ commit, maybe it should just have an aggressive mode
> that says "use that as if it wasn't ambiguous".

If you have this:

faa23ec9b437812ce2fc9a5b3d59418d672debc1 refs/heads/ambig
7f40afe646fa3f8a0f361b6f567d8f7d7a184c10 refs/tags/ambig

and you do this:

$ git rev-parse ambig
warning: refname 'ambig' is ambiguous.
7f40afe646fa3f8a0f361b6f567d8f7d7a184c10

Git automatically prefers the tag over the branch, but it does spit  
out a warning.

> And then have an explicit command (or flag) to do disambiguation for
> when you explicitly want it.

I think you don't even need that.  Git already does disambiguation for  
ref names, picks one and spits out a warning.

Why not do the same for short hash names when it makes sense?

> Rationale: you'd never care about short forms for tags. You'd just use
> the tag name. And while blob ID's certainly show up in short form in
> diff output (in the "index" line), very few people will use them. And
> tree hashes are basically never seen outside of any plumbing commands
> and then seldom in shortened form.
>
> So I think it would make sense to default to a mode that just picks
> the commit hash if there is only one such hash. Sure, some command
> might want a "treeish", but a commit is still more likely than a tree
> or a tag.
>
> But regardless, this series looks like a good thing.

I like it too.

But perhaps it makes sense to actually pick one if there's only one  
disambiguation of the type you're looking for.

For example given:

235234a blob
2352347 tag
235234f tree
2352340 commit

If you are doing "git cat-file blob 235234" it should pick the blob  
and spit out a warning (and similarly for other cat-file types).  But  
"git cat-file -p 235234" would give the fatal error with the  
disambiguation hints because it wants type "any".

If you are doing "git show 235234" it should pick the tag (if it peels  
to a committish) because Git has already set a precedent of preferring  
tags over commits when it disambiguates ref names and otherwise pick  
the commit.

Lets consider this approach using the stats for the Linux kernel:

> Ambiguous prefix length 7 counts:
>   prefixes:   44733
>    objects:   89766
>
> Ambiguous length 11 (but not at length 12) info:
>   prefixes:       2
>                   0 (with 1 or more commit disambiguations)
>
> Ambiguous length 10 (but not at length 11) info:
>   prefixes:      12
>                   3 (with 1 or more commit disambiguations)
>                   0 (with 2 or more commit disambiguations)
>
> Ambiguous length 9 (but not at length 10) info:
>   prefixes:     186
>                  43 (with 1 or more commit disambiguations)
>                   1 (with 2 or more commit disambiguations)
>
> Ambiguous length 8 (but not at length 9) info:
>   prefixes:    2723
>                 651 (with 1 or more commit disambiguations)
>                  40 (with 2 or more commit disambiguations)
>
> Ambiguous length 7 (but not at length 8) info:
>   prefixes:   41864
>                9842 (with 1 or more commit disambiguations)
>                 680 (with 2 or more commit disambiguations)

Of the 44733 ambiguous length 7 prefixes, only about 10539 of them  
disambiguate into one or more commit objects.

But if we apply the "spit a warning and prefer a commit object if  
there's only one and you're looking for a committish" rule, that drops  
the number from 10539 to about 721.  In other words, only about 7% of  
the previously ambiguous short commit SHA1 prefixes would continue to  
be ambiguous at length 7.  In fact it almost makes a prefix length of  
9 good enough, there's just the one at length 9 that disambiguates  
into more than one commit (45f014c52).

--Kyle

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7341F437
	for <e@80x24.org>; Sat, 28 Jan 2017 05:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbdA1Fn7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 00:43:59 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:56517 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdA1Fn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 00:43:59 -0500
Received: from homiemail-a62.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 515B6E0761
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:43:44 -0800 (PST)
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id 18491634079
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type; s=bit-booster.com; bh=xyWK0C1iZtf3YDpLd6jWc
        XWHKJo=; b=L1QKwJ+qn4naL5pdQWYalBuPM/r+X+lg7hJht7429NmRbPF4RJ4pn
        2LLGsBm7YRHXyHnETrhZmScvJX7eh3xaOymuUgWQwNyTNgJO1gzWUX4GpHHMLm+u
        qOn/d0zMwHPn0g2lK1EDx52BUXWEvmFq5Dw+mEcZsFgoEM5enij2kM=
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com [209.85.213.170])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id 09A83634075
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:42:43 -0800 (PST)
Received: by mail-yb0-f170.google.com with SMTP id j82so74040313ybg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 21:42:43 -0800 (PST)
X-Gm-Message-State: AIkVDXLZACnrJbSUx9Js2porrHE8x/EgcHxbkrij0VyltGthQr2+tkXcj9mq+M8LWpwLHmVZTZlCamSbVJhtoA==
X-Received: by 10.37.219.81 with SMTP id g78mr4222470ybf.168.1485582161814;
 Fri, 27 Jan 2017 21:42:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.56.201 with HTTP; Fri, 27 Jan 2017 21:42:41 -0800 (PST)
In-Reply-To: <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
References: <CANwu5-o=3p8QfWo9wQvok=UZESRVtF3Uxb3nEMZVv8AvkKYYGw@mail.gmail.com>
 <20170127175151.srhhczliqgvbzcre@sigill.intra.peff.net>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Fri, 27 Jan 2017 21:42:41 -0800
X-Gmail-Original-Message-ID: <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
Message-ID: <CAAj3zPzO4+9t9_L2OXFmkihw-HwFvzybb7GXs4tTeFRyZHOaNQ@mail.gmail.com>
Subject: Re: show all merge conflicts
To:     Jeff King <peff@peff.net>
Cc:     Michael Spiegel <michael.m.spiegel@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 9:51 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 27, 2017 at 11:56:08AM -0500, Michael Spiegel wrote:
>
>> I'm trying to determine whether a merge required a conflict to resolve
>> after the merge has occurred. The git book has some advice
>> (https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging) to use
>> `git show` on the merge commit or use `git log --cc -p -1`. These
>> strategies work when the merge conflict was resolved with a change
>> that is different from either parent. When the conflict is resolved
>> with a change that is the same as one of the parents, then these
>> commands are indistinguishable from a merge that did not conflict. Is
>> it possible to distinguish between a conflict-free merge and a merge
>> conflict that is resolved by with the changes from one the parents?
>
> No. You'd have to replay the merge to know if it would have had
> conflicts.
>


Aside from the usual "git log -cc", I think this should work (replace
HEAD with whichever commit you are analyzing):

git diff --name-only HEAD^2...HEAD^1 > m1
git diff --name-only HEAD^1...HEAD^2 > b1
git diff --name-only HEAD^1..HEAD    > m2
git diff --name-only HEAD^2..HEAD    > b2

If files listed between m1 and b2 differ, then the merge is dirty.
Similarly for m2 and b1.

More information here:

http://stackoverflow.com/questions/27683077/how-do-you-detect-an-evil-merge-in-git/41356308#41356308


- Sylvie



> There was a patch series a few years ago that added a new diff-mode to
> do exactly that, and show the diff against what was resolved. It had a
> few issues (I don't remember exactly what) and never got merged.
>
> Certainly one complication is that you don't know exactly _how_ the
> merge was done in the first place (e.g., which merge strategy, which
> custom merge drivers were in effect, etc). But in general, replaying
> with a standard merge-recursive would get you most of what you want to
> know.
>
> I've done this manually sometimes when digging into erroneous merges
> (e.g., somebody accidentally runs "git reset -- <paths>" in the middle
> of a merge and throws away some changes.
>
> You should be able to do:
>
>   git checkout $merge^1
>   git merge $merge^2
>   git diff -R $merge
>
> to see what the original resolution did.
>
> -Peff

Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B57C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E2B20722
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1BZ35A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0MTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:19:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35212 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0MTG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:19:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so4239074edv.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 04:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSpkd9AQA55xGKMx4ftMBa3vUsz0Nc3BbGgs9tp1dbk=;
        b=G1BZ35A+X6oG+UU3lyztXoqeW/TEXr7kKxgFOzJRAe0JezUUxXufwC9puK7lzQGN5Q
         c7Z2WDH4r0zof4BENcd0QG1VdkLK2Qxb7ze/xKIUW6e+TF0pJe1SkLjvqp1VrWKlEID0
         zzWWaJTjKUX96uUWcTYVqrKpJY7RjH9blx4lzCr9sjxJSMD6tY6Z1tbSWXRPqZAFoIji
         +3TQ6N822PaIG69Lgqg229MzlawRP6G2GAd+YLtuDThWJijfdQbC2b2BiWrh7XMXzRyD
         cocWUPMILr1/NBkJfLms9KEDUgp64h3j0RiwjWFmos9PGss7GCwhPuzjIeTKC0xydmT/
         icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSpkd9AQA55xGKMx4ftMBa3vUsz0Nc3BbGgs9tp1dbk=;
        b=OKmTHViqddnIPR9N0T4eIl4si9xGs7ds8UOLqCVA+vN31l29/3yI/WUDtGaGXA2Gz8
         KOY7MH6klD8K23iHr2XYTOFWDoJ1WISL5RlQwiuafCkd7VdJh0/RXxAOV2aykpi4VE08
         8wZ3pMHD6X+j0ql1O7N2NYnrZ0nvJtx5g+O8HYmQ1bfURurQQ4uKOHViH6YBtUIatA9D
         BITRNR9+ZaerYR1dXUrrKuA/HiEBwlY4ojidIErdbNsvqhIxz38QlzlQa7i+5PhHFPIv
         r+MejrR9pAffGROPd7ysQqJK2nMXDYg0qeYpRX8R/Kfphw2htwhd6eyfapl90Ae/9AQA
         0bEg==
X-Gm-Message-State: APjAAAVNBHnVF2Yx+FlnIisIayVLXMb40n/nLkORxodOUM6urgg5EoXi
        At3bZy8rept/w6PscZP6G49pCz5b8VZLW8LUcUo=
X-Google-Smtp-Source: APXvYqzR13Ny11LEX35IQP7+VS7+ulgaa66Z9Z137qo/S4itbvJcVvvJ2ijssAKLD8X77k/YMeq10+FYNWQGoP5UcRA=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr31624755edw.280.1574857144124;
 Wed, 27 Nov 2019 04:19:04 -0800 (PST)
MIME-Version: 1.0
References: <87o8x06sbw.fsf@sydneypc> <20191125141635.GD494@sigill.intra.peff.net>
 <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
 <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
 <CAAE-R+8yZOchnsa-au+w4JveCQffw9bpGZ54oL+DApa8Y094=Q@mail.gmail.com> <20191127113007.GB22221@sigill.intra.peff.net>
In-Reply-To: <20191127113007.GB22221@sigill.intra.peff.net>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Wed, 27 Nov 2019 23:18:52 +1100
Message-ID: <CAAE-R+8neOxJTt+gUrh0JeftaOU1jPKgV2_3NS2KbMTMqdfL7Q@mail.gmail.com>
Subject: Re: A new idea to extend git-blame
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Got it. I will try to finish the patch first.

On Wed, Nov 27, 2019 at 10:30 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 27, 2019 at 06:32:37PM +1100, chen bin wrote:
>
> > Just double checking, the feature I suggested is fine, right? I will
> > send the patch asap. It may take 2 weeks to implement.
>
> To be clear, I can't say whether a patch is fine or not without seeing
> the patch. :)
>
> I'm not entirely sure I understand what you're proposing to implement.
> But if it's of interest to you, maybe it makes sense to see if you can
> make it work to your satisfaction, and then we can all look at the patch
> and what it does to see if it makes sense to include in Git?
>
> > > > I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
> > > > d01d26f2df. Looks git log is not what I expected. The output contains
> > > > many unrelated commits. So it will be slow in real project.
>
> Looking at the output from that command, the issue is that it's
> imperfect to decide which lines in the pre- and post-image correspond to
> each other. The first commit is:
>
>   diff --git a/README.md b/README.md
>   --- a/README.md
>   +++ b/README.md
>   @@ -26,3 +26,1 @@
>   -See Documentation/gittutorial.txt to get started, then see
>   -Documentation/giteveryday.txt for a useful minimum set of commands, and
>   -Documentation/git-commandname.txt for documentation of each command.
>   +See [Documentation/gittutorial.txt][] to get started, then see
>
> at which point we consider all three of the pre-image lines to be
> potentially interestnig. And then the next commit:
>
>   diff --git a/README b/README
>   --- a/README
>   +++ b/README
>   @@ -29,3 +29,3 @@
>    See Documentation/gittutorial.txt to get started, then see
>   -Documentation/everyday.txt for a useful minimum set of commands, and
>   +Documentation/giteveryday.txt for a useful minimum set of commands, and
>    Documentation/git-commandname.txt for documentation of each command.
>
> touches one of those lines, and so forth. A human might see that in the
> first hunk, it was probably the first line of the hunk that was
> interesting to keep following backwards. But I don't think it can be
> done automatically (which is why manual "reblame from parent" is still a
> useful technique).
>
> It sounds like your suggestion is to take some anchor text on the line
> to decide which lines to keep following. But then it sounds a lot more
> like a "log -L" feature than a git-blame feature.
>
> -Peff



-- 
help me, help you.

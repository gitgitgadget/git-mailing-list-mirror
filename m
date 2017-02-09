Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66CC1FC46
	for <e@80x24.org>; Thu,  9 Feb 2017 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdBIMAP (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 07:00:15 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33929 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdBIMAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 07:00:11 -0500
Received: by mail-oi0-f68.google.com with SMTP id w144so104001oiw.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 04:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5F+8Vye38+Ybf6BPXdF3E/ohCPcruiCJy/YuVAR6ZEc=;
        b=DGAaNHA5yu2dA7AvcZFFxwTs+EIKojRjBUaXQRSmlnRz5oOgsn2/0qr65zgbtlspOO
         sECcCIIFTVVIf1KjumnelgqwLYzvRlzQPQ+Csl0PCMBYxghGiGBg4h5FSJ0yON7alQx7
         tHaXauajjnDye9SofpmqabXQsYqYYuq4d+zXnt3yCUtvyH1Mj+5f/j3kYA4YmCMDgi2/
         iXBKACXJogWBn3ElIENn1XJU7IYUWjtvmEuIf4FtvL2r3/6BU1fa7IEhJdMKL/a3qmIY
         H7/nVjioN4+Bukh07SJJ47qkEqpWX5JWcLIf/CEvnX26LR/YRNPTuVNIOl21jV5p7FGf
         KxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5F+8Vye38+Ybf6BPXdF3E/ohCPcruiCJy/YuVAR6ZEc=;
        b=HEK6IuUYAYLldfKcXecHJs430EXzdHFSIQ8ZpyNdFiBTgbfz4ZARWHpxVyVJW03cPr
         zzdm1FQPzoLOfy5WeynabmUtplPoSX4GtDNiWLdyDIH8repPDOD9KiBp7MQMsQfZEKdA
         5XUE6X79ornSkH+deP6RzxsQ7ncCnJFhtVD8qibSolFIx8iSzXSuc0b1awjOJPcK2E9Q
         IOOQmpXeOpoc8yY3Mx7d6yjGHhN5asWvzZca8xfbwm0A7k1iM4SghWope74gDxrwEYI+
         GwgwYUW8Dz2wHztUzPzwA65sWhQjFHW5yxZ3EfOGiCHNx6QQFVzrVmbEza734yhXaZbi
         I00Q==
X-Gm-Message-State: AMke39n2fXnsaj3dHHnTu5oKojqfWiGI6XRTU+c498BIHyQ8J2W08OGC95phad+ST19fuDryDzn0HFtrmiveBw==
X-Received: by 10.202.60.67 with SMTP id j64mr1419731oia.124.1486641602696;
 Thu, 09 Feb 2017 04:00:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 9 Feb 2017 03:59:31 -0800 (PST)
In-Reply-To: <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
References: <20170208113144.8201-1-pclouds@gmail.com> <20170208113144.8201-3-pclouds@gmail.com>
 <37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 Feb 2017 18:59:31 +0700
Message-ID: <CACsJy8Diy92CNbJ1OBn893VFFrSsxBFWSyQHjt_Dzq9x7jfibQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree.c: use submodule interface to access refs
 from another worktree
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 1:07 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It is unquestionably a good goal to avoid parsing references outside of
> `refs/files-backend.c`. But I'm not a fan of this approach.

Yes. But in this context it was more of a guinea pig. I wanted
something simple enough to code up show we can see what the approach
looked like. Good thing I did it.

>
> There are two meanings of the concept of a "ref store", and I think this
> change muddles them:
>
> 1. The references that happen to be *physically* stored in a particular
>    location, for example the `refs/bisect/*` references in a worktree.
>
> 2. The references that *logically* should be considered part of a
>    particular repository. This might require stitching together
>    references from multiple sources, for example `HEAD` and
>    `refs/bisect` from a worktree's own directory with other
>    references from the main repository.
>
> Either of these concepts can be implemented via the `ref_store` abstraction.
>
> The `ref_store` for a submodule should represent the references
> logically visible from the submodule. The main program shouldn't care
> whether the references are stored in a single physical location or
> spread across multiple locations (for example, if the submodule were
> itself a linked worktree).
>
> The `ref_store` that you want here for a worktree is not the worktree's
> *logical* `ref_store`. You want the worktree's *physical* `ref_store`.

Yep.

> Mixing logical and physical reference stores together is a bad idea
> (even if we were willing to ignore the fact that worktrees are not
> submodules in the accepted sense of the word).
>
> ...
>
> I think the best solution would be to expose the concept of `ref_store`
> in the public refs API. Then users of submodules would essentially do
>
>     struct ref_store *refs = get_submodule_refs(submodule_path);
>     ... resolve_ref_recursively(refs, refname, 0, sha1, &flags) ...
>     ... for_each_ref(refs, fn, cb_data) ...
>
> whereas for a worktree you'd have to look up the `ref_store` instance
> somewhere else (or maybe keep it as part of some worktree structure, if
> there is one) but you would use it via the same API.

Oh I was going to reply to Stefan about his comment to my (**)
footnote. Something along the this line

"Ideally we would introduce a new set of api, maybe with refs_ prefix,
that takes a refs_store. Then submodule people can get a ref store
somewhere and pass to it. Worktree people get maybe some other refs
store for it. The "old" api like for_each_ref() is a thin wrapper
around it, just like read_cache() vs read_index(&the_index). If the
*_submodule does not see much use, we might as well kill it and use
the generic refs_*".

If I didn't misunderstood anything else, then I think we're on the same page.

Now I need to see if I can get there in a reasonable time frame (so I
can fix my "gc in worktree" problem properly) or I would need
something temporary but not so hacky. I'll try to make this new api
and see how it works out. If you think I should not do it right away,
for whatever reason, stop me now.
-- 
Duy

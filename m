Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA9C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 18:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiCGSEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbiCGSEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 13:04:33 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A774DF76
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 10:03:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n2so5076469plf.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HSvjwnbgupIIH5aBA7V3bvgxx3luXpVj8rs0P+cMcxk=;
        b=UQ4ANHTafRNs2r8/z2l6IEVw9fTybkSXmGEUp3QTSbxcEA0Igfx3YbW4noNMWRkYUt
         bxo80DO1mtP4z0Ke89cM7SOzSFCjFcpsveX6b1SY5DuqhfOzj1peBG3kYpvY9aJSwlJN
         BrkBZ5lgnDA5drhzJORdKOphCKliMyiZeaTHv49vc7RYCAS3Iy57FPp578JXiFnPsidi
         M0KXcEdMSOpEHMu4CkI5smmjedgfOAKn9ZhGUr0oBZYv6y3JD8QS2/AjEWJiABfsgGGk
         EQERFlLpNk43iYDTdNN/e94WF3AcwbpsWEbyabjXceb4rm0rTxbPZe10OU/J0kLmLnhw
         Mm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HSvjwnbgupIIH5aBA7V3bvgxx3luXpVj8rs0P+cMcxk=;
        b=wQxCoQAz7HnYJJ8gCBN6TtyWMKchEu1FwZNB+1yOkq5Mqc+io4S8gO/hB4ra/KFkjA
         aqgg0t0ZUczgd6AyRH6POL9smH5ncrQxqmwVf7fK3A1p7fHgo3Cj/4SOLdEkCHEuWVyc
         Ih7SgTCDoPkjlfdjlBHHnJZNYUO6aksu9UFP6DqyTe6V0egnscDLUdeyvPfx7hj5GvUZ
         rjC3lj96bpfhrH6Qnkn2TVyipR6nGbgz0m+FIgywoIn4YT9jNUb99BAnoif9y146MuWg
         MZUWn9qDps9e0FrXmw46eRY3F5zuLZqYFsq/SYX49KX8QjrLBCaXxom+sX6Z0xImGYj3
         XgDw==
X-Gm-Message-State: AOAM533paqiO6GET/0Sx9MaMqOULdcdOvzh9xAT3M8VlF+KESTjmEmor
        ftDq/Jk9En43MZZRqPJIw8Q=
X-Google-Smtp-Source: ABdhPJx4qLtDpVP7izmG4AXXdzs1owOFcXwAjg+a8QLL8SgRvXqqkN3J9H59Pp8SkoOvBS40FHYC1Q==
X-Received: by 2002:a17:903:22cb:b0:151:9f41:8738 with SMTP id y11-20020a17090322cb00b001519f418738mr13761065plg.46.1646676218374;
        Mon, 07 Mar 2022 10:03:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:7d6c:e74e:dfc4:f2bb])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a191900b001bf53bab69dsm25620pjg.35.2022.03.07.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:03:38 -0800 (PST)
Date:   Mon, 7 Mar 2022 10:03:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
Message-ID: <YiZI99yeijQe5Jaq@google.com>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <784ee7e0eec9ba520ebaaa27de2de810e2f6798a.1646266835.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> Create a technical document to explain cruft packs. It contains a brief
> overview of the problem, some background, details on the implementation,
> and a couple of alternative approaches not considered here.

Sorry for the very slow review!  I've mentioned a few times that this
overlaps in interesting ways with the gc mechanism described in
hash-function-transition.txt, so I'd like to compare and see how they
interact.

[...]
> --- /dev/null
> +++ b/Documentation/technical/cruft-packs.txt
> @@ -0,0 +1,97 @@
[...]
> +Unreachable objects aren't removed immediately, since doing so could race with
> +an incoming push which may reference an object which is about to be deleted.
> +Instead, those unreachable objects are stored as loose object and stay that way
> +until they are older than the expiration window, at which point they are removed
> +by linkgit:git-prune[1].
> +
> +Git must store these unreachable objects loose in order to keep track of their
> +per-object mtimes.

It's worth noting that this behavior is already racy.  That is because
when an unreachable object becomes newly reachable, we do not update
its mtime and the mtimes of every object reachable from it, so if it
then becomes transiently unreachable again then it can be wrongly
collected.

[...]
>                                these repositories often take up a large amount of
> +disk space, since we can only zlib compress them, but not store them in delta
> +chains.

Yes!  I'm happy we're making progress on this.

> +
> +== Cruft packs
> +
> +A cruft pack eliminates the need for storing unreachable objects in a loose
> +state by including the per-object mtimes in a separate file alongside a single
> +pack containing all loose objects.

Can this doc say a little about how "git prune" handles these files?
In particular, does a non cruft pack aware copy of Git (or JGit,
libgit2, etc) do the right thing or does it fight with this mechanism?
If the latter, do we have a repository extension (extensions.*) to
prevent that?

[...]
> +  3. Write the pack out, along with a `.mtimes` file that records the per-object
> +     timestamps.

As a point of comparison, the design in hash-function-transition uses
a single timestamp for the whole pack.  During read operations, objects
in a cruft pack are considered present; during writes, they are
considered _not present_ so that if we want to make a cruft object
newly present then we put a copy of it in a new pack.

Advantage of the mtimes file approach:
- less duplication of storage: a revived object is only stored once,
  in a cruft pack, and then the next gc can "graduate" it out of the
  cruft pack and shrink the cruft pack
- less affect on non-gc Git code: writes don't need to know that any
  cruft objects referenced need to be copied into a new pack

Advantages of the mtime per cruft pack approach:
- easy expiration: once a cruft pack has reached its expiration date,
  it can be deleted as a whole
- less I/O churn: a cruft pack stays as-is until combined into another
  cruft pack or deleted.  There is no frequently-modified mtimes file
  associated to it
- informs the storage layer about what is likely to be accessed: cruft
  packs can get filesystem attributes to put them in less-optimized
  storage since they are likely to be less frequently read

[...]
> +Notable alternatives to this design include:
> +
> +  - The location of the per-object mtime data, and
> +  - Storing unreachable objects in multiple cruft packs.
> +
> +On the location of mtime data, a new auxiliary file tied to the pack was chosen
> +to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
> +support for optional chunks of data, it may make sense to consolidate the
> +`.mtimes` format into the `.idx` itself.
> +
> +Storing unreachable objects among multiple cruft packs (e.g., creating a new
> +cruft pack during each repacking operation including only unreachable objects
> +which aren't already stored in an earlier cruft pack) is significantly more
> +complicated to construct, and so aren't pursued here. The obvious drawback to
> +the current implementation is that the entire cruft pack must be re-written from
> +scratch.

This doesn't mention the approach described in
hash-function-transition.txt (and that's already implemented and has
been in use for many years in JGit's DfsRepository).  Does that mean
you aren't aware of it?

Thanks,
Jonathan

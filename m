Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4DD20954
	for <e@80x24.org>; Wed, 22 Nov 2017 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdKVUI6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 15:08:58 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:38640 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdKVUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 15:08:57 -0500
Received: by mail-it0-f67.google.com with SMTP id n134so7767148itg.3
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1swWvBAxoPHAVKMhKity9PaBYKmvqS1DOIZteAZG23o=;
        b=cPr0EWDFYcmZwBM3r+s2qJCL0Dof/QNDRBI0Gte8ptCf2EvGaS2VilbhR0B9rh9C6A
         Jgd58UXw2erz+L+JYwNwGKQN6q0xrNjt6wZmw5WsOmfwCO0u7vYWPta9wq6ZJxk/fd1s
         uO3aWVxC1xDaG/Vl/DsMn4wjF8V3Eg0O87S6XC/yjSR3QupeBsgk1u7tq2sHC9e8FfJt
         bdQN41rWF2tIKpyss2wSfPGTo4zZVfk5bJ0GclaHqDQLqBZLsNVMtGNrlbi+wSKIkmIA
         1GqshPR/VQK78FHdtVivM5WYEX5n6lXYvDCbDm9Vh7Nrg05ZYyfPz2yD/f+bNFE12j6t
         fiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1swWvBAxoPHAVKMhKity9PaBYKmvqS1DOIZteAZG23o=;
        b=X6bztfzqONPLO4Js6MoMrM2Qkij5hdnsHOBz37RdkOQ4WDsGi+CYPZtIhlFUJLGMHL
         4buPWEFv21281luUMToNpnxsgmmQhJ51q+KVZKQ3eOZgVmakCag26LAgCAbTksD5NxVb
         gpYdLo4upuT6uE4HK0a1g7T5t14BoL189y3G45sSG+Q0gy/H5i6FUIdKwTSPayA9QuUG
         p3y1KGMNGWuaNuHKVeM8tGWHiCfrIUVf49PYwoS70WGpYZQKfaZ8b69wNGeU0Jqdazsu
         3jAXMcPDbm13Id2xPLtiNsKiZsNe5rZGMTQ1sMVXLf8/aXdrxzy2mMS1zqW7jmY5P0fe
         LRjQ==
X-Gm-Message-State: AJaThX6p4MdAyM6dGQ/cQHNdzaFvtY9IvWAhFcomcSeBvEt1js11A9Dq
        D8KItiV8rV+ddSGIUyCI9rXPFNS8
X-Google-Smtp-Source: AGs4zMbwuu0DrNSUojC3Wf9mRg3P2CjjZMglVCI0SFDqV/CX09/8UhQKupvwIN1J7YtbuK97x5/z3Q==
X-Received: by 10.36.101.147 with SMTP id u141mr7210385itb.62.1511381336628;
        Wed, 22 Nov 2017 12:08:56 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id p3sm2300808itc.39.2017.11.22.12.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 12:08:55 -0800 (PST)
Date:   Wed, 22 Nov 2017 12:08:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 5/6] rev-list: add list-objects filtering support
Message-ID: <20171122200853.GB11671@aiede.mtv.corp.google.com>
References: <20171121205852.15731-1-git@jeffhostetler.com>
 <20171121205852.15731-6-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121205852.15731-6-git@jeffhostetler.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:

> Teach rev-list to use the filtering provided by the
> traverse_commit_list_filtered() interface to omit
> unwanted objects from the result.
>
> Object filtering is only allowed when one of the "--objects*"
> options are used.

micronit: the line widths seem to be uneven in these commit messages,
which is a bit distracting when reading.

> When the "--filter-print-omitted" option is used, the omitted
> objects are printed at the end.  These are marked with a "~".
> This option can be combined with "--quiet" to get a list of
> just the omitted objects.

Neat.  Can you give a quick example?

Using --quiet for this feels a bit odd, since it previously meant
to print nothing to stdout.  I wonder if there's another way ---
e.g.

	--print-omitted=(yes|no|only)

If I wanted to list all objects matching a filter, even objects
that are not reachable from any ref, is there a way to do that?
(Just curious, trying to think about this interface.)

> Add t6112 test.

This part doesn't need to be in the commit message.  More generally,
anything I could more easily learn from the code or diffstat doesn't
need to be in the commit message: the commit message is about the
"why" more than the details of what in the code changed.

> In the future, we will introduce a "partial clone" mechanism
> wherein an object in a repo, obtained from a remote, may
> reference a missing object that can be dynamically fetched from
> that remote once needed.  This "partial clone" mechanism will
> have a way, sometimes slow, of determining if a missing link
> is one of the links expected to be produced by this mechanism.

Does this mean the <filter-spec>s will be part of the wire protocol?
I'll look more carefully at them below with that in mind.

> This patch introduces handling of missing objects to help
> debugging and development of the "partial clone" mechanism,
> and once the mechanism is implemented, for a power user to
> perform operations that are missing-object aware without
> incurring the cost of checking if a missing link is expected.

I had trouble understanding what this paragraph is about.  Can you
give an example?

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/git-rev-list.txt      |   4 +-
>  Documentation/rev-list-options.txt  |  36 ++++++
>  builtin/rev-list.c                  | 108 ++++++++++++++++-
>  t/t6112-rev-list-filters-objects.sh | 225 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 370 insertions(+), 3 deletions(-)
>  create mode 100755 t/t6112-rev-list-filters-objects.sh

Looks reasonably concise, good.

[...]
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -47,7 +47,9 @@ SYNOPSIS
>  	     [ --fixed-strings | -F ]
>  	     [ --date=<format>]
>  	     [ [ --objects | --objects-edge | --objects-edge-aggressive ]
> -	       [ --unpacked ] ]
> +	       [ --unpacked ]
> +	       [ --filter=<filter-spec> [ --filter-print-omitted ] ] ]

Does this mean --filter is only useful with --objects?  E.g. I can't
use it to filter commits?

> +	     [ --missing=<missing-action> ]

--missing=(error|allow-any|print) would be more informative and about
equally concise.

Since this is mainly for debugging, does it have a different
compatibility guarantee from other options?  Could it be named
accordingly to set expectations?

[...]
> +The form '--filter=blob:none' omits all blobs.

Sounds sensible.

> ++
> +The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
> +or units.  The value may be zero.

On second thought, doesn't blob:limit=0 mean blob:none is not needed?
Is it for future consistency with tree:none?

What units do [kmg] use? Are they GB, GiB, or one of the variants in
between?

> ++
> +The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
> +specification contained in the object (or the object that the expression
> +evaluates to) to omit blobs that would not be not required for a
> +sparse checkout on the requested refs.

This one makes me a little nervous because it would mean we're
planning on adding sparse-checkout specifications to the wire
protocol.  Maybe that's okay --- they're already part of the on-disk
format --- but it makes me nervous because the sparse-checkout format
is not so great, as I believe MS has already noticed.

What is an <oid-ish>?  Can it just say <blob>?  How would this one
work when passed over the wire?

> ++
> +The form '--filter=sparse:path=<path>' similarly uses a sparse-checkout
> +specification contained in <path>.

Is this <path> relative to the cwd of the caller, or is it within some
commit?

Sorry it took so long to send this feedback / these questions.
Hopefully it's useful nevertheless.

Thanks and hope that helps,
Jonathan

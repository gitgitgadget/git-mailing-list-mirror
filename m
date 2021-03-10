Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAECC43333
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 16:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715F364FC9
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 16:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhCJQ5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbhCJQ5V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 11:57:21 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31EC061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 08:57:20 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id u188so10804885pfu.23
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 08:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pm+MbyXlzDgUm+NLHFEkggvTafJzhe+e0QDyuKVNXTs=;
        b=BDNlM+xZwj6fS0TlxjXrmN/HEJpQ8+w7f7941nOl2TpAOcJCA2xxTxwb79wqXPJ6w8
         Ec1wN65RxWEWBer0vFBnHW8a5SXEFNV/DBVMJQzXPIUgNpzqMR4um6CPEg/6xLGR6Izm
         i3kgX5FBqAUZsGkXwa/9PwECdsz4fOgRV8hWYwtEuoWVtFUZfChEhNMKfSEb4ZQublEL
         VE/8D+eZjsnqgpFWCmxsd2zV1CQjns5REv64Qs6Ciu3BHtS6vpb/sF9EOm8BHg3Lnj5s
         dxGOFYRQndNk6Do5WMcuy005WC4VDXSJJwxJ2hCgTASXkpTKE8ASlv50+sDRUlOvstOR
         eoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pm+MbyXlzDgUm+NLHFEkggvTafJzhe+e0QDyuKVNXTs=;
        b=X2sMjAWqTs98gv1uMM/EbiF3wONaLjVmePo0RRc7wjP4Md+gP+vDNHrD+ryC56FMUr
         Dx/9c5acfbp40WI2dkPDeshQ8BrlHK2AmpwgLAiOhxNbCgGWU7IiUimlcEwDhkv8VFda
         mdwAWut2n3g8+RabfO11OjVNi/ciLGwbhmnMos371k5eahzFwwpgz65EldykU/DJQgmB
         PTVbJ0AueEW9d+NcUqRur3EqFYSP7yH3IGezoM5rB+TWzO3HCTo/MvagFqvERQ1gualZ
         9dL0VmYtO6y8xK8Qj32ldIf+2VyyG/sA9Unr4FuvWps+msAQf1esl9NH90JgHd6BegZe
         treA==
X-Gm-Message-State: AOAM530UDt8UCMImYnhSgWe8or/7pwjY14hCI4oZW1Bcv5dQmBDRAfAL
        Wq9BlxobVRx0zi/I0eAH+Q5GpKfr8u/NEpzmAZN7
X-Google-Smtp-Source: ABdhPJybgJaPXZja6atxGupZaTMqt1BtaU3DMolf90Ny6rzIVNe+v8fUARGKuASemKty8MUGecBqqxtjhPS7SuqUHIHt
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:cc0b:: with SMTP id
 b11mr4566131pju.216.1615395440400; Wed, 10 Mar 2021 08:57:20 -0800 (PST)
Date:   Wed, 10 Mar 2021 08:57:16 -0800
In-Reply-To: <xmqqwnugywax.fsf@gitster.c.googlers.com>
Message-Id: <20210310165716.2014235-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqwnugywax.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I was looking at the index_pack_args vs pass_header codepath in
> fetch-pack.c again after finishing the -rc2 stuff, and noticed
> something curious.
> 
> Before running the command to process in-stream packdata, we have
> this bit:
> 
> 	if (index_pack_args) {
> 		int i;
> 
> 		for (i = 0; i < cmd.args.nr; i++)
> 			strvec_push(index_pack_args, cmd.args.v[i]);
> 	}
> 
> where cmd.args is what the original code (before the "we need to
> prepare the index pack arguments for the offline HTTP transfer"
> logic was bolted onto this codepath), so it could of course have
> things like "--fix-thin", "--promisor", when we are processing an
> in-stream packfile that has sufficiently large number of objects and
> choose "index-pack" to process it.  None of them should be given to
> the "index-pack" that processes the offline packfile that is given
> via the packfile URI mechanism.

Thanks for continuing to take a look at this. My thinking is that all
packfiles (inline or through URI) should be processed in as similar a
manner as possible. Looking at the potential arguments passed to
index-pack:

 1.  --shallow-file (before "index-pack", that is, an argument passed to
     "git" itself and not the subcommand)
 2.  index-pack
 3.  --stdin
 4.  -v
 5.  --fix-thin
 6.  --keep
 7.  [--check-self-contained-and-connected is guarded by !index_pack_args
     so we won't be passing it]
 8.  --promisor
 9.  --pack_header
 10. --fsck_objects
 11. [--strict appears in an "else" block opposite index_pack_args so we
     won't be passing it]

You mentioned --fix-thin (5) and --promisor (8). Why do you think that
none of these should be given to the "index-pack" that processes the
packfiles given by URI? Perhaps it could be argued that these extra
packfiles don't need --fix-thin (but I would say that I think servers
should be allowed to serve thin packfiles through URI too), but I think
that --promisor is necessary (so that a server could, for example,
offload all trees and commits to a packfile in a CDN, and offload all
blobs to a separate packfile in a CDN).

Looking at this list, I think that all the arguments (except 9, which
has been fixed) are necessary (or at least useful) for indexing a
packfile given by URI.

> Also, because this loop copies everything in cmd.args, if our
> in-stream packdata is small, cmd.args.v[0] would be "unpack-objects",
> and we end up asking the command to explode the (presumably large
> enough to be worth pre-generating and serving via CDN) packfile that
> is given via the packfile URI mechanism.

I specifically guard against this through the "if (do_keep ||
args->from_promisor || index_pack_args || fsck_objects) {" line (which
is a complicated line, unfortunately).

> What I think I am seeing in the code is that there are many things
> other than "pass_header" that fundamentally cannot be reused between
> the processing of the in-stream packdata and the offline packfile
> given by the packfile URI (e.g. the in-stream one may want to use
> "unpack-objects" to avoid accumulating too many tiny packs, so there
> is nothing to be shared with "index-pack" that will always be used
> for the offline one), and any attempt to "reuse" cmd.args while
> "filtering out" inappropriate bits is fragile and unfruitful.
>
> Instead, I think we should not touch index_pack in the earlier part
> of the function at all (both reading, writing, or even checking for
> NULL-ness), and use the "if (index_pack_args)" block we already have
> (i.e. the one before we call start_command() to process the
> in-stream packdata) to decide what the command line to process the
> offline pack should look like.  That way, we won't ever risk such a
> confusion like running "unpack-objects" instead of "index-pack" (but
> we can choose to do so deliberately, of course---the important point
> is to recognise that the in-stream pack and the offline one are
> independant and we should decide how to cook them separately).

We could do that, although I'm concerned that we would be repeating
logic a lot (deciding whether or not to pass an argument). One other
approach is for each "strvec.push?(&cmd.args" to also have another line
that pushes to index_pack_args if it's relevant. But as I said earlier,
I think that all or nearly all arguments will be relevant to both.

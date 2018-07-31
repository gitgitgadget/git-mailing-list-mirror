Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6460B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbeHABGa (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 21:06:30 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:50988 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732412AbeHABGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 21:06:30 -0400
Received: by mail-yw0-f201.google.com with SMTP id 135-v6so10348701ywr.17
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NapN07zz4HUIaVUc40YCWsmDGf3aS7nHD5IMCwC/S6I=;
        b=nz5PN8eRuRsMkHyWeWjFzcktSe2bnFGc3vKsZrP73Szt/W/ofDxeCk6yPmwQgCxf+Y
         8jOnM2rF3EX5fiBVos0OzcVDp9J5b1BPSNSfe1va4c3qQ1JpnP9fU03bDX69W/9nS2qe
         6/SaCvPlmRmPstxiq//qJKzngQVcwiaA08Cx1ILLixGd39zafgyqIngcGf9Ks3nLZKAo
         k1G75P2e7qz1MMG1RmUyDuspfoYItiRq2UD3ETpJ51RjmkBXYAg3N5i4RNsBaDj8j2Uu
         MoJuyDAFjANPLLOgNlZNsN1oC25mfcBrpUVsGNdX4Q3XFWeISHqjDAdnCfxjp6UQkaQk
         y1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NapN07zz4HUIaVUc40YCWsmDGf3aS7nHD5IMCwC/S6I=;
        b=HN4lpZsq+FYQXTj3GQy30Tn3ml5rTRIx0MO6b/rYQcC97zEjnb30pmh56TOJ/viBZ3
         aYZgiyeEfUlnSsa3PCzx2gwRyODT7lwnIJbIo3CcWsYBS0bz/ccJpdRIP4a6bz8dzjRM
         HHeoSkrOSrBqhZwUPGHgwuLnPKCCRXehDC9jCs9ZgYLm3YyLEbHxLRM+G4Fxy4pKg1E3
         9jE0OB/BrR/0NbbdGjsb9bEJjq2GMv233+w4rB1kdqJDbhSXv0PVZWqFGu3sLpN3BhOd
         r4K4ZqdpPB/PXJ6eSoAHpp6ZukmYSEccIHQ/B2PVWjaf7X+er9CYlNq7/FL/UBOZSOA4
         suEg==
X-Gm-Message-State: AOUpUlErNudpda1mBkLGfIqJrMsN3ROYShpujoPzuiG4Yhpc4O5wQZfe
        xOnUfKHRC1uok5eCA8HvsJSs1A2puzVXu/llE5Bt
X-Google-Smtp-Source: AAOMgpdCJ8hH2alullSK8W1jKx6hcJCY7b9M0UwVERsXjNAHRO8ajcTI/LnCm6wwjBV1LwWLqMXV15hhsK+V2nYLpQCK
X-Received: by 2002:a81:7097:: with SMTP id l145-v6mr6696436ywc.33.1533079430718;
 Tue, 31 Jul 2018 16:23:50 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:23:43 -0700
In-Reply-To: <20180731192415.GC3372@sigill.intra.peff.net>
Message-Id: <20180731232343.184463-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180731192415.GC3372@sigill.intra.peff.net>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3.dirty
Subject: Re: [PATCH] transport: report refs only if transport does
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, Jul 30, 2018 at 03:56:01PM -0700, Jonathan Tan wrote:
> 
> > Commit 989b8c4452 ("fetch-pack: put shallow info in output parameter",
> > 2018-06-28) allows transports to report the refs that they have fetched
> > in a new out-parameter "fetched_refs". If they do so,
> > transport_fetch_refs() makes this information available to its caller.
> > 
> > Because transport_fetch_refs() filters the refs sent to the transport,
> > it cannot just report the transport's result directly, but first needs
> > to readd the excluded refs, pretending that they are fetched. However,
> > this results in a wrong result if the transport did not report the refs
> > that they have fetched in "fetched_refs" - the excluded refs would be
> > added and reported, presenting an incomplete picture to the caller.
> 
> This part leaves me confused. If we are not fetching them, then why do
> we need to pretend that they are fetched?

The short answer is that we need:
 (1) the complete list of refs that was passed to
     transport_fetch_refs(),
 (2) with shallow information (REF_STATUS_REJECT_SHALLOW set if
     relevant), and
 (3) with updated OIDs if ref-in-want was used.

The fetched_refs out param already fulfils (2) and (3), and this patch
makes it fulfil (1). As for calling them fetched_refs, perhaps that is a
misnomer, but they do appear in FETCH_HEAD even though they are not
truly fetched.

Which raises the question...if completeness is so important, why not
reuse the input list of refs and document that transport_fetch_refs()
can mutate the input list? You ask the same question below, so I'll put
the answer after quoting your paragraph.

> I think I am showing my lack of understanding about the reason for this
> whole "return the fetched refs" scheme from 989b8c4452, and probably
> reading the rest of that series would make it more clear. But from the
> perspective of somebody digging into history and finding just this
> commit, it probably needs to lay out a little more of the reasoning.

I think it's because 989b8c4452 is based on my earlier work [1] which
also had a fetched_refs out param. Its main reason is to enable the
invoker of transport_fetch_refs() to specify ref patterns (as you can
see in a later commit in the same patch set [2]) - and if we specify
patterns, the invoker of transport_fetch_refs() needs the resulting refs
(which are provided through fetched_refs).

In the version that made it to master, however, there was some debate
about whether ref patterns need to be allowed. In the end, ref patterns
were not allowed [3], but the fetched_refs out param was still left in.

I think that reverting the API might work, but am on the fence about it.
It would reduce the number of questions about the code (and would
probably automatically fix the issue that I was fixing in the first
place), but if we were to revert the API and then decide that we do want
ref patterns in "want-ref" (or expand transport_fetch_refs in some
similar way), we would need to revert our revert, causing code churn.

[1] https://public-inbox.org/git/86a128c5fb710a41791e7183207c4d64889f9307.1485381677.git.jonathantanmy@google.com/
[2] https://public-inbox.org/git/eef2b77d88df0db08e4a1505b06e0af2d40143d5.1485381677.git.jonathantanmy@google.com/
[3] https://public-inbox.org/git/20180620213235.10952-1-bmwill@google.com/

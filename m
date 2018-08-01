Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024521F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbeHAX0Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 19:26:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43269 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbeHAX0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 19:26:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so25425plv.10
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+cgz6HCpN4rOtc9w4SUsO2zkUmuhi6/DsoUGHCPheA=;
        b=ZjVV2f/ih0h+ty97wARHFw/gIWAe3vV2QbFo7zy4vTBLwtY2LVDS/B7AJ3KfEH6Sqv
         Gov5RHuajmIETsdH6LTTBZGeizYVLjAxr2gHqO13VIft2+xg99qYYA/amm3J5MVuQ6f9
         lDQqtpFYDh3L7MuhMQbZ9mEinGncM8Vl3dn26/m+DMIy+GJlLZsgQ5lzH9//AFFAYMrR
         AxcWSApLCRYzLAv1ZlQUhYnISjpz3KM7yKnDK31YTMl8hlfEPvi9piNgRP6eLPHtQWMO
         hEHonvl4k217q9TMaM03xWDn1GsY6mSDODsl4GhJxKc0SLeloGZ+8iyrIZGbjH/Zpq7U
         WvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+cgz6HCpN4rOtc9w4SUsO2zkUmuhi6/DsoUGHCPheA=;
        b=BX4b6yv2PAPz9m65lxht04havRv2rJsVLlBz5mb9FHxQBpD9lGcz6uIls08yn4gdr0
         HRNzJxjji6ZvQkGNRS8EVqn+2CTCBymfhLP2UhsvoFoJFuOym+1SweKSDvzAfJKr3Ce2
         l/xRx5Nsn76svD9sjBH7KdKuBpP6Q1PXtPL7yjWc/8itN2Rqf9NuVukRERBdB9AD2jib
         wx74CrSZCVRjgSUzWsIETUDoSeznHFacQrYEEQ57CAgTHDK4EP5xCPjS2lCTMf7XBQdQ
         g+LMVABv2ckEohFm1w6aO5QS8eFxdJF7fzfjiSk441b9hqXT3DHfwdMefOHIjxRfm/FF
         IoAw==
X-Gm-Message-State: AOUpUlG1HgWxMzPmzh3QnZN0IjeZ77T+iZf3SPkRjtt7AMw9IoMGnkPx
        6eEt+DI+2/EnRKWshCFhPhvgGg==
X-Google-Smtp-Source: AAOMgpfhOyBegMLpOgNzL1cIB6hWh4ZhNvqFcaPavQSKbBxm+ak7GgKA5gKSAr2yI2xS25es1x/4Lg==
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr54756plo.45.1533159508734;
        Wed, 01 Aug 2018 14:38:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q78-v6sm32320pfi.185.2018.08.01.14.38.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:38:27 -0700 (PDT)
Date:   Wed, 1 Aug 2018 14:38:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH] fetch-pack: unify ref in and out param
Message-ID: <20180801213826.GA66237@google.com>
References: <20180729121900.GA16770@sigill.intra.peff.net>
 <20180801201320.201133-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801201320.201133-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01, Jonathan Tan wrote:
> When a user fetches:
>  - at least one up-to-date ref and at least one non-up-to-date ref,
>  - using HTTP with protocol v0 (or something else that uses the fetch
>    command of a remote helper)
> some refs might not be updated after the fetch.
> 
> This bug was introduced in commit 989b8c4452 ("fetch-pack: put shallow
> info in output parameter", 2018-06-28) which allowed transports to
> report the refs that they have fetched in a new out-parameter
> "fetched_refs". If they do so, transport_fetch_refs() makes this
> information available to its caller.
> 
> Users of "fetched_refs" rely on the following 3 properties:
>  (1) it is the complete list of refs that was passed to
>      transport_fetch_refs(),
>  (2) it has shallow information (REF_STATUS_REJECT_SHALLOW set if
>      relevant), and
>  (3) it has updated OIDs if ref-in-want was used (introduced after
>      989b8c4452).
> 
> In an effort to satisfy (1), whenever transport_fetch_refs()
> filters the refs sent to the transport, it re-adds the filtered refs to
> whatever the transport supplies before returning it to the user.
> However, the implementation in 989b8c4452 unconditionally re-adds the
> filtered refs without checking if the transport refrained from reporting
> anything in "fetched_refs" (which it is allowed to do), resulting in an
> incomplete list, no longer satisfying (1).
> 
> An earlier effort to resolve this [1] solved the issue by readding the
> filtered refs only if the transport did not refrain from reporting in
> "fetched_refs", but after further discussion, it seems that the better
> solution is to revert the API change that introduced "fetched_refs".
> This API change was first suggested as part of a ref-in-want
> implementation that allowed for ref patterns and, thus, there could be
> drastic differences between the input refs and the refs actually fetched
> [2]; we eventually decided to only allow exact ref names, but this API
> change remained even though its necessity was decreased.
> 
> Therefore, revert this API change by reverting commit 989b8c4452, and
> make receive_wanted_refs() update the OIDs in the sought array (like how
> update_shallow() updates shallow information in the sought array)
> instead. A test is also included to show that the user-visible bug
> discussed at the beginning of this commit message no longer exists.
> 
> [1] https://public-inbox.org/git/20180801171806.GA122458@google.com/
> [2] https://public-inbox.org/git/86a128c5fb710a41791e7183207c4d64889f9307.1485381677.git.jonathantanmy@google.com/
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I now think that it's better to revert the API change introducing
> "fetched_refs" (or as Peff describes it, "this whole 'return the fetched
> refs' scheme from 989b8c4452"), so here is a patch doing so. I hope to
> have covered all of Peff's and Junio's questions in the commit message.
> 
> As for Brandon's question:
> 
> > I haven't thought too much about what we would need to do in the event
> > we add patterns to ref-in-want, but couldn't we possible mutate the
> > input list again in this case and just simply add the resulting refs to
> > the input list?
> 
> If we support ref patterns, we would need to support deletion of refs,
> not just addition (because a ref might have existed in the initial ref
> advertisement, but not when the packfile is delivered). But it should
> be possible to add a flag stating "don't use this" to the ref, and
> document that transport_fetch_refs() can append additional refs to the
> tail of the input list. Upon hindsight, maybe this should have been the
> original API change instead of the "fetched_refs" mechanism.

Thanks for getting this out, it looks good to me.  If we end up adding
patterns to ref-in-want then we can explore what changes would need to
be made then, I expect we may need to do a bit more work on the whole
fetching stack to get what we'd want in that case (because we would want
to avoid this issue again).

-- 
Brandon Williams

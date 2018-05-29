Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF3841F42D
	for <e@80x24.org>; Tue, 29 May 2018 16:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936850AbeE2Q6m (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 12:58:42 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35974 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965068AbeE2Q6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 12:58:41 -0400
Received: by mail-yw0-f195.google.com with SMTP id v68-v6so5039730ywd.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kl+NWZQpX1I485rJcaV4G39/oSC6B8pm/3N+u+SZxm8=;
        b=SPzb86hSYf4w1cMYQHKnrXcKRHzyubAmPsfd0LNA8LJLl8FVTUgsm1c1oUx//7L5rQ
         mS+u/G+ZV/hi8G7QWVGSYFQ96V66cY6zhKGrvu/ONKpR6PR0BHTVB9YPviXQFHY4MxYw
         goH/TDiQ0rtNenhv5cmMZvR50Ab9orTOuIHx6Pv8KYRRJVoJhnLx9Zon3kNrNJ2/Bd4k
         QG5aXXDGIzFQivQelEA5hAiCKRoA5IpB0V2aDwk/1aofwwLp7KldcTruc9nfQR8YSF7w
         YoFLAqYhQyzcYlnrjUqfJYIowO7PySb+Z2DJoENbw4dplnbj8/5z3aBMIIpgEi3/4B8L
         1PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kl+NWZQpX1I485rJcaV4G39/oSC6B8pm/3N+u+SZxm8=;
        b=aQWszQpf7hFZiupQSFsIsOgM6aznDj80Bd92pR0KvJ4y9sYPrrMrT4+MtgSuMtllyb
         uRjM3v9KH+YTezXrICqIvek6RxzERiyP0jL4+1dzVUR32kSuBxM/4XLKmOj8TkaiN4ds
         mqN/2qQxHe33P+rHrvmJTjnFGm+wr2rouIt0SJhRTVNZUJGDa4WgeF96BoMNN60tQD9P
         A04Vax2sdo7Ab4FEcMVScJpnItEjJxHfmXw5CyK9XQlUy1ZRw+jANlvAaEEHh6i/VPLB
         P6l4AedehkGnE69v8sXhN+W/CTzkbKG+7zAvtSZDdBExIsT0TswQk6wq6jKFmBMpuWkp
         hXGA==
X-Gm-Message-State: ALKqPwdzdQDgSpddhtDjQJjcgGCqnUUtcqzIsvKkuNuVbTX/rI5qwLLG
        eVDznMMjRFbCpd6F+vGMC8wrmg==
X-Google-Smtp-Source: ADUXVKIPG8DyFjrqviv0KnBP25JWtB7KE1AoJ7nEUEdnYRdoKA4zTE4Eu7AKHljs8vvqvm1NfKsHTw==
X-Received: by 2002:a0d:e9c4:: with SMTP id s187-v6mr9639462ywe.177.1527613120841;
        Tue, 29 May 2018 09:58:40 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([100.96.193.68])
        by smtp.gmail.com with ESMTPSA id i124-v6sm13679097ywd.45.2018.05.29.09.58.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 09:58:39 -0700 (PDT)
Date:   Tue, 29 May 2018 09:58:37 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
Message-Id: <20180529095837.fe06e9ac5dd1176060fff2ad@google.com>
In-Reply-To: <xmqqwovvujfx.fsf@gitster-ct.c.googlers.com>
References: <20180521204340.260572-1-jonathantanmy@google.com>
        <xmqqwovvujfx.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 23 May 2018 12:42:10 +0900
Junio C Hamano <gitster@pobox.com> wrote:

> Somehow this feels more like a WIP than RFC, primarily for two
> reasons.  It was unclear what "edge" computation is trying to do; it
> seems way under-explained, especially the part that takes min-max
> while. merging two candidates.

Agreed that WIP would be a good designation. I'll make sure that the
merging is better explained in the next version.

> It also was unclear if this should be organized as a "take it or
> leave it" patch like this one, or eventually should be split into
> multiple steps when it gets polished enough to be considered for
> application, the early ones introducing a separate negotiator module
> without changing the common ancestor discovery algorithm at all,
> with later steps refining that negotiator and add more efficient
> common ancestor discovery process.

As for the question of one or (at least) two patches, right now I'm
working on a way to simplify what I have (probably to just implementing
the "skip exponentially" part you describe in [1]). I think that it will
be simple enough to put in one patch, but we can decide
once I've completed that patch.

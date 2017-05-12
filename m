Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7829C201A4
	for <e@80x24.org>; Fri, 12 May 2017 05:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbdELF1r (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 01:27:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36280 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdELF1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 01:27:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so4637808pfb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 22:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=drTcpQixr323zMxMcMfQaNffKIjqDqYddC5cUbhqmvE=;
        b=ncmdKEdq0Uo/98hslnLz1Obv1jXFXOx+yW/R3boXsPiHctGfAuBJchINNjwHYo+z0W
         eSUKy3vvf8FDMDsB0zgUgDX/+fwD+gRyAFQHCrOxhv18g8njaVBtYNz0XPYl2G/DQH7W
         h6ZC+6SgNqRaNfNOC8S8LXDUOv1/cEXseSXX32pDqzfufpfASkU2WN0QtUTggkThjqSM
         c8IaJz2zSmlVle7PRUMcsBUSld/6IKPYgrIeqDsY9Yv0idGah5PfmBtAcKXRIdrrx0/4
         hxSl+HPACbDCfvzFMF9BgJ9DNe+fe5hv8UV4hG50JUtLx6L3tu0j/1/jL4Q4GRKFKLho
         J2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=drTcpQixr323zMxMcMfQaNffKIjqDqYddC5cUbhqmvE=;
        b=XPd9jOkRzx42nnSwZRO8rLr0JfgYqTVZNdodiufrn6SK9vHTRoAcUq9eqXLDuwfevd
         lcBLk51pOI0YSq8M3O6VWgfKZnHoCnfUMoRwOMcqirCmfQmjInxFiV+QHFp6irlTOaRv
         dbK8a6D+KpUQq4QquFzlsGGilaXz7elnsdXzAW/hFxSxAFQFtKAE2fW/EZrsDkxv9MaF
         Rcj0qlR3fMeryghs7pDfkOeAX9f7XUZhzl483OAdwyk073tjDe6ftcrndxWda+/0Of8N
         s2pmWS1K9WQxegJ2kGnFWRmB8i3gFiXoBsCgFrHe3JXwK774lkiyV9w3aJTk9uii7IZc
         v4jQ==
X-Gm-Message-State: AODbwcB8grkJFA5UrUKQ3xVORaU5dDRgKq2n1LGl+jeYMkuXATXiPvq+
        oqGivIJd0mpJUg==
X-Received: by 10.84.254.70 with SMTP id a6mr3089878pln.64.1494566866366;
        Thu, 11 May 2017 22:27:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id b126sm3622880pga.3.2017.05.11.22.27.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 22:27:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [PATCH v2 0/6] convert pathspec.c to take an index parameter
References: <20170509191805.176266-1-bmwill@google.com>
        <20170511220427.192627-1-bmwill@google.com>
Date:   Fri, 12 May 2017 14:27:45 +0900
In-Reply-To: <20170511220427.192627-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 11 May 2017 15:04:21 -0700")
Message-ID: <xmqqh90q7ige.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> The main difference in v2 is that instead of piping through an index_state
> struct into parse_pathspec, I ripped out the logic that needed to access the
> index and either removed it completely if it wasn't needed anymore (stripping
> submodule slash) or factored it out into its own function which can be called
> after initializing a pathspec object (dying if a path descends into a
> submodule).
>
> Brandon Williams (6):
>   pathspec: provide a more descriptive die message
>   submodule: add die_in_unpopulated_submodule function
>   pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
>   ls-files: prevent prune_cache from overeagerly pruning submodules
>   pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
>   pathspec: convert find_pathspecs_matching_against_index to take an
>     index

This was (perhaps surprisingly) quite a pleasant read, even compared
to the other approach ;-).

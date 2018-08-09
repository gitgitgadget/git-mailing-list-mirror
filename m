Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065D11F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeHJA1A (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:27:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38264 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbeHJA07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:26:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so76982wmi.3
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mZ5XghToA7UrYtXnCSExLoCHJWIRDSMPnrUHFGCI4Yk=;
        b=kFb9ZQHXqherpxOVfoERTMKiEscQ5jyRBcYOBnK9jB6/JgRFPSjV16Sh/dJai1W/01
         ofQvKFYMnhC7B0Cfs9ovIViBlFy9hULrEVgvO0DY7snqOU5S1AAFtugweiq80q3zgZCS
         D3NqGhhL5oyOg+tB8RwilDhxxzFsWbGV+HlBx3UOz5crW+xwN9S/zMXkrZvlxHsiX0Ha
         F+j/w0G2tJF4WDeQ1TCiZyadtftLEnynjGTWLm4xykOIjWPmgWaiOuzw7nTBINaGK3zQ
         zSZO0PdHXYsZ+mGHVr1TfZOaXIgywHLjnJRXIJFEAYPU0Lw8w1Q077iVxM5k1NHPJRNA
         684w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mZ5XghToA7UrYtXnCSExLoCHJWIRDSMPnrUHFGCI4Yk=;
        b=DKZydD4vpbOpAfz0nV1QDRoOXvObjN70/7SikTLDSXX0h0IY4mNSd21FQEAPEqBiEc
         4dRsgiYZm7nr9UOkrw+aqtOZoHGbtUwE9OuQ9Q3bTGZdjfsLVqjbEMydkEWEg9QU81EH
         CESJ/Y9G2xJHZbrneFJvB6awC5xXL2GvEKVuZFN5h6czgrlBfCgDKW0GUdcIHkXLiH+Z
         CwzA9H2gPmVAiA7Fjl2Pe7HqDfQj9evaod/UwoVFOL4cG/c9DGIeC1V1u9d96Cvy+rjU
         Qej7HsC+MA7zMM4dJ7SEpe7PenU4ZTfNbpfBTA1PEvRPftSM0wwhnRRwOW+d+7Ohfd7p
         0QgA==
X-Gm-Message-State: AOUpUlH6PmNZ2/aiPTdhm9N9N0FWtYWrCZAx/FtdqkLgz5J+RQ4q6zBj
        zcVSCJH6uUMrQgZUwGxH1Es=
X-Google-Smtp-Source: AA+uWPzyIESOMx7dTG2yblBe5uUvgJBqxnVo7SHsA3C/7JYN3N9FKRPHIKefTQs+C1D35PL7lRYjeg==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr59790wmd.92.1533852009432;
        Thu, 09 Aug 2018 15:00:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a20-v6sm5216935wmg.23.2018.08.09.15.00.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 15:00:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net
Subject: Re: [PATCH 04/10] submodule.c: convert submodule_move_head new argument to object id
References: <20180808221752.195419-1-sbeller@google.com>
        <20180808221752.195419-5-sbeller@google.com>
Date:   Thu, 09 Aug 2018 15:00:08 -0700
In-Reply-To: <20180808221752.195419-5-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Aug 2018 15:17:46 -0700")
Message-ID: <xmqqk1oz9p5j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> All callers use oid_to_hex to convert the desired oid to a string before
> calling submodule_move_head. Defer the conversion to the
> submodule_move_head as it will turn out to be useful in a bit.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  entry.c        |  6 +++---
>  submodule.c    | 12 ++++++------
>  submodule.h    |  2 +-
>  unpack-trees.c | 13 +++++--------
>  4 files changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index b5d1d3cf231..4b34dfd30df 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -358,7 +358,7 @@ static int write_entry(struct cache_entry *ce,
>  		sub = submodule_from_ce(ce);
>  		if (sub)
>  			return submodule_move_head(ce->name,
> -				NULL, oid_to_hex(&ce->oid),
> +				NULL, &ce->oid,
>  				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
>  		break;

Nice.


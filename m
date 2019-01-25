Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88AEA1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 19:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfAYT3U (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 14:29:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34300 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYT3U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 14:29:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so5496429wmd.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ymFx2kHazadmZE8BU71gcALjzhxssqCbeAOeu1Msano=;
        b=P9PjTjYpke0thv8YNIo7NIWFC17bkpfaR01PnZPDDnks1XJqoo4N+OrlU1hOLGwsZ0
         ZTQQz0vn6Pw/bFLUMUUzvSuMRrENVHYg2n6Q7QnnZrNnthSeT2QconWd1yQR/PDxM+bq
         Zx1TBN6y6rUTZulCwSRktlUv0/sT5fixOBtc13/ai6VtUTTTl0T7jwl4F1yp1H2YQ8zG
         cYU1GmEELhuNAZPs3QoJxttsbr4hL0qUi3SygP9LD/SLgOUB1spad4eDP3vBzAAW35UA
         Ps8ABIL13FzPpNL/HbWVTsAmPhdN6wW4U5TV3mzx4+PpQHjoiRLfSehtF1Tw86yA+UkU
         Q1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ymFx2kHazadmZE8BU71gcALjzhxssqCbeAOeu1Msano=;
        b=AONrjywalKuHW96qNAOLmegf+MPDxAKpi+Dy6OdBctPDU5zsy3TQYfQGBad4ulAB4Q
         weoOk5w3rBG9tOekRJcPegNcaaVEdFwEGTSKJawex5EpLYwW9PFScpPKhjHaLyVMIn/W
         n5BN0clUGimMiwqeWCgguDHSl78i6JvphyQyy3qYL5fLUTHF+zgmDRvhQMDe8Df2OgeP
         8TFZx19I9OxKFV+cRmn4GChY2L3Arqp7rDe9+YRDXmuwaNb4bQu4wFLOOu1v3VnaJJ9I
         URPCvR6JKrIQ5OPOWne1PqkGOQNbCQuc2mtCe2tD0K2BUll5TSbR7/MB3Bf0jewM4klb
         VJVg==
X-Gm-Message-State: AJcUukeu3zhccIlGIXl+QksbLzs/uF/DAHUXkLa996G9/w6ozRjaXrdx
        sjiHkGnGMnYbqU3EFg9vT4k4Izzr
X-Google-Smtp-Source: ALg8bN61A0eb7k4wgjGXdp/dPm0AXDbdRBRry38rloUVAOMgG/uX0LIpKIwsC/Z4oHqm7t50zQt20Q==
X-Received: by 2002:a7b:c04e:: with SMTP id u14mr8171864wmc.113.1548444557948;
        Fri, 25 Jan 2019 11:29:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m21sm46016034wmi.43.2019.01.25.11.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 11:29:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for merges with renames
References: <20190124164654.1923-1-newren@gmail.com>
Date:   Fri, 25 Jan 2019 11:29:16 -0800
In-Reply-To: <20190124164654.1923-1-newren@gmail.com> (Elijah Newren's message
        of "Thu, 24 Jan 2019 08:46:54 -0800")
Message-ID: <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The raw diff format for merges with -c or --cc will only list one
> filename, even if rename detection is active and a rename was detected
> for the given path.  Examples:
>
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
>
> This doesn't let us know what the original name of bar.sh was in the
> first parent, and doesn't let us know what either of the original
> names of phooey.c were in either of the parents.  In contrast, for
> non-merge commits, raw format does provide original filenames (and a
> rename score to boot).  In order to also provide original filenames
> for merge commits, add a --combined-with-paths option (which is only
> useful in conjunction with -c, --raw, and -M and thus implies all
> those options) so that we can print tab-separated filenames when
> renames are involved.  This transforms the above output to:
>
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c

I admit that I designed the original without too much thought.
Perhaps we should have avoided discarding info, but it is way too
late to fix with a default behaviour change.

I am not sure if it is easy for consumers to guess which name on the
output line corresponds to which input tree from the status letter,
though.  Would it make it easier for consumers if this showed names
in all input trees if any of them is different from the name in the
resulting tree, I wonder?  Even in that case, the consumer must know
some rule like "if R or C appears in the status column, then we have
N preimage names plus the name in the result for N-way merge", so it
may not be too bad to force them to know "for each of R or C in the
status column, the name in the preimage tree is emitted, and the
last name is the name in the result".  I dunno.

> +For `-c` and `--cc`, only the destination or final path is shown even
> +if the file was renamed on any side of history.  With
> +`--combined-with-paths`, the number of paths printed will be one more
> +than the number of 'R' characters in the concatenated status.  For
> +each 'R' in the concatenated status characters, the original pathname
> +on that side of history will be shown, and the final path shown on the
> +line will be the path used in the merge.

Is it safe for readers to pay attention to only 'R'?  Will it stay
forever that way?  My immediate worry is 'C', but there might be
other cases that original and result have different names.

> +--combined-with-paths::
> +	This flag is similar to -c, but modifies the raw output format for
> +	merges to also show the original paths when renames are found.
> +	Implies	-c, -M, and --raw.

So, --cc -p is not allowed to use this?  I was wondering if we want
to have a separate "even though traditionally we did not show
preimage names in combined output, this option tells Git to do so,
regardless of output format used, as long as 'combine-diff' is in
effect".

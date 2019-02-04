Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97C41F453
	for <e@80x24.org>; Mon,  4 Feb 2019 21:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfBDVUf (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:20:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBDVUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:20:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so1449575wmf.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JqYCwAEAyMkcmTvTEiAGgeolGAxRV4jYqzidCrlN6Ew=;
        b=Q4RhXpu8nu9PqIgpxixlXsBqDF4KTAGVOO4mPUPtB1i9wZenGF5/WcU3aATh3GDr30
         DrfHyORjC27+tsS6xW4XX6WdvLA7OsdyJyan6hOwxWGk5MyqdSTuFh9X6M9/ZgPYJ/vG
         yFEhK/r1L7UmYftGgZOQHrLaVqWonxWZmLUCgOoU7OxLVZOVK4wsDTsl6m0kEU1Frrii
         VbMReTPpStlXihHq/UpUbRFeICNMDzEH+ffOzfZ1LIqtt6NFUq0JpG5hJbfxg9bJ8o1z
         jS6jf9yeYrbw0QfbIknHsiZyzN4O+7WYrgf1SV424m2bMiTZSBU65aebyzetAQpV071V
         P6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JqYCwAEAyMkcmTvTEiAGgeolGAxRV4jYqzidCrlN6Ew=;
        b=VkveKVpd6JMS781EmneFxl8BrX6TmA8NBe5etkkScs3IehJFZIY65H/GyjXciilQfk
         5vRUiU3RNR7DBUAKmN5cCb6R90BxLTS0jS2tF9sGTYGIrxTb65UBRZiU0lg6m2q3sWQs
         fDaGTqql3YTDGaPM+/B+lo0smYRPAahPrWhAd3OCGyc4v1z3GthTbIznkTuPrYQHV6NS
         lOeppAs1Id2tfvRoVH/SlC7Afx67CmIGFXdkloPHtoXHTgxvHPgWSYU+zKWY0vtWm3/k
         YMl4pUNWmlmBGK6tYN4EkjZNq04tvr4tnvq/+ZTKSp/OATwTyZpZ2ltqEteAA2TqmrY2
         aGKg==
X-Gm-Message-State: AHQUAuaiexXMOVeyTghm5crfHqBJsV5wdh+W/8EVVV8DVSVYXirFlc2G
        z3I8BDX0Ff2xQWFz8SWUqa7m7G0U
X-Google-Smtp-Source: AHgI3IZGshfpQKP635AjQSgvKQd4IOqCrfROoAOQ9NGJoTgCqJHDsaMgJZ6wiSOopHmo8bCHoxZtZA==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr926107wmj.145.1549315233126;
        Mon, 04 Feb 2019 13:20:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k4sm7660364wrp.8.2019.02.04.13.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:20:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
References: <20190126221811.20241-1-newren@gmail.com>
        <20190204200754.16413-1-newren@gmail.com>
Date:   Mon, 04 Feb 2019 13:20:31 -0800
In-Reply-To: <20190204200754.16413-1-newren@gmail.com> (Elijah Newren's
        message of "Mon, 4 Feb 2019 12:07:54 -0800")
Message-ID: <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

There is one place that says combined-all-paths, and everywhere else
it says combined-all-names.  The former is probably techincally more
correct, I think ;-)

> The combined diff format for merges will only list one filename, even if
> rename or copy detection is active.  For example, with raw format one
> might see:
>
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	describe.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
>
> This doesn't let us know what the original name of bar.sh was in the
> first parent, and doesn't let us know what either of the original names
> of phooey.c were in either of the parents.  In contrast, for non-merge
> commits, raw format does provide original filenames (and a rename score
> to boot).  In order to also provide original filenames for merge
> commits, add a --combined-all-names option (which must be used with
> either -c or --cc, and is likely only useful with rename or copy
> detection active) so that we can print tab-separated filenames when
> renames are involved.  This transforms the above output to:
>
>   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c	desc.c	desc.c
>   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	foo.sh	bar.sh	bar.sh
>   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	fooey.c	fuey.c	phooey.c
>
> Further, in patch format, this changes the from/to headers so that
> instead of just having one "from" header, we get one for each parent.
> For example, instead of having
>
>   --- a/phooey.c
>   +++ b/phooey.c
>
> we would see
>
>   --- a/fooey.c
>   --- a/fuey.c
>   +++ b/phooey.c

Do we have the three "rename from fooey.c", "rename from fuey.c" and
"rename to "phooey.c" extended headers, too?  That's what I meant in
my response, but I do like what I see in the above example ;-)

> -. single path, only for "dst"
> +. tab-separated pathname(s) of the file
>  
> -Example:
> +For `-c` and `--cc`, only the destination or final path is shown even
> +if the file was renamed on any side of history.  With
> +`--combined-all-names`, the name of the path in each parent is shown
> +followed by the name of the path in the merge commit.
> +
> +Examples for `-c` and `-cc` without `--combined-all-names`:
> +------------------------------------------------
> +::100644 100644 100644 fabadb8 cc95eb0 4866510 MM	desc.c
> +::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM	bar.sh
> +::100644 100644 100644 e07d6c5 9042e82 ee91881 RR	phooey.c
> +------------------------------------------------
> +
> +Examples when `--combined-all-names` added to either `-c` or `--cc`:

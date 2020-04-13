Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15916C38A29
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB032072A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X0Tu3t+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbgDMWpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:45:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389697AbgDMWoC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:44:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA62A52EF6;
        Mon, 13 Apr 2020 18:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DvT+YRw4M/W1BsPthsesOQaVekY=; b=X0Tu3t
        +eYrNqCmSEUbquRiNST8NCwpAgUHMldG1/iio/E0+W1M/HanetuuZatI3ZeU6f/7
        H1Ac3SJ/yInzkTv4ngxPDVP6cWER37Ib12sAstbX6603dF4dVjV51ZRylfkXLJSv
        fHY2B4DAqPLaAVcbT3as4KNtp5tmdtrgk78UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BodCQPRi8qkj8JVdGOAz3A0t0G10gLOm
        kTgBjQNyW786OjnAxWQCru8m8zX6zQ7rPlrW+fZNWk6zbfT65JnvnGYTRctx53AW
        rPq+Iyue5xNniECx0+to496qufTPeiAHZ5k1KI51+sstApCwMMcYSKErU5FmrLy5
        42KoaEIE4hs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9340E52EF4;
        Mon, 13 Apr 2020 18:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 701AD52EF1;
        Mon, 13 Apr 2020 18:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v2 0/3] clone: document partial clone section
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
        <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 15:45:00 -0700
In-Reply-To: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com> (Teng
        Long via GitGitGadget's message of "Mon, 13 Apr 2020 15:25:57 +0000")
Message-ID: <xmqqd08batub.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6990B1B2-7DD8-11EA-AFEB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Teng Long via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Partial clones are created using 'git clone', but there is no related help
> information in the git-clone documentation during a period. Add a relevant
> section to help users understand what partial clones are and how they differ
> from normal clones.
>
> The section briefly introduces the applicable scenarios and some precautions
> of partial clone. If users want to know more about its technical design and
> other details, users can view the link of git-partial-clone(7) according to
> the guidelines in the section.
>
> Derrick Stolee (2):
>   partial-clone: set default filter with --partial
>   clone: document --partial and --filter options
>
> Dyrone Teng (1):
>   clone: document partial clone section

> base-commit: 6c85aac65fb455af85745130ce35ddae4678db84
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v2
> Pull-Request: https://github.com/git/git/pull/745
>
> Range-diff vs v1:

Can you remind readers which thread was the v1?  Hopefully it is not
this one, right?

  https://lore.kernel.org/git/20200322192234.GC671552@coredump.intra.peff.net/

it concluded that it is not a great idea to set default filter with
"--partial", and the discussion led to a v2 with a reduced scope at

  https://lore.kernel.org/git/pull.586.v2.git.1584906606469.gitgitgadget@gmail.com/

and that one is already cooking.

>  -:  ----------- > 1:  6f340d9aadf partial-clone: set default filter with --partial
>  -:  ----------- > 2:  9baf4c8ba38 clone: document --partial and --filter options
>  1:  f063efa545b ! 3:  c1a44a35095 clone: document partial clone section

Thanks.

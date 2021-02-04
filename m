Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C56EC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03DB64E3F
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhBDSyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:54:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53916 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbhBDSxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:53:54 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A16EDB3F8F;
        Thu,  4 Feb 2021 13:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tx1THNZrDi+5btVULsKZf9oZ1YM=; b=nKgIeE
        WcZFLreBIS1X7+ZepNpipZUr7VtEgmW2gUknvFCJh4XzOHZo5g621+5AoVbrEqQk
        5ncN5GCZ3v/npf257xYLxHYCV4x78IWlc0N6h6RuJR4b95Trh4i5cz0Q1DoVQcMZ
        LD0XT0davXtw0BLpVVhJbhXxgJHQjC2fzy2iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVyzdLKBKQCrVEALJ+FkVkjnh2gVANu8
        3SXl81V6SvrlmZ6kYtStydot6boGvIKCKDqIyOtfPR5ZjhzROlnKLwpGMRkR9Y8y
        mzexbrYaUWuMU6Ps3ndvzBxpfmNQKKKIMbH3atHEHnH5LFjPzGhWUdDeDSqQfVJS
        OMKD3A9M0Jw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97DACB3F8E;
        Thu,  4 Feb 2021 13:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C6C1B3F8D;
        Thu,  4 Feb 2021 13:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] range-diff(docs): explain how to specify commit
 ranges
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <295fdc1cd32cffcef145d9dd0ac76d29580fa6de.1612431093.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 10:53:08 -0800
In-Reply-To: <295fdc1cd32cffcef145d9dd0ac76d29580fa6de.1612431093.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021
        09:31:32 +0000")
Message-ID: <xmqq35yb7jhn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3931BAA8-671A-11EB-A7C3-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> There are three forms, depending whether the user specifies one, two or
> three non-option arguments. We've never actually explained how this
> works in the manual, so let's explain it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-range-diff.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> index 9701c1e5fdd5..14bffb272a06 100644
> --- a/Documentation/git-range-diff.txt
> +++ b/Documentation/git-range-diff.txt
> @@ -28,6 +28,18 @@ Finally, the list of matching commits is shown in the order of the
>  second commit range, with unmatched commits being inserted just after
>  all of their ancestors have been shown.
>  
> +There are three ways to specify the commit ranges:
> +
> +- `<range1> <range2>`: Either commit range can be of the form
> +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> +  in linkgit:gitrevisions[7] for more details.
> +
> +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> +  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.

As I said before, this _is_ a symmetric range that has commits
reachable from rev1 but not from rev2 on the left hand side, and
commits reachable from rev2 but not from rev1 on the right hand
side, not just something else that resembles a symmetric range.

> +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> +  <base>..<rev2>`.
>  
>  OPTIONS
>  -------

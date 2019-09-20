Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5668B1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 20:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfITUBq (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 16:01:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56927 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfITUBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 16:01:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F159C8047B;
        Fri, 20 Sep 2019 16:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aamjP45RVzJPKaZCuwfBlhPb4qA=; b=Q4zIQo
        c4mdee1ypGp21+UCammg8BOX2sEJrx8l2r1MSmytLaA4oh449/VgNW1arfMVzaj1
        hi6+Gts0HyraJG3jGBEeWUPcrSDJ6mG4FdzsTg5zcJemRz8wNOY+9y80wc+PQQLd
        jhKST28KbtV4WZk8c3zV6EGKFO1iPZTZi0IpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h4noani7EzDUAwgBgQLvI8OPozktLg4W
        8SfthUqd/YLPHLErCnjYme+qvfsLJik5nXfqQkWxGUzIk4zUzHiBv0wN3j9KcdZo
        2QuP1UrqjABdPzSg77mFSTExPnJK5HRnYIYm72mMNn//YoyH3QWJqORKPuCGEV8Q
        RQg3hAJ3rE0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E905A8047A;
        Fri, 20 Sep 2019 16:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1940580478;
        Fri, 20 Sep 2019 16:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag Add the MIDX_PROGRESS flag and update the write|verify|expire|repack functions in midx.h to accept a flags parameter.  The MIDX_PROGRESS flag indicates whether the caller of the function would like progress information to be displayed. This patch only changes the method prototypes and does not change the functionality. The functionality change will be handled by a later patch.
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
        <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
Date:   Fri, 20 Sep 2019 13:01:35 -0700
In-Reply-To: <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Fri, 20 Sep 2019
        09:53:48 -0700 (PDT)")
Message-ID: <xmqqr24au480.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 748F1D7C-DBE1-11E9-80F9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: William Baker <William.Baker@microsoft.com>
>
> Signed-off-by: William Baker <William.Baker@microsoft.com>
> ---
>  builtin/multi-pack-index.c |  8 ++++----
>  builtin/repack.c           |  2 +-
>  midx.c                     |  8 ++++----
>  midx.h                     | 10 ++++++----
>  4 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index b1ea1a6aa1..e86b8cd17d 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -47,16 +47,16 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	trace2_cmd_mode(argv[0]);
>  
>  	if (!strcmp(argv[0], "repack"))
> -		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
> +		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size, 0);
>  	if (opts.batch_size)
>  		die(_("--batch-size option is only for 'repack' subcommand"));
>  
>  	if (!strcmp(argv[0], "write"))
> -		return write_midx_file(opts.object_dir);
> +		return write_midx_file(opts.object_dir, 0);
>  	if (!strcmp(argv[0], "verify"))
> -		return verify_midx_file(the_repository, opts.object_dir);
> +		return verify_midx_file(the_repository, opts.object_dir, 0);
>  	if (!strcmp(argv[0], "expire"))
> -		return expire_midx_packs(the_repository, opts.object_dir);
> +		return expire_midx_packs(the_repository, opts.object_dir, 0);

Hmm, I actually would have expected to see a new .progress field in
the opts structure and these lower-level functions would start
taking a pointer to the whole opts structure, instead of just a
pointer to a single member opts.object_dir.  That way, we can later
extend and enrich the interface between this caller and the
underlying functions without much patch noise in the dispatch layer
(i.e. here).

This step is meant to be just preparing by extending the interface
and passing the new argument throughout the callchain, I believe,
and it looks correctly done, assuming that we are OK to take this
"add a separate 'progress' parameter, when we need more parameters
later, the interface will gain more and more parameters" approach.

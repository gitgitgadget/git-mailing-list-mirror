Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456A7C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 22:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242549AbiF0WS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiF0WSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 18:18:25 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9944DBA
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 15:18:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 120C1131A13;
        Mon, 27 Jun 2022 18:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sHHMVSbp4K0jcbnXogxw8efgo8p82pcsZRt4gA
        eoL+g=; b=GZczscBnlxVxcyeblu+QvqBYQjG75YJqKATAyWRBZ5mo5U0kHOuzr6
        QyJOd+Zv3Vqm9ycMbfvPy6SRM3lbdhWkuyWtI+t2ZvTdPY7vqLFjYKFBVAqJqGcd
        RyjVpEhT0+tEo0xgc/63jUe2jkNXzi1Wd7ezfaN9DnUYlJlOkvg/4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 095D2131A12;
        Mon, 27 Jun 2022 18:18:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A991131A10;
        Mon, 27 Jun 2022 18:18:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 15/16] bisect: remove Cogito-related code
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <33566b86d77dcc11d68b2aceec0b6c5218bf198e.1656354677.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 15:18:21 -0700
In-Reply-To: <33566b86d77dcc11d68b2aceec0b6c5218bf198e.1656354677.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 27 Jun 2022
        18:31:16 +0000")
Message-ID: <xmqqo7ydn42a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E5B147C-F667-11EC-B0BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> As of April 19th, 2007, Cogito was therefore discontinued (see
> https://lore.kernel.org/git/20070419124648.GL4489@pasky.or.cz/).
>
> Nevertheless, for almost 15 years after that announcement, Git carried
> special code in `git bisect` to accommodate Cogito.

Good eyes.  Doesn't steps 15 & 16 cover the same theme, though?
IOW, if surviving Cogito users appear after we take this 16-patch
series, would reverting this step the only thing needed if we decide
to accomodate them again (and removal of head-name done in step 16
can still be kept without harming these Cogito users)?  I am wondering
if these should be merged into one patch.

Thanks.


>
> Since it is beyond doubt that there are no more Cogito users, let's
> remove the last remnant of Cogito-accommodating code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect.c | 8 --------
>  1 file changed, 8 deletions(-)



>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 380fef852f3..47103ebf3f2 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -14,7 +14,6 @@ static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>  static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
>  static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
> -static GIT_PATH_FUNC(git_path_head_name, "head-name")
>  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>  static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
>  static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
> @@ -809,13 +808,6 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
>  			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
>  		} else if (!get_oid(head, &head_oid) &&
>  			   skip_prefix(head, "refs/heads/", &head)) {
> -			/*
> -			 * This error message should only be triggered by
> -			 * cogito usage, and cogito users should understand
> -			 * it relates to cg-seek.
> -			 */
> -			if (!is_empty_or_missing_file(git_path_head_name()))
> -				return error(_("won't bisect on cg-seek'ed tree"));
>  			strbuf_addstr(&start_head, head);
>  		} else {
>  			return error(_("bad HEAD - strange symbolic ref"));

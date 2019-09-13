Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712591F464
	for <e@80x24.org>; Fri, 13 Sep 2019 20:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbfIMUFI (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:05:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65091 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfIMUFI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:05:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E97F3005F;
        Fri, 13 Sep 2019 16:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y5tzPDWCPjXOnm5vmA6nM+MCk3c=; b=Q+EgDu
        8zO2lH3lcG6+iC8EahU9hxmCn2HiiTvRJfM+WwuMucNVIn8ApVttxwBeQb0SzNoJ
        DePI69df30Ba7VZbIbsEhPYHTsdOnKBcnVDEL7rGWV1QaFdEwq9AK15PHgFu0N0f
        WfiBNJOIUFlgP27mO2u4jM6QB2FVM6odfixZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JX5bddpPttIBjNNwjuQqmTnrVtu98YGp
        e5oD3jPRo0mUnZpyUBtVCPuxTlrd0qP1EKFy0eGc+FRmzZg7PvayrJMfr01dwe7K
        VA3pzRlEheN1OJnbFJGneEWIl+c7fqU/RPqLCJSGmn9ICfHqHNO3JAsk7Vim9njm
        IrEXUgg1zAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E74FC3005D;
        Fri, 13 Sep 2019 16:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E90C3005C;
        Fri, 13 Sep 2019 16:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Asc?= =?utf-8?Q?ens=C3=A3o?= 
        <rafa.almas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>, Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v3 07/12] dir: add commentary explaining match_pathspec_item's return value
References: <20190905154735.29784-1-newren@gmail.com>
        <20190912221240.18057-1-newren@gmail.com>
        <20190912221240.18057-8-newren@gmail.com>
Date:   Fri, 13 Sep 2019 13:04:59 -0700
In-Reply-To: <20190912221240.18057-8-newren@gmail.com> (Elijah Newren's
        message of "Thu, 12 Sep 2019 15:12:35 -0700")
Message-ID: <xmqqsgp0c68k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4B8BBF8-D661-11E9-8956-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The way match_pathspec_item() handles names and pathspecs with trailing
> slash characters, in conjunction with special options like
> DO_MATCH_DIRECTORY and DO_MATCH_LEADING_PATHSPEC were non-obvious, and
> broken until this patch series.  Add a table in a comment explaining the
> intent of how these work.

Thanks.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  dir.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 47c0a99cb5..3b2fe1701c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -276,16 +276,27 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
>  #define DO_MATCH_LEADING_PATHSPEC (1<<2)
>  
>  /*
> - * Does 'match' match the given name?
> - * A match is found if
> + * Does the given pathspec match the given name?  A match is found if
>   *
> - * (1) the 'match' string is leading directory of 'name', or
> - * (2) the 'match' string is a wildcard and matches 'name', or
> - * (3) the 'match' string is exactly the same as 'name'.
> + * (1) the pathspec string is leading directory of 'name' ("RECURSIVELY"), or
> + * (2) the pathspec string has a leading part matching 'name' ("LEADING"), or
> + * (3) the pathspec string is a wildcard and matches 'name' ("WILDCARD"), or
> + * (4) the pathspec string is exactly the same as 'name' ("EXACT").
>   *
> - * and the return value tells which case it was.
> + * Return value tells which case it was (1-4), or 0 when there is no match.
>   *
> - * It returns 0 when there is no match.
> + * It may be instructive to look at a small table of concrete examples
> + * to understand the differences between 1, 2, and 4:
> + *
> + *                              Pathspecs
> + *                |    a/b    |   a/b/    |   a/b/c
> + *          ------+-----------+-----------+------------
> + *          a/b   |  EXACT    |  EXACT[1] | LEADING[2]
> + *  Names   a/b/  | RECURSIVE |   EXACT   | LEADING[2]
> + *          a/b/c | RECURSIVE | RECURSIVE |   EXACT
> + *
> + * [1] Only if DO_MATCH_DIRECTORY is passed; otherwise, this is NOT a match.
> + * [2] Only if DO_MATCH_LEADING_PATHSPEC is passed; otherwise, not a match.
>   */
>  static int match_pathspec_item(const struct index_state *istate,
>  			       const struct pathspec_item *item, int prefix,
> @@ -353,7 +364,7 @@ static int match_pathspec_item(const struct index_state *istate,
>  			 item->nowildcard_len - prefix))
>  		return MATCHED_FNMATCH;
>  
> -	/* Perform checks to see if "name" is a super set of the pathspec */
> +	/* Perform checks to see if "name" is a leading string of the pathspec */
>  	if (flags & DO_MATCH_LEADING_PATHSPEC) {
>  		/* name is a literal prefix of the pathspec */
>  		int offset = name[namelen-1] == '/' ? 1 : 0;

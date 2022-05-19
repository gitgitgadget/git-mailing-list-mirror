Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65319C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbiESRpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242981AbiESRpL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:45:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F194A5012
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:45:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC93F11585A;
        Thu, 19 May 2022 13:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D4I6O+GwlSRNHWtgK4j7dfWpdDeZdTEb9k51r9
        hYb70=; b=j1XtC4xNIst6fOCms2FLbjldueLHJd6zefUTLkysN2/EDjEzs5UrtI
        61lBcYazFjACXg9PmMOURMQlton085hdxl82QDqy9pVho24BBp6OpuW01ALI3QUF
        2Xtjy0/RBNKTs20TmIq3Rz9dZUhGIH2/oP3FuixtTUaVnqJ1dGUqk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77353115859;
        Thu, 19 May 2022 13:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6ECF7115857;
        Thu, 19 May 2022 13:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] merge: remove unused variable
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 10:45:06 -0700
In-Reply-To: <042d624b8159364229e95d35e9309f12b67f8173.1652977582.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 19 May 2022
        16:26:21 +0000")
Message-ID: <xmqq1qwppgbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CAD0980-D79B-11EC-90EF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> restore_state() had a local variable sb that is not used, and in fact,
> was never used even in the original commit that introduced it,
> 1c7b76be7d ("Build in merge", 2008-07-07).  Remove it.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 2 --
>  1 file changed, 2 deletions(-)

Nice.  Thanks.

>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index f178f5a3ee1..00de224a2da 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
>  static void restore_state(const struct object_id *head,
>  			  const struct object_id *stash)
>  {
> -	struct strbuf sb = STRBUF_INIT;
>  	const char *args[] = { "stash", "apply", NULL, NULL };
>  
>  	if (is_null_oid(stash))
> @@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
>  	 */
>  	run_command_v_opt(args, RUN_GIT_CMD);
>  
> -	strbuf_release(&sb);
>  	refresh_cache(REFRESH_QUIET);
>  }

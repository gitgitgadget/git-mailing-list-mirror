Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 23:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiGSXO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSXO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 19:14:26 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100864E0C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 16:14:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C778D199D49;
        Tue, 19 Jul 2022 19:14:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3x6Cu7eMLotSiJGk8yr4s7TM/wmfuMjMJDvF4+LYbdo=; b=omrC
        L4jxcHNPsY4+0lxzIE17mEuKzfzL4wXhcmQrG68AMkNnOQFuE4bGFsXknd9tikuD
        Mp9nr1j965IZAMrl/n3hDVPwcuwtbDVI1bkZMbasGFN70fvNi+8+j5mX2f3VkXf2
        nDPiJvRMxlCjaZKUikwmJJQUiWELGtyGMAdPnIQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF383199D47;
        Tue, 19 Jul 2022 19:14:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5EDA199D44;
        Tue, 19 Jul 2022 19:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/6] merge: remove unused variable
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <230d84f09c8b75d15168d5ff8205b543fa8ca91d.1655621424.git.gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 16:14:20 -0700
Message-ID: <xmqqleso66gj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85D2A5EE-07B8-11ED-AC5C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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

Obviously correct ;-)

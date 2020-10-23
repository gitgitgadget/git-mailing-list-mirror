Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D1C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 05:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F345C20882
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 05:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370776AbgJWFbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 01:31:20 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:3061 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370772AbgJWFbU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 01:31:20 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4CHXs22Kpjz5tl9;
        Fri, 23 Oct 2020 07:31:16 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5E0AB212C;
        Fri, 23 Oct 2020 07:31:16 +0200 (CEST)
Subject: Re: [PATCH] apply: clarify description of --index
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <23806f2c-df96-b105-3b85-f40b0e8ec7ca@kdbg.org>
Date:   Fri, 23 Oct 2020 07:31:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqzh4dk3ey.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.20 um 05:49 schrieb Junio C Hamano:
> Instead of explaining the requirement for the paths to be up-to-date,
> as if it is an afterthought, state it upfront.
> 
> The updated description matches how the checks actually are
> performed.  A path that is "dirty" stops the patch application from
> being attempted to either working tree files or to the index.
> 
> Hopefully this change would help users to form a better mental
> model.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Just noticed while reviewing how "apply" (and "am") are explained.
> 
>  Documentation/git-apply.txt | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index 91d9a8601c..1be7751f58 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -61,13 +61,11 @@ OPTIONS
>  	file and detects errors.  Turns off "apply".
>  
>  --index::
> -	Apply the patch to both the index and the working tree (or
> -	merely check that it would apply cleanly to both if `--check` is
> -	in effect). Note that `--index` expects index entries and
> -	working tree copies for relevant paths to be identical (their
> -	contents and metadata such as file mode must match), and will
> -	raise an error if they are not, even if the patch would apply
> -	cleanly to both the index and the working tree in isolation.
> +	After making sure the paths the patch touches in the working
> +	tree have no modifications relative to their index entries,
> +	apply the patch both to the index entries and to the working
> +	tree files or see if it applies	cleanly, when `--check` is in
> +	effect.

I don't think that this is an improvement. The purpose of --index *is*
to apply the patch to both index and worktree, and that should be
mentioned first. The check that both are identical, is a prerequisite
and not the primary objective of the option.

>  
>  --cached::
>  	Apply the patch to just the index, without touching the working
> 

-- Hannes

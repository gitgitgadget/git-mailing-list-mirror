Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9C4C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B27161263
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 10:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhIOK0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhIOK0h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 06:26:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C81C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 03:25:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w29so3032001wra.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=806KWJdi5XYIf5m2buOg+zSsRjY7OE/BSYg+G+xz6mI=;
        b=C3Gt2MLYBy7uqvqby7Zymi4Wt7Cjy0Ma7HBNDwn5cQTRnkIE/t+QP/nr8G1N6TYGRP
         V2KnYz+CuhnqfeRV1AeOVJzgSi+QVORkIIwNVG4m9uPp9o+a0FQU41g++bplUMcsbVjC
         rGpHnfQ+7wVKkm9+avr6/yR5zYH8Ez7ETRhXYh/kK+G1Xxd+JNMjx9wFUt5e/VUThNwQ
         kwDV+FUHWe9Lqopw7LlAozNrnMqK9AKpV3xG6/wdxiAGiWVB8I3rAZlOBnNckS10mza2
         gtDo6Vhm4RtshnnO7aCNJD3PYbFgC/Ys7vmQUv/ysXUQtc7sg6brCYYCmfWfu64mZ1nB
         f6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=806KWJdi5XYIf5m2buOg+zSsRjY7OE/BSYg+G+xz6mI=;
        b=cTA0JHj9sbNgWLvYK0gI4B12c1iYhwV4JYL31X5R48j1YvKolvZT4rvUfBT0gz554/
         AzBC9YAhWbG1BBtvMxVRYxElqteMBSHmyZl2zW7brCT//9WtAH93is7TQl1Q1N+xPWKp
         g+PJ8BnXNBb6j+YIj7ViO/X128grZtwD897qG9EwtiYzmLEz/E/q6OC0UYE6aywFk2Uw
         ojC5PrhJkh9pKaPqtAvD8ajPaHT+U//wJPv0DEv3EPkzOWPXA22ZdY8fV4cXejSGiYQA
         Z/Fta6CwPR2TlAfAl04dhj46aIUAjfdMEVdLbWCRN6Z4RT91Dn1dX1uLlAos9BQrPik4
         863g==
X-Gm-Message-State: AOAM531FmVBdAu2IPKvcMuND+GWYBXXsoLHjsZLu5/qNckRyfzzXs6pO
        FN80lET+yYDXM+M5qYM1xCE=
X-Google-Smtp-Source: ABdhPJzpOHgB4a+Y4/cTkMVjyAika0wuTswfMwJrMLxszGGwPQAvpIKxShcUtqBJFbJEtf4Ht7+vXw==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr4190299wrq.359.1631701514089;
        Wed, 15 Sep 2021 03:25:14 -0700 (PDT)
Received: from [192.168.1.201] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.googlemail.com with ESMTPSA id f5sm3771370wmb.47.2021.09.15.03.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 03:25:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
 <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
Date:   Wed, 15 Sep 2021 11:25:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/09/2021 18:03, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> [...] 
> diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
> index 25c4b720e72..de9c6190b9c 100755
> --- a/t/t6427-diff3-conflict-markers.sh
> +++ b/t/t6427-diff3-conflict-markers.sh
> @@ -211,4 +211,60 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
>   	)
>   '
>   
> +test_setup_zdiff3 () {
> +	test_create_repo zdiff3 &&
> +	(
> +		cd zdiff3 &&
> +
> +		test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
> +		test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
> +		test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
> +
> +		git add basic middle-common &&

interesting does not get committed

> +		git commit -m base &&

adding "base=$(git rev-parse --short HEAD^1)" here ...

> +
> +		git branch left &&
> +		git branch right &&
> +
> +		git checkout left &&
> +		test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
> +		test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
> +		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
> +		git add -u &&
> +		git commit -m letters &&
> +
> +		git checkout right &&
> +		test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
> +		test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
> +		test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
> +		git add -u &&
> +		git commit -m permuted
> +	)
> +}
> +
> +test_expect_failure 'check zdiff3 markers' '
> +	test_setup_zdiff3 &&
> +	(
> +		cd zdiff3 &&
> +
> +		git checkout left^0 &&
> +
> +		test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
> +
> +		test_write_lines 1 2 3 4 A "<<<<<<< HEAD" B C D "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= X C Y ">>>>>>> right^0" E 7 8 9 >expect &&

... and then using $base rather than $(git rev-parse ...) would shorten 
these lines. It might be clearer if they were split up something like 
this as well
	
	test_write_lines \
		1 2 3 4 A \
		"<<<<<<< HEAD" B C D \
		"||||||| $base" 5 6 ======= \
		X C Y ">>>>>>> right^0"\
		 E 7 8 9 >expect &&

> +		test_cmp expect basic &&
> +
> +		test_write_lines 1 2 3 "<<<<<<< HEAD" CC "||||||| $(git rev-parse --short HEAD^1)" AA ======= EE ">>>>>>> right^0" 4 5 "<<<<<<< HEAD" DD "||||||| $(git rev-parse --short HEAD^1)" BB ======= FF ">>>>>>> right^0" 6 7 8 >expect &&
> +		test_cmp expect middle-common &&
> +
> +		# Not passing this one yet.  For some reason, after extracting
> +		# the common lines "A B C" and "G H I J", the remaining part
> +		# is comparing "5 6" in the base to "5 6" on the left and
> +		# "D E F" on the right.  And zdiff3 currently picks the side
> +		# that matches the base as the merge result.  Weird.
> +		test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >expect &&

I might be about to make a fool of myself but I don't think this is 
right for expect. 5 and 6 are deleted on the left so the two sides 
should conflict. Manually comparing the result of merging with diff3 and 
zdiff3 the zdiff3 result looked correct to me.

I do wonder (though a brief try failed to trigger it) if there are cases 
where the diff algorithm does something "clever" which means it does not 
treat a common prefix or suffix as unchanged (see d2f82950a9 
("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We 
could just trim the common prefix and suffix from the two sides 
ourselves using xdl_recmatch().

Best Wishes

Phillip

> +		test_cmp expect interesting
> +	)
> +'
> +
>   test_done
> diff --git a/xdiff-interface.c b/xdiff-interface.c
> index 609615db2cd..9977813a9d3 100644
> --- a/xdiff-interface.c
> +++ b/xdiff-interface.c
> @@ -308,6 +308,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
>   			die("'%s' is not a boolean", var);
>   		if (!strcmp(value, "diff3"))
>   			git_xmerge_style = XDL_MERGE_DIFF3;
> +		else if (!strcmp(value, "zdiff3"))
> +			git_xmerge_style = XDL_MERGE_ZEALOUS_DIFF3;
>   		else if (!strcmp(value, "merge"))
>   			git_xmerge_style = 0;
>   		/*
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 7a046051468..8629ae287c7 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -65,6 +65,7 @@ extern "C" {
>   
>   /* merge output styles */
>   #define XDL_MERGE_DIFF3 1
> +#define XDL_MERGE_ZEALOUS_DIFF3 2
>   
>   typedef struct s_mmfile {
>   	char *ptr;
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 1659edb4539..df0c6041778 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -230,7 +230,7 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
>   	size += xdl_recs_copy(xe1, m->i1, m->chg1, needs_cr, 1,
>   			      dest ? dest + size : NULL);
>   
> -	if (style == XDL_MERGE_DIFF3) {
> +	if (style == XDL_MERGE_DIFF3 || style == XDL_MERGE_ZEALOUS_DIFF3) {
>   		/* Shared preimage */
>   		if (!dest) {
>   			size += marker_size + 1 + needs_cr + marker3_size;
> @@ -327,7 +327,7 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>    * lines. Try hard to show only these few lines as conflicting.
>    */
>   static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
> -		xpparam_t const *xpp)
> +				xpparam_t const *xpp, int style)
>   {
>   	for (; m; m = m->next) {
>   		mmfile_t t1, t2;
> @@ -368,6 +368,42 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>   			continue;
>   		}
>   		x = xscr;
> +		if (style == XDL_MERGE_ZEALOUS_DIFF3) {
> +			int advance1 = xscr->i1, advance2 = xscr->i2;
> +
> +			/*
> +			 * Advance m->i1 and m->i2 so that conflict for sides
> +			 * 1 and 2 start after common region.  Decrement
> +			 * m->chg[12] since there are now fewer conflict lines
> +			 * for those sides.
> +			 */
> +			m->i1 += advance1;
> +			m->i2 += advance2;
> +			m->chg1 -= advance1;
> +			m->chg2 -= advance2;
> +
> +			/*
> +			 * Splitting conflicts due to internal common regions
> +			 * on the two sides would be inappropriate since we
> +			 * are also showing the merge base and have no
> +			 * reasonable way to split the merge base text.
> +			 */
> +			while (xscr->next)
> +				xscr = xscr->next;
> +
> +			/*
> +			 * Lower the number of conflict lines to not include
> +			 * the final common lines, if any.  Do this by setting
> +			 * number of conflict lines to
> +			 *   (line offset for start of conflict in xscr) +
> +			 *   (number of lines in the conflict in xscr)
> +			 */
> +			m->chg1 = (xscr->i1 - advance1) + (xscr->chg1);
> +			m->chg2 = (xscr->i2 - advance2) + (xscr->chg2);
> +			xdl_free_env(&xe);
> +			xdl_free_script(x);
> +			continue;
> +		}
>   		m->i1 = xscr->i1 + i1;
>   		m->chg1 = xscr->chg1;
>   		m->i2 = xscr->i2 + i2;
> @@ -419,6 +455,7 @@ static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>   static void xdl_merge_two_conflicts(xdmerge_t *m)
>   {
>   	xdmerge_t *next_m = m->next;
> +	m->chg0 = next_m->i0 + next_m->chg0 - m->i0;
>   	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
>   	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
>   	m->next = next_m->next;
> @@ -430,12 +467,12 @@ static void xdl_merge_two_conflicts(xdmerge_t *m)
>    * it appears simpler -- because it takes up less (or as many) lines --
>    * if the lines are moved into the conflicts.
>    */
> -static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m,
> +static int xdl_simplify_non_conflicts(xdfenv_t *xe1, xdmerge_t *m, int style,
>   				      int simplify_if_no_alnum)
>   {
>   	int result = 0;
>   
> -	if (!m)
> +	if (!m || style == XDL_MERGE_ZEALOUS_DIFF3)
>   		return result;
>   	for (;;) {
>   		xdmerge_t *next_m = m->next;
> @@ -482,6 +519,25 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>   	int style = xmp->style;
>   	int favor = xmp->favor;
>   
> +	/*
> +	 * XDL_MERGE_DIFF3 does not attempt to refine conflicts by looking
> +	 * at common areas of sides 1 & 2, because the base (side 0) does
> +	 * not match and is being shown.  Similarly, simplification of
> +	 * non-conflicts is also skipped due to the skipping of conflict
> +	 * refinement.
> +	 *
> +	 * XDL_MERGE_ZEALOUS_DIFF3, on the other hand, will attempt to
> +	 * refine conflicts looking for common areas of sides 1 & 2.
> +	 * However, since the base is being shown and does not match,
> +	 * it will only look for common areas at the beginning or end
> +	 * of the conflict block.  Since XDL_MERGE_ZEALOUS_DIFF3's
> +	 * conflict refinement is much more limited in this fashion, the
> +	 * conflict simplification will be skipped.
> +	 *
> +	 * See xdl_refine_conflicts() and xdl_simplify_non_conflicts()
> +	 * for more details, particularly looking for
> +	 * XDL_MERGE_ZEALOUS_DIFF3.
> +	 */
>   	if (style == XDL_MERGE_DIFF3) {
>   		/*
>   		 * "diff3 -m" output does not make sense for anything
> @@ -604,8 +660,8 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
>   		changes = c;
>   	/* refine conflicts */
>   	if (XDL_MERGE_ZEALOUS <= level &&
> -	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
> -	     xdl_simplify_non_conflicts(xe1, changes,
> +	    (xdl_refine_conflicts(xe1, xe2, changes, xpp, style) < 0 ||
> +	     xdl_simplify_non_conflicts(xe1, changes, style,
>   					XDL_MERGE_ZEALOUS < level) < 0)) {
>   		xdl_cleanup_merge(changes);
>   		return -1;
> 


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB8C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E099222518
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLOOcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 09:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbgLOOb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 09:31:56 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F98C06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:31:16 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id k9so4858232oop.6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 06:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbxPlbDbrqeKtJxGIQxx1tI7RTNIu0IIiUEhoXyAp8Y=;
        b=LalnRqZhTwJCfLGjiLmdeI/wEoBth5B1RGrcPH9Ydppy/gSJnT9Ft7zpWAyYaETq7H
         4C5v99fwvAi8iLXUMpLRDOlXuBPqKbe9HfCwLZYHbZOfk5VyZxjvxjV8OgGRpW28SCNb
         bLudY9XTU0faNCaZIIDOqFZpnspzBm0rUdHi+tJx3BJNmCOexzG5fs41tgP3aXOxLMNt
         jyns9iVkD6gfbE5Er077y/GAb1PY4CGgmWRoCSLmxzYTxiBdjM7C6bxcEBN6XW+bADdA
         Z/O+UmO68KK6QDWTue1c5lv7ozkaCF8FY/Bn1RDGUfyFQz5xtlp6Bpq/6Oj7FSkuUV/S
         tuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbxPlbDbrqeKtJxGIQxx1tI7RTNIu0IIiUEhoXyAp8Y=;
        b=tNpSEqHlxuP17yqnzpw4s7q3KFUZoRZebxJZobpCWCSbO9vyYgEed8R0lUbptnXAS+
         +qMdGC61iXQW0N0EvY6+RbFdtRUi9xYclrh5+aj1E0wM/64sNP+nYAFQlGfhYmL5USfU
         mvHmRzNCoRRPUy5QB0VeU+v23kwA5hr9RP2YW4OjVSATxUHPKblpwIWC3D/2RgeC2DGn
         1SrnQmurqXoLPzRYelILQZs4hSKp2EIATKDCh84XZN1cqOq0Im/xzs1nhmJ+NVbuNbgs
         eAHYb19rl6ybKKVQMXkXdiPXflpKEdB2H0YQ0ABnN84WuFaMEQUot1aGdgqouk0l7Sk2
         Cz9Q==
X-Gm-Message-State: AOAM533g7cAyFLLAVfOc56OxbiAZAn6AoNfHUI9FdV8+2cpagAYGnwK5
        3q6LZmBqr1vcbMl865tqimU=
X-Google-Smtp-Source: ABdhPJwp/GGToOarSDBpsRqPNOhgMtIoW1mXs3O0jQ2eNZPmamoVSygT0QYNMWOBxHerEQDRY2tcKQ==
X-Received: by 2002:a4a:da44:: with SMTP id f4mr6305330oou.84.1608042675419;
        Tue, 15 Dec 2020 06:31:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id h7sm444221otq.21.2020.12.15.06.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:31:14 -0800 (PST)
Subject: Re: [PATCH v2 11/11] merge-ort: add implementation of type-changed
 rename handling
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
 <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
 <ff09ddb9caf73632c9792c07f1f7499a75a09606.1607962900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fcc6b18e-c5eb-27a1-b6b5-4dcdd97e2b90@gmail.com>
Date:   Tue, 15 Dec 2020 09:31:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <ff09ddb9caf73632c9792c07f1f7499a75a09606.1607962900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/14/2020 11:21 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Implement cases where renames are involved in type changes (i.e. the
> side of history that didn't rename the file changed its type from a
> regular file to a symlink or submodule).  There was some code to handle
> this in merge-recursive but only in the special case when the renamed
> file had no content changes.  The code here works differently -- it
> knows process_entry() can handle mode conflicts, so it does a few
> minimal tweaks to ensure process_entry() can just finish the job as
> needed.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 9aac33c8e31..11e33f56edf 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -778,7 +778,32 @@ static int process_renames(struct merge_options *opt,
>  			 S_ISREG(newinfo->stages[target_index].mode));
>  		if (type_changed && collision) {
>  			/* special handling so later blocks can handle this */

Perhaps drop this comment, or incorporate it into the lower one?

> -			die("Not yet implemented");
> +			/*
> +			 * if type_changed && collision are both true, then this
> +			 * was really a double rename, but one side wasn't
> +			 * detected due to lack of break detection.  I.e.
> +			 * something like
> +			 *    orig: has normal file 'foo'
> +			 *    side1: renames 'foo' to 'bar', adds 'foo' symlink
> +			 *    side2: renames 'foo' to 'bar'
> +			 * In this case, the foo->bar rename on side1 won't be
> +			 * detected because the new symlink named 'foo' is
> +			 * there and we don't do break detection.  But we detect
> +			 * this here because we don't want to merge the content
> +			 * of the foo symlink with the foo->bar file, so we
> +			 * have some logic to handle this special case.  The
> +			 * easiest way to do that is make 'bar' on side1 not
> +			 * be considered a colliding file but the other part
> +			 * of a normal rename.  If the file is very different,
> +			 * well we're going to get content merge conflicts
> +			 * anyway so it doesn't hurt.  And if the colliding
> +			 * file also has a different type, that'll be handled
> +			 * by the content merge logic in process_entry() too.
> +			 *
> +			 * See also t6430, 'rename vs. rename/symlink'

I appreciate the callout to a test that exercises this behavior.

> +			 */
> +			collision = 0;
> +		}

Here, we regain that closing curly brace, fixing the compiler errors from
earlier.

>  		if (source_deleted) {
>  			if (target_index == 1) {
>  				rename_branch = opt->branch1;
> @@ -858,7 +883,11 @@ static int process_renames(struct merge_options *opt,
>  			newinfo->pathnames[0] = oldpath;
>  			if (type_changed) {
>  				/* rename vs. typechange */
> -				die("Not yet implemented");
> +				/* Mark the original as resolved by removal */
> +				memcpy(&oldinfo->stages[0].oid, &null_oid,
> +				       sizeof(oldinfo->stages[0].oid));
> +				oldinfo->stages[0].mode = 0;
> +				oldinfo->filemask &= 0x06;

This matches your explanation in the comment above. I wonder if 0x06
could be less magical, but we are really deep in the weeds here already.

Thanks,
-Stolee


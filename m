Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69CAC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8F522B39
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393893AbhARUhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388950AbhARUhO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:37:14 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8D1C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:36:34 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 143so19861262qke.10
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJeTHuID04+jmTTMvk0BHWGStBWi53xqptLvOwQ7m1Y=;
        b=LCvu4bPHrfpPhAnuYLmjFSnLjVWn/7pDRk6xtqAr3r9TEICu8BOKkQS4kuiAJ68EBv
         ejOLmvzFbyc4Ik0MfLuG10Lql/MzYOWxNOuZiZJ8B/uGR6FWpwMPfTgrEf6zYIgFBfM3
         06HvAATuE8mjG55odY5uhuzfODgJLKxIs/3GP0hcYbytW/o+KdH4IxAw79DeY4YtLFYi
         J1MY0jspakGEE/ePmfWAxuMjgMPHZI9iClFMUgX9UDKfVtGghJvM5nKnpS7QqAAUnUli
         F0Q/pwgr1Rv5DH6/IlpFFGkpiciyK2xniyVqJK6lnexQgEeZ75YWM76oAywmhvQY9lcw
         NwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJeTHuID04+jmTTMvk0BHWGStBWi53xqptLvOwQ7m1Y=;
        b=Nnd6MP4P7pNzvQ5zSL/fSxns/JusoucenpuAVDWRQN711HlC+gmelSPFH9TvZRmCCQ
         VfPFETt1f/p2VTEsSLgwAOhSz+25kQY4oCr3IDjJQqWELVvpzX9HoxP9ZKl1te3AsTJw
         bYP5YSxLyFhwkCc6NaGpnAhMUAk5fRgsUhaLlL+oKd4MOslowSA7DmkUZ01rWwE1jB5p
         l3PKxQVmx1U7yyENhbNkN4ax6N4fc959cyrVjXBH6+8hx4IH6SyTaUSfc4Y6+T8UIkFD
         RQammmt0c740pS14yNMbTAp4Vn+YM5D2NIhtyXMhDnJAcDwFyxMUUftjHbkhCjSl7w0e
         4gIQ==
X-Gm-Message-State: AOAM533NRC+sSjFW3Hy6BCZWOYfd/jOeh/izf8hFFC7bbB1UnrPz7iq6
        MrzyDuyRYcFpmw8iLbZD/AxahjSmI9NrZA==
X-Google-Smtp-Source: ABdhPJyrchBXV2CJFaWNc0EgyakEfxNC7xm9NwIXifdATmlOCDugqAQq+VXjRjOrtpMcxFYxGkwBxg==
X-Received: by 2002:a05:620a:13b0:: with SMTP id m16mr1431664qki.58.1611002193623;
        Mon, 18 Jan 2021 12:36:33 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:626b:1275:5dba:df42])
        by smtp.gmail.com with ESMTPSA id v145sm11837077qka.27.2021.01.18.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 12:36:33 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:36:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 07/17] merge-ort: implement compute_rename_counts()
Message-ID: <YAXxTsnQ0gqQZv75@nand.local>
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com>
 <1e48cde01b9e2fe24eeda063e0298db8421b13a7.1610055365.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e48cde01b9e2fe24eeda063e0298db8421b13a7.1610055365.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 09:35:55PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> This function is based on the first half of get_directory_renames() from
> merge-recursive.c
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 7e0cc597055..a8fcc026031 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -721,7 +721,6 @@ static int handle_content_merge(struct merge_options *opt,
>
>  /*** Function Grouping: functions related to directory rename detection ***/
>
> -MAYBE_UNUSED
>  static void get_renamed_dir_portion(const char *old_path, const char *new_path,
>  				    char **old_dir, char **new_dir)
>  {
> @@ -825,11 +824,61 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
>  	*new_dir = xstrndup(new_path, end_of_new - new_path);
>  }
>
> +static void increment_count(struct strmap *dir_rename_count,
> +			    char *old_dir,
> +			    char *new_dir)
> +{
> +	struct strintmap *counts;
> +	struct strmap_entry *e;
> +
> +	/* Get the {new_dirs -> counts} mapping using old_dir */
> +	e = strmap_get_entry(dir_rename_count, old_dir);
> +	if (e) {
> +		counts = e->value;
> +	} else {
> +		counts = xmalloc(sizeof(*counts));
> +		strintmap_init_with_options(counts, 0, NULL, 1);
> +		strmap_put(dir_rename_count, old_dir, counts);
> +	}
> +
> +	/* Increment the count for new_dir */
> +	strintmap_incr(counts, new_dir, 1);
> +}
> +
>  static void compute_rename_counts(struct diff_queue_struct *pairs,
>  				  struct strmap *dir_rename_count,
>  				  struct strset *dirs_removed)
>  {
> -	die("Not yet implemented!");
> +	int i;
> +
> +	for (i = 0; i < pairs->nr; ++i) {
> +		char *old_dir, *new_dir;
> +		struct diff_filepair *pair = pairs->queue[i];
> +
> +		if (pair->status != 'R')
> +			continue;

This had a useful comment in merge-recursive.c that I think would help
future readers here. Would you consider brining over the comment that
starts with "File not part of directory rename ..." here?

> +		/* Get the old and new directory names */
> +		get_renamed_dir_portion(pair->one->path, pair->two->path,
> +					&old_dir,        &new_dir);

This spacing is a little odd to me, but it does come directly from
merge-recursive.c. I don't feel strongly about it.

> +		if (!old_dir)
> +			/* Directory didn't change at all; ignore this one. */
> +			continue;
> +
> +		/*
> +		 * Make dir_rename_count contain a map of a map:
> +		 *   old_directory -> {new_directory -> count}
> +		 * In other words, for every pair look at the directories for
> +		 * the old filename and the new filename and count how many
> +		 * times that pairing occurs.
> +		 */
> +		if (strset_contains(dirs_removed, old_dir))
> +			increment_count(dir_rename_count, old_dir, new_dir);

Much clearer. If you're rerolling anyway, it may be worth it to say
something about this movement in the patch message: "along the way,
factor out the routine to update the bookkeeping to track the number of
items renamed into new directories".

> +		/* Free resources we don't need anymore */
> +		free(old_dir);
> +		free(new_dir);
> +	}

And obviously this is new, but it makes sense here. Thanks.

Thanks,
Taylor

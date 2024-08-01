Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA2200A3
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474305; cv=none; b=giNJrchS7d/YJ34DXkWfa3nb7y6o9boZtkJwLWlZaWpRXgX7T5SuSO/wlYZ0Ikbsy6UJ+nqvoWuR3WMS0WfLRZsT57WSyuqj59kqJ/LmA/OCvTDJx7GIfbmHa+kWPOLbeledppTd4Z7f1ZApYFkQMYUDDw5nRaMy7A6gORQxaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474305; c=relaxed/simple;
	bh=9ZNjo7rbXavsialLAbiimj/P2yDwVnC1CvbH+hu0m+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgcIBU3z5BfAac0loHOkQJRuoetT9wD+/T8xl2YoJZtIv0bbqVVPSYNmdR5yfWX3qlKsHQjm5SnGaSheJZfxyc0dxQDAcMjrLeTSduON+mn+muzkINXin6ogyVTeNJZMRTYQt+RCFLo3FMioU6gUt+IWqAJscnuZj/L11RxiF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icVbqvNM; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icVbqvNM"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5cbe88f70so3182945eaf.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722474302; x=1723079102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHuoXGQlPIMXwl8XfemWBDNQtHhOOf7XtelDjiTrB20=;
        b=icVbqvNM2QT1/JXp2egYuNhDMNF82aH3/q8R0hDiAxV5wswRwtC0r2SptUayIp8fie
         2nsJ5ghN4Xi/uLAESlQAPOpJq/ZaFW5ARhLRoDIiS8P71eRsh8c3zPpPTSEPBbVHfgWG
         an1z2X70psITgR55UdZzMIF5WASPn/QxCp8L5xXz4T6oaraQvrh6Gm97YYOc4m3RAkTn
         8R830Pu/l+j9dgiF9ur4D38zvvtVsyGsxw7oomaHuQb0yxV87x8o0jKlQGNttPUQXazc
         opKcU8gNw3SQfzvlOgD7RPngTGzikDeHZa2USOqbk4pqqZfCdmm2gtVHG0QpS3bt7NCv
         qk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722474302; x=1723079102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHuoXGQlPIMXwl8XfemWBDNQtHhOOf7XtelDjiTrB20=;
        b=K4UiMp1s8HZ8tJgrS6b37nZxka39+vD9X2AI/bmyTYFcSiUD2K6gzw43jN0t21V4sG
         QkujrePCzG+n2IryEl9QkVxvRWACL6dKs3gnIYnEkPeht2DGFGvp4bVFN9L+ov9gZEMx
         qMlszFtP0z/txpsUppwYnyqegB5CygUq4LTMINMykqe6/tuw7Y3Rjjdm+iD3eFlEMhh0
         R6gDVqMrjhDeoUXpri9MZZhMYcQ42nKxCZjBom7+CWBNqpACVlX5tCb0IhSCo1DqAtNz
         4DJm3S93SgSaaJJ36CdVB4CD4sFIsR8tuJ2ElaLmLc1KFWiDj3fbmw2dfRFGu/nSFA4q
         dgdQ==
X-Gm-Message-State: AOJu0Yxf+DTOFrvrvzy7mPcWIlu+Y2+TS4UpgSirjl8Pp+yXpMZmn3cA
	gjNszIkMMDEqAgsthRjvScV2EBG8TCTX6KLckKSKmG6tq5dTzfl5YR7yt1GG
X-Google-Smtp-Source: AGHT+IHEfspa27DcI3TmAk500n5khRqzH3/9pSGq/iUlQwyBsZmZ6RqtoMaW6YTfNpRRLmDL82vxZQ==
X-Received: by 2002:a05:6871:4411:b0:25e:170b:4470 with SMTP id 586e51a60fabf-2687a78cb9bmr878019fac.50.1722474302211;
        Wed, 31 Jul 2024 18:05:02 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2653e7563b6sm2867277fac.24.2024.07.31.18.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:05:01 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:04:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] reftable/stack: fix corruption on concurrent
 compaction
Message-ID: <bkr4qwpgpzl2nffjuz52te3vwmn3gckoahrkynw2zrqrzptwd6@7b776obncdiy>
References: <cover.1722435214.git.ps@pks.im>
 <b746565bf0ff80fff60821bdeb79867ad646c142.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b746565bf0ff80fff60821bdeb79867ad646c142.1722435214.git.ps@pks.im>

On 24/07/31 04:15PM, Patrick Steinhardt wrote:
> The locking employed by compaction uses the following schema:
> 
>   1. Lock "tables.list" and verify that it matches the version we have
>      loaded in core.
> 
>   2. Lock each of the tables in the user-supplied range of tables that
>      we are supposed to compact. These locks prohibit any concurrent
>      process to compact those tables while we are doing that.
> 
>   3. Unlock "tables.list". This enables concurrent processes to add new
>      tables to the stack, but also allows them to compact tables outside
>      of the range of tables that we have locked.
> 
>   4. Perform the compaction.
> 
>   5. Lock "tables.list" again.
> 
>   6. Move the compacted table into place.
> 
>   7. Write the new order of tables, including the compacted table, into
>      the lockfile.
> 
>   8. Commit the lockfile into place.
> 
> Letting concurrent processes modify the "tables.list" file while we are
> doing the compaction is very much part of the design and thus expected.
> After all, it may take some time to compact tables in the case where we
> are compacting a lot or very large tables.

s/or/of/

> But there is a bug in the code. Suppose we have two processes which are
> compacting two slices of the table. Given that we lock each of the
> tables before compacting them, we know that the slices must be disjunct
> from each other. But regardless of that, compaction performed by one
> process will always impact what the other process needs to write to the
> "tables.list" file.

I'm not quite sure I understand at this point how it is possible for two
compaction operations to be performed concurrently. Wouldn't there
always be overlap between the two compaction segments thus causing one
of the operations to be unable to acquire all of the required locks and
abort?

> Right now , we do not check whether the "tables.list" has been

s/now ,/now,/

> changed after we have locked it for the second time in (5). This has the
> consequence that we will always commit the old, cached in-core tables to
> disk without paying to respect what the other process has written. This
> scenario would then lead to data loss and corruption.

If a concurrent compaction happens though, it would mess up the indices
and cause problems when writting the "tables.list" file. That would not
be good.

> This can even happen in the simpler case of one compacting process and
> one writing process. The newly-appended table by the writing process
> would get discarded by the compacting process because it never sees the
> new table.

This is indeed a problem. Since we don't reload the stack, we are
unaware of any concurrently append tables causing them to not be
written in the new "tables.list" file. Scary

> Fix this bug by re-checking whether our stack is still up to date after
> locking for the second time. If it isn't, then we adjust the indices of
> tables to replace in the updated stack.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/stack.c | 101 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 9cc91a262c..2b1ac58120 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1021,7 +1021,9 @@ static int stack_compact_range(struct reftable_stack *st,
>  	struct lock_file *table_locks = NULL;
>  	struct tempfile *new_table = NULL;
>  	int is_empty_table = 0, err = 0;
> +	size_t first_to_replace, last_to_replace;
>  	size_t i, nlocks = 0;
> +	char **names = NULL;
>  
>  	if (first > last || (!expiry && first == last)) {
>  		err = 0;
> @@ -1124,6 +1126,94 @@ static int stack_compact_range(struct reftable_stack *st,
>  		}
>  	}
>  
> +	/*
> +	 * As we have unlocked the stack while compacting our slice of tables
> +	 * it may have happened that a concurrently running process has updated
> +	 * the stack while we were compacting. In that case, we need to check
> +	 * whether the tables that we have just compacted still exist in the
> +	 * stack in the exact same order as we have compacted them.
> +	 *
> +	 * If they do exist, then it is fine to continue and replace those
> +	 * tables with our compacted version. If they don't, then we need to
> +	 * abort.
> +	 */
> +	err = stack_uptodate(st);
> +	if (err < 0)
> +		goto done;
> +	if (err > 0) {
> +		ssize_t new_offset = -1;
> +		int fd;
> +
> +		fd = open(st->list_file, O_RDONLY);
> +		if (fd < 0) {
> +			err = REFTABLE_IO_ERROR;
> +			goto done;
> +		}
> +
> +		err = fd_read_lines(fd, &names);

Reading `names` here will include all tables that were appended
concurrently which we need to accurately rewrite the new "tables.list".
Makes sense.

> +		close(fd);
> +		if (err < 0)
> +			goto done;
> +
> +		/*
> +		 * Search for the offset of the first table that we have
> +		 * compacted in the updated "tables.list" file.
> +		 */
> +		for (size_t i = 0; names[i]; i++) {
> +			if (strcmp(names[i], st->readers[first]->name))
> +				continue;
> +
> +			/*
> +			 * We have found the first entry. Verify that all the
> +			 * subsequent tables we have compacted still exist in
> +			 * the modified stack in the exact same order as we
> +			 * have compacted them.
> +			 */
> +			for (size_t j = 1; j < last - first + 1; j++) {
> +				const char *old = first + j < st->merged->stack_len ?
> +					st->readers[first + j]->name : NULL;
> +				const char *new = names[i + j];
> +
> +				/*
> +				 * If some entries are missing or in case the tables
> +				 * have changed then we need to bail out. Again, this
> +				 * shouldn't ever happen because we have locked the
> +				 * tables we are compacting.
> +				 */
> +				if (!old || !new || strcmp(old, new)) {
> +					err = REFTABLE_OUTDATED_ERROR;
> +					goto done;
> +				}
> +			}
> +
> +			new_offset = i;
> +			break;
> +		}
> +
> +		/*
> +		 * In case we didn't find our compacted tables in the stack we
> +		 * need to bail out. In theory, this should have never happened
> +		 * because we locked the tables we are compacting.
> +		 */
> +		if (new_offset < 0) {
> +			err = REFTABLE_OUTDATED_ERROR;
> +			goto done;
> +		}
> +
> +		/*
> +		 * We have found the new range that we want to replace, so
> +		 * let's update the range of tables that we want to replace.
> +		 */
> +		last_to_replace = last + (new_offset - first);
> +		first_to_replace = new_offset;
> +	} else {
> +		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);

I was confused at first by the `stack_len` + 1. The extra element is
NULL which tells us there are no more tables to add to the list,
correct? It looks like `fd_read_lines()` also adds an extra element.

> +		for (size_t i = 0; i < st->merged->stack_len; i++)
> +			names[i] = xstrdup(st->readers[i]->name);
> +		last_to_replace = last;
> +		first_to_replace = first;
> +	}
> +
>  	/*
>  	 * If the resulting compacted table is not empty, then we need to move
>  	 * it into place now.
> @@ -1146,12 +1236,12 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * have just written. In case the compacted table became empty we
>  	 * simply skip writing it.
>  	 */
> -	for (i = 0; i < first; i++)
> -		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
> +	for (i = 0; i < first_to_replace; i++)
> +		strbuf_addf(&tables_list_buf, "%s\n", names[i]);
>  	if (!is_empty_table)
>  		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
> -	for (i = last + 1; i < st->merged->stack_len; i++)
> -		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
> +	for (i = last_to_replace + 1; names[i]; i++)
> +		strbuf_addf(&tables_list_buf, "%s\n", names[i]);

The content of names is now up-to-date along with the starting and
ending indices for the segement being compacted. This allows to to omit
the correct segment of tables.
>  
>  	err = write_in_full(get_lock_file_fd(&tables_list_lock),
>  			    tables_list_buf.buf, tables_list_buf.len);
> @@ -1204,9 +1294,10 @@ static int stack_compact_range(struct reftable_stack *st,
>  	delete_tempfile(&new_table);
>  	strbuf_release(&new_table_name);
>  	strbuf_release(&new_table_path);
> -
>  	strbuf_release(&tables_list_buf);
>  	strbuf_release(&table_name);
> +	free_names(names);
> +
>  	return err;
>  }
>  
> -- 
> 2.46.0.dirty
> 



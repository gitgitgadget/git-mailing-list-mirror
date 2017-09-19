Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52952047F
	for <e@80x24.org>; Tue, 19 Sep 2017 17:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdISRwo (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 13:52:44 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:50664 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdISRwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 13:52:43 -0400
Received: by mail-pf0-f173.google.com with SMTP id m63so190504pfk.7
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HGoVzyXBi2dkG8FR3NGbATatQ3m1330yMCnY9U/n5cQ=;
        b=PdFmg/XVZzHLfUOAVUZVuhGJbRpgSx4ATRr87m2OyokRBgnjH/x6iX/7gs60as36o8
         6wGdf5Jv97DF8exyErf1GOtEGqUPNa5jOdLLh2fdOaJAUJnfg5NXFshFjP6QwEGdFE37
         6a30JzprCMiGIgTR3mA1wOzLKwfw+DWvH97emyJiWTG0nIfilCsMsB25SlsVKuuTePEv
         iy0r8FrvkJE2O/k3JPyodFxBjDrZVIm2Qq9yDlVoXSUZ3V93cQUWCE8TQs3W1sNdnwsg
         Uf2LScYOTBZGHaayQVzUEgR0TVdsvFGwW4nGMPCAr26xesVazQyan12lma87agFsaSS2
         NouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HGoVzyXBi2dkG8FR3NGbATatQ3m1330yMCnY9U/n5cQ=;
        b=jjAGo80a9MZgnh1Hd3dZzofSRQTHAvxqWkLamvQWJsLoqop2t9K1u9H3bWzUu1gChV
         Vdu0KuDLOgIstsxLHUci5NKkcv+HhhxI8KDOzra22ZVNRnQKYVoUN8zN8KCCSfZWIg8O
         7h2sg6cqjB9y4s6oiY03dsMocjQIee0TlE+Kzid7X9A5QrqIVoSnzcwnRGxG9pu4bzM/
         kqi9O1QWyaVTC4VyTRLW5u+pcSmHK4f93optcfaSGGjJAa1g3mEbqEbtwEiPzhBYrYIJ
         YSggYXrpLVjBl+ntofUOM0De0xweqSSEtaoAyppvdhQ1yJW4ttZFLQRXO+JiMCWF1bnA
         Mmyw==
X-Gm-Message-State: AHPjjUivwzsEzaTJdO7RW8ZiLWQmQsRhp5bgscYzQHl2xR9I+sgncHIK
        abrwuXsv1iEPmsGzafmz9NkGrw==
X-Google-Smtp-Source: AOwi7QD+dB4mfwYxvqMH4jH12hFETkwEo+7H3LXxHLrE5ta3tavSaAS8nOCzeDLjbMkF9R2A58qvyA==
X-Received: by 10.84.173.4 with SMTP id o4mr2056636plb.150.1505843562586;
        Tue, 19 Sep 2017 10:52:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b56e:8c34:dd0d:1070])
        by smtp.gmail.com with ESMTPSA id c2sm4857197pgq.61.2017.09.19.10.52.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 10:52:41 -0700 (PDT)
Date:   Tue, 19 Sep 2017 10:52:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jamill@microsoft.com,
        peff@peff.net, sxlijin@gmail.com
Subject: Re: [PATCH v2] Improve performance of git status --ignored
Message-ID: <20170919175240.GA94704@google.com>
References: <20170810184936.239542-1-jamill@microsoft.com>
 <1505755473-6720-1-git-send-email-jamill@microsoft.com>
 <1505755473-6720-2-git-send-email-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505755473-6720-2-git-send-email-jamill@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/18, Jameson Miller wrote:
> Improve the performance of the directory listing logic when it wants to list
> non-empty ignored directories. In order to show non-empty ignored directories,
> the existing logic will recursively iterate through all contents of an ignored
> directory. This change introduces the optimization to stop iterating through
> the contents once it finds the first file. This can have a significant
> improvement in 'git status --ignored' performance in repositories with a large
> number of files in ignored directories.
> 
> For an example of the performance difference on an example repository with
> 196,000 files in 400 ignored directories:
> 
> | Command                    |  Time (s) |
> | -------------------------- | --------- |
> | git status                 |   1.2     |
> | git status --ignored (old) |   3.9     |
> | git status --ignored (new) |   1.4     |
> 
> Signed-off-by: Jameson Miller <jamill@microsoft.com>

Everything looks good to me.  My only nit (and no need to change it for
this patch) is that the first line of the commit msg usually has the
form:

  <area>: <short summary>

So that its easy to tell which part of the code a commit is changing.

Seriously, great patch.  Thanks!

> ---
>  dir.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 1c55dc3..1d17b80 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -49,7 +49,7 @@ struct cached_dir {
>  static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  	struct index_state *istate, const char *path, int len,
>  	struct untracked_cache_dir *untracked,
> -	int check_only, const struct pathspec *pathspec);
> +	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
>  static int get_dtype(struct dirent *de, struct index_state *istate,
>  		     const char *path, int len);
>  
> @@ -1404,8 +1404,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  
>  	untracked = lookup_untracked(dir->untracked, untracked,
>  				     dirname + baselen, len - baselen);
> +
> +	/*
> +	 * If this is an excluded directory, then we only need to check if
> +	 * the directory contains any files.
> +	 */
>  	return read_directory_recursive(dir, istate, dirname, len,
> -					untracked, 1, pathspec);
> +					untracked, 1, exclude, pathspec);
>  }
>  
>  /*
> @@ -1633,7 +1638,7 @@ static enum path_treatment treat_path_fast(struct dir_struct *dir,
>  		 * with check_only set.
>  		 */
>  		return read_directory_recursive(dir, istate, path->buf, path->len,
> -						cdir->ucd, 1, pathspec);
> +						cdir->ucd, 1, 0, pathspec);
>  	/*
>  	 * We get path_recurse in the first run when
>  	 * directory_exists_in_index() returns index_nonexistent. We
> @@ -1793,12 +1798,20 @@ static void close_cached_dir(struct cached_dir *cdir)
>   * Also, we ignore the name ".git" (even if it is not a directory).
>   * That likely will not change.
>   *
> + * If 'stop_at_first_file' is specified, 'path_excluded' is returned
> + * to signal that a file was found. This is the least significant value that
> + * indicates that a file was encountered that does not depend on the order of
> + * whether an untracked or exluded path was encountered first.
> + *
>   * Returns the most significant path_treatment value encountered in the scan.
> + * If 'stop_at_first_file' is specified, `path_excluded` is the most
> + * significant path_treatment value that will be returned.
>   */
> +
>  static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  	struct index_state *istate, const char *base, int baselen,
>  	struct untracked_cache_dir *untracked, int check_only,
> -	const struct pathspec *pathspec)
> +	int stop_at_first_file, const struct pathspec *pathspec)
>  {
>  	struct cached_dir cdir;
>  	enum path_treatment state, subdir_state, dir_state = path_none;
> @@ -1832,12 +1845,34 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
>  			subdir_state =
>  				read_directory_recursive(dir, istate, path.buf,
>  							 path.len, ud,
> -							 check_only, pathspec);
> +							 check_only, stop_at_first_file, pathspec);
>  			if (subdir_state > dir_state)
>  				dir_state = subdir_state;
>  		}
>  
>  		if (check_only) {
> +			if (stop_at_first_file) {
> +				/*
> +				 * If stopping at first file, then
> +				 * signal that a file was found by
> +				 * returning `path_excluded`. This is
> +				 * to return a consistent value
> +				 * regardless of whether an ignored or
> +				 * excluded file happened to be
> +				 * encountered 1st.
> +				 *
> +				 * In current usage, the
> +				 * `stop_at_first_file` is passed when
> +				 * an ancestor directory has matched
> +				 * an exclude pattern, so any found
> +				 * files will be excluded.
> +				 */
> +				if (dir_state >= path_excluded) {
> +					dir_state = path_excluded;
> +					break;
> +				}
> +			}
> +
>  			/* abort early if maximum state has been reached */
>  			if (dir_state == path_untracked) {
>  				if (cdir.fdir)
> @@ -2108,7 +2143,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  		 */
>  		dir->untracked = NULL;
>  	if (!len || treat_leading_path(dir, istate, path, len, pathspec))
> -		read_directory_recursive(dir, istate, path, len, untracked, 0, pathspec);
> +		read_directory_recursive(dir, istate, path, len, untracked, 0, 0, pathspec);
>  	QSORT(dir->entries, dir->nr, cmp_dir_entry);
>  	QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
>  
> -- 
> 2.7.4
> 

-- 
Brandon Williams

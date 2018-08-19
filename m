Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DAD31F954
	for <e@80x24.org>; Sun, 19 Aug 2018 08:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeHSLu5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 07:50:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32861 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeHSLu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 07:50:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so7295460wrc.0
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAA2UhVLm6trO3fgVojX6wgO+IhXp6XsRWgggVVH+9o=;
        b=fzvpK1d7IBsJskquXjg9glTuehrLN5mFOr+WGLV4/XYTPICZRoQWlZwwofKtWHhz6B
         Vnp8Q9lww8q4eLr10Yz8v7+IZjpFo23KsxBRzYsdWc0xTa/+Vi1od3z3ZM5k1K6+YG3m
         Tt3pFHBxC15zlw3WeCUopSAsVISR0HgQLIeejjc26ZMsY6MLCQZAsby9h6G3OZAW1Otv
         RTPtP9Jehoj7XqgaE75AU3rvpG9Wi1jElih4NFfkCHenU3naT474//FsZmmFricg/OCo
         KRlQrpUc7m/QVZ4tTjhfU2X2vWmcmqCdPk8bD5gt38Ydkqors5OoriASqzJ9CusoyCG+
         2m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAA2UhVLm6trO3fgVojX6wgO+IhXp6XsRWgggVVH+9o=;
        b=bsVC4V6ae6kTO7bPfk6bqIxx+szAaVYqIKJbdL+atElx0xnVBk27eM9uAuwLylUjwp
         SxjSbFj/c1STguHAguy+0YOHlzf1+pkPRsCAqJLeFwatLrR9biRCGbHOyPkcK9EKc2Qg
         8+ziK9Bqux6DEoC1sewj0SjYgOQy8zqa0R/PKwOBiPpTnDTZdBokYdBpd/Iv07/1j6mI
         a/Y0XyHleNIMmINcqsJov9rL6UY/GJYCZ+3I4qvnCCLU/n13T/tPlIbXG1uZvxS+uKer
         1yF19N/UcfA8va1xURWRI0bPjWwTNrYpqObzBhbPatlvLx6z2kJZGI6JGpJYYN1QYsUO
         Rv1A==
X-Gm-Message-State: AOUpUlE7PICcKltZ4jv+iARIkIFbLUSeVMeq0ovoYK8VNFb5Ozt9Ijvd
        QHAlkr447hhPcd9sc6m9p4E=
X-Google-Smtp-Source: AA+uWPwCnmj5Y4lL2Fy8xOEqQg54PgmfFE/XMu27J5tGaqvLmDXUWi+W+J8He0VcAt0TM2zbqo/f/A==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr26411770wrv.102.1534668011196;
        Sun, 19 Aug 2018 01:40:11 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 185-v6sm11546367wmy.38.2018.08.19.01.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Aug 2018 01:40:10 -0700 (PDT)
Date:   Sun, 19 Aug 2018 09:40:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 26/26] stash: replace all "git apply" child
 processes with API calls
Message-ID: <20180819084009.GF13316@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <56500d98f9d5daaa5f21a43767885baede86e3a0.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56500d98f9d5daaa5f21a43767885baede86e3a0.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> `apply_all_patches()` does not provide a method to apply patches
> from strbuf. Because of this, this commit introduces a new
> function `apply_patch_from_buf()` which applies a patch from buf.
> It works by saving the strbuf as a file. This way we can call
> `apply_all_patches()`. Before returning, the created file is
> removed.

I'm not a fan of this approach.  We're going from doing the operation
in memory to using a temporary file that we write to disk and have to
re-read afterwards, which I suspect might be slower than using the
'run-command' API.

From a quick look the 'apply_patch' function almost does what we want.
It reads the patch file, and then does everything else in memory.  It
seems to me that by factoring out reading the patch file from that
function, we should be able to use the rest to do the operation
in-memory here, which would be much nicer.

> ---
>  builtin/stash.c | 61 +++++++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 46e76a34e..74eda822c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -13,6 +13,7 @@
>  #include "revision.h"
>  #include "log-tree.h"
>  #include "diffcore.h"
> +#include "apply.h"
>  
>  static const char * const git_stash_usage[] = {
>  	N_("git stash list [<options>]"),
> @@ -277,10 +278,6 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	const char *w_commit_hex = oid_to_hex(w_commit);
>  
> -	/*
> -	 * Diff-tree would not be very hard to replace with a native function,
> -	 * however it should be done together with apply_cached.
> -	 */

Hmm there was probably a good reason why we wrote this comment in the
first place.  I can't recall what that reason was, but we should
probably explore that.  If there was no reason for it, then we should
remove the comment where it was added in the series (since this is all
new code the comment comes from somewhere else in this series).

>  	cp.git_cmd = 1;
>  	argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
>  	argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
> @@ -288,18 +285,36 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
>  	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
>  }
>  
> -static int apply_cached(struct strbuf *out)
> +static int apply_patch_from_buf(struct strbuf *patch, int cached, int reverse,
> +				int check_index)
>  {
> -	struct child_process cp = CHILD_PROCESS_INIT;
> +	int ret = 0;
> +	struct apply_state state;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	const char *patch_path = ".git/stash_patch.patch";

We should not rely on '.git/' here.  This will not work if 'GIT_DIR'
is set, or even in a worktree, where '.git' is just a file, not a
directory.

> +	FILE *patch_file;
>  
> -	/*
> -	 * Apply currently only reads either from stdin or a file, thus
> -	 * apply_all_patches would have to be updated to optionally take a
> -	 * buffer.
> -	 */

Ah and indeed the comment here is suggesting a very similar thing to
what I suggested above :)

> -	cp.git_cmd = 1;
> -	argv_array_pushl(&cp.args, "apply", "--cached", NULL);
> -	return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
> +	if (init_apply_state(&state, NULL))
> +		return -1;
> +
> +	state.cached = cached;
> +	state.apply_in_reverse = reverse;
> +	state.check_index = check_index;
> +	if (state.cached)
> +		state.check_index = 1;
> +	if (state.check_index)
> +		state.unsafe_paths = 0;
> +
> +	patch_file = fopen(patch_path, "w");
> +	strbuf_write(patch, patch_file);
> +	fclose(patch_file);
> +
> +	argv_array_push(&args, patch_path);
> +	ret = apply_all_patches(&state, args.argc, args.argv, 0);
> +
> +	remove_path(patch_path);
> +	clear_apply_state(&state);
> +	return ret;
>  }
>  
>  static int reset_head(const char *prefix)
> @@ -418,7 +433,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  				return -1;
>  			}
>  
> -			ret = apply_cached(&out);
> +			ret = apply_patch_from_buf(&out, 1, 0, 0);
>  			strbuf_release(&out);
>  			if (ret)
>  				return -1;
> @@ -1341,7 +1356,6 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
>  			int i;
>  			struct child_process cp1 = CHILD_PROCESS_INIT;
>  			struct child_process cp2 = CHILD_PROCESS_INIT;
> -			struct child_process cp3 = CHILD_PROCESS_INIT;
>  			struct strbuf out = STRBUF_INIT;
>  
>  			cp1.git_cmd = 1;
> @@ -1365,11 +1379,9 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
>  			if (pipe_command(&cp2, NULL, 0, &out, 0, NULL, 0))
>  				return -1;
>  
> -			cp3.git_cmd = 1;
> -			argv_array_pushl(&cp3.args, "apply", "--index", "-R",
> -					 NULL);
> -			if (pipe_command(&cp3, out.buf, out.len, NULL, 0, NULL,
> -					 0))
> +			discard_cache();
> +			read_cache();
> +			if (apply_patch_from_buf(&out, 0, 1, 1))
>  				return -1;
>  		} else {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> @@ -1405,12 +1417,7 @@ static int do_push_stash(int argc, const char **argv, const char *prefix,
>  				return -1;
>  		}
>  	} else {
> -		struct child_process cp = CHILD_PROCESS_INIT;
> -
> -		cp.git_cmd = 1;
> -		argv_array_pushl(&cp.args, "apply", "-R", NULL);
> -
> -		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
> +		if (apply_patch_from_buf(&patch, 0, 1, 0)) {
>  			if (!quiet)
>  				fprintf_ln(stderr, "Cannot remove worktree changes");
>  			return -1;
> -- 
> 2.18.0.573.g56500d98f
> 

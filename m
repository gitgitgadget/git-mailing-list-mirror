Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F06C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 23:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiHHXla (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 19:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiHHXl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 19:41:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0618E04
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 16:41:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 73so9936275pgb.9
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rupaWgWqKyGgKP8D6/iHqdp+YuuBeFaioRB00HgCjos=;
        b=hAs0F7BvIyPwhWCq8zxPvrwpDaDcWNLyZVuEDV8AZM0WjptjaXtDcndZ3Zsw+SKnrF
         WAGyb8yOmUAUoSeb3qP3RVgJpTK2fBKZjjzbetKkqDGZTrt2VRR0e1ZzooSNvdOw+6CY
         /L0iCV9sYLXJpy/OZ9pDGEiroIaMgEDm6Vi8nZvmtEgswp6paffptathXBr9Q/kufoiA
         9WKtMlT7gsiDlraPsusmHTTWKsBKjpJMIpzis+WgU9rWqtJEbr2HVkOHDp44AaeRx13J
         /1hVg4lxoy1JI5sgpuTNzrmG30Xr8vXsHb8TXn0f7B3iA8x5Pq85mZH3/RlO88InvboL
         nwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rupaWgWqKyGgKP8D6/iHqdp+YuuBeFaioRB00HgCjos=;
        b=Hv9DUXnOZSioKvTs2m3QzreHJ9WMxp2s4SbJ9vYVXYC5ezPNKjUjVbvIHp7i1WXAk2
         0dNhqWow+yNAToBe7veyhS5CMLlpprLwWyPStJfQVnHagJYZdfdRPq2dOsQFam1MyBgC
         aBk46ipAtuKDuD8nJPB3Dm+4l4m+LMLu3TKUpRIHo/FmO93CtABymnPUjvBmdCSrelid
         T9Knv6hYy6QkHfX+yY/vnusAnN5CaISDOzp8E9b5r9vq+n6je7kiKKYNp0CJDaM8xw/9
         Acuy3nJ5rQcdDEVidjhTsWbauBb0yP8s/T9rCRexNANRbS6E14GP60bQ7wxdzP5hsoeO
         aIig==
X-Gm-Message-State: ACgBeo0LMIjfxilP1gEm1rSHxVh5wdfBqHe1DE8cYfpPJcUN84W/Cd79
        nOM6whW7Un8yS4p9o0luXdyd
X-Google-Smtp-Source: AA6agR7fiY6NOU8yrtpAVsUdGcaUKyzACPzy9EQahyEKEOiiL/TgYKOt8l3Im768iE9U2t2PlFJYBA==
X-Received: by 2002:a63:2041:0:b0:41a:8b08:88e0 with SMTP id r1-20020a632041000000b0041a8b0888e0mr17140483pgm.324.1660002087957;
        Mon, 08 Aug 2022 16:41:27 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id g26-20020aa796ba000000b0052d9c4a7f77sm3177316pfk.34.2022.08.08.16.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 16:41:27 -0700 (PDT)
Message-ID: <698b86d0-c906-9a9a-839e-71806ae41f2c@github.com>
Date:   Mon, 8 Aug 2022 16:41:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/9] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-5-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220805030528.1535376-5-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, <destination> is assumed to be in the working tree. If it is
> not found as a directory, then it is determined to be either a regular file
> path, or error out if used under the second form (move into a directory)
> of 'git-mv'. Such behavior is not ideal, mainly because Git does not
> look into the index for <destination>, which could potentially be a
> SKIP_WORKTREE_DIR, which we need to determine for the later "moving from
> in-cone to out-of-cone" patch.
> 
> Change the logic so that Git first check if <destination> is a directory
> with all its contents sparsified (a SKIP_WORKTREE_DIR).
> 
> If <destination> is such a sparse directory, then we should modify the
> index the same way as we would if this were a non-sparse directory. We
> must be careful to ensure that the <destination> is marked with
> SKIP_WORKTREE_DIR.
> 
> Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
> was everywhere and can be simplified.

This all makes sense. Stepping through the code...

> 
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  builtin/mv.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 0a999640c9..f213a92bf6 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -171,6 +171,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
> +	const char *dst_w_slash;
>  	enum update_mode *modes;
>  	struct stat st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
> @@ -201,6 +202,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
>  		flags = 0;
>  	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
> +	dst_w_slash = add_slash(dest_path[0]);

...you pre-compute a reusable 'dst_w_slash' here...

>  	submodule_gitfile = xcalloc(argc, sizeof(char *));
>  
>  	if (dest_path[0][0] == '\0')
> @@ -208,12 +210,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>  	else if (!lstat(dest_path[0], &st) &&
>  			S_ISDIR(st.st_mode)) {
> -		dest_path[0] = add_slash(dest_path[0]);
> -		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> +		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);

...then remove the in-place 'add_slash()' of 'dest_path[0]' and use
'dst_w_slash' in 'internal_prefix_pathspec()'. Makes sense.

>  	} else {

Then, this block is reached if 'dest_path' is not '.' and it is not a
directory that exists on disk.

Previously, reaching this point meant that 'dest_path' *must* refer to a
file, not a directory. However, you want to add handling for the case where
'dst_w_slash' doesn't exist on disk because all of its contents are sparse:

> -		if (argc != 1)
> +		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
> +		    empty_dir_has_sparse_contents(dst_w_slash)) {
> +			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);

so the above condition identifies whether 'dest_path[0]' is non-empty in the
index, and sets 'destination' accordingly. 

It took me some time to understand what all of these (nested) conditions are
doing; one suggestion I have (feel free to ignore it, since it's really just
a matter of stylistic preference) is reduce some duplicate code/simplify the
change a bit by moving the sparse directory check into the main "if-else"
block:

------------->8------------->8------------->8------------->8------------->8-------------
diff --git a/builtin/mv.c b/builtin/mv.c
index 4729bb1a1a..1c1b9559f6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -203,10 +203,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
 		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
-	else if (!lstat(dest_path[0], &st) &&
-			S_ISDIR(st.st_mode)) {
-		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+	else if ((!lstat(dest_path[0], &st) && S_ISDIR(st.st_mode)) ||
+		 (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
+		  empty_dir_has_sparse_contents(dst_w_slash))) {
+		/* directory dest_path[0] exists on-disk or in the index */
+		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die(_("destination '%s' is not a directory"), dest_path[0]);

-------------8<-------------8<-------------8<-------------8<-------------8<-------------

It doesn't make for the prettiest condition (so your current approach might
be better in terms of readability) but, to me, it creates a clearer
distinction between the "if" and "else if" blocks (which handle the case
where 'dest_path[0]' is a directory), and the "else" block (which handles
the case where 'dest_path[0]' is a file).

> +		} else if (argc != 1) {
>  			die(_("destination '%s' is not a directory"), dest_path[0]);
> -		destination = dest_path;
> +		} else {
> +			destination = dest_path;
> +		}
> +	}
> +	if (dst_w_slash != dest_path[0]) {
> +		free((char *)dst_w_slash);
> +		dst_w_slash = NULL;

Looks good.

>  	}
>  
>  	/* Checking */


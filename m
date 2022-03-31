Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1040CC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiCaVaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiCaVaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 17:30:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A474AE01
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:28:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so3893093pjb.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8W2WerQkp59Cmn5EsW5ValsSDUHGuE4nJuf1AuWDv24=;
        b=Idkko5FW9rybys9Uchgmn1iSC0RTl4oLxWiNIA8mEviZZMaKMyJRtey/F9xf/OOxOm
         JkgXF25E3RBEknYFIHFZikoL1fZn7pxkSVd29RU0Q0XuEQE26pWP8spOJ7o1quFYSmmk
         kDbZTsVfLEbOPnT/UAvlUj6ZkhJEtScgvZPiMG2u6EUPrjVpx6kwUDkVovHDUgR1zgGL
         K5orIvE85Wiy/yDSY/q/gZ9sZQ2Y93F820fy3T0PyqxUsxcLAJDRAMgJY7iF+Qxa32Uv
         QCtABoHgXdfxGLSSU6J0YcFhChtRz7TR1li2LKdALuny2N1NFrXgIUM9cDyAl5XvnOQD
         AQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8W2WerQkp59Cmn5EsW5ValsSDUHGuE4nJuf1AuWDv24=;
        b=m+9bPmkID7HfXEMAtsD0vdfCXJcGNLCRKbJK7WQ1D7nXSz1pjWkwMKRTZJqtxGp78B
         8Ve4qN8+m3CHnA5zRPXJm9+aIeaNthCmAHCL6tcc+56xuYdTayUjTwef8gsGb1WkYJcD
         Tl9BsBRKtPvDNnkICj7W8PQRKG3moCfsR/aLtG9+ZYgOvzMx/Bn8kiMMg9arnbH5CqHU
         cCFEW+ChDopD4/P/SYJmCnWY9KjS8TIIMRRlMU7lxfxWefTFHIgwJcym27Uiv/Hw+WuS
         7xTYMB7+0GC6Yewf7x3meWGwO4Zypg2n0BaokEiXsFI+07aeRVmhc/kBifbgXTrAwt1O
         keUA==
X-Gm-Message-State: AOAM531qxCrJh3Dnw+YGLEUDPSiR1go/SdX1L61cwKF/JbZoJJWmdsjN
        tR5VNocl5pfUv6aXX6CQZ+Nk
X-Google-Smtp-Source: ABdhPJwYwQo7DJBgMd9rmiRbNMy5zFxyjtv2AXEnNHy/jMJcT+lgVBdHbRuz1RsIbzuPnokF7Zkzzg==
X-Received: by 2002:a17:902:b782:b0:153:e0dc:755e with SMTP id e2-20020a170902b78200b00153e0dc755emr7266201pls.1.1648762098909;
        Thu, 31 Mar 2022 14:28:18 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id y16-20020a63b510000000b00398d8b19bbfsm278947pge.23.2022.03.31.14.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:28:18 -0700 (PDT)
Message-ID: <52784078-c748-a4a0-68b4-db3c133dfa80@github.com>
Date:   Thu, 31 Mar 2022 14:28:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [WIP v1 2/4] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220331091755.385961-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Originally, moving a <source> directory which is not on-disk due
> to its existence outside of sparse-checkout cone, "giv mv" command
> errors out with "bad source".
> 
> Add a helper check_dir_in_index() function to see if a directory
> name exists in the index. Also add a SPARSE_DIRECTORY bit to mark
> such directories.
> 

Hmm, I think this patch would fit better in your eventual "sparse index
integration" series than this "prerequisite fixes to sparse-checkout"
series. Sparse directories *only* appear when you're using a sparse index
so, theoretically, this shouldn't ever come up (and thus isn't testable)
until you're using a sparse index. 

Since it's here, though, I'm happy to review what you have (even if you
eventually move it to a later series)!

> Change the checking logic, so that such <source> directory makes
> "giv mv" command warns with "advise_on_updating_sparse_paths()"
> instead of "bad source"; also user now can supply a "--sparse" flag so
> this operation can be carried out successfully.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> Since I'm so new to C language (not an acquaintance until this patch), 
> the "check_dir_in_index()" function I added might not be ideal (in terms of 
> safety and correctness?). I have digging into the APIs provided in the codebase 
> but I haven't found anything to do this very job: find out if a directory is 
> in the index (am I missing something?). 
> Probably because contents are stored in the index as blobs and 
> they all represent regular files. So I came up with this dull solution...
> 
>  builtin/mv.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 32ad4d5682..9da9205e01 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -115,6 +115,25 @@ static int index_range_of_same_dir(const char *src, int length,
>  	return last - first;
>  }
>  
> +static int check_dir_in_index(const char *dir)
> +{

This function can be made a lot simpler - you can use `cache_name_pos()` to
find the index entry - if it's found, the directory exists as a sparse
directory. And, because 'add_slash()' enforces the trailing slash later on,
you don't need to worry about adjusting the name before you look for the
entry.

> +	int ret = 0;
> +	int length = sizeof(dir) + 1;
> +	char *substr = malloc(length);
> +
> +	for (int i = 0; i < the_index.cache_nr; i++) {
> +		memcpy(substr, the_index.cache[i]->name, length);
> +		memset(substr + length - 1, 0, 1);
> +
> +		if (strcmp(dir, substr) == 0) {
> +			ret = 1;
> +			return ret;
> +		}
> +	}
> +	free(substr);
> +	return ret;
> +}
> +
>  int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>  	int i, flags, gitmodules_modified = 0;
> @@ -129,7 +148,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
> -	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE } *modes;
> +	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX, SPARSE,
> +	SPARSE_DIRECTORY } *modes;
>  	struct stat st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>  	struct lock_file lock_file = LOCK_INIT;
> @@ -197,6 +217,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			 */
>  
>  			int pos = cache_name_pos(src, length);
> +			const char *src_w_slash = add_slash(src);
> +
>  			if (pos >= 0) {
>  				const struct cache_entry *ce = active_cache[pos];
>  
> @@ -209,6 +231,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				else
>  					bad = _("bad source");
>  			}
> +			else if (check_dir_in_index(src_w_slash) &&
> +			!path_in_sparse_checkout(src_w_slash, &the_index)) {
> +				modes[i] = SPARSE_DIRECTORY;
> +				goto dir_check;
> +			}

In if-statements like this, you'll want to line up the statements in
parentheses on subsequent lines, like:

	else if (check_dir_in_index(src_w_slash) &&
		 !path_in_sparse_checkout(src_w_slash, &the_index)) {

...where the second line is indented 1 (8-space-sized) tab + 1 space. 

In general, if you're trying to align code (in this repository), align first
with as many tabs as possible, then the "remainder" with spaces. Note that
this isn't 100% consistent throughout the repository - older lines might not
have been aligned properly - but you should go for this styling on any new
lines that you add.

>  			/* only error if existence is expected. */
>  			else if (modes[i] != SPARSE)
>  				bad = _("bad source");
> @@ -219,7 +246,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				&& lstat(dst, &st) == 0)
>  			bad = _("cannot move directory over file");
>  		else if (src_is_dir) {
> -			int first = cache_name_pos(src, length), last;
> +			int first, last;
> +dir_check:
> +			first = cache_name_pos(src, length);
>  
>  			if (first >= 0)
>  				prepare_move_submodule(src, first,
> @@ -230,7 +259,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			else { /* last - first >= 1 */
>  				int j, dst_len, n;
>  
> -				modes[i] = WORKING_DIRECTORY;
> +				if (!modes[i])
> +					modes[i] = WORKING_DIRECTORY;
>  				n = argc + last - first;
>  				REALLOC_ARRAY(source, n);
>  				REALLOC_ARRAY(destination, n);
> @@ -332,7 +362,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			printf(_("Renaming %s to %s\n"), src, dst);
>  		if (show_only)
>  			continue;
> -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
> +		if (mode != INDEX && mode != SPARSE && mode != SPARSE_DIRECTORY &&
> +		 rename(src, dst) < 0) {
>  			if (ignore_errors)
>  				continue;
>  			die_errno(_("renaming '%s' failed"), src);
> @@ -346,7 +377,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  							      1);
>  		}
>  
> -		if (mode == WORKING_DIRECTORY)
> +		if (mode == WORKING_DIRECTORY || mode == SPARSE_DIRECTORY)

I'm a bit confused - doesn't this mean the sparse dir move will be skipped?
In your commit description, you mention that this 'mv' succeeds with the
'--sparse' option, but I don't see any place where the sparse directory
would be moved. 

>  			continue;
>  
>  		pos = cache_name_pos(src, strlen(src));


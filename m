Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43CC00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiHIAXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHIAXs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:23:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3A19C29
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:23:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g12so9471329pfb.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dG38GJAqN7Ah174TWzfnPUJlTs8AbbxeHIEzZ+5BlFE=;
        b=UBTB0jOBN3CNtIZA9FJ86PdcBorj7XE9Cc6nOErKDSwZqIS/To/uqvtNhztJ8DjH/V
         egrsNSy7Gh+exPGjDWhAmbpN9NEoBrt9IWihk6DjaTY+p8j5IfeIm3lnHia5vQ6+9swn
         92kdidqtS6alcrttyrO/Xe8Me7kPuMKVvBwvmjWmd8NHAM7qGkYucsSZMFss5miJHM1t
         ZqsMzyrXm2Y555Zzhy6P+Vk58zRIjInfVQywEZkFsld70ehuaHXpkzcHrID+vX6sniTl
         q4JFqRx5jk3iMv1euf+SPpN7+VKmgbWsbAvV50YnaJ0PvS7hGo28fzLu6vEEIbGzRtIB
         RyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dG38GJAqN7Ah174TWzfnPUJlTs8AbbxeHIEzZ+5BlFE=;
        b=mvhD4l8Y+ASpWEde3GS2bLrBAbF2pP26wn3Mmmv6c6bMPAHN82iKyp0Hwwu1RLwFrb
         XXhRZ2RtkY1WCP3O/mmNByKHbgbVopWbyrNjkZYdmZ4XwfzYo00QhM0zbpJ+CrGwOS43
         l0OSHzVmbBraWgVVBFbGEDDuLE2uSJ5fbC60i7b5xbc+ukuu5elVbwqe54Qwe5aRA6cg
         ATpsgrJZ4E3HmFp2wJJPCeHZBiwc/f1skk41DlglmbjrSyYIUMe673aSpESyoBKiC+n8
         3Xde31GQk+cKYkOXBb/TAHiYm6QS3o9Ps65SuKHHPRsFdVKlQ4jEXnDframQ2k6gl4o7
         Zihw==
X-Gm-Message-State: ACgBeo1+kWPkv72ci2cMKL0MxIe7CBxJYlKNp6G6on77UcRZhBVCxl1C
        XL8MZS3o+IG8s0o7XSY+cYx7
X-Google-Smtp-Source: AA6agR7Tpx7UkHhRhB+nIBTfWSn4RZCGr7Qa8kGdXYiRBOfbk1bSvaV4dHiDrHLIu3P2/l9ucM4gqQ==
X-Received: by 2002:a63:565c:0:b0:41d:17e1:32f with SMTP id g28-20020a63565c000000b0041d17e1032fmr12817452pgm.445.1660004627205;
        Mon, 08 Aug 2022 17:23:47 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7983d000000b0052ab602a7d0sm9303363pfl.100.2022.08.08.17.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 17:23:45 -0700 (PDT)
Message-ID: <cb6e6a7b-f5a5-eadb-3de0-a98737932ea8@github.com>
Date:   Mon, 8 Aug 2022 17:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v2 4/9] mv: check if <destination> is a SKIP_WORKTREE_DIR
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-5-shaoxuan.yuan02@gmail.com>
 <698b86d0-c906-9a9a-839e-71806ae41f2c@github.com>
In-Reply-To: <698b86d0-c906-9a9a-839e-71806ae41f2c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> Originally, <destination> is assumed to be in the working tree. If it is
>> not found as a directory, then it is determined to be either a regular file
>> path, or error out if used under the second form (move into a directory)
>> of 'git-mv'. Such behavior is not ideal, mainly because Git does not
>> look into the index for <destination>, which could potentially be a
>> SKIP_WORKTREE_DIR, which we need to determine for the later "moving from
>> in-cone to out-of-cone" patch.
>>
>> Change the logic so that Git first check if <destination> is a directory
>> with all its contents sparsified (a SKIP_WORKTREE_DIR).
>>
>> If <destination> is such a sparse directory, then we should modify the
>> index the same way as we would if this were a non-sparse directory. We
>> must be careful to ensure that the <destination> is marked with
>> SKIP_WORKTREE_DIR.
>>
>> Also add a `dst_w_slash` to reuse the result from `add_slash()`, which
>> was everywhere and can be simplified.
> 
> This all makes sense. Stepping through the code...
> 
>>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>> Helped-by: Victoria Dye <vdye@github.com>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>  builtin/mv.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 0a999640c9..f213a92bf6 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -171,6 +171,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  		OPT_END(),
>>  	};
>>  	const char **source, **destination, **dest_path, **submodule_gitfile;
>> +	const char *dst_w_slash;
>>  	enum update_mode *modes;
>>  	struct stat st;
>>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>> @@ -201,6 +202,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  	if (argc == 1 && is_directory(argv[0]) && !is_directory(argv[1]))
>>  		flags = 0;
>>  	dest_path = internal_prefix_pathspec(prefix, argv + argc, 1, flags);
>> +	dst_w_slash = add_slash(dest_path[0]);
> 
> ...you pre-compute a reusable 'dst_w_slash' here...
> 
>>  	submodule_gitfile = xcalloc(argc, sizeof(char *));
>>  
>>  	if (dest_path[0][0] == '\0')
>> @@ -208,12 +210,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>>  	else if (!lstat(dest_path[0], &st) &&
>>  			S_ISDIR(st.st_mode)) {
>> -		dest_path[0] = add_slash(dest_path[0]);
>> -		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>> +		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
> 
> ...then remove the in-place 'add_slash()' of 'dest_path[0]' and use
> 'dst_w_slash' in 'internal_prefix_pathspec()'. Makes sense.
> 
>>  	} else {
> 
> Then, this block is reached if 'dest_path' is not '.' and it is not a
> directory that exists on disk.
> 
> Previously, reaching this point meant that 'dest_path' *must* refer to a
> file, not a directory. However, you want to add handling for the case where
> 'dst_w_slash' doesn't exist on disk because all of its contents are sparse:
> 
>> -		if (argc != 1)
>> +		if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
>> +		    empty_dir_has_sparse_contents(dst_w_slash)) {
>> +			destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
> 
> so the above condition identifies whether 'dest_path[0]' is non-empty in the
> index, and sets 'destination' accordingly. 
> 
> It took me some time to understand what all of these (nested) conditions are
> doing; one suggestion I have (feel free to ignore it, since it's really just
> a matter of stylistic preference) is reduce some duplicate code/simplify the
> change a bit by moving the sparse directory check into the main "if-else"
> block:
> 
> ------------->8------------->8------------->8------------->8------------->8-------------
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 4729bb1a1a..1c1b9559f6 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -203,10 +203,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	if (dest_path[0][0] == '\0')
>  		/* special case: "." was normalized to "" */
>  		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> -	else if (!lstat(dest_path[0], &st) &&
> -			S_ISDIR(st.st_mode)) {
> -		dest_path[0] = add_slash(dest_path[0]);
> -		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> +	else if ((!lstat(dest_path[0], &st) && S_ISDIR(st.st_mode)) ||
> +		 (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
> +		  empty_dir_has_sparse_contents(dst_w_slash))) {
> +		/* directory dest_path[0] exists on-disk or in the index */
> +		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
>  	} else {
>  		if (argc != 1)
>  			die(_("destination '%s' is not a directory"), dest_path[0]);
> 
> -------------8<-------------8<-------------8<-------------8<-------------8<-------------
> 
> It doesn't make for the prettiest condition (so your current approach might
> be better in terms of readability) but, to me, it creates a clearer
> distinction between the "if" and "else if" blocks (which handle the case
> where 'dest_path[0]' is a directory), and the "else" block (which handles
> the case where 'dest_path[0]' is a file).

Now that I've read patch 6 [1], I can see that you need the "sparse
directory" condition block to stand alone. I think it might still help to
put that block in the top-level condition:

------------->8------------->8------------->8------------->8------------->8-------------
diff --git a/builtin/mv.c b/builtin/mv.c
index 4729bb1a1a..4a16a5e602 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -205,8 +205,10 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
-		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_prefix_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
+		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
+	} else if (!path_in_sparse_checkout(dst_w_slash, &the_index) &&
+		 empty_dir_has_sparse_contents(dst_w_slash)) {
+		destination = internal_prefix_pathspec(dst_w_slash, argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die(_("destination '%s' is not a directory"), dest_path[0]);
-------------8<-------------8<-------------8<-------------8<-------------8<---------

...but, as before, I'm happy with whichever approach you decide to take.

[1] https://lore.kernel.org/git/20220805030528.1535376-7-shaoxuan.yuan02@gmail.com/

> 
>> +		} else if (argc != 1) {
>>  			die(_("destination '%s' is not a directory"), dest_path[0]);
>> -		destination = dest_path;
>> +		} else {
>> +			destination = dest_path;
>> +		}
>> +	}
>> +	if (dst_w_slash != dest_path[0]) {
>> +		free((char *)dst_w_slash);
>> +		dst_w_slash = NULL;
> 
> Looks good.
> 
>>  	}
>>  
>>  	/* Checking */
> 


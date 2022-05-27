Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05710C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353108AbiE0P1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiE0P12 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:27:28 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32515DFDC
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:27:27 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso6135750fac.4
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5kxVA+SY2HMRjtIcEahBMTq+EkEmGfg/ROvEe7nHXfQ=;
        b=LhXjlcm+RHXV7bvBCeyN2FAK93zwxOIMH6iol7qPjTxrKp5hSTaUjcqnnP/H/s/P1b
         ZgsPrugRFHs8NVJ5GsmxKuRpCVUS6668A83HSxtGOVBQUIEQk4BNrImF1YfPHQwd0oeD
         KhBH3h7uf5yjBwJmPPawNy/gRAgy1xsh68ZIE6A+QpVbFQj8cqyLAVicmlKgkyr/vd1l
         uDDdKQRIUjlTdPqGk3ZSJW4tShzMOMvS4xKeRQLeUlvK/xCEp+8pOib9An4GyKegpKOH
         htH1WfyBMWpAPiyabWJd/oCYNcAN/z43rFMzqS+rXjioKJePu4X8giCqIKhpSlVMvLD6
         MXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5kxVA+SY2HMRjtIcEahBMTq+EkEmGfg/ROvEe7nHXfQ=;
        b=gOQAnYEFPnD56ZckSKdFd+tl4KYz7ENPxR9EN3Qa7FoAxLYG5tGAERBsbeHGBOLThZ
         scSG6LigbcqmBbCWbddraR9buSDhdwLUaMqteQbjhU7g5KLxF1+9kSr9/rU8Sb6sPbTY
         8QfkxPLFu7CE5ypWh8ZO82mp2MzIsXZErpW9tN19mCDuzd9uD2pa8dLH3n4g+nqcn9it
         iDtfi4XpTLkvhx/tLOfvKcMXKM9jzAZhnfMiaAoj2UdYIkOleLo82hW6URlbZElq3yCq
         vjrvA1XywgQmoHTd4SP2IXyWDO8YivHxtyxSkl7O2Z1NbCtOcy4jElKCXXGDccaOYmOd
         29WQ==
X-Gm-Message-State: AOAM5318B+c8Qf5gOfOfC2gCVfYeuJhECYn5TYIMpgc5FeggdHJqfGTt
        2tN4uCUIMa7ybb7cHsa7LDjP
X-Google-Smtp-Source: ABdhPJzMOn16vKEaP0pLH1xPOOula1mCiNxAm4txO9S0xa9yW3oF63OboP/wKOgMxWUk+xrSop2ziw==
X-Received: by 2002:a05:6870:f587:b0:f1:dfaf:b66b with SMTP id eh7-20020a056870f58700b000f1dfafb66bmr4338060oab.117.1653665246474;
        Fri, 27 May 2022 08:27:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9d56:33a:55eb:168? ([2600:1700:e72:80a0:9d56:33a:55eb:168])
        by smtp.gmail.com with ESMTPSA id g30-20020a544f9e000000b00325cda1ff8asm1969474oiy.9.2022.05.27.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 08:27:26 -0700 (PDT)
Message-ID: <bc51f198-629f-0b68-a8e4-8135f61c0d03@github.com>
Date:   Fri, 27 May 2022 11:27:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [WIP v2 4/5] mv: add check_dir_in_index() and solve general dir
 check issue
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-5-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220527100804.209890-5-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/27/2022 6:08 AM, Shaoxuan Yuan wrote:
> +/*
> + * Check if an out-of-cone directory should be in the index. Imagine this case
> + * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
> + * and thus the directory is sparsified.
> + *
> + * Return 0 if such directory exist (i.e. with any of its contained files not
> + * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
> + * Return 1 otherwise.
> + */
> +static int check_dir_in_index(const char *name, int namelen)
> +{
> +	int ret = 1;
> +	const char *with_slash = add_slash(name);
> +	int length = namelen + 1;
> +
> +	int pos = cache_name_pos(with_slash, length);
> +	const struct cache_entry *ce;
> +
> +	if (pos < 0) {
> +		pos = -pos - 1;
> +		if (pos >= the_index.cache_nr)
> +			return ret;
> +		ce = active_cache[pos];
> +		if (strncmp(with_slash, ce->name, length))
> +			return ret;
> +		if (ce_skip_worktree(ce))
> +			return ret = 0;

This appears to check if the _first_ entry under the directory
is sparse, but not if _all_ entries are sparse. These are not
the same thing, even in cone-mode sparse-checkout. The t1092
test directory has files like "folder1/0/0/a" but if
"folder1/1" is in the sparse-checkout cone, then that first
entry has the skip-worktree bit, but "folder1/1/a" and "folder1/a"
do not.

> +	}
> +	return ret;

At the moment, it doesn't seem like we need 'ret' since the
only place you set it is in "return ret = 0;" (which could
just be "return 0;" while the others are "return 1;"). But,
perhaps you intended to create a loop over 'pos' while
with_slash is a prefix of the cache entry?

> +			else if (!check_dir_in_index(src, length) &&
> +					 !path_in_sparse_checkout(src_w_slash, &the_index)) {

style-nit: You'll want to align the different parts of your
logical statement to agree with the end of the "else if (",

	else if (A &&
		 B) {


> +				modes[i] = SKIP_WORKTREE_DIR;

If we are moving to a flags-based model, should we convert all
"modes[i] =" to "modes[i] |=" as a first step (before adding the
SKIP_WORTKREE_DIR flag)?

> +				goto dir_check;

Hm. While I did recommend using 'goto' to jump to a common end
place in the loop body, I'm not sure about jumping into another
else-if statement. This might be a good time to extract the
code from "else if (src_is_dir)" below into a helper method that
can be used in both places.

> +			}
>  			/* only error if existence is expected. */
>  			else if (modes[i] != SPARSE)
>  				bad = _("bad source");
> @@ -218,7 +264,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
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
> @@ -229,7 +277,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			else { /* last - first >= 1 */
>  				int j, dst_len, n;
>  
> -				modes[i] = WORKING_DIRECTORY;
> +				if (!modes[i])
> +					modes[i] |= WORKING_DIRECTORY;

This appears to only add the WORKING_DIRECTORY flag if modes[i] is
already zero. This maybe implies that we wouldn't understand
"WORKING_DIRECTORY | SKIP_WORKTREE_DIR" as a value.

>  				n = argc + last - first;
>  				REALLOC_ARRAY(source, n);
>  				REALLOC_ARRAY(destination, n);
> @@ -331,7 +380,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			printf(_("Renaming %s to %s\n"), src, dst);
>  		if (show_only)
>  			continue;
> -		if (mode != INDEX && mode != SPARSE && rename(src, dst) < 0) {
> +		if (!(mode & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +		 	rename(src, dst) < 0) {

style-nit: align your logical statements.

>  			if (ignore_errors)
>  				continue;
>  			die_errno(_("renaming '%s' failed"), src);
> @@ -345,7 +395,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  							      1);
>  		}
>  
> -		if (mode == WORKING_DIRECTORY)
> +		if (mode & (WORKING_DIRECTORY | SKIP_WORKTREE_DIR))
>  			continue;

Ok, here you check if _either_ mode is enabled, which is good. Maybe
you don't need the "if (!mode[i])" part above.

Thanks,
-Stolee

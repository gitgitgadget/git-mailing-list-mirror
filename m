Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1DDC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350224AbiDUTxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:53:43 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3633819C
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:50:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c12so6061523plr.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D3aTg+sb8+jlHXbbkP96z5wyWqV9/nG2y9/4VL/pqf4=;
        b=BIgPV1Jqg9vi22OW9REWT5FmbFzkoOfh9H3L+ekv3FKzEBHW6ghACaFCuVTcblwSjn
         +H+oYF8GlgzV+wUjyM2umWouJdJq8gU9C/RVuvpx5Jxvs9ruuvSAKjEKN2CA+N4vfsbO
         AWPjSGaa+e6dPENQQMQKnVNylamIxABkdit01ktYJeyQ8ZIDMha4bUlOvt3YqKrAdWgU
         sWd6i5xCufN8Kw3Eud7gKFqMZp31wQCBaXeSWqwlU5tlrvk/ipFu704+86DIGXzIFQab
         q/BAJwxdbv4EpcZuhc23zATbZcaH+QFG9XI3AFJSmob4e3QJ8HSPeqguIfgzxuPbHytL
         bQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D3aTg+sb8+jlHXbbkP96z5wyWqV9/nG2y9/4VL/pqf4=;
        b=BnAF/Wca0jE66GvhsK2CZU/iHjM71EVC5QF+RrN4EO4T2J3UsfNp9CJv9PnEfp+N4x
         T9Z+7BruUrw44FAV195zsImn6itdgLUxYOsei2ZQhq9Dp/ERUECMEz9vckrA0MA1z9M+
         V9CSwiHQh6Pu3MrXgW5KDy49t2tZiPfi/OoQVzJ8WipozfwICHHlgbl0q3RqoWbfP9WN
         +Dv4oWqkJ6BHPZWv69ERwc3lBCUJQUrHADqNOzxnEhAqDdBIKLLIJHhv6EMWBpG45dP4
         BLxDesRrrsfe/1tDlOTyTRt0WmR/O0taJ7XgIcUooiYqoZjKOu07X+40PqUMVHCSD7wD
         LfDg==
X-Gm-Message-State: AOAM530DtOtOEREEvxshnMCWUn+Sq2jmDkIPeAvQs9oEMIOHcTALJs2q
        dCmjNUaXlxZh7fwzYm31MiRM
X-Google-Smtp-Source: ABdhPJxSfG+VsH0Kj+QcETxcubIsQ0T/3yuthaK/8GjTvkPKKSDN83ky7L1rWneI/M/uX3w6jChBoA==
X-Received: by 2002:a17:902:d506:b0:158:d83f:c42b with SMTP id b6-20020a170902d50600b00158d83fc42bmr1077030plg.122.1650570652930;
        Thu, 21 Apr 2022 12:50:52 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm23817955pfo.124.2022.04.21.12.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:50:52 -0700 (PDT)
Message-ID: <936e7f12-362d-3303-ddf4-5b40f17a0b9e@github.com>
Date:   Thu, 21 Apr 2022 12:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] multi-pack-index: use --object-dir real path
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
 <0435406e2db6c5977928a2b0b0b79e66c0a078ee.1650553069.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <0435406e2db6c5977928a2b0b0b79e66c0a078ee.1650553069.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The --object-dir argument to 'git multi-pack-index' allows a user to
> specify an alternate to use instead of the local $GITDIR. This is used
> by third-party tools like VFS for Git to maintain the pack-files in a
> "shared object cache" used by multiple clones.
> 
> On Windows, the user can specify a path using a Windows-style file path
> with backslashes such as "C:\Path\To\ObjectDir". This same path style is
> used in the .git/objects/info/alternates file, so it already matches the
> path of that alternate. However, find_odb() converts these paths to
> real-paths for the comparison, which use forward slashes. As of the
> previous change, lookup_multi_pack_index() uses real-paths, so it
> correctly finds the target multi-pack-index when given these paths.
> 
> Some commands such as 'git multi-pack-index repack' call child processes
> using the object_dir value, so it can be helpful to convert the path to
> the real-path before sending it to those locations.
> 
> Adding the normalization in builtin/multi-pack-index.c is a little
> complicated because of how the sub-commands were split in 60ca94769
> (builtin/multi-pack-index.c: split sub-commands, 2021-03-30). The
> --object-dir argument could be parsed before the sub-command name _or_
> after it. Thus, create a normalize_object_dir() helper to call after all
> arguments are parsed, but before any logic is run on that object dir.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/multi-pack-index.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 4480ba39827..3853960f9ba 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -90,6 +90,14 @@ static void read_packs_from_stdin(struct string_list *to)
>  	strbuf_release(&buf);
>  }
>  
> +static void normalize_object_dir(void)
> +{
> +	if (!opts.object_dir)
> +		opts.object_dir = get_object_directory();
> +	else
> +		opts.object_dir = real_pathdup(opts.object_dir, 1);
> +}
> +

Rather than copy the 'normalize_object_dir()' calls to every subcommand, you
could "centralize" this by making the 'object_dir' option an 'OPT_CALLBACK'
option, something like:

static struct option common_opts[] = {
	OPT_CALLBACK(0, "object-dir", &opts.object_dir, N_("file"),
		     N_("object directory containing set of packfile and pack-index pairs"),
		     normalize_object_dir),
	OPT_END(),
};

It would require changing the function signature of 'normalize_object_dir'
to match what's shown in 'Documentation/technical/api-parse-options.txt',
and it potentially needs prefix handling similar to what's done in
parse-options.c:get_value() (which internally calls 'fix_filename()' for
filename opts), but I think it's probably worth reducing duplication here
and avoiding the need to add 'normalize_object_dir()' to any new subcommand
in the future.

>  static int cmd_multi_pack_index_write(int argc, const char **argv)
>  {
>  	struct option *options;
> @@ -127,6 +135,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  
>  	FREE_AND_NULL(options);
>  
> +	normalize_object_dir();
> +
>  	if (opts.stdin_packs) {
>  		struct string_list packs = STRING_LIST_INIT_DUP;
>  		int ret;
> @@ -169,6 +179,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
>  
>  	FREE_AND_NULL(options);
>  
> +	normalize_object_dir();
> +
>  	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
>  }
>  
> @@ -195,6 +207,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
>  
>  	FREE_AND_NULL(options);
>  
> +	normalize_object_dir();
> +
>  	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
>  }
>  
> @@ -225,6 +239,8 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
>  
>  	FREE_AND_NULL(options);
>  
> +	normalize_object_dir();
> +
>  	return midx_repack(the_repository, opts.object_dir,
>  			   (size_t)opts.batch_size, opts.flags);
>  }
> @@ -241,9 +257,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  			     builtin_multi_pack_index_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  
> -	if (!opts.object_dir)
> -		opts.object_dir = get_object_directory();
> -
>  	if (!argc)
>  		goto usage;
>  


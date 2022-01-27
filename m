Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861CC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiA0PDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 10:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiA0PDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 10:03:11 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8CCC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:03:11 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so733990oor.12
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zm53bnSyWvboQCP+nayOhHIi30iS4L0bcaLTe/Rxyfs=;
        b=FCrX0hylTeo1C6r0Kdtu46gchJ44U4qn21OUjmZLGkljHEl+d3Wqp1U4F6AZywY37f
         dhrmNb5s0wNRcxay7HpRB6RntxSGbr3o/pHX2r++BBLEKXw8hPv87Y7aHUXvn3nQyzWc
         gHjxPzGQTsOIg7zA5IDJ9Guq+Ybm1meiee1Syrn8r9Xw77idP7/fxJZEtgNWjO0t5XEx
         C1k5Ro/N2PVl4C8mhkYEfGDBqFOWFEVzkeCdInsuAamhSxaTQSGJp/Z6Caf7+NlugnUz
         YrJkUdYPbnIZ85GXgeBHzwXKfxt4lZ27gwgt+RgIzBhgVaGD19QiEMvAqTi6Muz6HKbC
         xIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zm53bnSyWvboQCP+nayOhHIi30iS4L0bcaLTe/Rxyfs=;
        b=KZPkBSBFkD4FwdVjvKftvK7NuzJfbSY7XLBIL3XOkgyZUdhp/P//UBGSoupIxGcjY5
         ySr+XdIrQtJHQJg2Rzf0Vy43JcZsyoiJciI0t9OQFd4+GfaGDL+sd0vh7Uo4h2kakV6B
         6ozKlD7WsfHJvwQLcp4sT87XKA4+zjU/zHNBP6XWivNTuOX+lWsRd7fKvOkj0utuAnId
         8mgVTRKMzh315cu8LIdX1BcjWlbxwtTa20v0mK+Usdg/UWxIed3uGd5mU8rY7v5v8xLP
         ZjZ3/Ug+vnxSgKdSUTIniCYVs2phUPPelG4YdTqNBRoNviqzn9tCThgLOzq1B+AQCt+Y
         uVjQ==
X-Gm-Message-State: AOAM533issl9uhHYdXzuLtrmFH1bEs89+EZFaz2BEqgUVUYvpcEZjmgp
        ZjsXWXxQUDDawGQ/RhflZL8dHi74/9Y=
X-Google-Smtp-Source: ABdhPJworqlU3Z+jdUQ3YyxPl6ALNkq7mcLj2pCAOal0SvkpQy6n0H+wAZ5Tb4TeBqxVnnkyFUSYfQ==
X-Received: by 2002:a4a:e0d8:: with SMTP id e24mr2103423oot.56.1643295790976;
        Thu, 27 Jan 2022 07:03:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id d14sm6121634ooh.44.2022.01.27.07.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 07:03:10 -0800 (PST)
Message-ID: <a62a007f-7c61-68eb-c0e6-548dc9b6f671@gmail.com>
Date:   Thu, 27 Jan 2022 10:03:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] repack: add --filter=<filter-spec> option
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <a3166381572481f2ed159740eb8a1d88d4f9dc0f.1643248180.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a3166381572481f2ed159740eb8a1d88d4f9dc0f.1643248180.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/26/2022 8:49 PM, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> Currently, repack does not work with partial clones. When repack is run
> on a partially cloned repository, it grabs all missing objects from
> promisor remotes. This also means that when gc is run for repository
> maintenance on a partially cloned repository, it will end up getting
> missing objects, which is not what we want.

This shouldn't be what is happening. Do you have a demonstration of
this happening? repack_promisor_objects() should be avoiding following
links outside of promisor packs so we can safely 'git gc' in a partial
clone without downloading all reachable blobs.

> In order to make repack work with partial clone, teach repack a new
> option --filter, which takes a <filter-spec> argument. repack will skip
> any objects that are matched by <filter-spec> similar to how the clone
> command will skip fetching certain objects.

This is a bit misleading, since 'git clone' doesn't "skip fetching",
but instead requests a filter and the server can choose to write a
pack-file using that filter. I'm not sure if it's worth how pedantic
I'm being here.

The thing that I find confusing here is that you are adding an option
that could be run on a _full_ repository. If I have a set of packs
and none of them are promisor (I have every reachable object), then
what is the end result after 'git repack -adf --filter=blob:none'?
Those existing pack-files shouldn't be deleted because they have
objects that are not in the newly-created pack-file.

I'd like to see some additional clarity on this before continuing
to review this series.

> The final goal of this feature, is to be able to store objects on a
> server other than the regular git server itself.
> 
> There are several scripts added so we can test the process of using a
> remote helper to upload blobs to an http server:
> 
> - t/lib-httpd/list.sh lists blobs uploaded to the http server.
> - t/lib-httpd/upload.sh uploads blobs to the http server.
> - t/t0410/git-remote-testhttpgit a remote helper that can access blobs
>   onto from an http server. Copied over from t/t5801/git-remote-testhttpgit
>   and modified to upload blobs to an http server.
> - t/t0410/lib-http-promisor.sh convenience functions for uploading
>   blobs

I think these changes to the tests should be extracted to a new
patch where this can be discussed in more detail. I didn't look
too closely at them because I want to focus on whether this
--filter option is a good direction for 'git repack'.

>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
> @@ -819,6 +824,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		if (line.len != the_hash_algo->hexsz)
>  			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
>  		string_list_append(&names, line.buf);
> +		if (po_args.filter) {
> +			char *promisor_name = mkpathdup("%s-%s.promisor", packtmp,
> +							line.buf);
> +			write_promisor_file(promisor_name, NULL, 0);

This code is duplicated in repack_promisor_objects(), so it would be
good to extract that logic into a helper method called by both places.

> +		}
>  	}
>  	fclose(out);
>  	ret = finish_command(&cmd);

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index e489869dd94..78cc1858cb6 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -237,6 +237,26 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
>  	test_must_be_empty actual
>  '
>  
> +test_expect_success 'repack with filter does not fetch from remote' '
> +	rm -rf server client &&
> +	test_create_repo server &&
> +	git -C server config uploadpack.allowFilter true &&
> +	git -C server config uploadpack.allowAnySHA1InWant true &&
> +	echo content1 >server/file1 &&
> +	git -C server add file1 &&
> +	git -C server commit -m initial_commit &&
> +	expected="?$(git -C server rev-parse :file1)" &&
> +	git clone --bare --no-local server client &&

You could use "file:://$(pwd)/server" here instead of "server".

> +	git -C client config remote.origin.promisor true &&
> +	git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
This isn't testing what you want it to test, because your initial
clone doesn't use --filter=blob:none, so you already have all of
the objects in the client. You would never trigger a need for a
fetch from the remote.

> +	git -C client rev-list --objects --all --missing=print >objects &&
> +	grep "$expected" objects &&
> +	git -C client repack -a -d &&
> +	expected="$(git -C server rev-parse :file1)" &&

This is signalling to me that you are looking for a remote fetch
now that you are repacking everything, and that can only happen
if you deleted objects from the client during your first repack.
That seems incorrect.

> +	git -C client rev-list --objects --all --missing=print >objects &&
> +	grep "$expected" objects
> +'

Based on my current understanding, this patch seems unnecessary (repacks
should already be doing the right thing when in the presence of a partial
clone) and incorrect (we should not delete existing reachable objects
when repacking with a filter).

I look forward to hearing more about your intended use of this feature so
we can land on a better way to solve the problems you are having.

Thanks,
-Stolee

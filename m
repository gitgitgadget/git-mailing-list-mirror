Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9812A177
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534199; cv=none; b=SNbkwMvH5lWcFX3PbmXXK+8t7uF1oVupJqarWRroSjfY2/WMZkOAFEWp3fvV5xpTIyOFTLbydYd1oEgE7/BDhA2U7FZjVk+IwDtYpgqxKvlUXGeZX5YQUK6aGnPselFx0YKZAePUTFP06UdfCT7qG9IDvAfK5apEIWtcK/Duwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534199; c=relaxed/simple;
	bh=bGboQ2S1PGe8UwpJawRyY3u4NmA7QZf/2P/uYqXhskM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEvP9hH2IUVDy/Q3y6zQNgV8j/hu1JXEg8EYIwiXT7/663dofL0RnqkH302wY5xo2cQVU3TsqHGgvasc87aeWJDqf+S6V6sfDJZ3U19nnrBhLyssvpaiD2TeGSP3V/0/siKe0OkGsDuRjPVAMX5SBwJBwkwNehtIQ5MwYDVFhYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIMS6106; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIMS6106"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6eff8289d0eso64277977b3.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534195; x=1735138995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JY/Wy669nZHdOGFKZkZvmIie6tXDBeUB38bLSIoz1aQ=;
        b=EIMS6106dr/L8LUQn5tIv26Pf1M5xJ9LT3dMe/T1ja58buBy7UJOBliLTE+OtCKNQ8
         1rO0j0uVWEak53v1TOx7HXjLGWZ6bBPZMoJLYQBw4+5rg8chFeelY288TBGVRkCxoK6k
         mcut9ZkEpVzPFTx0ISMNbuAXV3HmsY+eXA8IwczPwuLsY20CxyVpvoCSuOEaXkgyTu0u
         5qco74uqtJ+LBaQZJJ7vTU+8TJVDEOIqpJ8mlpq6jrZzayX4NsjTWRbY2PayuFn9PlQd
         4ae+MluXkwkY6p3tQWyegAchDupMu080sBa49PePSOz1pe6pYHq6b2X1SKefyvwF5glx
         yoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534195; x=1735138995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JY/Wy669nZHdOGFKZkZvmIie6tXDBeUB38bLSIoz1aQ=;
        b=arJYkatf32kerQEGOVshczwJ760o2EvLUEc9j4UF3Wnm1mGlRO6qjrYcscWE0HYz2s
         Trg4/+YHwykgOrsVxmdzAL/K3Yx0gfBbIO9O3UAG07h4Oi5sNymldmLEjvy8getJNwjm
         yoMXbSNfDNKQJA3Z6dJ0Nk0IAP3G7p1RPXZYXlgirbvEfEmAz9mz1yTa+jfMdbgIzvdK
         7CdN+tjzpUBl0fzpV1tduTLI55++Q9/hiE44INC3JDwZOf/hkWgB9Z9lExz9wypil0WR
         Bz+2PT24BM/1UjVc1wLqIOtS3dE9x9/FW4vlu2k6XenPPbwYqoZQyc+yl/KxtASgBmIc
         O7Kg==
X-Gm-Message-State: AOJu0YycO3EVgNmj90OzeP8YSpN37Q+ymzjPbJGWYvKzN70rYXJBheJP
	5VBd2hI+oova23MjqEc0/8FMQiL4W1p6O9etdBJCgJE/QCYrSaOs
X-Gm-Gg: ASbGncsTXUbzl4bENXAnRo8UD8Ac7lafMRk7+CvscqA1aj9Dawhsj0/+JbZCCR/4B6B
	/GHrjgzAIRIItfufl7jukd74Y/KJF284ooGUbAwh01FkDdfyJX00ldx8suOqQKK4sdhqdzVUvZN
	ay2HJ9GNDC7ZysBqoNXdUYoHcXXhAapCLbeZxQjJoZkx5cuhjE+AnXshbyt5T6/QxNYsrynhLQm
	fjUcXM3qFHYRXz7g1AMeH7SneN+HUDztN6sURP4+y+WVqgpy3i5Jh83zb13YHP0dxc+PKBl2/3m
	Uy+ZKS0svDDJ14UX55SxOUJzW4Z206CMnOiU1SlZug==
X-Google-Smtp-Source: AGHT+IGEK8IEPKB/TuUxs1/BfsFbXY6WMlQ8KTIKv/uslTJXRTr/EycD+MWd4ZPVWK5yEMjlmRLc+Q==
X-Received: by 2002:a05:690c:6913:b0:6ef:8e8a:6348 with SMTP id 00721157ae682-6f3d269df4fmr24277227b3.42.1734534195264;
        Wed, 18 Dec 2024 07:03:15 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:749d:17a4:27e:8972? ([2600:1700:60ba:9810:749d:17a4:27e:8972])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f2891ef11csm24082547b3.111.2024.12.18.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 07:03:14 -0800 (PST)
Message-ID: <79e8b04c-f8e4-4a8d-b55d-74f39d5978b6@gmail.com>
Date: Wed, 18 Dec 2024 10:03:13 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] backfill: basic functionality and tests
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik.188@gmail.com,
 Derrick Stolee <derrickstolee@github.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <5728dd2702195b7ba3a208859f114e40ba2b6bbd.1733515638.git.gitgitgadget@gmail.com>
 <Z1_eUSGN3B13uGmM@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z1_eUSGN3B13uGmM@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 3:01 AM, Patrick Steinhardt wrote:
 > On Fri, Dec 06, 2024 at 08:07:15PM +0000, Derrick Stolee via GitGitGadget wrote:

 >> +The `git backfill` command provides a way for the user to request that
 >> +Git downloads the missing blobs (with optional filters) such that the
 >> +missing blobs representing historical versions of files can be downloaded
 >> +in batches. The `backfill` command attempts to optimize the request by
 >> +grouping blobs that appear at the same path, hopefully leading to good
 >> +delta compression in the packfile sent by the server.
 >
 > Hm. So we're asking the user to fix a usability issue of git-blame(1),
 > don't we? Ideally, git-blame(1) itself should know to transparently
 > batch the blobs it requires to compute its output, shouldn't it? That
 > usecase alone doesn't yet convince me that git-backfill(1) is a good
 > idea as I'd think we should rather fix the underlying issue.

I've looked into making this change for 'git blame' and it is a
nontrivial change. I'm not sure on the timeline that we could expect
'git blame' to be improved.

But you're right that this is not enough justification on its own. It's
an example of a kind of command that has these problems, including 'git
log [-p|-L]'.

 > So are there other usecases for git-backfill(1)? I can imagine that it
 > might be helpful in the context of scripts that know they'll operate on
 > a bunch of blobs.

One major motivation is that it can essentially provide a way to do
resumable clones: get the commits and trees in one go with a blobless
clone, then download the blobs in batches. If something interrupts the
'git backfill' command, then restarting it will only repeat the most
recent batch.

Finally, in a later patch we can see that the --sparse option allows a
user to operate as if they have a full clone but where they only include
blob data within their sparse-checkout, providing reduced disk space and
network time to get to that state.

 >> +	if (ctx->current_batch.nr >= ctx->batch_size)
 >> +		download_batch(ctx);
 >
 > Okay, so the batch size is just "best effort". If we walk a tree that
 > makes us exceed the batch size then we wouldn't issue a fetch during the
 > tree walk. Is there any specific reason for this behaviour?
 >
 > In any case, as long as this is properly documented I think this should
 > be fine in general.

The main reason is that we expect the server to return a packfile that
has many delta relationships within the objects at a given path. If we
split the batch in the middle of a path batch, then we are artificially
introducing breaks in the delta chains that could be wasteful.

However, this batching pattern could be problematic if there are a
million versions of a single file and the batch is too large to download
efficiently. This "absolute max batch size" is currently left as a
future extension.

 >> +	clear_backfill_context(ctx);
 >
 > Are we leaking `revs` and `info`?

At the moment. Will fix.

 >> +	return ret;
 >> +}
 >> +
 >>   int cmd_backfill(int argc, const char **argv, const char *prefix, struct 
repository *repo)
 >>   {
 >> +	struct backfill_context ctx = {
 >> +		.repo = repo,
 >> +		.current_batch = OID_ARRAY_INIT,
 >> +		.batch_size = 50000,
 >> +	};
 >>   	struct option options[] = {
 >>   		OPT_END(),
 >>   	};
 >> @@ -23,7 +123,5 @@ int cmd_backfill(int argc, const char **argv, const char 
*prefix, struct reposit
 >>
 >>   	repo_config(repo, git_default_config, NULL);
 >>
 >> -	die(_("not implemented"));
 >> -
 >> -	return 0;
 >> +	return do_backfill(&ctx);
 >>   }
 >
 > The current iteration only backfills blobs as far as I can see. Do we
 > maybe want to keep the door open for future changes in git-backfill(1)
 > by implementing this via a "blob" subcommand?

I think that one tricky part is to ask "what could be missing?". With
Git's partial clone, it seems that we could have treeless or depth-
based tree restrictions. Technically, there could also be clones that
restrict to a set of sparse-checkout patterns, but I'm not aware of any
server that will respect those kinds of clones.  At the moment, the tree
walk would fault in any missing trees as they are seen, but this is
extremely inefficient.

I think that the path-walk API could be adjusted to be more careful to
check for the existence of an object before automatically loading it.
That would allow for batched downloads of missing trees, though a
second scan would be required to get the next layer of objects.

I'm not sure a subcommand is the right way to solve for this potential
future, but instead later we could adjust the logic to be better for
these treeless or tree-restricted clones.

Thanks,
-Stolee

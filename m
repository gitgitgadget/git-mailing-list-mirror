Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0FB17E8EB
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203435; cv=none; b=iebzRVNJoKYKbwqnTyZ5hxZ6OgQegkBzCBu4WPNnTbZmKQsi54jb/lpmSRBelykNPZLTWIoW4AGr6un6wEQxSU8Oe3vWhd2UqoNtViONc31WQakEYLmDTHi5FMIZvdjAOZ+IH5tX7RShD1JYV/7XLw9hYiY/9p8+d4V1lXS1VQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203435; c=relaxed/simple;
	bh=XQiTQEZrJeK3VZwnmKpJi3Lm5p41Ac4OVco89AEWNKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGwqCrPDIRxUbMQMs/gm66tjYUE7pTZVFVzkHXwYK15MrkLkoSzXYWQBa6SqvMXIpBjTEBenw6SOJ4P0lsN/c2SpfJuZrJ0B7ZXrPBfwk5Kgr5XYjG2L29gT7v7924Eo201QrYhl1qzw0dhT1ic4yszdp47qH0BUbBfJJVt56x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DKCecgD1; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DKCecgD1"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-62f518bbab1so14972097b3.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718203432; x=1718808232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAhwHOycWgMQOPFKxoTMPpXSthU+FpIBEhB2Aqys7/g=;
        b=DKCecgD1u3HWTMX0rt7ChLm/R5eO3X+2Yle1xOqW0W+sGsgQcwADT4/oNMcDlPws19
         Q6fv93SouK/MBS3UQyACHYJyRFzuNJcp2fUkY2Iv3m4BRrvpQiiXZNyLaTUY6qszSGBD
         2eG/n4Wzs5t2zv8uo8fLoKLxG9vIUaEfevqDIKUbbm/Q677Pc9yQPR83iat62bkXZDf2
         cl8gPRk549qmDLHDRDYU4OVyGohlZWu2MkOduGXCHgz1zKKdD4yrh39nCMT/XJxBOAVw
         8Qu9nrTAyVtsu2ENTbEy0+ftMgjpDt5wfPOlxO/90w3OmVvHx3s9zwL5lD3tR+FXDiQb
         39kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203432; x=1718808232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAhwHOycWgMQOPFKxoTMPpXSthU+FpIBEhB2Aqys7/g=;
        b=Hg3ghIgIuEFfHjshrnH9EgEMQsw3ke3wZxYLQm3S2jEUNh4ipPBcGL2W11ijfTUYDf
         B5dT5P01Kpw/+6BQFxAqa/Q28NKD4iYubmhY5kezEJkQ/d7hmuWUbBG/dPN9w+lHZ6cg
         CXtUpuNX1OScuDL2DUshT7zIh5Z6uiBHcXQ05wS2IGOPQy9PS6epiSo4PwOXJraOit9G
         gy4oyo3BNZ2vjD2Lo/DNMi4K2L1/7oI+MB8O7Wvcho5UqrLvqk6qyPMQzBmb2wy0lJaF
         gUbIj2iLQGcW2ho5UdAO0ftOHPmyFbXzR4T/yVBSeyOlUv6rCv6Bat9XWpHnk+eNwQrO
         f2ww==
X-Gm-Message-State: AOJu0YwnQWQZ+r1n5KWr1Lfy7xOQwWsxq+XcxTNLPa0uLkSuZ2+18OrT
	EnIEITq3eKayXs4Pa15dhmGHVN9BWMEtCHMgveblF/BvVgEK3pEKbMzY0dOOmhM=
X-Google-Smtp-Source: AGHT+IH3dX7ptGq/qoMRtGWl2PaDAKyeENa0I/+X6+KK+xY94jRpPCIYa+RI0qCypLHlS/OfynBUrw==
X-Received: by 2002:a81:bb43:0:b0:618:8a27:6150 with SMTP id 00721157ae682-62fb8d4730emr17454577b3.24.1718203431675;
        Wed, 12 Jun 2024 07:43:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6c4022sm68449466d6.51.2024.06.12.07.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:43:51 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:43:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: increment progress indicator
Message-ID: <Zmm0JcJRguLqxeif@nand.local>
References: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>

Hi Johannes,

On Tue, Jun 11, 2024 at 03:09:15PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> This fixes a bug that was introduced by 368d19b0b7 (commit-graph:
> refactor compute_topological_levels(), 2023-03-20): Previously, the
> progress indicator was updated from `i + 1` where `i` is the loop
> variable of the enclosing `for` loop. After this patch, the update used
> `info->progress_cnt + 1` instead, however, unlike `i`, the
> `progress_cnt` attribute was not incremented. Let's increment it.

Nice find and fix. I remember vaguely working on what became upstream
368d19b0b7 with Stolee, and I'm glad to see the bug fix he wrote on top
is also going upstream.

> diff --git a/commit-graph.c b/commit-graph.c
> index e5dd3553dfe..41a2e1b4c6d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1597,7 +1597,7 @@ static void compute_reachable_generation_numbers(
>  		timestamp_t gen;
>  		repo_parse_commit(info->r, c);
>  		gen = info->get_generation(c, info->data);
> -		display_progress(info->progress, info->progress_cnt + 1);
> +		display_progress(info->progress, ++info->progress_cnt);

It looks like this info->progress_cnt is only used in
compute_reachable_generation_numbers() here, so I wonder if it may be
worth it to do the following on top (ideally squashed into your patch
here):

--- 8< ---
diff --git a/commit-graph.c b/commit-graph.c
index 41a2e1b4c6..0410f6a9c3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1558,7 +1558,6 @@ struct compute_generation_info {
 	struct repository *r;
 	struct packed_commit_list *commits;
 	struct progress *progress;
-	int progress_cnt;

 	timestamp_t (*get_generation)(struct commit *c, void *data);
 	void (*set_generation)(struct commit *c, timestamp_t gen, void *data);
@@ -1597,7 +1596,7 @@ static void compute_reachable_generation_numbers(
 		timestamp_t gen;
 		repo_parse_commit(info->r, c);
 		gen = info->get_generation(c, info->data);
-		display_progress(info->progress, ++info->progress_cnt);
+		display_progress(info->progress, i + 1);

 		if (gen != GENERATION_NUMBER_ZERO && gen != GENERATION_NUMBER_INFINITY)
 			continue;
--- >8 ---

That would get rid of the info->progress_cnt field entirely, which seems
beneficial since it's only used by this single function, and we already
have 'i' which we can use as a replacement (as you note, effectively the
pre-image behavior of 368d19b0b7).

But I do not feel strongly either way, so no worries if you'd prefer to
keep this as-is.

Thanks,
Taylor

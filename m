Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EB23D2
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075694; cv=none; b=GdtTGPG/GE5NSqrIqw6ou1iyoSu7hwKVNx7Sz3o9ZHB/fOzADIPF28rto5RtE6LoQn4ZbI++SGjs7P5/HpnnC69a8XaTLSUR/dugPQ0+tYTIxz+92bXI4700VDskv604pllSh5lCdjvhciykE1krSSZK3cW/PMHhb9uMmDSjB/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075694; c=relaxed/simple;
	bh=HXTRsEMf+JoSYA0scEp9sb/r8ajtqYnWQRPewQw5Teo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN9mz3ErxAwW5DyvWDpHmxa+jEjSzGerkZN2TOmZeyzlHGHaNKoTXPR1VWNPMmZlzDxzUBHObIV4qWUSCft3UCtgrzCvDdLs1LfknRwTQ0ik/eIpUmS6N5wiIH1Aoi2fE6Mvk36PckTcFY/i1dNKQfozb+gXKy8Mff96K6gLiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2H8Ez7JR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2H8Ez7JR"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e30a1845787so426162276.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730075691; x=1730680491; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hnbC7iU+GawlRQEA+hg7jxE2fIz8ExlD+I06r+V1Afo=;
        b=2H8Ez7JRWZHdZuJUGbHeIVGZoYgWPxMKsDz7hpRVHbgrhBH+M7b0rPCXp5Xc4DBiCB
         ET0W7ekU8LD51XBKdDeBLqiHCK/Ktajsbg/HL7qIBepKWfIzv/+GXrCKEANUzoUqHS7y
         CBG9OplnpqyzYEZ3EmaLit6wLB2NSRRwD8QvPiB5D1XiudjpeHpT8Lq/gOmlLZnRimbu
         F5H+O2g6w5r0Oii8kdc5ENl9+BZdNuVQSG7Fx223jHzeE5jFqB5b6hAhkCp77K71X/Gg
         fgDOopU/2J062f0uMr8umYnSPp1Mvg7n2/7WaicrEYC8QXCJAVUhXrWkI6DnMGBtFaJF
         jMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730075691; x=1730680491;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnbC7iU+GawlRQEA+hg7jxE2fIz8ExlD+I06r+V1Afo=;
        b=qoT9HEuALmeRz8QkVvAHIyco4lKNiOnIFijLS8O7Lwt7cFNDqnLM6NyWC/IPJ7aG1z
         mgLRhidBm+W21/YC+KLmDXiXC2AETyvHkYvWUpfDi1R+KY3MoMbXZw/YHhzrNdUVAcu9
         KKL3BlZfHiQLxGrNiLASzBk1+NSlZuO8puwdPm6SZuPoGXcDZcTwwLyBKRjQSZ0bfeit
         bVtPKUe/ifSkzSmSAr2R/a4dQ8Ns92kx32lz3fIjXSWmjKb2GQ13OKfJYeKmtRlW5w4V
         RB1JwxOPH2C1DKpJX6fpFkPQyCABXZaL7V/gBKIxugDC8dRjV/1Z+G9HBvW7nz3eXawG
         LlPQ==
X-Gm-Message-State: AOJu0YzBlc2c78uTXMYeuBuzTwXcufSMbfxJ5g/x0gVYMmKq86c2dTbN
	5Bz+KE3rysSpSH59EeiZIiI4RSEC2wPqhIWj8LfIazvYEX2ZeWpAvDvrk5tJPtc=
X-Google-Smtp-Source: AGHT+IFkEOWWFnR1V+kf9UX593hk4D3CX0I9VhS42SVY4/33D/ARGEfPZEen6MxW5Vygw6oWqmlG3w==
X-Received: by 2002:a05:6902:2001:b0:e2b:df40:2588 with SMTP id 3f1490d57ef6-e3087a6bd52mr5406191276.21.1730075691206;
        Sun, 27 Oct 2024 17:34:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d9e027sm1185164276.35.2024.10.27.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:34:50 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:34:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path
 linking
Message-ID: <Zx7cKN9X56GrHrU/@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me>
 <Zx7YFPE5tjr/bn2s@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zx7YFPE5tjr/bn2s@nand.local>

On Sun, Oct 27, 2024 at 08:17:24PM -0400, Taylor Blau wrote:
> On Fri, Oct 25, 2024 at 10:29:37PM +0000, Caleb White wrote:
> > This patch introduces the `--[no-]relative-paths` CLI option for
> > `git worktree {add, move, repair}` commands, as well as the
> > `worktree.useRelativePaths` configuration setting. When enabled,
> > these options allow worktrees to be linked using relative paths,
> > enhancing portability across environments where absolute paths
> > may differ (e.g., containerized setups, shared network drives).
> >
> > Using the `--relative-paths` option with `worktree {move, repair}`
> > will convert absolute paths to relative ones, while `--no-relative-paths`
> > does the reverse. For cases where users want consistency in path
> > handling, the config option `worktree.useRelativePaths` provides
> > a persistent setting.
> >
> > A new helper function, `write_worktree_linking_files()`, centralizes
> > the logic for computing and writing either relative or absolute
> > paths, based on the provided configuration. This function accepts
> > `strbuf` pointers to both the worktree’s `.git` link and the
> > repository’s `gitdir`, and then writes the appropriate path to each.
>
> Looking at the patch below, it is quite large, and I wonder if it would
> benefit from being split into smaller pieces. Perhaps factoring out
> write_worktree_linking_files() in a separate patch would be a good start
> here?

Additionally, it appears that this patch breaks at least t0001-init.sh,
but others as well. The relevant portion of -vx from t0001.46 is:

    --- 8< ---
    + git -C mainwt config worktree.useRelativePaths true
    + git -C mainwt worktree add --detach ../linkwt
    Preparing worktree (detached HEAD 89e2b84)
    HEAD is now at 89e2b84 gumby
    + git -C mainwt init --separate-git-dir ../seprepo
    Reinitialized existing Git repository in /home/ttaylorr/src/git/t/trash directory.t0001-init/seprepo/
    + git -C mainwt rev-parse --git-common-dir
    fatal: repo version is 0, but v1-only extension found:
      relativeworktrees
    --- >8 ---

Let's please fix this breakage, and then decide what we are going to do
with the extension in the second patch relatively soon, as I worry that
putting the original topic on master may have been a mistake if it is
going to break worktree pruning on earlier Git versions.

Thanks,
Taylor

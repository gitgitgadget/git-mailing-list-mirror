Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4C2459DA
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795001; cv=none; b=qST041bpj/Ji+QKabeMfAN8pmESZmg20yIm5fcqZ8AonopCyUMMyN3HSLOhAY94guVANKvCD+RJl5IWg+pjmw4lEQfNQjpw4ZZuVasgFlR6cJTAsfunWhIRLkMcr11Kaf8MxVHXiCnwow9iFtF+PIt5MXcziB8AjhkIeOQ7kukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795001; c=relaxed/simple;
	bh=AfQ7B9v05efPHHkVR9jLBozYGEfwJDl43UADgpS70gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcD8TnPWBnVloYGkZbGiZuYl6elhNtsPYxdf3LeWcApef4788PXf/sWr+3Ix2cXX/9+9amJtbmBOqdnjbmBH8mVEnhp75woH3eFrudSKfLNFdd1ShAKWLwrmze9auGOA2t2m08GLYst8g8/AC3HDd/RyJUwAbTkKUZXOn8T5Pho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=c7TDxVW4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="c7TDxVW4"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bcbe46cf1so1520582276.2
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752794998; x=1753399798; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QlRvxOnt78FhDYC60nRJ0Lqbe3wVnYpQazQJPDzij20=;
        b=c7TDxVW4xOT+eOdMAlW6UOAEwmVz+mnmqFD6mZ0u/fM/hklVXXoFNutw/cJZgA6Vlx
         R/5EHIcIrVf4fRGGeVNi9nw1mhhTtsdsWYdReHadkA+Dylern18ALcgIwl4Uf+i2j42J
         x1sRrwa/LmHHW7zvbcVrQZs7ZzLvPdqIAvLLTiRNtKpNOa6qe1wNYqV+7hEN0h0wY9TD
         fYreQ7pmlIkJVjvRkkZHA5HAl90MR7msF7sAY4gaav76xX86ggMEa5blt7KkqPIcx5/V
         vCFulWGD963+LbRN/YTzJty8lc/WIZuFMzfttlV0mUEWTULGDkr1nZB9n6sR7Px9FmOM
         RFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794998; x=1753399798;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlRvxOnt78FhDYC60nRJ0Lqbe3wVnYpQazQJPDzij20=;
        b=Z+XeLOum0IBUSq3rL0U2th3QdQYSIc3o5Ra5qjBIzHb96s1CVMM98/c8m9y2Hi2wvX
         kxCuJmoqOXsaAGSlw9iRiMCbEt8A4AR5L2Gc/apz38rRs2l0XCkM6SGVbuvqV2KqmJfP
         7hmazQWdI7X5Amj48ZixdM/qDQKrLm2xTh5f+fVAZ1FvD0YnxQcfAnlmsToZi0PASEEm
         n/J06xSYuYtaqIQ11rQ3rAy5JH4OuWDrlMiRyevMvnEx9onbV0q0HxdIdiy5wl91hkZ5
         8RiWlryIAsT6T7oQfC23oH/bRqryuD8QBLwRdRq/VEaiCGMc8sz4xPLgmOwPJyDj8kxo
         ZJ2w==
X-Gm-Message-State: AOJu0YwbDvnwtJX6jwUYaVAU2luiW+kB6mp2jhuwDA0+HaechtXhoffS
	R4CWx3OhwbDI46KF/MnKO8vQrFgwXW2CHpl30imLwj521l73ayBjkFVm5dZDX7efaAA=
X-Gm-Gg: ASbGncvcY/q8sT7vebMVu6PA6sIX6Qdr5X/Nzx6nzu7rMh+ww1sBN+vS6UWqkN85KjQ
	OmbVo7jo03Bonu/AfHVXb0G67fXf87FVr5ySgQdMzHg9EIZMq319IRrcYVZEg1b1AY3bhqAaXND
	kRoClOjdJS9VXJ+7mxdyuX34JI65yU33ncRXt0ezAnXs2vdGRojsn6iLvQTrjAdMopKQ0XB8exI
	cJvv9W1wcCO4/nn+ROy8vK6t8eANNQrnbzd6fZo3Dwpi88W5q/d/kPSAOJ2texInvbq6vInqved
	eOlNPrSnUTP+e8gL6UdvpVVfvJclWB6Ue+JcRmmUX7cm01nlklthdCIGhWpHv9+H9f6RrK1F2Rr
	DIJVM2iulP1YMPAZiYP4NjFyCChPU0DM+cGAv5HU+Aw3rkhVnlQos1zv76D2h2rlemqjbRg==
X-Google-Smtp-Source: AGHT+IF28q8LjdOyUPkZ+K5u4txbdG6eBEN9AiOjcTgaLQsS7m+9rkdjX0AvkWyCuWmXG+DBSyBLaA==
X-Received: by 2002:a05:6902:158d:b0:e8b:bd93:5194 with SMTP id 3f1490d57ef6-e8bc27a9d52mr10152511276.49.1752794998303;
        Thu, 17 Jul 2025 16:29:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7cc0b1cesm41978276.3.2025.07.17.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:29:57 -0700 (PDT)
Date: Thu, 17 Jul 2025 19:29:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of
 xxhash
Message-ID: <aHmHb99q/if6KTTw@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>

On Thu, Jul 17, 2025 at 08:32:23PM +0000, Ezekiel Newren via GitGitGadget wrote:
>     // desktop
>     // CPU: 8-core Intel Core i7-9700 (-MCP-) speed/min/max: 800/800/4700 MHz
>     $ hyperfine --warmup 3 -L exe $BASE/build_release/git,$BASE/build_v2.49.0/git '{exe} log --oneline --shortstat v6.8..v6.9 >/dev/null'
>     Benchmark 1: /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null
>       Time (mean ± σ):      6.823 s ±  0.020 s    [User: 6.624 s, System: 0.180 s]
>       Range (min … max):    6.801 s …  6.858 s    10 runs
>
>     Benchmark 2: /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null
>       Time (mean ± σ):      8.151 s ±  0.024 s    [User: 7.928 s, System: 0.198 s]
>       Range (min … max):    8.105 s …  8.184 s    10 runs
>
>     Summary
>       /home/steamuser/dev/git/build_release/git log --oneline --shortstat v6.8..v6.9 >/dev/null ran
>         1.19 ± 0.01 times faster than /home/steamuser/dev/git/build_v2.49.0/git log --oneline --shortstat v6.8..v6.9 >/dev/null

Very cool!

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  rust/Cargo.lock       |  7 +++++++
>  rust/xdiff/Cargo.toml |  1 +
>  rust/xdiff/src/lib.rs |  7 +++++++
>  xdiff/xprepare.c      | 19 +++++++++++++++++--
>  4 files changed, 32 insertions(+), 2 deletions(-)

This patch is delightfully simple. Thank you for carefully preparing the
previous five patches to make this one as tiny as it is.

> @@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>
>  	xdl_parse_lines(mf, narec, xdf);
>
> +	if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {

It may be worth adding a comment here to explain why we aren't using
xdl_hash_record() when xpp->flags lacks XDF_WHITESPACE_FLAGS.

(As a meta-note for reviewing this series, there are a handful of style
nits that I haven't mentioned, e.g., if (... == 0) instead of if (!...).
But since the xdiff code doesn't match the project's style conventions,
I have avoided mentioning it in my review.)

> +		for (usize i = 0; i < (usize) xdf->nrec; i++) {
> +			xrecord_t *rec = xdf->recs[i];
> +			rec->ha = xxh3_64(rec->ptr, rec->size);
> +		}
> +	} else {
> +		for (usize i = 0; i < (usize) xdf->nrec; i++) {
> +			xrecord_t *rec = xdf->recs[i];
> +			char const* dump = (char const*) rec->ptr;
> +			rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
> +		}
> +	}
> +
>  	for (usize i = 0; i < (usize) xdf->nrec; i++) {
>  		xrecord_t *rec = xdf->recs[i];
> -		char const* dump = (char const*) rec->ptr;
> -		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
>  		xdl_classify_record(pass, cf, rec);

I am curious why you are calling xdl_classify_record() here as a
post-processing step rather than inline with the hash calculation above.

Thanks,
Taylor

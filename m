Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F563C5546
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591781; cv=none; b=alEXUu9uE+FSPurv9d07xQcKZuzL//7vlxhlVkAUvFKlR7Fv4urRC85yLIpVeUXp87oWTCvG8pQx7oBuTky9cMt8EuJ3HFTukDDpHi+x0w7z+srfrYuI+VvGsb9j0qV/SEL29Flp4sxIUCmsX+NUJJ3eDbuU1lYnj0q49E69LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591781; c=relaxed/simple;
	bh=dhmDupaGiZsnLo2dQ7yQ5pqeq1/wmmDijJD67VctTW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAy2l58mkyOrTE48luoV5elaTomSEpCDW5z1bh9WJBplz501iW3446HVgOcbwOhPoWjgzg6ZPLV9hRt5QbioknUqCjNVTu+mJzhztjSXlS2Xq7BMr1xzJRYH1clJsGgpJB2pUtPc+6uccYSii4kIJIaaXTQxfy2k3iTr1nGPmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U5uIfGkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hVH9vZHI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U5uIfGkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hVH9vZHI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 572A51D000CD;
	Thu,  9 Jul 2026 06:09:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Jul 2026 06:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783591779; x=1783678179; bh=aM3VcWX7+l
	y52ha8EmU9E5V5EkII+zkHR4Vs4XgzjE8=; b=U5uIfGkrKDRAVQcZwx2ImNOatc
	L3xtgC/tWBwrUznABFcpTfO/WZx/qDCTZjBFlMuuQGFrXgCGAvSNMhSACmRs/XsP
	x3b3WXsBe/gofLxNCHm0IFsEkhhiLWk4KNmAcR1//FStGvt8Z6l7wZ06Fu2Q1LUg
	hx5IniW9RspkUPjQy2riOlpOgbTfkBs1A/JzSJM2R1Mll573vepWp6S2H5SJxvIJ
	jpjhvhsVBdocZ+06nf8bKX+mXtn4cDfvaqYMH2jqTQl+Q1fUuqfv4WO426jEasSQ
	CTSVjDyGJq0N0zl1Q5GMVS5z1UjbhEkFeMNsXLjdzMVtfw5R5UV/Mpw1B+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783591779; x=1783678179; bh=aM3VcWX7+ly52ha8EmU9E5V5EkII+zkHR4V
	s4XgzjE8=; b=hVH9vZHIYHB0dFLk+IrNrxhwJ5NebuBn4XU3BZJ71EZkDp3AY7l
	HLWGgIW3sDYnp9aLMCcdqQqYlg8Pl6d7Fl4tNf3IKNVdT5j044xspEMGhCdWHX+B
	CncV1Ehxy5dzFR+lKv1X1HTB1IS9s4tNEnoNCbI2RPBCEDSPhfcNVzGO1rw9D32u
	Htt/qfPhOda6WIlW6M3bXYgoJxvW3lzicGFbYyrSL1rxWaZUiDojDP2PQc6oVbpI
	ro60jvFo4dSZkDOe7doJUc+uKbWDbWIM9JEfqeudAX/JhpGEFCIq0w16RP2Q4cwD
	FzVSTq4eRRimTzA5RGJmgxD+Yg1dhXdp9qg==
X-ME-Sender: <xms:YnNPasUOttZsLP-ZvJrxX6j4_shWvZQNKk0S1vs-naj2ZZfATOm3dg>
    <xme:YnNPaiFyBvaM8yGUOECR1yiPUUuijSFlgBLUU22qVwnxYoHlxuc_sxoS-GqX4ue8b
    bKwjNSNd7LzlQDX2SZQv0T0pEth-2hrzVnJepHE_CyJgSGhlzPquA>
X-ME-Received: <xmr:YnNPagf7yZQR7sFF9PjZDi8zlMhVED-SSESjNKX0jxxh7RgW3ssG-OPeRD_OVBkZeEWmyKjsnKsrFmWUr-j7tpf7dqkEHNlkeeRb0YDmyQ>
X-ME-Proxy-Cause: dmFkZTFTvzLtv2/AqXlKoh+QH2oRCNyI1j7DOIvi2AtCuML/18MbEKHljx5lXvZ2LYemkV
    kr3U2ED0VUQds7KeyC32h+c6hBQ+wi44491wGI1YNAnL4FSIYK8IOECAvYV1o3pZvNttZn
    tL29FXmeBHmrNGmBElLCOLWNdxrcdUnmp3WdwTNPpKEdWnuebznhrBvZj8a8YD2zC4g+aR
    ffSF256LxQ2g7NvjaxCy2BY+tMmWe75RdsxRYnxfcDX7b90AkPv6Hn7Yzqk4bGzDTQM2p3
    Sft0pVMu0soYjuSFP95EiCI6JDhtGbvPzwcuHguvGbDeKsl1q6iv3664/uYJJ5vGdhtUfD
    7oh28JT43fU0clatUaVWodPP2uIMOhGQGSDWu4/g405+sKT6Kr8cUv9k8B+MyPs7rFajei
    sIqnR3+p1YiwU0WqdaF4sm5pDI+2P4P8ZI/Fi8crLBZr9QEyBbXy0+pNBKymYAxaeyVwpc
    4bcxCspFQuTCib2W2WLYP4AAj+n/KmxLr8U7X8h0snVqwWBURs1MQWFdB94ksB2uCPJIyl
    3PuXhsgQs7iuKEEsE97G2rhT+tviObiLcQYpnhWpsqEXcAjGrXM/qZgNne++3IoCoWshA9
    M0o2tfzi0eskPgEDbxQRRcNiJM4393FnwEbcqnlycv+fPnTv9bSrewpwaXEA
X-ME-Proxy: <xmx:YnNParKF-FESPYX1X3xlT3SK78qhQaII3IKToU-IJQoePSv40Dx6xg>
    <xmx:YnNPatEgQCGzpolJ4Q5RR8N_-k4QPxe43JiK-R6rN9lrZP-avsyfgQ>
    <xmx:YnNPamAA5zvwrLu6vx7u8jqfwrNGbtsglbZzReHQUX2C8Aer46aduQ>
    <xmx:YnNPao_D9Ow0bthHC7QZvEL1C9-VFzq3VvODKXyxyNk-etuEcDeLfA>
    <xmx:Y3NPajKnuJdCxY8KlzkXEV9h1zbIj_P7z7rPuqUZF9Ig-uhsCs4Q-CpH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 06:09:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5e76fe07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jul 2026 10:09:35 +0000 (UTC)
Date: Thu, 9 Jul 2026 12:09:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v7 2/3] repository: keep a symlink-preserving copy of the
 worktree path
Message-ID: <ak9zWopOWpRVHmmS@pks.im>
References: <20260709-includeif-worktree-v7-0-e87e705e8df6@black-desk.cn>
 <20260709-includeif-worktree-v7-2-e87e705e8df6@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-includeif-worktree-v7-2-e87e705e8df6@black-desk.cn>

On Thu, Jul 09, 2026 at 10:41:42AM +0800, Chen Linxuan via B4 Relay wrote:
> diff --git a/repository.c b/repository.c
> index 73d80bcffdf5..a29d55a6fcd3 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -149,6 +149,11 @@ const char *repo_get_work_tree(struct repository *repo)
>  	return repo->worktree;
>  }
>  
> +const char *repo_get_work_tree_original(struct repository *repo)
> +{
> +	return repo->worktree_original;
> +}

Feels a bit heavy-handed to have such an accessor, as we could've just
as well accessed the member directly via the structure.

> diff --git a/setup.c b/setup.c
> index 0de56a074f7c..fbbeb95f99db 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1213,12 +1213,94 @@ static const char *setup_explicit_git_dir(struct repository *repo,
>  	return NULL;
>  }
>  
> +/*
> + * Do "a" and "b" refer to the same filesystem entry? Both must report a
> + * nonzero (dev,ino): some filesystems return (0,0) for unrelated paths,
> + * which would otherwise look identical.
> + */
> +static int same_entry(const char *a, const char *b)
> +{
> +	struct stat sa, sb;
> +
> +	if (stat(a, &sa) || stat(b, &sb))
> +		return 0;
> +	return (sa.st_dev || sa.st_ino) &&
> +	       sa.st_dev == sb.st_dev && sa.st_ino == sb.st_ino;
> +}
> +
> +/*
> + * Recover the symlink-preserving spelling of the worktree root.
> + *
> + * strbuf_add_absolute_path() already consults $PWD to keep symlinks when
> + * resolving a relative path, so set_git_work_tree()'s other callers get a
> + * symlink-preserving worktree path for free.  This function exists for the
> + * discovered-repository case: setup_git_directory_gently() chdir()s to the
> + * worktree root *before* set_git_work_tree(repo, ".") runs, so by the time
> + * "." is resolved $PWD still names the caller's original directory and no
> + * longer agrees with the physical cwd, and strbuf_add_absolute_path()
> + * falls back to the realpath.  We close that gap by deriving the logical
> + * root here, from $PWD, while we still have the original physical cwd and
> + * the root offset in hand.
> + *
> + * "cwd" is the physical current directory (getcwd), and "root_len" is the
> + * length of the worktree root within it; cwd->buf[root_len..] is therefore
> + * the part of the path below the root (empty when git ran at the root).
> + *
> + * $PWD, maintained by the shell, may spell that same directory through
> + * symlinks.  If we can confirm $PWD really names cwd's directory (same
> + * device/inode) and that the below-root suffix matches, we swap the
> + * physical root prefix for $PWD's prefix and keep the user's symlinks.
> + * Only symlinks in the root prefix itself are preserved: the below-root
> + * suffix is matched byte-for-byte, so a symlink below the root is not.
> + *
> + * Returns the allocated logical path, or NULL when $PWD is missing, already
> + * physical, or untrustworthy.
> + */

Oof.

> +static char *logical_path_from_cwd(struct strbuf *cwd, int root_len)
> +{
> +	const char *pwd = getenv("PWD");
> +	size_t suffix_len, pwd_len;
> +	struct strbuf path = STRBUF_INIT;
> +
> +	if (!pwd || !is_absolute_path(pwd) || !strcmp(pwd, cwd->buf))
> +		return NULL;
> +	/*
> +	 * $PWD is a plain environment variable: it can be set to anything,
> +	 * or left stale after a chdir.  Only borrow its symlink-preserving
> +	 * spelling once we prove it still points at the same directory as
> +	 * the physical cwd; otherwise give up and return NULL.
> +	 */
> +	if (!same_entry(cwd->buf, pwd))
> +		return NULL;
> +
> +	/*
> +	 * Drop the below-root suffix from $PWD.  It must match the physical
> +	 * suffix exactly; the only spelling difference we accept is in the
> +	 * root prefix -- i.e. the symlinks we want to preserve.
> +	 */
> +	suffix_len = cwd->len - root_len;
> +	pwd_len = strlen(pwd);
> +	if (suffix_len) {
> +		const char *suffix = cwd->buf + root_len;
> +
> +		if (suffix_len > pwd_len ||
> +		    fspathcmp(pwd + pwd_len - suffix_len, suffix))
> +			return NULL;
> +		pwd_len -= suffix_len;
> +	}
> +
> +	strbuf_add(&path, pwd, pwd_len);
> +	return strbuf_detach(&path, NULL);
> +}

This feels quite awkward to me, and I assume that these changes will
lead to conflicts with ps/setup-split-discovery-and-setup.

I wonder whether we can maybe avoid this whole mess by removing the call
to chdir(3p) when discovering Git directories in the first place.
Instead, we'd only chdir(3p) after we have fully discovered the Git
repository's paths, and that may allow us to not have to worry about
reconstructing the logical path?

It's something that I wanted to explore after the mentioned patch series
has landed, but maybe it's something we should try to do as part of this
patch series here.

Alternatively, I'm less certain that this complexity is ultimately
really worth it now... so another alternative could be to document the
issue and fix it at a later point in time.

Patrick

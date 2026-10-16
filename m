Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB0400991
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137676; cv=none; b=HYVDX51f2g76mlRIo0HhJPiHnhbRKkN83HrSdY8SAKHUUZrRWYeNHx0+uY0u2v00MVWz8fnZ/fir3U1qblaExOt5Lr4A1/YGjiLoeGanmrgQbz1MMQF0wW1FRFrPorn7KfzjbM7MrXo1Z6Dfdgk0EQZ6rsT5W2DcNm8SJYhIbXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137676; c=relaxed/simple;
	bh=/W7bv3vl88hBr4udd0tOVAhug09te/GUUCAFgkyEhN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHbqFf6PIaL+h0LjZ5A23LQ4zYT2PY4xcZG7DLnwapj86N1KvQ7tcr3TcG1ddownHpHh+IqChLkOLnWSWyJIrl/RznfhwbUB1CU3Xk4UxkMkyHmIPcb+Nh+vQrJUAdjfDVnlhLxYroTT/I/40xTeSZA/Q0kZWW9yv1MaZTDNVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r+8sN1pv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yem4JevZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r+8sN1pv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yem4JevZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D202C1400093
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:01:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 04:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792137673; x=1792224073; bh=wbePgL6AHO
	uU5KyYYxAdUvofGLCN9Ncnyxv+4OMTLek=; b=r+8sN1pvnnjgxeQIl/VdIJoaFA
	pBQq+gzk8acDfcdzINi7l/K69PB7JKX6QKbWG4pJsoB2Xe77W0tFBclocDdiH8R5
	KJBqH52qzpxRV5P+dFRJo4lvrps1X9wABjphK43325gFKfnMfI7cm/ZE9uekt6zz
	PkeQZ52LpGPFOoJ0FIsk8nbEjKHcyj+pN6LcZ4GmRKT6Dtb7wlAkm9iuiSKuy4rW
	AtEw2M3HFJHaIs1lP2fvjh+IKZpwvtmqlrcXwPKEvDjMwAGZe28gS6TqNspKOVDB
	uGS6cOfKQl2kslVU/jeqxYQc0C6DQkfXBBxosyzdOHL5P4jewiC3wcWZyrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792137673; x=1792224073; bh=wbePgL6AHOuU5KyYYxAdUvofGLCN9Ncnyxv
	+4OMTLek=; b=yem4JevZp0EJ9bSiBtbIfvDUcqfH0H+IGCQnZ6v+ZeA7PFhVxsi
	8zljqNJx54ANaa16qtmMiBy5ZgGLsDI8aBWa8nRLOyzEsnNXydI0w4ZxBJ3K7OoL
	nOqq7HjtPn+sleMdA/9eMXor4uQnSm8e7pSyeOfdQm2+OUwZ4ZQeqDvQKmjFIw7n
	Dj+fhO+keKulmYz5EiJRIR3375FBqJSHZ7VYN5eBpRNPdi5Z1BREZ3KwiyIJcGOS
	ebp+jD82a7X/pRFv+ouvXfw/Xq1Kn/gVVVEFVJ7dyO/KjPTFDGBt5H9x5Oi5HiuI
	6QolaCxWaDvMd/LJe/zSNBozBjRPwChPtwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792137673; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XweraotIc7tLnXVUmSlOZsKyQLMXnXphRnX6vXAzQLGbZNB
	vWlih0SP5SvojDLES+GP1/6H/w0rWSoCshwZ/ALCpw3AmJL+AQdR8ZD0Bqh8whw/
	8Hw+7wqPHknk+6h3vFIS76ZUX0CuXYfga5C8K5iTwg3nMLU+guaSB18E4MwFY0yi
	Rb1ferKjt4uu6TSB19ZgX0apNNF/tKAb6SqDmJNYSxRDReHHnO2D3UncM3nh+Qae
	V0to+kQGs5SFgAyxM0bwCCKHi5pnXMi/1/1zlNwrc06ZVPVA4T5VUiqYoMg89ZQ+
	ysHjamR+p2xMbC/xMiKnRKkahZzHYLwPPy+Yz9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+mKCuSUL+Bw3i3ddYXtLXlkQyTGXcpS5i/lJZsQQr1k=:/W7bv3vl88hBr4udd0tOVAhug09te/GUUCAFgkyEhN0=;
X-ME-Sender: <xms:ydnRatvz8VUY9TlYCZcNRDju4AeusyRiSkCzyBD68taSwslSD5xArA>
    <xme:ydnRat6N0WLiIOYyo3npuNlETbLHda7YIH-QfIDgnlZy0eBXFEx3YH42MAnuzFFyC
    6JuJPjFy3suD7RgqpkSa5Y4oIpcrQUNsTemLfhHyNbYL2dh5cQ5tDM>
X-ME-Received: <xmr:ydnRauLj1NmT4_PhPWw5cu1sKVH6_HkE3QmnUs9UwyK9wc7x4r7qBg>
X-ME-Proxy-Cause: dmFkZTFTxrl4vij0eX7NpmRMess7sE4iw44g5Rq+2/xoj31ftHVhs5TpoqnpzmTTdhj5Yr
    6MPocx+bsQzIvseuLoeU9O0LYYBtGOqbY388XhTOvnkF9hlGy0yvjJwkQHhVbi1K7MThQT
    RhJMFjxZ1DzdPfzHJ12ikY+4DpCxEmAM8x0hdGEKuSs1pVKS7WecUkzAK+vwGYjniCFb31
    ZxNMXGMYwkobeO21Hmr1LPQu/Rrnv4RR+VxwPlxmjdgMfc5yWS5ttwFm7CzeEcFYR9d+9H
    qcz9QwnH3k0k2Vkk22Uyrg/ChRdPo0sZyTIUauUcoE8yA1Kv4C3ls7D8bc5W2L7IqtLCb5
    Dl0GKBWLzsHjj585Rui2qfdQFWO0QKKveT7fTZFbUYjXT7VqAlrcWF6ilgTnh0QaPoCgCZ
    0u0tBwyqa34CzcnhOsgyRMfnkBbQ0hoNrL61jTJHuHgJlkR788G7kvLjoeBFzlPZJkvAjd
    jZ2P04UxkggvxvmMI3z+Lofz1mWQ1SUsfJw+R+LgD7QMvFESNJfs6sycr/FzjqkoY36DwW
    gBBmW9HflfbmsKJShuqp1K6E9iAa/GHdRM0LgBgNyznOFezoBEaqRUEvUpaGJ7YX+IN9VB
    4S2A9p6uLxvufzy9PZ4F/b4a9J7cYYHQaEastpVEKSPIoM0h4+JmQSBdeUvA
X-ME-Proxy: <xmx:ydnRat6WhP3ucQA_ZKMUtsn9O-Kob7c-F_FdTwP7z8rpri7pbzo0sA>
    <xmx:ydnRahwsCRSm-Oqm1HT06AYm_DagwV4RVC7YJBeNamOTW2r2Yzfsdw>
    <xmx:ydnRahZx6sEd5wCaJxwmMWN59iccLO2znE6VeG71dH6botVH3Ha50A>
    <xmx:ydnRajT0hvTNsYjVMMjlpZY1kx79ehjxGLsXlUeb5vV365j1_tFkTg>
    <xmx:ydnRap75qSCtumI4hpmre95vxAwye5J7uZyaUw4Krf2hJ6UWNM60l4xz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 04:01:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3b7b837 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 08:01:10 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:01:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] completion: fix Zsh handling of stash names
Message-ID: <atHZvexnI0Ia7Xjr@pks.im>
References: <cover.1791827304.git.ben.knoble@gmail.com>
 <3d1cd00dd8456aeaf8259767d9e33b7421aef9c4.1791827304.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1cd00dd8456aeaf8259767d9e33b7421aef9c4.1791827304.git.ben.knoble@gmail.com>

On Mon, Oct 12, 2026 at 01:48:29PM -0400, D. Ben Knoble wrote:
> When Git completes stashes for Zsh, it eventually invokes something like
> this (via our redefinition of __gitcomp_nl):
> 
>     compadd -Q -S " " -p "" -- 'stash@{0}' 'stash@{1}' && _ret=0
> 
> Because of -Q, the braces are unquoted, and Zsh will leave us at (for
> example)
> 
>     git stash show stash@{
>                    cursor ^
> 
> From here, the list-choices widget (on Ctrl-D by default) will show
> stash@{0} and stash@{1}, but the complete-word widget (Tab) will just
> add another brace. Zsh things we're trying to do a brace expansion, I

s/things/thinks/

> think! Interestingly, using menu-complete (Ctrl-N) does cycle through
> matches, since it's taking a slightly different completion path in Zsh.
> 
> We might try to fix this by passing surrounding single quotes (using the
> -S/-p arguments of compadd, which we can do via __gitcomp_nl's other
> parameters), and indeed Zsh will generate
> 
>     git stash show 'stash@{
>                     cursor ^
> 
> but completing here won't find anything, and I'm not totally sure why.
> 
> Instead, though, we can let Zsh quote metacharacters (removing -Q) and
> everything "just works." It changes the output format a bit (users see
> stash@\{0\}, for example), but I find this an improvement over not being
> able to complete names at all. menu-complete is unchanged aside from the
> extra backslashes.
> 
> So, override stash listing completion in Zsh with a working version.

Hm. I assume you tried finding a variant that works for both Bash and
Zsh so that we don't have to carry this override?

> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index d5c526665b..2aea7770d2 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -135,6 +135,11 @@ __gitcomp_file_direct ()
>  	__gitcomp_file "$1" ""
>  }
>  
> +__git_complete_stashes ()
> +{
> +	compadd -S ' ' -- ${(f)"$(__git stash list | sed -n -e 's/:.*//p')"} && _ret=0
> +}

Patrick

Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3086235839C
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510390; cv=none; b=rKpymo+12CT50seQ7k4FYN7kIcsO1HDavmS2J+tbL7Y4HVppVbkFPQ+Y3O2vDwhjNGYFTyWzvOeEEGlensQ2vqTpksjyzT+K0hlx4sUfGPLkz2r7yQfR/iYSQNmTpNF/a22eoJVsWTvGQRi4PSdpJCRo6ejp7FS55WwwcRZMLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510390; c=relaxed/simple;
	bh=pDb6Tto5ukI6MYsN/hA32mcpQ+qHlMPBDFPv7+Pg1h0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knQoO5CYngS7XyMFF6mj8+ueMMRGTMNFQKQQlGBQGKh4HJFGnXjxEYn6jGru++apD7Azr4PZk5z698EZl+hDDDFq7JjpkxHK3ttnZDaDl5MiFjo7dN1MN5O0S7xLKPHk0hiDqUSajTyZKokIKjI1O9r2Rchh+Xkxa6VCrrzaaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NBuEJDxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wy8eNfl+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NBuEJDxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wy8eNfl+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C4947A0169;
	Tue, 15 Sep 2026 18:13:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 15 Sep 2026 18:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789510387; x=1789596787; bh=CPhIboR/6j
	iC/2ObCG0ETaEavKBSVmvZDKjp5GbeK9M=; b=NBuEJDxBjKlgfmR27YZZ0bpvvA
	kWBaolG7+FJExBh/37iYLKdAyLvtP3dQQTL1WDEARtfgYCCTpoy1wrwDH+Q5m6hZ
	90Vz6K8GRQ7rcB9G0HJpnVGmLPb+lUg5hmMeL5MkePGa9i5YEfcCVo7KNEYVC1Ua
	r7n8aZXov9ANOLiN4EWlpSUDRcBAf/ZdXxzHQWcQJIWgao2K2AyhqXNVJicxowAs
	A6veuHx6RgITlcjiBHWHgx2Ik7nEdDtBf0xmLTSMV7RoTs2yl5vdySMQV9dMhxz5
	2cYheTBJR8P7Oo6F1lgzWq3zSfKDhIBOSZaYMdbuMj5HNwl8l1F3DuWs+M1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789510387; x=1789596787; bh=CPhIboR/6jiC/2ObCG0ETaEavKBSVmvZDKj
	p5GbeK9M=; b=Wy8eNfl+E7eO9rNLiD5YWwa+8jvBitHko67n+9PUUZVYHzi0yyi
	tdwkG2RzaegN2yqUxTzdJD8ydKkTkvbXvuTBCtv2Imx6oaacDlV/BuHOhMFhPe6y
	JAzYxrP8Hw3PCf6B85UN0IFIYxo8ibWVdSLmzcttFFGyLpOKMAh1ud8ABS8/Y96X
	I7O2KKG38rAf/uuB6UM3cxsAp4bQyeX1ormZkHcSvbyYAuOGGSD+YQX6n4H9Wnq0
	XTzpjTfleF5Gh2zu6QMtO2JOjMts/ot//buCY++y5lmisi1qbisJNpczOGlhfhLU
	J0GKNccFVLcoo62EmLe0JWtzoYUGp4nZFfA==
X-ME-Sender: <xms:8sKpal5HdJLQgmwQFNiU_SUAGG-u-yig6jLBzGPUwV5hCDCw3E1yWg>
    <xme:8sKpapy9dT3xoxVV4uqCKUBENrPIMV-b099VjmMts3BukhJTHl3p7TUwYR9q4QwJ4
    tjbe4yw6rVjCab5_3BWbVcAb8SeOzGGPz5nMxljncWnmnu_kOYuCQ>
X-ME-Received: <xmr:8sKpakx2Xqr1Lku2PfvNSWqZcam5nqhSRBc1j3QNaOlk0-LHcV6-IObpbj32HKmSxcDZA6Hd_TgOdq-_HN4_R_xxXvo7hSWp_lMw>
X-ME-Proxy-Cause: dmFkZTFDkK7IKjxVnr580rYUmwc2xi/xmkODdQdXti6Om7E4Aa7mmslUCFAPvNN1vZE5mR
    xP11ZZHp0+CSS+tuj+SPBWalwGcQdiA6T61EPc7MYBlIs+vMg2Kom016gw3yHgcma/wmIc
    BnM9oXQY4XLTHcJQdHLKlBs7wKaYGwDfI9JfWEB3S4zl696A/ySp9XXT/L1tQ+Had803nA
    s5tvEm6sjfMoye9Fu0bjnG9gIbbKTO00F04PEqbpcK9eXJYq+0p451hNhBh3CcJIBNN26D
    PBP/JVi2SGEuv1Q6+nAwVdV6++7G10rI24dTHXYuO6P3Rp2dA50L9dAhdH4sNLkdG3ydgR
    7BFCVVKn2OHUYLifQ3ZviTHpgYauRqUNyUGGCmGCJxgAbG9rswRaBsUo1YnxLvvRgSpJyh
    svpEaC3YeRiRZdc9vNWDUGNQcS/H34s+tMKyM5SlNLPNlsPG6tPieMOgI7OfjOsBGvzUiD
    RbHi7XfvrV3L3heFH6aBjfiZtoKadcgyJ/thD/hg4h7dso4B6Hn1F21XHOGaZ6FEmqrtMT
    4uWjz95c/NEcarvb0W3/Im9+BNb+71PJwJN4nromUxxbxzzoFad4gdao0o1mENS/Z006OS
    TnXIuBYbBvzw6xEejpxjFf8ucaczW3EFgVjIdnTTvURMaCnO/QdVmgaok8qw
X-ME-Proxy: <xmx:8sKpapzQMeSHgCJbU8lRdH0Inm1nYCRCc9N0hJPhE39PkzMZMALzdQ>
    <xmx:8sKpama3h7dtfv_QlLr1Jf3wOShBCj3QChpWDwBAZxInsH0ThESFUA>
    <xmx:8sKpaiUUk52leCoghiMihqgU4T37at0gvB-tKKacgVTGJb_tV0EgPA>
    <xmx:8sKpasgZDjrbgaHiPIJSi_KrfMn5Ffawi42X8lL0pNaIbs35-3zetw>
    <xmx:88KpatP0IMW7wgYS3IhELNhNK3wNVLWtLQdN4qbLaRU2pSB7zU7KLgFl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 18:13:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jiri Kuncar via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jiri Kuncar <jiri@kuncar.dev>,  Jiri Kuncar
 <jiri.kuncar@gmail.com>
Subject: Re: [PATCH] pull: avoid crash of invalid merge head
In-Reply-To: <pull.2223.git.1789252459520.gitgitgadget@gmail.com> (Jiri Kuncar
	via GitGitGadget's message of "Sat, 12 Sep 2026 22:34:19 +0000")
References: <pull.2223.git.1789252459520.gitgitgadget@gmail.com>
Date: Tue, 15 Sep 2026 15:13:05 -0700
Message-ID: <xmqqld92xixa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jiri Kuncar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jiri Kuncar <jiri.kuncar@gmail.com>
>
> Adds NULL guards for lookup_commit_reference() to avoid segfaults.
>
> Those invalid references are possibly caused by parallel fetches or
> gc racing on the same repository.
>
> This effectively treats failed lookup as "not up to date" so caller
> falls to a normal merge, which reports the broken object instead of
> crashing.
>
> Signed-off-by: Jiri Kuncar <jiri.kuncar@gmail.com>
> ---
>     pull: avoid crash of invalid merge head

The log message sounds a bit unusual from our norm (see
Documentation/SubmittingPatches).

It is of course good to deal with a corrupt state more gracefully
rather than crashing.  From a cursory look, the particular solution
chosen, to drive the caller to perform a merge and have it fail, may
smell a bit like cheating, in that we could diagnose the breakage
better by reporting what was broken at each place, but it probably
is a good choice.

If we really want to improve the situation for 'orig_head', for
example, we would probably want to turn it into a commit object
instance a lot earlier and pass the commit object instance around in
the call chain.  Passing around many struct object_id instances
instead of object instances is an unnatural consequence of how this
program evolved.  It was originally written as a shell script, and
of course passing hexadecimal object names was the only way the
script could drive 'git merge-base' and other programs to see if the
commit recorded as the current 'HEAD' will fast-forward to the
commit that is fetched from the remote to be merged in, for example.
Once we go that route to resolve object names early to object
instances, we will not have multiple lookup_commit_reference() calls
on the same object name (which require us to watch out for failures)
to begin with.

The above is a long-winded way to say that it is a good improvement
that does not do more than it needs to do and we will not have to
spend too much effort to undo when we revamp the internals to do
"the right thing" later.


> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 27f38ab3c8..7a3eadddd3 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -888,4 +888,30 @@ test_expect_success 'git pull --rebase against local branch' '
>  	test_cmp expect file2
>  '
>  
> +test_expect_success 'pull does not crash when a merge head does not resolve' '
> +	test_when_finished "rm -rf up dn" &&
> +	git init up &&
> +	(
> +		cd up &&
> +		test_commit base &&
> +		git switch -c sideA &&
> +		test_commit a &&
> +		git switch -c sideB base &&
> +		test_commit b
> +	) &&
> +	git clone up dn &&
> +	(
> +		cd dn &&
> +		git -c fetch.unpackLimit=1000 fetch origin \
> +			"+refs/heads/*:refs/remotes/origin/*" &&
> +		git commit-graph write --reachable &&
> +		oid=$(git rev-parse refs/remotes/origin/sideA) &&
> +		obj=.git/objects/$(test_oid_to_path "$oid") &&
> +		test -f "$obj" &&
> +		chmod u+w "$obj" &&
> +		>"$obj" &&
> +		test_must_fail git pull --no-rebase origin sideA sideB
> +	)
> +'

The "test -f" there smells more like a debugging aid for this test
than making sure the fixed program works as expected.  I wonder if
it is simpler (and more portable to non-POSIX environments) if we
replace the "corrupt $obj" step with 'rm -f "$obj"'.

Thanks.

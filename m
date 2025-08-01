Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14520C004
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037073; cv=none; b=rRZyY0TgfzU8rMq2EJax6lFmaQ111TQBeL6Skb20S/sfyyQXLoPI1ZSSX4qTcV69emxQB7foGRB1V85cBBIBIhR/IelrzbqEZ9kGGiJzxWq0aw45I/Zd29bkpO5hTHP6gMFyij2Bfzn9mYtXVgnCe8oKf9kJLyBQ3uk3zgH1zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037073; c=relaxed/simple;
	bh=Tqoht98PG5eSzSe9KTUQqYZ0Uh5agsciShxjP+zd2ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptgQjscNA90/Tz8Dr/LStE/OZ0py9zSaDmqaKO/Jy1hUEsuXSGqhoYX4beYMZJYVQmhKlr+Bs0sYjKzCbC3IpUlBElmXTCFxPyjMbE+GmLHj8pg4q02Xr1Hl+L6RABvNTFMWTZf97/FfsQXNek9ih2a2qwoCy/yjXqwDIUkozEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eEGl0JE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fseEZz7R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eEGl0JE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fseEZz7R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F2681400246;
	Fri,  1 Aug 2025 04:31:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 04:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754037070; x=1754123470; bh=EJp2oqWjVu
	y58dh37JNQuLPAR5xU4G6BiA8TJQhU8eE=; b=eEGl0JE2dPTJYwFkWYk8WHCOPZ
	xtiTdqOvfnQnQ9t9EzSAAZ2PExTz4hTU3d5G11fQi1tLFCZpBYsEDGnUZ9v4VOQ/
	XgxYgg7kC1djvMLaEW1aud8IVyvfJuMhLoBbgBM0Hfbr7B4P73AGbMrMUa6UTDBN
	lPxg+8wBmxEDD8SBatXQ2by4AAsVHglA+cr/SEemcnHPf1A6RhFvcWOubFYQTivX
	3g9udMRnPNvZHufZuOEK5dJWrSFuAsQFke//VA9VMnirG6exhpdXG0mJq2Wgp16i
	peGv54ADcTTf6cVNq1u1mpluZXYIYTuowbrxhsHmLoTP+LFEKBjGkeKOllTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754037070; x=1754123470; bh=EJp2oqWjVuy58dh37JNQuLPAR5xU4G6BiA8
	TJQhU8eE=; b=fseEZz7RMcTKBPbo55zWMxmJ9dBf5Z2AnpyxT0Q/jqVjjozeDS4
	VWwALz6TictQDzUHYtwxdvHdeZ2xr3jcukJXayw2wsgNIMk62eAiKFBFyX29n9yc
	qeb/LvoGpN/fplNekUUzzxO28pSrCyE3CAviPun0L8cqbDGXErSe16OnaRb4Uexi
	Hh821VctawhHM7iLGgjfq7tRJzTQngIPm8zGcxDy3uzcMYN0mxXqGlzUbbcdGm36
	zLzfXnT/zASX4RCbrnhXLeLT9u3+3Yw/skDzqSjEJT1jOUK+NJo/59vJIZV821EM
	FSg2rqJl3cPXiAtDMKodqudToMoSTwYnMdg==
X-ME-Sender: <xms:TnuMaOTeSCe4ofuS2AqucsAwIATU8k2LA_fh8YsNLxXZdJCVmkwU9g>
    <xme:TnuMaHDH9ZgSNcAvTjp0tTbesFT4s_dvcRuMSXWQ7DQmj-yrM_z1-iRuK3JD4haP_
    El5OfxELzlBMakjYg>
X-ME-Received: <xmr:TnuMaFQO39VcoJJ1QQDGdsaFAyhUEvqdwgL6TstHrNbkTRifnesE8x41lj2nsqyBIYiLWDfrjhZz7J1rzN7dwovSHltjQoiSOvNdg40t7bQq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:TnuMaFoNqu5gkiFh3ZByqNMfttcRoNw7t8oa9Lu-7rZjlRj_X7tt9g>
    <xmx:TnuMaHwM8Mt6dMj7cPNW_I56vuHGOWBpCUP9vu1kI8mAFUbCW30aew>
    <xmx:TnuMaKLCj_ikxkNkMeYoHhpqNGBUt3C0raX1aT1mKvK4HKz1mh2Npg>
    <xmx:TnuMaJIrmkqiuVgN1zwPO6pKQrB6j_D6ucMXuWcRVjTbEdNuhg5yew>
    <xmx:TnuMaJ_4L4lG2GJHHZYY4pW1tgXEJFBSa9aM_J0H4GUOzzfEjaD79e5n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 04:31:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cb32ccf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 08:31:08 +0000 (UTC)
Date: Fri, 1 Aug 2025 10:31:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/6] merge-ort: fix incorrect file handling
Message-ID: <aIx7SXfRabJWpa0D@pks.im>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
 <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7d4e022c59609bf263a7045fceb1854441bb29.1753197791.git.gitgitgadget@gmail.com>

On Tue, Jul 22, 2025 at 03:23:10PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We have multiple bugs here -- accidental silent file deletion,
> accidental silent file retention for files that should be deleted,
> and incorrect number of entries left in the index.
> 
> The series merged at commit d3b88be1b450 (Merge branch
> 'en/merge-dir-rename-corner-case-fix', 2021-07-16) introduced testcase
> 12i-12k in t6423 which checked for rename-to-self cases, and fixed bugs
> that merge-ort and merge-recursive had with these testcases.  At the
> time, I noted that merge-ort had one bug for these cases, while
> merge-recursive had two.  It turns out that merge-ort did in fact have
> another bug, but the "relevant renames" optimizations were masking it.
> If we modify testcase 12i from t6423 to modify the file in the commit
> that renames it (but only modify it enough that it can still be detected
> as a rename), then we can trigger silent deletion of the file.
> 
> Tweak testcase 12i slightly to make the file in question have more than
> one line in it, but which doesn't change how it operates.

Hm, the second part of this sentence doesn't quite parse for me. Do you
mean to say that 12i is basically left intact except that you change the
contents of one line?

> Make this
> change to otherwise minimize the changes between this testcase and a new
> one that we want to add.  Then duplicate the testcase as 12i2, changing
> it so that it adds a single line to the file in question when it is
> renamed, as a testcase for this bug.

Okay.

> Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
> assertion in process_renames, 2025-03-06), fixed an issue with
> rename-to-self but added a new testcase, 12n, that only checked for
> whether the merge ran to completion.  A few commits ago, we modified
> this test to check for the number of entries in the index -- but noted
> that the number was wrong.  And we also noted a
> silently-keep-instead-of-delete bug at the same time in the new testcase
> 12n2.
> 
> Fix to merge-ort to prevent multiple bugs with rename-to-self cases:
>   * silent deletion of file expected to be kept (t6423 testcase 12i2)
>   * silent retention of file expected to be removed (t6423 testcase 12n2)
>   * wrong number of extries left in the index (t6423 testcase 12n)

I think it would have been nice to also go a bit more in depth for what
the bug actually was and how it's fixed. You do add a comment, but that
only adds a single sentence of context.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c                         | 11 +++++
>  t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/merge-ort.c b/merge-ort.c
> index 9b9d82ed10f7..feb06720c7e1 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2873,6 +2873,17 @@ static int process_renames(struct merge_options *opt,
>  			newinfo = new_ent->value;
>  		}
>  
> +		/*
> +		 * Directory renames can result in rename-to-self, which we
> +		 * want to skip so we don't mark oldpath for deletion.
> +		 *
> +		 * Note that we can avoid strcmp here because of prior
> +		 * diligence in apply_directory_rename_modifications() to
> +		 * ensure we reused existing paths from opt->priv->paths.
> +		 */
> +		if (oldpath == newpath)
> +			continue;

Makes me wonder whether the additional brittleness is worth the saved
`strcmp()` comparison. But on the other hand we do have tests now that
would break if the memory allocation patterns ever changed, so that's
reassuring.

Patrick

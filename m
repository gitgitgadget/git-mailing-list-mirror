Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1D1C3F0C
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406046; cv=none; b=VWC/P/bj33gzvVA8QkmMQnx6PlqIi1q9OaTL8ZOyQY1qgPN0XTM1HQTMliK4N7Lwoid2GX4LbGKoaAtbSkBuJJWjUcpdIz7lLIADMCGLIOZEcM2jqzAwJd0MK0ApmWpLkQBA3Xx+J71oLehC9XTE9/Ui0iI3+8mznJTUxgxZCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406046; c=relaxed/simple;
	bh=9v9lVt2dHhKS0t2IoPLtfCQ4eZBXCESIEUAcTyZ8Sjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSvTbsE42jR+k4rTDi7Ntq5lI1fYEkt6Af0EkQyX6Fn/xEAbuvkB4ituYNHTqmq4iCcroJu7jeQJ8MGI7lQKR5kWepmCakbIU1JJ0r2LkuBq5ooUpIZGCoBwchyZm+25cv0mE97HLw+FiAherNjCKkyCg+/5Jj83RQ6I66ygoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X9bB4De/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NUJSOp/0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X9bB4De/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NUJSOp/0"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9508011401A4;
	Mon, 31 Mar 2025 03:27:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 31 Mar 2025 03:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743406043; x=1743492443; bh=7ZAfdeDqX7
	i0sIvhnJcYhmSmF6poz4sP/BoZDu8Q3X4=; b=X9bB4De/7A9LmvpmfWv6mtlylZ
	dN6DEtiSWDowDMAiWKJ/eYgejtpT381V3rVK6CMnoutBILn+a09rVc2HrpelS54s
	mDYf4khdNdQQuT2Of2/RIZlp0pIP0RBLbiCIdMIKZYxCskk4IqrZepS+94oNVYEK
	oPGC0hmJ0judpgB47ASoBZUj61LhM53jmAIkmn4da8p4A+u+p7YhxFoGZCsd/wiv
	BNg6Gr9cm/O5JiqhO6mOCGHsZJYxAxH/r5AmZ8NNTpX7ThoP0LChV/k9V0SG6rr7
	fLBG8cevrIryMNcuqO+iIP7zJwOvZfiyaTG7uH2nQqmrx65lQNmxSsmL3/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743406043; x=1743492443; bh=7ZAfdeDqX7i0sIvhnJcYhmSmF6poz4sP/Bo
	ZDu8Q3X4=; b=NUJSOp/0aUrq2Z4eLmMq1qnLlhix8qpJU7iNcMviE3V+1ByQJ1S
	Hz8JNDLODDkybAlwZBOL5odRh/qblGgZqs/bXrUBLTldfhigIqVkbRZ+UGgue9sv
	zLz142IhijuAkR1+atgQE8EEVYG7uBMUWIPJ4HsGerZ5Q6HKIH7qlh5VaFYLJGht
	pD6DY6M6qiAzRiQIhsPoTRKRxl+iJe8eBARj+STmEJ5yncvrt2UKGVp/UqUHRTY+
	BpI8ga9ua+yaQubTgAD+HChaFZigtGwDVp+EP0hl3ueQSWD5FsfZABdOJlIPIpwu
	Biqs9xxXT20OtFd04JLBnWFu/+xxrVTHsDA==
X-ME-Sender: <xms:20PqZ2eCHWEqvokBr-HPsITHP8QxCmH_zDFbp46t6qBAVF3VUwWQUg>
    <xme:20PqZwMso61HL_deplIUg8siwqpSgNBxsm8J2yY6PzBdIFT6adfZYpBTWbxTkkn68
    kiTE6p5J7H04Ys78A>
X-ME-Received: <xmr:20PqZ3jHKKzA8vdSOeByBdQY39fe6lotErmyFLkVXKgnVYKnRv5ukOa5OWDUzCE6EJ7PZeVEvn2E1gPqeVb7nnhbXb3hBUpwYTSFCDLpI1HvC6WC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvhguhigvsehgihhthhhusgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhgvvhhrrghiphhhih
    hlihhpphgvsghlrghinhesghhmrghilhdrtghomhdprhgtphhtthhopehnvggvrhgrjhhs
    ihesmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:20PqZz8qFiiYiTGUC978wmwq_ce8_jyHJFewJdgs5mLyszk51qWNcw>
    <xmx:20PqZytbvMt9JGEJ-B0ht4W30P8eZKW_nOX8BqQwEjhlPltvf1Fz5A>
    <xmx:20PqZ6EPps-kA8ZmsP5A6DzOb1sunMruuNXGe2nN94E7JCqJjCGp1w>
    <xmx:20PqZxPfyBSv4OzVqn2vTvvB29ldrm52oW2_5-ll7j_Mynf32v8Q1g>
    <xmx:20PqZ0W38K1fZKMrvU2lqNpTmJsV2SzN4f2necfRZp-w73TEq57BEUMk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 03:27:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0df0557a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 07:27:22 +0000 (UTC)
Date: Mon, 31 Mar 2025 09:27:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>,
	Neeraj Singh <neerajsi@microsoft.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] p9210: fix 'scalar clone' when running from a
 detached HEAD
Message-ID: <Z-pD2aeCJ6yp9XBN@pks.im>
References: <pull.1936.git.git.1743181669.gitgitgadget@gmail.com>
 <1092c32609f249839453052ca802cb10256cb48f.1743181669.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092c32609f249839453052ca802cb10256cb48f.1743181669.git.gitgitgadget@gmail.com>

On Fri, Mar 28, 2025 at 05:07:49PM +0000, Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> In p9210-scalar-clone.sh, we test using 'scalar clone' to clone
> $GIT_PERF_LARGE_REPO (copied locally as 'to-clone'), which defaults to
> the git.git checkout we are running the test from.
> 
> When --branch is not specified (as in this test), 'scalar clone' tries
> to get the default branch of the remote repository by parsing the output
> of 'git ls-remote --symref $URL HEAD', as implemented in
> scalar.c:remote_default_branch. When the git.git checkout we are running
> the test from is in detached HEAD, this fails and we fall back to using
> the name of the currently checked out branch in the newly initialized
> repository, which in this case is the value returned earlier in
> cmd_clone by repo_default_branch_name.
> 
> We then invoke 'git checkout -t origin/$branch', with $branch being the
> name we got from remote_default_branch. This invocation fails if
> '$branch' does not exist as a branch in the current git.git checkout.
> 
> Fix this by creating a local branch in 'to-clone' in the setup test
> "enable server-side partial clone", making sure to use '-B' in case a
> branch named 'test-branch' already exists.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/perf/p9210-scalar.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/t/perf/p9210-scalar.sh b/t/perf/p9210-scalar.sh
> index 265f7cd1fe2..56b075e906e 100755
> --- a/t/perf/p9210-scalar.sh
> +++ b/t/perf/p9210-scalar.sh
> @@ -7,7 +7,8 @@ test_perf_large_repo "$TRASH_DIRECTORY/to-clone"
>  
>  test_expect_success 'enable server-side partial clone' '
>  	git -C to-clone config uploadpack.allowFilter true &&
> -	git -C to-clone config uploadpack.allowAnySHA1InWant true
> +	git -C to-clone config uploadpack.allowAnySHA1InWant true &&
> +	git -C to-clone checkout -B test-branch
>  '

This feels like an easy and pragmatic fix. Thanks!

Patrick

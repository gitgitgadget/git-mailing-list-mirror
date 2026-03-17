Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208F330D24
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773785944; cv=none; b=dPtdVOeAXcRcfIbQEOoDTFneCgSOonlIEhvHorV44BgKSx5SGIt+jCIooFEZWoZFUhZb8AZ22D32uQH5/C0ydPFSS1EKg7KdqdiciVpMR7nDmwW6zmDFgEKb9pp8dvQ3vAyTFnj5pUO9orL6WRWE7FRyZutPtDSXoxgdNMagxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773785944; c=relaxed/simple;
	bh=eoYkbQFsATKqxo/4atqE3DQXz2znZ+HXWAeTTdn/leE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GSHLSFCNyWRL2Y57lKWl2o53B9Y1t/UwDw0z7r0q/UZC2BYI5lYx7iV03vqUcQ6bUKCnFHTVzCSN7KFJtcQKTo1MZFmw+WS6qxsFNpAoOCmAd2GIcxfLWPOnbGSYNpZBBUzV6CcuPIeodQpddjnrSCdqd9SXV0OeyBvZy+m9694=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PuRNa651; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcDULhUQ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PuRNa651";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcDULhUQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C2851D00030;
	Tue, 17 Mar 2026 18:19:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 18:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773785942; x=1773872342; bh=976eshJObh
	WMf1xRPy3oPEaYdDdJQEaR/LA6Xt70SFc=; b=PuRNa651TisRh5kxoNLstpOVq/
	QlAzVsv8voyVHvmyYBwzjxGKLGYBxfiX4WcSyDuf3Rr2ath3LkXHTrFUY/+PrMAC
	SCI2TT6/NsvkQpNG1IvvewbG+CgX7Gh8ozyydwrn87o5YouX/Leju7H/Dfz9mUaO
	hcj+tdKzEUQOVcKScTNCxDWf021Qtxb2p/XrHuHKJyYqrLr1KH+pyJPdtRUmDQXY
	uKX78rpTjpvWJmKVAnCPvyQZuk8f7CzZsjpGmCUpo3qwNKwAh19DHG/cJqRvkNyp
	k4im8gRSYjYRxsDLhCy1Y6oa0CHJINugOV8nmsyr0hUc3fHkaDfkkT0Zy63A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773785942; x=1773872342; bh=976eshJObhWMf1xRPy3oPEaYdDdJQEaR/LA
	6Xt70SFc=; b=QcDULhUQbaJ+qxJkQoDSBP0bu8HC9cJEnZm1xwx6pV+Bkf8pBBf
	u3FzQu1H7PJm2eTZDa0jOLNRALoZQRb1+7CRVFI0l27GCOGXCZt5KsOXAGQgbKNW
	zvfbVUdN8H/4OzZjFugVVHA6aTkadQuYiaSSrO0VHEvPIFv7WRI41Cq8O90SUvhs
	nvo2pTsS6McCFKhW+0K23rmwpxD4ZlF4i/rKFzcm4vGtB8eV0F4xRkBekOzbITtG
	mfOMU7+xM65EFMPxoIpKB0qHE5ITxfHOCDIxwoOCQjQNw0k3e+sTwH7FLp1IaNzG
	FAoETk5CXi0/+HaeN4MK/GOrwgG16z1c+Nw==
X-ME-Sender: <xms:VtO5ae4klSZfHPiUOM5nOFosRAOhH1CViHnjj062VCikCNcJQPo3wQ>
    <xme:VtO5ae5NRT-0zLtWG3rZRO7-m10beh2rKe6qD5Mb_09WrYUjIKLMmGp3Ri_3BoYLN
    Th3Eo30A7oZt6Yg86cuzK_TubSmVmezTAuq10H2bnxDMjIBUKYtxVI>
X-ME-Received: <xmr:VtO5aScQ2N16oCjyiaL767lLrHq6LHO_0WGlS-rPrZbVoZnk7wTH_xk09VZaPZzUb9ohL6-bFR85yGhIgR-F22P1JH9YDyVlUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:VtO5aaD4lSL5NhZAKYl0kCvz8NkokwcU2eI9a0PXG4NUiGa4TIcg5A>
    <xmx:VtO5ad_R-xemFAAQWoMKmAF7uBm4WMayYx6Sk2T_9H4Lk7uZK7KaTg>
    <xmx:VtO5adID8Z7SvN8iQpWTWo_9AS_UAP4pkuCZn2KVrY9kCcM1INV1Vg>
    <xmx:VtO5aehfkF_LYLw0YHAy8sr5I9COAAnonAFUuzzQDuHlv-bEJp6X4A>
    <xmx:VtO5aR9Nm9pnSMgJ_T1RNW_P0PWuO3FOTKyLlAeHHqgI-ljUUGz6EFXu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 18:19:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/5] path-walk: support wildcard pathspecs for blob
 filtering
In-Reply-To: <beb1c92554c76907315a4d1a7983226d2bf5a828.1773707361.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Tue, 17 Mar 2026
	00:29:21 +0000")
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<beb1c92554c76907315a4d1a7983226d2bf5a828.1773707361.git.gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 15:19:00 -0700
Message-ID: <xmqqms06hzfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Previously, walk_objects_by_path() silently ignored pathspecs containing
> wildcards or magic by clearing them. This caused all blobs to be
> downloaded regardless of the given pathspec. Wildcard pathspecs like
> "d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
> during 'git backfill').
>
> Support wildcard pathspecs by making three changes:
>
>  1. Add an 'exact_pathspecs' flag to path_walk_context. When the
>     pathspec has no wildcards or magic, set this flag and use the
>     existing fast-path prefix matching in add_tree_entries(). When
>     wildcards are present, skip that block since prefix matching
>     cannot handle glob patterns.
>
>  2. Disable revision-level commit pruning (revs->prune = 0) for
>     wildcard pathspecs. The revision walk uses the pathspec to filter
>     commits via TREESAME detection. For exact prefix pathspecs this
>     works well, but wildcard pathspecs may fail to match through
>     TREESAME because fnmatch with WM_PATHNAME does not cross directory
>     boundaries. Disabling pruning ensures all commits are visited and
>     their trees are available for the path-walk to filter.

Hmph, I wonder how significant an impact does it have on the
performance that we have to disable pruning here.  With the bog
standard tree traversal, wouldn't tree_entry_interesting() already
be capable of doing this, even with fnmatch / WM_PATHNAME ?

>  3. Add a match_pathspec() check in walk_path() to filter out blobs
>     whose full path does not match the pathspec. This provides the
>     actual blob-level filtering for wildcard pathspecs.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

The latter person cannot sign DCO or vouch for the origin of what
they have written in this patch, can they?

> ---
>  path-walk.c         | 22 ++++++++++++++--------
>  t/t5620-backfill.sh |  7 +++----
>  2 files changed, 17 insertions(+), 12 deletions(-)

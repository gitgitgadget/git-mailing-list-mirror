Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB71F460C
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204931; cv=none; b=e3dBu2CAm6b3g1jWMXpdCuU4VXuH0NuOVoRXiHzkQ7B+PX0IMzQkyaij8xpXuqjdodC+Nxe2mzTxmnLx/qgRcpcgjK5lfFh1LlRqyyzNZDWkQtq6NtfLgfbkHazlWq6bPs1J35Oul8L+ifbf3GiJwbc3EdItwDvaAHR5dhDilDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204931; c=relaxed/simple;
	bh=39NKhFtSosFzUESHIHwMxbM1PQEfsBS9fmkIX9NnKjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSnRiF5MYWD2Z+zD5iyfB2UrVKvtCnPd+jDb5Euj6oi9uhRlK7nK3YX4oSIubVYg1mdKTidzGk64qEizqf2rrrC+94pSfgkAmTFUTbTDfxr8744KLdzqcxbJkZY3TH/L0uMleqwlGJV4PGUlQkAKKrq2qhFt5j5obY/pmKAlEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g8p4Ggqh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6CC4vo4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g8p4Ggqh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6CC4vo4"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA5831140272;
	Mon, 10 Feb 2025 11:28:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 10 Feb 2025 11:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739204928; x=1739291328; bh=bXPyjRIIOx
	nyCt4PGwUMoXWn/as9HacDK64EE/O6D6A=; b=g8p4GgqhKVD4gb7KZEMUYoajRq
	nCJarhABjpc8DtOZDxlV8auRr+AddOsbyC3vJmSdKlNkTj56BKYdKK/y7eXSfeOt
	vZWFeKj+/XD/meSXILgOMgQsEqG7aS48IHc+rTOE+sYc2+WNk8Bkyrx3/pLDEWcV
	sgKTg6SZDm+lhGymVLOiG9ENrD/NE/fplvKeznO8wkrQy137nHsu5uMOcaINhKnD
	veWGo8DuwxREGmkIT9QJVrcNztzVLHetDpJExnPYeGlgynhVgVVPLGYl5cQiDLCL
	mVpvi+w/KITr4Llnt/zi32p2wUMVXGIhVH5CKO2EL5Cqhp41rWn54yC2qK7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739204928; x=1739291328; bh=bXPyjRIIOxnyCt4PGwUMoXWn/as9HacDK64
	EE/O6D6A=; b=B6CC4vo45FB0yqiM9R43Hk8VTf3qH+tZOlBWVb82NGEgwucZRXz
	A23qRw4uEMlpYMQ6IbT6RxL9yo7Rn1en0W0CpGOmqQCRDiYBmHhhucMwhlHIoZQM
	GkXTiTS67wrQI88XVnZh+NCLCppMW0GOTDTY+oFzJivCG8wUdz4vdQO32/wNltW1
	jKPwMoHXakfEP83JExU8u+SZMmIdg6nPnAF25wiwrDn6DVPAFepoOhPqaCV4e/tD
	SHg33Ll3IEcqWThJhhpQwwJV7smng1CkjjMF0JrnEXa2ntDp4TAopTQng8tpP6FJ
	mzveV+VhTJqL0FzkJ5EZXOIiWlm462njDWA==
X-ME-Sender: <xms:QCmqZ-7wffkA7GZxhr-FyVrcJCBYZxOKttkf9_AIgAMMAmjHKMH78A>
    <xme:QCmqZ36FcygMR4q2URGnwKY7JQ2OP4dMmvLVbeIeKufOQRZ_v4JuATHdgoWmGV4Xt
    7ZIPBJ6LDZLZf5frA>
X-ME-Received: <xmr:QCmqZ9dip07vZhqxqQ9B8fv1G_708ASPEihViqtwdy2MzIWAXYZKOssZgEHtN5pozLo4GmmZhI9gvRL1p0CkjsNqGdqPXHNJV0ae>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepgihtvgigsegvnhhvshdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgihtvgigsegrohhstgdrihhopdhr
    tghpthhtoheprghpvghnfigrrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QCmqZ7KrKbULQvaqSwVbJJsjkPVrp_EMjFgo8c_d3cZSiMcsoRnGCA>
    <xmx:QCmqZyLLW3M3YewqZX3m_A6JFF1hl_hH9LDd4TVkxevsk6cWKlEaqg>
    <xmx:QCmqZ8yl1NZWqaEvp90R1H1q_VEmka7lg1TK8cMyrOC8mSO2uHdjwQ>
    <xmx:QCmqZ2JxLbgcO3yFpQZ2ydzDnyogC-0EZJVv3_mrC6Pf9OaK8i7rnQ>
    <xmx:QCmqZ0juAQFQKe8y3mGPXZ5p-LuwhGgBoI1gMo2_9uuk0nBZpcBD9gp7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:28:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Bingwu Zhang <xtex@envs.net>
Cc: git@vger.kernel.org,  Bingwu Zhang <xtex@aosc.io>,  apenwarr@gmail.com
Subject: Re: [PATCH] contrib/subtree: verify HEAD is valid before adding a
 subtree
In-Reply-To: <20250210021128.31083-2-xtex@envs.net> (Bingwu Zhang's message of
	"Mon, 10 Feb 2025 10:11:26 +0800")
References: <20250210021128.31083-2-xtex@envs.net>
Date: Mon, 10 Feb 2025 08:28:46 -0800
Message-ID: <xmqq8qqddarl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bingwu Zhang <xtex@envs.net> writes:

> From: Bingwu Zhang <xtex@aosc.io>
>
> After initializing a new repository or switching to a orphan branch,
> HEAD is a symbolic reference to refs/heads/xxx while the pointed branch
> head does not exist until a initial commit.
>
> "git subtree add" will try to ensure that working tree and index are
> clean, but as HEAD is invalid, diff-index always fails:
>   fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   fatal: working tree has modifications.  Cannot add.

[Disclaimer.  I do not use "git subtree" at all myself, and I may be
missing the usual expectation of end-users of that command in the
following description.]

Good finding.  I can see that an unborn HEAD would cause the command
fail.

> It says "working tree has modifications" but it is not the case.

I am not sure if "it is not the case" is true, though.  If the index
is empty (i.e. nothing has been added yet) and the HEAD is unborn,
shouldn't that state be considered that working tree has no
modifications?  IOW, wouldn't this part of the code that uses
"diff-index HEAD" want to consider that an unborn HEAD equivalent to
an empty tree for the purpose of the comparison?

In short, "is not" -> "may not be", perhaps?

> Add a check using "git show-ref --verify" to ensure that HEAD is a valid
> reference and give a clearer error message.

And if we want to treat an unborn HEAD equivalent to an empty tree,
then dying upon seeing "show-ref" fail would not be a good solution
to the problem, no?  Shouldn't the updated logic to deal with an
unborn HEAD be more like "if we see that the HEAD is unborn, then we
are happy iff the index is empty; if HEAD already points at a
commit, then we are happy iff the working tree has no changes
relative to it"?

> Signed-off-by: Bingwu Zhang <xtex@aosc.io>
> ---
>  contrib/subtree/git-subtree.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 15ae86db1b27..41eb816e454a 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -770,6 +770,11 @@ copy_or_skip () {
>  # Usage: ensure_clean
>  ensure_clean () {
>  	assert test $# = 0
> +	# verify HEAD, or else "git diff-index HEAD" will fail
> +	if ! git show-ref --verify --quiet HEAD 2>&1
> +	then
> +		die "fatal: HEAD is not a valid reference.   Subtree cannot be committed as the first commit of a branch."
> +	fi
>  	if ! git diff-index HEAD --exit-code --quiet 2>&1
>  	then
>  		die "fatal: working tree has modifications.  Cannot add."
>
> base-commit: f93ff170b93a1782659637824b25923245ac9dd1

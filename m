Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0A1A6815
	for <git@vger.kernel.org>; Thu, 21 May 2026 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779326567; cv=none; b=KrAFCwDaDcqL4w7o4VAUAM73HeYsrs2tbL4+7j8pkS7LIgE0CdhV4ZMBHz9CsPjhp9hNhoM7awqVLdyun7/DInu4mPJVCJVpEAl416P98l/zxqAx2wcQ7186jo13sst0vdXH+XnbMr2InrhEs1oq6BjFZAA4hobB/5GWwsm2iPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779326567; c=relaxed/simple;
	bh=Nxh0Jg7orS9vTbZCaEBlluk0b0/aElzHNBh7VbxEa4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTL0VdLeYQ+U1LZHvtZIg7xr1zXwdAqLbRXZKJ5ut5MSEWK/p9ks9pd7zpigapC0PAeCShKUt1wzSpuDQ36vW0RVYgZ5M4mJGCl7irDMMUrGMaMNE/WPXSDSuhcibMI1RZ2l/uAuBLbRr2z+K0IdZE3nsZAYwVLOSWvYhfq0NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WnHDQpwn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VfUUHjak; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WnHDQpwn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VfUUHjak"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E0BA7A0049;
	Wed, 20 May 2026 21:22:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 21:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779326564; x=1779412964; bh=s6kih9GYPo
	eQcLKTgOY0rWu1K9R+2mkjWPUzrGkOIgI=; b=WnHDQpwnXNbrD22ooSSYI4Hcyu
	zO3pC7Zf6OLn5q3UUWam/39+qDFWXwgXY91mMEzb9u/LwfTbY5nOa2r62a7TJKzE
	rXo5QwgberREDT9F326Hadk7xvwgd2pWN9rVv80IDaQHE2E2ON8fUPwd6g7IZRsT
	64q3NaFAEfBil7ky1y8bCyzsq69sCnDErVxhuD9EHjg1ootPgmLel/KzDWY7x/+n
	TGx4j9crGxgud4v0PxiBV85b64Neu/XFTBsoUsGyru89DdpRGvPNhkLGAL84A7gp
	qQZYFJ+nPiC2FaotH9rptGkO0tXSrkWQbAQl1bTRaJL3XWw1idRmSpX4s1hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779326564; x=1779412964; bh=s6kih9GYPoeQcLKTgOY0rWu1K9R+2mkjWPU
	zrGkOIgI=; b=VfUUHjaknfB7l4wySNZI+Ff5PWKq4J60JXmASBFPRVF3Y68JOWs
	pjtki6N2PD1LxWUgvnuyNzIMSa5bXnHU9Zsjkwi1lCp6Jqthk7L+dDR3x4LLzYop
	QxAtGUdEdpfUjsMXzu7gvC72nJIh5BYB121kODzswr59K27FmNFzfu5O+AQjkAAa
	LtGlaEuXRbO5YdEc8WQaUVSMDuA6KA8aKNakoehBUKqOqiqy5k92WrIhh/qUlyy2
	jN4JwBW9ZGP+SrBCi1p+SswdEavG73jfnBED4z4kH/JhXQorr7JY4GvMgp9y9+yr
	4yRqMqGmN+BL58gpxCTLMgtUryCm8lnc7nA==
X-ME-Sender: <xms:ZF4OalPRSk-KPicUGTOoKE2nKJBF5RnMUvbK3OiV4jr9O33gYMf2ig>
    <xme:ZF4OaqO2PeymJmiscCwOe_CuW00HFebV4TaScBdovpm4JGzxOhSovAB76mxUBydvW
    irvA17YPHNnLbLfldb7xhZ3nBNA16njcm4txHjd9qeDa2yghjMsNQ>
X-ME-Received: <xmr:ZF4OamgR5auZVwQ6RDhxFbMBjxSQl9i3wsTv_GuM2XWRbnZPc1dWom7m3ExlAzDTk-c_R66MgS5zWe2KGx4EAUoYMqXCva9QfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhrvghgsehhuhhrrhgvlhhlrd
    hnvghtpdhrtghpthhtohepvghrihhksegtvghrvhhinhgvugdrihhnpdhrtghpthhtohep
    ghhrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZF4OantHu8hYPeF7PFPQWQo07rBN0ol2VZ_OODD8W9eejaQswu1Wng>
    <xmx:ZF4OasTFDpEZ1Le2iylzQk2m1VXhlhG_1_jKQ6zxqasAtteMLTqP7g>
    <xmx:ZF4Oaj2s9aNqKMaft2LA2ij3hFUagjnP8BYJlTbcdx5APhgPUWorRQ>
    <xmx:ZF4Oapt_b6okOHzV6-lfBFGW4O2jEG6EYdulj4TP21TNW0FNnJOXng>
    <xmx:ZF4OapceiA7Yhddbr3KqMMGhf41aPmp8-YYY2GSOUX0KEgrYlx0IyF1D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 21:22:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Greg Hurrell
 <greg@hurrell.net>,  Erik Cervin Edin <erik@cervined.in>,  Greg Hurrell
 <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH v2] git-jump: pick a mode automatically when invoked
 without arguments
In-Reply-To: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com> (Greg
	Hurrell via GitGitGadget's message of "Wed, 20 May 2026 12:31:46
	+0000")
References: <pull.2108.git.1778231254871.gitgitgadget@gmail.com>
	<pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
Date: Thu, 21 May 2026 10:22:42 +0900
Message-ID: <xmqqik8h36al.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If none of the interesting cases listed above applies, then auto mode
> falls back to the existing usage-and-exit behavior.

If more than one interesting cases apply, what happens, and what
should happen?

> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 3211841305..ac35792e55 100644
> --- a/contrib/git-jump/README
> +++ b/contrib/git-jump/README
> @@ -75,8 +75,20 @@ git jump grep foo_bar
>  # arbitrary grep options
>  git jump grep -i foo_bar
>  
> +# jump to places with conflict markers or whitespace errors
> +# (as reported by # `git diff --check`)

Is "#" after "reported by" intended?

> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index 8d1d5d79a6..43d3b42a41 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -2,10 +2,11 @@
>  
>  usage() {
>  	cat <<\EOF
> -usage: git jump [--stdout] <mode> [<args>]
> +usage: git jump [--stdout] [<mode>] [<args>]

So "git jump --stdout foo.c" should mean "git jump --stdout auto
foo.c", OK.

> @@ -16,6 +17,10 @@ grep: elements are grep hits. Arguments are given to git grep or, if
>  
>  ws: elements are whitespace errors. Arguments are given to diff --check.
>  
> +auto: select one of the other modes based on worktree state;
> +      "merge" if there are unmerged paths, "diff" if there are
> +      unstaged changes, "ws" if there are whitespace errors.
> +
>  If the optional argument `--stdout` is given, print the quickfix
>  lines to standard output instead of feeding it to the editor.
>  EOF
> @@ -82,6 +87,23 @@ mode_ws() {
>  	git diff --check "$@"
>  }
>  
> +mode_auto() {
> +	if test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true"; then
> +		usage >&2
> +		exit 1
> +	fi

That looks like a basic safety measure, which is good.

> +	if test -n "$(git ls-files -u "$@")"; then
> +		mode_merge "$@"
> +	elif ! git diff --quiet "$@"; then
> +		mode_diff "$@"
> +	elif ! git diff --check >/dev/null 2>&1; then

Shouldn't this "diff --check" be restricted by "$@" if given?

> +		mode_ws "$@"
> +	else
> +		usage >&2
> +		exit 1
> +	fi
> +}


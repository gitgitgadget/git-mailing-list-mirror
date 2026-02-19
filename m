Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCA28C84A
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521001; cv=none; b=iMHRwhdI7nuo8/CZqfyDYSwOawjoxYf5xd4PBNigx0h9Rx+Ab3mpbTj3zNxHevfhKtsR0sA2knKuhHB08vKcUsMVQULedBTE7p09fgGxV9wcjvcbe86OEJUB6U5yOwDXfjiL0lZ2NMpI8zWxMwjB0UYUblT5UTOsWyKhBJpwjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521001; c=relaxed/simple;
	bh=dWmNro/KipKn6ES/UC/djiJcC4VSL89Epyk8nzv9Tcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpymPpdWFH06n70ZSnIU2P+MSbYzNM9QYoh5YmsRjgy7KLM/tHjeihtDIzxDpWEfUjt3LpmJx+k8hCmjq1rRkVEvWCAh7SKcz7K3L7NhOzt60yq9/lyvXtK4nlc05vS4DfljNRDyYsBy6laFajIdDkOW+EDNerfm15QORsSYQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=id6/x66W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=riYKne8W; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="id6/x66W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="riYKne8W"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CC209EC0259;
	Thu, 19 Feb 2026 12:09:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 19 Feb 2026 12:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771520998; x=1771607398; bh=VTGFTxUoza
	YlGDSzSsh1HiVl+ahxSkH5+9Nnem1z3Qw=; b=id6/x66WNVy+tdWledvbZv0OUE
	957hNmSgysqz1gZ1qdFLo6h9XMwJ1g4WE0nvmkFlrG06S09WeNDYiX4WsXwp60bB
	LnMrPK8Q2QquzeYvzv26DlJ5B0d9XxgQUdcGuolOKgJbKOGRYIMvpJftfyLC7Ze4
	aWb6gsI1DJDLrJfLybB6nbzYbIWPtkPff1Hytz/cXpY/XaC9GR+MHEvuqxec1le5
	9VtYEnHbCiC8GGLwK5CUuqd2XtxGqPSCXRDGAOVKItCQ8UfFRrP1MEzOKmnMbuos
	WHkSAWFYkYoDX5f0J3AeVJ0mrWkT+PO4lYenBO0NL8Gz7iQAg/frBFjI7xjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771520998; x=1771607398; bh=VTGFTxUozaYlGDSzSsh1HiVl+ahxSkH5+9N
	nem1z3Qw=; b=riYKne8WL0KFhCrrrQwFcaIY3tjzFxtj0Oe34Y9AHb7F0OZ+JmH
	IKpfd0MdchZFTuORjqZKFXqHcTmczbBlwHoICWunvke44yQnFHK2YRI6iUtOSlGv
	a8G8nAkgNjO+XU7CV6HDiLk16U0//fkhjAilBQ96x1z8iPPvtRvS497SZp36DhRQ
	whdUPumKZkks8q/sswRCrjqp8s4we2c2YEhRqMcwn03bu5sa/dQ8Ou3KPaM9TmWu
	oqv/VY8/BYRzK4eSppEWINChxi1JJxNoH726Ls7AftzqKg7j9SF06M316zRn0Iho
	PNyP8Qm2Vu+WzPgUfUYzjit+kxMbfUZORTQ==
X-ME-Sender: <xms:5kOXaSQxuHdQFYf9V5xPYUlhFUYyiAvsvXQ3Fad7-3b3bSXqnHGD1g>
    <xme:5kOXafM7lawg7ut9iLUtzbzh0y3bfSvv2-UaVVP0eouCbiyBoaxWV6ymu1n0NCUzN
    ZE7OKBZx_jMm068ekU7vFsWe1QHsK8RPH7FMkYWuN-kNbiDoMIjNQ>
X-ME-Received: <xmr:5kOXadPg6MGtN5JKpHAGJ-Djs3TRE3HYkQRKTb4lhb2Jv6pTXr3oYU0i9zuqJvD3CWKwo-6qh-kwRMRnSKBXxVClXcUtIeBWPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeitdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5kOXaXvPc-9DIZ6VWrvVZ2rgk3VUBX5Aoe419fQPouKUSlE-P4psxg>
    <xmx:5kOXafVUfVrMta7W_0QBV6OZbPs0BOea-JepEKy6GVM-uMxxE7LNNA>
    <xmx:5kOXaXvLHvT5RmpnvGO-H439NP3vcmXHc2GPTO6bVEC_ok1iFeEtGQ>
    <xmx:5kOXaTUvJEndRRqO700Yi7n0LYR_YxqFJD8C6bcQjOUiYxhtMFcOdw>
    <xmx:5kOXaVXMc2NlUtKa3Nx0-ZPhJSfrJsPvjvFJOJ2t14vY3TOCVzhzwcIp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 12:09:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] t: use test_seq -f and pipes in a few more places
In-Reply-To: <20260218181019.1705160-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Wed, 18 Feb 2026 10:10:19 -0800")
References: <20260218181019.1705160-1-aplattner@nvidia.com>
Date: Thu, 19 Feb 2026 09:09:57 -0800
Message-ID: <xmqqbjhk7j8a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> Several tests use a pattern that writes to a temporary file like this:
>
>   printf "do something with %d\n" $(test_seq <count>) >tmpfile &&
>   git do-something --stdin <tmpfile
>
> Other tests use test_seq's -f parameter, but still write to a temporary file:
>
>   test_seq -f "do something with %d" <count> >input &&
>   git do-something --stdin <input
>
> Simplify both of these patterns to
>
>   test_seq -f "do something with %d" <count> |
>   git do-something --stdin
>
> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
> ---
> Suggested by Peff and Junio in <20260114173055.GD885771@coredump.intra.peff.net>
> and <xmqqcy3cf5xa.fsf@gitster.g> respectively.

This side topic completely slipped my mind.  Thanks for following it
up.

> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> @@ -401,18 +401,14 @@ do
>  
>  			# Create 99 packed refs. This should cause the heuristic
>  			# to require more than the minimum amount of loose refs.
> -			test_seq 99 |
> -			while read i
> -			do
> -				printf "create refs/heads/packed-%d HEAD\n" $i || return 1
> -			done >stdin &&
> -			git update-ref --stdin <stdin &&
> +			test_seq -f "create refs/heads/packed-%d HEAD" 99 |
> +			git update-ref --stdin &&

Nice.

The original was doubly bad in that it did not even take advantage
of the fact that printf will iterate over its parameters, but now it
is nicely packaged up in a single "test_seq -f" invocation.

> diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
> index e334751759..26b716c75f 100755
> -		test_seq -f "update refs/heads/branch-%d HEAD" 10 >input &&
> -		git update-ref --stdin <input &&
> +		test_seq -f "update refs/heads/branch-%d HEAD" 10 |
> +		git update-ref --stdin &&

Everything after this patch gets applied follows this pattern, and
once the patch is written, this is not important enough to go back
and fix it, but I do not think it a bad idea to use a temporary file
in something like this.  If you were hacking on the "update-ref"
command and find this test breaking, the first thing you may want to
do is to rerun the test with "-i -v -d" options, chdir to the
$TRASH_DIRECTORY left by the failed test, inspect the "input" file
and then run "../../git-update-ref" under the debugger.  Not having
to type the input again while you are doing so would make your life
a bit easier.

Thanks.

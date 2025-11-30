Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F0A4A33
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764482367; cv=none; b=YXR7y3xLw71AHqbbcGQytqt+zQQ5Cg6E6bD1nR8J6TS53ihlHwAJ52XxHek4yZMzSuzkC0cMvKnoenir/rIX4l2aQAgJAyXIBexHu2kvrqq7AqoFZOFQqp6iD+hKO4HR9n+EKX242qoKBhUBpjRUWzK3PrpHEQQBeLJ/E/C+9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764482367; c=relaxed/simple;
	bh=CcGCkORKOBdgTffrdjxVH4DaX3ED6zZp17E+dgmvbBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ubULW+wSX4yPrA4Kh0OxRfcN6guFgYLkWlGdX/IfUrIq2Q6CLB8+cKAar9Z1ypLtv7zgmcYOWWgVj8rN/0DvSg6j1bZwtUBZi9MpoKSp9Zk4wPnzmCWC3JtV+6Syyk+dvcJVmPffM8LOF0JOioziyTxN4wY3ZLeLJHUJ5GPchFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aSV+tWj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKT3H91e; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aSV+tWj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKT3H91e"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4530B14002B9;
	Sun, 30 Nov 2025 00:59:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 30 Nov 2025 00:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764482364; x=1764568764; bh=vfs5r5u2FT
	H57haJEVWzunMCg+4BcEdY865UMUGqEdM=; b=aSV+tWj7sd0r698jgynS5eLapz
	wAwP+p20nbC9BietrpsiRuqJZL7P8qvCVDiE71faT7z2ZyePZfjmwJdxtDaEOSoo
	KtZyJkk2/bMeap5W15Pt139ZG5kSZ4B5pFy4m9wjLSx+G4G3kEedTHK7tC1HMKC1
	yR9Bu14sZUQ6KXRxZcpTaSDesTzdwE8i533pUa9YEJ11J+u/0n8C1+G3bmUpyyGV
	iNZgMo0TNhcsuNwcS85uTH+69C5PGu/xB3xQdE41A2PYY60F30EtpxzA/qHrVTQ3
	RsqzKxBXUdqPlcKQvFcy6NZ1+zgy0cjr/zDP6gFeY37p5zsqYFhxWY2yE/dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764482364; x=1764568764; bh=vfs5r5u2FTH57haJEVWzunMCg+4BcEdY865
	UMUGqEdM=; b=tKT3H91ean9Eu2uTRlztP1j852+C44K2y2BZ5mF2xN8vgnVlLfk
	CAoWTgs8+Df6+Y84QKJnMLKjcymxoiUbieGbxS6GDlO6TFk+nUdDw4oCmtvw1jBj
	Xgfdh+wvt+3bFHCAj17+wlGfzL1YOu3M+rx65QreoFzY+QGLtch0LTP3HODZ7A2J
	6oSfmH+Fm1bMSC33Zm27xKUx8Y6TxtfTnk/2rFvXZxDpXYsORLvVxACL1CckRoir
	LyziYnC2fvuAdNnQbJwp+4fZ2Yevu2rBP7oQzrQs2wdMxvewEj+FwP/BjyoyVRF+
	kX4Es3btmUAg40oQtQ9ov1ratv06ONDt/Hw==
X-ME-Sender: <xms:PN0raYm4dPBqeK9kLQG9RkLFR8K7-SZDWxHPKdJ2ETmCrvbPuSp6qQ>
    <xme:PN0rae1o-I5AxM8EKhuCUlP_-z-bpA01g7b71W5xt4lmiRZIrQO0J8uRxlC3UNkJN
    XHidnsjdmRCURqREbwk02Ee5WOdgYNMaHxMrDSGxaGuL24nZcpg-w>
X-ME-Received: <xmr:PN0rabqob7yEx_Beoyj_uP3F6BZITbTuKdfVJ_mEUpWWfEmSxtvBTcL5HoRe4198nu5d-Sk2LRBu1m68AB9w7HRMusSkaz5HBi0K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PN0raTcBuj1F0JLM5dO_bPNF_jO9Mym5-Nb17Fl01107JGYnF5juQw>
    <xmx:PN0raSokP-Nh9w6cLim_TDBtVhg-HozIJYFKpP8-TRwMxaW5GNGgXw>
    <xmx:PN0racFvro0trIN2Q9y7t0fe4xeduH4dwGuWbo6sl7bXCi-DQ58wBw>
    <xmx:PN0raasOhPcbJVIdD7hL3t-X9vFSSTPH-NVmu08FdQ0YK9VyWLzJUw>
    <xmx:PN0raWyzsjSyNpl7qie6uxCRU87M3gYyfDD9iRic7M-TLtkJABRBwJH3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 00:59:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/10] t0001: handle `diff --no-index` gracefully
In-Reply-To: <3be9594e80c37b2b393f5883a173694ab6793813.1764440906.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 29 Nov 2025
	18:28:20 +0000")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<3be9594e80c37b2b393f5883a173694ab6793813.1764440906.git.gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 21:59:22 -0800
Message-ID: <xmqqms44cb7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The test case 're-init to move gitdir symlink' wants to compare the
> contents of `newdir/.git`, which is a symbolic link pointing to a file.
> However, `git diff --no-index`, which is used by `test_cmp` on Windows,
> does not resolve symlinks; It shows the symlink _target_ instead (with a
> file mode of 120000). That is totally unexpected by the test case, which
> as a consequence fails, meaning that it's a bug in the test case itself.

It is dubious if it is a bug in this particular test case, or
test_cmp implementation that uses "git diff --no-index", though.

Either way, when test_cmp here does not do "diff", the test would
fail, so you are correct to notice that this piece of code needs to
be patched in some way.  I do not think not comparing is the right
solution, though.  Would there be a better option than completely
punting on the comparison?  Something silly like:

> +	case "$GIT_TEST_CMP" in
> +	# git diff --no-index does not resolve symlinks
> +	*--no-index*) cmp expected newdir/.git ;;
> +	*) test_cmp expected newdir/.git ;;
> +	esac &&

perhaps?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0001-init.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 618da080dc..2f38e09b58 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -425,7 +425,10 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
>  	git init --separate-git-dir ../realgitdir
>  	) &&
>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> -	test_cmp expected newdir/.git &&
> +	case "$GIT_TEST_CMP" in
> +	*--no-index*) ;; # git diff --no-index does not resolve symlinks
> +	*) test_cmp expected newdir/.git;;
> +	esac &&
>  	test_cmp expected newdir/here &&
>  	test_path_is_dir realgitdir/refs
>  '

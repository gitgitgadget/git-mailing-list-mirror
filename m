Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355C158538
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625733; cv=none; b=LjeR0F3g5055FWV3JSj/3Y2q5Wqoog6Mb9hk7bvn1xl1PEUsc3Atasw8bsNxJyEhLYHbVGP+ip4cMCeOeTXdwKQkiTUm1ZiGNayvHjTi1y1+zX5tSRhNHKc4E8bTnatjoeJW3EFdbesMwvpHD4jPjBsFZv+hzKJ5NzbGKawz9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625733; c=relaxed/simple;
	bh=OjebcySCAVtvU0XYQE487x8h470qvneGJ3JOYKRz+6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWzW1Ff7dgixYivPf2Jn0/lgdwx+crNO8AJIMbGMd/cP0ZOJvcsFCL6abrSfTJTl7gCTUp2kGUA1tRwwjIol2QDHRoXl3nvLT1uQAKAnQNfPxJgf4cFVMVXdpKOycu+cO0/pHcLbJpuqRbvP1NMwl7DwmM4LXr15UmRAIoDog1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WtMEGUGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TtH3+96q; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtMEGUGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtH3+96q"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60961254019D;
	Mon, 10 Mar 2025 12:55:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 12:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741625730;
	 x=1741712130; bh=Pd0nETguKJENmV7MDfk6mRq5/zO49YBTF1TNrTrREz0=; b=
	WtMEGUGrqvvctuuuzJSg1kpTVpZzOI8/dXEQXyGFXK0motF8rXjs1vtrKM/PBljW
	2dvHMoj7YPfyciXE///Ufp82TLA44OA3q17Fmi1RQml99rvq7ZaN9Lx9pqWVo7lz
	8TP0T/SU0mSB5Ks40d6WxAjzJ5Hp/EHL6bJzpwxWn9vVqsSCKBDP6tSVjBO3RHN5
	u7Fg6G5r1YV3yWZBR0DFMmWTH73uhwqQflkVISiPSohhBjsWgxRHmoOUOvFwejkz
	bxNZRuqewtfAGqY/7SQGmnb/kVEWAQv1LZmDKOGP8OSC++rsekxkcPVDM2j9N5KA
	cF6Q51rTYPYcW9CVkmvHeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741625730; x=
	1741712130; bh=Pd0nETguKJENmV7MDfk6mRq5/zO49YBTF1TNrTrREz0=; b=T
	tH3+96qrnT/BxEXk/i4s9i+uvF2WB5aLdZw+3LFkQ5zIX2/s6I/kCiKA5yT2xR71
	x/nBW2OBNljkzkZ1nS1Q+7rTJ+uIqIbstTbIeqSL4E57LqzK2jRszJ7yhGihFpZW
	qxonzXGsDlWOloMLCNlUYw5+IXZu1Iq2LZtR1jpy/vMOVNSoRrOrRGwSMbsBhDu8
	IJRWBlx+2eYrwcNOvstnlnPyrqCTdN9nPCqGjLdeqi+MmZCHrx/nOlPL+GogZ/NB
	z91ic9OQFqEA8RpIs36W8cyREUTaBB8t2RisTrV3r/vtWJHiNg/ooaykTVCw+gf5
	LBoiofIoEHaFKPbih2+WA==
X-ME-Sender: <xms:gRnPZ2ByFpWTwbXyDjwJ3AOutzCfqn4l4o--wBXJacldPsGyHi1Lbg>
    <xme:gRnPZwgPx53Jc6uEJHvTC46wdf9rA6o0HbDK54CuzbyuBllYVwnxq4IH8sNCDY8eG
    mg_I3NlGki_rnrIAg>
X-ME-Received: <xmr:gRnPZ5nuAshK4lh7UzCGKP-17_IpLtT1Bk-gx-R6Bt_y1MDPn6KgtH5wzY09ZPLh9CXEIuWvUj_hyzyBleSbDZHp58OurIA4Kn5a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinh
    drrghgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gRnPZ0x5jLPMmgQmNGP3I0tHIVsnKIGo7lRxdmJEmJmeb50B_7Ua8Q>
    <xmx:gRnPZ7SxHZ4KE7A9pqa6PPINc0oNYt_c1avyvcRVKW_vPCwB2ZlN8A>
    <xmx:gRnPZ_b9ImsWvHOB0bLxXh_pIN1irs7LcGl-jIrl8X--ZakSPXBj2w>
    <xmx:gRnPZ0S3dvMkfF8h1PVsg9yG9SIb2-B5246QfwY25PddS7lyHou72Q>
    <xmx:ghnPZ5Nq5ivBpGVZUDK8DBgev8ZXx3snbyflEQAY1YqcPFfqULOGxBnv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:55:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org,  Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH] git-clone doc: fix indentation
In-Reply-To: <20250310110758.601206-1-martin.agren@gmail.com> ("Martin
	=?utf-8?Q?=C3=85gren=22's?= message of "Mon, 10 Mar 2025 12:07:56 +0100")
References: <20250310110758.601206-1-martin.agren@gmail.com>
Date: Mon, 10 Mar 2025 09:55:27 -0700
Message-ID: <xmqq8qpc9668.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Ågren <martin.agren@gmail.com> writes:

> Commit bc26f7690a (clone: make it possible to specify --tags,
> 2025-02-06) added a new paragraph in the middle of this list item. By
> adding an empty line rather than using a list continuation, we broke the
> list continuation, with the new paragraph ending up funnily indented.
>
> Restore the chain of list continuations.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  Based immediately on top of bc26f7690a. Could equally well be queued
>  onto some later point, modifying git-clone.adoc instead of .txt. 
>
>  Documentation/git-clone.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 8d0476f6dc..ebfb608885 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -279,9 +279,9 @@ corresponding `--mirror` and `--no-tags` options instead.
>  	`remote.<remote>.tagOpt=--no-tags` configuration. This ensures that
>  	future `git pull` and `git fetch` won't follow any tags. Subsequent
>  	explicit tag fetches will still work (see linkgit:git-fetch[1]).
> -
> -	By default, tags are cloned and passing `--tags` is thus typically a
> -	no-op, unless it cancels out a previous `--no-tags`.
> ++
> +By default, tags are cloned and passing `--tags` is thus typically a
> +no-op, unless it cancels out a previous `--no-tags`.
>  +
>  Can be used in conjunction with `--single-branch` to clone and
>  maintain a branch with no references other than a single cloned

Thanks.

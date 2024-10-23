Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B468611E
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706482; cv=none; b=edlODsnaduiNdMduXMy2/Go0Tgez0fVK5wS5WQAWDMH7p40MFSM5xAf3YJ7SlWvCfFHIMkRpbJZWB0AwjQf8IGfCbeoTwAXojW5yV3YP+JMkXzmF4E6YucrxdoxgQfADBkx2mkEug4pzv8ea18BX6CYUuu4khT7PHpuwxSHNnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706482; c=relaxed/simple;
	bh=bHoSI1QhTrVuH9X1hmejxjTsxANPf5dWyNRRDeT/YOI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tpZHNRvxfhl/bT6eW8wFk+kaSulZ7/WNqj8Z75xXOSg/GnSqy2k2yvoXdtMTOiug/UcnjX/d37adg1eKjPafVytswvwJtvLuWFWwmNdOHKPBmsfUNI5CWD6q4jtY9OcQNKl+I0lqtAXKmTR9gvk12qpVQJYDbXw1+Rol2e8RaMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=McJnTh3H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9RDjzZU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="McJnTh3H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9RDjzZU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D7DF13800D4;
	Wed, 23 Oct 2024 14:01:19 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 23 Oct 2024 14:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729706479;
	 x=1729792879; bh=iAsKzV6aXierCdCfWwtPZk8WKyaa9MVSX4rtUHQVwyc=; b=
	McJnTh3Hr/yhbKtruAxyvaNBp4/WgDzpqHuiJlNlzm3xZK36TxkZnPtmzmunZMrB
	1TvzPt6I1aS61OaSrivhlsZAZQVhJ90MfmnLxBwPWZ+Eb2mraD8m0bdg2rEwkTsP
	ej+8+X7fXHOh+xyLnO9B7O9liKCFqIxiqs3a94tqyTxjViOBtJt/DMmiyNgHmpg2
	NBVA9nHXdDgXF6a84EvPItmHi/P2khSPa63v1TyNc6eG046jsfe+EAdLK4lBQw4E
	wbeKbSwWnTowPsT7W+YOX8RHAZVzHxzVcfIWW8fcEdbogbzGsX22VGPJGBzkRuBo
	/3KGIV9gwsFktl2R4nvLrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729706479; x=
	1729792879; bh=iAsKzV6aXierCdCfWwtPZk8WKyaa9MVSX4rtUHQVwyc=; b=d
	9RDjzZUmmND5hUJHgjvFzQe2SmwX/oHrLD6EfgxqUNOQNsrBNrHTC+I+ObHUhhBh
	xt6eyl7X6cBi+mqsM6q0NotIDa6rJG1kvU8Soh0tPMioJOCrKyRYbn3KXZlYodD4
	0nPkHtUfHXOUPjCK1Gu63qlP+U7DKzs/DqKVwU5x695BKwtQh6MeAGriAVAmpgsb
	piZFqdshTIbk7HJDN1P6pGSkP+fVsr8z2/kLydQjagF1LNEwawgWgycwKxTbxQeL
	j8hQqYY+dieOlZ3/mziMt6t/E41+ceoIv0AIWpc6hGkfqbbwsclKqg/jX7l/OI5B
	FH3472KlFZDoLZBN0pAYg==
X-ME-Sender: <xms:7jkZZxChvyZ37JysLG0o2R-ViBtrjK0t8geVWIXPhSl_RLpshPXZMqo>
    <xme:7jkZZ_gPAk3vzJTTMIaYMDwwJwFyyKJoCoJfKld7dqk2dNNPJhE1AEe0iMwRf0O1Y
    dH8nvmhaei4k2ueYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefghffhvdefleefuedvieffhfef
    lefhvdeggfffuddtueelteekvdefleeuudfffeenucffohhmrghinhepmhgvrhhrihgrmh
    dqfigvsghsthgvrhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlghhonhgvlhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7jkZZ8n0OWSNNKBBSq-rFA-m4-icBY3opF-E9o5wQkDyI5lNNZ3gKw>
    <xmx:7jkZZ7w7yfrdITj4r2DJZnga7ObYhU7wdjdwZBXiA54zTtxmHk4huQ>
    <xmx:7jkZZ2Qb7egdY9pC3CtCfOj3ZGwetrm0_GrZhTE-TZbBncBmibw30A>
    <xmx:7jkZZ-Ydp6wxJXbD9NHPLtzAOlAHXJjKw5QRhMEMz0OEiWnCuf00BA>
    <xmx:7zkZZ5KCjdE165OsBKQYsjLwCrCUH9MAxjAjIv-n8I4fyBxo4SF7iB4H>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C87DE78006A; Wed, 23 Oct 2024 14:01:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 20:00:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Andrew Kreimer" <algonell@gmail.com>, git@vger.kernel.org
Message-Id: <fa5d771b-5819-4ede-bc95-9d50c456c619@app.fastmail.com>
In-Reply-To: <20241023170111.6638-1-algonell@gmail.com>
References: <20241023170111.6638-1-algonell@gmail.com>
Subject: Re: [PATCH] t: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

All of the changes here look good.

On Wed, Oct 23, 2024, at 19:01, Andrew Kreimer wrote:
> Fix typos in documentation, comments, etc.
>
> Via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> [=E2=80=A6]
> diff --git a/t/t5303-pack-corruption-resilience.sh
> b/t/t5303-pack-corruption-resilience.sh
> index e6a43ec9ae..b634bfb665 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -15,7 +15,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  # 1) blob_2 is a delta with blob_1 for base and blob_3 is a delta with
> blob2
>  #    for base, such that blob_3 delta depth is 2;
>  #
> -# 2) the bulk of object data is uncompressible so the text part remai=
ns
> +# 2) the bulk of object data is incompressible so the text part remai=
ns

Unusual word IME but makes sense here after googling:
https://www.merriam-webster.com/dictionary/contiguous

> [=E2=80=A6]
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index bc2bada34c..aecd03d69f 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -147,7 +147,7 @@ test_expect_success 'push from/to new branch fails
> with upstream and simple ' '
>  #  - the default push succeeds
>  #
>  # A previous test expected this to fail, but for the wrong reasons:
> -# it expected a fail becaause the branch is new and cannot be pushed,
> but
> +# it expected a fail because the branch is new and cannot be pushed,

Also: s/a fail/a failure/ ?

Perhaps =E2=80=9Cto fail=E2=80=9D.

> [=E2=80=A6]
> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index cd05321e17..3816ed5058 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -945,7 +945,7 @@ test_expect_success 'creationToken heuristic with
> failed downloads (clone)' '
>  		--bundle-uri=3D"$HTTPD_URL/bundle-list" \
>  		"$HTTPD_URL/smart/fetch.git" download-3 &&
>
> -	# As long as we have continguous successful downloads,
> +	# As long as we have contiguous successful downloads,

Contiguous in the sense of =E2=80=9Cnext or near in time or sequence=E2=80=
=9D.  Makes
sense in this context.

> [=E2=80=A6]
> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 06c1301222..2458e9d0eb 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -77,7 +77,7 @@ test_expect_success 'before initial commit, things
> added (-z)' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success 'make first commit, comfirm HEAD oid and branch' '
> +test_expect_success 'make first commit, confirm HEAD oid and branch' '

Easy to mistake m/n in monospace font. :P

> [=E2=80=A6]

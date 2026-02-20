Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B002FF154
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619223; cv=none; b=DFI4AC0bKBvKcYNz0Y/Qt7ENQC9TnF32/t+DaNvNl2RahGezq53TNSvvXJdetH1vM/C3JAq7dGYxzDZ+ZMu0TlttKGiOFSdkWBvyMseTqESqzrfoLDFP5UwOOyPwtvaWLBm/VQ/lSRqdfDjJPD0dpWyKWlBquxPpzjI7fqlnVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619223; c=relaxed/simple;
	bh=E51qOIozeSBLmk5m0RFGN2/nOoThiWBC2abfpeSVf54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UTji6dhluF1tjJwqQt4PBURryl6PgkRogC/Ru/f+EcrV1afd4MGKWxgqWb6NxJloNDuzBgzj6sBaJYzK+fQMfHiTRLsVpxie1e6YnVIZNuZq2nu3WnxqNpAbyevecZN8s5x6Gku5Qc7LvzZQZZuRxWzfid//Ljq9asXBZ5R2XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cKxFHsyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ikm1yCp6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cKxFHsyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ikm1yCp6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D2381D001E4;
	Fri, 20 Feb 2026 15:27:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 15:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771619221; x=1771705621; bh=s2hd9XJ/96
	VTwvb2BLjWcPcTBLS5yVctX8/lefCTEK0=; b=cKxFHsyzV+AY19ngetZFtVWSiw
	BQVuf1JxayriUGZogHSEIreprIvJ01EgB6q4Bn7K+GOxBpIaqCRMrMELV7KPVt2m
	ieEM6wwlcM5s7PDlWZDS2v8pCPd9SD8RIV0xBcXa8I9mf9+Q5lTsLbgOaDtaBeCl
	BQuQgjTmhT0QZbOnvuuOtlwMkbSnHsg/8weOXYyUFV/ztl9xh/IufVzdgS7N7RGA
	V5RVUSM/gNBFjQq18ZWcyX4dScPIwLficXyZsTmgnDye7Ka+stUC7igsHBcehIqc
	QmEn4964mWMhdORgCAfjHsZKsnjvYCb5yFKqap3X8ZePcCi+plz8H/fsPu0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771619221; x=1771705621; bh=s2hd9XJ/96VTwvb2BLjWcPcTBLS5yVctX8/
	lefCTEK0=; b=Ikm1yCp6g40wOOVcaFASOLDItA8Hc06eFtFRkOBFs0MZk8hEeUr
	lKO6tEy5dZu0WAUL5SLU47G9bvm6FZpfA4zWXFtJa7HBkud86gURI06ZLotG8yoo
	eqtV7St+arBFrk/U1wUiwKs8pKjGgfFTcQdbkq8ewVchQTPm4eZLakrFNK+fq9nq
	aBEg17/6rQPNFMG3EdCk9g99fZlEYEyA28GfSMsBHTA3taGiQn0CrrYRx/X6fPbe
	wzGYbJUEDa+PirF9RG099DD3wPBpt+yUtsUwXPiQHjVp/87VuUoVHA5DvCCL0QqS
	jhDDOrgp3X0d/lijDLRUb5MMWRni/3ZkpMw==
X-ME-Sender: <xms:lMOYafElX4W66PbUeEFQOgp77M0ltN2AqWMTSaWRKI44-MoiWYUcNA>
    <xme:lMOYaQDvNjXXCe2W0mpgfX21f1ggjthVoYng04kkXre_mNeFHV2tFtuKoConvnKqI
    PEcIN5sr-d9BJgS2QMTVmFdt2kF0nC1rJPAWidhWBWL5nfBl-LvmA>
X-ME-Received: <xmr:lMOYaa8d4Z-ttmyY-pGtd1sYWhGXVM5SnBGZVoY4nnp-DbLOIAUN2Ek7kn6P0n9FI76kVpyiV4oo5yQCIuVZdXMC_TwinQwyXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehjohgrqhhuihhmrhhotghhrgdrtg
    homhdprhgtphhtthhopehjohgrqhhuihhmsegrmhhuthgrsghlvgdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lcOYaUBNxla9oUXlI8BYjNKCpSbX30cloKaoCsj7Hj_ILZ5oCbWhOw>
    <xmx:lcOYaXQzTDlk4EZ4Ui_AB54peimYqCsXNkeYuUsp-O_YsXy3bVJYdg>
    <xmx:lcOYaTs_zHE99SPrcEfVwYsXRn78W367Kt3d2ZtELWeTQofj23MUkg>
    <xmx:lcOYab1kMnfT0dAKuJhT3nCijk43BP0ZtL9DDT8VZi7N76O12iNpQQ>
    <xmx:lcOYafZB63wCum7KZ7R3HJOZkrNf0pO4SHStfiP64WvQ7cTqtyuMWEdQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 15:27:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Joaquim Rocha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Joaquim Rocha
 <me@joaquimrocha.com>,  Joaquim Rocha <joaquim@amutable.com>
Subject: Re: [PATCH v2] apply: normalize path in --directory argument
In-Reply-To: <pull.2198.v2.git.git.1771373732749.gitgitgadget@gmail.com>
	(Joaquim Rocha via GitGitGadget's message of "Wed, 18 Feb 2026
	00:15:32 +0000")
References: <pull.2198.git.git.1771002510709.gitgitgadget@gmail.com>
	<pull.2198.v2.git.git.1771373732749.gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 12:26:59 -0800
Message-ID: <xmqqpl5zw48c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joaquim Rocha via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Joaquim Rocha <joaquim@amutable.com>
>
> When passing a relative path like --directory=./some/sub, the leading
> "./" caused apply to prepend it literally to patch filenames, resulting
> in an error (invalid path).
> There may be more cases like this where users pass some/./path to the
> directory which can easily be normalized to an acceptable path, so
> these changes try to normalize the path before using it.
>
> Signed-off-by: Joaquim Rocha <joaquim@amutable.com>
> ---
>     apply: strip ./ prefix from --directory argument
>     
>     Changes since v1:
>     
>      * Normalized the path as Patrick recommended

Sounds like a sensible direction to go.

Will queue.  Thanks.  (of course, further reviews welcome).


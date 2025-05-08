Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260C1865EE
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717285; cv=none; b=Nh4scWpjSliqiBVMNBBEfL6MbVCiVopPs5ph9Q4lfNbeGPMXSHDxtapRKzr+cXqv380/uIHs8tl49jQ0fQoFWZRVA62VnOlNx/8jbXdl4kByd3ZHL/T8s86XooYz4anyHPHdwFMIb24UaJWilxmyf9HhCkEz/pDSok0WceObx5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717285; c=relaxed/simple;
	bh=WqoPvBUQRr820NuhNKMY8yZRJazpOEtTny1gTmiYptw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOvtWmIz8kyZ6o1non82sMalakLoyqmmnv/wK/q2eegYkjJTUoP91qlcys2z0o1yjKiHvrOoaWlauimBwfDBCfz+Hr3BU/fH7Ee/h7mNgNyh61agkeH+sVtYgrMpopUVya4TR+e3tXYh/Ryq4GL+b0ZHjmGHcTKz40nqXs5M1XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5c9MGl9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nih1iKUv; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5c9MGl9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nih1iKUv"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 770C7254012A;
	Thu,  8 May 2025 11:14:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 08 May 2025 11:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746717282;
	 x=1746803682; bh=tpuSpyn4RFhc+A9616KW48QHUho/bbu1HOrzt2fgI4Y=; b=
	E5c9MGl9HtsDbEVNeEySmk/YTZKvwH9kKEEd7feVdybgKYMf8NaIPytFtSX2xFh1
	3OsFII0MOiNyBYsjNeW3SyX/2/FoxIBnJGFP+nkNnMsuUu4yJ6oR4lhbeuDshkh/
	90XSfSEf9qmwwkwUSyXX6PalbZsYv5Y1loTnxYGjUjClDbRnzYBjlIYDJHM7z7go
	y27VUpxD1wS1DiJw6bGOpJEk2r5aEjkxs1khNFOgc76Fibp2Ya9hjU4dlOtXT/X7
	RF+eLy5uTbBI7KVasoUMxnqKQXUQy2gSZDePKPhnagH4BAXStf+2BCoU/EXKH9tI
	sgulbh/6wgVmiLf82c8YDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746717282; x=
	1746803682; bh=tpuSpyn4RFhc+A9616KW48QHUho/bbu1HOrzt2fgI4Y=; b=N
	ih1iKUvTSBstwIvC8m7PDAMURXacgDx74+4+t0F4YWzZ0yGdqX0T6K6EUKoSfwFs
	5urlvIkuuwyNpOSCY9XLriZuxJyCUIM69UZummwPUnUOX8zhQ+uOC9rQlkGvLQIC
	hT0q0gb7PJrw48aWhk9nexSyK5OcPcUXGxBR5mIqGpQjuyi7PNzDl0jN37LkTL27
	TQbJ68hvIh07s0Ikzr/sJzhX6Mji8iwIorvLdhLEYSeOKPDf5X0hj9PiVA1oPsKe
	CvRQAyk3wAKV1a10Hm1BzvNr+9GSA9PkEaoL/BMJYmCQHjNXAkr6Sdk60BqXoyQR
	JMfILqAqng6XhbcBLPWyQ==
X-ME-Sender: <xms:YsocaF5wzhG96_QosAfJSNgbGdbc7PtXxeh2AVM3KZIg5ZfTAeb2oQ>
    <xme:YsocaC5oeHDCl3G4eRySU6GUQZz05HsM2H19Z7EzV9kWkpGUqRAJfZMtzn71rcUj6
    xMFqIcFb3gv7CKALQ>
X-ME-Received: <xmr:YsocaMcHpvYM3DjS0vrnZwzBUY4j6QSW56AJaZb-v6o3JGaAKjaIY9l7cP2MCHbovJWMlnUyNXDznM11gpfMrPLH9CCBok4uNqdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YsocaOKFBTLaHGFHbF5Mwr7BPa1-1ctyUHwOszJCTWUrPgdHirJLcg>
    <xmx:YsocaJLRPuchoaoK1YUI1jbMyWQcqjeHCrigNk_OMRBRO4Fv8TkBQQ>
    <xmx:YsocaHwDhzU7NOh2LoNxWxtFGzjw9-IXrQTKhCIffSJ6j-Bknrs00Q>
    <xmx:YsocaFJ1i0jrWMY3sXtApR5TtmDq_kw6LnCYmRi7TM6nczY7gIT2lg>
    <xmx:YsocaFN9_vng2VOFhodgAXMDBqGgfqlIpEWpVYj2E2q3EIb6pg5a6tW5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 11:14:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Additional changes
In-Reply-To: <20250507210104.26709-2-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
	message of "Wed, 7 May 2025 22:58:16 +0200")
References: <20250503011537.3035416-1-gitster@pobox.com>
	<20250507210104.26709-1-jn.avila@free.fr>
	<20250507210104.26709-2-jn.avila@free.fr>
Date: Thu, 08 May 2025 08:14:40 -0700
Message-ID: <xmqq1psz878f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> ---
>  Documentation/git-daemon.adoc     | 60 +++++++++++++++----------------
>  Documentation/git-var.adoc        | 40 ++++++++++-----------
>  Documentation/git-verify-tag.adoc |  2 +-
>  Documentation/git-write-tree.adoc |  2 +-
>  4 files changed, 51 insertions(+), 53 deletions(-)

I was somewhat confused where this patch is designed to apply, but I
think I figured it out.  These are to further update on top of my
synopsis related mark-up updates.

Do you mean this as a set of review comment, i.e. I am expected to
spilt them into parts and fold them into those three commits to
produce an updated version of those three patches with "Helped-by:"
attributing you?

Or do you want this to sit on top of the 3-patch series separately
as the 4th patch?  If the latter we'd need a log message plus
sign-off.

I'd assume it is the former (as the three-patch series hasn't hit
'next' yet) and start updating htese three patches.

Thanks.

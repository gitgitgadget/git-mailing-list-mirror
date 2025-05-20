Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D94DDA9
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768531; cv=none; b=n0HpTK3xyxG85CuGZSaJJkI481RN4Xxnaui3ThNHnIOMpCwMiv4m0eJppQLSLjsvB3tmsc12Qr+jLUiXnXhc7SJvQeKDBizCjMBmZVtbEeq7aNWzonT6HXEN5TYjo3mdPg40hiOZ66gEHtlpOkZfA2sKiTTRTZ3HhT4cQiBM/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768531; c=relaxed/simple;
	bh=6mjZOJwpM1lU/Mzv8t8VtltX3B/PzhQYkFclsjQmsRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VEXOyU1jwQktt0S6Lo7+wvqNZcmbY5KT5Jst5jLenhT29VGQYL1FDU+0XHOsHYZ5Yc88u4TGFxlPwfF6/ymEAvbgLdMMqgZxcajaQhkKaFG3cSW+4jvNTQcW0wXp48IZ9CxhqjaGtGqDlfxnw9DbeY+K7x682hTWKeAVa1bVIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RIdii0PB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qnxRrbVs; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIdii0PB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qnxRrbVs"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 918F511400AB;
	Tue, 20 May 2025 15:15:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 15:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747768528; x=1747854928; bh=CdUdIVoLIj
	fc9BAOCzBaEMQJE8epKdr9Qw7tZeWe4oU=; b=RIdii0PB+kmHvMVcSbGq4iKDaE
	lnXmF6kBcJI11S1QvDDBN9wsHElABqx8obMOBBgvTH403LMcqAwEDSo3sa7z/jhF
	k80HNYaEuik78ZkP5MRiXfiin2BoG2BTm6bwUyD24MlTFgMhZoKMOk3n8+HFcVg7
	MLyPVWKjZCCMdGNThxpRvseyQ0ipc8Z3WQiKdob0HcNcghzfX0Nr9UrGAa8VLZL8
	oPC7yrhlHzLOPZZl3LIYdQGbepfQU8hUwyLjGjUztOrV/ugTqNnFP8/VPu2/LDim
	jTG1xledI7lPQlX+2EULfSLn1QUMEDju209rbox77s6EU5+nlsjJTfIIi7bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747768528; x=1747854928; bh=CdUdIVoLIjfc9BAOCzBaEMQJE8epKdr9Qw7
	tZeWe4oU=; b=qnxRrbVs4Tqhj0/QT4oW8stdrNVSwnvjj4TggI1woKxkFIBejh8
	/uyLwIcm4QqZR05oR9PHQgu+xFx5MmjqPVhp6P0L9Gc04Zh3unyK0cW+KqpecLpN
	FiSHayt/r00Mw/JyfsuyPrmA+aA4RDMGgkEMZO38pppHVIDl36ZcQdcR+afXqb4M
	m6XnLN/7r+W/LAQeG6xMIg9IIT9ek4zJeNU/RfQ2hKhmBVdXKedKMuRq0JfUKDmG
	y8c0jKvsQy7hDMk3y6L4Qahqg9mYcmrK0nSdXolOVDvzPJuKk+0SqMFHC4BhZfJN
	sfqV6lw3RBrM4o2KLYj0qLL39GO4cThHq2Q==
X-ME-Sender: <xms:0NQsaDSs2y7fbCl2-nyjpO_OQhyT4bVm8WBCXhADQrsxoLX420JI7Q>
    <xme:0NQsaEwmJXCpDLlx0Iw0MHwYdrI-EJFaodXE-FF3QdRwKyhnJpFFtTTiGij4cPLyg
    9OgMNI3P4rvUkHlWQ>
X-ME-Received: <xmr:0NQsaI3uqU1ITW1XO3e1rMDUGutDwf57n17FvKdzVw1EMIS9T4QvVHPhZpPfxyN17gqfp6ApyXldVtiRklREmd2jAexdXd8SUOoA_z8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddutddvucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffg
    fedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeguhihrohhn
    vghtvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:0NQsaDCsjDLrNdjWBtkyLqIACteXFsxFNKcKa749u1NLmF0cltmmWQ>
    <xmx:0NQsaMg0HIGxHwEA6sasNeP7tBC_FB298E1iZtGEDiOYG4C2K2XFZQ>
    <xmx:0NQsaHrFtOk0WrqAUZYTmpSEbJFULXat_Nhnm24wXbgrxQf0BD4rjA>
    <xmx:0NQsaHhCeTbIcwKk7WeBFjFMkYmRPoNiBI1qFRQ8f08Yp9n6iQQOdg>
    <xmx:0NQsaHFAqWsZR2CJHxbAMRq2RzKqnB4etrVWkYiPsSDLZaYWi6LsTJs5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 15:15:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 5/6] doc: notes: point out copy --stdin use with argv
In-Reply-To: <cbb177479cae24b85284d507beff4b7abe173dc8.1747763769.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 20 May 2025
	19:57:23 +0200")
References: <cover.1747763769.git.code@khaugsbakk.name>
	<cbb177479cae24b85284d507beff4b7abe173dc8.1747763769.git.code@khaugsbakk.name>
Date: Tue, 20 May 2025 12:15:26 -0700
Message-ID: <xmqq7c2bhz5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Unlike `remove --stdin`, this option cannot be combined with object
> names given via the command line.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-notes.adoc | 3 +++
>  1 file changed, 3 insertions(+)

OK.

> diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
> index 1b714eb9e81..d2d7dac8d41 100644
> --- a/Documentation/git-notes.adoc
> +++ b/Documentation/git-notes.adoc
> @@ -87,6 +87,9 @@ In `--stdin` mode, take lines in the format
>  on standard input, and copy the notes from each _<from-object>_ to its
>  corresponding _<to-object>_.  (The optional _<rest>_ is ignored so that
>  the command can read the input given to the `post-rewrite` hook.)
> ++
> +`--stdin` cannot be combined with object names given on the command
> +line.
>  
>  `append`::
>  	Append new message(s) given by `-m` or `-F` options to an

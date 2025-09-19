Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4413016E2
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321248; cv=none; b=pLtPH5kFZjV7jIGdTh7DjDZztySKerQVUfA6YMtAZFl8jDwT7d5fmd4JmyV5wsYV4m2msP1De1s5OHZID1UXnMVmbX+J9mA9DLMCo4x5+ON0wvxZLQH846zKMF0R7zaWGxHldWHFgn5FXBtm8gpb4l3ZOmu9ZEFFo9AphMaONes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321248; c=relaxed/simple;
	bh=Bt7LVHm4jDdsV81WMGd2Ja4IlB8A+LG355QOtHoyIDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCHRvIWaPCPG+ItmcTlpmY2/jXCk+U4RFnQJfgqwPN0BoD57GegesAjDoJPMj7y5CukQeV5UcTRl+38rfD142aal43q9rOLoJZRe+QorimngrHBqnbWXDFSEd+juU3tHofaHejM0+3LBmvUx7uCchgPoSOUYmh/0JqIDAQ+u9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3N5Fyq4X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZ4lVguX; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3N5Fyq4X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZ4lVguX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D50041D0003E;
	Fri, 19 Sep 2025 18:34:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 18:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758321243; x=1758407643; bh=XtpEGbVBIK
	4/DsfxZWpkJcos17EyiqEPZ/XkeodNIUk=; b=3N5Fyq4X5VHixmQK8eKzwGdBrX
	KblPnfupIA4bqVbkH/1o4TV2lbD+veO6gwIha81OhS0edy2oOyvlGpKfs9faM93z
	487P9cmsh8LXViN/Kc2gYwc19lOUwZMI6Bp47K53q9BwQJ8wayR3x0nJE6++tWa6
	YeDkDKRBa0VzLVkE2PrGzDZH78MxmkNcceTo/t9lVXbMW0R4qrBFU6c7QNwcAqEq
	K2D2MhZbEDLmZvds4xB1BuoZ19w64Ffq0Gd2QiqoRYgI+Av27Sza7S0hEh3j5Rpj
	Y+olpPiTW+Jhm9f5AEAIISSv0bRTrOJImsIeRx2pMzAYT5ve4gWq19Ta7jwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758321243; x=1758407643; bh=XtpEGbVBIK4/DsfxZWpkJcos17EyiqEPZ/X
	keodNIUk=; b=jZ4lVguX5JTF2vUX0S6bTlrDfIA9pSLdrpOvdlg7Zc0aHaH9xEZ
	xuh255Mn2DNOtn2eLahb1WlaISZj4kqeMcW5ZvJxPeS7rbARp2ZlveT3xDOot06p
	hvpx4qlBjpsToSvPRQqKugXvCVFi2s6LJfcCU2m5FeL/bUBWADVNGckA1snLTPkm
	5wiuRxObboBYwozJT+FTPtKzNkaIBe35ob/hq4uVH8yP8XWiMv64jvwaLNvbMBeC
	hc1owO8HkO6AiBfbYZF1XjSvV7ZOLZ8rd2tCmo4IE3GSZU7L5/JhAeaYMv+4z/N7
	xXGQNAIdyepde+LI30SOuC1djt75PgzzTZA==
X-ME-Sender: <xms:W9rNaP8oBuJOJgRqDJHvklPPEYC2_XUaqrvrzVdch9AGqvnzhUMX2A>
    <xme:W9rNaHMhm1VJLg7pJlfKrOuTD9meronrkbvTlSpPTzHrh6YjE9zkbFFuWLGGCGsiC
    XczklkLsdhhYeCWgw>
X-ME-Received: <xmr:W9rNaDe6v-gn_pyMrRAT2ZNH76lhMzWtnl7H3GvtTKcjXtiuGy6YUnM6tyXsxxy-xhmT7Cuf2oiNjyTeYJYnh6HUdiKXc6-4zba0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:W9rNaGVwueyakwdPWVzX_rs73jbuoEXUuv6axhMaCzApmU1dg7iDYA>
    <xmx:W9rNaLjyB50fNiITEEa9gi_xSM6PuvIBF9MNmufROL1dGhh-MDUQHg>
    <xmx:W9rNaF_wTKgk3fpDhNsfDgiqv7ZDwZVwlB5D0KQVamxIpAWBwrz2Fg>
    <xmx:W9rNaNbzvLk-QVlVY7j1xkGVrebuiubJGIIfy9tBtHXIG9nh_HUqaQ>
    <xmx:W9rNaGhh1DUimrNTCd_sc132EEtpMzPMFg_gCkm8xxBmZFSwczouPJdx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 18:34:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 3/9] docs: reflect actual double signature for tags
In-Reply-To: <20250919010911.649831-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:05 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-4-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 15:34:02 -0700
Message-ID: <xmqq348i138l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  Signed Tags
>  ~~~~~~~~~~~
> +We add new fields "gpgsig" and "gpgsig-sha256" to the tag object format to
> +allow signing tags in both formats.  The in-body signature is used for the
> +signature in the current hash algorithm and the header is used for the
> +signature in the other algorithm.  Thus, a dual-signature tag will contain both

Not suggesting a change in the text, but to make sure I am reading
the new text correctly.  Does "the other algorithm" refer to the
compatibility hash algorithm specified by the compatObjectFormat
extension and the "current" algorithm refers to the objectFormat
extension?

> +an in-body signature and a gpgsig-sha256 header for the SHA-1 format of an
> +object or both an in-body signature and a gpgsig header for the SHA-256 format
> +of and object.
>  
> -This means tags can be signed
> +The signed payload of the tag is the content of the tag in the current
> +algorithm with both its gpgsig and gpgsig-sha256 fields and

My reading of the previous paragraph is that we cannot have gpgsig
and gpgsig-sha256 fields on a single object at the same time.

Should we say "gpgsig or gpgsig-sha256" (instead of "and"), to get
the resulting text parsable as:

	both 
		its gpgsig or gpgsig-sha256 fields
	and
		"-----BEGIN PGP SIGNATURE-----" delimited in-body signature
	removed.

instead?

> +"-----BEGIN PGP SIGNATURE-----" delimited in-body signature removed.
>  
> -1. using SHA-1 only, as in existing signed tag objects
> -2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
> -   signature.
> -3. using only SHA-256, by only using the gpgsig-sha256 field.
> +This means tags can be signed using one or both algorithms.
>  
>  Mergetag embedding
>  ~~~~~~~~~~~~~~~~~~

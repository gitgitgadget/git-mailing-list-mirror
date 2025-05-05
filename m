Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABE26F452
	for <git@vger.kernel.org>; Mon,  5 May 2025 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479685; cv=none; b=ZUFfvICtEh/VGhxu5v0o2sI60tD0yPE/fsS0ZM5yRi2MEbc6hBh4AnQRSbi5MoJ8krGDe/aNs8gnLk9IksHHzbXDydU6W8+cFNGBYKYhaMYlxycbnPDJqbNgLS47ZBoUmlF0uTohyFLTPlNacrfi0hTfZpc7/J/c/9W4/aKYx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479685; c=relaxed/simple;
	bh=2Bf7bFuVOJh/qpUXTnPm3V6iIdU/pJbNGFHAoaZYs7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CHQNHYLXGrAIKOF8OQCNdeKOTKewPK+DXO0R7YXGy+N7gnJv3cxE3Sa29EBFMCCZLAgCKtywwVKDf4XzaoBwSya4aRLGdnnmSfbfd26J6q/eeAHovjGw9B2v+MegLCuji56H9DdNobfYWhkNc5LbGRt9qe0G0cD4J0fOstwPD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S0ET0d94; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iw0jHFhh; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S0ET0d94";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iw0jHFhh"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D4A4011401CF;
	Mon,  5 May 2025 17:14:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 05 May 2025 17:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746479681;
	 x=1746566081; bh=fhY+IRzoL4JyK4JHXeTmqPlZaOK12VZpSze43ut/iQs=; b=
	S0ET0d94DiEAlwlDfii6+ZPXlqO4R/p6qKVRz7oeAxNGxnhY+GOd6/pKzccbSdir
	EX+ckVABu8eCH4nY6OhNNWzaVSAHo0mLCGD9py29g7ZWWshqtJrSi9//kpJu04g3
	vxQYiz5Pt41v9lVazUMh3LEMVYfPC/iUqzHMPX4Du2VzAH1BX7I9DcSkRy4oTtZp
	xsaZWowcGfzzi/CeyXUXYleGTJOIS/dbwsJHstafyggq2A3hL3qMqv1WR14YAxUV
	PLnX2el7uY2d6Wx2k+qqoEk+VhOgYqYSFjXPM8ml8PiO6hGUvOpseMz4u7B4Uy1d
	z9L1MrzIZptMWpJmqh0XmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746479681; x=
	1746566081; bh=fhY+IRzoL4JyK4JHXeTmqPlZaOK12VZpSze43ut/iQs=; b=I
	w0jHFhhn20LCLG7+CKOYnRopjop6Gx9EVAVDOE6gtG222kZjKu9gF7zsTDthl6sr
	u7u2MX7SC/JFQ4gSUTf2ufOdwsZwiI9ADIzya6z2Ids6F3asQ5cZeXVu7N62qxAX
	ETLXUEpWFHoAus31nFW7/6KPBy8wItlnGlsSsCgpD0jGlKHSLT72hEKLBE41bR++
	SGR8wXgATLPWwiVU9Ex7402DH7//UcsrQBLe3FKFyGjnyJhTyfM22a99D1BTRrhE
	c03kl54kypcqIUGvyspMw96kKxl7tLKAshwm+ddADxMrmGM33HGgE86jqaHAfvmz
	s0cWxLETYrfV5i6o0XTPg==
X-ME-Sender: <xms:QSoZaENE83hko42qqGZoF-Bx-dhjuURuHYTfpY8PFXdDUF8PFo0IYw>
    <xme:QSoZaK9eol7H90FWceTW0eBgC9PCFd489Wez249CfBEwu-aF2LUFFjE81E1Q6fBnm
    0_CutBskx5ZxSF5lg>
X-ME-Received: <xmr:QSoZaLTi5y6fVaSvTZhlWESqgIFHqKy076-QsJEUCy66DiyZMVvrZBWMJ9jUYcoyX52IxNbqAbCKrPrCnabrRQlYa1rG_iEpxZx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QSoZaMuqPKkIn5GhXyVWKPRUxZkxRGEflOB1yfq6AzT6_2s_z5vN7w>
    <xmx:QSoZaMferklnaks-lc4sFsTX8iGhRHMPKanl7wspXL3HKwVQRhbtjg>
    <xmx:QSoZaA1B9u3xQRHRN1ewpdxpGkXBCbwkWqgkE_b0qHJ1FJpkgIxGww>
    <xmx:QSoZaA_y5EBMyGUXGpY9D67mxWPdYNrTSmvPBvdvUtFvugZ4lsdWQQ>
    <xmx:QSoZaAFFOHpFHFXCpJRUyYvFAHMAqNwrWL1SI1iX8TclWy1bUmxRRGGY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 17:14:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Seyi Chamber <kuforiji98@gmail.com>,  git@vger.kernel.org,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] t/unit-tests: convert reftable block test to
 use clar
In-Reply-To: <aBiKSeTLItw85A8z@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 11:52:09 +0200")
References: <20250429175302.23724-1-kuforiji98@gmail.com>
	<20250429175302.23724-4-kuforiji98@gmail.com>
	<aBSXGz_eIljWbb2H@pks.im>
	<CAGedMtcBsT=7=tL_y99_G9xNW43Bttb3dFqy68DfFt0ZgpZ-4Q@mail.gmail.com>
	<aBiKSeTLItw85A8z@pks.im>
Date: Mon, 05 May 2025 14:14:39 -0700
Message-ID: <xmqq7c2uoj40.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

>     -M[<n>], --find-renames[=<n>]
>         Detect renames. If <n> is specified, it is a threshold on the similarity index (i.e. amount
>         of addition/deletions compared to the file’s size). For example, -M90% means Git should
>         consider a delete/add pair to be a rename if more than 90% of the file hasn’t changed.
>         Without a % sign, the number is to be read as a fraction, with a decimal point before it.
>         I.e., -M5 becomes 0.5, and is thus the same as -M50%. Similarly, -M05 is the same as -M5%.
>         To limit detection to exact renames, use -M100%. The default similarity index is 50%.
>
> What you probably wanted to say is `--find-renames=90%`, but without the
> percentage sign it is read as a fraction, where 1 means "exact copy" and
> 0 means "all different".

I am confused.  -M<number> without trailing %-sign is taken as
fraction against 1 followed by the same number of '0' has the
<number> has digits.  -M5 is 5 over 10, -M50 is 50 over 100.  -M90
is 90 over 100, so -M90 and -M90% should mean the same thing.

But you are right.  When you want to claim your pre- and post- image
files still correspond with each other in a meaningful way, even
after making extensive change, you would want to _lower_, not raise,
your similarity threshold.  If the default is -M50, then -M90 would
be a useful option to reject what Git (mistakenly) thinks are renames
and tell it to instead consider they are removals and creations.

THanks.

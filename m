Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C30D33ADBC
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559415; cv=none; b=CtU7c5IuUncScVV/R8HdHfNX8jqrrPHz19JvyGfSNnk18zueYnk2/0isLBZ+wmioAlfuI4sHybGFlswQ+gIi7byOXA72yPF7yX7R0Mn/HE8RAvnd6WxN9VbwSHRP7GTSaH7Wo8oUN+lGqXahZv+uNJNyuJr4J8Mhdrf7joQJQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559415; c=relaxed/simple;
	bh=NGRhIYwbcIaPTxluVoMuIMwKb/0PKUOiUPq1ILmTgFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bSTSZ4ImfLQVpzGRtCDpY+FX7E2EDpbmBe7iZKbazSsce/+AsmW3Gk3IheD868K23d7Qq39AXQw6qPZ2yqeEaLi+RcTuyMeJxqgD5mFyF2rgAggU5Qm9w3wOOf6yQ0dQW2JM/tIErHapWOTTi+SSVUvqb79VCEEGMG/Nu/0TUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bji0c/53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4E2DpLpR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bji0c/53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4E2DpLpR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4BF11400218;
	Thu, 26 Mar 2026 17:10:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774559413; x=1774645813; bh=RX9nxDoUDh
	Y4CaFbNs8R9v5xzcqQPk15IwHW+2oT3iA=; b=Bji0c/53NVuEFKit6riGn/EjjD
	1yxLs19cqxEEQYOOz5ZxnY+rWMJYCCpyBUSSmUeoFISmMpjoA46Tznq2yl8CFjYK
	v9I8Rv8BVe5Mde2RSsWbVsCPTE+/qy+FtVmFfp9Zp2SrL21Qklakvi6xZLaIufwU
	QeEkHa6B2iLKxNQW33mKD4gUhycq86f7pwCRjs0o55sWKlBeO79KbbQlHhDI73c8
	fY4AbI49T9G/MIUgr733sJO4cfdDDSc7KYHNLaGwkDuwHKyeEn1EYKST0dPLIbWF
	f+lAGsuRuXUy3WEZFwurTs/dakKOBHBlHN1Y1UYgHzvp5rPKwAiwL8o6WuIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774559413; x=1774645813; bh=RX9nxDoUDhY4CaFbNs8R9v5xzcqQPk15IwH
	W+2oT3iA=; b=4E2DpLpR8B64cj/P38bn2OvGc14Ggt0peG2e3/AEDI7seftSH70
	WOt/tI25QcHJkPzqKEMBu5o3M9msn/bn+6I5TWU1ChBjnyqAvan6PcwPsn6RFxz8
	lvzOQm+ap3M5YZgf2mJl+67AXZhht0EAbwIgIFMh7xPvnSagWXNrN3LfOYECdRnx
	iFSFpyKjQY8u41bA73bYKEq6eGncDBqwphxnyfTlagC8oo9wLPz6c1IOXE4kV6N6
	dQE8GXD3ND+oOQBBwB9kcMgFhvRt0OauXi2d2XsS+XLjN6sS+nf/0L+yVdCMynrO
	sHlCxkMRZIccfTe1BcEtJVcRWdR1GFMx7Uw==
X-ME-Sender: <xms:taDFaX4ZwZVMhGZtsttmfiOzBdTnRBaFf0xZOdAmqz20gscpB8zkug>
    <xme:taDFaUUGGbaXwbTcGIaG4AGkePOPJak_BiHoekD_PM810gQoptcFpc2DFOT7mqCqy
    0snfI5Bn8kq9Nau6loHizgERBdM_epqPXIEkYwt1srMrYMvdumzfmQ>
X-ME-Received: <xmr:taDFab2xY9Ye_NDZ0dfS82uNtK3vHpJkViWQ1zGqGg0K-dftCPzQY7x6rYjWJa5L0KJBPDPkJUc10mFLvU78Vd2SdAlvODN3CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:taDFaR3_KIOajw37FCLqsLYJws0GITz2j0Xbl-kEp6m-zt66BCDgqg>
    <xmx:taDFae8oxmwOjfM3X545Dlxx1R8cfYGRcmSUAPwJ4-swaXy-jysPvg>
    <xmx:taDFae2oC2I9WH3NwFBbxWYzSac7oukOiF0vG6jaIcIvGVQXpdTEYQ>
    <xmx:taDFab_kCuc6l1HQD_o6oqyh6esxvAENVFtkDkvN9pe6i66GPDP70g>
    <xmx:taDFaVi-aKL5aD7fnvIr3OaN2lQddm0chgeXjU-Vg1OT97szRb7vhnUo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 17:10:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] docs: fix --commit-list-format related entries
In-Reply-To: <acWbpJTRusOv6bPk@exploit> (Mirko Faina's message of "Thu, 26 Mar
	2026 21:53:56 +0100")
References: <20260326185541.17523-1-mroik@delayed.space>
	<20260326200643.20251-1-mroik@delayed.space>
	<xmqqse9mnwv8.fsf@gitster.g> <acWbpJTRusOv6bPk@exploit>
Date: Thu, 26 Mar 2026 14:10:12 -0700
Message-ID: <xmqqo6kanvpn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Thu, Mar 26, 2026 at 01:45:15PM -0700, Junio C Hamano wrote:
>> Being verbose is usually a good way to discourage readers from
>> reading.
> ...
>>     The use of this command line option implies `--cover-letter`,
>>     unless explicitly countermanded with `--no-cover-letter`.
>
> this part in particular is no different than the original text:
>
>     This option implies the use of `--cover-letter` unless
>     `--no-cover-letter` is given.
>
> If we want to emphasize that the configuration variable doesn't imply
> --cover-letter, we have to add the note on `format.commitListFormat`.

I do not think so.  

If we mention a variable, the readers would wonder if the variable
has effects.  You can explicitly say that that it does *not* have
effect, but we are often better of not mentioning what is not
relevant.

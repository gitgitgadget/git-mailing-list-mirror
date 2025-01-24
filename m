Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D005D23B0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737738399; cv=none; b=ReMgOTvQjut04Y9lkeMmGy4WW/hU5zo4Rdq0FiYIENV2gFVVIxg8NEqhKSCIaubwGmMZ8NUwF6seT4qB+fUjhI2i3Llg0z/7arl532ovJWqZjAUyJMY0l5JqtleYshV0zRj3ErN/uAdZeu1C+SzS+HzcqvNUF7oakeh3XRWLdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737738399; c=relaxed/simple;
	bh=eiwyiqJkyW/RAG4cs8d+A3Kexw/s3PByYhgZU/3J57s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLdmA9IkK6y2KL8UwTEaMBvpLT0fPlN+G+VTrCZvmrLjlStkHgmnR7IRP+pugibON0vKEGh8njdwreLKHFMOa4tYNnRFFzL8X1vMmYh4D5sjkiCyS7YXAwuS5u+iOj6h+ZYJ2Gsre8pFRbQtZxjAbnPw7FP9rV8yyIFUPQuaDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gqtyq1jQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpqIaVvn; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gqtyq1jQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpqIaVvn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B9C71114008A;
	Fri, 24 Jan 2025 12:06:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 24 Jan 2025 12:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737738396; x=1737824796; bh=eiwyiqJkyW
	/RAG4cs8d+A3Kexw/s3PByYhgZU/3J57s=; b=gqtyq1jQlgLrrm5akEYPS2w0pJ
	oAvT0DJ1IQVGrh8PG71gp3x4qCWv6mmVR2sC3KiIP/jF14GSxTmE/1aZJn0HbXhh
	YEmdN9LFvYrX1vJJE1yjDLQ94RMScm9aaAtE2cvHlZh1Ndk/8Y/hnc87evt2dFOQ
	MnlrHSsEURjVesUzmVPUNTsb7nm9D3HBQNLLq1EKHlIAq3y9a9RNPYHPWxwKp5Az
	iTpYzQuUdB3Yn+ZEQ4lJSBKu1CE4VXzuyghAkD7lEqcsepAva4u+8+X/BlR8MG3V
	1FiwWbaxJZUyClATUVRG/Psp0Zg3ulEwJnba077CXi/hDq5KR/5cU2d6i7tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737738396; x=1737824796; bh=eiwyiqJkyW/RAG4cs8d+A3Kexw/s3PByYhg
	ZU/3J57s=; b=kpqIaVvnGz01ApV2iZxBZWarSl1AsCs9+jqClfSLQu68mAL2V3t
	uI11V0xjkUlt6p0hr7JBaM/xw9RWclVJggnqcWb3GLaFpg1uLQgqZwoqR31O8t0g
	FmfT+aGHVu0YktkVtV+RPBQV7Utxt+piGA3kgabEAtsJGbk+HFGePGR7Wdyj+ayE
	G0pI7ha7xi5CJrngjTKKLD54PrOUptZ+65ZVi/g9xD56WWgQoyi4RpjVKzQHhWDG
	GvOXNiRcTK3TjCmm5ksP1qlgUPe6y1C33ZdYmZg/ZP9OF4KdVkiGhQQicvGF3aDn
	24TozOn/Fv2+dPfvD+oTvxv/Tkmnf3s08kA==
X-ME-Sender: <xms:nMiTZ5GxNv3I58YzbeW9_YhX-LZxPdnRjys36i3GETdQequHqkhAWw>
    <xme:nMiTZ-X8c6tdewZvJXkKgrBIHyz7pLz7w_GezsOlcdYdfuxXTgckytsFZOeEthKaO
    9O1WpoYhDmsr5OQVw>
X-ME-Received: <xmr:nMiTZ7LDFOa7lagUdXGCme-EMZJGw8ituCHA2qe3RBf4lBckfubDDpZjR4qOzl8WTF-39BUh5yAsjaK3Uuec1BfvrBi83fJXefnz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedghedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nMiTZ_GqpKdO4UMtFghgdg_OdAsi2yS9aiKpHKjiI0thWxPbp78ABw>
    <xmx:nMiTZ_USISMoKtZ9Ht2Yz4TfV1u2YHqRcuzezDNtmugfxsUC2bPX0Q>
    <xmx:nMiTZ6PM3xyF8a98uhaaVmtd80bSqWcEl4DCU6tKmjS_JFk6x8iPVQ>
    <xmx:nMiTZ-0kBtBTpBAou19neZmzfDv-UD6P_ZnCeLqHEd7JaRa-El6GBw>
    <xmx:nMiTZ1yE7H9k4t0jzJGAWyCyVSoBPQmr_5ZYVVa2yptpZtYows5m3jPW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 12:06:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <CAOLa=ZSotvEPgOyU0FnZBpNwnpjhBk4-PXk5rc=cQZuToUmVDw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 24 Jan 2025 03:05:59 -0800")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
	<CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
	<xmqqldv1tpgp.fsf@gitster.g> <Z5KAUo4FeG2M1mIa@pks.im>
	<CAOLa=ZSotvEPgOyU0FnZBpNwnpjhBk4-PXk5rc=cQZuToUmVDw@mail.gmail.com>
Date: Fri, 24 Jan 2025 09:06:35 -0800
Message-ID: <xmqqa5bg16qs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:


> This seems right, just providing another set of eyes here.

Thanks for helping me out.

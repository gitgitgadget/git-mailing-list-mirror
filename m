Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACB1E1E05
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944867; cv=none; b=PwatC8LyPT24VbQHix4YW/9xRfRmUThMGpbeCrrcC6hqsVl3MRLcItTe5F5QfJulUtJifxZ2K7p6pollKbEHiveby33mGy7/H0L74eNWXIttGQUrJTv8DdIqMxia+/2JvILhFV2k7PQfIvnE3e2TR4LmAJGswFSaXc46P1YGh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944867; c=relaxed/simple;
	bh=qqoH7xrrM8rmyDNH/ZMYkRY/A/0KEXh3dNP9xID+mtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzLL0ajY9sVcwfAFwcs3SaFGxbTJttV5I/6yvrhc+IVjWidPaXl1f90oCxsNHrNIAUwg1v/VdAnQPkn44Sv6IfF5NNwgdaGx7ujZShPdqSE8G5A3FeDLip+cKIgljyLPlsYPZSwwMF/alaJOb7ULOqxWedHs3Kqtk93n2nkiR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KwCRQQQ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BdY5b9Ys; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KwCRQQQ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BdY5b9Ys"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3740D114022D;
	Tue, 25 Mar 2025 19:21:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 25 Mar 2025 19:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742944863; x=1743031263; bh=EvU1gZA0Hi
	/nM8hBj7tOTwe6M5+0C6Z89R2Pl05jPPI=; b=KwCRQQQ5UvwvIvud+8AvdgRyvk
	I+2Kr9M4YqwIn+W6BZuj4JALJuTpi8Mnk/rtNeKKd0t5uQCYd4RyWicSJD70dNDR
	XUv0kQ63tA6mGBEYNtKYPQLJfnO4zSRJ9rUVD9ugMV3lrF0slp6irvr/VeEQFpaj
	Spfhf+qiEhiyilsh5oHXydZ79uwp5AG0gZSLmMJNSvkPmpLVqeledjf+S+bgKilH
	gG+yhra4hWG02lhTlN5ZA+pqxEU6xSd1KSSrbccl6DJMEazoOMeLMLTXvDXCyMfh
	5PC7ChgrdQ9yod4bYbJvL34fHxVKlivA9YiTiaJrDug4dwzgtxliHV5/veOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742944863; x=1743031263; bh=EvU1gZA0Hi/nM8hBj7tOTwe6M5+0C6Z89R2
	Pl05jPPI=; b=BdY5b9YsU+JTRyCbdjFaIT1XrP/gMazjRUfxsj//fipz5JurokU
	LI93U/4KPeWvkUERPRFu7uo1+9NQkhqon9BOqeF9W47tzhNIDptKtbJCl3RLW8OA
	zPFxAv4ayC8rSaMs7x+91nS84aMWyrdTbHhwWRFMmfNLbYeajw6bl37VbnNKO8DA
	nCCToZOOaaDO5lSy1p9ulEgi6cAf/tpzKNR32aRS2So9295gLnnG6jFlw9DchKcD
	el5WappoAXJ/pyjdauMXC/dDE48oosZmtllV5MQXlgvAVG2MJ4P8Y9DBmijsRA1K
	rtzIhSszlUzYaszK/ma8+FJIot+bLB8vjbg==
X-ME-Sender: <xms:XjrjZxX0l_KewZXaUc-j9I4vJ5DfJlz8YMFL0GmEaeO5vJw-R9pREA>
    <xme:XjrjZxnnT1Gxvo2yCHjHuP3PrNy8LqJvLe26PPtoTNktm2uPp5wXRfltPvLicseOr
    tbkUPiwUXtwz-_8xA>
X-ME-Received: <xmr:XjrjZ9YzEhk_cT8IPEZ_iNBhaj9J4ayvgoBn4iIGFWRRb1ncpNtL83CTAPWV7LpeFRuAcnAcvuLPEaO962RtT1d9Zu0JRiuZzbYru4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshgrmhesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XjrjZ0XCfalNHb0-KRvczOltDkKUGRRyLBEvngo1PrXAXsfnxVo5fw>
    <xmx:XjrjZ7l59VAkJXAZ10AIajBbXo3D81N97jcxh3kbVrhMRziC-ex03Q>
    <xmx:XjrjZxemUyl84wUbwZXmBAkX--S9SXX96SNETgoW2MRc_9mgr975BA>
    <xmx:XjrjZ1Hzp0FFW1sdVMGmZ2r25oUqn-NbKUuy963mHkyzFYcWIbHp3A>
    <xmx:XzrjZ2uwmS_p8oXOkM9GW9YhPAkF6rwZu8dvWYa1IBBfirVXo_k_LuC0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 19:21:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Sam James
 <sam@gentoo.org>
Subject: Re: [PATCH v2] meson: disable coccinelle configuration when
 building from a tarball
In-Reply-To: <20250325200920.198057-1-eschwartz@gentoo.org> (Eli Schwartz's
	message of "Tue, 25 Mar 2025 16:08:48 -0400")
References: <20250325200542.197687-1-eschwartz@gentoo.org>
	<20250325200920.198057-1-eschwartz@gentoo.org>
Date: Tue, 25 Mar 2025 16:21:01 -0700
Message-ID: <xmqqpli4lmsi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> presence indicated a desire to use it on this source tree. Instead, we
> can expand the conditional to check for both `spatch` and the `.git`
> file or directory.

Good thinking.  I very much appreciate that you allowed .git to be a
regular file, as well as a directory.

Will queue.  Thanks.

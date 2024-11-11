Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A112595
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294984; cv=none; b=c1QHxOMxjo+L8DRMkboACEr+UL6Q798mmTIWsVYB88X5LUt4Ec7oOK2hsDzi0Tcw+aTgVwijQ1Mepe77gl/d6Qqsr6CfNTkpW8ggIcF9e3a29zQbxVwyO0M4yUwrFQI6enGH4J0FQ7eayOzz6JLJ+/SD967VWmlvCjqHnXIAmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294984; c=relaxed/simple;
	bh=m840JVYMaoRan8xNBYajlDKjSN1tlj5qEl9n+4QOWyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jr2NuKNg/y1ac4nmcxyL65NmcOcqO2UZWafxtdhYvmyIx/rwCv6LSnDmYmxP0PQhYSvn6Z+8toaQdE7ASH2BMlFhNKAAfG+2BsHB95hdMnrBHXaUEHQzRUcASpsv2Hb60AjdaZjxh1DVBMu+WkN3vVe+d2n3KCuV48asDHk1TFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RUwelGFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d0PjdkiY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUwelGFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0PjdkiY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A3D851140168;
	Sun, 10 Nov 2024 22:16:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 10 Nov 2024 22:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731294981; x=1731381381; bh=57JxO7e8pL
	slANd5AJ+gN2Pf5BhdMVaRkNMtO2QfsX8=; b=RUwelGFc4ChZrjI8pIMNtR12vN
	y5HoyiCZ6nM2bPXYkXCT/bytyo/p9IVvkDqygB7UthnHxYsBI5Dn7Yr7g8YC5Wyv
	kBgDIzn+tSADk7+fhtRuSAZgNbYPVut5wvhglxjnXF2ORAeXMtSVK/FQFc7sNSl/
	7LgwIm+JaFFhFAibDDX4FriiXPUliShgnSBgNpCki2KYyy0DeQxlNXChuF892Mh/
	6WRcEnqmnzN2RK2IEZHQTszTTqgaoIMKQL4Q86+evNHRsjLS+BM/cI96XgdH6Epa
	bwM52wJ9dm6rOUDH7dR257ZlsFPfuOmFb9ZAzBCnBYTrxVgav/DIH9+Nj31w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731294981; x=1731381381; bh=57JxO7e8pLslANd5AJ+gN2Pf5BhdMVaRkNM
	tO2QfsX8=; b=d0PjdkiYzz3LLtD9Uqai8Wf3ilBR2OD2lgCOxkAJudSct7vYA5D
	iZ6gdu20WAxiSyVX+mmQMtbRxwOao/DHrErZRRGxiRBYWWsNI7WQJ/ZhRn9lCtyK
	eOi08koCVGBIESbR+KHu05H9cs+WOYhOZ1PrrJ0vAMgnQzofJPLRnTN7XddTbFVM
	nrlZuSJ7GT0ZfzbDuoPO85MqKyafXqMDLVTWdme/HA8j9+rs+jb+JTGgQZ/Lcn0N
	75XdMwVG171Aw3oVfKm69sDJ7fLtt9IALTHQgJ1yavvRsPLDZqXhQ7oFu36iaIfP
	2VE0J2+/IiSbTOnqlRaEzwH6g4nMFZz1OHg==
X-ME-Sender: <xms:BXcxZ-MWR-HRLk4QH9ZL6vyp4MXLgegZQLCFmu1Qvr2-4LzwSGcqvQ>
    <xme:BXcxZ8_MDgWa3HIjaPQ5-_MBi2TJuSXYWssijoIMvAIl_2yGFHSZREypqHj_SwoQi
    dHVKGAbRvenz7jXgA>
X-ME-Received: <xmr:BXcxZ1SGg7usPeOIe4WNtMuX-xoQWft15A2jQVV19bdYWpmRLq7OV7sEY6wLyTtSdvhfu0MG4CQq9M4Tt2DkrGZLTExhJTp_KYhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheprggshhhijhgvvghtrdhnkhhtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BXcxZ-sVA_TztBdUKa0JzsqbeaMwlOUUYklvtZzeX99jTwN6pPJSNw>
    <xmx:BXcxZ2c76eWwUOLmuPy6iXpZZZvtBU-uPdpVpwIU4hN3eEWZQazj9Q>
    <xmx:BXcxZy1xhwUEXAqcP9TW09AWfPpCJpBqHDhwJzP00hCUm0NKzS5RBA>
    <xmx:BXcxZ68vc9h_lT_Lb6wr_HhXePzhPLM9TnV_J58n4bXhPlwOXI9UgA>
    <xmx:BXcxZ-T6g-sNxJ4V1Q56asyZULQuqrryJ9SI660FXowtCeiYKwkIApNE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 22:16:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  ps@pks.im,
  sandals@crustytoothpaste.net
Subject: Re: [PATCH v6 0/2] show-index: fix uninitialized hash function
In-Reply-To: <20241109092739.14276-1-abhijeet.nkt@gmail.com> (Abhijeet Sonar's
	message of "Sat, 9 Nov 2024 14:57:37 +0530")
References: <xmqq4j4mv5o6.fsf@gitster.g>
	<20241109092739.14276-1-abhijeet.nkt@gmail.com>
Date: Mon, 11 Nov 2024 12:16:19 +0900
Message-ID: <xmqqzfm6h33w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> No, I don't think you are. However, I would like to point out that the code
> which I used as the inspiration also does thing the same way:
>
> 	test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
> 		cat >in <<-EOF &&
> 		$(git -C pack-object-stdin rev-parse one)
> 		$(git -C pack-object-stdin rev-parse two)
> 		EOF

There is a huge difference between one and two, though ;-)  If you
expect that your new thing may later have to expect more than one
line of output, the way you wrote may be easier to extend, but if
you know it won't gain any more lines to its output, output from a
single command is better written without cat around it.


Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6017A31B
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749416151; cv=none; b=JoyFSmvMBrvoek9oQx6KESXMQd/8R7xApa0wmWeZkCjjaYyvS6MUR3VZgnu74rRdBjZV+TiuhXdZu4nKzMW66oLyQTXYGHkyK1SbmLLMyMD1aC62xdoG378D7KS/yXlSuBWigojVGazW1SVfllNoJ+B8O/jc94sst4BELJ9LjWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749416151; c=relaxed/simple;
	bh=wBnwd6+gRWaObzuQyRHtI8aiUcAh7+if6Dx8wX6ev2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u1uxWo42z+SbYwP065g4Jhca8QnJwL7+gY0zlHM7ZgWa4fDAl9G+Ewjd5JAEm4RtLveHrfyuyVaYY2AnGMk6ZDDLHjm9zVBSwA4XPdlg6oVbgs84ODzKp+0TWtSljBZSnBTCozX8oiziSKbIOzi66lsjZrR3HOptbKjxKSeb6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hmohCSPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/CzTyBs; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmohCSPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/CzTyBs"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AFA4254010C;
	Sun,  8 Jun 2025 16:55:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 08 Jun 2025 16:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749416148; x=1749502548; bh=wBnwd6+gRW
	aObzuQyRHtI8aiUcAh7+if6Dx8wX6ev2g=; b=hmohCSPMF197GLB8yCe6ap6v72
	Ku97GxtKPZX0pj2LwixNSw9T/AAyDYjJuInCtoZilBx6PR2C5fGosO+rBbEwzL2c
	F/KBsk4H9/DuuCxpVn5F3walCG+MvxtwaJVxFOm3EvkuSCjegRnJ/UtfLomlOWPK
	4gCsil0J4o27qGXiRGp4tQ169I3YGFR3Y4SJBoQNRr7oAGhiQdusc/43M3OpvMiL
	zpx1tRPKr8r7hJRiluH3YlUH/Z35C3lvBZdaasKAqWRX6fLU7r2ktsRlPIQLVPNw
	RXCEnnOS1nKZBECSGm8BFTLvsaoljZQsTIwfCXya+akTMdtIdvXRHJcsUW0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749416148; x=1749502548; bh=wBnwd6+gRWaObzuQyRHtI8aiUcAh7+if6Dx
	8wX6ev2g=; b=d/CzTyBsjdlMol/KF3iCXCPrKkTJtUgoHxDVnYI0LqW3NpCGMrR
	AcpRYXPKI0X8AZB18JWOdUVbJBhvUbl1X7Iaq2E1j0o5xgOIj72McHpk+Ahgp6io
	OSDR4Di0Bn2eGHelz8JYFjNSEYpgzy1JJuY1RIHn7DwAo5JgK0T6T2hvQszTUPXI
	lgKdBuibcKBBu8M58byoLe3xalxPqtV1FpIJgxaHWBXMFPZWx0b/8Orm8z7NIWH1
	IZL3lTGMZAvPcHPZuVlDnxi4dLFfyEdOyK/M4jeVcXxl41+Gd860Xg/AOE4v8WBT
	ndwK/anrckxtMjnk1wAiDJ7JYhC6bqWW3Kg==
X-ME-Sender: <xms:0_hFaNa1Ij2f7yTv9fy7W75mTEM8RZA2pUY16_ZG4Vz3aEsUF9R9yQ>
    <xme:0_hFaEbMY7RuQZlEVhIHaj9iaFD2fHYlAqI0aidM6xNQF6xsz8NOIxhhCZEhPnu1l
    E2NBHOXTcDTGNlHzg>
X-ME-Received: <xmr:0_hFaP817XPv8Xje3aOFA6M-lNE2L5452NCIa2Xe9vNPsyfmsPiuTq-RF5wngTkq81vQc1q8gqW_dYeS76Z3_AwwDPbjaGIvXft0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0_hFaLqDeqjhFH2UmkVmtoaBl9GidB129tFNo4KEDwkfAQN1hINioQ>
    <xmx:0_hFaIr2PsYmtlq8I3aSOz5tt9aummUFGRSBiIG5ZXVbqpxIOGR5_g>
    <xmx:0_hFaBSRbW6eMDXe0l489CIR2v30hdjbHJPuAEFhKiL__IeL5kFwiQ>
    <xmx:0_hFaApPDP4NdL57QedLi4ePMZrrik_vmmr3ESViH7STF7z5jRdBfw>
    <xmx:1PhFaF5vQVRLSngLoRMLWrZUR1DvoxZ_5AiZ_yhaG7xXPr7DccaFm5mV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 16:55:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: is there a short way to merge the last commit to the
 second last one?
In-Reply-To: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 09 Jun 2025 00:00:30 +0530")
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 08 Jun 2025 13:55:46 -0700
Message-ID: <xmqq5xh6vtpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Hi all
>
> This is something I usually come across. Sometimes I make a
> mistake in a commit, and then I create a new commit with a
> correction. After that I git rebase -i and use the fixup option to
> make the fixup commit a part of the main commit.
>
> I was wondering if there is a command, like git fixup or something
> that could make this process easier? I know about git squash but I
> prefer doing fixup.

If your "After that" is "immediately after that before piling any
more commits on top of the history", then the standard answer would
be "rebase --autosquash", i.e.

 ... work work work
 $ git commit [options and arguments]
 ... oops that needs further change
 ... work more
 $ git commit -m 'fixup' [options and arguments]
 $ git rebase --autosquash HEAD~2

But if it is truly immediately after that", then

 ... work work work
 $ git commit [options and arguments]
 ... oops that needs further change
 ... work more
 $ git commit --amend [options and arguments]

would be even simpler.



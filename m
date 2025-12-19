Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EA32BF2F
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145488; cv=none; b=hD3h7CPvuNmdx9lrkFN++XenCGQWrcGrVcLqBCzlUY7xliJUC9inMkFB9c5JUqx9P0P7DT//OYPG5HMPKHTEBPZBJ4vyQHLfruRoDQjzkqGfHAY39w9u7Smkm8w/s/WST6AVOCmuUEphos7FdNf1KOlLS11dlkhon5dn7Ycn1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145488; c=relaxed/simple;
	bh=84IRWQoCstC+thpaqs1ZEs+AJYe/fHstrDrlWrYF+MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g1MwZ7T2uNBlTCaayOXX4ZsyyLHC6ul7ikOMs+M/gDQfFEmpmWK6lvVaaWVFwdXlEPdHNPRY2/3cPfmBsmWoJJ6j3Z7Ok84pjJYsb04qK53HL5SvbZrbCClhYNKk8OOWQe9UNCTkdiqjtw4KCrW5jZcXfCpQTovFDEnQpLCjByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OR1yM5G1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAplfrKl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OR1yM5G1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAplfrKl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0CA4AEC0107;
	Fri, 19 Dec 2025 06:58:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 19 Dec 2025 06:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766145485; x=1766231885; bh=nkUPMq9VP0
	E6icsnWT/pqS91JVUmxXAkPZbhp5JJ78g=; b=OR1yM5G1/QuonzEkQ/DKn2FxKH
	s+2Yx3NlBgB9yMf1SEGfLzR3FWYZFdbs9kIlFK9/kxvnlgJeXkNZDiVGcIZ3gTtI
	aAZEoHoPMejlB6A1D1WVAIw8LGC0OTM768CrZUlkIguyCbvY3uAUA7U8EOQzpjTE
	dG4R6RzM2n+aKAAR6+7M/SMPyajiub9tbRCl1Gp0E+jQrI5WJYJ7fJyZePqX9fL+
	N0ZbohG3RBcuHxB0qvHHL2I42KR1vaRMFxrtMdmODsww1J0qNKE5Dv477+Erz2Ub
	wwXBAQNiHND1oDloy9UCFp7wZYbvve5qPqSoU6pCkBvYb0bf3VLJIMPoA+/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766145485; x=1766231885; bh=nkUPMq9VP0E6icsnWT/pqS91JVUmxXAkPZb
	hp5JJ78g=; b=bAplfrKlr0ItCcZjLuZ48hJ6SAGIwZ1WfVifripayYzeLeSsv3z
	nlSC9P6dwYyUueAzRYGf063AZ5kuDtJDT4FYR9pP2GaWEyl+Uc/evQdMdeWSpZzR
	g+xxfjiweCTnWxQR2JqFq0AoRftgREJulFrPn2D2cYp4ILJEwM410o51rdI6z2Pv
	G99yknRmhvoC576cxuRaYKfBtAnVAgI6PNytp3ckkmba7qxqtfj1PQWmc0XGHj2R
	RV07lVKalCCheHK5yma3Wo45EwxmZsohftHvLxiJhhEEk1IRkTOwapj4WsdF9oSB
	yGwLPyWOSXlpkpXGupnXFuZ+T8DWXeZ/bKA==
X-ME-Sender: <xms:zD1FaQc_sHpJEljNhAsXKHrmvR1C7RMlGhw0Hb0D9ONQaAFjvXFIVQ>
    <xme:zD1FaZPgTSWZlvgXrACpkEX0CCivXAQS6exrwuY3yk188iUehukdV680SB4D205OS
    0inPCQmn42rDR9q5c7wBocEJ2APwLAcGdfDEPV-9o85ZKOUtiiDuA>
X-ME-Received: <xmr:zD1FaWi-Wsm70SDcCqliHNl7eZOyGtFqY53h3JLDONLIpd4qJfvsIjP4EDrqA5LaWQ-ebXYqSrEQ0j9UMZgxs0NvMKiKdncoqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zD1FaU2QtNNUZGSL8m0zC6JBGYGcCHs_t3SAWBVvAGEhAl9VxflQHw>
    <xmx:zD1FaYjUw9dfVKKGE8IQFiYjHzF-U5LWRGjFSDWvbh7xpDUktdsvNw>
    <xmx:zD1Facf7SfuN82rk6cMiLlQQie4c8SClff6oblYAZyP2l5LgfTx1xw>
    <xmx:zD1FaTkRFKwuTMZjmrLOxfGVIhgr1tmZZKuJ1C1nsL180ySfomenMw>
    <xmx:zT1FaaD2DMrpkeGqIdnKT08dAvyvOOWk7k0oaK_2QaG9CCbrnxO10duu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 06:58:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] diff: add --no-indicators option
In-Reply-To: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 19 Dec 2025 08:17:44
	+0000")
References: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 20:58:03 +0900
Message-ID: <xmqq8qeywuno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Add --no-indicators to replace '+', '-', and ' ' indicators in the
> left margin with spaces. Colors are preserved, allowing diffs to be
> distinguished by color alone.
>
> This is useful when copy-pasting diff output, as the indicators no
> longer need to be manually removed.

If you are cutting more than two lines, then the first column,
whether it is '+' or neutered ' ', needs to be removed.  And even if
you are cutting just one line, you'd still need to deal with the
byte in the first column, whether it is '+' or ' ', by either
cutting from the second column or removing the first column after
pasting.

Also, if your terminal emulator allows cutting from Nth column to
the right (e.g., "screen" allows this), it does not matter what the
first letter is.  You can just say "cut from the 2nd column" and you
are done.

So, I am not sure if this is something we want to support.  Are
there other people's "diff" implementations (like GNU or BSD) that
has something like that?  If not, it takes a lot more to convince
others.

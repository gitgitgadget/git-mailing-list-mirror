Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B9221544
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749662865; cv=none; b=qGtJ/jhkfAtFQBpXyDyOMZoHNAgWJu39XfuggzgKXx9rtoUbFHJ2wfkaN+kTyXVOL4yjJ1RD/wDMRKOPsabesN7tHYVanhXcxrDJcDBofLDE4WcVQbRUR2QITUgQcerQDgevsNfGvuKTNgfuLZcfdoJn+9ev1NO9rxd9bwt/CBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749662865; c=relaxed/simple;
	bh=dLCz/4UgxSmVUfoQblfJeQ0vVYYwNM9npUxsOudn0bQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uW4IzOMoQ+gMAeZ6ptOwcWqd38IcFFXtD7RFGPxN0CCKJyXaux+hnuA33tGEyK8GrsaAnPChyzArhoZN3ay9nyzuiNrdQNIFuCGTwzkAMGZYVEae9hNySAMvSVXCFSMDaiWM7H7cFJX6W8Ue8/c3pkUDhxs1abM/cCnb+zWlFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFhVEHjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJVKMSEJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFhVEHjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJVKMSEJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8025411401C6;
	Wed, 11 Jun 2025 13:27:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 13:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749662862; x=1749749262; bh=b639eUVh9z
	WDViKRisVXO/rYdHiSOQ2U6RKwzqeAzEw=; b=RFhVEHjxbleChjqvcRST1fSQgC
	78eawSiwdvUzTgJvUK2cCKDCI7iDqvXgy5u94zPWlZa6WlWOdRk5aPC08DLnPJbw
	HgYFhBKHUJdcyFph8KVsEVent83a2yOTVujMjyPMmxCQbPMwHGimOk4dZYbH/v/n
	5/tYzTEdqVrHhoKNuLEDAQE3pLBaH1S0X9mqeIK8aRG37bzsMYOGZ7uKEi4D9p4u
	qdalt1Vxv10yp0/b7dztzWSzQ1kZtOvN5U3eVrsa99clSvFmuybiXdDg+UKqSl0B
	i3UlRLvMKypSFvY0h39cfEjEhDHFSbRZEiC3Tfx+X4GsE6Ye2Ek8lHTmdzGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749662862; x=1749749262; bh=b639eUVh9zWDViKRisVXO/rYdHiSOQ2U6RK
	wzqeAzEw=; b=PJVKMSEJJ+iYQLUV5DSmfItj8FaK24PVdPYVJ/qpBX4YbR0Euy9
	N6IXuQ28TWsJfmF4P8DsHbjZcUMCcLH/xOSlMc7DFEz1x30eDUKjVaz/hIJMgf1q
	K1jJ1B1lG3trosFmj/ATw6aLIcFioRiWNfcjzuXBRcTA6hh8G+dXJc3ufRblQobC
	O/nXxGM+YS8ZnpJFNCeDYxBu02l0+5r1pMLhMbb7ttD1P74JF3coQ+Kj78paYlkb
	0ez25GLDDyV84g2GQw0RUw8ppDoJikeQwRMzQAqAIN8oueXQg/nHk4NvL6vxp/h6
	MC35wBPU7NsJb7EyeXt/rh/obj/SKG3bmwg==
X-ME-Sender: <xms:jrxJaCrpYDuZsyfEFyJyG9eA91rMyIhv_ScMI3zbOOEwucqZP3GR2g>
    <xme:jrxJaAofbQA6vvf16s0cNjzXgAKj05b_8x78P9bN7xpgZTcbhYSir4aNSwGbEHG1v
    nxQQqmGBkyq5CpNVg>
X-ME-Received: <xmr:jrxJaHOL8XjUyPKtBaVaYHIycVdSLmueh9Dcntea1aqr3HBHQg5BHahmXiiDncyspSt8LMGrUd2aBwRSZPilp66ghWVNPB3bpPDt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jrxJaB4eCQ-UH3gbiERiSebRmrpeAD0l7hnkeK7nA0Qr9G5wJXegcA>
    <xmx:jrxJaB6L3JtfDvr7lY_UnymJOKvMeFmKulGPxU9kcU0Uz9PbUH3ZoA>
    <xmx:jrxJaBjMckY_s3HSDR2mGVRgkDsrL7P-F4ZazfKViEGzgCMq22O1dw>
    <xmx:jrxJaL4H_IoAXiqNNng8JcfnXzo05m2cKiXy37in5v0PPJot3fmYww>
    <xmx:jrxJaBldkSuxf7wWKjCEgfFb12-sHIaenaJUuTfzes6RE4MpoF9hUOui>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:27:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci(coverity): fix building on Windows
In-Reply-To: <8d71bc71-3e5b-c59c-8948-c07d7b4f62ac@gmx.de> (Johannes
	Schindelin's message of "Wed, 11 Jun 2025 17:53:32 +0200 (CEST)")
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
	<c65120f25704e9725c317a62b9a1231bd19f3e25.1749650552.git.gitgitgadget@gmail.com>
	<xmqqtt4mjqz4.fsf@gitster.g>
	<8d71bc71-3e5b-c59c-8948-c07d7b4f62ac@gmx.de>
Date: Wed, 11 Jun 2025 10:27:40 -0700
Message-ID: <xmqqbjqui3xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As such, that `cygpath` call is incorrect, as it would fail on anything by
> Windows. It is also unnecessary, as I just verified in a manual run.
> Therefore I drop it from v2.

Great.  Thanks.  Will replace with v2.

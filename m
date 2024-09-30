Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908DB199EBB
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720475; cv=none; b=iGgGsgYxniDFGHwRFVUzHnnAJ9bvCpN1OzF3FIiJTHKvqb7BykdUkolSUmeiY0VLH3osAZ9hBKcAK52xVV8FN5v1ju/Rxx8xYF1/KiDUeiEYkFSxMAtNOnjzVjm8ZvbUfMatcRSDYrVkKR1A7ELLcZt2BeK5zlStjWOW3Z5RWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720475; c=relaxed/simple;
	bh=12uddjIn0ejR4wXiqrqCSUvJeyTkq+RgTaxWLtwakXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c5xdOQllnrTAJ8XFkUskmioS1hm9HsGyJALT8HF1QZPjDasVf/nt6PMrmsTT991AKvm8fDXJdZCoQ5DMrBhPtCnHmEZHTwsvT8ICfXHhb6Dc+F5w9hANMIkl8l2sLHjr19ZF9iwU9l7NUdr4kq6Z67IuHyfWy6ZAyPY158Xl8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=A5dNQHzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEiLFLoS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="A5dNQHzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEiLFLoS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A4291140298;
	Mon, 30 Sep 2024 14:21:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 14:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727720472; x=1727806872; bh=12uddjIn0e
	jR4wXiqrqCSUvJeyTkq+RgTaxWLtwakXM=; b=A5dNQHzPXXZKPsfj9CWQF/nEON
	8prg26SgLnXbiW3DaWc+zXp79YBZMWPPptGNltO+S9knsSs+2YXK/x2jaV2cQ8uL
	qFytUJOa0dVrQaOepGMe71grA5eZqUIBvsNuzt/PWz480fCtQFwKFGeH6+CwRngl
	AcaX1cinQ2Wx3nksiJA7bPPwuvpSG7Cm/J0HCGdmfhsKvxZScjaTGkgobESmLpgI
	gPIMP/ijUqpqWYG9mHTa3nyRnazLVI/piYxLu/2robO+rhqB8a4blkCgiAWPJVQb
	H475CZTEagWUuilugZngg6j2eLzUkmyLzuzwbT38WHbE2IjnFjyET3VeWi7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727720472; x=1727806872; bh=12uddjIn0ejR4wXiqrqCSUvJeyTk
	q+RgTaxWLtwakXM=; b=TEiLFLoSjU5O+zyQHBVTW2kPcRCNkTozTIAnILCiTi7L
	eAOrzFhI5FbdC298qoSXcD8Z1+8pH4Pgy61u/0x+EUNOhk8oYf7wMSYWTdNMYjNW
	es9aeMiAI4GPLn9Gc+vFAsHiy6sj4gwO4oklBZGgj/5Nf79e2mfyuc65NHVJveiQ
	Ps/Ka28x0CwKqIMMAjAR06cpUi4uBg8BCnfssquRitK0lt7+2zhbWR2PzX7tzjSl
	2nkRPxRvXm1tCZfh/Pej5z6losUD+Yn+cTrbpxKeoaHoQpudACsr2fIDsltFhG5W
	m5VRYXW3yuG5YM2ubF0UDzRXkWBTzd5NnN5kMi0Hdw==
X-ME-Sender: <xms:GOz6ZtCcurde7qpCcNZA1n5SwibIhZ_OPDI7pd2dht4M8zr4XRs90A>
    <xme:GOz6ZrjADRsn7CMfxqMpZK0gaF7eRfohsc6xr_JvoGTiLHXO_ctu6ZFzW8vvERds_
    wsQxHvymRWprOmeQw>
X-ME-Received: <xmr:GOz6Zom2ABGWVwz9um05coqD8Gu2qCXpnbaxfrO767Ctimt2OQcLwDGW8zCNtSaoPU3W7YsRZSEl-zBBsqlUMcVMdxjNXUWiF6vh1ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GOz6Znw6fDqS8MWZ1VRRJVQhldNsrRx3KI6r9785EFgUR3B9CYKu7Q>
    <xmx:GOz6ZiQTBDJWHWMuGiXXBxo_ESoocj00_I5VhhQL-str6HnI6J7W2A>
    <xmx:GOz6ZqYaBVONM68-IWVHk1G5zoSrKTHkE19l_mNM4urleyh45GiGRQ>
    <xmx:GOz6ZjQOw-aTwxdXpM56OZkT1KWy1BdxiKdPDY4C8vkMb3DALbQ1fQ>
    <xmx:GOz6Zgfv27htzP5m9BqF9coS7hMlOH8NaCvBx36KEkKi6WJZkEwCoazO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:21:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] deprecating core.preferSymlinkRefs
In-Reply-To: <ZvplBAl5DrcX-Q3u@pks.im> (Patrick Steinhardt's message of "Mon,
	30 Sep 2024 10:45:03 +0200")
References: <20240918232825.2627999-1-gitster@pobox.com>
	<ZvplBAl5DrcX-Q3u@pks.im>
Date: Mon, 30 Sep 2024 11:21:10 -0700
Message-ID: <xmqqttdx6m09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I guess you've split this out into a separate discussion by now at [1],
> right? I've already commented on that series, so I'm not going to repeat
> what I've said here :)
>
> Patrick
>
> [1]: <xmqq7cb77810.fsf@gitster.g>

Yes, it seems that we are converging on that thread that we cannot
afford to do the runtime switching thing, so when I have time to
reroll this topic, I'll see how it actually works.

Thanks.

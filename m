Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235B1FBEA2
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190792; cv=none; b=K9uKFuuwVJLuy+kef9wlQwUDLuzkxqzps+UvelbBqczyIrsU9F2VbaY7DKfJHjR4Qw3Zwz14Qo9/5PU9DutkkwdgmEZm8Wy5EJMISS3xuzqkFHJMGN63jzdRu0vqQkCU2vBatJTQtILAKCwGV6r1zUXJKsDqqv5v2WJOJM87Xt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190792; c=relaxed/simple;
	bh=QIMXtbRjx+LAtVfB2h2PtnY3YJXux4arqZzIVK96CAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=gpIEjUaD6mr7UGppeoSq4lnq2+yVCACJ+Mcju2TP42FIinyyFMg+8ydf08GzxL4C/Py0jCYCauZ8u519668xGHs/K1IwHGJYqSnEnUbGhA316lu2C+1/twHxGtZPfSiIDR6Ct4I0XxPwyYojWcrlrMdIF00umhNRBRM8l/NaR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eXNUmtKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RtHulJlZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eXNUmtKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RtHulJlZ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BEA67A016A;
	Thu, 10 Jul 2025 19:39:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 10 Jul 2025 19:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752190789;
	 x=1752277189; bh=SfbUxNe49e+Z3rttWY8cZ6iWtizzlF2IbOPpz0QLmQ4=; b=
	eXNUmtKnjF6i1gN+tH1xDZNx5y6U2PeV2g6bdqoqffv7rtAiTGSYelCPVa8hk3h8
	UdbiGLm5JUUkglcD/8YyaoblRV5Z2jOjADsqHeJj6+yfQxk1VNr5a3/v8svqYZU/
	A0F8IDipM7BTDus2hNId8cEjdmBtdmz9uBcxneXWRBNhGfu3PsVSsdMOxq7LLmId
	STqBL48rXqbMbqT1m5z7dNTrXKirURbrSHvJGXdH8kpSs1FK2oUk4HM+S3mp9xNC
	YS0aFI5zvvXMWYVqXbZRfXL+BI7+2JH1PSmJqZM+s8VRuI4gL8wyqxzY6zwIPP7O
	+J1jDJnfDkWAmd652w9SFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752190789; x=
	1752277189; bh=SfbUxNe49e+Z3rttWY8cZ6iWtizzlF2IbOPpz0QLmQ4=; b=R
	tHulJlZxQPbL6yIYbAUanRMcLG7xpkISXESPBn8PAL5ZNxUqyjWpRP38PHiQ/MgQ
	qsgKZoND1BHK1HczhwPbOKqLRxL7C4/dbbbYXjhYtAV8CV5QIaf6Al1nyL2YScpX
	jlCm2/xHcrQy+qF2cFsPlUsbWlub7dd9HVqCH9s510b8R0HnjkVI5Bfhm119OO35
	DcDFku8P+i8i53tiG4gyH0TFho/+oAK+Z+82lYwyRBI/PCsP4e+CZMWBM+x1a9Kh
	hiOwp/8hI6lZJF3dc3suwQP4vegJxlE2eo1ijeByVqEM+X9x4wJgqbFZwzju0BoY
	L7NzUwN4JqrfR24IUsF3A==
X-ME-Sender: <xms:RE9waD_XfB2HvwBRf3KDMZF7PH7wLOZHKcsmt2dO9cBDGlQTcbVFQg>
    <xme:RE9waP415_sAUbYipkTn00l2B3HW4F-KgxJ3SuAlqz6hZwjVmwB3CKAqygJxYaldz
    Xd9UfvfW8fMqTf2us4>
X-ME-Received: <xmr:RE9waC169i3pWR3QBeILxWVPWERbzSccR5WrS1serq9PJHBDe3kLpwL9fmypGYl6vvHNW2cuYoCBHUyGxcRfku9sIZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertd
    ertdejnecuhfhrohhmpedftfhushhsvghllhcujfgrnhhnvghkvghnfdcuoehrhhgrnhhn
    vghkvghnsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeutdfhgfevkedtgf
    evudelkefftddvfffhudefteeiuddvgedtlefhgfeuhfevgeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrhhgrnhhnvghkvghnsehpohgsoh
    igrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RE9waODw-JSs8Bi4fG7c1a3tSPH_noaou5eSncEZWORcXywZiB_QuQ>
    <xmx:RE9waM26fwJS9z4dupl_mSI8kzaxcV3EeA89Oj9dokggHf7UdQF8Vg>
    <xmx:RE9waAtqx6h23yaBfMLMsXnomcXLX2VR2qUjK38YvisX39o19ooaPg>
    <xmx:RE9waE4AJAToOYyWr1krxC0B30lY8ojS63WNgNBTwgkM_BHUM6Uiow>
    <xmx:RU9waGhevaWXPmbiPAewsh8rxYAjA_By77ndyjDil6cq7w2Jfl-xmWfT>
Feedback-ID: i0f414978:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 19:39:48 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 19:39:47 -0400
Message-Id: <DB8RSNI6D2D8.2OCZSLRSIFP55@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] doc: correct doc for glob pathspec
From: "Russell Hanneken" <rhanneken@pobox.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250708024507.62386-1-rhanneken@pobox.com>
 <20250708024507.62386-2-rhanneken@pobox.com> <xmqqikk3xog6.fsf@gitster.g>
In-Reply-To: <xmqqikk3xog6.fsf@gitster.g>

On Tue Jul 8, 2025 at 1:05 AM EDT, Junio C Hamano wrote:
>
> Will queue.  Thanks.

Was there something wrong with my patch? I haven't seen my change appear
in the repository.

Regards,

Russell Hanneken
rhanneken@pobox.com


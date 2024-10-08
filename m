Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D044C212F1D
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412424; cv=none; b=Ws6Kn0C2NsJVx3qsImjldDa8txHF9PYJy5jYuh+gbyKgUgc27iAnFDqAes5Gow3aZUEuZw2z/g2Ofv12XXJaMKDfrxfPIPGfTxtBZF2PIKnS1GdCHSeGPvs1C9OkjGDykr+NYtfIGCKmEmUyqxwZNnGnKfG/IIgiIILQFstuGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412424; c=relaxed/simple;
	bh=1j3LXWkp+NI+xA1zn6npyEl8+5oHT64SHR33ZMfRsDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7KH6BLn3IazbhP309phF+/s3zX8Aed26eT4AZ17UF9r5d93lcP4MF+xyUGDj/cOwEMJE/q+ypNRBRZsarYqsibF+a13TyhHMsAw4ELtbCOkKG4uX8RJifWAQr2NYsoW3jlF3uGyxAAS4UWhydNu1K3+8YlHpOZty/xL0hfvtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PspbJTZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgizrgzC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PspbJTZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgizrgzC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0707D138018A;
	Tue,  8 Oct 2024 14:33:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 08 Oct 2024 14:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728412422; x=1728498822; bh=1j3LXWkp+N
	I+xA1zn6npyEl8+5oHT64SHR33ZMfRsDA=; b=PspbJTZjD8FcONHUFW2zIAtkiL
	G1Spqt+lyemlJHrih6Vsu4NQt7iH8ZDNZ7MW+/bcA1MJVMpdalC4bx9LgmadNkt/
	z4FdP2cIYI0W3+zusP3uMd1npvMgb6n/CPgl+/V19tUqCJPGpVHmJ1YfjfifWACN
	uMBzWb3dRRha7LftOrwCaF4k5Qnk4CmJdmpuzILZsGOayAKl3JMaxI+Xf6zah7SG
	T1rYjcXjeI0rnH7SZr7G2/PrC9kwbww5O5/goN/p2jRHMzhXb2NQLdptFiehzmFk
	duXbmlhaU7b/fRZP/xm4MPmmZX1ZJB0ZjqYZESJy62ti6/omcyi+InNrbK9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728412422; x=1728498822; bh=1j3LXWkp+NI+xA1zn6npyEl8+5oH
	T64SHR33ZMfRsDA=; b=RgizrgzCHxwJ1UFZgSOKzuxYdx84Q0fgZVChupTUgH8t
	meXipODj1KDY/0mcIBdCbxig+YHsFacqOIKXP20ILq2HsT/KpHo3bVTZETYjL+x0
	Vzp0WpP2GhLEXo28ESlMSorFu0Xgk/oiyQI1hfnOt9s6YG67qftFjTDtNTeFwiFy
	+FSYsSMtd14xmkwx6o/2nEsLZhiwhJ/t0wI/UKSFDOhJ3pnQf+lybTsmiT8/Hkse
	NKbP+JY0DkIxbfOn2yIwjsmdEW3cFrfgdyzXPURcrBxDeHa6BQqqasaWoHnyg+JJ
	4lmFg9h02djb9sVgj6KEiT0plLnsc+Xn4eZqH/ExDg==
X-ME-Sender: <xms:BXsFZzbIiPVgfHkiJ6_FwvUehCRuXg6nZ78cLntDZsVwT14bK5YY4g>
    <xme:BXsFZybf2xx2PX_yoSoaDOcyQYWkD7T1wmT6c-yStDcxPQdiNlsFVPa11uF8IVK0F
    HC41ID5Xx7Nla9nkA>
X-ME-Received: <xmr:BXsFZ19_gnaBehNVrYfMSjqH3SkU9drpubzeabrQUIDnbpXB9OKYAjH5PSG-GktVOCk50__m5eqKAO_VZMH4QR7txZ1qNqnqa8pkXBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhhusghhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BXsFZ5oBd8YDrqny9IulJ8u0C709CzwTppFqat2CNdeFfvthENVOlg>
    <xmx:BXsFZ-rOV66iQ877QXDSxQXRQq_B__I5GZ1HycBoCVWZJZ6_LAiS9g>
    <xmx:BXsFZ_Tx50v2kkSEfNtSVlKrjdWIB00O4eZcPzEYn_q7hpW09UaAoA>
    <xmx:BXsFZ2rOsMyN3w1wAkSG1h-59dcuv5PyFVHPyOl5vvwFEvMODo6WFw>
    <xmx:BXsFZ3kAQjMJYwWblOraP-4wrXYSPJrJtetXrV9-VaBKZ3dlRAYv7Mml>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 14:33:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance start`
In-Reply-To: <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 8 Oct 2024 14:15:53 +0200")
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
	<976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
Date: Tue, 08 Oct 2024 11:33:40 -0700
Message-ID: <xmqqbjzu1m2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So why didn't we catch this trivial regression? The reason is that our
> tests always set up the "GIT_TEST_MAINT_SCHEDULER" environment variable
> via "t/test-lib.sh", which allows us to override the scheduler command
> with a custom one so that we don't accidentally modify the developer's
> system. But the faulty code where we don't set the `out` parameter will
> only get hit in case that environment variable is _not_ set, which is
> never the case when executing our tests.
>
> Fix the regression by again unconditionally allocating the value in the
> `out` parameter, if provided. Add a test that unsets the environment
> variable to catch future regressions in this area.
>
> Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

Thanks for quickly reporting and addressing this one, both of you.

Will queue.

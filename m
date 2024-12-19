Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B2216E03
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734587774; cv=none; b=tSZGHDdlw6mqZv34C9qqXg6rTQqM1RFPgtDkdVJvzMkKhzEMdYDKIwahM/XYd43Ul+OdEUDnGtgjqI8soPDeMCKS8RfrotpnFr0VIxoVKFxZUlw2MOcyJCMOoPyDlEh48hdsieJBbLg83v8G/wZNjmfnDj/ED0OjDj7dVI04+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734587774; c=relaxed/simple;
	bh=GFWujw+6yII/Fc+jhFyH54xpkq//YvPWffXpH0H6LpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKQRe4GRUWWkNDyzWvFZcwcAyaatF8OIw2gr7jUetaC+DJ2YrWF1gUNIn02RBitv2qeimC3iJrobLn+j/lhALupK8vc9ZChPDUZ/4i/71BenVM1AsrVoj1aSULeESLfRZpu+nqSb5WY7XMx4DHZc7SEx3mSJKGvGgDXztoS3vWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t2j+NU1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dG/BFD4v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t2j+NU1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dG/BFD4v"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AFFD713800F9;
	Thu, 19 Dec 2024 00:56:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Dec 2024 00:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734587770; x=1734674170; bh=ZWXbEMuEI+
	xkYakKuWcOFbc4bZdD7Evo+hde+3WhYlM=; b=t2j+NU1gDqQNO6y+R570K7IOzQ
	shcYjzSDdyWUQPE6FxYURlERcdeBj+Fw5/tjEIaPtCSvxunqQGoWh2UDy0YSFlbw
	mbcOZN8ICAaWPWGp7faQ3+IlfOz/TUv4FYrTLf/SLIKIjPMgXQ2yG9W8mucwo+I9
	CvSVSZs5e6ePod7RtdFbv21fIvsr9f/+z4P2BiKC1r4+wNwJ2mVxhHtwYMPhdWba
	fYVoUpDFS0UrDIdEOJwCITMCnjqnpCOmKKefXZsHeUPK+yvfUOnK1tLXp4JKm4HO
	Qms5ER3E81lIdgVTowYEhN6lrPai+0mxV+KyUI+GN0QmNOU30zxK3iFZ2iHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734587770; x=1734674170; bh=ZWXbEMuEI+xkYakKuWcOFbc4bZdD7Evo+hd
	e+3WhYlM=; b=dG/BFD4vl/pzBNOwlP87aldJh0bEWY+nkPSrLtnI8vUdQPfJGv/
	+U7klVFQkiSltuEXnbUb1EkJW348BaICm9GelZk+Rh3Hrt4l4pMeR/B4OHqY+i+3
	cJhvDvejhua4XCeE7Cs1lmwcCHbykAheCc0XoFb4F+wwYYfDWAiO7LAtsgm1Ytl5
	N/HOcwf98dLPxZlNGG9LQg3J5xDAZyCiesimmwUagrgrnKc2RUSFDJGcFLu3FR7Y
	DCIjmH4ikXNlgn2soFTpwJMyp8V/8DSx3S0E9SiKDKqHvq6zW5O4syaeTNiKNl8i
	KyIcYwDhnrAt/00Klhbv+Le7OV8hWl5Omhw==
X-ME-Sender: <xms:erVjZ11bses_CKDP5Frgg_8aUP_RkkUnze2sHtfPQLfESTGfd0UQRQ>
    <xme:erVjZ8GQS9qmDAGvhgDcmWQORk0ojAXReas7iCpZw_Jt_wwBiBk4ERUzbhLTu7hD6
    Sjo-gm7KyBjnTXmNw>
X-ME-Received: <xmr:erVjZ15ghp3lSKimqzbT8YaQ4Mty_Qb8oP8w96r3PDcWYL7-7Tnb7234OJYIxGEHUdjnsGumJKHSkbcm5LlMbwFVm9v436A4Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpedtgfejffdvfefftefhgeeivdelvdegvdejueel
    heffvdeutdekffekuedvheevffenucffohhmrghinhephhhtthhpshhhohhsthgvgigrmh
    hplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhguse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:erVjZy3oVmyyp_LigkKhB4HFI3_wjw5cMDXcZMNcryy80UreTUQi4A>
    <xmx:erVjZ4ENWYGPqJgBU2UD5rNBRNs8WEDZBqrP2l1iyHmn2eQ-JyLw5g>
    <xmx:erVjZz9C3-ZiW0wortVPvAWO4xw46NR-xpvb1BIxwe4FKRegWtbkQg>
    <xmx:erVjZ1lgRQnfANvBOB7R99Dj7zUvoVB2TVcpLElsVubfZGw9ewMJxQ>
    <xmx:erVjZ0hBl9HqiRPgT5_np539Vtz9y9KrR0tt5GXBB_XX31NXyDIC7g8Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 00:56:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: M Hickford <mirth.hickford@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Fwd: [Bug] `credential fill` prints incomplete bearer credential
In-Reply-To: <Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 19 Dec 2024 02:02:21 +0000")
References: <CAGJzqs=ksKqY2M8Px3uv6ut=MBwkmpPUqp3xVzVpNMJ0YBrBww@mail.gmail.com>
	<CAGJzqsnAO_vDSYOC7ZbYUQHJ3fT10JuQ2RrC2cvY4hcPMnZ=bg@mail.gmail.com>
	<Z2N-rV4fhF3ZkGlp@tapette.crustytoothpaste.net>
Date: Wed, 18 Dec 2024 21:56:08 -0800
Message-ID: <xmqqldwcnrlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2024-12-18 at 20:42:31, M Hickford wrote:
>> Hi. Is this a bug in git version 2.47.1? Or am I using it incorrectly?
>> 
>> # erase existing example.com credentials
>> printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential reject
>> # store bearer token with expiry in far future in credential-cache
>> printf "host=example.com\nprotocol=https\nauthtype=bearer\ncredential=letmein\npassword_expiry_utc=2147483640\n"
>> | git credential-cache store
>> # try to retrieve credential
>> printf "host=example.com\nprotocol=https\n" | git -c credential.helper= -c credential.helper=cache credential fill
>> 
>> Expected output (complete credential):
>> 
>> protocol=https
>> host=example.com
>> authtype=bearer
>> credential=letmein
>> password_expiry_utc=2147483640
>> 
>> Actual output (incomplete credential, no prompt for username or password):
>> 
>> protocol=https
>> host=example.com
>> password_expiry_utc=2147483640
>
> This is expected.  Every request to a credential helper should include
> all of the capabilities that the caller supports on input, and the
> credential helper will always emit those on output.  `git credential`,
> however, will only emit the capabilities that were actually supported,
> so that general callers (including Git LFS) can determine the actual
> set of supported capabilities.
> ...

The original report did

 - run "git credential reject" to clear
 - run "git credential-cache store"!!
 - run "git credential fill" to check

which looked curious.

Am I correct to understand that if the second step is replaced with
"git credential approve" (which calls "credential-cache store"
internally), the right thing happens and necessary capabilities are
passed?

Thanks.

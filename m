Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83F19C56D
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664551; cv=none; b=bzagxJLIY3Fp42sLPj7UbjBRLn8QepQBVP4igpqhbv2IgIfksOxUf81s3CN5Q/kH1zipMulbD0RWPhGKN+9wcnn61gcwV/x1jZYnKY2nJivmmzPTvQ/qqiJ/XoIJ8bXAWWYIJpSIU4Fz/ZBPGlEUOPE93fd7prlDFkoeWo1sUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664551; c=relaxed/simple;
	bh=v+WjZNYdj0KXwMfJbY3sp1l1Vv1WVbXUZlAOSdYjzQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AUGF6sP9GztBvTu9RihJ6KNB/rDq5GdGum8H6FYDYXHRvcacfolqJFRs1nFn+KSBMnkCPb5II48ltj+P8mAvBS1cc20Qw6AweRAIB399MxDYAKervKtYA310S4fglZn+YnCPeb/c4q2dR3H39iz/EzzVwnUBqZwRlt8a/WBxMhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cAyeLIdm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPQB9H/2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cAyeLIdm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPQB9H/2"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9692911402EB;
	Fri, 11 Oct 2024 12:35:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 11 Oct 2024 12:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728664548; x=1728750948; bh=v+WjZNYdj0
	KXwMfJbY3sp1l1Vv1WVbXUZlAOSdYjzQo=; b=cAyeLIdmgpCDYZ5pBaXx7aZQYM
	t1eIbut76RVgfdhUIPK0NKqsrJLYT+YuDpcFKAp8GzjEACC6P12MgIffyWnLGqw+
	CmicFiMo143DuzVaFo5BpD7w+C44/7GtkknSmfTN/NcYeUP07K8+mp4IvyLISFeW
	6lqoKWLDtgjyMzHtoqRT9i9bD8h42h3FNsb35Ysdvatd9AQjOxzrwrINeeVMG7Y5
	P9j8AlYVYtBWs2JJyINCWCuBkQonAcmwyFAHZFFzOUXLUt9T+5f6uqvyfp2og3IN
	QiwnzorA3D+PEZ3eHdK7PBfLsWTCdJL74RgVN+ukWxjdurlsSUCP/o2/GYSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728664548; x=1728750948; bh=v+WjZNYdj0KXwMfJbY3sp1l1Vv1W
	VbXUZlAOSdYjzQo=; b=JPQB9H/2MzEkY2vs31Cldf6keL+8fzyLf91TmUq6aGzI
	YvrLDtbZ+/qNbOxDEVXlbqexJxkVOSDd1pBCBL0K76kEow9W95HvTgCO2yTVGTXD
	nJrbW/ULftUxOekizxDQ7/Px60mt5infuSmvWmHwYkkgf77YtNELmPDRZEnXThKl
	o73lGHPfuS+azJVJ5WUN6q6P6R4en137A/ieqGRdr9BKDffc47uesJmF2S5Ey6SF
	j2kIjeH5uAy2IBVoX1Uk86CNBvc3NyzYpNxMpft7QrhA1aaUoaoubd1QkttjYlKC
	lcuPyXy0IiTvSnyHic9D8z7lubXZYS2lDn4ES2KV/w==
X-ME-Sender: <xms:5FMJZ_PFIxuXLCQXEsq2Dd7LxyBA7FqwwkAjz5y_73HlxRgvMTWiew>
    <xme:5FMJZ5-2DTDFVIFduuSRuApTVPRrze4Sqs6s_QQBFKGjenR_HBbC4s1K5aWN7gf6w
    0gsSdZyktflNZBmmg>
X-ME-Received: <xmr:5FMJZ-Tz3ftfihly2qDSWOCx5eAT7aGmWzQEKZi7oe-GDcIKRjlwDHsbeoO1vjHxj0tmDYVtJx39USGQHGMMrOJsj2trP6YBtTPk4SU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehoshifrghlugdrsg
    huugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepshhtvggrughmohhnsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghrihgtrdhsvghsthgvrhhhvghnnhesgieguddqughsvggtrdgu
    vgdprhgtphhtthhopehjrghrlhhosgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5FMJZzscs3khbblPMjnOG7v-VNFkRNr0_BESHz0K2cso8vfkoPdqlQ>
    <xmx:5FMJZ3fLRyneGh3xlL9sVcy0MFA2oFbykehSqLAItQ1oEZkfPOe4Pw>
    <xmx:5FMJZ_0n-ViCPymweAQB1nlG6zO1Ri5gvWZPYmasriXSUIZX7Yrrjg>
    <xmx:5FMJZz_m3HEFgmBIDNaqs_lDPw4_JoB0DatfkCSh5vG64Fk51U9uDw>
    <xmx:5FMJZ_SNKqlM-N2a-WO0tGfR-3GzZWycM27PErjrpjfVBxzvv9NE4WC3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:35:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  eric.sesterhenn@x41-dsec.de,  jarlob@gmail.com
Subject: Re: [PATCH 1/3] fuzz: port fuzz-credential-from-url-gently from
 OSS-Fuzz
In-Reply-To: <ZwjsK-uprX0eUAl5@ugly> (Oswald Buddenhagen's message of "Fri, 11
	Oct 2024 11:13:15 +0200")
References: <cover.1728594659.git.steadmon@google.com>
	<625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
	<ZwjsK-uprX0eUAl5@ugly>
Date: Fri, 11 Oct 2024 09:35:47 -0700
Message-ID: <xmqqjzeeha1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> just some nits:
>
> On Thu, Oct 10, 2024 at 02:11:53PM -0700, Josh Steadmon wrote:
>>+++ b/ci/run-build-and-minimal-fuzzers.sh
>>+fuzzers="
>>+commit-graph \
>>...
>>+pack-idx \
>>+"
> the trailing space-backslashes can be left out, which would make the
> code less noisy. then the variable would contain linebreaks instead of
> spaces, which the for loop would be just fine with (as $IFS contains
> LF).

Perfect.

Thanks.

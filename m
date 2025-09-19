Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F378027932F
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309021; cv=none; b=YTVDlLwyP29AfqcCZXZR6N94IKcfKwJjOveWjKI3c30a5mZYeeyJQfEApXXJPFwrNMN0ivNqtedIZFbfL1w5cXcWS57f2vrm9zjIHLXPWXYndz8UcAv/RCT3WRQM7en73VPwO3h70rSvceEq0ifokKChUSEgYn/CHT9aDxFVDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309021; c=relaxed/simple;
	bh=J3gaLRQg6iBHr18XDOeDuZx4/e2WmKkecLQREJ/WZbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vz0jV/RulVDuMC2rSJaI9Duy8zHoVKL/OAJNbXg05Ar/+rWR2QcuEYrKea36A57IsnrvcFDbdcCjzh/bt4QblB68WKZjrWEgr+UbY99wzDMY+npARIuh+bw1NQM7YT9TwLbKAn5TCDkcPiH32T8vHR8a6vXulnQXpzUROvyHYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pSAHe+7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpA98dKV; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pSAHe+7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpA98dKV"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFB987A013E;
	Fri, 19 Sep 2025 15:10:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 19 Sep 2025 15:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758309018; x=1758395418; bh=0FxVIKBLjY
	2/tBbs97mYViKowH0jzhf+H8Sow6aE3Mg=; b=pSAHe+7cysHWSfcfdwgiqSyQ3J
	+rz6aKqTvxcbT5WKo8xlklXE3xGSo5Pr8DQQFMjvqBLpu2aBIKgPUAaftkZTzp/G
	XXPgH5AHxtZIARnl0xKo+9uJYg/oMxW0+FwQZMbwED0Lic+ikH6YebvfcIIIDBL1
	prK6pmce8kjZesX37AObKc/pzxSqyE1btVt7++RxWyWUWvtx+kU3ecv3+WpbIC9x
	014VTecXfRYPxPr7R1cu+SLA5aZmJyF/aNaZsWNPoL0w0cgFjj6A181y/JtpccAy
	yl6sk0WFJPD7N3FNDceLmrcgzUGFvs5HM82Uo1PjdJcbYdL5DYNJ0Er7hLqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758309018; x=1758395418; bh=0FxVIKBLjY2/tBbs97mYViKowH0jzhf+H8S
	ow6aE3Mg=; b=EpA98dKVAwN7YLdBizskkM747h8cuE5rIeRRdHh/qc32Z+sD2vX
	0O1njH7KOwm4owjMZQEP0H2LTnwl/6bKUYygcFgwRvjp7SajgMif3bnD8plvZib+
	VXyuFl+43QmkCG5k+Din5Ergi4UGxNY0v7KqaIkDEp1H0+d5c/xKjcSx7fT+hFUd
	cXX6p40cDvqRUSnnAvh8oVZLaNVYrSHK+OjQj8tPdtL7yNiE26oAnsKGLVu2ef19
	qwFbKhr7VU6juTzgIxLy4Ejfj+bhO+lHZa4kDP0npqlZnoVcXB2FxmiNY/Jf1xG3
	+ePkFFBTT3IpEzVQ24Je/DNd3Ijgjr3qCyw==
X-ME-Sender: <xms:mqrNaF1AixzWyPKsfMZE0GApVu9E2ftlO3-FADcteboR0Am9a904zw>
    <xme:mqrNaHmI7OGRlup1vXgxw7VY2IDV5m-Ds4wO46hTTjeQLoBtU1WanNjvzmG637EtF
    ZcFDWZ04xYXPWTqcQ>
X-ME-Received: <xmr:mqrNaMX7f_c0ChP_UUVeeuW-VdQV85Un6il2EK07FLhnEAnZYVHvtgdJqDU1SR90Kp5tovzdN6EUwfTlUWUl0q1EXrx4sTeBBAeETjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mqrNaNvtYoKJReixj6uJhIA89Ek-PLHkPtDU1tj-TCpNfuhAU5M3Hw>
    <xmx:mqrNaPZhspn0dC6skyE-U4-60wiY_aEt0ERi-RTLsfxkEEtvaqMg7w>
    <xmx:mqrNaMUB-K2_bTOb9selR9386PAnAHN07ciSxujKHqA-Pxv9g2HUIw>
    <xmx:mqrNaEQAPVP502H_rrsAoSiCGeqO0z_Aq9OZJcZ-_sjSXDztVv_DbQ>
    <xmx:mqrNaK4WUdhjvIElig1AYbG9nCu-xRDNo4bOGHqTU4ZuGrk9U3bXPObd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 15:10:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 5/9] docs: add documentation for loose objects
In-Reply-To: <20250919010911.649831-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 19 Sep 2025 01:09:07 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20250919010911.649831-6-sandals@crustytoothpaste.net>
Date: Fri, 19 Sep 2025 12:10:16 -0700
Message-ID: <xmqqv7le45t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We currently have no documentation for how loose objects are stored.
> Let's add some here so its easy for people to understand how they
> work.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/gitformat-loose.adoc | 49 ++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/gitformat-loose.adoc

Fails a build, unfortunately.

    ...
    LINT DOCSTYLE includes/cmd-config-section-rest.adoc
    GEN lint-docs-manpages
    LINT DOCSTYLE includes/cmd-config-section-all.adoc
tmp-meson-diff/meson.adoc tmp-meson-diff/actual.adoc differ: char 3297, line 176
Meson man pages differ from actual man pages:
--- tmp-meson-diff/meson.adoc   2025-09-19 12:04:55.145229743 -0700
+++ tmp-meson-diff/actual.adoc  2025-09-19 12:04:55.149229734 -0700
@@ -173,6 +173,7 @@
 gitformat-chunk.adoc
 gitformat-commit-graph.adoc
 gitformat-index.adoc
+gitformat-loose.adoc
 gitformat-pack.adoc
 gitformat-signature.adoc
 gitglossary.adoc

Thanks.

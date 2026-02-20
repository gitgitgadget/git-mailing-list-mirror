Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85334E744
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602837; cv=none; b=erk7+38p3m2w9rXGZtc3zBm6zwrjAOWI8OKPBMA+yi/Vhg37FSi4tmc+lQ2IUZ+8NDTHgr8Ch/Gzf9G1Cs8HeDCdgy07foAkwByzWEA6cBOQHe26G7o2kKytxdlHEV0q3UT5J8NfCIVSnuNjUc52EL+ukhyJtxS5AMGZSMTANPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602837; c=relaxed/simple;
	bh=pZtg+sospNI4Jez7mNjL+CRwsTJXluNXnnsoo5ZHjs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pU2jSugF8RKmCuhA2Yo88PlC9A4OTNAtfkWbkc+7JoQoZobMf6Xii8E0cZ0mvYHIwMZ+axGcC3Ns3+TUmiqh/1ISUKnDq4U7+/w4DGlQK6P6QbplPbSCDj5uHL3JWsbDFzVlst7frT6C4mf9O45lsdos1Zz0lWzcqz/TBTgZpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GUwUeiyF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqufpzbC; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GUwUeiyF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqufpzbC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B953140002D;
	Fri, 20 Feb 2026 10:53:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 20 Feb 2026 10:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771602835; x=1771689235; bh=kXx7HnCscp
	ca7S0H7lIiQnsuF2WAKG7iQFXN0DzCFCM=; b=GUwUeiyFsYvAE9GtHgaGCtS7Eq
	oO4nqJFJizQls8yBRNXUnHhsC8Tuu9QVNNF2c7a3WRlf7i4z6//O2H9mWCO6MIN4
	9boE/eo5RiEZFSL1mEkfroX1+tdkNxfBwm3KxRr/mzMyKxGokpmXRWuwjcXHUVYu
	QOWxnC8Ol4xHEwkwqIH6VN7+BiusrOj1OPuwJYVb9xF2h6hZalNi/6YLXZCMCbMs
	edx+BGI55ARfksqLX0by7IqoyvNgtJ/S5nYTfH9Ijvzr1rigMJDPf5Bl+HC91ypF
	yueSRLPlP5UdYVbY6/97NLgSFCSPxng5W2EireZOcy64JUf+4BWY4QIfqhsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771602835; x=1771689235; bh=kXx7HnCscpca7S0H7lIiQnsuF2WAKG7iQFX
	N0DzCFCM=; b=GqufpzbCZMnuLVZjsLFwAAXoh+H+cSlsDybsC2C2lOJAzAgLqqt
	SEWy/cO4oHvmBkx8OyPF5WBp84rb907052g67N/V6EkLa5C+jq4X/opvmQf6VQeD
	ymux7LDL6lbOouMCN4hH0GPWcu4AjFy1SsfpyORvWvlQqUXkPKZd7cKl75l/ZrpV
	4mnHggvvE+Ew8ak75WcHy79/jNp7uyd4mgjxuU4OlrqIP/iiC71D+njGYOvjWkAs
	vvOd7beDPzKkekCqUjWx6XFBoUc/eJUt7oRjPYegr3wE7DVR+ibzX+8jQGaX8DbO
	ha4Vg2KRh+2HtPzLWCXEjXXcVTLbNvuRy3A==
X-ME-Sender: <xms:koOYaWxEgHotLaFjs5wpQFIupW9cFgOfjMINcx6jUS7JykQzBRWRlw>
    <xme:koOYaZIQ0zyC4ByvG_Tn7ZdAJ13CKfOFDHuFdHSc-Ye_jPJrwkCGn4sXRRjqs-gps
    Zq8ecKwATJ7bdjzgOhqMDNaKqEjyMHyhVTObyMTsI4_zwt5WPrPUA>
X-ME-Received: <xmr:koOYaQrNawxFGTkO-AQEOTSMRHpMmaa-Su-EJZQG9_gHZs20z2LhSr51rDyRCiZDxTQT6tXegkIS8QiprYLCSW23d5rzwe2LkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhn
    shhhihhnvggtohdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmh
    hilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:koOYaYJz9lp26FvMPIVdKKTmk4szHXjk8M1_aQUkhzcF-v7o_0ZT4A>
    <xmx:koOYaVS3o5OjHlEe_f5WYfgrbqbwUmQKmYFYkSecw5aiGyVOEvG05Q>
    <xmx:koOYaXvg1tCdAY_f7PidmALueWhMpaljAOAE9jDVLCujOg58O3REuw>
    <xmx:koOYaWZeyepZWJnTgxzkVyuVDF9HkNikft5SG-mkDAhqBno_u-WEVA>
    <xmx:k4OYaQmAF1-ZIgZZjk1xUySc4Qha2C-QSTfIMQ3X_u7nmrlyFfaUQft0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 10:53:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/5] Fix tests with missing iconv(1) executable
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
	(Patrick Steinhardt's message of "Fri, 20 Feb 2026 09:25:58 +0100")
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
	<20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
Date: Fri, 20 Feb 2026 07:53:52 -0800
Message-ID: <xmqqa4x31kdr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v4:
>   - Use `test_grep !` instead of `! test_grep`.

I missed these when I looked at the previous round.  Thanks for
catching and fixing them.

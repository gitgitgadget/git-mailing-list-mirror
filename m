Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C613433D9
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738626831; cv=none; b=k9cGYzBAXj06DPhy+Php8d1FY44GE5bvBW5C0IAc8nrUf4ZiM/pvulLLwh0cmT833mYST1q72lvUWFUS8nav6JjN5WqXOi5zsAg3bIzYgUbSg8vv0snGeX4Ax5Hea5c5EDwi8TK5K3CZbN6MMDv2fSKCzKa2TCUX1CwaQnKrVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738626831; c=relaxed/simple;
	bh=I0OsJf9x4MsMUVrDgPWsHySolieQbL+hONlaN6Y906o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eIEUZKwyz85rUOLVvNfDKD7MWdlNthDj0/5qH6H+smh2I1IEzEQGjqVb9G/bgPkPDir+wy0Nc28vlUa5mLWcvNJnBRJBAC7UfsL4B+mUxpAXIHnAAVV8YA2ky8cHkTQC30b7/oRFHtXHv6QJdmpvNByjO3nS9OePbExV0LrpUaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L6Xs2vJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V7oao4Jt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L6Xs2vJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V7oao4Jt"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 54563254014E;
	Mon,  3 Feb 2025 18:53:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 18:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738626828; x=1738713228; bh=ShaMnLf/Mg
	M3bqGTvz0pTsv2ZxZy9p1uompNHB1KoFY=; b=L6Xs2vJlxeBAtM7TOTZMe5ysd6
	v0auKfXFoSTizz0qPnTA4xxv6mzo/q/8YptXp147bLyXw+EsvcadbI9Q/5lB+jvG
	eP7l5ypthF9TctcUlDIEsuPseOxZRIDAepaU+VOW7RHk5XGqyLCARPM0DGqhUAuA
	ve49KgPKzs8gxBSQv2hUiF+Q9xtgZ7CaEt9a0FqavVEQ7hcoTeDiXp+kmwu8Sfh9
	mKfpGpm2zOk4Zqr2rxViWTkkXoY0nEP3EH9Iw4XeNQh1q1neFEm8MtUTZQDFtgeZ
	YaCePG3mrlx3Ot2P2tkrF5vTDs7TZyZkMNS6pckRYG/qoEV9BunRRcBaJZHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738626828; x=1738713228; bh=ShaMnLf/MgM3bqGTvz0pTsv2ZxZy9p1uomp
	NHB1KoFY=; b=V7oao4JtNcxmiAI+45Isf5hSRNk0wpYWdrnOqMswCf2RjGKPRRi
	otAYMXEfYhN9JOhgoFdQJG8fgDGeZOVglvRBrQTdRR85y2f8DH3LZeTuLFQXaNCb
	8FUuzXws99pU929IeKJNzC6yPR8+9M0wXGqNX9z3jwG3q/3RPiIvUqa0Os1VjkJ1
	YWhsmUWfA2fZkcxpAR2txecp/b2q/Fl7pB4btGhZL4R65Oi8hpKudST6qrwGUbZF
	GRIoVRts3R9HIRzMncxIFxp1L1b7DJWw6RJYP2XY1TyApvInif/eomhba5T1ikC5
	CUBDFwu2uwqvA/JPoWkxOjGBoTyW2KI6tVQ==
X-ME-Sender: <xms:C1ehZ4nlrrHuL8vwLxHK_q0vCPFIhiNTrfWHDGh1AvhIQ_8qa_-USw>
    <xme:C1ehZ33t8nk3I6zpM4OnDqRLdCAwOxrKkDxTEXNZCmeQ-UZpCKIhErAkhHkqVYIvA
    MCdEgkStBQY33iT3A>
X-ME-Received: <xmr:C1ehZ2rEaXp1SUqaslL_E-T8RMVYqNnjuEDQbRQQL2rk_65w9p4x-Vzkai5wgvu4grCIE-Cf8Tg-akBLsm0IpSDED4lp8f3I_xu1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:C1ehZ0lJG2hJ9XJFNUxcGgJD29GpXr52VudVBUW1iYu2xcnEt21QtQ>
    <xmx:C1ehZ22OBfGdxchwLhJBVv-fCLWHGfTh6AQqZd7XRkfTJTBs8KX81A>
    <xmx:C1ehZ7sutvC4a7pkwLf4ZqRBb93MsiOR_ZKBMiBahbfyU-K1UdyHeA>
    <xmx:C1ehZyV5j9wWfkY0X2WjrX7hlUUGQn2_wyto5Lov824etLAxMMGvlg>
    <xmx:DFehZ5QnB13Hhxs849dTVFYX5Jn1Urp8LoygeAxMSGkFLuOvq5zF6gEb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 18:53:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
In-Reply-To: <20250203183224.GA4183065@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 3 Feb 2025 13:32:24 -0500")
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
	<20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
	<20250203183224.GA4183065@coredump.intra.peff.net>
Date: Mon, 03 Feb 2025 15:53:46 -0800
Message-ID: <xmqqcyfyzit1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Feb 03, 2025 at 02:06:54PM +0100, Patrick Steinhardt wrote:
>
>> We don't have any tests for `git repack --keep-unreachable`. Add three
>> tests that exercise its behaviour with different packed states for the
>> unreachable object.
>
> There are a few in t7701. It's spelled "-k" there, so a grep for
> "--keep-unreachable" would not find them.

Ahh, good eyes.  Thanks.

>
>> +test_expect_success '--keep-unreachable appends unreachable packed objects to new pack' '
>> [...]
>> +test_expect_success '--keep-unreachable packs unreachable loose object with existing packs' '
>
> I think these match the two that are in t7701.

Doubly thanks.

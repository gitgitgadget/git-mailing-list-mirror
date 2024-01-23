Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D95916A
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969882; cv=none; b=OPWlF6gq1B1uQI6x00yCoZO2vis04l0Aoe+0trPJX2soviBAi6rjDNiZ+R/745Jtg2Udn4AMFdvRGRrZDCOvgdrwpq2z3dFlwZGfdt4TharY4YbUfnmQyQVTlQQOD7fKGpmcmC2l5Lbr7BHxtU4Rwz16z+FjmzKmbU3vETndEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969882; c=relaxed/simple;
	bh=R1CGU7Vu/zXd1/Egk1PiGDPrI7AZFttCvrk9zesQgrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lxc8suSqcme45+RGaXqixHuwXvEuJFbXVOFHQSN8g51ZmCmJglUyyRjTRrCLMhmT3Mw5GFLdrJOHHH6vsO1OGCS3OGlzBd6gem14paWvt4ZJzaKoW/uJAsAsv8I4tQ/pnIE/iTVm9wpsrdMFln0cgK1Iol9HyiJ2j6zIT4gQA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MnDe1B4t; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MnDe1B4t"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 018B52C7AE;
	Mon, 22 Jan 2024 19:31:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R1CGU7Vu/zXd1/Egk1PiGDPrI7AZFttCvrk9ze
	sQgrU=; b=MnDe1B4tS9DSxHCVQ8WOhSn2geD1ws5HcK+uUvV6kiv3DnZ3XQCzH1
	VtLppAoZFxK2B/0ELbRVU9cgn8nft58p8p0fMBqOZbEQ2xj2xNx0qffcKoiu26cL
	9Hu4temiBcZZg58gQ20x2jZ79/meioDz5vGFUXB0bmXO+Z+pwH7vw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ED4BD2C7AD;
	Mon, 22 Jan 2024 19:31:19 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 84F9B2C7AA;
	Mon, 22 Jan 2024 19:31:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: "Randall S. Becker" <rsbecker@nexbridge.com>,  Taylor Blau
 <me@ttaylorr.com>,  Dragan Simic <dsimic@manjaro.org>,  Git List
 <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Defining a platform support policy
In-Reply-To: <CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 22 Jan 2024 15:17:50 -0800")
References: <ZZ77NQkSuiRxRDwt@nand.local>
	<b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
	<xmqqjzog96uh.fsf@gitster.g>
	<006b01da4412$96c6c500$c4544f00$@nexbridge.com>
	<ZZ8ZlX6bf+hjmhN+@nand.local>
	<007c01da4420$10a7b700$31f72500$@nexbridge.com>
	<CAJoAoZnHGTFhfR6e6r=GMSfVbSNgLoHF-opaWYLbHppiuzi+Rg@mail.gmail.com>
Date: Mon, 22 Jan 2024 16:31:14 -0800
Message-ID: <xmqqil3kriul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B867D688-B986-11EE-A699-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Emily Shaffer <nasamuffin@google.com> writes:

> But, Randall's remarks bring up something pretty compelling: I don't
> think Git has a clearly defined platform support policy. As far as I
> can tell, the support policy now is "if you run `make test` on it and
> breaks, and you let us know, we'll try to fix it"

I doubt this part.  If there is somebody motivated enough among us
who has access to such a platform, then that person may try to fix
it and if the fix is not too ugly, I may accept such a patch as the
upstream maintainer.  So your "you let us know we'll try" does not
reflect reality at all.  The major platforms luckily have such
motivated somebody almost always available for them.  Niche ones,
perhaps not.

> ..., but nowhere do I see "how to know if your platform is
> supported" or even "here are platforms we have heard Git works OK on".

Yup.  Patches, with commitments to keep such lists up-to-date, are
very much welcome.

Thanks.

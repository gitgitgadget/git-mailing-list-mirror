Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D9618FC80
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496961; cv=pass; b=a0nqeJ2MZl/7liWcks7Zplu1zGwD8twQY88XrHgeGmmwxDuDuUy1AFn0pYwdp0YxHmw+OPvwx20kQAtTUYmg1XBF121maYfrcBeDbCuFcz515EztUNAgUwKlHu0KY6fxf7szJ0M3eIukAuXAOknD/hV3RVYs2cDHExmkvNKWDU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496961; c=relaxed/simple;
	bh=AXfwTDhfxHQ3PJdaZaNW4pOb6jmjHSREIOZOL7EnNq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sdJ8okn8DEbc03nCoqT1GLuR9NCeqAhQ18MI3+MKhr+jdetVjSBtpYcYxT4tQJqssDb89/oYGruIO19MDw5lT08WF5FEDDPNNLBjFGTPu0gIpEO+/kLHgACO2GtyWfOVANoGiECgGtW6cLf/qro2nPbPGnLSQEh7mB9EfBE3KeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fgHYREq7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fgHYREq7"
ARC-Seal: i=1; a=rsa-sha256; t=1766496943; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bY17tmdTTHcqGEkSTspf6379HoSyKZpCvuJYwiAkeFEpsPIbOQmpYnuMh+KPffQ8XZ2vcqyKkQd+GEsW08yLrrnkVG9eVz/pRtb6cp6VU89hPNygtMwkacJN2bQmyzAA437ulRvlkUDdqRxQSPD4i2BP93t8s+WiVGL1+8Kv9Iw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766496943; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZyhBkbKFKvUFQ6L3qZiVJe/mAm/CVPdsF2MrBP9gamQ=; 
	b=QGCrX/VBKtE2X++8OMpZVhpHYCAVecaIK4INrY7+B8WkucixR08TwYP1XYgH8ZAkIIGqT6D0db3OgAhK1QVJhgJnGSNlat0bLwwr+KE30Hp/suWZ0joUR6gPO5qHw+muz/zq1k8DuKpjvHxXI695JUy6u9Sr76Vc/70q+Q6BtBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766496943;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ZyhBkbKFKvUFQ6L3qZiVJe/mAm/CVPdsF2MrBP9gamQ=;
	b=fgHYREq7B6D7i3JCcaoc/8FYkNLbq0ddnQ8+oZLRCRji2ssdTYKjSiZH2TUWGkj6
	Q9huFWnCiGx7oC4WIWPz6U70DoX5mBYm/Vkfq/Ou0y42KRIToApkrn+0dMHSqasK4kw
	pD78sHesGe9HzXmdMWMJ28KGEaU602HDTM3I2+4A=
Received: by mx.zohomail.com with SMTPS id 1766496940769436.5783100806585;
	Tue, 23 Dec 2025 05:35:40 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 04/11] submodule: introduce
 extensions.submodulePathConfig
In-Reply-To: <xmqqy0mwsedz.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-5-adrian.ratiu@collabora.com>
 <xmqqy0mwsedz.fsf@gitster.g>
Date: Tue, 23 Dec 2025 15:35:35 +0200
Message-ID: <87y0mtwcbc.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Sun, 21 Dec 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
> This comment is not about the primary contents of this series, but
> I notice that the whitespace immediately after "errors like" is not
> a SP but a HT here.
>
>> +* Encounter errors like	`refusing to create ... in another submodule's git dir`
>    123456701234567012345670
>
> I have already alluded to it as a #leftoverbit in a different topic,
> but we probably want to have a new whitespace error class to detect
> a HT in the middle of a sentence that should have been a SP.
>
> Perhaps the rule would be something like a HT that is at the column
> that is at (tab-width - 1) modulo tab-width (default 8, but the
> usual attribute applies), that is surrounded by non-whitespace
> characters on both sides.
>
> I may be counting off-by-one, though ;-) The quoted problematic line
> has, labeling the leftmost column as 1, the HT at the 24th column.
>
>  cf. https://lore.kernel.org/git/xmqq5xa76z0o.fsf@gitster.g/

I think the algorithm you pointed out is sound, seems to work, so I sent
a separate patch for it:

https://public-inbox.org/git/20251223132756.604036-1-adrian.ratiu@collabora.com/T/#u

Will fix the whitespace in this series on the next re-roll.

Thanks!

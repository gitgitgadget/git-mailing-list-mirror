Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3333ADB9
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686310; cv=none; b=jdwBAoNQd43lq5UwLuq39cX2+No2KBLY7oVPCYNIAycVL2Bgap+SnWWXHe+A9RQGn073FghhYMYu6FwaFkJ8cDe8pOOrRtp3zfjDm+iBfOyTL779iKquT0T71G0+bcEdxkWeIutr0WP7bfjle64bYyHxDyp5QoiTIXhZ3nTK1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686310; c=relaxed/simple;
	bh=lkkVh0K52nU1gnvoOQqy/DawDuIWNkhncabwQYdX+9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=px9owu5guQAapY/hsD+GJG+eauLKUBWUOBEAzn6PPp8eJDYW1I/7ajzORV56QcYqXYz48OBAT8lHRSmWUh2fj1kGjvuGdJuP0vdBsKaohYFSRcuJPdzioHoEQJXbvL+vcz7TgqK0oBMAx32O5FjwlyG7681/i/FIkX0e6dHDnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YbHVj4Hp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVGyKuvF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YbHVj4Hp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVGyKuvF"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id B388AEC01CC;
	Tue, 25 Aug 2026 15:31:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 25 Aug 2026 15:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787686307; x=1787772707; bh=HO81a59/u+
	7lL6tnlF29RdIVeE98D2/emDp3lyycKaQ=; b=YbHVj4Hp2IXQ1A4uyV0zeuc15h
	4RlitUyUUyccmnMglVIan8kFVJ/EUAciW3HyputwjpRgZCXG2J9YLNu8EHHo55Ks
	l7PKjH+k/4WO8dayKEp8EjC1/qHdba9RJSdNdbLAIV8d6FkQRHCeWk3B4sRxm/Aw
	zf15bTbPCCvTXqbEVclpBOnFts8s/6N/jG6q6MhrqhpSpP7Z8NC/PeQdw8OFGxb0
	J/Nc1qCoEQWFiQccEpsLwPHTR5rgtyIg16CGUhOqqMNpEjX78OYiqdhhFJD/H3G9
	i1tOn/Z/uT8vXxjpeWk+8j4G0CV5Qq75MCvcpLLlsEX8rOVLu6MKUy2g3UWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787686307; x=1787772707; bh=HO81a59/u+7lL6tnlF29RdIVeE98D2/emDp
	3lyycKaQ=; b=bVGyKuvFaEkbBUrN5oorZRi9iSRq23WLWcI4teSn4ebm4eFevLa
	NklUbqzuJutNE8+l8KolS4CJxlH3l6DeG3+/NKJhKE6LpzmehkZWM/HkVXHTTHwQ
	7+wJpPcKmwcBfrmOvKd+DKK9NUFg8mclQRJpCl+y0F3bgiAiXd59Rw8H7Qwk0I4j
	0H3MerNArX2l1IwGj/xr5RJhW9LFPwsHPm4f1uMKPWlW59MLWszK+mF3uKW5iJQd
	sKY8GW5xVPA2N4yJh53YGKZJgHkn0+cKCULHRgSjXhh1i+/FvSeeR97HMEPaTgqO
	vefPh7MTAHkZqZ2sGBDI/k9kjSVbos/ZkeQ==
X-ME-Sender: <xms:o-2Nag1AKKzAevO-X31wOPjVqFMmg2a9sA4TxJpm7lJKMgV49krB6w>
    <xme:o-2NammGvWtk5E1yaukkOCDUlt8EiiFOJv9gVCkVFC-kqECb1ZF_HRRwoLLEVPaWT
    _tobe3ltsYjB5KxQlCxXXz9_Y3--nLm9bwKpkFwooO_phzyvYLFKA>
X-ME-Received: <xmr:o-2NavW64aKfceyUPtMsk5Grl62_T-1-tN_ABapyJEBO0JB1WWF1_xPIMGlTnpVbYqW-XV917i_XUCBUqBfkpBChjeFDwXiJlA>
X-ME-Proxy-Cause: dmFkZTFQ1Uy6sZX0czBCS5P1F/NPrsEBPt1t/drdJxD2fxSKFS/KeGvBPh8szXeEUf8qeh
    PXFSgAH3UlOnE/6wKvN27VVjEYmRALWrDmPmM0JnctheWamVwnRzLzubxeJb8xabor3NXx
    GH2dkgU3brO4DW93+w9jnjdhf0nRvHivbtAtdcKrMwU8+xzAJu8zz37MaU8+7Ghmpuyw5K
    6UW7EkAvsK6EC4BFPlpNo/thj39q6Iu6Ht2kDHEnvcRdeBXltdozN0mFXnuYba3jmqzmrE
    SylDGaZIcrSCpDWYV35HQYJw4c5V3s1Nx+SEQbMzXGzRGGfrcNd7w34NQm0DBEMkbh6xMZ
    Lj68KdckxOohmiy6wGAcIX21rSW4xLWT8FB4Dajcuo80Eb9sEyV2L9JEN0x+em3obuctf0
    xaoS4E687CEvJa6bc0w6Iclgw1pCOYM67xB7TpGSJzpNXpkGn3ZWnMpqDiDa/p8dX2irj0
    IJdhIWHNuL/wcbPZUAwiVjI0dpniUTb+ZFxUIFpt5ZSaQ5jEMl8rf9ihF8vfIV/h0lHN7P
    LepXhjD4XYPk+Y9Y1kmbsLXIJVT7inZeJB+b6sGlX7oqNzycHP//hCl4Km5TfCnyfXCrmf
    zD5woeio2TCsFpEZ4DrKQZcrgQAhrEfkvboSAI92SIos2BmPHCCA4guj+IJw
X-ME-Proxy: <xmx:o-2Nakt1Bi0M2e4xGWpVQg79h8bhA1aKwYLXjLs5-73S2IjFTmyGGA>
    <xmx:o-2NaqasQSiI1lgVsFNa_uvBb0fMiCCRnL4HIA1G6anazu-2CTOslg>
    <xmx:o-2NarXuVJjNVn87-JgKrdJgmQSEOXC9Tq9D8_n56sj4CUdv8PY3Rg>
    <xmx:o-2NanSC7SYAnDkd-UDxW1CMNebDoJ1rDK58g-nRnsKxhFNCEgOzoQ>
    <xmx:o-2NaoEi1b5czQG-8CPEUHTvkP6R_0Kn3JRNsUr5DGPyJRop-P5H8dLI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 15:31:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  lucasseikioshiro@gmail.com
Subject: Re: [GSoC Patch v5 7/7] repo: add path.cdup
In-Reply-To: <20260825175818.645579-8-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Tue, 25 Aug 2026 23:28:18 +0530")
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
	<20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
	<20260825175818.645579-8-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 25 Aug 2026 12:31:45 -0700
Message-ID: <xmqq7blem1y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> +static int get_path_cdup(struct repository *repo, struct strbuf *buf)
> +{
> +	const char *pfx = repo->prefix;
> +
> +	while (pfx) {
> +		pfx = strchr(pfx, '/');
> +		if (pfx) {
> +			pfx++;
> +			strbuf_addstr(buf, "../");
> +		}
> +	}
> +	return 0;
> +}

Can we have a small common helper library (e.g., repo-info.c at the
top level) shared between this code and builtin/rev-parse.c so
that we have only a single implementation of 'cdup'?

The same comment applies to all the other features that duplicate
implementations from rev-parse and elsewhere in the repo-info file.

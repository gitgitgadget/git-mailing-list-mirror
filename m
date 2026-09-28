Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F473DD86A
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628137; cv=none; b=pmQ+JWVurFTunFCEkWpJksHO2YRcf0uz0fEPn7abs8yWT2p5A+186PXfELugQvoblbJf6cp028bp2OxdJYrRcD8HAXjD14L6j3A7E+rNI1BZ11p5GRa83H1Uqs93L+3zoXzAvwUCnZBv1r0USf3TZmwjSdjb4kwzE4GBxTua7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628137; c=relaxed/simple;
	bh=iuvaU63Uvt4Sgtu3D2al34CzyWy7NJR8vs7hK/WmZiY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ClYpBMz4OwP9myXFPVR+fT8fRip7gL0jVfCI+w1nv+C2hMnf1obE/W0Ap61CcYq0NbYWyeIuMTv2J0WNanjkpO10QvQqJtqpfCQ55cH1EjMNahD6DU43ExSkOSgoCZ1HcNp3kAJO6KKbhm82m0vGXAfPHgnNBHH4MFAxpO1ZQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=QR4I7aYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P9YrTfI1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="QR4I7aYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P9YrTfI1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DAA851D000E5;
	Mon, 28 Sep 2026 16:42:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 16:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790628134;
	 x=1790714534; bh=iuvaU63Uvt4Sgtu3D2al34CzyWy7NJR8vs7hK/WmZiY=; b=
	QR4I7aYacsGhiJ2v3t8vr1NGnUHXfO7MbhXbClN3eDrow+eCnoU51Rnmb51TEORl
	qy9qc/lTl8fRM1W39+kDvTg7/cng/ViEriB25c076Ccbtvc03nDwqbiSUSj6Y5IY
	wK4ULzTiq22xj8r55uhjLHMrD21ij2fo+Ip3b/lTeuN+3t5W1PtDY0cOkXEAIVPO
	ALi4UgEkdhHGmIkoomoSTaWi7kSIL0hEHVJF2iMNcRfLb/VRFnqDEz6FS1bCn4yn
	fPM/NR2jlN2bUqn3SZCx3eI3YWs6QX5d3aDQhI19qezODOcCFZhhd93MWD00EXJw
	NLwFOcDt9QUzsH4tQyxeiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790628134; x=
	1790714534; bh=iuvaU63Uvt4Sgtu3D2al34CzyWy7NJR8vs7hK/WmZiY=; b=P
	9YrTfI1kQcrEBWle0A/JGqsJ9HWpPrPbU6pUhPZCF9weoLf26y5ZhIE5ck9yoRoC
	54XUqNZj2I96MquuXd/g4rUqAhSZziDP3WDGngkb9/7d7f6OgbkySG87OC1RX2Lx
	WMqAT1eASQ3IHkY85VYduGEyS7jYdclvhcY4biHTAmThkVp1MWow5hSqQ1NzNXiR
	0TPxmn1sxbigaq0tXlWR2UR19ULwmmBCvzrxm5kKhJLJNfVMU1sPMs4RsYYKuIsy
	MWH1SV7jXMVXmJGV+W/EA2NT5+FbRmG9XMfm0yqPE3NVf4UzS5WLVK+2oNLfYuRE
	sgndyGQB175IPpL4zWA5w==
X-ME-Sender: <xms:JtG6ailCJKgQi4ADjWT-OXS-UIqQTrociHW7bO-3G1OsMuMBpPSm4A>
    <xme:JtG6akrVO5I8f9Y1dvbsOLn83FFe6-l4w7o_MbLzpHTH3aEzujxoHRNzhscRGbsaB
    HEnKfl-_p-pfvMxHnUVtTOrh8lD7FWyuddyAUTnzzCc8pnN4cpgPUE>
X-ME-Proxy-Cause: dmFkZTFLFE1r8LsUbXpjWjIwVSkyTmrfIpwrJedohHQWRVvUDgd0E98S0B1/a207JaqZjh
    zhht4Bv58tYYJyLDFZA5xxkw24A3OtCbNcnbBba+hwSJ+pHAnApGM/4qh2cD6SNQ5F2EhU
    om4jSTDNmHSei9JKuQ6Vj3Hp5xXj4osNgLtWhF3J4nWxK0kcVatWLar/QfLEIbSxTHl1X5
    HTM+z1p6RwqfDDN6aJnf7oaaGEZFFtLhCtTBkU1jzh7m7JWWmxLL7MOSLy3H3tYGUIHgpA
    n/c+kRRmt9sF8rBxWylXUOWjU6jZxabeOPujW3yJvnED/nPf4cdChjWrM08wfRmYmoBtS6
    FCdqwKzSwwBT5w0Ib5jX/TgqE8JPZtxjqTikdEQOQpOWy605up4HLhjizh32czi/B4eBjJ
    zTjfqE6pGmM2TqagYDJQMZyJ6i8wq7fufTLHNn3dnecnKAaHWAtD/CQur2E09fWDyFgFZd
    z1kXzOkxrH2L/rNuxPKmxggLcSOReMvjfNfPMd3uswDdw7OcWGBWnutwyJn16djO8KgWq0
    MDVG70vDiTqEOLO7gvYXtxLqsfcFRZC7acrGPp4aSPGW+6PQV9FdU+oviqGUj/V6OyWjzk
    eLYuzB3x1nvxo1N1Fwd2+Y5D7ZdnC8JVKDLmp1C9dTzwqsKw6Mc+0Lc3qGLA
X-ME-Proxy: <xmx:JtG6aqL10HNxQUbUM8ZB1iaa_UgGc0SLep4iHL_zdaaLha9i9LFP1g>
    <xmx:JtG6ajpMoX-QSEIQa_9RA42atLX_VCif38YTBU89GaMcaQVhjJD9_A>
    <xmx:JtG6aqxNtwjhdil7dBJf9jYZCtcWZSg-g0C0h2BfI7DxYpW4g8X5pg>
    <xmx:JtG6avPzYCzt4MdoJQm4tqpFMThNw0eW0qd0mrW1y-fRyCNDarPtCA>
    <xmx:JtG6aje14BHUS5UE1yEDI3h-D0tLvx5kixNFM9fCpEsQML6aHB3yrup5>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 82553780070; Mon, 28 Sep 2026 16:42:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWFTbsbb2HAJ
Date: Mon, 28 Sep 2026 16:41:54 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Patrick Steinhardt" <ps@pks.im>
Message-Id: <01f196af-3a6a-40e6-86c9-f8b4ce7bfe47@app.fastmail.com>
In-Reply-To: <20260924233726.GB765100@coredump.intra.peff.net>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <xmqq33uyz3yp.fsf@gitster.g>
 <20260924233726.GB765100@coredump.intra.peff.net>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I think that is giving us a good signal, though. The guide should be
> mentioned in command-list.txt, so that it is linked from git(1).

Thanks, will fix this (and will move the conflict-marker-size change).

Should I be trying to apply my patches to `seen` before submitting them?

- Julia

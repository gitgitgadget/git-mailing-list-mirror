Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982613BBFD0
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714859; cv=none; b=UGBt82h+9n1apN9CtQy7H3nRW0K1Kjr8vbWU1KwlTFZ15dPp/ojpE1wBBrNY6qBp57FJtr7seRwvPs2df/ohbUFEakvhzb5vf/4uOkCSxkVhLt3FGfx/w6ovG1izn+y6esqJJ36/37UV6MEVKNP+ubNR7EZmvsYq1FKzirkABJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714859; c=relaxed/simple;
	bh=hZ5CGzqNfrAZ+jYF/F017+Q6AgALmriKEthwsEqkYm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SljRjo1CfhxjKqKqi8RN/gHBhG6s2s9T3RRhFLmIwFX1QPNwZBwzaVjSyv5ON5OF6tGEn0o1CFgP6bUM5MvhNJfa3h9jyEl9lhXdRSyx4uKomcyKZCWHVIKkkGi8ivyHDR93fJtkWuEfCjm7sCDmyM0rwWzQMALvyxZx4AttTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uD9p4nyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m/meEQAn; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uD9p4nyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m/meEQAn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AC19014000F1;
	Sun,  6 Sep 2026 13:14:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 06 Sep 2026 13:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788714856; x=1788801256; bh=hZ5CGzqNfr
	AZ+jYF/F017+Q6AgALmriKEthwsEqkYm4=; b=uD9p4nyu64gD3DdRpwPpfCo9XV
	D/lXuHa4OxIDAL5jsnqFluxbfiGtL437WMKeOM0Ya+qXsQrI5QGaggRp54B8HRWQ
	mynISOPxK8EES3erQEIYEstvlJqHB/IyYVhyICdSI2WMW0gMkEZYqHKoucxyaFco
	5WWwXkC/R/5exi/C8Ro2oaW2Oip7wjmtDwazuMd4a4YvhV0RYTNAqaDn18Pbcw4R
	UgY8flGO19hii1tXN/J2ZtUjN2xtReOI6a6ovzpmvc2EIrXyO7ZBbEvkUkmVfsmX
	WNhh3PG8YCQ22CMI+KrO3N/PyiomnrMo4Uj2pqGfIvBJpv0THpn4nXMES4rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788714856; x=1788801256; bh=hZ5CGzqNfrAZ+jYF/F017+Q6AgALmriKEth
	wsEqkYm4=; b=m/meEQAnQLWsBY9n7y9UukiEBlAc2rd40gM0u5CzWWNgFkusyv6
	Na6X8a86WpMraY2LcMZ1YDcsMDhIkAHOYp85XZ56R4j3griNQu3fJg2noEhvmQ89
	bHVG90jlvFqOxv/cFgDsmCuss7T2B507ISsAnvhGsiGzSIoAFpoKaBk6z4bbUGmB
	QY6KuVXVCdZ4TNwWkmWE4it1KYKBqikZBZX4/l5+hCH2RTXmvgrlHDkYTXl3Sapi
	ryIRkQE2dVhXk8yxjXsR2wUaEBggGItStlU5QfB6T6e4prtnIpq0x9QAoqOQC320
	G2Era4FU3IRrJ0wmx580jP7QAZqhXYnAK6g==
X-ME-Sender: <xms:aJ-datTmvwnRP-cax8qRHQZ3mUckcyNQFtIk6ax1uOKTt6T5GlpL0w>
    <xme:aJ-datqmtE785yCCHeDfSz4t06e8rKSxOFg3ImDZKvulOETZNGhYMk4FvGjEfy4Ay
    PmtALKZyRPACApeOUh--8KvQAiYjMslqKQS4vYaLU2g2XtVq85QpgE>
X-ME-Received: <xmr:aJ-darJ53VAYzat4GLnFurLCklEDrr3IwbdhszBzJIiAl9iYh3APc2csn-dSP7ErS0PytmoBRZArap-Eu0pjiY7BqBWJJKho83zt>
X-ME-Proxy-Cause: dmFkZTGvqj4Lj6a1xqIILClEjrIPnjrykcPnAuvw5MRfFbiTR62/7oHqObEwfU1CZte1nI
    KuGyhEGfN9AVBWHwSVw8vB98OgrGdaoqKxPheZCmAmJ6aac/os8/7fvu34/YpFWQpbYMQk
    spOZQhb1GwF7/oBLzzBM8Oo9AwitZzVbuNYlZFtpn4GBFyQPSII6ana2avkEy/t3drXKdz
    NfDlnYZpgIVATYa8CrDg0D45SDTzH+my+7Qab087lkspsTczQJUHQRaDXTOvWKbvxURl+5
    OG2HooqLnHnNY8D7WBwo2ArxwJS5xwRL/q+BVX2mJOU6bwprAJawk5wcqV03TDRjxU3qtE
    vh7WjzMJu/AJsZWWEEqcl3sKblyEO8azoq0APzetMcm/PiRwh2SfKcqY1EwlwU+1iHHATR
    Iz/EZWZR81OHqkkz6NiB/d8fEAmhCaw5Gop0FIhdKCvqkAH2EjbXA8BDZq78XwNJvYeSyZ
    PqO1QvGOSwPeB5DOUj9f3abFu67yQXiR8dKNeKGsNHjxrmDSOWDdCXFiFFMgl9n/hOLaf8
    hW4PIAh8kwnlmd1YPZg2O6PFcJAPBlowwI9/82BpTGTDQgh3k1u3vJCx/bJEkhHkDsAI58
    x66a0OMY3xy2CA6CUhE3c7Sqg/2OcpA60q0PJ2iFsTGF1ziOEQ+xwRn25Cvw
X-ME-Proxy: <xmx:aJ-dagrnW3sj_5jLSVoF3YNCO_5VZ_0C2eyTLdBdg2NcIasbd7aUYA>
    <xmx:aJ-dajwYAvYR6FfX2KHgwHqxvhGjcPG5rcGeZO6Jctbk2ezbSs3JrQ>
    <xmx:aJ-dakOT9gMcnwa0qm8Pjgl--_NrvhiEtQTIZZmG8ji4BlJ_K30kNg>
    <xmx:aJ-dao4tSGrKKbqY6sh82SbHr8jnYM31JKeeAz0Q45y5r9qVFtNXtA>
    <xmx:aJ-das7S5YWfXGFg5KEIzz87CmZHMnodg3-g54qWQ8epnlAnPZUvaQly>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Sep 2026 13:14:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Aleksei Sviridkin" <f@lex.la>,  git@vger.kernel.org,  "Thomas Bachem"
 <mail@thomasbachem.com>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref
 has no reflog
In-Reply-To: <fdf8fa9c-1e6a-4f7c-bbe3-a0b41cdaabd4@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sun, 06 Sep 2026 11:39:29 +0200")
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
	<20260903200015.36849-1-f@lex.la> <xmqqo6ee9jtx.fsf@gitster.g>
	<20260903214551.53918-1-f@lex.la> <xmqqpkyt3qul.fsf@gitster.g>
	<20260905171343.34722-1-f@lex.la>
	<fdf8fa9c-1e6a-4f7c-bbe3-a0b41cdaabd4@app.fastmail.com>
Date: Sun, 06 Sep 2026 10:14:14 -0700
Message-ID: <xmqq8q5e480p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> By commit message volume, I would have expected the commit messages (if
> they are LLM-assisted) to read more like Jeff King log messages given
> the corpus training.

;-)

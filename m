Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C273D4123
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048342; cv=none; b=gc3lJBu/CiWySU/eTJ0FBpF2GbgND87L9VImiilQI6J9vItaNhSBcTx/VhleFQ/nOmLb0jmf1D84d+z3dYHU5zgt5sk6T40tt38iJuwI/xfr+Ev4fQmjDVTp/uVbvRaxjt09Tfy2GuG9y+FGD+amfgdxUv4mGVci2mF9LEKU9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048342; c=relaxed/simple;
	bh=GH9tEvppqRFGVPfvGOg8h32BNGnCad7vFGaYi9N7G4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dAwyJqrY2dGgpKivL2/rveAImFhMCaPS6Ko86X1YK02LsM/alm3kwLh1zTaH7syy7wejUmVGTLYqWCFoQATjY+jAvBxlZeFccf8aDr4PUnsmxmTT3jN/xwiUJSXNeqIdFoM1/k/GnKd/PvoFD6l+HNc50+19Ra1Xa4UJNwskyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDbrVMle; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyC13E7M; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDbrVMle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyC13E7M"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id C7F121D000F4;
	Thu,  6 Aug 2026 16:32:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 16:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786048340; x=1786134740; bh=0OPCeWlA77
	ZU1iyJvayXy/NMMb5PvYTY758Y/6I7mRQ=; b=QDbrVMleEHAS9Ktf32FwrFowHY
	vj0TVcSpZsTqBHHfbFQkpmJoz+4aKG1ny70rh34wv0S9MmRedgjEWKM/alUwp7/C
	cgLM7eCfCwCb1DeR8JjzVArRlCh0wkr9OxJhT02M1IjLwT0iotiLjyMVD0GAVdtV
	PyxQJoYTLGSklUZ9b+cXSR7ulKNAcRdNf+oV3ZnVZe16Ky0mvPuTmLYtNSr72Tt8
	QWwybBcfble51PMqF+7y1XSmtsHDPgsL0dfFP9hUIQLYFf14QtGFAo6nvXhhZBHG
	b8SB03e6RVArVRv7ZudgwZLICfxPJel4hS4A3bRfUVUWTjK/qrwODgur/BZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786048340; x=1786134740; bh=0OPCeWlA77ZU1iyJvayXy/NMMb5PvYTY758
	Y/6I7mRQ=; b=KyC13E7M9eHH6fiJft+eNm7QkNaU+C1CxvgmVAhB66lC+KuQALs
	Ii1dtJpwF6ED9p08VrdYQaOt3W9POzTx1thLZkJcpZMKuoORFZUvc7vvKTx4I82C
	qF5p0BF0F+bIafH+uHMSc1MiWp+lVX4qCR30UJFddomK7zJAtjCBasO9Z8R2nPd6
	x+cKMeYNQNXXeI4BpSoxTwUU/HXSk1QNwD3rRpK5TVO+4ul42NpcOwNe+g1jHwL6
	jA/iw816JDriadOBmLMmbYg5dd8RwuTLJz0+KEsuIr4I4OTywN+ZpXmBV29ktJfi
	yTdrHWilqvA8MN8rShd8bacDKlUmUS4pUSQ==
X-ME-Sender: <xms:VO90alXchocOQNaCS-epedmEYxzqBcF42o8uI9KaS4ghczbyO2yNgw>
    <xme:VO90amSca0HOVsmxLysMTCkexwUL5mnZ6vnkA4hTTSfiV2yyEUK2CXWetTksOg0IK
    y1Bjwpf-hw7yHvJmS87BDfDprzloriVvfZCsViuB1u2wEwx2W8y-w>
X-ME-Received: <xmr:VO90avlCOLVCLHCUnRqRSyhsosA4_V1qrSlSW-0Gr_J0Oz01P-cZ8OTyyzvTsWVCk5jwrJDaLe5m0C7aqKBMfNjeqceGToKEAQ>
X-ME-Proxy-Cause: dmFkZTE9boaxG1Km/ETVS7ESWfSRtCfgerH6K10agdTf/hQwxFUbEyrMliTsgqgP4on+gR
    1VwHd1mszg8bbCpY/1Xoru48NpSTgl+YvPYBz7+l09o3U40TYaXCDByhYWoTyITXcDVSQ6
    Qxvhu2NgGl3677aG2/E+fG8saDe8VRGJVK6ZlXaPLMwqnicyWo9OcDRAGpAmV1wSy5Psn+
    yoUn6IBxZ9bMXRrFN/0FOJfLRbZnuObeSAI0I0Txzpe7oOkcfDmOq2X3fKBM6B2keXk0jg
    vrj3Hjc1JCQ3ANseRRs/pU+dIeWyflT7BIoGZX1EgaJ/e79koZF5C0UWFL9vDA2eFlzGgX
    uotMGBP9Vgwncb1uOpf0JVADx+1+6sqZfZKVPXjRXdgS3q9Qq2EuGeMzF2da6itEuuMDZa
    2RhaftuX+962Q4uSbXu1STtWCNdn6zN9ZN209mBk6YtznE62HbWE9fACWadE7f6td96Q7O
    m2V4V9XB2chvnjExsOLMaT3L7PgnmlrEuLN/J2Tc9sNISjD8yDC+J9oXKisSE7uWkCso0O
    pRzqHSZYLAfPU+r/Eu+rXSoJrOr3qHtdKV655gNv9GxLBdpBBnM5sJZri4K6FAX1EJFRgp
    SK4vCoHE2F/AgRqdCaXvwn6YH0zRCMe7Ds1/3EWzEUgCg5GSkgOBlewQbQOg
X-ME-Proxy: <xmx:VO90as6Z-bJAawLH-g14e8DUqYsLBkGVReQKdpgeEu9Pqwuk933qDw>
    <xmx:VO90aljsN1bx9j_SVKbclWW7vaw9_BXAglx8b2g2TCOV-rWJPfwiIA>
    <xmx:VO90apGsr7NwuLmAlXThV7RLyax8KaTOyc9k_31tmkyguJ7MciA50A>
    <xmx:VO90arR9D7492x9JZScWsO12Q44vnCMeZ3N1cJpX-JXDs8DDG6k1OA>
    <xmx:VO90aogBbGizA3xfqvfVQOAdBiL9Y9koLBWoNfGswIOUCc8wLU2uPPAN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 16:32:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  <git@vger.kernel.org>,
  "Phillip Wood" <phillip.wood@dunelm.org.uk>,  "Elijah Newren"
 <newren@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] sequencer: honor --empty when a fixup!/squash!
 empties its target
In-Reply-To: <DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com> (Farid Zakaria's message
	of "Mon, 13 Jul 2026 09:30:40 -0700")
References: <20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com>
	<xmqqh5m494yh.fsf@gitster.g>
	<7a1e5111-185e-4390-afa1-c19908c9bd86@gmail.com>
	<DJXL4KSUEAD4.1EE4ERHJZ00TR@gmail.com>
Date: Thu, 06 Aug 2026 13:32:19 -0700
Message-ID: <xmqq8q6jhtws.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Farid Zakaria" <farid.m.zakaria@gmail.com> writes:

> Let me know if you have any more comments. I suspect not much will
> changes logic-wise once I rebase it onto 'next'.
>
> For clarity, is the f85a7e6620 commit the 'next' branch ? I would have
> thought to just rebase ontop of 'next' and I'm a bit confused with this
> commit hash.
>
> If there is anything else I should be aware of, I would appreciate a CC
> if you can remember :)

It has been quite a while since you received a reply from Phillip to
the quoted message above.  Has there been any progress to share?

Thanks.


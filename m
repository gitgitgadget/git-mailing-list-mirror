Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717DB36B919
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907800; cv=none; b=DL+mXpi3o3+EJc/c73mufKpOTbySw0HyTyvvrR8B419eZOU6Z1N77p1AQbGIJpppAGl5Rta/USQ2D9a67LotaRvHz7UGohKdeAUgJ11DfuZGcK4Ly3GTN2GgY2xp8qNrkS2QVxr//12O5m2jLwQ0at0pKz3mVINqT3+CCBtRyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907800; c=relaxed/simple;
	bh=gfeDBnmw7RlfvuKuBVZvg0vfPFtCtujs0mVb0RDy7z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEJqjcOMZogWjADv2u4jR8MjZv0OWwseviNWwxH4x7vrQrm2tJI4wF4wSIdHUa2aXJd0WyIhXR7la0b5YSAG1I3D64Ntafvq8xPU+dvi+qhQOFYq0F23iZu68sJZKV9Vy/sx4iySSSO43yqXe/eRWVpQDOMOsewXZFuhAUA3ES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jm5QaeFi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADsVmfEa; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jm5QaeFi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADsVmfEa"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8763A7A01B8;
	Fri, 24 Jul 2026 11:43:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jul 2026 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784907797; x=1784994197; bh=v1i3daqdu5
	hAF9VYuKHo9R1he5aAkBQm15H2oRo4BTQ=; b=jm5QaeFiVKSO9a8raAsJDN7Mo3
	rkibLLZNqPqKKCYZIQJUKqvAhzopeyd5hH+mmgmziQXNuQrS0p9q1t4GHD0UCs1q
	e6kgJ5FbUxYM5tzplPucZlAGWe56p2E8+Sx4GqgIQlpzdgcNByGBa9s2WxT/4bPT
	BJoSPjIHum7LkCLU0crqyx0Y0vdd1wYc2KUfsI0mQTR5CIsb0JpLT2olVF8IsQgt
	vCh4BBL21zq/fFGptwvD3KOY0DgDwBhj0D8RcnbL6CmQaeqAJFLzKgUPpariI4tO
	543Pku2q2IhpD8p+RU/N4yKOICjm0kglXm6tMv8cTTTwrQyRZUxoKeRPLpdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784907797; x=1784994197; bh=v1i3daqdu5hAF9VYuKHo9R1he5aAkBQm15H
	2oRo4BTQ=; b=ADsVmfEafkVVBJmwfRE++UlSlHVnIaSsxtHlUyXX6eg4w7q4Ncf
	ZacPXxXvsOjgApRpKTFmWgY/f+MykrKW4n4D+9baCFoqLz5P9KpayiAza4O4A5JF
	MVEjn7ZZ8OkB/4n2koQBGiZMjptX6qBNJIlHWLzbosD3zZfZzZny336bbWYpdElS
	Cg6b/p8lthqewezH9I2dEVmQfb3ezHRI9PRdIB6sNVB437syY+U854ONvAZxoqer
	fBZ/KSPFmhcXlE2P0UPNF0nm1mIECWaVRMAjcmB9FrDygovvjPO7lDdC2sAZZCWN
	iVwzNUsEfI3Pc+GVsa/WqPpY7ITFtK8bgyw==
X-ME-Sender: <xms:FYhjasLE4_-eAGT_7441rUS2IkOShEIcA3LBSj0SakTZ5bNpnKGVNA>
    <xme:FYhjauYWZzTSbBkK1QZP48V6zZMMpEDsFzYVZqP3NAWNayi3Iz3metIjWWo9w9BU-
    6rByasjdbu-dtDgY02G1YuM3LojVwjQNZU8Q7GtQqnRIFmd2SmTig>
X-ME-Received: <xmr:FYhjau8_w2kstsiyfHTJ4oQLDQNV8RnxNtq_IVAY6sKB3IOVADsiGmr4q2r_Bi0SNZUKSQKDeE6vs7N1y7ZVRAfoARYvefBjMw>
X-ME-Proxy-Cause: dmFkZTExWRB+CNQDovXTLrUeXs4l3Aw9xji/kjAtRNAsOjPBDqMZkCkp4YyWavptwZB9b+
    fPII2uDqJOaWn/25cz4CnjJbad84K1WMdU6cmSOZz19hVTzVPYbs73IP/O7asxImzGu9Yt
    bTb3aF90VmbLrC+UlU47HOIR9pQBMjAv7nz+O77b4uVVfhTkyyZ/OolSLGwj/gOXyNAdKW
    FL6ikygT0Afl3jw/JET2nzcUHscJhr47PlaE8F9lNkA+sMVOfQqIPVQLZwPbhIBzjWRsy9
    goRoxrPEGzmGnD5boy6DxgimiZ64WXSKGjUA8oG91y99rufifUopFIRuCBDUDm8Ml94AZl
    PZLl/V79b5RG+K1Ddp5ut7SJUFMdKekPsy+w1rH+ARCzjnF+GqTGQ5oAcJcaQ9UlzGUNYp
    o+2MZkUsI3oehepcNG4hzxm1f9jmSmxYvCI4jRc2DqUZiHH+2wbrTMOFlxg3jchVo2s/ac
    +Jrsn7k6w7R1TlfIOmixrOnUjUNO7YHvdsapn3DcriqtUo0HK86QcBV3t9qkz1uUA24T4Z
    660YA8EFA8OnRE8Lye2evRnfG9DkZiuQpm3HnWiXu4axNYz+negOEnZZ5ACm3mRsHo2rSG
    nXyFfr5HEiCKrIjUTGrOXL0a32WTNyiyp2gIh+aVX6RZEIqF3De0+ccZRcVw
X-ME-Proxy: <xmx:FYhjavZgljTqC9pGoFFSz9tVAhFeDGN9iOcYljvS5C3qGSJKPVrXKg>
    <xmx:FYhjaiMhoX3-uSoRdfFswVw6_Ouey1sP4cDdjl0pdOSb43xNozdcvw>
    <xmx:FYhjarDt8Xnpzmc6bP_4UMgPIOUyB0x5L1jYzB6T1UwtR_nHyeKxaA>
    <xmx:FYhjapKvqHkFcHPZtVCaPY3I-83y2AFibD53rY-XMBpQxqyknZWLgQ>
    <xmx:FYhjavGA1K9wAimHNygbS9KwrNHVx5b96hK_W8PaSR8m96kwIXibhGen>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 11:43:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  Johannes Sixt <j6t@kdbg.org>,
  Phillip Wood <phillip.wood123@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v21 0/7] branch: delete-merged
In-Reply-To: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 24 Jul 2026 10:36:10
	+0000")
References: <pull.2285.v20.git.git.1784704238.gitgitgadget@gmail.com>
	<pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 08:43:15 -0700
Message-ID: <xmqqy0f08kbw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Delete branches that have already been merged on upstream.
>
> Changes in v21:
>
>  * Change loop variables to prevent CI timeout.

I see no other changes, which matches expectations at this point.

Is this topic pretty much done by now, or are there any outstanding
issues other than this workaround for the performance issue with
'strvec.cocci' in Coccinelle?

Thanks for the prompt update.

Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBE3EF0A2
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974376; cv=none; b=kuipybgeSMH5HawmduolXggSgzTPS2ZlN0rkK1UO5r3+YVmGD5flHlLXEWLQxI5OF5ShXu3TeTofcLQTQkJL4wtqkLR1yMqLzS1gmlg6LN2Pz5OCRVYPICvgAab6knnJafqHRoopqfiafrHRTqR4SKzUXLK+/PGzlwEJoAlxTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974376; c=relaxed/simple;
	bh=a/0WohmNRQ4ie5BAkY8bahGww/HskHC0QUTsrmAHQ8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPRYtcdZOoX/m7xkkF8pvCxoZSbzHFOI3RhrZmydMC92wxNsAEnyYY/iu7PATsMdO8/WYL9tqZfDwJj+YFTrr6cERl3obg++wbHpp7wycO9ra33DQh23jNvnMlrVGm/OiElD61aFTq0lWhy+vtstqHe64oC3gwbABSSNiNe+cQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CJEMVnu7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zdg7t3wz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CJEMVnu7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zdg7t3wz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB3E91400012;
	Tue, 31 Mar 2026 12:26:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 12:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774974373; x=1775060773; bh=a/0WohmNRQ
	4ie5BAkY8bahGww/HskHC0QUTsrmAHQ8Y=; b=CJEMVnu7wSkTbt7TSBJnqPpmTm
	JdTDWVUJuf5QZ5fYmADP12HW18zTn6oFNOCNYXbC/FjFfdWiByb8RaurxmECU5uk
	Te8sR/8OKyn18RXdNhgo7sGee+2RlpXb7gww0CeO+TWU36+K6BtOfRiaqXDq8ddQ
	unYNfbt9X8WdccRz/ux0rzWpm43OG9u25cXYsyYQw2JZwkcYG5nejvyEx7+g0y3f
	Y2/URHL1ypj6w5T3FXTwjd0dt5uQWnUrHnStmRDQqCp+tZhPHCMhxvK5KfhGl8Zt
	9PJMIcba5hQXZGMZ6ADUu5sRG487/MiIwtEs1KcU9sOwwJJPqKEIIOZc8y9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774974373; x=1775060773; bh=a/0WohmNRQ4ie5BAkY8bahGww/HskHC0QUT
	srmAHQ8Y=; b=Zdg7t3wzHKgQsMptN6bmXE6OOGU0NMZYpz2nSXtg/D1aoAcG4kf
	Pzsh/J2gThsWwOW8b1k26a9kO8k6RGnCcNaSx6E1vFBXABjBx/vytJVi9op29cLB
	UjpSrU3AK/RCyGlPJ+xlrkMDNK3DpK6tVxyrsfrEalbmCdKnK8yOehPfw9DkdIfa
	x1Iq0FE0VEmSMBOK2Tg9dxQbe0/qiBf/u3Kpa81ERrP5Khm+hp/5aHE3EHVNOBc+
	ZAbf4Z9FBMCnzenAKiH01OiRmbnJCViFff1Fi5MakAWE3rwVW5VPgMmlNlNaQ1CD
	r5pnUCzkJFGPFHBs3sVSot25I85pXeY5SCg==
X-ME-Sender: <xms:pfXLac4Zmhwu5Ux18W7gvJlxFOyG4d3pbgBkwIDj0Qhz_Qk6yRr09Q>
    <xme:pfXLaVUIhsDtjcYShboAd_PKcbfMqwo2h9ZNgD6qmp_uf60j2r7lIR5IsS3xOhZBc
    1n6F0zsnEjgpXDd0P9NE2UBUWjwtd70V18JCsahY0mqTi9D9cHZ>
X-ME-Received: <xmr:pfXLaY3yZ_1MWSFnOh6w3oiHhj7mVs7nb6VlETPSLdOAZ18Hadwtp1VTPjfNVspEHHLz_8MoLyw_ekfbtCcntdOLdtQGN8bX6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgrghsphdrghhiohhrghhoshesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pfXLaa138xHHrXqPeCYLr9GEO_0i6bvLtiD3o4ZTG56sr2seJCx2lg>
    <xmx:pfXLaT_eDCb5R-GZ0koGW-pTX9AFx6UMcg_USudttgkSAEir8gzGNQ>
    <xmx:pfXLaf27zFHslcwBYdOXQgVC7o-LrwanQcy6ddxDPtBgKH7M5wNXpA>
    <xmx:pfXLaY9iIOahE-0Sq9kktYhdqLbF1934XZzIvsmgdsqNe9BdWmY51g>
    <xmx:pfXLadWO_GsIJQkoZiQU3zNy7DCl6k2LOYmFmkWovJlxv6gp_OyUUtP2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:26:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Giorgos Gasparis <gasp.giorgos@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Feature Proposal] Add a built-in 'git whoami' command
In-Reply-To: <CALCP2CjymE-i9TsKB8TmW_0M=ZDbtLPzZFpx4-ba01164b1MOA@mail.gmail.com>
	(Giorgos Gasparis's message of "Tue, 31 Mar 2026 17:57:55 +0300")
References: <CALCP2CjymE-i9TsKB8TmW_0M=ZDbtLPzZFpx4-ba01164b1MOA@mail.gmail.com>
Date: Tue, 31 Mar 2026 09:26:12 -0700
Message-ID: <xmqqzf3o0xuj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Giorgos Gasparis <gasp.giorgos@gmail.com> writes:

> Hello Git team,
>
> I would like to propose adding a native git whoami command to Git to
> easily check the currently active identity.
>
> Currently, users have to run two separate commands (git config
> user.name and git config user.email) to check this.

"git var GIT_AUTHOR_IDENT"?


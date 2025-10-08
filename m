Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3901EB36
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956689; cv=none; b=odzfOeQrKatw2H+ZYMaZoWgyNRxcUbxax6yblwY3iqcOKj5v9U/SFVRJmuMuJzJBI30oBzS8c/gAkaPH/4BTlAGPQWcm1oaq62tBUuC2grlT32oOJzP5ooLvKvTutob+P/kRuhqiAFhcp2LINNMyIM73Y8+dJ4GNMsvUA55CrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956689; c=relaxed/simple;
	bh=qKGAwjXcZAd9zcXTt0wm4j91Apvbnv9Vy8YySiuq4dc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGkoftOtp0NmS77Z3mJW2HpCWh0Fl8CLSoNX2hpKney0Ln04oTAqr5rGxuRbfCWODb8bYqFIneoX9P82Aw6ZlDy3XWjsvfj1nFX9zcmZeGEuYOloSwktS41DXfAOU8FZlzGPSPke8SPUNCi9ibXodViDcwNzR6xFTr7zY71+Spw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BzgNT8qa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iyH4JCQt; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BzgNT8qa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iyH4JCQt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 542B47A04F0;
	Wed,  8 Oct 2025 16:51:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 16:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759956686;
	 x=1760043086; bh=zECTQNn4DK78hR1Prdlq2ScYQEfa132im3PBdGnPef4=; b=
	BzgNT8qap+Zr2GxVOQNEFHWk77B5h4Y8eAwOL6fUA8LdDSUbJ520zSgVYML63SY9
	mjkdFoieEfLWdJCpVlML8iVLjfC/DCi8YaP7LN5CVjS50fuLPDOOwa6nhQmvmuN4
	eYpXMJyue9B2fP1e2Enm7XgGywgqb8YolCruM8vaGLE4GJkYP6tkj0Z4taEtSbBs
	5Ezxw/VDtTFbTOtoAnJ3CTx+f/tqp6E5Uon1rnLktBB1nbOd4vaYXn3fHgjA78p+
	ceLKOZDhQIbh8lmBeZL/hts7wowoF/GgtbqBYEbdXuIU8zfOotGOxU+J6EbmZ0Cm
	50HHdJffnRCS3kfa+mt1fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759956686; x=
	1760043086; bh=zECTQNn4DK78hR1Prdlq2ScYQEfa132im3PBdGnPef4=; b=i
	yH4JCQtqS2Kunt6yWChYWDCtquAXYEDroAwOTjXg1Y5w7M72TJYq9T0lzoYVXILh
	4t/xHeuMyb9i3IEmJ+H+DfO+5Z2zovl+UEMk0VTCF8FiBaTmxBu3dWvc4sVLQpIv
	2pMiTwveKBXHZo0sY/rEtNCYwPTukLrgzc+Qo8+lTuUW+1mcFDMnBHmS3QL3pgjN
	4fxT4IGu493KXmvgujEiNzH27cn4e7+Dh4sLdKSriOkZS6OGTNEF+qNDIsp5tD+p
	bBN1vF35MOXATBeepu65jSocjUk47qxPnBhIcwBQ0zcczOOgN5eTrtSLT4yMMNdG
	bk1iihZ5sGxSXabLAMIjQ==
X-ME-Sender: <xms:zc7maKAxlv2ZTV59jJzPL6MlrhjgS4dmVDAf_FWJV8kGGnvbRuHqPA>
    <xme:zc7maLbHNYSBFaDcwyF51CbJsyKdWneDg3deHALUCodqvRv9HGnPtNxeaLPeIYS2y
    2rn3kbEk2g4B_7lBimLYkvocobcI2AQ20QdS7XAPRjkGzSXdhbt4Q>
X-ME-Received: <xmr:zc7maF4fLi_ykF5brePA-QKTuzalgF974cuEaoPMHydHWRLTCu_8Sf2n5-sZyVQr5pqV4jDVKrLc2bk2nq871uOtA7Io4WYkUtJa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:zc7maEb5Gnvz2huPbCJoBKeGt1_0whE8-XQrq54hPqM_Y39PG6cwEw>
    <xmx:zc7maMjDDlwqp7xgjRJ14L47Nqhx2Z5UhSSqFT0dhhpfp4csJbqFxw>
    <xmx:zc7maN9li2aLwYiDQeTzb9IwbjuomdnAW_Ag544yrF3eyn1p3vMofA>
    <xmx:zc7maPoBroiVpu0PEEXnl7UVypvO4i3HcRk-RRLsPBTGX5r_h4QVBQ>
    <xmx:zs7maEwcB9vgG1TTpwcm8cfJWZ01gq-Bbq5YtS7mL0RFTBxWfknr6GxD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 16:51:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Taylor Blau" <me@ttaylorr.com>,  git@vger.kernel.org,  "Elijah Newren"
 <newren@gmail.com>
Subject: Re: [PATCH 1/2] SubmittingPatches: extend release-notes experiment
 to topic names
In-Reply-To: <85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 08 Oct 2025 18:14:42 +0200")
References: <cover.1759873165.git.me@ttaylorr.com>
	<d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
	<85dbe67e-f252-4548-910d-4af29939806a@app.fastmail.com>
Date: Wed, 08 Oct 2025 13:51:24 -0700
Message-ID: <xmqq8qhlf777.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> I like the format in the cover letter:
>
>      * tb/submitting-patches
>
>        Extend the experimental protocol used by contributors to propose a
>        topic branch name in addition to a description, and describe how to
>        name multi-series efforts.

Hmph, but the paragraphs that eventually go into RelNotes are not
commit log messages.  "Extend the protocol A to achieve X" is what
we would write in our proposed log messages, but after such a patch
achieves X by extending the protocol A, we'd report it in our
release notes by saying something ike "The protocol A was extended
in such and such way to achieve X".

> But it was noted[1] that the-topic-summary doesn’t seem to have been
> used much. That’s not surprising given that the instruction makes
> the-topic-summary blend in with the rest of the cover letter and doesn’t
> signal that the author intends for the first paragraph to be used as
> such. This patch shares the same problem.

Oh, that's a new theory.  So you are saying that authors may have
tried but I (and others) failed to notice?  It cetainly is possible.


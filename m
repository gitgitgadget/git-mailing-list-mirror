Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC131A555
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368097; cv=none; b=TBaCWIAdVWbY4MH18/X+xlWHY6Ne42xSCzy97uSqUhaje58a3eYkBUAOa2YZQ9HPIjJEBfdRmQEIEkZTcyHUP+bm6SsOTaRpEgwIJIVCI+vaWUcWEcMibdRxUcfkKsUtuz07HGPXRzJHrJX9aWcCSiGYnbTrarKmCg+5F9U+LXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368097; c=relaxed/simple;
	bh=ZVTNqoYIhp2PsY1rVwsAp7WTBdfcaoiIIgcO9+SPWWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A3qYJuJIhVZsu/QcGlnbBJqpcLGW9gFcM0lAOw4vfYSkLCAz1EUZ4krR2yNKc0A8QnQWnJt5aNyoNpnKNeR+Miv9wJV2dd/d8yQl3s036qzaJAgE34iY4tJlhbMlg8VJKPbCAT6ffwR9T4PykRNvUKabjTvS+XogRgzckTkRTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ky9U+AnF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/kNViDr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ky9U+AnF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/kNViDr"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41E1F1400050;
	Thu, 16 Apr 2026 15:34:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 15:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776368095; x=1776454495; bh=48nlhPO1uJ
	YrZqmJwKxFYogcD/9OXTd813aUCVOLRRc=; b=Ky9U+AnFNiBs1pbchfAWPhunwU
	Up3mtAMz4GHQwWUWEZxXpL7B0xvuOFrj0nc3Rzbx6bD/BxTjBD2c9KIYOFVDrakE
	WGcCWp/aimhslkxr9DXVWn/fzfva76rwTBNe3BVrcPdYlrjlo7p8iL4wMWJBk7o/
	3ciwLRZYXO5FPsLkADl66OhStyiZl6PL09AixjdK3/SnB5kkJH4OHlHRrlP/EOBa
	tCtikstUFk8jJFvv3AgyxHEeSmjU6QS6/r5/tgoHEiRe+lGvNcszskKP9mSNgkQZ
	dYipN14LDijUDIfL2Ou2TD1WUTnpaykFshWe4mAUwNU2BW68WRPgXlVDioyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776368095; x=1776454495; bh=48nlhPO1uJYrZqmJwKxFYogcD/9OXTd813a
	UCVOLRRc=; b=X/kNViDrtch5oSg4oui7g8PEoGoOWOk8rVxgQpzYzR6ws9owt8n
	ilBWtEbbUTUGc2nu3GRUVFBdUuX7lKis8KtkeHu3m24eTInAe/vTMaazNBK19WZK
	HbuBrKIczq6hORnduB+HeT+HFgRnDxstGPRqM2QUWtB6fICzp0VgMQKfmjHwcUbf
	YLnKVd6zS1bTOpNS3gIP3oo8Mw1oh7olorhNyJEvM6r1ItyXKYtGaXMYRp0wQyu/
	qBw5ILIouZHlHSkI0hajQnLMs9XenFMSOASE1Anza0+BTSnh65R8MHxQAkcg8f68
	t+GoxXu8SkaHXgY5GBfRgs2gLsH3VTW9NHQ==
X-ME-Sender: <xms:3jnhafgtFLkv2E84gP4fLGLuxYkfbMVj0-6ZYRgP4pK0QS_9RPhpCA>
    <xme:3jnhaQ8YEW3GJ99eFHJQfvd0BrlqdV0emiQJyoMUUxWFFpke9IkseJ1ibL5Pvx8dF
    yoygmyCbpMWj_g1_b1EzM23wmC_8QPdpHMD_XOHK7P44iZBZnLjaQ>
X-ME-Received: <xmr:3jnhaTXoOH0nMmq43tPuUtzVm6-OJnPF0umBwl00KI4hl0Pj5a8t7R-Vdhuc7J7xyeEefCGJc_7ySJVNtow2MeyrLkL3zoH9kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehijhgrtghkshhonhestghhihgrrhhkrdhgrhgvvghnvg
    hnugdrohhrghdruhhkpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghn
    ugdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghhrhhishhtihgrnheshhgvuhhsvghlrdgvuhdprhgtphhtthhopehgvghorhhgvges
    mhgrihhlrdguihgvthhrihgthhdrphhusgdprhgtphhtthhopehlihhsthesvgifohhrmh
    druggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3jnhacAyWIrwgyk1xsiF6nvkFA62yTeWFrPEDwwQKQ6fHRInL2IDaw>
    <xmx:3jnhaQEYLTcCp7_h7CV3gf1_KqQGWUlL_hHVJ8pKEq-YGUijneR2vQ>
    <xmx:3jnhaV4FfHjSrxPqg9gBU0w8Kc8Y92LaRMUbsKxzooJciZZ12pNuDA>
    <xmx:3jnhaen17qPlGUPcSq9_g9v5m7xDvcuuITdgtjFubbuZoSeuV_uVmw>
    <xmx:3znhaRW-G3qPNBU1K_jn_uDXFPMl6RHRLtQTfDv1WmBhigOr8W6t22Pi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 15:34:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: Colin Stagner <ask+git@howdoi.land>,  git@vger.kernel.org,  Christian
 Heusel <christian@heusel.eu>,  george@mail.dietrich.pub,  Christian Hesse
 <list@eworm.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <27104.58166.993109.63505@chiark.greenend.org.uk> (Ian Jackson's
	message of "Thu, 16 Apr 2026 14:25:10 +0100")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
Date: Thu, 16 Apr 2026 12:34:52 -0700
Message-ID: <xmqq340u1yxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Jackson <ijackson@chiark.greenend.org.uk> writes:

> TBH I was quite surprised, when I reported this bug some time ago, to
> find that git-subtree was written in shell.  If it had been me I would
> probably have used Rust and libgit2.

FWIW, it is my impression that on this mailing list, "git subtree"
is treated as more or less abandonware.  Patches to it often do not
attract any reviewers--- not the original author, nor those who have
subsequently touched it.

If you want to take it over and rewrite it with firmer commitment to
maintain it better (which unfortunately is not a high bar), that may
be appreciated by its users.

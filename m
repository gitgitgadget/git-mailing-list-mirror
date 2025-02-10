Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5F20487F
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217270; cv=none; b=orvlDQomu7r9gsEo0uT8MvWER3lgxN3AIy84o72guPSVt+3E1P1PZac8OBxVtLUAvQCLOzvjE8pbZk2W/vgSlGS5qaVeHM/5c8d5ss/mWX/BTQvv3md/Qd3AByNikSvT4tjc6wbLah/oM72aXHaCUY19S2rJt7OZZtO9xe+OaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217270; c=relaxed/simple;
	bh=nT7SteAx1B2KiJy7bGWaY9I3QVt0ATP2bJxuWm5/5O4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SR+kXRqfLR28u2NzF0VOPVOAupjFMkvRTNkXQdn6JxWAJqpQIQYYYr3wkJ0EEPcFst9KZ7o39G/fvsGG73PRIaJbtx9h8TYUBA8Sxy2gcfYvmmtgerAScubNY3nxoVPzY9zRq4UtCk+3AapnBwHM/jUE/0L/AobFSsHCbwflkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E9299hOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0qJkBJJE; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E9299hOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0qJkBJJE"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A01001140151;
	Mon, 10 Feb 2025 14:54:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 14:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739217267; x=1739303667; bh=YG+2wr/yvE
	LiW1PlpKze6BhzK+9IyYNUOLrM3SSAPP4=; b=E9299hOMib2196ThiCPyKZY/xW
	ildrlU2WWnm5+NRHTH91FG34Ipsh94l+59g/WYlZK8iaQE9d7q/E6qc0RUuc3lan
	KIb6Z3ZYNKoO3NIRsHs4pzHPvLudwLBMUvbmRNIbjKxbdKuq0/VFo+jeGuovsZL2
	qXtTylfZaALtMzQ+uYon+/jjAMHRhQDCr7ty5HL5ASDsJJ6Tke6Ffn1eBVahXK3r
	/Jcf28DiTo5E5Rvir5Cz+dKQJZpKIYwgWhBpLwBkiyLARqAsFGIikABuuKMxALZG
	jkHIXYM55IKv+42rvjIMnYi6g0hxTHAkbi8XGdQ3RRvI6z9cg/wD2lJxsr7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739217267; x=1739303667; bh=YG+2wr/yvELiW1PlpKze6BhzK+9IyYNUOLr
	M3SSAPP4=; b=0qJkBJJEKnML32NzQoRm9dbDi5Yt5/45ANLPXD8cW6swTBMY5jG
	S/Slep5GTT9JVJykMrd08YPdTqWsdTNP0K3/LBkKRXaHr0ugW7JeWsW+6FW8L83A
	UQjs7YY49mTrIIfZSp3wDVFxLxwm6o2JERo/ERHIttTahsHOjt7z54o3T399INGE
	yfgCnEer07IHHeT/Oha3JsOAVW6ownqRJw7Sx8qEqOXeepnDWesVf9Kx/FefSxU0
	8hijvHeS9z5Vaqu4NWEeEViV1lE6jBEqhuxjndjxJVfwKdnymj8yWAKv0JYmm2Ds
	OQbmX7ANarHv7Fq12vMKMaRJR2C7PzA3RtA==
X-ME-Sender: <xms:c1mqZ5FR4B3g5Yht3YmAbI_cZC5RUVgW54E8dhcWZL2Wxues647hHg>
    <xme:c1mqZ-UcbXlutlrFK-2Ls3Oa0PjV-Nk25vjzf0YzKOlRlWMi1hyxvBNFrxIhkDd4B
    kHPtbuLcm5EIGftvQ>
X-ME-Received: <xmr:c1mqZ7Jj5-vMLBLIkMdTlvFxFcAO93FPQ5gqEqTljnXCoYjepyUnWc7fpn_cqtN96R2dPbsEhEFGHTyqcyRsCo7pHdUuFw_CaZN_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshdrrhgvphhorh
    htsehgmhigrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:c1mqZ_HKEt78AEGVfm3nd_plzuayN5QTSAn-VqT8-0Kf9AywBxHHIw>
    <xmx:c1mqZ_WyxMA46-0PJCQLT9uEklaqZN04VYMy8mxhL9HHU8cVzs4ulA>
    <xmx:c1mqZ6PsSr0ks2jg_LqoUnH3mr3nVk8itQTV3EKcIibNv8e8ZvZKCA>
    <xmx:c1mqZ-3EYtw4mDueFvXwdhMcSmK_sfV5TO7vTHl7shinYRWpE_pxPg>
    <xmx:c1mqZ1wkPb8y3FXs0Nm8QeyrzX9NFrYyZfgLkyaPfOFEusc033yBJhjr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 14:54:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Seiderer <ps.report@gmx.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
In-Reply-To: <20250210174335.6d6d2af2@gmx.net> (Peter Seiderer's message of
	"Mon, 10 Feb 2025 17:43:35 +0100")
References: <20250209133027.64a865aa@gmx.net> <Z6mtnmvKMsIOEVz5@pks.im>
	<xmqqlduddb8b.fsf@gitster.g> <20250210174335.6d6d2af2@gmx.net>
Date: Mon, 10 Feb 2025 11:54:25 -0800
Message-ID: <xmqqpljpa83y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Seiderer <ps.report@gmx.net> writes:

> Maybe all doing (autoconf) cross builds where happy with the defaults
> from the Makefile (SHELL_PATH = /bin/sh, PERL_PATH = /usr/bin/perl)
> on host and target (as the buildroot autoconf package since 2013) and
> only users doing native builds fiddled around with non-default values?

I somehow doubt it.

The problem I see is that there is no distinction between "this is
the path for the shell on the target system" vs "this is the shell
we run on the host while building the package" in the Makefile.  Use
of autoconf would not magically change it; the Makefile that
includes the config.mak.autogen needs to be aware of the
distinction.

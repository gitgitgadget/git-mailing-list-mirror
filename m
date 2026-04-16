Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B620DD51
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373086; cv=none; b=KFvwpSXNmCRJ7VgCd2yAl5SLpdypYaDgDmXwp7+49Lt5wzeowKxekgGj6ax8PwzX6XexBMS7kVBP3PWvRLLDay74vFj1Q7PtrODs6BAcsZMvaPOWjTO9ynIJdxxOKHP+TDXALSJD49JukTp1oyWwf0g0gb7ZtMc4XqW2VQvxsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373086; c=relaxed/simple;
	bh=bzlaQ5UPwWuu3cPlt0v9VkWdVxvFD3kxWZBLnVdsX1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=owHGhEIsnscdmexTDe5fTsIKVIoHOK5lfa7U31m+veUJBb8g5NqfEcHz52R+YmnOguOSFqs1sEtpNq0JmmBdZXRoJeaxBSYHD1pmt7xUQD9XQOozn7F1j05edEfxozVLZuPegH0NHhMPHSS0HhQAcizAaFJdCroJRmNbsHWrbXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u86/G3jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h8r2Sy4N; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u86/G3jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h8r2Sy4N"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A1482EC0076;
	Thu, 16 Apr 2026 16:58:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 16:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776373084; x=1776459484; bh=F+hP+9MtSg
	nvmLzhGHLwmmdISwAjxfhZJeuRb1+dkow=; b=u86/G3jbGLqXDbqlnu1SyrwItw
	WH/SNxvxENtWtv3gvsaxrqQHZ4vBcB6V6sGcBxx6uAUOtJlAF4I8smJCcpOM2MoF
	TGlgYHfsxOCpds+6b/X8TSvP7HTxY2I9pBd4rSFDRUNUBzs4zuQdcrWhnUltON1z
	olEDCOaWGZaS9EWylSbnX0Sbiti6lmmdbqpeloe9wK0XOAB83VhpazkIVZ/eqiqY
	pdPvFFgmXxX/dHLS4M5pI01K3FopDcyhGK/v7jqQf5u0zTIqrxNbdNgpn/CUGBn8
	H9KjINa6VY4guueGsVlURcIg+DYYnPsjuti9KUhl0Gj5Q8s4cm07fe31TkNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776373084; x=1776459484; bh=F+hP+9MtSgnvmLzhGHLwmmdISwAjxfhZJeu
	Rb1+dkow=; b=h8r2Sy4NjRPGpYsihY/nkxWUYWwsj/ryQMTuDYmGK9e/H8aPBg+
	tZ7QCL+QyVEquwpn1pNnU8Dwb31LkMnKYpzn2M51VXHMY9PviD+iXDRXSZg9Oy1M
	1DIlPcbXVYpydF7Oj7XZsvMwt/U80MRN1xVMPazqldX7woiFjNwOVMcOzzVqBdrd
	1Ot41rWOD234xp77XL1+prBqB2qOKmZkpVap434WJ8iaLjGs/4JTPCOtI2K8dxvj
	F+vfIKQcecIMKhpiOePP6P+wAHKJ0k5S0hQlPoOXfdVIpLdYmdN8UBZ0sok7gVoK
	t3707N0dN2ag0bWLSmslqMI0blsXr04dxGA==
X-ME-Sender: <xms:XE3haT45OjiEgejCb5A4GHmVUrBZJ562LyJNE_VUlIZumo4d8J2qcA>
    <xme:XE3hafz5jORU1nljHTfEE4tANS9LPevIXKQFmKMlfO3H95jjFattaFTz_i1iCSwP3
    mfF97JANiwmKAO3Cw4G4lhFATwWZEOGTSrypNpSz6kbNuXFJaTP5Q>
X-ME-Received: <xmr:XE3haSxrAZgZcnLnB9F-wZd3kkVyaCEQCv9AUX2wjXtsu1p0BXsNJpsj67J7nuPORtT8mnXxNVxQ9fZPxhVHPaoZr0Ur9tvgfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XE3hafxTFXmz2Firt-iYzP8P7WCRDAB_3hDI8JWIfrhZji43niJHFg>
    <xmx:XE3haUbn7uB8BPlXxXopbW9dHFS1mRigsR6pUXwbHCXsp9weFwiRfQ>
    <xmx:XE3haYW2BVZDFTHHN044NV1I27Gc2PEDVmWvx6SWrUN1fHbXWG89Ug>
    <xmx:XE3haah8P7FhnD2kTUcRjyPSplpGXthaulh-ppZbEiOnYQUo8FMQkQ>
    <xmx:XE3haWJIcwiNmVvuUU5K2hk7b2PCgibVSnaTq03RlbvRAAU-CQ8ELvNL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:58:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
In-Reply-To: <xmqqv7dqzoeh.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Apr 2026 12:38:30 -0700")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g> <xmqq8qam217m.fsf_-_@gitster.g>
	<xmqqv7dqzoeh.fsf@gitster.g>
Date: Thu, 16 Apr 2026 13:58:03 -0700
Message-ID: <xmqq1pgezkpw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Of course, the tip of tb/incremental-midx-part-3.3 needs to be
> adjusted with this before merging to 'seen'.  I think my tree is
> getting ready to push the "revert the default" down to 'master'.

I'll discard this patch, as Peff's latest one that enables v2 only
when needed should make it unnecessary.

Thanks.


> ----- >8 ----
> SQUASH??? adjust for MIDX version default reversion
>
> diff --git a/t/t7705-repack-incremental-midx.sh b/t/t7705-repack-incremental-midx.sh
> index 562554e69b..7eb1109ec5 100755
> --- a/t/t7705-repack-incremental-midx.sh
> +++ b/t/t7705-repack-incremental-midx.sh
> @@ -63,6 +63,9 @@ create_layers () {
>  	done
>  }
>  
> +# These incremental MIDX tests requires the V2 format.
> +git config --global midx.version 2
> +
>  test_expect_success '--write-midx=incremental without --geometric' '
>  	git init incremental-without-geometric &&
>  	(

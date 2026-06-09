Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA6279903
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780975580; cv=none; b=jxqm04yC8KCA/PvwxGrwaHJoyvTtcbpIYBZsobotZRGYjxBiU4sgVcqgRVikRF1VFJppFtdYeMu/aNGGHN5S2kW+qMkpGhkiM1wULjXDgj5p0UsCSvzMBIaQIJmGZBAUdKfW7GPSNaWBeLYRCgLxctbphA0omBOW+TUSQSG0vHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780975580; c=relaxed/simple;
	bh=yxCgq94sNwuFIWbkjmi5n9EpTd3F5jHPa1eDdjFHEmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTHEh5wZcWybD7mPXGXyPY87rc3/Hm7Gec3q8bI6y+X3wkDnka22Iz2r4JEYKBg3/9CNgSE5u0mKG1hhoXsbyftr86Dvt+D2BpkRxXDYop37cxl6SnXIdFmDbPGxeMEQhMcL0azalRJuOfgiaQeLwEIVgPufrizNFTs1VRrSaJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mVwArtdD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3R5Xl+P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mVwArtdD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3R5Xl+P"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 585791D00109;
	Mon,  8 Jun 2026 23:26:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 23:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780975577; x=1781061977; bh=NBrXwC0JfJ
	k34Oxl/wGwHZnciqOUKks2vHcP30QdynU=; b=mVwArtdD+TZGwoInCXuZKLPzJ4
	KmvkHk/TEHldS0U7oFqJQlNjf7yuk4LAtmZeN36khoNeNSNxxeY6ufA1h4Nh8yiX
	IeWDklC2UTo/httYsR6Atv67aT+I8XbyMTRj8eTPIoZ+NDCNwgJKzOkyHPu7iAlF
	yVm9AeFMhnikC3qFNkdPZUSGP4p+bStGOZ6Qpnr0wyjaw081UzKPoTJdcQQmsMQL
	a2VfP1RQLrdSJwH1E09Wu5TbaBlStwFI/nosFw9qyjgGvfijDGCKn2pE/upoRM88
	THNV36q6mv+WV5CFg2NdJghpiDXA96hlSyyReuopPh2pDmNpji2ZZeDorrgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780975577; x=1781061977; bh=NBrXwC0JfJk34Oxl/wGwHZnciqOUKks2vHc
	P30QdynU=; b=I3R5Xl+PdoSmpdEy2RmX+hMuAnXugJkziAY5c2VC+G6SXOXECW5
	gj+kQKYCWBdE/fQfLw7xx5E51tNxadVhnLXk6aRIjjdx5w1HCwnz6JHZ4gwhSpKh
	eTQwDSVTCT7EG6MFfhAD8PSQgU+GGeeXzK2oUXN+VVmBfOH0/EbGjgyA1S8DxJiO
	QZ/C6kytdTH7ZynStSucPib9yG+W06HuGVj+8LnB8Pfi73Nkio/HjSt2qnoWW3Rj
	QrYbDYErrKqg04OU+cuAYULfgU1IchINerczeg9nxHatc2ScSSz6LOb7Bn941QgZ
	QyA+rFusJkP8PJYBUXAzqW9wNzDXLGJb1UA==
X-ME-Sender: <xms:2Icnap8jJT7wDxKLCjBJbb0MwKMWY_sDRJF0EG7HDNXZfcOxLRYsbQ>
    <xme:2IcnamJfKNU_Gbf025nLbX3XeuXLi2txu_TF0O7geIurQdpBCjdxyqv8sNR7LLNe3
    zrct67w08Y9ZqQpQATPRURAQ97eXJRoQYdllFaBM4bCCXa4Ey0qYPc>
X-ME-Received: <xmr:2IcnancYKNbtGNDrPhmoYCmxIQzeA_NTRZai8JVyaz6Go08awfFazY8UkNr3wrtjEcQuUMEli5DU4OVJyAxVF6njBI5oEw_--oIY>
X-ME-Proxy-Cause: dmFkZTFBOavr63C13VySbHbsPDgtQtMDOasR41BAs7+T3qBe3jrPudoKPeK68Z9wgu77nY
    Tvxc32qMdANWYJNCsi30PN88p4Y5RP7rEf/EITcFsvWLiliLHGGMGGAsb5/TSt+EeiaKW1
    Nis11rlyJHOUF9yvR2braSJMMx8pEX5njnOz9IpFZmJGk+s30KsDBX6mI17tX491SglmE2
    d+ojcO3TU411fiK3zRCA7/BhmotFhEdayCE+hvlwTEe/6UI5yDDCzHFc66pOUQ0g80mOGY
    ljTR3vLXgC8p8PPql+PvnhkZF8jHmbqrf5DQfQ6jstPwktb3O5++lje7+PEDQuA+egYYhy
    L2/75lKIh4Lcjb4TxtZUXer1y5YpwhRzo+9au8UQ5YzGJgXVaC3y1k0oB7eiDF3uUbhSx8
    h82lsBVjxaMLNtZh54y8Ah9V2AQ31sT4PvQhWqkcUUA0CPybnvRwIWs9UR5ANq06cX+njD
    ZVokRfTvRc36jMYpTe43WI3TDn4Umz/XNKshKgTxGUl7m3x5IYDiZbowvSVI/4yxQM6ZD0
    8qZogYt/8QEhWyMkmKeLxy6eZio36xCLH1weyWrhGYW/hpgXejaNi4WIocwEI3+92FsLoe
    909ex/PDBkOk4+xsdpQVVvI8O6fc0eknQHb+ZyIGXsK3Qn5afglw9lDkTjWA
X-ME-Proxy: <xmx:2Icnat8jN1uUxpCid7uTMa0DsEz6kvD0ObxX-ZIHOGna0-xDlwvY6Q>
    <xmx:2Icnasq-eGPS5RxCNb7Wqk68aj1xJmx5-LY8sCh_xZAXq-soQTeF0Q>
    <xmx:2IcnaqAuE_LSi3ShuiP9CLQDgXF6kOsdiPIaH_Gy5xBlAXnLJE3kcg>
    <xmx:2IcnamyeXAgjWEIPJkHnss830RpYMk8WT0CYw4RuvrnGSUzA8sC7nQ>
    <xmx:2YcnarrTD8ZvBdWnB693Es6dGAQebYgDvW6xnjpyI_PPKo_xfYYqJgz4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 23:26:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
In-Reply-To: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
	(Tamir Duberstein's message of "Mon, 08 Jun 2026 19:37:15 -0700")
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
Date: Mon, 08 Jun 2026 20:26:15 -0700
Message-ID: <xmqqv7bstmw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> show_files() checks whether each index entry is deleted or modified
> before show_ce() applies the pathspec. prune_index() avoids most of this
> work for pathspecs with a common directory prefix, but a top-level name
> or leading wildcard leaves every entry to be checked.
> ...

Please make sure that your v2 is a response to v1; otherwise loses
sight of the previous iteration.

> Changes in v2:
> - Restrict early matching to one pathspec, avoiding the regression Jeff
>   demonstrated with many pathspecs.
> - Add all-matching and many-pathspec performance results.
> - Drop the Assisted-by trailer.
> - Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com

And it is *not* a replacement to force human to follow such a link.

Instead, please make sure each piece of your e-mail identifies where
it fits in the discussion thread by pointing the message of the
previous round with its In-Reply-To: header.

Thanks.

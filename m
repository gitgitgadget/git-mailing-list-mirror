Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A7933F8C1
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718657; cv=none; b=uH/5AT0z4bQrOpq7Md/8YDP7eDDYSprmuHUrh4lP4G/OxOFyba6zPFgvBbIhG3w5lcDe9wEM+Mea9rgBlKh5lW+yjHllz0kvtZo1e1EwLIxaddRtIINwiCLs0ylvUoSU2jpsXJASfhvVTz5mEx950ENRdKslHkfQf9k+Wi70ycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718657; c=relaxed/simple;
	bh=laTvIXVg/a2fLlNUAXPjXHmjsYxWCY98oCRYvkuXp+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y7owEk/WolJY68dqqIkcMSYIsCE3iNePG8VbgSHDhwLsyq/dde7I9+7drpsxiSIj2p/rC2Xv4a3CdG7M59vjD14ThwlHC/x5jvAZ2HlqkFCi+glFIvmqBs7XKsOwV4sAdMJwPr5traR0KRtEeFqE9BbMRq85fPRaYC5FznnqKtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1lQgTEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDn7kzBo; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1lQgTEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDn7kzBo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1EA8D7A00F9;
	Wed, 17 Jun 2026 13:50:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 13:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781718654; x=1781805054; bh=PdhygIVOdu
	2WB0+0Ex41AdYm2/zOhASFWStUankSmI4=; b=U1lQgTEJarnOYKslSO06J6Stc3
	km4oseD15EZ/MRFytlQ6MjQCTkDOM776lxibASiwtQYlJy+zEFGsDbzoPA31EJuq
	G7K6UNl89U4u21dkfjJKwDBGq5VkqoLbYyA6a0kG/4D9eHK4tI0WQIivzBUeAlS6
	jvRGTnpABZhY/wmHdYqsoIAy/VH+YQDScDoyWnLajUrR5sxrE5Wi0p+iVHw5HJU9
	jqItdTE/M8ZNBKAZZPMAsrG6yHhyvGcQj2pHD+VfHVPn7jC3wGWDEumvGJoSdUGc
	xYWPol9/wk8u9UEB59Us1LxOACi/JlCQj19l6pol1HIaA1eQcXxStyfl+oGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781718654; x=1781805054; bh=PdhygIVOdu2WB0+0Ex41AdYm2/zOhASFWSt
	UankSmI4=; b=PDn7kzBoyr0khGbQNYi5h8mLmKB/PtCXTxSrVr+oc9/oaf/+Yc1
	pH/afSUVomB8hCx57Ud0/iRMQeAdxlbF31Z+XoXEm2+QEPV4r4xJogoAzoVkTMN/
	JAgAA+7scTucinYedUrS8T+tZy/YNKHxcEMweQCFo4IRbJWfKDKi/svXo+CtaH7f
	4g9+m0u0cEhGbqnxlh2TvNOY6IzuD/h4kEz4DH7+0fST5+viqWofcd6aDXUvQEk7
	N35Qd7ZkUlttgl7n/A5+AmjJkJUW2/IqmaTCMg5RaS9851/e0ODKwCnpr6VejxCM
	iRzEPnBi4nPdSBpf+VVIV6I3m4MtTuKWHbg==
X-ME-Sender: <xms:ft4yatOr4vz5YyNYd7jdHfS6cJAMH057uti7t7XIkotbzbI6KXj06Q>
    <xme:ft4yam97lRZbJxahBke8kFw6xDNus3oJnRmTrnCVHFfIFvxC7QbYzUwlAiFiSlZZ_
    2suTXm08uSPszgLaUEl-P4mYHfWT0ypSi5anIkFxsO9ohd5SHNAVw>
X-ME-Received: <xmr:ft4yahRWyWQaldhR1XvywqBGnKpcDF5b6mUCgT3IR1pFPNSulK3uyuaqcc0XaqQQDEWuQtBo6TAL-7rEJ0bc_8-lIOhdKPqCp-ru>
X-ME-Proxy-Cause: dmFkZTFihhk2AN375MGKeQTQUemTYGkwHERtoFqgRu459SwrBOwvB3mFZlnv1EnMkEW+ZQ
    nZUWGDGhFXN14sDB1L4HvD0JGCFpYwa0TdxNTW9RZHFog1xO1VgeghkgT4V0FTgNnaLL8m
    Dv8jsYfQBM/0J3zBGjulSpf5rAsRfic72Bmnn0F2msmC8cFJvReq2jiTBFgHjAeWp+6qwP
    rRX2sR1jTiPVLL6O1Xx82lkC3CYIfbVhrUA3M9JcIHG2w30iorQ//jbZYCdYS0gEgztqMN
    g1Oy1mEGTuoslZxP9LbwDnYD0U0bySsJJ9nH948tMiYX+etEAk1xclxi3PV9pk3NqeUnJJ
    hGRJ0NHg0S9wDspehb+7ILcVvJITuL6MyqMxQ6pKRkUiLAZ8oAPDray98+W8aSfVPy2hQU
    DDiTPIPbjbOvfmgx8cRtKZe9GiLQyf6fBJgDqZQ/44tK3+/f8Xb04wzRMVi136PpxPckjK
    ykjGVS7ETIXfcS0gp0eJSV84yFYxQ3BXaDUbcD90lvglEQtKD2Vln6PoPoG7ZJcV7ypPte
    uXPoIM8w/OUD17aVFKNMsKrBPBKCznchDopexgPrqn7ztvOIEdDnZWEf5sCT4CILrHwSu0
    9k73cYYL0+b6MrRloYTVIcBFaQk3S2V4j0Zq648sOvZuPBhCPCHAiZ3qArPw
X-ME-Proxy: <xmx:ft4yaomsn1gW7ewuayjRK8OU-JcIg9PK_SnDcUk-maVWgnQunHltjg>
    <xmx:ft4yahTCjLpGChLCqha1C3v0sTJrXpAncN-l46TmVm98LtiYlxpycg>
    <xmx:ft4yamPoUnV18DHO-vqrJ0N0EJ-w0qkR9euvpmDz1mEoyHG9fcgXNA>
    <xmx:ft4yaqX3RA7cEoiiRW89fun2sp4bUlrOG2UzbW2t5Ug-YOzySFiHVw>
    <xmx:ft4yaiNe22Gmr2aJXbBlRiERHTyGbGx1BYNLOPEdqTtToLGZuGSQzdQ6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 13:50:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/2] doc: advise batching patch rerolls
In-Reply-To: <496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
	(Weijie Yuan's message of "Thu, 18 Jun 2026 00:51:34 +0800")
References: <cover.1781358364.git.wy@wyuan.org>
	<cover.1781714757.git.wy@wyuan.org>
	<496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
Date: Wed, 17 Jun 2026 10:50:53 -0700
Message-ID: <xmqq4ij1vywy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Weijie Yuan <wy@wyuan.org> writes:

> +The right timing depends on the topic and the feedback. Larger series usually
> +need more review time. If the only comments so far are minor, such as typo
> +fixes, it often makes sense to wait a little longer in case deeper reviews are
> +still coming.

All sensible up to this point.

> If the comments require substantial rework, sending a new version
> +sooner may save reviewers from spending time on a version you already know will
> +change significantly.

I am not sure about this one.  Even though the intention to avoid
wasting reviewers' time spent on reading through the previous
version that will be invalidated is a good one, by definition, a
substantial rework will naturally take time, and it is better not to
rush and send an updated version with substantial changes that you
yourself haven't had a chance to thoroughly review yet.

In such a case, it would be a better idea to respond to the review
that made you realize a substantial rewrite is needed with a simple
"I'll make a substantial rework based on this comment, which would
invalidate this and that part of the current patch series, so please
do not waste reviewer cycles on these parts until I send an updated
series out" message.

> If the topic is close to being accepted and the remaining
> +comments are small, a quicker new version may also be fine.

I am not sure if this needs to be codified.

I often see (e.g., in patches from Patrick) that an iteration is
marked clearly as final candidate that the author is not aware of
any outstanding issues.  This encourages reviewers to ask "what
about this one raised there?"  to remind what is missed, or chime in
with "yup, this looks good" to show support.  Such a note is highly
recommended, but I do not see a need to say "the (supposedly) final
one is specifically allowed to be sent without waiting" even then.

Thanks.





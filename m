Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883F3AE1A5
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236489; cv=none; b=r7/We+DjNV3CYDfHfP6lBNCWom6komtfa8fZUtJCs8/IPuQdNMesM5uKZj7o0xXrJV2ti+yi3pn8GQXw29py79afT1vDN4xW0XF/LYDJyecTO5SHeRjUfeUz4WDQX4ZtXA8UhrkfXpJRsF515CwShnjEp6QYXGwIJQgwMTSpeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236489; c=relaxed/simple;
	bh=WWmeh3Xn5u7blW/RUgZMU4IISkQaVDDlqFHJVlGijD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DcmYeUrk22Vo3NnttP58ICxJBtE8Xtiw+kjJg4fph6zBpm8PXfR/GqM6ROIqoWSCzcqdn3IzuSr8ADAJ2w6sI1muM5f7R+y39TiYW6ZjeRmPTS1LV4ou5lb7mzYfHF4KozyQL90+az1fwyyP2nbQlmVZqZVOro946cHbcas+Z0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Grm0UvtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KaXHC7o9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Grm0UvtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KaXHC7o9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id D6A3AEC0129;
	Thu, 16 Jul 2026 17:14:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 17:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784236486; x=1784322886; bh=bwBh9Pj/mq
	iXpxhVIwMvsgifhmspNGQyyGrKN2Zh5P0=; b=Grm0UvtWvOPyvkZ31CSz89ePWN
	BXQAuRkaeSIdRgv/owogptt9AhUnUafrcLqbuJGD6gMsh62IA0+14xKIaPO7/HYd
	w45Tn6JuCJ4ZuiQBWaDG5KGANMMLRZLeBTGXnOdEe7Vo++WbUCXVKxYAKb+qtN0y
	eSH8Aje7tXhjZnc56z0YWIFe4yF6YIgqgOfFT5Ujs/BddmpjnPrgAjKn/T4Cxepj
	dn2Wjln+kfXyiY1xHojFvjN4D7i3LrKJBy4WTVeodsHCOJXfWuXonTtEIxJabkho
	A7/HHuJqGWb+aFNP6du34IaggPX5ZmhO4a+Z7kw1dNOBQsciAL6fRsR8Lqrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784236486; x=1784322886; bh=bwBh9Pj/mqiXpxhVIwMvsgifhmspNGQyyGr
	KN2Zh5P0=; b=KaXHC7o9z9oA7sTbchInVNJ4y1lEybTSI61DtqazjXLeQidOqTx
	czT1XW43ly+2Qj4bZ8MU0x2oOSzb/4EFR8iuj2aQzbpOabTyRQHzvHeVK+03q2ku
	7SYHAX2BHU9bkAhMMjkIIR5J2zZvhWjPfyO1LqEvV2UYjNfzIWxLUk0YOKp4zjy9
	Sl1WKJnt581jz7Kf6YPnzEEIG1gae+vK/wN9LNElJf+xIzVpmgf5Rzk2CDnCIRfC
	s526GsougCGI6A7Ydq7JuN+5k8UMAPCLNoXZEvpabatrh5+QDE5RmcpnaI5poGgr
	3dA+Ghez5m75+qqvaE5QFczRDGhjhH7vUVw==
X-ME-Sender: <xms:xklZar3uxoieytptcD5rK6RWHwsVWc1ipWIzlEEH5R93ZazSLBahOw>
    <xme:xklZampbOWtcXoS7IvZDSW8_wmpgJk5Mk9E0v3SNDOo7BbzD63JwLDwOPHbB5otFM
    uEWJ-tjnO-Ix7zX7oVX0Sh2sWP5plgMAij7YhGdPOxCeTvLWu3U-A>
X-ME-Received: <xmr:xklZagVh69T7FxQ3Qbh9JB3PLwiNAM9QVPNPvPJ0dLSz_7amhELj9O5vvyOnpCV5RkO75K4xwRucIG-Xbx0mXSxCnTBkMnJiNqvG3eI>
X-ME-Proxy-Cause: dmFkZTF7/iW5ebMyxOTdq0+s/9l7PSTZFnylZzeiLcPilRe5JtAFZcYmq7KEvusSP21i4y
    w07yjYiCOVl2n7BxETv8ADTnrbko5v5LXrAJM2cl/JgQZ1zHm9WfWsLFDnCe7C3SH2hVqm
    J+QbzPebmPJP2DNhkzr2FqWEbpv3QYDNb367SeCucxxfZEqCRk+wtzOtgv86lb/9I07zeQ
    7xX5HZb5/8ABg6u3YuRjGufeu97gcvSruNlGsSVFRt0Rmt0eAu4nBUNi7WNGnLWlQfPnMH
    ZGFQ1Jaf675MSsDalk4rZ4tLafSSA6+X40jxr6dkGB4D8zLjmOSRRhqcYCllmYyzFv4xFc
    g3uLELHgymd34bIwadGJUDZk+JIiSOItPhuMR4xLSptpOMu80TWAN24FKDDIChFWyIQOOR
    luxsOcLQQsam+tKwhjDc/eyZxmzvdlZRlNvsEJmn+2EmvliAvdgLtRrPp6MsG88SR0acSw
    YXXnJRVG4zrRtlszQUmCF7UGOnUadINtTszaj3GUpsKq3DU7+7v0wNbce7hwYW6K7BKRc9
    +8L3KDRsvgCXd7RQIJ8rsdhMO+GF4ScamS6ZmMQM7JyuErpWhQdACczAceNmcMGpnTJUgC
    biPmmAzcvl208B3QoUzEL2mpxot78kUX/2MlKb94OOHtxsFi+tP8dDhgWEUg
X-ME-Proxy: <xmx:xklZanrOcxiqVFOdtA2e2YSU_YZdQy-hhs3XJ_GlkwirJsqhorbL1A>
    <xmx:xklZavBdZvUuN0S-Q_zR1TtWwe_8hjjGCkh0OZSXqXKfSOV-nD3ypg>
    <xmx:xklZargWPgc0T-5pgs_rSX75J8KKFtyaRxpzuVnwlrqgG6bpSBj3NQ>
    <xmx:xklZalZlOfMPwGVCF3akbN0DdxEiEDyUL-F6JUWmHtPtaFFv80A7qQ>
    <xmx:xklZarBg3JldP52aWwGJ67VM6AtByuuDpHC4EvR1GJ2yHDxM6MGnZ1Zs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 17:14:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/7] parse-options: introduce OPT_HIDDEN_GROUP
In-Reply-To: <20260716165517.433849-2-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 16 Jul 2026 18:55:11 +0200")
References: <20260716165517.433849-1-christian.couder@gmail.com>
	<20260716165517.433849-2-christian.couder@gmail.com>
Date: Thu, 16 Jul 2026 14:14:45 -0700
Message-ID: <xmqqcxwmeiwq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Hidden options are not shown by `git <cmd> -h`, but are still shown by
> `git <cmd> --help-all`. If there are a lot of hidden options or if they
> don't belong to the same categories as other options, there is
> currently no way to properly group them.
>
> Using `OPT_GROUP("Foo")` means that "Foo" will always be shown which we
> don't want if that group contains only hidden options.
>
> To provide a way to have groups shown only when hidden options are
> shown, let's implement an OPT_HIDDEN_GROUP macro.
>
> To test this new macro, let's also improve `test-tool parse-options`
> and test its output with `--help-all`.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

We have been doing this for quite some time, but I just noticed
that the 'From' address your MUA uses ("Christian Couder
<christian.couder@gmail.com>") does not match your Sign-off.  Could
you add an in-body 'From:' line if you plan to keep sending your
patches from the Gmail address?

I suppose nobody has noticed it so far because .mailmap hides the
discrepancy once the commit lands.

The changes in this step looks alright, though.

Thanks.

Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468325CC57
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787283205; cv=none; b=QiikLiV6HdvthpPrH6UHbzXvx9SqomDKfNboUC8/a0mwpHxzRgUFP1HTwOzSAqewhD5FEwRkAa9Crduk3l0p6FDIUG9WAjzQblUtwvGj86oz6gU6eU27XKq3RkBtGB7Qjk+n1gp8MgLpLX95sdUMoEOY4ikfxPHF+0vcamgz8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787283205; c=relaxed/simple;
	bh=MpQNRqhySxeAefyZ83vu1sfsnI8raedo4LCPPj2qN24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzRYV6vt3t9WW4LiVXhyfjOHQdc7lTfBxOJF1gMelWfnTp3aswrmzwmRREwHTId/8uX/VZktsTcN5R+KzZcp9sy2SiMT21gwxxVNe5hHV3DYbeWN19D2HykdC88uEP9mogYGduTb9tPQgVM40Qatbr8lh2BPcdIVPVj3es9bPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yWRv+hFQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F25Y52vG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yWRv+hFQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F25Y52vG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 532D114001E4;
	Thu, 20 Aug 2026 23:33:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 20 Aug 2026 23:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787283202; x=1787369602; bh=5tEIICdRjC
	Q3lAyZFYA5ot3XLRDpTKYBl4MoGJl9xAw=; b=yWRv+hFQhGGXsdqr2wawW5KmGC
	nMoZF8QhPMLti9ftxdHunE3Ze8PHocl9Om3DuB3HYlxqA5cxalvdNqAAOlZJaF8v
	yAR1tUk9RB4q5Ki1ziOjHN/F/dIEYYx7lTRFU2pUEq3Pxoe2nsXFwEkum4X/003v
	ZmqhHHfXTEBUbs/58Lk50E19o10atTJ53f5Eebs9djhkfx3vgTNP+/zo5K3L+VcR
	0MwPnW7QvRIhjIMnXlSNSWUQ02yByRmhLTUjPcdpbGdxqGkknOLumQHmoMEHIZDe
	JDIWpfN6GWxc1GSQPK5wLKUsfdeZMNMKxXmAsbx8WxQW96aT9zzchwj8q6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787283202; x=1787369602; bh=5tEIICdRjCQ3lAyZFYA5ot3XLRDpTKYBl4M
	oGJl9xAw=; b=F25Y52vGUSMfK5DS2c81hRk4YV6/42VBzxh/UMvo8vA33qQuCtZ
	2BO7Piih1EINCn+YwHmieNTv7hWEDjrPD2gmLEn9VOR7K2MYL0ERiTAjq1WOvI/A
	ySHnvBqbq4eFOlo+MWKBgNyUjISIrWZN97kyP85A6GWuMOp8vM1kP4Ugtu8ahpQj
	TjXkroJHsNF4k09iUfCEG/OMBx8qDJuVUTMCbx/LCloGbSIBcU84/wAMmftPq0Fi
	AHdlBwI1ZCLL1Pph2LF3IDkxqm9VYn86ASAAv9Vm9pdzlgH0f9BqcFjx5PvJ5+jc
	U3N94VcBdENKiCvRbzVH+ruEu9/jaZeZZRA==
X-ME-Sender: <xms:AseHaprjEoIORSpX94x8HinreyWIacDff4oci5F8eWwu2BMcZuAsAQ>
    <xme:AseHaigrrNMePoPLhowhb4Xd1c9K7VeAVGQ8PlkLEv1qqjf1w5q_2EbgzBMh1bT8O
    puhJZxpN5hFFQdk9U7x3RD-0iGed2nEjvrEFgQmoCmi_BzOEwl8OQ>
X-ME-Received: <xmr:AseHaujiBuvOAdqroyyguwOcyiTodJUxdNobdaWXM72_0xI5n1PE4T_c2-Qeu55WK1GNpYNV72d-vW4Usa9WBSnAj64DKRO-OQ>
X-ME-Proxy-Cause: dmFkZTF5Mugv4PezaLLEeLByoMT4GeEgCA5m2aErx8HU9XWjOInhZU8FyEBeOcSaE9Pfdq
    ARSbdwNamgyaATqA0Fo8/PiZcjdtfWdVBSS6RMJavo+f2wSdIgP4oNxtE2iUBAn0fn4EwK
    KN+BxSrVWVEL445Gr+NFlGqjG0n1o+b354V1V2QaYApa7/rWYPCYjA3tPCyL5m342eosYT
    KL3+B/ev2UEeCOG9lPKMbj5nhV9G6K/7mWWIHtBeq+80FEb0GO+VTZ3ff8BgBRCngAzXVM
    +knZu5Jg1/AUuMFK1aMhxcdJeopeizxV/pTF/t975tmPYW+S5kcW6ygmpiiuvnIWcN3Pne
    sxExwrdESv7NJ+SeAQ+IRHn2mPrUG3dQZYU41QYTqDKm61vokAhNsHhXLmDgmtvizpLYS0
    i47gww0GaiLDRcBt3tyaYcDWm+cAaf+kjrGsPKozhWEBb91cabqZxEbrHC+V0AOm4z1Nut
    8gDQa4Gxh1krmPRWZucDcvCgoIzRJKOXzLQeAeVoQBYN26Z5qc9P2M87ftxRKf0qMlFAwd
    7CG5QnWUnCYuz06aPiqO73O3weaQMcr97i4+5nMysWTACc+rODqEhdtBLlymNvajyDi9ye
    YVarPXxkzLXaNsVJvIJSQ8+GoVp3qPKnNJb2SFVokIEP1HgsHNLjoNKAGW9g
X-ME-Proxy: <xmx:AseHagg3TCXQEF6MT8Ic9_S3P677Ce8dB0oTGP8aXkcNjgEq7jeq0w>
    <xmx:AseHamJbWjtDozU2daCPdZI7WavtipIz-fnLO23aioBrOwBjjsKGyw>
    <xmx:AseHanFO57GN7b_BNCsbst4NbH2GwXr8Hs63tp4VSm4GFFSfR7dugA>
    <xmx:AseHaiQ0WzSpOfI-gNKf674j9sTC7lC8Im3ZWuBGxix_9b86qqm2Ag>
    <xmx:AseHahCkWrF6PTg4iYwBngbUutD2INosDrX1ziMOwAxuywxFIfeTn4Qf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 23:33:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  friel@openai.com,  git@vger.kernel.org
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
In-Reply-To: <20260821004019.GA296407@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 20 Aug 2026 20:40:19 -0400")
References: <20260817233914.8740-2-friel@openai.com>
	<xmqqo6f02q2f.fsf@gitster.g>
	<c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
	<aoaTjWMSO8og_iFw@pks.im>
	<20260820082102.GA2973952@coredump.intra.peff.net>
	<aobFLJuiuM1EuNpv@pks.im>
	<20260821004019.GA296407@coredump.intra.peff.net>
Date: Thu, 20 Aug 2026 20:33:20 -0700
Message-ID: <xmqqpkzcrvun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Of course what I'd _really_ like to do is rip out --max-pack-size
> entirely. I don't think it's generally helpful, and it introduces all
> kinds of weird corner cases and complications like this. But obviously
> that's a much bigger change, and naturally if I seriously proposed it
> somebody would come out of the woodwork so with obscure case where it's
> useful.

;-)  Perhaps Git 3.0 boundary?

> I think this is a case where we could similarly relax. Especially
> because this is just the pack checksum. The actual object contents are
> still protected by their respective hashes.

Yes.  Dropping the "(b) validate as we re-read" step is a reasonable
thing to do with the least disruption from that viewpoint.

Thanks.



Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75F3E9C2D
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268171; cv=none; b=BEjOmiNd3UqWfk/FQ2m8ZhIyQkI9vum4wsRVLx019r64v8KE3YjQR1EQNTEEUjnzGe4jQXafG8LChGMGGKqx+/stGZxw7A/xciFeFPEOE9TDnnG1wdYTPUWKYzmTl5k+Fqynrxf1eVJYPCOzMfropOzpvCaeCMCALJifePu0LUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268171; c=relaxed/simple;
	bh=gaoSPk2HOXn1pKi+2bHDzM/mB3k9YfVsG4bocjJpoes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W/jcAxz/7EigQhG8vFBsWjUHNBtyRsCJzpsUppO5toMcUNIQ9zAU86M1wU6EnfwBCMqygN7yacqXA0G6wFnaSpBeRUJvh9kG5pApQ1rIT5SwiBMBt8n3f3vKloIJ3crktU4bshVkxfLp1c7+5oly0jRX/N9X4MvKA6O7E37RRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L9/hFm/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sx4O+Ddy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9/hFm/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sx4O+Ddy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C5BB21D000BE;
	Fri, 12 Jun 2026 08:42:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 08:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781268169; x=1781354569; bh=NtluqXrflm
	VLjbC6JPdMgOUsoMsRTIQ/osrexIpaKaU=; b=L9/hFm/hpcoD31d2AtJx3exHlH
	Uz5fduLqut4ek0k8TL2un6JNtswvqWl3RIvSdPFB7QrAiFmLLUokvnD/CtGiyxe9
	m4NrEzGYEtbqXBxwbBAUMv+qQq+gqwhmL3WNQtaYiA/IJXJrtnu4TiHk9aU3gH+E
	N3rjuWxok/GsAqDXe9+ZfTazc2AOoWiSz8CoWRtAQliHEeXmZn2xAbh7MNK6HQUq
	KZaozI/Td5smjjZHOJaxHgrlSum2bGHvlTiGFojDE3Mi5jg76m/Cl8wp1NfYvkLT
	YM7PwDxkmq+x0szXIDv1zoBcINp3OEPyUMzjIueaYadB9tcpSpQsO+/fUHpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781268169; x=1781354569; bh=NtluqXrflmVLjbC6JPdMgOUsoMsRTIQ/osr
	exIpaKaU=; b=Sx4O+DdylcEmA/+z3TL+yNedjHNYlbLAqv/4IUFfCyi3rgga+H9
	2GFybazxcawuh3vuneTRx4g6CJ7W+t2aMZmCgvrqG9wrLtPYk2QDAmEMGQyEULjs
	fbEOgjzBLg9SILJ3Xj0mt8Bz2Ksx1/T8PoMuFtnXrjzQmhi+o2k7wO+B1Mm2j1co
	etYVL6lzflSuqassjk1E1pDo83fDGopt60cUocvGZOe3XikZTaWSBACJx9N7LDdj
	l+vZWQugYjeCrxAkSrutYBnSnp50hbAiBWCg+N452PzWAjAZdMv6IGC7Xe9sygfR
	Yv0rdlIYrX4F1v7B3TLHOctJoLbcF03A1mg==
X-ME-Sender: <xms:yf4ras_V_ehKefOhT6I4SaY53ceTNrn6N9hT3k96XrlaN9wOusOP8g>
    <xme:yf4rasL60ZAfd_K35NO3qLkAevhERvFO8QizdvWhOtNqCuOPPwa-jDbM0wy1yraER
    4M4JSTZQ-uKms2-aO4RMHFdLxjzsdLPODs9C-QBP3Z79PVU15QPrmc>
X-ME-Received: <xmr:yf4ravYYCOzh-ht_9jdfS66-j9ADmqwppGSpbPb1qjjSsBzqE3gmqfc0Q2NNlyiGCF6TiezKBTctSSZwoyGaMjAE3YZuBrYyB8e_>
X-ME-Proxy-Cause: dmFkZTFsZOp4HL+Ks1Lsy3QpkIY27vWqNAnlyRGg0aNjM3Lvby1ENYhjttO7cfoCY651tj
    CaCcUGBNYGq0fDOX4aQRFiDkRZmA1/EuGXJG/87vF9roRFct8BnmrsjAEnxoDK5bS4ZEiy
    BonV/KNHP3vGHPlWty2GaIn1iu0aw2TLkVgK5NGdIpQodMVyAOotz/DMNI//EylUv5+iVJ
    X+gUzHRsgqgz0viP6H9LzD8nQn7oDWjSWgyAynCe2TrZlZb9f72OAcIfR4lf9xTfibA+r6
    ehmRlBSICHZ7K0GX9d/qbGr8u3nZeO0pj6v2dl0lY9wzG9THuw5+N8UxfNO0OO3x4ylxP1
    SuJ+QpFS8+zUU14E3KC6SzWycZxXIYIcNB3BRoqaN3KtZprUtpi4Ur5usIpHSag7aIfczn
    O3OUtCYImwmssf09Tycq/+CF7aYjlY6SmpAdNmxipBWk4IClAG/h+/0P4aDaa6QwSdpeyi
    QLo5H9Igu4PEca/ztzUtvgIBOY4P9tT3HcWx32eL1NuUueMPoP1hrUoiFCSb+0adXrIcik
    oxBffDZu6Ugptw2TyEMJmjvVOywckZ1vHDM0i9rF/BwHT3zleJ9V+5PdRVmhJRUOy147Cp
    9wq9i3LOs8inIB8QZKTXCNbSJMKYfvE+VkYJ/GupMF/WBCt8AeYOoEFSJSxQ
X-ME-Proxy: <xmx:yf4ramIocgUUh0Tv2mvC2dSf-xe3wiMKD4O84XJtnEwnSyctc51p-w>
    <xmx:yf4ralC5nILN9DKeAa3F49sjWFRJ3Y8s38YvyDa9GXl7xHlEZY14HQ>
    <xmx:yf4rajpIiqt_bq-cTWgl191-33PyiAh1OD-kfdHoyFKedJp-aNi3vw>
    <xmx:yf4raojmD5ZBgPiU7zTMG667kmOajsdNCAyGLKvaaFW4e0KsmIM5nQ>
    <xmx:yf4ram0Fetl-PugwNx0MZO-q_6sIlYZ6_DUcSr0ftmiXWLC1Ws2FLwQT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 08:42:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: repo discovery with rev-parse; pick and gui
 subcommands; silent make -s
In-Reply-To: <ca428e6e-c840-4ee6-9fcf-39889fc07400@kdbg.org> (Johannes Sixt's
	message of "Fri, 12 Jun 2026 11:38:51 +0200")
References: <ca428e6e-c840-4ee6-9fcf-39889fc07400@kdbg.org>
Date: Fri, 12 Jun 2026 05:42:47 -0700
Message-ID: <xmqqv7bohquw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit bb52cdac6254c006e06bf0bb820268dcf024fc22:
>
>   git-gui: grey out comment lines in commit message (2026-03-04 08:04:37 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 1b2c2a2edbaa1638becef4c3755b3e0633b9c304:
>
>   Merge branch 'ml/repo-discovery' (2026-06-12 11:05:28 +0200)

Thanks.  Will pull together with the gitk updates.

Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559041993B7
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580148; cv=none; b=oyzKI/PY4gATtngKCm5oO/3iHjyPscv8nl9Ma7yAKqnJxBncw5muQfhkYNc+C7wOcRJxxAwyQjFTRDu9GmqmDSBXzGUxQXvbBJYija/dZhlk1kTboVvgNnk51BKTohvFO8kYIPEBB/oWHjVzF70SLBIZplhnkQ73hIuQQrN3dZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580148; c=relaxed/simple;
	bh=xORDaFpPTNqdUABqB4oXPvIOk9+vo+asTMZbA3WUeno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u7iVJBRyxrkqkAHKDll+SyVVO/R3Xh/uMfVkdLvvdanGeLnAR8tQL87DWMQ8QLOO0I1EjDNTycp8pUoCzLDS28q/25eOdYcWa6Yj+fIJRuHnmrAjtepujGw7yIOl3WUflEvePKM5cHAnEibNTjs+v/am1yONoHjcvpgbqprXkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TprUPckW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPPUOxNZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TprUPckW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPPUOxNZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6715E1D001AF;
	Thu,  7 Aug 2025 11:22:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 07 Aug 2025 11:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754580145;
	 x=1754666545; bh=+aWXqAnstgfeiD99bKCtSyyIMTwY2+DVArr3Sqcg7wM=; b=
	TprUPckWPoC9BXXm7mBw9B9gt/qai0dFB+61OCtf3NDLZai6Cu880IB5XZV1qcFy
	FtDB7u1btTOmvKkodAwMp1R14/7OU6VbS/AT+ijMi1X2ve+Jf3PQ8swZ22j7p6vi
	tL151T/GeLRIV7Hu59aZcnBOKViARIRiPGFrDmk0Ti9A8p4cdv0/4K/T7fIe0uCF
	wYo86nV9ek0TW/ueP0FzVIrPlynPrEkfm4kDVKioLm4CKniR6e1KYehEgdPF8BxE
	Sa1pzL/qbYEPFAEqphHAM/5Y1A50cbPqYSR2x0gl5MN847mNEyU51N5Bh/XAUKeC
	arkOnMDAKSEC71SEd4nfug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754580145; x=
	1754666545; bh=+aWXqAnstgfeiD99bKCtSyyIMTwY2+DVArr3Sqcg7wM=; b=X
	PPUOxNZt8fB7/5dCifByDgcTMnxCgiOWSUSRxYvm+iH6ZKyN4IOt9OK7D4hMa6O/
	k8VQJMZCNelcsrwLnp2YWX8VhPy3EDrPD/+EwXCN542ViGmQcajTm6pr5bBcG2dF
	0zhelUBkbjeQwW/KRZZAFkeGWrcPguhx/TV9jfueqcOlCU8o1M93GkZArxl4nfhw
	ZfymvAiPvfySaZSHrKPcTi38pjjStu1e3H+b6oPVW1Gb15xxRP9PhgYlneJ0Fgun
	pci1Ew1ivRTFvaVZiTgKvmDk+Pk1zkw7q6wT6NnFa5QTtkCIzUhx2bgxwiyNjbsV
	bxfY1vg5SD57KKD3781Sw==
X-ME-Sender: <xms:sMSUaKl3MLJao5TrmeCpaDSJCh5--l1zGb6OjvOj-gGH16Oa_tSgHQ>
    <xme:sMSUaMbW2rXPt5YzvaCZTVjUbgzqKpZryFRLmNWeaXAaMzgKUVMhGNcjF2TnObZda
    RHiHvNBnfowR9bN7w>
X-ME-Received: <xmr:sMSUaFNky5Zo3B8YLhBXubd7EWBOgG-DDIm6Ev1WIXp7MGyEqoY9FQrJf8qyxuZA0iny0GXmqDikoOFf2nKhgSaQ09eKOMeyxdKbOOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshiivg
    guvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sMSUaBZ_gRRy_LiUQ0ybnH0P0ytSx1YkQ3EoqJs2ETLIpoN6iCqo-A>
    <xmx:sMSUaD0uL55YsPYyg2OOosUJ4I_tspUBsnmTj07ofSwB6lNYCtKugA>
    <xmx:sMSUaHeRyMsZh9O9fgp9zcacucseCf2KcXx_6n8AjYiYKqTBQBOZzw>
    <xmx:sMSUaEHA910d0tLkoSJgL50-UVvq22xaKETMqELa9-bCtPtUPLjEFw>
    <xmx:scSUaN0XcVVG5VUYapxbR8hbWL_voDidBRXyeh8Tmw7Xr8STvYfwtZZN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 11:22:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #02; Mon, 4)
In-Reply-To: <aJQu5VJ_w1Vq_VYW@pks.im> (Patrick Steinhardt's message of "Thu,
	7 Aug 2025 06:43:17 +0200")
References: <xmqqectr57ax.fsf@gitster.g> <aJO/VhvaH7FgluZA@szeder.dev>
	<xmqqfre4tahh.fsf@gitster.g> <aJQu5VJ_w1Vq_VYW@pks.im>
Date: Thu, 07 Aug 2025 08:22:23 -0700
Message-ID: <xmqqo6srrwb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 06, 2025 at 02:18:34PM -0700, Junio C Hamano wrote:
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>> 
>> > Before merging please make sure that the topic can be built on its
>> > own.  Currently all of its commits, including the merge commit the
>> > topic is based on, fail to build because:
>> >
>> >   $ git log --oneline -1
>> >   fc33fe7eff (HEAD) Merge branch 'ps/reflog-migrate-fixes' into ps/remote-rename-fix
>> >   $ make
>> >       CC builtin/reflog.o
>> >   builtin/reflog.c:7:10: fatal error: object-store.h: No such file or directory
>> >       7 | #include "object-store.h"
>> >         |          ^~~~~~~~~~~~~~~~
>> >   compilation terminated.
>> >   make: *** [Makefile:2817: builtin/reflog.o] Error 1
>> 
>> The joy of having too many moving parts X-<.
>> 
>> Thanks for catching.
>
> I guess what I learned is that I'll refrain from building on top of a
> topic that hasn't hit "next" yet from now on. I knew it was a going to
> become a bit painful, but I guess it's even more so than I expected.

As long as the base topic is reasonably stable, having to recreate
the base merge(s---there have been cases where a topic depended on
multiple in-flight topics) and rebasing the existing dependign topic
on top of the updated base was not _too_ painful.  In addition to
rerere, I use machinery to remember and reuse necessary semantic
conflict resolution that was done once (which is used to rebuild
'seen' on top of 'master' a few times every day).

In this particular case, it was me being absent-minded without
realizing the base merge may need merge fixes until SZEDER pointed
out.

Thanks.

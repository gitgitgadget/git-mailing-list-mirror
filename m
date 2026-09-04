Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8DD3E8C65
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548935; cv=none; b=Lj9GRmefk0uRFHvMmFE9/XvA4hn7cK6cLRkhTf9jpliv0zfJut7Tw0Mo3bM9qxTkMQxgw6Ju12Sh1ZOhH9IjH9YrGESk6qUTzoeYtabbNvNralOjXYBM/1yOWvcuPc9WHp8xVL3n1pC5suHwG57G9qRQ+ATn3z2KrFVFxlq6Unk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548935; c=relaxed/simple;
	bh=xOuHkkSzavBFHbPnmmhfoJ5GJ2ebuUuM21iQMx8Dcq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsZCYyqyf+UlXwLzJdXl/X69jW/DRD7hBHNrkemK0qEQKLp36bSpSk4/ybvUQ88GWdwKsc49W3+P7U0r/ZtBCJ6jHrZztTbMEpLvioooHMOp5htdpvO/zO2SjWSYQb9H/bzLFswIOLdkCOwSAlF/Gw0ySIWvH/qdCszho0uakTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jdQm3mD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3etaeJt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jdQm3mD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3etaeJt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3165D1400023;
	Fri,  4 Sep 2026 15:08:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 15:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788548928; x=1788635328; bh=jeHMF6HHcw
	jzRm9nTJ2AjnPAQadWcDJnlEquwh4il5c=; b=jdQm3mD3bK21b4tU0t8cn57me6
	wUKJfqy9hK10MKc4ftyQKWrXQYheOCopcGIcqdDT2ih1d+0VWh/79ZePB2ewEvEB
	5dVM7uklfQRzVU656WmCAbeXokvwJgNe3682LL2YnTjRzs7wAYKBMY233jyP/Hce
	jRrWZ26NH2zxyaWKSPnj/IVDlf/3lUPkprh+YFvvh9oES19gZrN+9qOAvdxeCxm4
	Oj5XK67CJXoVf/f39PBTpPVCCGBRYhcyyLihJFpgMMUOnarS1JGFplQOjj2B+5uo
	vSn5YedPZl5nbVyURwCHQwRbUxaN1GUwTg79sNXK5N8eGfJtk8v5uOSzcdqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788548928; x=1788635328; bh=jeHMF6HHcwjzRm9nTJ2AjnPAQadWcDJnlEq
	uwh4il5c=; b=T3etaeJtgBNemJOKa5vgC/6S/x8Luv3f2XqphIB92x28KbPcAHi
	kDtqEfxkXUBbVmJV/q3r187/6sMhXhS39CsNrqzdc6+v2Oa6DE6y0v6e0NklsdUq
	Vktba6+fobA+jVvd102ye3tx/Ecdfu3UyDT/FNYcqHu/Q1/0x/HBpVHb5T5M/wT8
	N2QwxqYXn7HcCdyqcrupmuWSRY7lA9mqjJmkyBmrg9nPmgU2irG9ulaWmR8t3pl1
	rKw8MNOx4FFgUiYdjrKtO/sCLawZtf2EAXPwFTejyKW6ktZHzSZqwzr2+8KIDvG5
	iKhyG5JDLMhtdhY9MfUU5pxRiJZ+1XAVHJg==
X-ME-Sender: <xms:PxebakIuTBfnhqLpYi3SGwUdnPfoIR4pPMZy30-SJrO2_RavfRwzkQ>
    <xme:PxebatdtxCH9t6t_b7nLvrl4eFl6pqz4hEX-X28UDwsKevCzzpHPQ8fnQB3hmJEyC
    0pTVEEEpPfVmCJ73lrLW-V-G5BZI4xBjc0bzzP82b3QOxi3v3Vqg-k>
X-ME-Received: <xmr:Pxebar-9-_Up22otRwEuTmfNHB3GIEZ8-S1xeFGOVtX3-5rZlIohZTCMV3_cinv6698dFABwwenETgGeupfBCSKVYBp7jFEWOQ>
X-ME-Proxy-Cause: dmFkZTGgEMjES3BsM4ZtE8ELtU50ai2Sk7zSv/jNVFXp8Q/QW4WnPmnsMMFyjzLuK9LYoq
    7waAKzRwWst6nwQxIy31MtsPmrAL7prqSf9Xf96Awn6pC+k7OZ4ORckxRt+gVSJ8BB2rSS
    JIDQLC2jy/XWHjQhsPl+6U5PL6qnL2mKAMkQaGoPaY5hpvwWeXOW7XgvyNJ/6M4Y5HnByi
    +RBlkJdgWwVOuIqYrvRw1Gd3PveK6uVrSLmb5Kwc62YK9FzR2yqvKP2EYd/ZigabL8uRoN
    RPWeMGBtcm+Buc+NxpHBK4uq9ocy9Jm7sN4/ScpedNxbCOIL5r/J0Ra3KatmZhStbFHhPM
    t5NVktXZ2upDpS9NWLroPuYwe3S+THxnVPX9wHjMD+7YYIjcQYl8PRp7SXFkcgybLK0pn8
    4u1puzQtprPOHABcQ9630tweFOkMGLXaMHmdCw04yAHtJgCV6jc/5ZP3velhpDEY/sFh5g
    L/GY6HX6sUe9Hy199PX/81tKKJ6qsVrOk3pAx7i6ZZ5Q2eJWe0M2Atyo91e03KTmArT7G2
    G/MKb5UGL9JedhWKV/SAwnb9lBpWPrlGopi9sYDshJMIaceBORXzU698I+tnkMLitVbEMv
    iKaDq4zKjjQFM28hgRGYSVMaYpKFrCD51eKOUqbzNNDKhVk28RVWiKuUjjqA
X-ME-Proxy: <xmx:PxebaiqD7QWFHPqy_0reStjC_DhH4NkitWvjl0XNyS8Cx-kd7BnW6A>
    <xmx:PxebaoALuU7oNzirCZRxOpYHyd7WcHco8wQFsM9fqq-LJUqCINp_iw>
    <xmx:Pxebaszp7F1a4NehR01xuEl6pAL0IukbM6XVxfqxdIaOJID57EUR9A>
    <xmx:Pxebat2vQDOlFz6n3XiM3dcBf6R6Xaxmk5SdLzhJ4zdzLakw2YOOLQ>
    <xmx:QBebaqE9LcDqH2LC8j7bbnjo5Ja47oC_xRnCX_OsJxb-52KWaYjLl_k->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 15:08:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v3] rerere: keep a background gc from killing a rebase
In-Reply-To: <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com> (Thomas
	Bachem via GitGitGadget's message of "Fri, 04 Sep 2026 15:51:21
	+0000")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 12:08:45 -0700
Message-ID: <xmqq4ig44ywy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com> writes:

> semantics of core.packedRefsTimeout, then warn and go on without
> rerere: a lost recording or replay is nothing next to a rebase that
> cannot continue.

I do not understand the logic at the latter half of the above
sentence.  During a rebase, any and all opportunity to reuse a
conflict resolution you made earlier is preferrable.

I would be fine if "we cannot grab the lock so let's skip without
doing 'rerere gc' at all".  But if a conflicted step in rebase that
stops and leaves conflicts in the working tree fails to record the
preimage of a conflicted path, and makes the user realize that was
what happened only after the user spends significant amount of work
to resolve the conflicts and the resolution is not added to the
rerere database, that is a huge loss.

Perhaps it is just the way the above three lines is stated and what
the code actually does may not be problematic, but I am not sure if
that is what the latter half of the above sentence is trying to say.

Thanks.

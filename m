Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5406659B53
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368670; cv=none; b=c+xA5iaTPmogFVltcMJ9Qz804oLY+3CXSkjO8z5lkvqo3F9NZln1+aX2idrfBSNZFBV4olA9xbwHj05rWmQQnbEFbZHts+S8S0mhgQTN0QC1jafz6jyprdtDrnn0kkMW+9qlfKecq5OOsIc4inVpTBfvXzCpuv/VEUdvrn8XJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368670; c=relaxed/simple;
	bh=Uv37NNeWGMPt1a60L/Jin3LGVUIwb/CE/iLGkBU5EuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=hFYCMIrKJSkh8xRZnQhRdv/i6pzjPNS7FmDPup4fGuUBP1MPa0503FycFds5RqORzDjHaH1UjROsLQ5K7GMg8dohejS0wSi1h5tkvi8Cu5430u+GByAo+MSD+YXHUvSjLT3HYjfIL1bn4KNCZBsD3qJ+sHLx1dMR9V96vW68s6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=ZrJRUUSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZUbm7dvn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="ZrJRUUSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZUbm7dvn"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 64D4A138010D;
	Wed, 13 Mar 2024 18:24:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 13 Mar 2024 18:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1710368667;
	 x=1710455067; bh=Q+YhA2w33YSaB04FMV5+TEs4XXXziCSS2dQsWvRhHD4=; b=
	ZrJRUUSdYb1S01uIUfaMi6fLdV/pt+mfhCMY43KoH05D+n8sjir0aQ+4T9hmCXsC
	tJr6t+yviUeD/ttOcSIFgxqhkcAbirBwdgV2I8h01Qu/0MiBF7m0Pn2xSjFYOtY5
	xaccNc7MKdBejekgyAe3uHUMy3iK/+2gZ+b+quXisQf7g8gL7QmNhvGQEOhzPs6s
	fz4nVhnQavQZ3yUiIx9nz51KZCsvTN/lr/AV+WluECmafshwsBC1ZGGyDMynxmnL
	0WZMBoGPIv8BQeYHzV2fx05D/P/rbG5EQ8f7ay6xsv5UNS36jiZaTYMaGeZI1v9g
	m9/OAL3yUbqxiaabWNYNcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710368667; x=
	1710455067; bh=Q+YhA2w33YSaB04FMV5+TEs4XXXziCSS2dQsWvRhHD4=; b=Z
	Ubm7dvn9ZcO2oL3tmZLBCyunacY7eT425KDdPTUkRrTIZJ3J45XCT7eplNU2Bi4f
	s0xqdrlje8fmR4ff/l4aViO+V418/Lxy3HXsVS4bubioNlHIjOXllqzI+d+/DhBv
	8bTq7Oj4Ck5iMftjUxIU1xQ03+zhYWPbIsXWoDXslX3JDrCoipND8IavSokVYd6Z
	fXEhM+a7RNlkxUv58FMJnSXYsg7g6cL6+81RfQ/Ombwjha+n+8gxvzRJQt8scVqX
	Lw67a4U+CdOI6j3ohWzhXdzL5+ZoRzGLs7Ab1vhxqFFU+twtUoKXxWhgoZyniyHK
	5QJoQrWhakkEir5e82qTQ==
X-ME-Sender: <xms:myfyZZ6OhzWVYiSWwf8oHgMVrMl-HyLf5YaJrjy_-reRx6-BeCjcVg>
    <xme:myfyZW7Jd1oDEGN7JQ6duqO92hSU1COZdfrj3VY0GktmCFGyysR-GzBZ2gCD3LZ38
    lMVJyzHj5ifVCZvEA>
X-ME-Received: <xmr:myfyZQfwwTBCZAdW0P3P-chaS8pFoKvoVX9erjipd2UvdqiacoYaiRjwXkg4D8iHJYgj4bozG2phfS0FRX65UPAFvdtBPWUVWDrxUTaJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehgdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpegggfgtfffkhffvvefuofhfjgesth
    hqredtredtjeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghm
    vghslhhiuhdrihhoqeenucggtffrrghtthgvrhhnpeeffefgudevgeefudevveevkeeiff
    fhteffueekffffhfegleeukeeiffehtdevffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:myfyZSLpkJ1DdC_rUy--ypBkAQJtnJx8g85vvBesgM4PeTYZmLNRiQ>
    <xmx:myfyZdKTw-ueDvI4AagLb0-4khwycJh6s_PWQpru55uIZ0rewPe30Q>
    <xmx:myfyZbw4k_vOA1DyIaUnmLwmC9O0lSlA04w5Ch3pPKQGrB-5gxjFuQ>
    <xmx:myfyZZKhlSpQEtC_0PV_lQKKGVKELG-O0P-n0LED3edrK6Xa8UIuKA>
    <xmx:myfyZd15C7t9NjaejsUQ9FBD4WkOF8je0N3W5oVGytHlQA8779N8gA>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 18:24:25 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 09:24:22 +1100
Message-Id: <CZSZ38DTWF14.3BNXFKTGVPLZQ@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] log: make the --oneline option work with -L
X-Mailer: aerc 0.17.0
References: <20240313090841.36717-1-james@jamesliu.io>
 <xmqqr0geca36.fsf@gitster.g>
In-Reply-To: <xmqqr0geca36.fsf@gitster.g>

On Thu Mar 14, 2024 at 4:31 AM AEDT, Junio C Hamano wrote:
> James Liu <james@jamesliu.io> writes:
>
> > However, when --oneline is used in combination with -L, Git actually
> > outputs the single line commit information _as well_ as the full diff.
> > For example:
> >
> >         git log --oneline -L 660:Documentation/MyFirstObjectWalk.txt
> >
> > will incorrectly display the diffs too.
>
> Why is it incorrect?
>
>  * "git log" takes options to tweak formatting of the commit log,
>    options to tweak what commits are chosen, and options to tweak
>    how the diff are shown.
>
>  * "--oneline" tweaks how the log message gets shown.  Others in the
>    family are --pretty=3Dfuller, --format=3D'%h %s', etc.
>
>  * "-L" tweaks how the diff gets shown (e.g. limits which part of
>    the diff is shown) and what commits are shown (e.g. limits to
>    commits that touch the specified area).

I suppose it isn't intuitive to me which options affect how the commits
are presented, and which affect the diffs. The help entry for -L states
that it will "Trace the evolution of the line range", which doesn't
immediately suggest that it tweaks how the log message is shown. As a
user of this option, I'm more interested in using it as a filter for how
commits are chosen.

-S feels like a similar option to -L, but will omit the diff when used
with --oneline. I think I was probably experimenting with "--oneline -S"
and then was surprised to see diffs after trying "--oneline -L".


Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182F15DBBA
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743400804; cv=none; b=Qxr7gPP9SfAUPSDJQBtsNlkiZbcZR1nowl6xe8xuzwRQoEwfh05W6sP7GqjDnBq8SNc4La7U/QmtIL2+caXyxsylUX19Ycr1QffDTKza9PJOIh81r0QFPPIbCrmHv+551J1XUvYUiCcUUT7F2uRpy9G/WVj5+2qBtpuNXLubADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743400804; c=relaxed/simple;
	bh=wkmZl2v1NRm/u5hFHsdhZxnst9wHETivLZsMLeEasZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBlJmOISEwheMF2j62ZZFjlaTs8h7zMNcC5K3CWaHxgXvevbtjiBaAQi10fUP3v19M+j5GS6B4MkNQi5cRc/wIbMDhuiCq7TJW7oepIILDJkLgPDe52DKMYxTZLt4pZMxsFXDmoAqK87Hp7j86R3wuo8K2q1vj/eCeSZU2IjkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJioomCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRS9uBki; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJioomCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRS9uBki"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 94B15138435B;
	Mon, 31 Mar 2025 02:00:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743400800; x=1743487200; bh=a0UdZmlVkB
	i/rCM5MJNXfAIDoYFcUUsQEXHnJGNgqiM=; b=gJioomCq44PlJk59Ou0RqsIUd7
	H5MFeNPnCw/4eO7z6MVe/6sW11MUES/x3oTqYYEZ1z/zBbnWIe9XyMZBp08yqXE1
	QgKJF0qQMhQi/8gYCw7yH8kHstIeDMHB0mUnMC9U1Cye01RiJ2uRHuzBHaa5aDVv
	dNHJbdyQh/UsM8AuDgtRLvZGa4rmYiDyqwFgNTwQeJTMXTyAy2g+/7lo5RZQsPQt
	T6/OJBP/3gaNYLIYvYPvXEFIFDLacAv1Ehi3WucJRrtGNZycrkqeyio+HAhvx4X4
	1+FUaa/aSRBcRtZoFsSOIonL7LetaG3OF4WBfuS2p1VfRclbwithinvhfjeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743400800; x=1743487200; bh=a0UdZmlVkBi/rCM5MJNXfAIDoYFcUUsQEXH
	nJGNgqiM=; b=LRS9uBkiITQSTFXcHvqBTzrWhRrBuimgnBSefNlBmcrOYSQzARU
	RkMa/dv8cEbM6dFHQajiFngnriTGTGv58UEr4IrambbqW/sqH2zJbaBct30lK6OO
	VS5SFCAM6C8zWQKJyZfDF2I0BiLtkmJjS44MG2iz/O0iaPqwfSsoXVLmd7POQfTh
	Woys0JJPV9ErbL2sWoAYnpCcC9D46prozZ00cfeFrNTnJWJBTqwflC6vpcrY2w2z
	GqO/wtHPDknvLUK7tb66k+7vbitYo2Dj9uiOueHW1rZVBeXKJK12Gz7uRo6mKzHz
	XcuMwjJJMadMspxiImtEptQxq1JMzJJV+NA==
X-ME-Sender: <xms:YC_qZ47Z9kGB2-DLDtqDhq5odtfh7e9hVOa_rhqRWGVnMznI795ACA>
    <xme:YC_qZ55Rbtg_vkRDWtNMGtRW7OYpFuiTyp8t_WY9jNS1q2-mFYHBjOvkCtHVniuJy
    8BjnmI5oVCZ5_9DCg>
X-ME-Received: <xmr:YC_qZ3cMVX2bYm7zH3a5-t2y7E-rYQGP2v3N255mtqMybR3H4S08bOVuZtxZeAfMWJ5yFpVzyIs9FsWpJJIO7C-ZNYEG5pP9OZu1Z0ha2Luco5-O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghn
    nhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehtghesuggvsghirghnrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YC_qZ9KkALukaAx6aA4_M3ZqGBytOcwtspOl0gVLa6DUarqo7A4QMQ>
    <xmx:YC_qZ8KdNn1_iGXDC3XuxB4ApLf-PbJaBOE1r-PDlpMCygwI3bcKZA>
    <xmx:YC_qZ-wTvI2uwFivboZhRDpxgx9w8ohGbERa-virx03rxQk35AFI6A>
    <xmx:YC_qZwIVKMttDN8HYimr12VmJGnyDsuawrrCaov2UJUC6d8Ke2N8Mw>
    <xmx:YC_qZ0--JS3qucud1GizxG3TD1EUvjexMawe4QoHdRBv5pHvi3rLUGnc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 01:59:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa4d45aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 05:59:57 +0000 (UTC)
Date: Mon, 31 Mar 2025 07:59:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Thorsten Glaser <tg@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] meson: require Perl when building docs
Message-ID: <Z-ovV-9dlXafhJtX@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
 <20250328-b4-pks-collect-build-fixes-v1-3-ead9deda3fbc@pks.im>
 <xmqqwmc7d8ki.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwmc7d8ki.fsf@gitster.g>

On Sat, Mar 29, 2025 at 10:56:45AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > From: Eli Schwartz <eschwartz@gentoo.org>
> >
> > When building our documentation we require Perl to generate the list of
> > commands via "cmd-list.perl". Having a Perl interpreter available is
> > thus mandatory when building documentation, but Meson does not enforce
> > this prerequisite. Thus, when all optional features that depend on Perl
> > are disabled, we won't look up the Perl interpreter, which will in the
> > end lead to an error at setup time:
> >
> > ```
> > $ meson setup builddir/ -Ddocs=man -Dperl=disabled -Dtests=false
> > [...]
> > Documentation/meson.build:308:22: ERROR: Tried to use not-found external program in "command"
> > ```
> >
> > There is already a list of other cases where we do need the Perl
> > interpreter. Building documentation should be one of those cases, but
> > is missing from the list. Add it to fix the issue.
> >
> > Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> > Commit-message-edited-by: Patrick Steinhardt <ps@pks.im>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Two puzzling things.
> 
>  * How is this different from 7c8cd9c1 (meson: fix perl detection
>    when docs are enabled, but perl bindings aren't, 2025-03-16)?
> 
>  * This uses get_options('docs'); shouldn't it be
>    get_option('docs')?  With that changed, the patch becomes
>    identical to the patch from May 16th, but the proposed log
>    message seems to be vastly different.

Oh, yeah. I did try to double-check that the topic didn't yet end up in
'seen' or 'next', but I obviously failed.

> I'll drop this step from the series for now, as the other one
> already has been in 'next'.

Yup, makes sense, thanks!

Patrick

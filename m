Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F518FC8C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525403; cv=none; b=PxOC5dfy2iYgTOQzWIVxcH1kE5OUbrEMNarU6v2EjpUcrBkk8P0haca7L5UxP8whtVwnVl2GJPWz745akxhIYWBBiyX/MwOM7FQnkyTS+kc9/7QAaZfxGKME6jDOxZJv5rG2JUPaSFbme1QzXvvoUEBIVIUY5bKAIdZZsjJ4PDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525403; c=relaxed/simple;
	bh=ym50LGG5OqF7x7975NoYPK+2+M47Em2K6+2wXjHy+vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbIqjak5wEZA74+u05amvZ0OkP7ySz14Dv4r4LqELe8BCEkv429sdOs/Hs7lqPCtswFUoRC75F1opQyem+8Im7rsdp59bxxvsNlRQot9FKrN50Q3oXlFCS+lxuA2pQMGKmmyTNESzbEdBuIqTWOxBo/zSdIc4DT96GPkaxiY2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XK/33CFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4joNi2Fl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XK/33CFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4joNi2Fl"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D6CB511400CA;
	Mon, 25 Nov 2024 04:03:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 25 Nov 2024 04:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732525397; x=1732611797; bh=QhzqEkrC1/
	+t7ZCEFFqaRLZ17LYs2MXYcv6VUoySw78=; b=XK/33CFkGmUZj3dpN/XkHIZsF9
	4Sf4cdz8wO6QnJcfP6KXrsBijhUHUNy5EED20EVZyG3cSVgN1nV4N+V7cuRVbiDq
	v/ibY30zesNHCpNquBdUGxUbMY/r3IdXIvfezalA1PtOZR5fo/nKeCKISBFv13CX
	gqWzzWW2cvA0nslmkHMiyISi5N4V6SUbFzHZBuSVM1XkyiVYvhvKfqzHrutDzh6/
	fvRFWs9Kjo0XWKcbX+ssFVbJ/P8UDWdVv/8F7aCigpgKedWj0PlHwPMtSyiqFqCK
	zksJ0aOEAr1mUx4BKkfLaadDaGGSGmD9NnYubtVXHztnJQoAnpTHQ3P+v+EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732525397; x=1732611797; bh=QhzqEkrC1/+t7ZCEFFqaRLZ17LYs2MXYcv6
	VUoySw78=; b=4joNi2FlCNYrtqr1Z9htrVM770ShQEZMK4FXWxw9kJ9wewLxgTm
	s4+Ep3gvSHL8RAEbmwDgPaZuAhNPvsDAG4lfjNYoBRp/QuQmtnae4cZHgo6bcTST
	OCttrgtpH893tUvJJzM2FvuVkJ/ja0HAKYqHS3N7TjcXKHttOy8i9OgT93qlsDND
	OcVJ2Xgupmdf0FX0iPIBxVBbvX02IhRWAJKfJtnQjHvmvhKS6ScHS8O5bwsKTxe/
	GodeEv41IWptLjTj/58GdJbd0BsWSsouKdbp7XxJscaXjKtqAxLXUgwM87lgmluV
	hGY14grySpQfsgotiklyd6g29O0+Y3pDMoA==
X-ME-Sender: <xms:VD1EZ5RhwtcGTAMYuKId2_EXBQEaahRpLVKrMla5mrMzd3V1zfR9Rw>
    <xme:VD1EZyyg1BXPapdCIeXE40_-VnUXJ71I55W4S07XH285rXiG3iY8U0j9Sam7BDqPC
    Zd-EOBfUgXtWw9RCw>
X-ME-Received: <xmr:VD1EZ-0SYBsqQTWFHiv9XZuBWllXPAjHYju_tLjuPSMnowkF2QWBviPiESv2HyKOtZIKyp7FmfZsDnYZg1TBsaT1mIU6A9RYTnKkwxDV6kkwFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VD1EZxBpSDbD3BMipFipuIF7CRz2O93ZrMBOvNfhp4vTrLOzDBYwLw>
    <xmx:VD1EZyjgPCKKqYdy5SLWpNp2vGbJtJOW6_-HgBu0y5kEtn2bTgwqEQ>
    <xmx:VD1EZ1r9FRuCPvmzhtqROzMHT2gc3XaPMrKIpMmBaxUi-Hr9SsMKZQ>
    <xmx:VD1EZ9hMkVdPRgL6U_AfXVv57Qli50E_ZFl6LgcbSuI3_wsLIX02MQ>
    <xmx:VT1EZ3bMu03cvk3h6U-BeTlpWma61t9cqwE8MtmyhL5rhl4LGKxRaSbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:03:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78a5cbee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:02:12 +0000 (UTC)
Date: Mon, 25 Nov 2024 10:03:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/23] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <Z0Q9RTAbs6tc7LN4@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
 <20241119-pks-meson-v8-3-809bf7f042f3@pks.im>
 <xmqqjzcy7ehv.fsf@gitster.g>
 <Zz2vkNtvoKayaZyT@pks.im>
 <xmqqfrnlh2qh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfrnlh2qh.fsf@gitster.g>

On Thu, Nov 21, 2024 at 09:03:50AM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Yeah, being consistent would be nice indeed. But for now I'd prefer to
> > keep this as-is because we'd otherwise change the version schema used by
> > CMake builds. In theory we can use 4 numbers here, too, where the fourth
> > number would correspond to the `PROJECT_VERSION_TWEAK` CMake variable.
> 
> As I only write vX,Y,Z with three numbers, any fourth number a build
> system comes up with has no bit of information.  So we could consider
> what we use is 3-number scheme, and supply a fixed and meaningless '0'
> to whoever wants the fourth number.
> 
> Which is essentially what you are doing with the "split $(echo $V 0 0 0 0)
> with 'read A B C D' construct" ;-)  I am fine with that as long as
> we have a shared understanding documented somewhere.

Yes and no. All of our official releases use three version numbers, that
much is true. But our development builds use four numbers, e.g.:

    2.47.0.280.g199a5082df1.dirty

The fourth number corresponds to the number of patches applied since the
last release, and this is what we use in the context of "git.rc".

I'll add a comment to GIT-VERSION-GEN to explain this.

Patrick

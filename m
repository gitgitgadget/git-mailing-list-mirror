Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10815DBB3
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647463; cv=none; b=d2k07jDhph1rMAzRikSR1Yr0vjBi49U5E0Jm5HX55kdm+fgYkUSTaWoNTVXYefPFYgQCTK2L8ib7pGvN3cbWtHPIar4fcmJEDesGtUprp5uc8kpXH/ytffw0FTXSUW2GdokcGu36jibOavtAaxzJuaCONrJEa1dNgLZ0AHMZdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647463; c=relaxed/simple;
	bh=fcknkpZDnsUGbb1c2jJ9FWrwrdJNAs+0qHXwCeV6sUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9TIb9VZllFsDoHnuHnmrntAuBwsIUf9vkbYPyFyFmvCZoX43gR+H8lKKZp2dMmkX3BA87Qi7yHad03PB4zyO45qevvZ0E82jIzdD9OSMqa2TTiqAVTi5NJFg0j3fN+2U2aVTmDxuo2snGn4vPFvb19jzWfSKHyUfosnTct6Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BcbmZD5n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sr+viWeS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BcbmZD5n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sr+viWeS"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30C3E2540217;
	Thu, 27 Feb 2025 04:10:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 27 Feb 2025 04:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740647459; x=1740733859; bh=Bftt+Ui3Wc
	uPBxZ5DWV0OjOY0dmJa2eLvslEJijdkDY=; b=BcbmZD5nQqKpDAflXG2evWa3o2
	AWSyP2UYsUndCbnDDsFQTdVdFTybnUmVkd3ouRYToyxQGR+zf3pfOsjrlU1aOVD4
	DqYiLEs8Sh+rUw/k8xtO0SQuRb82mfRtxuhkh817gIQbNvyhmxqBtIuS2hHgNsaW
	YJEK/CTTtvEdqN/ve3dlHBoUoxcdCja4CcuPyI9o2ENePPVk4NSDUvmTEquB2LAd
	vhbvtjchvIYLn0FvuyxSMg47HEMJnu3dq/Q9JBzQ74wkjYTpmt821xOVjMf8PWl1
	T+V3k5F7Trg7An+stoVLzAmzxatQvsCXrijdysKqzrS0fOoBMxuBE6BRZXPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740647459; x=1740733859; bh=Bftt+Ui3WcuPBxZ5DWV0OjOY0dmJa2eLvsl
	EJijdkDY=; b=sr+viWeSAigCP5NKTVaWP8QBedbyeJiY+mlmQYcmkZLq1/7J13p
	aVXYPTtXVVCr4tJv9YZv7K3sl7iu56tnlaaDY8TkRERpa3ob8Z8K171zNM/cvZi4
	KkdC88UfSglNHPtY5uPsrtvSYPbEcrRYMwxlkWk1kQ3Oix0FgffoO7HXFkynyIJf
	wbdvfQb/kKysvue+8rAts5qqVzBjZmel+1wRnnWVPJQZoUFj95Cq4f95/8O5lsQT
	1K1cFtHuE2iFvia9MS3MSTkxPKfRytg9WZ5sFKPD22+Iwke+LIqydXhx8Jabwvq6
	OBNFs/F7ASI50c3Ksayn+/ER+Rc+cnw751g==
X-ME-Sender: <xms:IizAZ-AOWuQdhIbjYBT2Mx2EtI3rLQwudacP_eeB01KaEcJlZuqtGg>
    <xme:IizAZ4ixK2InXwQtqQ0sGKhltH1g4RcrAqYjqMrT09V3dbK2uRdevO0FZYAfbPx7V
    EokkAeeFMlo-I6tXQ>
X-ME-Received: <xmr:IizAZxkf257yPJlouwiGCyaAfsTSCsOFhkr-D0moyT1erQyRaA-WkbfwXVh1FqLEgdOiPObkpAck9IG0DLT-5DmWmSvDT-Jc49k8X669Q6bx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IizAZ8wfLB8jxidRJIxRD-9GFCow_caiJ1r89TxLt8XTt6gBBJJ_yg>
    <xmx:IizAZzSWrl4roacPsIIkM8cBBVHaJRSLBgWj2xWuqPgKaRRpzEkcFg>
    <xmx:IizAZ3ZIHzzdSpupc-fc1sbmPROEqOOAv3_XcIoCigCxdrKYkKM5Iw>
    <xmx:IizAZ8Rv0Ufhw2UZTlqe_VTuPNyFgQxG9hqyc_ttELl_WZxD0zkoMA>
    <xmx:IyzAZ0JHf1-cVk9MUyAxv_HMgLsWzQQO8Zq0_43Ej9SZu4GDg7XACDXz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:10:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01d8b9a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Feb 2025 09:10:54 +0000 (UTC)
Date: Thu, 27 Feb 2025 10:10:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Markus Gerstel <2025@uxp.de>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
Message-ID: <Z8AsGdPqDVXpqkhR@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <543e1914-d05c-4053-916d-e8286edecf50@ramsayjones.plus.com>
 <xmqqtt8gbldf.fsf@gitster.g>
 <5ecea6cc-0702-47a7-91de-14aa06757d27@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecea6cc-0702-47a7-91de-14aa06757d27@ramsayjones.plus.com>

On Wed, Feb 26, 2025 at 06:54:48PM +0000, Ramsay Jones wrote:
> On 26/02/2025 18:40, Junio C Hamano wrote:
> > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > 
> >> Hmm, I don't know what you have in mind, but just as a data-point, I have
> >> never used, and have no inclination to use, git-maintenance. However, I do
> >> use git-gc extensively: at least once (times the number of repos fetched
> >> which have changes) per day, pretty much every day! :)
> > 
> > That makes two of us, but everybody knows that we are old fashioned ;-)
> 
> true, very true. :)

Well, it depends on what you mean by "use". In fact, both of you use it
implicitly assuming that you use a recent version of Git because that is
what Git nowadays spawns automatically: we don't use `git gc --auto`
anymore, but instead use `git maintenance run --auto`. It _does_ still
use git-gc(1) under the hood by default, but that is something we can
change going forward.

The opportunity here is to have a more fine-grained strategy to perform
maintenance, both when run explicitly but also when run automatically by
Git. git-maintenance(1) is written in a way that makes it significantly
more flexible overall, so we can iterate on how exactly it performs the
maintenance for the user. Different strategies may make sense in some
contexts, but not in others, and that is something we can account for
here.

It also allows us to bring newer features to the masses that have a
chance to improve performance or reduce the time spent maintaining
repositories for everyone: multi-pack indices, split commit graphs,
geometric repacking, incremental bitmaps.

While we could move them into git-gc(1), I think that this tool is just
not well-suited for such changes as it simply doesn't provide a good
foundation for tweakable behaviour.

Patrick

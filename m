Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576B12262B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530448; cv=none; b=SId3dfQ55NKd1dvkTC1lrdEbAlIoUk2pibDqBgPxa7Hjv6aR7Bw7xMxNXFQ9yeDjOVM1FxORH7bqVx9drJiCCRbGS2xGURwH2QhR9nylXYXeNDah4WaOk7kEj21nk3YjBYs/BzX51YJBkTm9MQ7CyUxsvPiWIlKjnYTjFqc92k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530448; c=relaxed/simple;
	bh=+5OfFe7kiGKXF5vu5svNoVJI6NpJ827olzE2Mnn+C5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQZoS2NsaCNSfJ7HE1l1MvQ5ratHN4Lih9Hy78EsqeDNrM+kcGZ7BqMfDMw4lo/fhDMSmM0FQLEmGBcqBhFoOUgJdq+VnqFsxFKuxs8NH0TaUQQ11U1y6s8NpcoL75BwGrFIWo4DdbztgNZvfjk3WV/Ox3cUrDUx5ueZlPmkZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bzC8fS4V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6qv8k1f; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bzC8fS4V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6qv8k1f"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 616B9138FD52;
	Tue, 13 Aug 2024 02:27:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 02:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530446; x=1723616846; bh=/OnkD08cyJ
	8JGH8bCcUyHNkwu7bBt8pIf5xth6X38Ko=; b=bzC8fS4VWRjaMKF3I0e52xi1V3
	T8ZfK6g+UtYZOMyeuL9rKUBNgRjizT9uaOiKOVSdak5HjTQifnA94XNtCvP6qv5x
	0+4e2wyJV0V6dj0XqOj7gT8c3yQ6pVyFbZjKzONYU6RR6b6Ien9sv41871VsJ3c3
	7Yqku/VNuzlAfV9lD2YgEmI5QFv69H1f/sSc0Is08vT22oJ72f2tzK+35ZBS2Qf+
	Irc/2YAs8WK/+uW1xQlIWWkcyHJt6EEqpOJsCjvJpJeDkzrdgGMbGc3GNJp+Jim4
	2etVPa3vam5W6frEVFzXkXtWln4ep/kfl/IEL09sjTjfSUjOTARfeWvJ1Lkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530446; x=1723616846; bh=/OnkD08cyJ8JGH8bCcUyHNkwu7bB
	t8pIf5xth6X38Ko=; b=b6qv8k1fTs9qsD+SpoMHCxpr9LOp4YMAmzz7ZWRk761A
	Q41XAM6L7IsHMPPVVJt7BcxZyLyfbhmC/4laK73ij/8wKwGfRQaTdcmwfrLtmkUG
	fSt9eDdSRlCadH5qM0moT+r/zccnG1PMMRl1Vo0m11Raiz5U4z9v64sxu9YG5l9B
	xLI5n3GZOoq7WaL1VHgyC/8id29OWM4I1OPh0DQlx6U21KBWKzDv/7zw6IBvebq1
	7CDjjSmDc0Rirx4H6j5rf4CXLaa1lDUShqjemOEI+lJbQSloyxBIj+Aj2NHmaRlF
	UnMPhOsGBReeHiHPnX2MOAapvsU7CuTvbTx+JCserg==
X-ME-Sender: <xms:zvy6Zs2t2DZwz7z9XYjgusIGQ8LhtbCG8XTVqQBDOd8QC95nA8KXkw>
    <xme:zvy6ZnFKWk0lFnKaUMKVwb5N_c21AbG5adaT8TULtix9cykc5ChJPJOrwIO5RIDrt
    fbSBVhKx47MDx_Jpg>
X-ME-Received: <xmr:zvy6Zk6Q36NcAZQ0Oj2yuqB6k6mvlpA1k3hTbWSipdGddYkgYNfhZD9dhr8V5K5S8TWvXa2ltVvq7TtqJdGjsPkt0PLJRjIg4ZiYJVK6bE_MWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghs
    lhhiuhdrihho
X-ME-Proxy: <xmx:zvy6Zl3xoZKxxagpjzjK9YpbHRRXZNCQd6_USLo2vDYq7FgRwN58Eg>
    <xmx:zvy6ZvEWzVGY__v-NoItJEmxiF0eeCH1ta_QaD7Ve-FfiAphDa2kCA>
    <xmx:zvy6Zu_mAbwZ3kqfBFOEF4p5eKF93vxu0ZNvPcwWdGQiDAOX3Mp3XA>
    <xmx:zvy6ZkmfO1twL_ACYz2n7MzsUoJitZ4Lk2DX-IRPRM0xXIciFly3Ow>
    <xmx:zvy6ZgM0CsPl-knFklw3Uq1qMDaqujTy62iuVuucIKtOcFomydBD_dMH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 02:27:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3677be8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 06:27:08 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:27:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: karthik nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	James Liu <james@jamesliu.io>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.4)
Message-ID: <Zrr8wmYpY02lM19k@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
 <CAOLa=ZSCLZU=eeBqx9cpHkUJ+SOHXToVwMKjmCKLc+54MfxdRQ@mail.gmail.com>
 <xmqqbk1x7nbs.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk1x7nbs.fsf@gitster.g>

On Mon, Aug 12, 2024 at 08:49:59AM -0700, Junio C Hamano wrote:
> karthik nayak <karthik.188@gmail.com> writes:
> 
> > I went through the series and apart from some typos, everything looked
> > great. I don't expect a reroll for those typos though, since they're
> > minor.
> 
> Thanks for a review.  A final reroll that shows only the typofixes
> in interdiff/range-diff is not a huge burden, but having to deal
> with many separate "here is a typo", "here is another typo" patches
> over a period is annoying and it is even worse that many readers
> have to get their reading distracted when seeing these leftover
> typoes, and get annoyed but yet not annoyed seriously enough to send
> these typofix patches to leave them unfixed to cause other readers'
> reading hiccupped.  Let's always remember that there are 100x more
> readers than those of us who write.

Clue taken, I'll finally bite the bullet and set up spell correction in
my editor. I'll also reroll this series later today.

Patrick

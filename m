Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A429BD89
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357628; cv=none; b=DqTYn6g2S9hNL7CJgrgicTXeyEnFP+rTU12dWRa3wQNXdYpgyMe2S78J0OrVgdHsb6Pm7XQkrcao+uyKXchIEpWUMYYQhcWBWXrUD19q4Udp/wc0VinEIGEq8jXGVTgoyfYwnfW2ouKiryR5qaSgcZQhVqIY7rLevLp/1wrzrnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357628; c=relaxed/simple;
	bh=PBaXiQlpq/+dm3caR0xx+fJEYcafYthU8Xu9rVA+GyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldJZ0sPhOBN5nhJNISDJpxhgjcwOIJzmPvk80/u6SSmzjmf5MokgAPS12fM2AC2VPM8BdcO2FsEmue5L97WoKzTtQK/B4Gfqtq4z6mypO+snQP68ikz5R5MS+GXrAAp8Zz66zXDyf7YrBiEb1SIQJd3NlC02djuQGARShx/uF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BjvC6Y5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ctloa/Dw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BjvC6Y5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ctloa/Dw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5A7F51D00118;
	Wed,  1 Oct 2025 18:27:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 01 Oct 2025 18:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759357625; x=1759444025; bh=FcW0Lj3OoO
	QPKIQ8Ba/kzVDa5/RyC2qU8dsn+2JOPSs=; b=BjvC6Y5cFoJLt2NsowqiAo3yjF
	4T72ocncEzh0UNM13ijjs8/U1pCWGxNVZg/mg4VGwhx+LkCoaVTcfQm7ogzYVuao
	Ydv8yYHT3GB6nz8W6UZ6j9KXZejjCuCMLBkpML5EKfmSBSPcipZbyFglhpZDk7wX
	KJSj+5jRM2r3/PyizGv6ZyhwpfLYo5/daiCT9AaP2Sv881V3NXTtPSXJ3Efzz/Cs
	7QQMHDNxoTVrBsyO+yIADSzf0vJuf8O92QDlw9OeN9m0dFWDUCmvg0PbkMTb3nxO
	whtwCpLhXQqldC3ms+9quHZLajRFjH/qFu1hsiz9rtNTwRw8NmsdCewgrV5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759357625; x=1759444025; bh=FcW0Lj3OoOQPKIQ8Ba/kzVDa5/RyC2qU8ds
	n+2JOPSs=; b=Ctloa/DwJsi8hZ9MLJnwGt/AITsaqX4PwqN4GreaVmcEyVxYto9
	u9ko6IRb7hHHaxJHb2w+MUOIjW1PKP6CMWfablcaIjIjVyhOpj8oMIUzeZ0rHOrJ
	1o/ZK8+i83sfv3/cBt3LLO2S3IwdrMTQybXbXBKDPZDxos5j5U7SJdELj/naV0El
	A2PX9YAbWhooU1LJyKqQF8wvrNl9kT6B6qZnk0U6v88eOOFoI+IZgg679/67oRV+
	OIvRtmQ5Ez+5xG0FVQC71eff3aCNdp3K0xcd7ySVp5wn/9Xiyj+ixrrrQo/AYyW9
	roDd+OqQt+c6svlL5ZMg2BuHYeULLE+akrw==
X-ME-Sender: <xms:uKrdaCl4411Bx5kp8GHNenhQGPvRsPZHVSd0s2Z1okMtL0SoXtX8MA>
    <xme:uKrdaI76AzoObW4JF38Gs92oexHYpydf1Rs7MVykB34Dt2aAjaD_kSPJHJS5YD8GZ
    7qHAN7kriTvLhQuhfEGigyAaUv49nz6pjw7nxlb2rnWEti0tpzH_Q>
X-ME-Received: <xmr:uKrdaG0AQvmSd67Ka_BRaHA0WYEfHBfp8RtuchwKuYhnDeKI2L292dPHMe-dJUPWrYplMC0yZcDnlkQqdb7VnIvq2LN9C35C1DP7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhsuhgthhgrnh
    gvkhesshhushgvrdguvgdprhgtphhtthhopehjrghsohhnuddutghhohgtrgesphhrohht
    ohhnrdhmvgdprhgtphhtthhopehjtghusghitgesjhgtuhgsihgtrdhplhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uKrdaDE64cwTyL7GlelJZG-9p70DFviBQr0eQY6gKCZ7HQnFRWiUtA>
    <xmx:uKrdaFhbmOH19KKE_-FUHA3L7Iuh6RxFXv1DIXMzPgOmMtZE14er-g>
    <xmx:uKrdaGDyx1Xy90M7U-twZsaMK7yFdmLDVkgzFeDZEkfJh3tUeOkrEw>
    <xmx:uKrdaHTDJ11Z3xEtSA6YAXq89LxxZSH6wvM64ib8hkQP_td5Cb1EUw>
    <xmx:uardaO8sz73XpHbRcjTovTEVdtqJv8sBUDGx_Ux2gzta3WU9Q0YHI7tq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 18:27:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sergey Organov <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Jason Cho
 <jason11choca@proton.me>,
  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>,  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 1 Oct 2025 17:29:29 -0400")
References: <aNuy1aab954D3rJ1@kitsune.suse.cz>
	<E311F5BA-F88C-4C3D-88B5-F8508B106D41@gmail.com>
	<xmqq3482312r.fsf@gitster.g> <875xcyfk3k.fsf@osv.gnss.ru>
	<xmqqa52a1h6x.fsf@gitster.g>
	<CAPig+cQgZijWi8VV1_QScKPhm9cqhQVvow4N-VH00R4oO1m2xA@mail.gmail.com>
Date: Wed, 01 Oct 2025 15:27:03 -0700
Message-ID: <xmqqms6az2a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> skip over them when scanning the output. Moreover, I think this is the
> first time that we have (on the list, at least) heard a complaint
> about the "noise", which may suggest that this is a non-issue for most
> people, and that a warning telling people to avoid the practice would
> be unwelcome.

Ah, different people guess different reasons out of the same
observation.  My interpretation of this is the first time about the
complaint on "noise" was because everybody else would not even have
additional worktree in-tree.

> Aside: It might be valuable to extend the documentation to add a
> discussion about hanging worktrees off of a bare repository. People do
> use such a workflow, and git-worktree officially supports it, but I
> don't think there is any in-project documentation which mentions it.

Oh, that is an obvious thing to do, too, to attach "additional"
worktrees to a bare repository (which does not have the primary
worktree).  I do not think anybody sane would add these worktrees
in-tree if the repository is bare, though.

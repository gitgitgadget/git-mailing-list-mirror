Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC501A8F8A
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731375; cv=none; b=AkCrDvfn34t7m9OUHQ7i7DFbqGbT/Ost1ptkAFZdHPWRY972DyWhoXBQQTt6rgKVOACADzFCyakgl4UiGkfeyz5zif+99S4GurS1rD/s1kk8b2zewym6on6eBzDjMY0yTLqsFsRUf4cLt8QNXHm4a9r3+I+PMoEJb1ERF0T1QZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731375; c=relaxed/simple;
	bh=CJ2CD3Td4McPlDAvi/kUr6x1n7JDRd6UjIW0ndo9zDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CImkQVMJDXV3xMr9zIzNtmqE86ad1rT2a2kL71NM7Y3M5wA69hBg2FIJQkJB345euSa92dgUdvQtn2yH4/CUMYlGQPa4uBz7nbP8rJFu3Toz5jNX9itbMMCSyj//25DwwSfCSqfbGBLh9pL3nVOP/CH1Vg/1jN8xJwSn6hKcIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hyMNXY6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tG/r9Rpg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hyMNXY6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tG/r9Rpg"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 47CC6138278B;
	Fri, 28 Feb 2025 03:29:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 28 Feb 2025 03:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740731372; x=1740817772; bh=f8cB6kl8pg
	AaFPmhHyJ9Er/qZTr7ZfdZkWXGOReJjnQ=; b=hyMNXY6VxYlV2Cvcl/ILYDzLOW
	29210gfBoHTjLjHdaJhbxcldfoIMABXrKVgOtu4Fu7+JLv6FM16YK7mRrx6BBFqR
	IIic13TG4XwUM2xnAbnlZeCaqp3+Wx69cjJAID5EGyZ23oM3lJq67Q1hfwTkV7Cg
	GU29srpbu9TcjKEYNhY8Sq4uedTME5LBn210PQQ1gRn6lDqi7ueJ6aR93u+e4u9i
	ckznr3EcbJ7Cm2lMHPVciCOlJkXuSFmUJAOc96B1DFYfACr344mfD3kqOn6sHs1S
	JRihgrUnU1VnQTxaoDqNEO1s6DSoxJ1C6O7LAZhMvwn60XCpZCZa4dUaxrJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740731372; x=1740817772; bh=f8cB6kl8pgAaFPmhHyJ9Er/qZTr7ZfdZkWX
	GOReJjnQ=; b=tG/r9Rpg6tfg8WPN14bQpyPbC4Xd8xAih+KL6gQU72cqTTCn2ET
	BQecTilEzWq0dWgJxaEIP3BA55x5Zi6TTFii50bXUbyKsCEG2YeOsti0C52uWgKz
	zeACITYsKGuMMoA3oyH+F7VWPPOM2tG9aHbwH8OzlTuwRCWPuBacQmjQ/vC7qiGb
	FOUtohh6CJlE2Xf4cthFev5qEj0YT/2K+xeaBsh7KqDZMNWJR7ebNk09DdCvhmEI
	d8B8LofjwZ+RhB6iohKeT+LPVSRGZnHUp4eC8O8H5jRNQ6OhcAju/06J1cXz/v0u
	o1X4iufTZzoIckepmcO2tKXQPWA/DeKiP4g==
X-ME-Sender: <xms:7HPBZwr5mT2lSP5RRPTdfKGr7J1f0jyqQ1moPxkLnD9z6b_DT8fVBw>
    <xme:7HPBZ2ohfBk-GvRmcw4VBlnnrGpx-UbaifQXzTqmXyiktzRtaLT_p3rGBOoRX0Cbw
    4RUcCuLjhk7iP0KZg>
X-ME-Received: <xmr:7HPBZ1PO9xCA5exWMKtew1UQnfACn-yFgPL8pHt_vgUiDxoeOdBWzYpo0EpdBn7n7BfwuOW6hGh2BRs4mF2zndG-boIw5g5hkS7xrin_9464emOl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7HPBZ37XSFDVW1Z2iaMfF-sdDrrnQeee_jaO9oJrvieamZ4CzyBvzw>
    <xmx:7HPBZ_64CsllKT7Yq510edtW_q9xMnSn3nXV0XoGh3BKR_aRZi-VQw>
    <xmx:7HPBZ3iU04pAZPP9r4oqXRAdrPsrG6HVKhPXlsfsEFovZoG7QqzZcQ>
    <xmx:7HPBZ56Yt5RYg73Ymr186eBNNNQcp4C1y3_1zykS_aEiPHf6r60UQg>
    <xmx:7HPBZy1dPLmN5u-gznFmiafOCzUojidKDO9ZNGD77IvfvOfHdBX75QN4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 03:29:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 10919a0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 08:29:29 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:29:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v4 2/4] diff: add option to skip resolving diff statuses
Message-ID: <Z8Fz5XHtyG_m0_bX@pks.im>
References: <20250225233925.1345086-1-jltobler@gmail.com>
 <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228002604.3859939-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228002604.3859939-3-jltobler@gmail.com>

On Thu, Feb 27, 2025 at 06:26:02PM -0600, Justin Tobler wrote:
> By default, `diffcore_std()` resolves the statuses for queued diff file
> pairs by calling `diff_resolve_rename_copy()`. If status information is
> already manually set, invoking `diffcore_std()` may change the status
> value.
> 
> Introduce the `skip_resolving_statuses` diff option that prevents
> `diffcore_std()` from resolving file pair statuses when enabled.

You mentioned to me that there was another user that basically abused
`found_follow` to skip over this, which seems to be in "tree-diff.c".
Would it make sense to convert that user to use the new mechanism, as
well, so that we don't mix up options and state?

Patrick

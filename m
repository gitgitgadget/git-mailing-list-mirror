Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5A421EEE
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973161; cv=none; b=gaZShGNIP6deBnu2CNkaiXpgBFxlrpMduM0bZkGx5BLlBVS0ADqlIj84UazNCAXQHC+DppXx6J2ocMSJo6RVXgbak5k7a5UG69Cd9jvlwsWlZ5ApN1YIe9YY962IQ4lYWUr94AzsxXCS61tFm6erS4K7CZS8e+tYz5NnFsCnPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973161; c=relaxed/simple;
	bh=gIcGpwpbylmt7Eem0GQTShlZZxJ93JNrmsyqjXcsPSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6CoaG76NkUZTR8rbPJMmFmpy9FSE3GvfS31gxhlFsncot0GbIfUbNForG6jwoyixyHEJ9eq4QoFO+ocIVPc+PJxbAaND5TM0zD4OM+VW87pL6NRW1tzDdrokKfJQC9ufLKmYPKQMs9UTceWan/1BroemL9KbhkIUnKu4y+vgYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UmFlMzBa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsPf1bBw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UmFlMzBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsPf1bBw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5430014000CB;
	Tue, 31 Mar 2026 12:05:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 12:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774973159; x=1775059559; bh=IA0KRPqr37
	mWQmmSBmaVlr2sPTyIl91UIp0uqK6aShg=; b=UmFlMzBaSy/LGy1DqjvaF6jP8V
	NiVpCkGYqvIuEYbKW1aoNB+gPW/rK39NVISg+Af4P8xm1MaDv7RlUCh6DB6uZN3e
	8M+neeNfJR8euE6mI3heYYD2kuxKYp9sJdnfOYPnFYaVOx3kEd9ufsaep3tZCWaG
	xADmELWMRA7TheU5ZY60tWXi5G2/bJ5b24uvqnh6UuHXPr0Ir3+D3ElEdgJ5NIFF
	26XaXIZQMpUE7wzwFh9AFoyBjVy88isLOyhXejF7mJtBGMItePE3RFnssJRkFw42
	o+Jnl+ZnJbwgrj2HhOxvAo2a4hf8pE+QNdY7wfe3RJeWqdC9xh4bGEWrNHRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774973159; x=1775059559; bh=IA0KRPqr37mWQmmSBmaVlr2sPTyIl91UIp0
	uqK6aShg=; b=UsPf1bBwfhJzTtvokhbiM74c/W+l9jz9vGN0UQSRfc3Jl46J7k3
	mVDG5+ZztemAt8oWvkWpgTYPbHEfPr5xHiAonCMIfl09EtklRKnTj3X7ZwStT5k3
	UjsnHFoXv/wDOuQlPw/8EQgRnN02qNIQS4Rbw0apemObhhuKMLSAdbfMu6s1PuEV
	LXZu4OpSOh8F5/hMHMDmeMQI+k+5nPtodbWrgGmEyX8qqQmhDzmF5paa+U346vuh
	uX+0A76mWqM3kiSDskUpIMveQx3qyDLsJC8+qKgZXFFLZnql+8AZvJQ/j0Vl3+uP
	cdRRg6Be+/vEqglBrIRIOOBon1aVoc1sgHw==
X-ME-Sender: <xms:5_DLaQPXaL-5noD6waeIncmeO4JlZSt4c1TJngUmfIzVxZ11xY2V9g>
    <xme:5_DLad0kwZzWURr3Jfmrt3XRR0pMS6-i09GsdXPOeL95AlhBaveOisEm2ZqalDnvf
    5O6CKQAdEb13I7uP32QQxvgOxOCwTkYgV5Ny1Xz2CY2d-lC4rU0>
X-ME-Received: <xmr:5_DLafnSKYqDVNtvMdSxIAhC9-CTL_nctG8_nVG8603VWWpQanRitaBXENtoygPSs7uLdsiL0eQKBpj3SKkrNHQpXx9mCDnF2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehprghulhesphgruhhlthgrrhhjrghnrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5_DLaUW0h1iXPRBLoy63SLrAxvP1l5Qv6AiQsZbODRCWYgtqx4Xiyg>
    <xmx:5_DLaVt8b9i8A2V5VICWY1KFcXg1Q8_XxtMlUQhk-XSQT9KWuBI37g>
    <xmx:5_DLaXYOEuO2rfgmBSOrv_GoKVfni4O0sbqN_HiL7jEAHhCdbTOniQ>
    <xmx:5_DLaUV0r-aZlWPVkRqzl9krQFi1okqS3JxPJaw3XJUK_i3aYuP20w>
    <xmx:5_DLaRy4ceLL7cBR6eBUGvtFSjp_zo2lpr90cOaBthOkhECQnEX2O0ac>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:05:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Tarjan <paul@paultarjan.com>
Cc: git@vger.kernel.org,  ps@pks.im,  gitgitgadget@gmail.com
Subject: Re: [PATCH v11 0/8] fsmonitor: add Linux support using inotify
In-Reply-To: <20260331061754.83335-1-github@paulisageek.com> (Paul Tarjan's
	message of "Tue, 31 Mar 2026 00:17:54 -0600")
References: <xmqqjyus4qp2.fsf@gitster.g>
	<20260331061754.83335-1-github@paulisageek.com>
Date: Tue, 31 Mar 2026 09:05:57 -0700
Message-ID: <xmqqikac2dcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Tarjan <paul@paultarjan.com> writes:

> I reproduced this in a Fedora container by merging fsmonitor-linux
> into seen and running t9210 with GIT_TEST_SPLIT_INDEX=yes. Fails
> without the fix, passes with it.
>
> Fix is pushed as a new commit at the end of the series:
>
>   fsmonitor_ewah_callback():
>   -  assert_index_minimum(istate, pos + 1);
>   +  if (pos >= istate->cache_nr)
>   +      return;
>
>   tweak_fsmonitor():
>   -  assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>   +  if (!istate->split_index)
>   +      assert_index_minimum(istate, istate->fsmonitor_dirty->bit_size);
>
> Paul

Thanks for a quick turnaround.

If it is a preexisting breakage in the original and not what you
introduced, wouldn't it make sense to apply the fix very early in
the series of patches, instead of patching breakage on top?  If we
queue on top of what we have in 'seen', this topic will still be
broken up to [8/9] in the same place, breaking bisectability, and
fixed only when the last patch is applied.

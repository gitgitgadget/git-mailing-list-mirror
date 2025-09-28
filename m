Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D252EAE7
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759074547; cv=none; b=nRp7aVysjIWgQKpOg6k8bQr1nPRHHLPCftDNrOfDrvFLKtqi/uZobHaPeH8JO6v2lvVeVbkzs5k6vT27KVj5PUXkrG6KzAgHWFgBUmKYKKajgIfgHQz1/M8cjSFd9V7+ObOAs7I37uDgISrpuq9IkSLHslJ4D/OP+mZzBUg66iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759074547; c=relaxed/simple;
	bh=GQJQLpO0+tP9Fw8GMed9Jwb1z7tU07q3Nde+eVbVaJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H3NGsRD8qypzZ584MdtFuf3AeRrXVj3zde6fnT2GpfMgN2LU/kljm5JAiJ5pndBeXySHjUtoQBT9+eRPm4jcACqdmdUwQkSuUt5IUqprrn9fEUe25jdQQPCVTYOomgeH0FAu0tYfLIp7NLqkCLGRSJmxTzOHdpMR1oGWiNul3/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RGjyZlZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/h/AsPi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RGjyZlZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/h/AsPi"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 470561D00039;
	Sun, 28 Sep 2025 11:49:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 28 Sep 2025 11:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759074544; x=1759160944; bh=0pxffvHmsQ
	/gY7FgWbqC13u2y9ccmUwOWrDaWGJg+gA=; b=RGjyZlZMBfu3vzrryjPnAflzCW
	qkbwxiGMU5mTvULn5M3QHgHPodPIShPk6qkxH/OQLF/sc0LHyE5Speuvakh1+yiZ
	gNdP3SWL1oAgvAYsr64gAiOeug/G11SQdsjAIQF0pEt0WUYswKeMVv5BCsrGw0lw
	0+a7o2lKhzH7fjGKzoUDiczn6MJjtSJRpYLKAnAeygSBK1ovCK7vubpt9X6GnA3r
	vK+VZfMx5N7LvsY8LUcJu/h48KbnbXHYT6RweeqD9JVzNhzghjn+szY8qf5dk1q9
	WvJRLz+DJ30fbEM4ASMbdbJdH4N9LkGCyWIwKOkvOPtSeV0aqavX5PnfmbQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759074544; x=1759160944; bh=0pxffvHmsQ/gY7FgWbqC13u2y9ccmUwOWrD
	aWGJg+gA=; b=q/h/AsPiqCrBsjmf1YTBi3EFveLqMgVemx/0CvNZNNg0RMKZ1XX
	JYPmF97SFjt6SIx4jGKMguku4M8ENytG/p00bT0as2uEKbacop9tahQmiqaVo86Z
	HLIbXwWZ6/43eUS/QHLd9qJlkeSPLFaXKzfwn/AEbojOSHA2DDbakWsAYRhbxS29
	aeIgBMIazZDkFBwYOvmneqYPrVS3hP9WSLKHHcREoCW+a3YcmAEXoQ2jmT+DB+QN
	NHTbXx2W7dCnWUCx94s6eJwLMUg11dr/rqFZ0EJ1A/E1ZM2mzj40h0c9lsiry2KK
	M8bMnN3WaHgakzYvyHD7ori970fAGLX6O/w==
X-ME-Sender: <xms:71jZaKm9UOCgu1pogTLsbZGYkwLGI4R4OeiwCA58gSlNV6xVY5uyuA>
    <xme:71jZaFjYA2oR9OEE2LMU872L1s5RAdHavzXgQ8LPzeA0TpSh4Db8jSuyhfIOxBEfL
    wUV37AsX6ct8IYlZmWx8j26a1a9h8E4FRwDStr0VJXj9PoGw15XMg>
X-ME-Received: <xmr:71jZaCeI5aEwitmtp3veiy3iN11IJ8tGWv-XshKrk3Cf0yJowG3jf4Ulb6Nw4x7bxSNgu6mx-zNcK8aJ_2LjRStz0ZD3DS22ok0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghpphgriiiiohesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhsihigthesthgvlhgvtg
    homhdrrghtpdhrtghpthhtohepmhhlvghvvggurghhlhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:71jZaFhy72BosABXDar2-xPzGhTYTv4Gby7o7XI_67FOl4pe_W4PNA>
    <xmx:71jZaKyORIa6Zoe1Swn7kP_tUxsWfEDzgAZO7CT3yEYcDPOWYYn_zw>
    <xmx:71jZaBNmHwGUfdWpbwordkkR_3GG4zDwF78_r4sX2qXoxvdyGg1Oow>
    <xmx:71jZaLX-n1EP3oPYKuSlmVWHUz1O6iIeU0zG4KZWUWRrgWxEhw9CcQ>
    <xmx:8FjZaAQXI_IZeTGKJc6z_Vn1c_0fzKy2n1GnjUOQ3j2ITT9HAD5PHVnF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 11:49:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org,  Johannes Sixt
 <johannes.sixt@telecom.at>,  Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH v3 1/2] Revert "gitk: Only restore window size from
 ~/.gitk, not position"
In-Reply-To: <20250928135435.59623-2-rappazzo@gmail.com> (Michael Rappazzo's
	message of "Sun, 28 Sep 2025 09:54:34 -0400")
References: <20250928135435.59623-1-rappazzo@gmail.com>
	<20250928135435.59623-2-rappazzo@gmail.com>
Date: Sun, 28 Sep 2025 08:49:01 -0700
Message-ID: <xmqqh5wm7f2q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Rappazzo <rappazzo@gmail.com> writes:

> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> This reverts commit b9bee11526ec23541ddbbd75716bfd1acc241463.

If you wrote it like

    Revert b9bee115 (gitk: Only restore window size from ~/.gitk,
    not position, 2008-03-10).

it would make it obvious that this is not a revert of a recent
screwup, but historical wart carried from long time ago.

> The commit catered to an unsupportable port of the Windows Tcl/Tk
> stuck at 8.4.1 that was used by Cygwin. 8.4.1 has some bad bugs in its
> layout engine, and forced changes in Gitk to be compatible. All this
> became irrelevant around 2011 after Cygwin gained an X11 server and
> switched to a supportable port of the Unix/X11 Tcl/Tk (it is now on the
> current 8.6 code base).
>
> Helped-by: Mark Levedahl <mlevedahl@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

Very nice to see such a clean-up.

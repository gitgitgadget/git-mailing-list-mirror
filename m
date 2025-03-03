Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEE1EC01D
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997067; cv=none; b=U/rTGdyAlL+32Q/hIPJ/qlLiDv/Y/pjCMzm/ZzM/THWrxffVHOYejrf874l0NGYfQ58y94wuoD4jPppRmFK+dzlA4OPq/MuutIrlbiUU4F5TtA2c9PT4DLavumA32uDKV6vqZJY1y/19wHJlshOtOMtvtDvDd4H/G7zoRDcKlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997067; c=relaxed/simple;
	bh=3XGznXk2uKQV7mviZob1Dy/0Mag9vHx6l83KZtrv4c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1xmfffToxsA5a+GVxPhP8RqkEoAUD7VuP55Cow3nc/y+q2CZiA2K5tLvM7dZpvy7FH4H+M7RXuw0EJzV/E9z1BSyNZPOBi59Ob34STFVlmNtYGMlyrDiEl9fzFfRnOn2gcl0SMQpsgQwwI0GxE98aRTNefAE0gRuxGRdmut5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YzdnASom; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzDG2Ljm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YzdnASom";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzDG2Ljm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C51B82540160;
	Mon,  3 Mar 2025 05:17:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 05:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740997064; x=1741083464; bh=4LN1ijVILW
	+XT+qPS98IgcftJFbunA/kcDsBHkrE7vw=; b=YzdnASom+2QEmqHV5H1cAeRwk6
	8cuPb1ALfVVBCVOIXBty5jh5XjQvlXg+5NQcbOJ7qP+z+Z8JjH5PxtPlM9sIZzqS
	4SU5Iz713Mq+Pu/W1Z4du4op5lNCQF0jWEFwIQrTvfp8ckgrG2t9YmU7kCw/q8bs
	/YNj4A7iqRd4X36geQ19Cg0Tz5uEiBclU8neU3Wx3lZVdeZ/D8g1+MNCGsxz6jl0
	JDQT+Hbn8ejCPGFnnWjk0Xfn4E4TASrXDA7k7nLEh45ZBDJElE2JPktZCWa3BHxY
	29j/2L0+u5lHe9zzd04JE+jz+ERKytj/jhWpqQH+MyvLrDJx14228HRX+xjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740997064; x=1741083464; bh=4LN1ijVILW+XT+qPS98IgcftJFbunA/kcDs
	BHkrE7vw=; b=UzDG2LjmQs81X0sFgt7Xr7WXFcmKtU5M3fSk71VBD/8PfTmcgy9
	VBYduwMSpPg5vog8zKKyoIkCA/+MERGN4BuAG66X+rtf+WDkkyVigjcWR8OJ0TqN
	QBqXb6yxgXppoM2hM/LJz53NMtJVTE2OuOkLq8ltoC7N8vJxoCqXENGvYZXXQtU0
	fKvouHXmvomIry0vZg4F//eXnVeMvuSO8Fxl6adehGMjQlzP2ersuw2g9wHJ5bGD
	3qVMrqWSV08+pnm0Ns1aNW0NTbC4BasxqvL2jwVx4gzFYzAnV7UmaTHwMt16W2w6
	Aiyj3eRF2mxTODl3Zn2OO3A/m3pxRgDn6SQ==
X-ME-Sender: <xms:yIHFZw-nl-oRkS-SHSM0AqA6JLOyWUdP-Jh6P9WK7U17jJXqOpRplQ>
    <xme:yIHFZ4u3c27xvbaOu89D9LKHuLSbkveR-r20JNfktRCbkadkkrE3PwBuFx6h9wBk3
    s5becrwVP738PMq-Q>
X-ME-Received: <xmr:yIHFZ2BgsLMjdCr2YX_lxBLsuDHmkRen4rpwvcdMgmfFBVkTODB6LVKMgI7cC2kul4ztW-7z0MP0I9Ifx77KdTERvQHGcuw4teWi-3CuGXQ00Ohe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yIHFZwe1ElYAKUJIYSEZfLeT6VgkSqlrZaW1i6gndJjM1RVXc5fZlA>
    <xmx:yIHFZ1MiU6VDTWqg2mjumQVCNgCFJC2gvVmLXiPuM3YTfMUvCMAZEA>
    <xmx:yIHFZ6nLpjQ_2nBavJaZZcviRtCpEVvoowMyH7NC09aQ88ot7J5z4A>
    <xmx:yIHFZ3seaAbPrwqsLioMrIzAEZT8KBVMqsavUHOQHaovRBJ1dEEX9Q>
    <xmx:yIHFZ6rhEqB6khPjp2yLnTZgYCjpXnIr1_TBE4I7oFQduZpJN5YQZqPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:17:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd52dfec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:17:40 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:17:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] meson: fix building technical and howto docs
Message-ID: <Z8WBw1L50zVmjGIs@pks.im>
References: <pull.1870.git.1740931350451.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1870.git.1740931350451.gitgitgadget@gmail.com>

On Sun, Mar 02, 2025 at 04:02:30PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> When our asciidoc files were renamed from "*.txt" to "*.adoc" in
> 1f010d6bdf7 (doc: use .adoc extension for AsciiDoc files, 2025-01-20)
> the "meson.build" file in "Documentation" was updated but the
> "meson.build" files in the "technical" and "howto" subdirectories were
> not. This causes the meson build to fail when configured with
> -Ddocs=html. Fix this by updating the relevant "meson.build" files.

Good catch, thanks! I wonder: do we maybe also want to start building
documentation with Meson so that we would catch issues like this
earlier?

In any case, I'm happy to defer that to a later point and for now only
land the fix.

Patrick

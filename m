Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FE82D70
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654357; cv=none; b=ksYNakHOc3fcEtMvbuR9dskUz0qnJLaVAtznf0ys+4xMAd2tPsQsLkjjIs5G/FbGqPs5fgY25SwqVXxMT/B56BeA6r5mpjYn9R2g7ilJ7BH01/2ccGCDbyrUbvvzmSODlZucUjle0TntLMjplNRk7YqMvMUMsy3VcqsBaUTvSKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654357; c=relaxed/simple;
	bh=20fKsjui8EmTu+iIk6wPaLQrhlQRY/GXVmg98svNGBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEpJX4DWFiZ6XXbNyi1qzOafD6WuZg5NUREwZdN0TvcO3B6CC1/NriFxp+r+7TPrKk/zUM5bNnn9+zGzUQt4svkdsFpuMRzKp4NZcFZvFGey/sAqzn/Yh92bu4BNOV53XEIBVlhOCDdfILZ/m7i8dcYzHvXg8XFpmUXJPqYKXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qjUzuVqw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fPKLaQ7x; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qjUzuVqw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fPKLaQ7x"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 736B41151B25;
	Mon, 26 Aug 2024 02:39:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 02:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724654353; x=1724740753; bh=AjNGQjfySl
	mJNpNm+bEN26421UB1cZbIqtlhfrLRdDc=; b=qjUzuVqwGVfIHytNa2enknupTu
	5b8ZoA2uFurK95AUsU4gL7SJKoZycHTlmEHWRLMOguFQB4/RwSGjkEFFiBiC+OUk
	4UzJxCy+crSr+yqAneUkFmDOZpVWvSe37VVBwzNX2y5fVBzR2SNICk/HZFi9i3cf
	dmUNTj3rMMbgPuRMS6dHx2ZND9WtERxTAqmkr2nsMGUeAq1tQx6uUktqM2Nrimey
	K8RxN/fi0msRtyQQI3xau/IXR0iIiYEgchjaKuq59lzThim8sinZS/eRdlkDGcqC
	b0B1sbZQARcqFvWo3lnY157G3smNa3zJrUBR86AB3YhtVItfBX7sO+K2sbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724654353; x=1724740753; bh=AjNGQjfySlmJNpNm+bEN26421UB1
	cZbIqtlhfrLRdDc=; b=fPKLaQ7x5IuzYII8X8s9p3MoQBDkX70YJ79D8ruLHFsZ
	FSBii+Ak+XlDE6g+ruJrgaBgKDVc6Z8Wtf2zzkgZ0JEaUkZ2OiHIgdsx8qV+0mui
	uRSel6du88d81Yrj+BUN074BBqx0NwnzxILU5z5Y/qMx9tNanniEX73/AKaES0xo
	iUbnnJ03O6zpf9NZ7C3GJZB7nueNZdA/s8RJAHovc8bofhCKvSqmywgOdP6qwseF
	DBe3HtRL4avCBgqSK4X3XqIFi9tHyiLJ3up+1N4qCUuvV1vDRUE9qA+5xADyl59Y
	iNXRnD0XmBnFhj1BrLLccqSBI/V+xmIiHWgsmGLr3A==
X-ME-Sender: <xms:ESPMZrN9w4FgZ1KU3oqNdYAn8uUowNBPuBsz8FfZBhC4AeqHBKzxmA>
    <xme:ESPMZl9zJUZRtkCZPOop0Ej6JPbuoD0F9VgXK41b8s73MfE7ueZ0IFFddkKjKxtch
    3C5S7OamDxs6KEqwA>
X-ME-Received: <xmr:ESPMZqTRjTjMy6_sInMHx6IOVHJ9X2c13ZvUYBOIfgqq1CNFSPey6BQQ_e_shqMYgbQjWGfXKc4d1LVE8gLJq0iDpzPbRH4PWR_SG6cTWCe_Los>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:ESPMZvsGzz748IaOLfdsBh4TSrfy1VPb9KG_BQoeZJeGo9EB5Orepg>
    <xmx:ESPMZjc_ExTQwqCGIrMBx0_eu-7nxQBOuzoBLjSFJfB3DYlDSA7mpQ>
    <xmx:ESPMZr3wl1Ald2TLWXVWV5Colzp1vftnPAeAtQPc_QxqvblzIevRlA>
    <xmx:ESPMZv_f1Bkrg1NWH-kdGeuZZl3gitX-qMru6cLyWzh8R5WQ4QkLtQ>
    <xmx:ESPMZv7QFNZTMfaVCSk0Ofa21DKDSkHB-jBdyXIUQWytafn9gX-sBJCc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 02:39:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4505bb65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 06:39:07 +0000 (UTC)
Date: Mon, 26 Aug 2024 08:39:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/6] t: harmonize t-reftable-stack.c with coding
 guidelines
Message-ID: <ZswjDAOBzj5gwlxO@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823120514.11070-3-chandrapratap3519@gmail.com>

On Fri, Aug 23, 2024 at 05:18:47PM +0530, Chandra Pratap wrote:
> @@ -1039,10 +1035,8 @@ static void t_reftable_stack_compaction_concurrent(void)
>  static void unclean_stack_close(struct reftable_stack *st)
>  {
>  	/* break abstraction boundary to simulate unclean shutdown. */
> -	int i = 0;
> -	for (; i < st->readers_len; i++) {
> +	for (int i = 0; i < st->readers_len; i++)

Nit: this should likely be `size_t i`. Not worth a reroll on its own
though.

Patrick

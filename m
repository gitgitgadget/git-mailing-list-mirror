Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA1A31
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738565166; cv=none; b=XKLQ7Gxn+ZwGQtPQoBexe5OTOii76aGeTRBQ3asM349UyiXWx61VxZqYautXKSv3RBK29cC+s1cHhaJAJPgp5Cf/I+yOQyULH7HQTuVMPpbUGb4aeotfskxlnrT+S4YhZU8GAtjlkF11tKF4c97SAOYnGM/OdnCzvKYXh7HycMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738565166; c=relaxed/simple;
	bh=l6KLmL5Y4ymnOLYEDdQFqqZL0Wp+GBISokKueonlmig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4qs3MU5arlgTyWYZQY/UHV2F9lY2eEBa4u0/SMSN7oNgfkxTpkz6q1yqJQxs+7h0oSfHfyBv4AZN3K9kS3AF1uHMkDzzDxNMOAajdvwtiXOC/rfjigSRGrC2GBgfMkREd65vxr5xMglmpnYLMVGoA6BTjGXEsDfv16pHigcP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvtLcUew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U06GX29w; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvtLcUew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U06GX29w"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6ECE0138070E;
	Mon,  3 Feb 2025 01:46:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 03 Feb 2025 01:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738565161; x=1738651561; bh=l6KLmL5Y4y
	mnOLYEDdQFqqZL0Wp+GBISokKueonlmig=; b=WvtLcUewr6quClJvWGqSi839lA
	/B3IyP2s1AxNizdiHpUYKBqregszeVKLUQ/sp01quMwGBbtOn0zSGQr/J6gKt2td
	1mO0m7/lL8sOpu/i982XVRLTgmLfUAz91nU5E9kb6UfzPdR5xUZnyKsQ23cxEwj5
	85RTVjOGiR99bMcV1GTxWRezk0Q1hjZJ/qE4r5uUGYq8w/2TFtWO9PUieyTamGyg
	4jqdbj1zZB0l6rSWkUNUhClTqvzxzZbmU5xWIBAe4bqJC4jXLJ7JZIQ3588CaRsE
	ac9wuuBJhX3hqN5epbKZ6HhyQAN/QRDHXE0SiV0DJC7M6GwXJ6kLjL4B/Dzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738565161; x=1738651561; bh=l6KLmL5Y4ymnOLYEDdQFqqZL0Wp+GBISokK
	ueonlmig=; b=U06GX29wFKiAPTSwaSyrMx1BMQc7nHoNhqq+nNpBC5/RiQ1rJOM
	6RZpeEnVxtwhgzsqe69FRahlTtAdUN3J2vVjEkwsjFdyGIWrC0xNGmjdYiAAvvSm
	OhyhDGe8Ja5WYqzFWtXiyExhjLaLJjQGzUz855aIi25hITEGL8KdR64NAmAbxC7V
	L89yoy2nzeieR+9B2fk1v9OqsptoqtjVW4wsS+Agu+tpyiBugRXBgsFL4gftyQ2k
	n7kW8Ip3Aj0CQCQRUF55zhDozyhN8wtyEAkOhNrEC3Xe0uOYt+ZWqJX/GGXlWmiL
	VLdps7Ijw4xSgTg6FttBpnxyZXLzAPUec+w==
X-ME-Sender: <xms:KWagZyNE-TJgguHVTQRStKBSVSTI0IX2eQS2GnGLipxEanb0d_BKEA>
    <xme:KWagZw-RkxnM02L2B0NQluEdqTD6uZ1uWNfKA1xemHhGQpf7SvpIiFpBFGK5I_RjZ
    QsjlN-ocBt7CsIXpQ>
X-ME-Received: <xmr:KWagZ5SVXCv1JqCZjcvbSFIkzbT6IqyrNYfFtm-9cfBTQFCwX1lB2Fv77J3K8pWVVsvRQVtnAwZsRXUiW-qQnXBj7JqmV-eLanxpHe1reRTOsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehshhhusghhrghmrdhkrghnoh
    guihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhtrhelgeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehprghvvghlrdhrrghpphhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvggvthhsoh
    hniheftddujeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:KWagZysUIiZTov1ez9KWEFLjohEAZM5ZBe-B1twgS6VVAYqD3GqObg>
    <xmx:KWagZ6f8iPis6vfAwj4CRCHNQaSNiZz3HNHjuM5yvFWCpDN1LE-qUA>
    <xmx:KWagZ205LCIJ7n9K1MHHjsSMOfaSsggiS0kDRSFoyudW1ImKk6edKQ>
    <xmx:KWagZ-_yhTHqJULz6qYqZciuYePYAyBjOLXkWqD1G2wg_v49TsThsA>
    <xmx:KWagZ66VYFNNgOsxbaYeWc7dS4eCKp0Sfhwxo5Uh_TlCAWjzKSZAftOB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:45:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62955449 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:45:57 +0000 (UTC)
Date: Mon, 3 Feb 2025 07:45:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com,
	Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Matthew Rogers <mattr94@gmail.com>,
	Pavel Rappo <pavel.rappo@gmail.com>
Subject: Re: [PATCH v3 1/5] refactor(remote): rename function
 omit_name_by_refspec
Message-ID: <Z6BmIGIJYq5D2ZWO@pks.im>
References: <20250127103644.36627-1-meetsoni3017@gmail.com>
 <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250201064202.76116-2-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201064202.76116-2-meetsoni3017@gmail.com>

On Sat, Feb 01, 2025 at 12:11:58PM +0530, Meet Soni wrote:

Please drop the `refactor()` bit from the commit subject, we don't use
these prefixes here. You also did the same in a later commit.

> Rename the function `omit_name_by_refspec()` to
> `refname_matches_negative_refspec_item()` to provide clearer intent.
> The previous function name was vague and did not accurately describe its
> purpose. By using `refname_matches_negative_refspec_item`, make the
> function's purpose more intuitive, clarifying that it checks if a
> reference name matches any negative refspec.

The new name certainly reads way better, and the changes themselves look

Patrick

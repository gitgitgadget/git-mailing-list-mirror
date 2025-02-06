Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3989D225A2B
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824454; cv=none; b=Rtn+HXXolpTjZzvRjOXlJkc8Ak2VmsVgeD1bqAAqzeFRPGujvk5PvP0EsG3ehhuWxftMLAOoYvkg77jBOe7asDz2vdI7SfYBE1dR4BGvoM2cVT+JbyygpVUEu7Gmg5lv9LpFOk7VMfIObxjM7TeX4Dq36IcC4KcugRhJ5/4yuUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824454; c=relaxed/simple;
	bh=OJf/kFJ/HYuyqbhiwcQNMLEntU7NH3UnMUBHOLBtLxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKtj2Dgm0K5MJ6YadIXV9lfmg9nSZMvehziz2/Z3NBy+MwsLztUHQxz4mNZ+0BuFJiYNV5pVjLl3/Tkk/+nL0YqT17E2+3scaP4lmAfspngQfwFamTzX4DwsBB+7SdA2shLI1NnNn+9Ll6KU6PXL7KgXEYQTDOAQsJSKJ2me6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T71eIjjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvpZNRdZ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T71eIjjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvpZNRdZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2988E1380227;
	Thu,  6 Feb 2025 01:47:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Feb 2025 01:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738824451; x=1738910851; bh=ABtdKhpkxl
	V8mEstd1t2brbDHr1ft7yj1pXvy4vyMoc=; b=T71eIjjIuPQNgNKMp1aJqZVH23
	+UPFhshhNTA0l4BVb5xJsm8T40DL2QXxDtNvW1dccGtWJXBHHNnRcD8TgxoFzvN1
	VIFOKlyK6g59p7lCuC8zzgP1ZM0To3XwouFnG/r0dvZi97erUE/j96aStvS+51BX
	YcoioOCooEp31LeuqFT2mmgcGJeKxipthItDlc60HikekER5Mios6fuG0zwyy4fe
	5/acgXe0RgejTmL+Mg1fPcXjHE2mZ/TU80I7BnHhGzLA93m/FVnLNlonOgKC/M67
	pJFA0kH2ByQaPHEVpkp6VNGkkazNPBcmU0obdF+T6+f++XQsAEcVIfZW2lUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738824451; x=1738910851; bh=ABtdKhpkxlV8mEstd1t2brbDHr1ft7yj1pX
	vy4vyMoc=; b=ZvpZNRdZkSJPqwCRYpZlOM5y7+dzCodONoHkpYQPPcWtkCOLFHb
	SzmmVqmVMTEgy/WZJ9u7rnesNBYEzB5SzTOVIq5nBaxlmxpPPpimo6wT++Gg9Dlp
	zaYzlkGnImzl02EhobDSQ+ar0EMSWxs6qygjZvc5opye14e6e6q0hlYCjiLdMsJg
	7kflj6PUUsQuvvN1dOPCCo2E9y9YezXjHvbwD1ELLF24N0ccadZX1nMPi3O9kNvK
	sZfNbuilWeMfh25i9ulj8eNqFbmOMpWZctfWNGMP8IOQ0op/VfNjVv5aNK902gRi
	HEuKNrRqxvKnCGW+4AM5kUn0cwkGL6pThOw==
X-ME-Sender: <xms:AlukZ4wgY8ueWNs_xhvkS52kunO5VC4EY2oI9fcP6EzR29E5tXkqqw>
    <xme:AlukZ8S_eFm9tIdA3Crt_7cEznuvzneYvrCQbIpfVysBUuCWlhrdPDrUJu7g8RQOo
    P0QfzwJSR6-hqSUBQ>
X-ME-Received: <xmr:AlukZ6UWxEzCl8INV4b-mW7TKJFjRy02QSS3_pVvhG2xVRRdfoimOmGCm2Chwf4hxlz_P820HaUXv9ks4ZEDALKiMvJm0KTL9bATS-uXWt7W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AlukZ2hO1Rb7MuHp_l29K-dBmZjhGnJu2pFMz2cB4--0Mwj3gA_NnQ>
    <xmx:AlukZ6CWZxHI-v7eBf6vFwfR5o6_-3ivDlsMlKhRCOZLJnkEhA_ltw>
    <xmx:AlukZ3J-1ZbcJG4DycOly6k0u_kaNAE2xtEEjpL77ioKTUhVmzi2aQ>
    <xmx:AlukZxDUNugC6UjkyMOwWWFgMvTScBjq3mV7j9BObx9JrjaLrbx_9Q>
    <xmx:A1ukZ9_UCOhXL5e1iISOwiRBQJnqUJRIMC-yNLb9G6IKMhFfToQxOnAJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 01:47:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d8dbbee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 06:47:26 +0000 (UTC)
Date: Thu, 6 Feb 2025 07:47:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Feb 2025, #01; Tue, 4)
Message-ID: <Z6Ra-HSNAAdT_QTJ@pks.im>
References: <xmqqldulrvly.fsf@gitster.g>
 <Z6MNRVrhw3Nxz6Iw@pks.im>
 <xmqq7c64nn4o.fsf@gitster.g>
 <xmqqseoskkf4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseoskkf4.fsf@gitster.g>

On Wed, Feb 05, 2025 at 04:04:47PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> One topic that I miss in the cover letter is [1]. You probably forgot to
> >> pick it up :)
> >>
> >> [1]: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
> >
> > OK, I was wondering if we are going to rethink after seeing some
> > comments but with blessing by j6t [*], I guess this is fine.
> >
> > [*]: <37c14379-68e4-4c52-a08d-b78c7797ef26@kdbg.org>
> 
> Wait.  This works by futzing with unlink() call that is imported via
> <git-compat-util.h> which you got rid of in a separate topic, and
> given the overall theme of sans-compat-util topic, I do not think
> you want to include <compat/mingw.h> either directly or indirectly
> (via <git-compat-util.h> as we used to), either.
> 
> So where would that leave us...?

Ah, good point. The relevant code still gets imported into the reftable
library via "compat/posix.h" -> "compat/mingw/posix.h", so the fix would
remain largely the same. I'll rebase the patch to fix the semantic
conflicts.

Patrick

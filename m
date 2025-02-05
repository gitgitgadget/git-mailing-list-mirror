Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E7A79FE
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738739327; cv=none; b=DgCrXHw0CNc9lJ0kq7DEYTnAW/TFNtl2tHFc5kMzW0uK7SNmUPffv9lscHS8LMwE6K+lmJJ4R/WK/dkT++rtjkBs3mVhQ9VqWsErWVELOKKxNLXJ7DncpugNik2u96uXPpgAgkYWUCrHu+boVGA/ngxNiEfaa+TDuTaWVGdslUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738739327; c=relaxed/simple;
	bh=f8b+XV+vfCpU27OoAPHQgnFxwxlRnhh9Rxbkvht0qmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKt/KuPDbh2gsvE0bo5VFl//as6siL2PklQsbS8a5QFDKavP5LauEBziLenDYBpSwxGgXojJPTPfIOBLmVogN9ejDFNPfDE6ZvuX7coOvcfOGki7nLVojT1pi4g3Xb7NXC2fTdGR8S8PXXtK8jPLiO4w5nwbThTMXFmICXDLBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N30xWKo7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wgNpnJft; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N30xWKo7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wgNpnJft"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 21F74114011F;
	Wed,  5 Feb 2025 02:08:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 05 Feb 2025 02:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738739323; x=1738825723; bh=4Fqn2+xSCj
	xBq95F6HERhDWpyWb30XcIlrZ5sQTcrWM=; b=N30xWKo7VgpZw2+kmL+50sFppr
	iwklWnD7wpw8ypW/NnK1iqWNvQEd8uCWRmzGCxgi6AZgx8LxcDWhdnGMaXgPrdLH
	IUnLci9A+oqMTUWlK3W4tTBhzpc/7DJQ3l+bl35XKIFpWI8x8N8NQUnPbm9EVkDA
	6jxql+lFcqqAnlZcXIaPP4R5+M2IniTZluV8Sih3PUGOtLTwTS24dGxuly2TDDhi
	Au3rvw+QVKqPLe7zrWQ2/bMFSXbcL9naSSouDUzPrkzj7FDJi9D3nRJ1rN5qo8AB
	sUNFu5CBTIykZC1XGrMj53z8nJke/Ey5bRxOU5Nsu1temRpxUjQvl7P0D2ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738739323; x=1738825723; bh=4Fqn2+xSCjxBq95F6HERhDWpyWb30XcIlrZ
	5sQTcrWM=; b=wgNpnJftxW98D8povTPFJc+hqmWzKtrQCEmtkgzKaMrTvb9bfPy
	3hZZnfZHyUMzPVll8qcoPwLmiNdD3gufYt22JNAtnjyoAFJ+SjW6p7ANieqm3+UI
	bq1F5+bdhfIOrmchWev+O2+Qr9F366Q7gUeXxS9gxfLPu+hm5B8p6QgW9aCi0D5q
	EXFcDe5iQPv+XJMhoX52uLJrV86ZKOjjvynFw+Y6CcA0tMFLD1uNo29v0hjlAgtk
	6xH0A2lz5cAtWeXAH0ZuT5sJ+xnxpidlNuvJqQjgCT4BSzAaCTNfAxByeMNoPLO3
	c4Qozm30IswkxgnwsDZT/bV6ruWbd/qtjSA==
X-ME-Sender: <xms:eg6jZ9zQbp9JqH_2iYgYRPmC7p4ml06fB5WS7YIzvlWEvOZicJTd2Q>
    <xme:eg6jZ9SxmgyRF2onkzaCjMuHZUcfDk3-sya84ZWIegA-8fnLlol0EpXO0prBt1yQb
    xFGb4JpOCR4nIMQTQ>
X-ME-Received: <xmr:eg6jZ3WHchhHglmjvYbhkik6wu9Ugdig49h4rbyFuOhqqo0vb71mddWu3wlD9Juwy2S5R4saEgbJN5RQB9vH67mKum7-Won0-CAfcS3IZQ3_LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehjvghllhihrdiihhgrohdrgedvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eg6jZ_g2NukIfvtX3RC82BItdYqo5qh7-6vjr8SPCE5TPzkkUbe09A>
    <xmx:eg6jZ_D7W_rehSBTIAA62wn3AYu08xQl4GwbuDzq_lbtCMTORnyzKg>
    <xmx:eg6jZ4KBqh_1eqoYA-gzjicqebgsR9Fm_UHgf8ibVbfHwW5hYGq6rQ>
    <xmx:eg6jZ-CBaT76LGvQMRul-Pm8DGWAGPYGIuh6t2I3fxzgjegSq4IVmQ>
    <xmx:ew6jZ2PV3FZvmTphnx3A5W78rOCWK76DrIW2MSxefQoU4-bMm19YvH19>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 02:08:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6754ee3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 07:08:40 +0000 (UTC)
Date: Wed, 5 Feb 2025 08:08:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Zejun Zhao <jelly.zhao.42@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [PATCH] contrib/vscode: respect configurable options of
 IntelliSense
Message-ID: <Z6MOdywCXc48qARV@pks.im>
References: <20250204125721.11357-1-jelly.zhao.42@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204125721.11357-1-jelly.zhao.42@gmail.com>

On Tue, Feb 04, 2025 at 12:57:21PM +0000, Zejun Zhao wrote:
> The initialization script of VSCode development environment uses removed configurable options of IntelliSense, e.g. C_Cpp.intelliSenseEngineFallback and therefore triggers some warnings.
> 
> Fix this by strictly respecting the latest configuration manual of VSCode IntelliSense.

Formatting of the commit message is off, as we wrap lines at 72
characters. I cannot really say much about the patch itself. One thing
that might help reviewers who aren't familiar with VSCode would be a
link to for example release notes that announce the dremoval of the
option you're removing.

A bit off-topic: did you by any chance try out our Meson build system?
VSCode has a plugin for Meson that you can install, and then you can
import the Git project into VSCode directly without using
"contrib/vscode".

Patrick

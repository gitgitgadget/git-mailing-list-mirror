Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33640F8DF
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602690; cv=none; b=qLHj5J2Zgjc/xkNGoP+jsi0OTbIOeC4JOKUi6UpqEoqzHqJK5SNfAvVEx66aYLXw2lCc2STPeFPvk5uWDiw033efyBY9AAObO1NBE2d1FMYy/XnLtgc5/mdMvon/y2F4LDm7V/RiT4IJeTOa+KgfYsSdk9K5haELUjr/A5d3Opk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602690; c=relaxed/simple;
	bh=Djkwb+tt6GSyjJ7cZMhf1AXdgaSz2jFvCcpwgICpUKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJy86eR2D8rbx77nIyWFcZ819dNo58xmlfZT3n788oIpaEwAPxoVya3RdBTxqYFzu6LC4qvONfzOzwG85ZHCmVeFjcPFx6CaciZ2XS6r9Rf32jqcrLqpfVgBC9iHSDXS+mz87oIF4NmQG3w3mWH7TXDQbT3L7MDs9fHMxQHrTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L2++6WBs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7lwgKVX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L2++6WBs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7lwgKVX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 250601D001AF;
	Thu, 13 Aug 2026 02:31:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 13 Aug 2026 02:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786602687; x=1786689087; bh=hGE0bJ7t8S
	bMlTvHobtmWf7577xb315G4X/LApHC1P8=; b=L2++6WBsXf6ICSAdknaQcz82Ac
	Iln4cz717+tx92GCh0BejtjoIhcLA3dN5ftRVWyNFgG8Rv5NxoKKNldWISou4sms
	zLLEjjOyBUpdGyH/rd76ZrPleU0SRb0rjZnQTLU3sWuOWKxC3qIevqEhPi4ibv/U
	VsumVjd9aZL1w2AWvjC5QskHaS5PTLDfSA7Z0tgLs8BmOOWFer8DaOfBPIGNYkCw
	J09rdq+FlxJevv9gH1dVmRDAJaoU3/+rJlspCkVWYQ5QDESBG5VU20vYA7tiZgaZ
	QCbzdmpUc59rfNp5s37dX6SiXVMLOmfd/PnWGjheHQafSXnSMuj3n3ZK288g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786602687; x=1786689087; bh=hGE0bJ7t8SbMlTvHobtmWf7577xb315G4X/
	LApHC1P8=; b=Y7lwgKVXNlQHOTQXb7Ley6QiP6kFSfauvOaGoNpyg17ZgdcRdIH
	YBzsLtzJgdMJJeQr0BTTeGRVQKnx4c9jagWDaE+aQxWconimGae4AzxuLkBrYPN0
	q8RgHJPkeyeCAe4/AR9JHGqYYvyk6/TLgsJkwwk2G+Pji5raMXLbYifS/twlur3R
	iHS6OpvZ8RYM5W6Y/artk5z09H06OOWX2wm33foMM9z8uQuzrhhCKczQGnTxFoNf
	HChhuzV1BGYHcsPcw2CI4hWKVMChZ91RMUZyaA31Fg6h6KWqgwRWJHnRmgOxxlRA
	bv7wP1rHJ25b3AFyTyzlGrZgn5RsZs8Ty2Q==
X-ME-Sender: <xms:v2R9auDAfz5Pll2pksBBolI5Kc0H_1lD1lv8zNYO4IQDKpmWYYaA3w>
    <xme:v2R9avgfXdUJ_McAeWmcBPhOKpqgaXAxd7nQleNNY-4wN5Y4EceqMs_SKP-F8eSt8
    ddoNGYE-7_uqQNGWkj6c01Fyc8T4a6G5cz6wTiEOkpgvGTlZaiQu9k>
X-ME-Received: <xmr:v2R9aml66XkoqecpWSF2TZcaA-oH4hzrDXTy0lYULUMYA-UXm1Krzsgru6MKPFLPNHdUe-MiJd3WWa0bj2ez4soyttrBBgTlCWWJ9ifsRmU_>
X-ME-Proxy-Cause: dmFkZTGk+GmutG1m8vzeq94F3KxAI9+Fz1o3crIaSMlk21lm8g0uE9VTuRQSQldT2i1UME
    sEYIUbB8uqUqG3Tjx80pWZmStp+qYKZ8eCElIz/jRUu0f4S7F5uFonFEpIblpJNf3n6JZ9
    JIgULpWhkzlagobCQ56yFw7t5t/7Zx+zGuxxOtDRwxt+BepyHenCcB7sg9RJR2uWnevQ25
    MIl/N+YODPIsPygir0ZtVB+JFaB2zMvsOlgAUR3PGU1UFJoVncGryPNhINeWI/FHIxSj8W
    fuPg2WjZDnmFPf+PlWWdMdq9xDw97QvK2z1gGFfTrI8Zir4bYux5BlxhKC+MHCK3WIWGAu
    b2Eb3MPJ7pGXkjUnAD7195U5g3jmgeqIRku4GnP07R9pfNQx2vfrcRwLd/5lfN88WvDR3A
    5Mtua2NoiPpwoa6GrKJ0drVkEw4m7CWK0V0JbAJUJGjXl+JmtdR7v2/8BqziT4hlmzKvdP
    Br7cI8gFHS1mA+L+adPAyJUExMm2bi/2Aal28KpHXsoNOHdas9XKaQv9xPbcKbvYgjc5yh
    ZYkKdUmvvM3ZueQyvy59eaP93JzS1t7LBMLtBAFUqtfr0garDY/LlUzHCGjL34ILQg9X0t
    B7gd5sphM7OLO6JfKSz5xoFzRJl8Nd9NUzqwDnHmx+H715vtQJDQli4nVRPw
X-ME-Proxy: <xmx:v2R9arqCT2ysYzNUpEAZENvMOffO0flXsnzLl5MjXdQ_otAByExmPA>
    <xmx:v2R9avH6BgpkxJQd1rJmGKKPHz2VrRUHtBPk4K7lARNLIO74LdikLA>
    <xmx:v2R9anysLy2AMnoPP9Xozf-3K1--TKyYMZt-6k9zPfj0x6lArUBoYg>
    <xmx:v2R9akrsfiTup01ORsyzf3TVgMU0ujcZiXf9HwAhFuJr0ePFQBABng>
    <xmx:v2R9ahmejZyX-Vgct8vtXGOMf2f2G1Wng032nR_1wcyqoWMstxLhHiOx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 02:31:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4d89f988 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 06:31:25 +0000 (UTC)
Date: Thu, 13 Aug 2026 08:31:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 09/12] transport-helper: warn when export-marks file
 cannot be finalized
Message-ID: <an1kpG_KA-iNgyAO@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
 <ad6ea197374f48f0837a40993588ae0cf69affc6.1786521801.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad6ea197374f48f0837a40993588ae0cf69affc6.1786521801.git.gitgitgadget@gmail.com>

On Wed, Aug 12, 2026 at 08:03:17AM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When push_refs_with_export() finalizes a successful push, it writes
> the fast-export marks file to a .tmp sibling and rename()s it into
> place. The return value of rename() is currently ignored. If the
> rename fails (permission denied, full disk, or an antivirus product
> locking the destination on Windows), the .tmp file is left behind
> and the existing export_marks file remains stale; the next
> fast-export operation that resumes from it then silently operates on
> inconsistent bookkeeping.

One question here would be whether we should try to unlink the file
instead if renaming it into place failed. But not doing so potentially
gives the user the ability to fix that issue. So I'm not sure whether
that's really a sensible thing to do in the first place.

In any case, the post-image of this patch is a clear improvement as we
now enable the user to act on the warning in the first place, whereas
previously they wouldn't ever learn about it until the failed rename may
cause errors. So overall I think this is okay as-is.

Patrick

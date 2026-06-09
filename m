Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844813ADBA4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990086; cv=none; b=I2LFADcW2+XhnIDbNkBDpMzK00cmOKotFa7KhcNWq5RxVPmpyb2L+IdOv3t31uJzupRMHWjSND9/uPXQld+IkXMDCRswikNLnoXOQDLmYzF7fTTTMFYzlMiXBApDwdYkBDPzjL78hmjLCW5ewCC41QvLVoLOsxKrLw5a2mQ2Blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990086; c=relaxed/simple;
	bh=ekUvUbiu4BvXaJertWtR8AD/Qwwq5nU0k0If0gmLSVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6Zm4TDFz+H0TWPKVoXhasOtfjizZcPeRPQ0xVtXYZtLylNfHn8hvl/xM4WN+KnVJfe0UxENdIxIxpSANX9B97qzZw76FBJR9prOELiv683p1BSVzPFViWEPXDvyVI2fdDXG+O4V/bngmCn58Wiz7VgL9yufVywws3cIc+QkvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aTFpMTKs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xx51TW5V; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aTFpMTKs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xx51TW5V"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 9FF961D0005B;
	Tue,  9 Jun 2026 03:28:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 09 Jun 2026 03:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780990084; x=1781076484; bh=Es22rmbqj/
	3Xs9KMgvZ5fEJWvHe849JoWLNT0EKbTKw=; b=aTFpMTKswG3GZ9yMiLpTa8UZ7f
	ij2pRZpZav+XuP08Bike3BDHx3rrgGncwyYOQ770fgIBGNoQWw5B0+L9Dd0kHLM3
	vILAXbhaT2mp3DWy+LKN6HEJv9yCrSelZMd62xZ9egCl9lMcShCMDbKgzzstjyJM
	juHNZlSyHmhG5Iwm0SjTum/eR1SBHXHi9Wn/RYL5sfHRDCcy/VincS3Ixb9mMM5D
	Gu2nKX0gVATNSRvxQZ0a4T8UVei1WzEhtIEVz5CDwGsapYHnNceb8NqY0uLCJ/cA
	9dPYhOelWPRHtRUGouOPGRuoYeoRH4cVFalVDeHEdoxYcWEfeUdDsQqG2uhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780990084; x=1781076484; bh=Es22rmbqj/3Xs9KMgvZ5fEJWvHe849JoWLN
	T0EKbTKw=; b=Xx51TW5VxTwrVGXAQ9s2xE+ThZgtPPPyMWEeZBxLcjdJL505f2/
	uNyCBko51tNP80OyMo9+WqcQgq1vDz/nF1Qxk87nXHdV+jKirpUH/FwRQtpfsjxW
	HwE9rN8c52o+pVCSFsFLNGMnlWoQNvBjhqRoP8+14E9B9Wmjf6YSLsPbAYpnxGZQ
	qY7FX3hbpx6Ooo5R3ilu1pnbEzLPyH+IAumlg5b/Rloh/fk31mrDojR1b6ON4Us6
	A2g7ZR2w9s6Yvp+76S0xCVP0kXreKI7/EFoi/Zteq988GKR5OGuwpohcDW9kycD4
	edPFfT3Vp4v+cdbeQkIrhSDHhw8iKCHgdRg==
X-ME-Sender: <xms:hMAnaiw6o4PV3Lpq-eI_vMySxq_jm_-UKmhE0fYIuWNyaGAEp15y9Q>
    <xme:hMAnakTs5lP3ixFxBRgLlAlk5vXmP6DN2DHGbOzZB5n5FFaPjVh29hZmhAYyMGx4u
    1ImLxJ4QcdZNH7KymfbSYcuY9ZY_bnx-Kd-naCvT4v5YKIqo6TIyic>
X-ME-Received: <xmr:hMAnah-nkCzHqQDG_11NT2r_Q2wCUdt8Hr18jhosjpmeEJYZIKqm000ULHKFWmt6ZeO_8sUJLANDxT6CfWlPsYCVzJK5APKMfbFiXA0nPTA>
X-ME-Proxy-Cause: dmFkZTFKYNZeeLsdKOdaBqL5gxf898Xu/52DxGALnahjdJ4kx6UyGI+X/u6x/xsFasxFlE
    Y6AO0hOGqAAVp3NRlGQm4sCHPPydFhooVMiALpIV8C/PNHMnXyJI+u9EJX4rrp1NE7/FSa
    82xNT3c+7spszJXbLUVFqo0gGf6iO5SpQRiB856kGaAkPo50rsUlv7uEVmPHpDDP9TObyG
    JSa3JIaVqstT3HRXZEWxaE9eg3246YOs51ToURdbbxF9xnfmVktHW37in92l4db2BJ97tQ
    RC8m9vN0NuvYdPyoo5n6lCDcQ3zYdsEztR3AMsgUDmMucnRZb/mq4FCBKE5x0IFL7bhtm1
    OphC7E7d3yWhpGx97dw+s/pRXlppy63uENLnCTi6lSGcRdAsWHAy57P4c3Uo8wt7/Tb7cU
    8io7xWhgGdxS1tiBdK+mS3NJhFMUYpZxIHhcUvqrqiGZuypvzzllWyINvHh2MMAcggi1s9
    Z+ceqUr/AkPTxDPgJE3gdkE7rJ5DpExf+AiJi++bLdt4q6b2SxqS8r9BZauTc6FfM1vRM7
    g4wqWmxq6eZ7mtz2TlHLkx24emunubJUsmW7jbOFDNByiDtNJpnOvmBdtpY+xOlVV8wRsr
    I3da9lPPNsc+hqyYz/2zlzeh8fUh6f/2dR3FkZsw3+Pdua5vshPb5VG57BbQ
X-ME-Proxy: <xmx:hMAnajpLKwqgANmyYfDPhn9_TJjXeI7KJcFX4YhW-tL5BKSrbHdLTQ>
    <xmx:hMAnammhQ8m-NMqnn_OZIS6WERvFF_E_82CYMWe_kXvg8ECSzKQ1rw>
    <xmx:hMAnaiL7M-2QdDSEwCu3CP7lshLwmQzYKXDp4jWa_nYn57kLssuzzA>
    <xmx:hMAnajwsr40a4MLrlJgd918h3I5bHRQj0DhgfOi0QXtjBo_oW6oy-w>
    <xmx:hMAnauj3TMxvuQeePXOA_aCte6mZaPMqiQBc_xr3HBlzU5iiRyUOfuJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 03:28:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f779a305 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 07:28:02 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: make packed object source a proper `struct
 odb_source`
Message-ID: <aifAf-ostt7-H9wV@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <CAOLa=ZT9PLFeVpyKph=jQOz_BHXhYgKO=-3SV_VP6p4oXLxZpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT9PLFeVpyKph=jQOz_BHXhYgKO=-3SV_VP6p4oXLxZpg@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:15:09AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series converts the "packed" source into a proper `struct
> > odb_source`. It's thus the equivalent to [1], which did the same thing
> > for the "loose" source.
> >
> > This series here is unfortunately a bit bigger, mostly because I'm also
> > renaming `struct packfile_store` to `struct odb_source_packed`. Back
> > when I introduced the packfile store I didn't yet have the full vision
> > of how the final layout will look like, so I didn't have the foresight
> > yet to call it `struct odb_source_packed`. But now that the layout has
> > materialized I think it's sensible to adjust its naming to match all the
> > other sources that we have.
> >
> > Also: I don't have anything else in the pipeline anymore that moves
> > around large pieces of our code in the vicinity of the object database.
> > So after this series got merged, subsequent changes should be of a more
> > incremental nature.
> >
> > This series is built on top of 9ac3f193c0 (The 11th batch, 2026-06-02)
> > with ps/odb-source-loose at ef4778bcba (odb/source-loose: drop pointer
> > to the "files" source, 2026-06-01) merged into it.
> 
> This was a good read. The commits towards the end are mostly simple code
> movements. Overall the series looks to be in good shape.

Thanks for your review! Will send a new version later today.

Patrick

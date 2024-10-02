Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF451D52B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872618; cv=none; b=DZPo7JxMynZvRuk6JCgNY+c1wThqWTNCFN8REUchIBj030lYaoerNTDusOOhjqRadYZXNr9IwRzmqK7z1gz28uVZ8xpOh/+85qM+0GP/reAik/mLEzsVaV28piWAF8PdJGLLiLQ8ILWbe3bSUNTMkl+QCNiWeRQqttzfsEYV4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872618; c=relaxed/simple;
	bh=yqRX3GC8CCahz5ubIhP4/lZDDD+9LwDsYxhOSZz8QXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdpAC1TosAw0ffyDGXNhEKMcOcgf/8UQ3+cXCKIk8Rd0RdPwGa4QptreuCcjpX5PqsPDrZNVHABgZN1Je+QnJ0Zy4oj4XdYW/n7eqPPF8YZosQaY+b6Ir1+qsJmaXZxRcs9sOdXAhzdKrktfHRObwzyeBZSVm2RgpTX4mxr5GtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gkCI4vJG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IM3HmcTa; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gkCI4vJG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IM3HmcTa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DD8913805FC;
	Wed,  2 Oct 2024 08:36:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 08:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727872615; x=1727959015; bh=aznkb5Ny4/
	O/fQf+N3US1PV/vhEc/VDlZ0tG8hokRQw=; b=gkCI4vJG6glAyvUHN3FXXl2NAz
	hF1cLr4giWqGIjm59JqRDxoI26EnwByG2r+NZwtKwdLhJPr8AA2VusfuVHB3C6Pk
	KQI5qPOKM0+PUpaarDWdCZtXPVCOdQeVCL7+Tdaw8i94En8jlU9ilsB/hekxFAfV
	0ZG4DKSBez0/qvveUbaJZ/zC5g7FIFMtnkrB157H2nNocaT0nWJlNn77QUPTqw0z
	iyySYA5IHdaTilNGd1OTV/lr5XjT58oPW8wHo74tIG/lMdrfXCrIdef387Vv1HE7
	go87nrXAukVacQdM/Eg62T/S/6kXdlzbrzyuc8qbmf0Q+GrVyLNoK+VDkfQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727872615; x=1727959015; bh=aznkb5Ny4/O/fQf+N3US1PV/vhEc
	/VDlZ0tG8hokRQw=; b=IM3HmcTaL6E6gUIwP9RdBMS95XPC8X/5mGkpPIPvYvgw
	DVpwL4UecIfdINChSB3uyd0oLdHbb7fhsGTVskhbHKBwBSkrqgqVMGIaB+LuT36p
	G5xefA9FbOOMNNdo+NOS0WP6fOtbLsB060+0aYj2DTsqQ8vGQc4bDfc13pCuX2Ko
	MW14q9Snjpwo8D9D/Qg/lA8yLRkw1r/b6k92T9sCgB+r2nIysMQZ4Ey87kXHp1B7
	AhMz2Qh2yDZ13dChafkHzSsoRPBiM7Q+rpP+U+iTSZY80d+OyFZ8tLzyv1xpgp6i
	woSWDzSnG/B8+se/t5lEdoKhMa/bC66oBlGxH43ekQ==
X-ME-Sender: <xms:Zz79ZpXxPfmD8sVzArubZqCq-E2oz47r68NEqSQmCUaAOZ-2uyP_9A>
    <xme:Zz79ZpnWvfn5vxhQWuq_aX0FFENbPrEEDaAqWguz-kDKro_VoCjlUnttKRyH4CAx2
    G9-4gpnGFemieNdZQ>
X-ME-Received: <xmr:Zz79ZlYtDl_Ytt3tbvJCAyXBDWQWNx7kelqr1_p-u7jEv6kxKOoyXG58LpoVcFAMQX64H0vq6o9k2dWWYookHjv_JBr2riZTiH8Cv-TlmuHLXRxB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefh
    ffejvdffkeevtdegudelledtvdekudeivdffgfdukeehkeffudfhgeduiefgnecuffhomh
    grihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Zz79ZsX979lIvTAty0y_zm9wUmowWIKqQ8ang1W8dy7aeahY5Z9UXg>
    <xmx:Zz79ZjnPDW27MpU5rGumD31cXoZRPC1xt6_cs5yubZohLeOEIFX56Q>
    <xmx:Zz79ZpcNgc71uXEBJVNsaRcvGXruDkoKv3BKwf7ykDBui0MJSPL9pQ>
    <xmx:Zz79ZtEE-spAZN_68coP9ZYdVfBzbrcliWYpTqaUBEB8wz3_1btCOw>
    <xmx:Zz79ZowqhLmJLLbO4r8KIdrENb2xuyPAv0ayPaZ1kCMy_-N_kyoLb2dP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 08:36:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b67d05c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 12:36:02 +0000 (UTC)
Date: Wed, 2 Oct 2024 14:36:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Outreachy] Potential intern.
Message-ID: <Zv0-Wv03hSea_Tje@pks.im>
References: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPSxiM-+4VFsHkBW8Y3ncY-kjxvAXSOdSom=zBQzTNd-JK+HxA@mail.gmail.com>

Hi again :)

I've already replied to this email when it reached Phillip and me in
private and redirected it to the mailing list. So I'll repeat what I've
said in my reply mail just so that others are aware that I've responded
to it.

On Wed, Oct 02, 2024 at 07:12:37AM +0000, Usman Akinyemi wrote:
> Hello, I am Usman Akinyemi from the Outreachy program, I just got
> selected for the second round contribution stage, I got interested in
> the git project as it is one of the most important OpenSource
> projects.

Great, thanks for reaching out to us and thank you for your interest in
the Git community!

> Also, my skills are aligned with the required skill for the
> projects and it is related with what I did at systemd where I created
> a new unit test framework which is now the primary framework used
> across the project. This development has significantly enhanced
> testing efficiency by improving error reporting and debugging,
> streamlining development processes, and increasing the reliability of
> the software.
> 
> I hope to learn and contribute meaningful contributions to git.
> 
> Also, if there is anything I need to learn about, kindly let me know.
> I really appreciate it.

I would strongly recommend reading through [1] and [2]. They should give
you some ideas for how the Outreachy application process is designed to
work in the Git project and lays out the expectation of us mentors.

Let me know in case you have any additional questions!

Patrick

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/

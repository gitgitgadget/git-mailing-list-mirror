Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2586F30F
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602731; cv=none; b=sW9NAsU+I0p+0eGkVTIMK+QuUU1844DN8Qv07y+GV8uOQIYdae6Ov/ce+bgB+0KewKb/tAsdpzlvamP/I5/yh3RgMFx3O1MNBlhH1WWEBkcxsgC9vqC4iLDnHuaXiJ3zuSS0JC0fVM/3wYevnAG5PcUOdHqusSc1hor8DnnudT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602731; c=relaxed/simple;
	bh=qrQTSZVQEMbf5XNre5v0hs3IAmW8Ii1SnRUJUU1/RoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYe5tiWnf7i37uBI7B8VR5znneoGHchs6ccQjmTmbY3zmLe6JHAUc7q7mwP9euQPSNU7BUAFZpqKiO3QGOT2Er7MAEpCEp7cOK4mMohVyU15OycKbXYdtR4JdSyFAqzbEUq7RE6tEqYHm5ymZwNb91ESdCCy+knUrB5kXbLwfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vdncQTUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vVErJS5r; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vdncQTUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vVErJS5r"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 224E41140146;
	Wed,  2 Apr 2025 10:05:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 10:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743602728; x=1743689128; bh=5OPpkAAK3Y
	Jd7tHcxR4nlioCH+qsRomMwliEpO9Ex2I=; b=vdncQTUfRnCSPBgBQShP72EjUM
	+5AYEpSSs7olhHyrLQE9zXYmUoO32uRdmw97wLhcHNVOxgXOhcZ0vMOqmr7Qv/HH
	uTvTXjn5UnVRL/DA7ZZIYOU09UblvuPW5gYql1usoNCZKTHQ+vtSkk1HvpQk4E1L
	B9Su2pR8qpOVg4C7cox2Eei6cy/zhvsVqt8Wew6tMhISM0eCjBO63bukPHh/9YI1
	dF864Bw9Jv9+x1kmakZHkyyRI/IDrOcQJcdtM+XK9ZGVewEFHTvXtlLa00aO4uim
	u26EILLVhCDJ6srR09HGMR5WQbOO805iEwgrGU2bLcBCl7QKm9gHICTsuPxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743602728; x=1743689128; bh=5OPpkAAK3YJd7tHcxR4nlioCH+qsRomMwli
	EpO9Ex2I=; b=vVErJS5rKKOH5KJz7/CU4VTJH1phNRj5f+dglV++vtznCnSqApr
	JzaNXdiHkdHPiDiYbyJpWZ2lyEtBUz5x0MARTzwkMxVfsvsMy2WgDcdkqf6woW36
	7KubbVv9ZRYlXTbg3KFVJPJ7L16UXT13R5ywuB89lrL+PYIGgi1dI1CxdU9kN2QA
	MRLyiIs16eFHZghzu5+DPumSuoT85OWANbHJjj7oMWkzZ45wWl7oq1mbjfJaaI+I
	IzI8sxkvIN+mMA2rzDUP51vCUwZYPSMPaCpxS6Mgxpi8J4syR3r5njZjq5oMmEK0
	tLv2I6h00dm9KtGaE7cfzblFB0nK56MZPJg==
X-ME-Sender: <xms:J0TtZxaiKQJwf3pxfQMxLYT6u2O9mNPBNaEfV9imkN90f2dkaOaIQg>
    <xme:J0TtZ4bjlxvy4IMTgaVBrS9le638Iif01pDn4laHkQnWirdsDvXmoE2GSbNxxY47u
    ieRetgYs9Xd2zo7kw>
X-ME-Received: <xmr:J0TtZz-c_iBAoSAGZBR7AnPFyeajMHVe1i9SZ-q3Y29gBbnh4mNL0dHefdkE9L_9sAOr_btASwho9NUFoh4sa-dUBgocASTF_5OxWha3TQIwmd2b9A6X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeuleeh
    ieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehlihhsthhsodhgihhtsegrkhhshhgrhidrihhspdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J0TtZ_qMwL344zb19rPoZ7EQTiRXTATLriZ7bIjRHJPvmiJpKkWbMg>
    <xmx:J0TtZ8pmYMgOPvlARPTqbN7MpsXTSdNY_jypkU4cfudwS2xyhD08Ag>
    <xmx:J0TtZ1Tcg1wA61nJ6J1CM9GsAiZfg4_zYxy6TPUWRfsd9vqGiY4vYA>
    <xmx:J0TtZ0rZJURvm3NmcfSKyR6BKkWO9DSu5RdzpAkSQSFlNgknRYcU_g>
    <xmx:KETtZ4Ij5s31KeIPPCs1HnATPDdgHc8kXxR8POPdFSPZngu35POl9dOE>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 10:05:27 -0400 (EDT)
Date: Wed, 2 Apr 2025 10:05:26 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org
Subject: Re: meson: Installing completions
Message-ID: <Z-1EJo8xHpA9qM0-@teonanacatl.net>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
 <Z-u42Sm613hMj1Ft@pks.im>
 <Z-wltqWraESmb-Lm@akshay.is>
 <Z-yLvgkJnGm0CkG3@teonanacatl.net>
 <Z-0gpxXBmt8G72Z9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-0gpxXBmt8G72Z9@pks.im>

Patrick Steinhardt wrote:
> On Tue, Apr 01, 2025 at 08:58:38PM -0400, Todd Zullinger wrote:
[...]
> One of the questions is whether we gain a lot by making this an option.
> If packagers have to manually adapt the location they could just as well
> copy the file by hand as there is no build step involved in the first
> place. I also think that for Bash and zsh the locations are somewhat
> stable across distros these days, so ideally we could just build on that
> and not even provide an option in the first place?
> 
> I'm mostly trying to avoid to eventually end up with tons of build
> options. Ideally, we should just do the right thing and install the
> completion scripts into the correct location in the specified prefix.
> 
> At least if we can get away with it. It seems like the default location
> would work alright for you on Fedora, and I assume that it would work
> alright for most of the other distros. So I'd refrain from introducing
> an option now, but if we eventually figure out that this is problematic
> on some distro then we can still introduce the option at a later point
> in time.

Yeah, if the locations are the same across all of the
systems we aim to support are consistent, then I agree
there's not a lot of point making it configurable.

Whether that turns out to be the case or not will be
interesting.  It seems like there are almost always a few
systems that do things differently for one reason or
another.  With luck, this is an exception.

>> For reference, here are the locations for bash, fish, and
>> zsh which Fedora uses.  This might be helpful in determining
>> reasonable defaults (after comparing to other distributions,
>> of course):
>> 
>>     bash /usr/share/bash-completion/completions
>>     fish /usr/share/fish/vendor_completions.d
>>     zsh  /usr/share/zsh/site-functions
> 
> We don't have completions for the Fish shell, right? Just making sure
> that I don't miss the obvious.

Heh, we don't -- as far as I know either. :)

Those three just happen to be the shells which have a
packaging macro for the path in Fedora.

Cheers,

-- 
Todd

Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CD36D
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249388; cv=none; b=sfVnnCjQY8lD2hPTGpG3KffeoVce31Afy569ZKxrceg07XXHWKfRBgKBstjZWpOjV4BTl8jNeFTnZQA21K4rBdYCdFsPtat6rPdTD4mSyfjVMPqd5UHpI4Fs4sZ7AxF/dXDxZObqaVhM2t4w5FJUiHdDrx7IspsQ2sk92HIWu3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249388; c=relaxed/simple;
	bh=B+FqnWIafVgg/kPeAlJ+X09Yx3gC/TtWIXOjec34eu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwNWrBlJmrtFohME4XKX8uMHwTXzHtNID17rWutUVDhwF9srVt3xAiZApmU1KwV827S4cAbYSmOWvo8VrWGfqG9/jQrLXkbuxxehQGOonwLkmBipi0+IBPD5oJ6EebgEcvepGjPNDoA4nlhTe0Z1CixfBMdcXlzTDSCM8J8l35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nyMZ7DRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aoA9SLcK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nyMZ7DRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aoA9SLcK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 41EF81380260;
	Fri,  6 Jun 2025 18:36:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 06 Jun 2025 18:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749249385; x=1749335785; bh=ITUneAULWh
	XUTg6ZiH0Edqm6nhlcM8trFCQai9OkvIE=; b=nyMZ7DRTA11yxPpbBn/FLJefEn
	2KF4hYd6qBDBfphfChpp6eoA5PZxiZhQVQoXFkFMXKtfVNft4qHkmqjOIy9cd9tA
	bJggP1L9ln+TL9eNZb2B2RrcQfhIK3lAR/F3KLAT6gGQwBublxk/aJDCCIodzdXT
	6buBiPbHSy3k3ynTG8T/K1f/yRbYtLcPoZ1qgcPEle7baJmB62vlWTJdcNFnVkgb
	M8KPZOwl5xucyJiOAIPwHeJ0kjKcsTXTcq149DzWi0Hb6Ebh9bnrrX4N8+6oHIyX
	FE46q9QzJjUpi/yTqOxJt9mW1ZGEYCKNeq6SQfMPNE6k9YEI6beCt7400nZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749249385; x=1749335785; bh=ITUneAULWhXUTg6ZiH0Edqm6nhlcM8trFCQ
	ai9OkvIE=; b=aoA9SLcKNuVBENln2AUWlWAqHIZgZb+E0tbzU1iqpSyL8mh+sqq
	hBPONuFWS0QxyB540BsPxhuERtEvghdf2/tNIJe+KVU5ws0nltadQzpK52rilFRn
	gL4icvVmM7Dsx8J0NbSo1cUL7rS+Z6NmaGPCvsSF6blzgdXCAWTGeGwGN2JBzlGc
	drP31fVAWuQpaXgUKNdokDfucvav+MhLYjoiZJSWmx9H1AnjlBnG764Vi/MPi8+D
	sBdqBbF8+dF0rTkr0vjCP7WuhCveLUiBmFhxRR6Hq+XzLYSQ28UmVodl96aMt6lg
	6urRmP+b4LudO6VY9YEGZPuemOjmpSrVGNw==
X-ME-Sender: <xms:aW1DaK-aKEhJIpwYpZjgXGUSZeJf-HRJq_XQgjy2r1jdGGj0nnOv-w>
    <xme:aW1DaKsyjdcx1UqTwmNqzKsIka_ytINY_ZLhVKrshSDBTbSG6wUWFtXb6vFC-CaNs
    eLb0pQTCwmlklBGNA>
X-ME-Received: <xmr:aW1DaACNqJnpmif840Akc4hRVM3lsxX69j1EbrN32-OEVttBzufVN_yNdguDkSNR0EDBT3qhgRYePGlNXKAI1bcags59Vf2_kb9N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdehieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgvsggrshhtihgrnh
    essghrvggrkhhpohhinhhtrdgttgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aW1DaCd1VRy4gfnp0sley1mYIPZclOnFyggLFJE_ORosWgLrXNqUWg>
    <xmx:aW1DaPOv2-WsSFq9nEx5jsOyoh_Tm2Ob18k8yu4_VRcvASvkfohuRA>
    <xmx:aW1DaMnYiK0NyXOJuTeGHQeVLjuHOaVlrotOEMCptHgvDx6KCTiY7Q>
    <xmx:aW1DaBt18m8Z6spqLA0Jthxqmk_PcLzAARIlMIG7A8txgD41Pg9QMw>
    <xmx:aW1DaA8evEFMe8NnUSoD1F-PqOfVN_AnyfFs7ZZK1sOO645h3xUJd_Nf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Jun 2025 18:36:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl*
 macros.
In-Reply-To: <20250606220455.jhicNLuK@breakpoint.cc> (Sebastian Andrzej
	Siewior's message of "Sat, 7 Jun 2025 00:04:55 +0200")
References: <20250606165718.HOiC2U4X@breakpoint.cc>
	<xmqqplfg1sym.fsf@gitster.g> <20250606220455.jhicNLuK@breakpoint.cc>
Date: Fri, 06 Jun 2025 15:36:23 -0700
Message-ID: <xmqqcybg1orc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

>> ... we undefine these two macros for _everybody_ here.  Also let me
>> take a mental note that we only undef these 64-bit functions and
>> leave ntohl/htonl intact.
>
> How so? The ntohl/ htonl are also replaced with bswap32 Or do I miss
> something.

Only sometimes, unlike the 64-bit one that is always replaced.

>> >  #undef ntohll
>> >  #undef htonll
>> 
>> This is related to the "oddity" I'll mention at the end.  

>> > +# if defined(bswap32)
>> > +#  undef ntohl
>> > +#  undef htonl
>> > +#  define ntohl(x) bswap32(x)
>> > +#  define htonl(x) bswap32(x)
>> > +# endif

This is ntohl/htonl thing.  Because we do not have
default_bswap32(), unlike the 64-bit side, we do not touch
ntohl/htonl when bswap32 is not available.

That is the oddity I mentioned.

> Ah, the ntohll/ htonll gets undef and defined later. That is the
> "oddity" as you put it.
> Do you want this reposted with an improved commit message or do you want
> also the undef for ntohll and the identity define removed since it is
> not required?

I do not have a strong preference either way myself.  As long as it
is clearly documented what we are doing here (e.g., we probably
should tell anybody who includes this header file that bswap32 and
bswap64 are an implementation detail inside this file and they
should not use them themselves, or something like that).

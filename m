Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA928D068
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104041; cv=none; b=FV36mXyGewuavuSu6/A6ObTCDPtBjq2zxQVAhvnrsAC9e5zN1R8MboJedoUGTWtnBxG7QNbAwimWbP32uL3PcoRbCu255EWLjfG0rp2p0AEndF8rgJrh10WqIJrGM6ISYci9Gn2FdLSgKWjDGqLfxVEB8KEFUNfGo7WAZNV+at8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104041; c=relaxed/simple;
	bh=VDn1aDDf0F19GV8kxUcyOfuHR5aCgbbAIEyI4Bi6u7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eU/BGL0V3LUBTObOz+WKPEOBEtaPCAtYrndvmEwVOQ9QFx/DUqacIzarsYrFQhMkoUJZ+RGPA6+6f/CyWFxbtIvyj0+cugQQTsyi5Fuqazuajc/P2WEbg+aOEz99hZk9ui79ILcY0PRHVAkCDKqtGRXssRaTq5Urxn0Yo3urPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c8u5K4I3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/zYqgTk; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c8u5K4I3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/zYqgTk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 82A4D1382734;
	Tue,  4 Mar 2025 11:00:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 04 Mar 2025 11:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741104038; x=1741190438; bh=VlezzoesWx
	5MtXsQfeHNqQN5f9oA7MC3Sp1YRosIfFw=; b=c8u5K4I3xczVmqRzMXTrlWvW8W
	CPGJJ97ihm0kHWFMtNhTuA7SGF7M1U26THoeccZGSGH+2mZZmIUgg0TIwVFtDyiV
	0PdwiT34zznojZKQ3PECBVLigeAHF4uSwYr4pS4GtMcG6y9daeEjSygwB7II35TV
	HX3rIvGJoRGZO83ZpUAGkrp5sw9n0S6GziXCmnKevrPaYnB/bud5XZFUqdlHc2/a
	4vmo2N0bjvyk73dkypPAltnWeADeocwPTr7l+a3So5jJUqunk3zUoh6YgwGXbIDQ
	VeD0DRsVWdDMaQDpYQixGYUG/yJLJkH2BvwntqApO5KvZoyNnp9oIQobAq0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741104038; x=1741190438; bh=VlezzoesWx5MtXsQfeHNqQN5f9oA7MC3Sp1
	YRosIfFw=; b=U/zYqgTk9mqh0U+8q950wPhf5dRECfHOnsUlpOpCRIAuwrZ1m3E
	Ua0B8HbaRy9AOoolPDA5CakADDkVpVflZ7pObsnwSisGexBSURYcqXV4TEnX5R/S
	eiJ+dRAdGZa/pR/VyEpHUnNJhNsOEStavgVfC3omnLXCvJmuG61MGXW1UWVMEBlr
	/AtyVsrETtNdbjFmVwqqC1LeYrDLuZuHDT2Ar8ljkSTlw1EAkCtGwcoU0PFt/RQ4
	1PyH1UnW2Yf5aP6HuqOIs7wX8njervEizTGIl/Aezg39wuYqxado49wrQrvoDzOp
	iMPJjxxl2u5N3JS3MDZ03kA66Cucnr15SbQ==
X-ME-Sender: <xms:piPHZ-UFOhISfvZ8_5UWGtCXqgKEx40_HPWK8o_YW_fl6gIANtQeRw>
    <xme:piPHZ6lcEjGOzwfvVowrYn1DKhUokzLHyI8SFWzTKETmbJMCSvsV7Rxt-AMXTv3nE
    VLoPVstroWeEdG-JQ>
X-ME-Received: <xmr:piPHZyaiPVVdM_1eVBOsdW5plvDfQsmks4fWWFuiSsXmNw6gl38VhjBbs7wOR8eQ_bXe4S9apiaYR-8VC9mB0h5zBihfwxly1x4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhimhgrhh
    gvnhgurhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:piPHZ1Wa114roBiUB7osHTmPEdJVygG5Ljt8SjLOIrS1W3M755bbrQ>
    <xmx:piPHZ4nYFE9f-xbXGmxuGgRvg1XYAJjloQsCGuKf1LJoz7NHj0zcTA>
    <xmx:piPHZ6fknVMVyrMIvHA2CZniyszcA6m1SIbkWXnmXIPvs0SfzOnplw>
    <xmx:piPHZ6H2OYQVYESpErM_wrbF5CPCtA3kKfyKIv5c3NIy3a8UkoatMw>
    <xmx:piPHZyiYKYPUCkGrf436TfcZ2fbeIUEdDqpP5gkmUhTLdYVzubJ5DgDz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 11:00:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mahendra Dani <danimahendra0904@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSOC][PATCH v3 0/1] t1403: verify path exists and is a file
In-Reply-To: <20250304094153.28959-1-danimahendra0904@gmail.com> (Mahendra
	Dani's message of "Tue, 4 Mar 2025 15:11:52 +0530")
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
	<20250304094153.28959-1-danimahendra0904@gmail.com>
Date: Tue, 04 Mar 2025 08:00:36 -0800
Message-ID: <xmqqv7soss4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mahendra Dani <danimahendra0904@gmail.com> writes:

> test -e does not provide a nice error message when we hit test failures,
> so use test_path_exists() instead.
>
> Further, verify that if the path exists, then the path is a file using
> test_path_is_file() helper function.
>
> This patch does not change any code in v2, but is rather submitted with proper formatting
> which was lacking in v2. 
> I apologize for the incorrect patch submission in v2. 

My cursory look didn't spot anything iffy in v2 and I found it
nicely described.  I do not see anything, other than the above
3-line paragraph, that is different in v3 from v2, which is a bit
curious.

Thanks.

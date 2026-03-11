Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8878D32B9A8
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258517; cv=none; b=m49H7/DuhGHuUOTX7YhB5w9YW/QA7X857bsS7SrlKK+UKmnYj8eCSWM1UcsRt/wVCsst6oACS6jowElTlQx+0W9vWG9C17RYQ1+jduDTOzEUGVDufKIYEAy9QKk1pWi/PnE2ZUQUzVimEzxWfgJsyobsVr8r5kD3xiEjiQkL2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258517; c=relaxed/simple;
	bh=hjVrYbWzQS5bpP9LhfpHYubY78L/qif8LwpISUju71M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSZlcRMK0DP+A0AA+XgwAMzp4Q0CUenzF7qPoHkrxW3H3bm2zwglbbloZ1rmYJm73QHU7D+Tkq5xBmR4+Jt0q30Juju7bgzYq4OWyRJpJ7WXHWjBN/VGmklyEgsj4J6A6+PMT59LjrhR98mTdnd8hHOGSrG1BR0cwbTL9SpDeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aFuWOn3P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kiwin/Zn; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFuWOn3P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kiwin/Zn"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 766797A01F0;
	Wed, 11 Mar 2026 15:48:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 15:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773258515; x=1773344915; bh=hjVrYbWzQS
	5bpP9LhfpHYubY78L/qif8LwpISUju71M=; b=aFuWOn3PJCZKu+N56/bSs9fiUV
	zL9VETSZpIBJNqF5yMJHLBUEB1l4FQpM8YJzPvD5YXTzaSHmNggk/6hsEABVEo4g
	97VuuFzoebm+2iXMd5HLUqYLYffH+og2ckm0FcUCbst1+HRzTKVAaqwJ01QV0aWW
	6mI3/t/dC4WKh5vnmjEaWmauhwhDvsbFPHKNZNPI+O9FVoxQwIYmwte/6olYCcX0
	LW8VGp3U4H0860jtS/hzdMqAsZabxGO6Bfi2RWF9OiLE4tdS9XymbDMQrOXM3cmq
	cba+j5gxTnY0cxucUI5sIf4xMOne06PSjcSp2JRoLmj95fREXbaiOYLPycVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773258515; x=1773344915; bh=hjVrYbWzQS5bpP9LhfpHYubY78L/qif8Lwp
	ISUju71M=; b=kiwin/ZnihtnccKfZoVh5goYLSs4nJlv4rmIjBQsa3jtbMM7lzR
	RQvlAKHM1O1bJL8jalCSahv9X2PZM53AAle1dbHQt1/dpfDKiAfSNlrqGjMZ2cDC
	8nX65AjTozR5M8RBMlnkRkPGVCxKPQ0mqKLbw+iWuwStAAuue4yBdIBhMExo6nmk
	8XPurVpjZ39Ce7AZ4f3TnmTim+qGDINAsaPbR5ykoBw2aP7BDCz3cfgPl+e6qij6
	rP97UI/x/XpMjwMKLgGKXLkjfv2G+2zeM1DHir9AUF+lz1zEaZSs6D9msRrqFucc
	7QaxYhLhcEUnKBJZ4nSyJMVHX2rRVNPdKqg==
X-ME-Sender: <xms:E8exaQeQXYAi6fTQaOvsgt0-7jbsXpK2lElGFE-CVxdKzEHy6XCncw>
    <xme:E8exaV7eIYd6P5litsqZeGWGAzU4Dh_W0evitAWf3nRL_Cua8sqRTtUEh5FqCkpyg
    ER4q_8VaSRo_awiTHW3R8n4nwJtAA-l1uFb4KlaeOc3oGb-hcbBIw>
X-ME-Received: <xmr:E8exabV8n8LSqqkDiq9wkAG_nq0RbtprzH_0zwBzGo4sfmliI0TUMiLo8j_9nAGviNFSv54NSd6Z-FQPdUWWtL4DChzuTvEyxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    hishhhhhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhdrshhiugguhhgr
    rhhthhdrshhhrhhimhgrlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:E8exac4mvPilR75i2Ov4OqFZHFhmeolm7aujb2mRvxQBouw5B1tFBg>
    <xmx:E8exaepoV8PXKWDT2CrC9cS7_jIjZW1tvTy_G2xAJVkd1IAWkK04ZQ>
    <xmx:E8exaXkGYuchz0Wlk7jxg80KMwmP3hQPik9U0y3GTV-MskfvcA4T5Q>
    <xmx:E8exaSPuIYqo36neu7PUhYhvkm6X3V9KmS8BtzETQGKSiJvhY91c6g>
    <xmx:E8exaVCgojngmaLEFScmmRGRm7u_9L_J7M08wZAAQInjZ28xwdHLlu4N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:48:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
  git@vger.kernel.org,  ps@pks.im,  jonatan@jontes.page
Subject: Re: [PATCH v2] builtin/help.c: move strbuf out of help loops
In-Reply-To: <CAPvEtrd9Yri5LQu9DiMAO4EDquyd-JxwNBGn+h=+=E+oKJ2ERw@mail.gmail.com>
	(Amisha Chhajed's message of "Thu, 12 Mar 2026 01:00:51 +0530")
References: <abARj_VI9n2nB_xT@pks.im>
	<20260310160029.44605-1-r.siddharth.shrimali@gmail.com>
	<xmqq1phrtoen.fsf@gitster.g>
	<CAGWgyh_dJX7TteKjwVXUwnmUL5kmZifpA0a4n1RiwRvCBEY5gw@mail.gmail.com>
	<CAPvEtrd9Yri5LQu9DiMAO4EDquyd-JxwNBGn+h=+=E+oKJ2ERw@mail.gmail.com>
Date: Wed, 11 Mar 2026 12:48:33 -0700
Message-ID: <xmqq3426no4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

>> After looking at the refactor of list_config_help() in the
>> other active thread, I agree that my optimization is no longer
>> necessary.
>>
>> Amisha's new structure with set_config_vars() and set_config_sections()
>> is much cleaner. Since the logic is now encapsulated in these helpers,
>> my proposed changes would not be applicable.
>
> I feel removing out the strbuf initialisation and release out of the
> loop is still applicable,
> I have added all the parts in v5 which were not fixed by my
> improvements and tagged you,
> check it out here
> https://lore.kernel.org/git/20260311192151.60489-1-amishhhaaaa@gmail.com/

I love seeing two community members, both of which are relatively
newcomers, working well together ;-).

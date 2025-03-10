Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFB1A7264
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620282; cv=none; b=G3aSQCPx1uRpRBpic85gVoku09e6hWRdlpLN748znZ7njXZcTFVD7+rqm0OG9uA01eISQ4HdJhKfEcmt6NjE6J5NgEMV/jzdReFLSbsT5z5VyEX84xoVRZSp9odj3iAkHCqfx0Nfi9z7iL28BNlx0sahtaZNmfRmpdIjsyuS42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620282; c=relaxed/simple;
	bh=x2r4gjbMZI2R47tRq2xV8HdMG/2g/5CwQQ/ukRfYXGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YKHAwMNn8sVZF6Os6jsVyKTsfPnZXU/wntnXw1t3lMllEDnvuQ81bbfFjB21ubMmAP0Upy4IFxKMLYd111du7apQe5slJ2QIbUjZ09w4MxI6xazrZDHSoizw0/FdKh4kXuMFpyiWH/JvjV6WTEt6s1giaaG/rL0bjCFhQjitqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGkThLsg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2GCtu2JM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGkThLsg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2GCtu2JM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 054EC1140091;
	Mon, 10 Mar 2025 11:24:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 11:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741620278; x=1741706678; bh=Qq8BFF09Kf
	+5bAQ6VzPWTxy1dksSAB8Ni7QyCeRrpy4=; b=lGkThLsgES4hHPIIiMwaWQe6NK
	j/71EcvaRkffgrSNjY6+etXQNR56FxCqYQYhxTt2zWM1l775zw719mWGHtlBztt+
	P7dLhH7hmvuV6WheZEp74o5Trg3sM3+Ct+U7XpyE4vhIW8Mt+Y8+u9rTSiUnve3x
	forxtwNqJnsSlbeawo+8eFVOu2pMSjnXOosLpdR2O8PYzdbGjNqbxA91vq25xixG
	QKuguXkCeCWSkpiPFEi2GDkQx82If2TZxK7WbUV4OB1+oInrh60Rz6XAuIug3qr8
	bTvo2bwB9c0cwPEm5V6idLPHP+XsfoJzfyeJXsIAwWW/bqWJHg1b0rxnT2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741620278; x=1741706678; bh=Qq8BFF09Kf+5bAQ6VzPWTxy1dksSAB8Ni7Q
	yCeRrpy4=; b=2GCtu2JMU0Pw8VKvYU8eyXTXArmWjimc6K0NMYq4yVZZADf0tu1
	QJvLiSrp27npxNVTN9O3rBabUAThLFvZJCItFgL56jvKPuSxw86741iJBAU2JMtv
	tHqFvGQ+DkO0k/9zNBmzxKyn3zLHYSdRk+mvouH5nIcQFXk17IretYCuK8UCeDpi
	HgMyaOIglHGRda8Vd0ODEbf3RFZ6wG0QxPfAjPqtEFJh5zLX9Z7XPCkoblOmEJOW
	3EuXshyNoIDZr2dCVGTQ05L8IaihaaBXNmzhDCNr9aIExLPJ9KvV9YP2PiBs3yZQ
	1mK8DJSdLyXDdvuh9FcMN2NuyZVuZdRTnfg==
X-ME-Sender: <xms:NgTPZ_VDzw9yHPUXUEt4MjHTjmK3PRqKgyP9Xbu-dPpa-RyyGJt8Ew>
    <xme:NgTPZ3kpIFb0iax2L08FjBKYFTa8cHVseCdMWXcCVvHOz1pl_DhkYQ1WDNgJEBjMZ
    nWxTdfGR3YS2zSJng>
X-ME-Received: <xmr:NgTPZ7a24LH7O4_1SYCGQ6YQle6J4gUf_R6DuqJqNL4fnXqoJjOA7HUexpZg25f5wQtNGwU9LO-bwCPgVV5Yu9FMFNcW-fqOGP_n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NgTPZ6W7gCkPOP2_Zh7JH06mzBSDqd7MafIHb_ELIS_jBihgHERrqQ>
    <xmx:NgTPZ5nnxaL-XveeJQFtOvp0t8IT-fJ-2XoqlMDjZyjf4q5IqUDgIw>
    <xmx:NgTPZ3euScyT_74nNnjlyRYxMYHarYj6Hy-_POaapSVV8_HItACn8g>
    <xmx:NgTPZzHEb6jI0T2djwHh_unVqfrUNTHR2v8RFD-ZTeOdSLzWGRbLvw>
    <xmx:NgTPZ_jLth7KBxTQboc2PzXlNs1VqokF_HW3EioQ_YRLE3gWOUIQRiJH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 11:24:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] reflog: drop usage of global variables
In-Reply-To: <CAOLa=ZRqMnus=MZV1ASce4pxnMkVRGqhZZ+vZNcGhWdUQE-JRg@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 10 Mar 2025 06:41:26 -0500")
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
	<20250307-493-add-command-to-purge-reflog-entries-v1-1-84ab8529cf9e@gmail.com>
	<xmqqo6ycczdr.fsf@gitster.g>
	<CAOLa=ZRqMnus=MZV1ASce4pxnMkVRGqhZZ+vZNcGhWdUQE-JRg@mail.gmail.com>
Date: Mon, 10 Mar 2025 08:24:36 -0700
Message-ID: <xmqqsenkaoy3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> but I also suspect that it is mostly due to the original program
>> structure that uses OPT_SUBCOMMAND() that the subcommands fail to
>> respond to "-h" unlike the top-level command, so this may not be a
>> regression.  I do think however that this change is making it harder
>> to fix.
>>
>
> Hmm. But this is the existing behavior, no?

Didn't I said I also suspect?

> But point taken, I'll drop this patch in the next version! Thanks

Yup.  Take your time, as it is already deep in prerelease feature
freeze.  I'd prefer to see us leaving spare capacity in our minds to
fix regressions introduced during this period once they are noticed,
without getting distracted by shiny new toys.

Thanks.


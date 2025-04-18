Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FF2741C8
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982872; cv=none; b=Bpp9D6yPE7/vTXhw2UmcV+oebJz0uZMAtdX+nV1Wdpnss0qN5qDq5Thdf1377/ETxQ3Hh1U6QpDn86YYY3OgFBxdG2ZPxRHOh96mslMYmiDyGlsmyCnIMWA2iOFfzeJ655RG/wsJxK4YrzZVIItr0guWb1SjRfDtEdSpKIhgj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982872; c=relaxed/simple;
	bh=NL/vjdYUxp2ztsj3EEb2tYbpOT0lyJ6QB7+nZGdU5pw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOxJ+gEuVVSVSiUPKMc9l0NRrP1DiCsrAVIFdh92R+lnAN/CACLYiBZESJTPFLOUUY+94s6u6H1kdb47uKBfF7fDORHDPHg5YdpuiOjDVbx/PL9NaX6b5gc0VFdGhiwbzlyf08BSSI6HeYC9J8LAkbtLR7epJHCf2E2dlmrsy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iw7dbedj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sojPyb2L; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iw7dbedj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sojPyb2L"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B72D13801A6;
	Fri, 18 Apr 2025 09:27:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 18 Apr 2025 09:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744982868; x=1745069268; bh=RvG9zE34jB
	z38gknwZfjm7QHgknYGw1v5ybXw6tIMck=; b=iw7dbedjxWtsrQlHW0HjMMP3ut
	/J1kstKwi4SU5x0zFxRuOy0kqGTwhueKcBeHQ6ZuBN2tC+0FmYOhsvOspP73+RNz
	qUmrXisZwFZQb8O/wR4xDX5gZ4BK2mXV+YqykkmShefjWpbYl413K4xSWskNKrkn
	L9w5PGDa1stJIeMzDvycl7GNG8fxqL35/zmp5/nJyHFq2Zx5Xve+5ItwU8r6H2ND
	MaSFcp460qFg0mX9cqnUJX+97DK8HQB60x8De0bR1LIXoi66zFAme3c4lC8mGIhn
	Iw2Vnxriz3Ue2qAw39Yx+Chx+0x7cDVpMW1PjNJmd+/9J/Dm4H9zLCUYq3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744982868; x=1745069268; bh=RvG9zE34jBz38gknwZfjm7QHgknYGw1v5yb
	Xw6tIMck=; b=sojPyb2Lh6JrT3BmQBbuS6SCVlmwU2lmYD9PrgYMq0l++MXPta8
	rj+B59yzhTaEflLnhfnVhovfcPZd6IAA8K5jOf3nU6hZykU33lufZugVGaD8T2Dc
	2Y8iMkbTWH7mT1eX+MWyhbsuQcpYp8dmjEjs6Klaoc4fl6gQzHus/XDP4czVz/PO
	EXro9Np4horaZQhJ3ypC8EV0Z37mPN/4zv4gbkYzL/YQaEoVPRQbUNO/JLxPreCF
	ePtf5yzvdDkRPrCxxYFDY0/7/zT5vEeoAdquKOdQ8VVwX5dQSbRJM41Kd7iYITZc
	HtbWgv2mT0j6jVeGax+UTNA2rN4H0qaiF7A==
X-ME-Sender: <xms:VFMCaFRrbw1yRtZzLdW8aDwj0MfF4HUVcmATYc62vzrJdvzoCES7_g>
    <xme:VFMCaOxGROQ5hzthyUwB36kc_LlAL_3vbplNxBQoTKMKjnSYHZ--_uWFHc-SzM3ZL
    ZNTNnIS_a2JDbe-dA>
X-ME-Received: <xmr:VFMCaK2SuokulRoOPHWlNctfPuod52i6fOn6_jYpmjCPlH-5ZYiBaV6lA6GZkY7JnDqAoLkBBvkeomg9AyOppc3OqtXlwdpNnmGS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehkvghithhhrdhsrdhthhhomhhpshhonhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VFMCaNBNl8bjJHmtTdwXFFDOk5WQ1I_WlXzO8m0pyY8VA3vVVKJm_g>
    <xmx:VFMCaOjFWNas3wHrFPrcJGsKKLLuYJ689ZG1rLi7DJ-ceXnUjbtNag>
    <xmx:VFMCaBpQYSgJEMLHnLY7FmsSuPyF-roXPWhajq24f9r5IoomqbrY9w>
    <xmx:VFMCaJgI_HVzD0H30-F8bJZtl-f2eJx6ydojySg7QJk4idZfkkZDrg>
    <xmx:VFMCaJb_xhWqDE6Uiwzf3btHG8UqcnxplicHlAGO_zPqIEiAJBnxUpa1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 09:27:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Keith Thompson <Keith.S.Thompson@gmail.com>,  git@vger.kernel.org
Subject: Re: Bug report: Minor glitch in "git help" error message
In-Reply-To: <20250418091612.GA10441@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 18 Apr 2025 05:16:12 -0400")
References: <CAAHpriMkqapiJuUGimn-i8SqcZmvmc=Wpk6oUr844uAkCYgMxA@mail.gmail.com>
	<xmqq5xj2clcx.fsf@gitster.g>
	<CAAHpriNYikDFwiTpjZEupG4yWOkbzW5DnBcsUnBKkfxxxtWNkw@mail.gmail.com>
	<20250418091612.GA10441@coredump.intra.peff.net>
Date: Fri, 18 Apr 2025 06:27:46 -0700
Message-ID: <xmqqv7r1bnvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ...
> So probably a bad idea.
> ...
>
> The other thing it's tempting to do is teach "git help" to check ...
> ... We pick up
> third-party commands automatically by looking in the $PATH for them. But
> I don't think we can do the same for documentation ...

Great write-up.  Thanks.



Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BA2EDD74
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231073; cv=none; b=XXwwc0XA0ieE1y+w+v2sh8ETcTFEqfkxMrQccrVQnyMc+p3T7pELknByoJ9G6Y+rQMevpR6SGeg+vZNMrQRx4VO45+gjyKozNiHke2BRNHR2yXpcsc1pKLryD8yzI2QsXczBdZWEWEkhOvrcpvHU2I30Kzejat9q9v4gHFM2UIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231073; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KhErkz3jyo0iB0iOeCeC1DXD8azCg7xQnol+v8QuSe+/F+bHWcBT0J8/eRSmfbvpo48Tp5tWtF4XN60QSyKNUcAiQVhK2UrbhHYswi7gWloFmkMugK+Vv8dDjLx0vaERxT5M4JCl2Igxdhi4/XFD3e7KB/lcXVhptIm4t6W7G00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gF3aRS3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qrn5d/Ih; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gF3aRS3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qrn5d/Ih"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0251F140004B;
	Mon, 12 Jan 2026 10:17:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 12 Jan 2026 10:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768231070; x=1768317470; bh=47DEQpj8HB
	Sa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=gF3aRS3ORwxx5u6g/Dal5ymq4l
	YAvbyYpsRalPXQRbqdOvVkj6XaGLCVcivD9jKJ6H+NFfijtUxdMPwVryJdC/YqBO
	dVaCjzBVXoQIazKSCZV3QQVXRON7TIEjRduVyHIgJShhochqBDeCw1Mac9UCiMh2
	2LWHp+jveoTGmSARyqJCwov87ASaRCwYCmCUrZIc+1BL92TR0tpjN6kYXAly2Zd3
	1MWB5JEfTZt6JfOfgTxb/p20BydoswrWKPbNcBrwD39I7u3iYhcLVHo1fzE7iPp3
	jse/MY0DSrpEPtUMlI059QAEDHEC8bELkEFiiqwTdco45b/2GhzAYQ/rt3Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768231070; x=1768317470; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJW
	ZG3hSuFU=; b=qrn5d/IhQMIn9EFGvK3w1nTiMQupifvcoO+u0lKQAUXgznl0tNW
	P8V6498xhxKdJjUtEIR5K5FFiL71S5LiLqM1RHjn6/NBPkqWwqpZFHG3IcCs0ESE
	WNuF+kCzKNSXNfn98ag8wR53SzbudE9eWwy5HAmpT+C40gsZfiJ4MZdeTIUgxE/G
	NvMvf+kZ6zS/ugtmIjRU+UpQnnzD+Fgp2oSQhfL74e5sZZefgT0B2qli70xxt9jW
	CdrOElx8I29QtpQHSQKHuirs5O80d7li9c9gVQKcUi9GeRKnxSAg6/j1f5ME6lAy
	YU7NDpnzWHcm+uiFuSIgkalL64I1GTetBoA==
X-ME-Sender: <xms:nhBlaWl1GdaMfgHX3hiHOh-jI-B-24Zb_I9-NWJa60HkYam3ohSJMQ>
    <xme:nhBlaYZhCcHonkZgWl5W2DdpzjS0NXra9xuo2WdlsMXmqLpfzf-Y_HOKTKBx8EsdS
    _-rmMVB2IFFO2FA4FjP1znHInC3OvtKiNhpNqGp97FOIRQiqy4-dQ>
X-ME-Received: <xmr:nhBlaRP4RJOZKsjhF1vr39GNQBA6HfDHse01VDYOtwdytRPDAv0p2PKFoUzDrd5g6gG6h3I8hiFoM-HyYLKq0r6bsU1lOeIglzkc1vM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnefgmh
    hpthihucgsohguhiculdehtddmnecujfgurhephffvvefujghffffkfgggtgesthdtredt
    tdervdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesph
    hosghogidrtghomheqnecuggftrfgrthhtvghrnheptdeghfduvdetteetieffkedtfffg
    udetjefhieevudduueeivdelhfeukeffkeehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkh
    hsrdhimhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:nhBladbnA4RZLr8PzHru7EknjH9xncOF_4kHGDb_MIyJVLm46hEiAQ>
    <xmx:nhBlaf1H0lMzYB4PltJgtFwztRBS0dx6JUcax2jEQRzBr3MdjElUNQ>
    <xmx:nhBlaTcIXejIt9PLDxnabIx1tgMX7luPettfG5_Ia9LmReC6E3vEjQ>
    <xmx:nhBlaQHQ3uREmA5INwE3qw4PZVZ0JYOVCWEy_fQBMZIgiMiq4ikY4w>
    <xmx:nhBlaYYY4Lvai5EUMaJTjYUgiNnMnIL05AuPqT8QaCan3ojFXsQ0iJWn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 10:17:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
In-Reply-To: <aWUMn6G0C1cHA4qY@pks.im> (Patrick Steinhardt's message of "Mon,
	12 Jan 2026 16:00:47 +0100")
References: <20260109213021.2546-1-l.s.r@web.de>
	<20260109213021.2546-10-l.s.r@web.de> <aWS9Ll8CQ3eILx3z@pks.im>
	<xmqqh5sqoqr0.fsf@gitster.g> <aWUMn6G0C1cHA4qY@pks.im>
Date: Mon, 12 Jan 2026 07:17:49 -0800
Message-ID: <xmqqqzrun9lu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


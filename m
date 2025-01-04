Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E9186A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 02:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735959323; cv=none; b=pKXcBrw7Q0mi4k53/pX+zAZ4WFrUMRrf8rsiDzacw3cwUzFyHShMPiBgaAW2CFJmeBKkj+W4uwwGV6JnyoXoYgrH1mBkIZgJTPKo3FOvXf4v82Xvk5ZWletshIWosVlLSejlGj6NtHAo8IQZtVM4i2eMmZFKek+BerbejzCYc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735959323; c=relaxed/simple;
	bh=lMwyDP/Xe0VWzeG2uWgIyqG7vnvBdReMgcP91/FU93U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz+pBDlBhOcNw+MiYgix/09o/yxUJ9+RpFXBVcu3Urmli8TQDQBYQAcsFJBPX58l4gTu7Z7eN+ZQJNJo6PwlJf1CezU7Kr8FtDuZorBxaLe4XEwdywR2N73U95JDlhjOXS9ERVTXSuOqCdjiTLXh52my6k+2gByIt/ow/OawRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nOXmGFah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RxaxrN55; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nOXmGFah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RxaxrN55"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9988811401DD;
	Fri,  3 Jan 2025 21:55:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 21:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735959320; x=1736045720; bh=ciEoyXrY/W
	9BMNfZ5ioOAoJAve/Bq5LA5iPam704Y/A=; b=nOXmGFahH5D2dyefc21sHqaaKo
	od9XXb/TPkVf+7TNmR/v58gjkiUx6VbWjAzlbhaH7/ObDiERFtmoDyx16pCwPBc+
	m70r+ppe2mZWp7W/XsVe7x59m9Sr2tz2Xn2qZZHD8vNyDf0Edy6HvYNRPtq21+mT
	Y5/0WuG+JdGpi/UB8AvdqD0JhxGqU6GEur1jm2kAS95xTIZhH/VBNfaFLoWDsfTv
	MepxSFoZtVEV/06e1nVx5TbbNlD8bawfYp2fsn7XSwwo0LYlxb6SPcu6dKO7qu6o
	RRjSH7iMhDAvCYsoRLNBuWB92TNWEgf5JkfU8+KPsmOvZYaRRcmSn1Hj6H5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735959320; x=1736045720; bh=ciEoyXrY/W9BMNfZ5ioOAoJAve/Bq5LA5iP
	am704Y/A=; b=RxaxrN5541icemxtCyJxG7sFQWplfmGnXI94ZMR4nXb5j2PlJt+
	w9oGWKtgsdk2fbRPQXrc2pH/ranaUZ8J4TqFmc1yM5UlXeZw+jSh++PIzu7csGeu
	qx7AFbATTvk1jCws4wPo6Th4G4E34rvaM1R8aXGASwrESL6MhooU6uhWygVMfEIC
	VQMZRJLGv+H++hfZPfKJiknnCpwBxDjYJb/F1laikJiZ/S7b9+sCLLb2zUCRVIB6
	xTeLW9IXhdzQ1aamZtFB5XxdlVMh8PPK5rjQi+wPFumZ+wwkQyouF2lxDPz4hNEf
	ac7IPIPSbJbNT0TW2Un+nSRF5X1EOCqBUyQ==
X-ME-Sender: <xms:GKN4Z7Rh859K03VXHrdw30WGZr5j_ULBRyIMe7BKmAWqFfV6oWaBIg>
    <xme:GKN4Z8xtTjaWGvInglpB1UCPDQos64bbUa57JYwGUTab7xiNYfAf-6ZUl21lD4aX1
    IhvBKLM4u99Lum2tA>
X-ME-Received: <xmr:GKN4Zw1geq1V32-WrkG0HTMlWpiOsV8x1ANRYCmHt6kzIl3Ju0gdJH4DoWPfUve0jEV92ZcmE-i6LDcX5tylm61p36fhXVF2Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:GKN4Z7D_Reaw6WlJAYJFxQ-5yc6PVyihvF1NQFCeb1BVPwJn5fH1HA>
    <xmx:GKN4Z0jCCYIEjuTjmZdZONzhgqro1OiiZeQtTOQ3manKsuE8NaNeUg>
    <xmx:GKN4Z_oE-y0HnuqcjRz6CyHjiLuv0So-XThvcaMVXM0Mct5ryM64XQ>
    <xmx:GKN4Z_hLb-_AgEv_zmHLNPyt7_rHmO4mAWwdn6bQHHw2w8B0u4tPaw>
    <xmx:GKN4Z8dhUVW39UOXECt04pkhwdyW6qRJdQRrUK13XASrubJWHYWe42-5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 21:55:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Wink Saville <wink@saville.com>,  Git List <git@vger.kernel.org>
Subject: Re: [BUGREPORT] git diff-tree --cc SEGFAUTs
In-Reply-To: <20250104003154.GB3244554@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jan 2025 19:31:54 -0500")
References: <CAKk8isqpAXLoiXxOP3uAc00M+OM0FaU3Uhnt5R1FnFMD=xGARg@mail.gmail.com>
	<20250103204624.GE3212696@coredump.intra.peff.net>
	<CAKk8isrz1NQ=3=2aZ3tANymo0eSsCy=r6W5yKgn6gxmOom54CA@mail.gmail.com>
	<20250104003154.GB3244554@coredump.intra.peff.net>
Date: Fri, 03 Jan 2025 18:55:18 -0800
Message-ID: <xmqq4j2fnv8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... OTOH it is not really
> solving the more fundamental problem, which is that p->parent[i].path is
> only sometimes useful (we do not fill it in if it would just be the same
> as p->path, so the patch only changes it from uninitialized memory into
> an empty strbuf).
>
> And that is probably not something we want to change, as allocating
> duplicates of each path may be expensive.

Nicely said.  I reached the same conclusion after looking at the
existing code, even though I have to admit that I am not a huge fan
of the more recent part of combine-diff.c and its data structures.

Thanks.

Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77E270545
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119197; cv=none; b=QlSG83AI2gt89Tu2HENcSucRWQV4I3Kf2mhrQVn+rgaoO+bMjkbqzSU+KIVZRhgVv3t8i6wXgiCA604B1eH4QQSfZ4YkyKe1pgNlmf/z2XrAm96Hgr3oJVLlB24EgW49N+igBMzsqmtkUEnKO4Mqt67RyZc5BdHpw3SrJoju/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119197; c=relaxed/simple;
	bh=e8EDj49u1T1bgSqPMqQaZFr0LJCP7l6L7pKh9AzagLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C81HzOhqKAUGydZXrRjNvJeF+yXgauqZAu86G4Jgld4mI7ARtDi6x+jbIYBjjsxvq2GMFGIQnf0FSi8xaXmZ9v5daDSXH9crRzX2DriC29jZrVZIZM11ctD8O3uocrGYx7lE9oqsJ6jAjIZKIbF8CeirTSU5LoLhGYT8gXnEZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DqpvouCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a71u5Eee; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DqpvouCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a71u5Eee"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E14EA140019E;
	Thu, 26 Feb 2026 10:19:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 10:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772119194; x=1772205594; bh=e8EDj49u1T
	1bgSqPMqQaZFr0LJCP7l6L7pKh9AzagLc=; b=DqpvouCqNo9vXvfXEh8YBI9bmq
	m42ltpQyd2QDbEqCg4UXSHEWdUMReKGS5f8hlZodh5rXtnepGxNrCBNc9Df6Pgqj
	GBIQCFqAqgoGjoafr8wym8DQOYjGXFt6ZeQEe3voFo/cpAVNGRHV9YLHQnMiuFKB
	dmIJMDcisoZCAGHsYERTzlQhKcsTYUOwJm5ucKBt1gCvh7plKmHghm9q9Nqq7qMf
	pvTl5qaZHubK5cNKX9V9NxoaeEwiASvEmgpQ1Bjux0T4pgjuM2S68XVIV3ntv1R2
	0Z6CtgUVmxR3ZC6y32bxX1QFVJofOLPtt3YuqClmQSk0WKGW+pIutREQyPww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772119194; x=1772205594; bh=e8EDj49u1T1bgSqPMqQaZFr0LJCP7l6L7pK
	h9AzagLc=; b=a71u5EeeXmZ3Tt3OJQpR+BaiHEoXy/ewVITsKadcQc7/8sNKyrK
	LR7nOn7xfkwV73jx+QkkoHeUgVMtYv4VIT77AlS8OwSTU0nHArB4+vWSDBQrqjqu
	exru1mcrSS4XyQNhyybX5UvY+/Qg7AbWmfWvhpd6+85TcDf/yP5w2MUX19DwSvf8
	+Xsef5Dp9zeFIinZ5ZCMefmFZsPKyKcmJpwE1gDufTeL1eszvDJdjjAwudxOwta+
	67EFghPbJRUW7O/xeTrg4vdpqiuOBdyH8OSelh3Yi5/JRFKS5impRz2CDiFcPkZI
	kdQ2TbPA9Tvsh0o/FwdJwmdESENKyzDdt9w==
X-ME-Sender: <xms:mmSgaTaptdicxozDszgT_2Hvww0Z-svThWE7SuVikt3b8t86o9p4YA>
    <xme:mmSgaeHIzcATcsZKh2neqBLCrT1zhC7ky74ePHnxRT6VO2GICAwcwjnkEK4hSd5bP
    gNCU2XvQJ8KNSjJ2bDcSnLH0KLOfwy8GiZviT7dU9M_DTq4W4gdfEA>
X-ME-Received: <xmr:mmSgaSav-XcSsdmqpNbZYx50--q8dN8Bxd5QZWnpdxGdqjMlibnb-oSW12OjhEGN8UrmQd30Wdl-Cfpx1S8X62TaYUgNJeNL5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeifeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegsvghlkhhiugelkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:mmSgaSyP0S8jGLRIxskfsfdES9mm7pHCyvj7XjAsTkRk1IJgGiZmEQ>
    <xmx:mmSgaUT1baBeOHNSa887807rs0UmxFk4bZO53SvOF_GdInMb8A4SZw>
    <xmx:mmSgafLunL8XTOeKNBsZasvGKRRDzMzv3zheomAtKZaltdH3q6I7JQ>
    <xmx:mmSgabU5CXqH8DjqqbaEsIopf2sebSr3WWb6SSC9xNuVvZ1BJDHD3g>
    <xmx:mmSgaZH3P0EoJDZ_Ji6RSUhrRQXT8DFC_oT4-w35sW8xaDFnIFnt7T2a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 10:19:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  phillip.wood123@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com,  karthik.188@gmail.com
Subject: Re: [Outreachy PATCH v7 0/3] store repo specific config values in
 new `struct repo_config_values`
In-Reply-To: <CAP8UFD2Rz3NMrTayi9yjRk4-51tStaLWKeBVB9RaJMWmiBLqrQ@mail.gmail.com>
	(Christian Couder's message of "Thu, 26 Feb 2026 14:03:36 +0100")
References: <cover.1769256839.git.belkid98@gmail.com>
	<cover.1771258573.git.belkid98@gmail.com> <xmqqa4x7b0ba.fsf@gitster.g>
	<CAP8UFD2Rz3NMrTayi9yjRk4-51tStaLWKeBVB9RaJMWmiBLqrQ@mail.gmail.com>
Date: Thu, 26 Feb 2026 07:19:52 -0800
Message-ID: <xmqqms0v5y7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I took another look at the series and found only another nit (a
> missing blank line). Otherwise the series looks good to me.
>
> Thanks.

Thanks for reviewing.

Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF02256D
	for <git@vger.kernel.org>; Sat, 17 May 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747444787; cv=none; b=JNExjF60qpVt7RJUJTFpWkQBu5WEeeMDz8hAHeOnbiyU5fHn5CO1V9l9EMBXGwZYjna+AK9DU0LkLcdoZldFpiDwO4XdMb6Q7Yrd/TX0R0ik21GzkLjMyZ6s4uc0QIBTZkTA3FgiQDvahyF1taiRhS22XVu79WhjP/7WIByRJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747444787; c=relaxed/simple;
	bh=j6t0RyuY4FwQQGE0uz0qE6BEz7H3GHSVIw5WBm87TaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPtU8kKuPj2hQmriNheSQhkm873j32ScueWy5IqSxLgSMExEb04pMeHGqy9xSLL5Kun47+9u1T+swzCdYCaeWXp69bIYCi3g4gbjzUOjcfHp/wTqqlZFkUyOUqJvZA7b4O66UD30N2Pp37/KFJaDbHaTiLJgqIHPeKqsMkVu2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QO2i7tMr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kGcDTKxt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QO2i7tMr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kGcDTKxt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C20041380439;
	Fri, 16 May 2025 21:19:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 16 May 2025 21:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747444780; x=1747531180; bh=fjx3SB3KEn
	2y+ET/x/FhL5P9i0pfX6bOAGxV17f0f7s=; b=QO2i7tMrKP1+Z+GY/5RX3Fev3w
	vNDkZoI0uTykms8PmFY9NMQJHqMQskvXkqUCbEIRzIS8PpH1uO6bDGqSpkqiwG0d
	Ruutm+pKNcslRaD7aHRK/rkBWQHg3kmzglT8QM4qUiDCC6GMwUb+16c01khSXGaN
	ublWXWmPUNyCKrrX747BndvXAFjchMJGiLLSBN5JBjz9+CfJNpZD6pS9RIPktvC5
	qmZsaY7Gl+CW8Jm2N+guncS7tDhQxEMkQkSt+R9gIGBjr4jiPYy/mfRX30sIPz0f
	7Gs/TcxWxLKkgrj0Hp67QYoGTCwVlPcRT6cjuyu5IfMLm77f6gQ76dZM06cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747444780; x=1747531180; bh=fjx3SB3KEn2y+ET/x/FhL5P9i0pfX6bOAGx
	V17f0f7s=; b=kGcDTKxt0jpvey+3zbuxJ9MT9uSFFSI+xD5X0yGxQ4S03qas18Z
	a3+l/ynt9E3B/JAwgldVXEnkaCcv8thPd6t1AsXQwP8w5PbfLGzlPUA5QbA+l7X3
	GXCMSylMPc0QGO5RpNeShOnVUd2tPr7m8eaZst1ApdENv14qGWJZ9MRIRt2IoT35
	1L7AphbvWe/nqG2LNa0HBPUomOZWosUFiHdHw/KACvly6lHta/IIU5qybjObQhny
	qrEfLsVFIm6y/EkN6G3gq+6P0n9Mtvcj1HvRh7gVFZQFide1ttsBVp5rSIhG9Pwk
	agWKBqR7/lXvIJqxth6m89XAZazT6wJHECA==
X-ME-Sender: <xms:LOQnaG5RQUljCQe-9TRVZxwA5Kq9v-TGB4BRYiogaLjPQo52-G6cfw>
    <xme:LOQnaP6bVp3w-Hq713zbuRtc8mBVoHIQHQIpkUoh9NHlOKJWBhhGrjy_lSSz8JXTU
    -5MsXI2JLja0YVisQ>
X-ME-Received: <xmr:LOQnaFf3jtfTGasi3zGhDdmJB65JGY8MvXS473tct4yQ65ZN57IMnCH93bqb3eiAZpZV5DeIR7yLfHKrt7h2shcxH_p8xB0_9S_w4JM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuve
    cujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthht
    vghrnhepffegffelgfejheekieekveejleffiefhffevfeeufeeifeeiffejkeeuudelue
    fgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhoohhglhgvrdgtohhmpdhlihgs
    vghrrgdrtghhrghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkh
    grrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LOQnaDLmLvXbccNRfyQlNBYQzo6u5kaKHdNpE_gatnfsqQfeDumOmQ>
    <xmx:LOQnaKKzJFad_hnepLWbs5tJuggGwWHnxjxB5X01hzX66jp5IkfzUQ>
    <xmx:LOQnaEykQj3yj-akNgMucDjwfavoyKfZlDH01tb5h0kX4Q9AaETOqg>
    <xmx:LOQnaOLNqcXvQE8lK7mCkXeoni-FLtD9j4bWTC-I4dxDYRD8rCPBnw>
    <xmx:LOQnaLfx5IhtwBfNQz9YPSX8p6DgqBCLtaep1UeFZGsCs46H_9V3roJM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 21:19:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: nasamuffin@google.com,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] docs: remove unused mentoring mailing list
 reference
In-Reply-To: <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 17 May 2025 00:25:14 +0530")
References: <aCeAIqwvEVOdrsMg@google.com>
	<20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 16 May 2025 18:19:38 -0700
Message-ID: <xmqqecworq39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The git-mentoring group is being removed because new contributors
> now approach the main mailing list directly and
> almost always receive responses.
> To reflect current practices and avoid confusion,
> references to the unused mentoring list have been removed.

We typically phrase the last line more like

	remove the reference to the unused mentoring group.

i.e., to give an order to the sources to "become like so".  Also,
the early part contrasted the mentoring group vs the main mailing
list, so "group" would probably be a less confusing reference.

Other than that, looks OK.  The actual change is also good.

> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index ca1d688c9b..ef190d8748 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
>  The https://lore.kernel.org/git[archive] of this mailing list is
>  available to view in a browser.
>  
> -==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
> -
> -This mailing list is targeted to new contributors and was created as a place to
> -post questions and receive answers outside of the public eye of the main list.
> -Veteran contributors who are especially interested in helping mentor newcomers
> -are present on the list. In order to avoid search indexers, group membership is
> -required to view messages; anyone can join and no approval is required.
> -
>  ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
>  
>  This IRC channel is for conversations between Git contributors. If someone is

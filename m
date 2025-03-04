Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C127C851
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103702; cv=none; b=eaScECpWE5tjai6n2ZYPmY4gHvqt2K9iLutc2DSjj90P7uncsN41dWp0ubslnO/jaIB/I74LIHxFFHqu0SnqjxqziVJhOnNcx2jFKy63RKwpxmoEv/zbfOVDsk6z0gOBqCTaGbVPq0FlEsBgo67/6raWms2O0hfxdwnAxS0OkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103702; c=relaxed/simple;
	bh=Dt3Y9md5FB8pll5gK1bs6n8Q5TJDlmNBXgUXL3YGIkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UkNEcW8idExmjJGB/zdUD0RGhqfDl/3PrxhD7IBb6NS5Owv1nboufYmFITsX7xe3pUDBuxqOIiinqLMw3B7iV7y7Mx+i28M0qUcm/8sN6BdE6QIWQ/yid/gmmYfOQ9fgeNIxWeNTuIOCIBvFbHcIj7ky0p0nzUvvHaehGa9WA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qdM0bvna; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNTLgnIU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qdM0bvna";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNTLgnIU"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A4AF114017B;
	Tue,  4 Mar 2025 10:54:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 04 Mar 2025 10:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741103699; x=1741190099; bh=OHFR4sYUNL
	9XkHm0mmxqxD5bmQnl/NadsPXJkkT1tSU=; b=qdM0bvnajW88VifqMlMhPLNZ7l
	vXbO3TYDWE6EfIMIbmiTyR69qeutMCnPqsLHesz99q8D8TAiYaIKXcBjddoTgIOj
	/LA/31reEw0pip+cHUBECTVA7z6/c8J8ljcFgXD1vmCQkFSeTphNc2U5sVUc9yh3
	om+RmBNtYq3cj9Lr5Ut//5Ti0uyW6WcKrfRHhA4X+capl8gRW22bK9420bIImc8G
	BC4Dsev72L/sR3xu/ssa/jXW45yIc6Lw4QJrQ1evh8Z8j7moZ5ZLAvYJOXCvx/BO
	m7f278/VGzMCH+P6a0rYOqx37JP3NN3v6yCXmos0h1H5n9/TSpwVzTrj3Dqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741103699; x=1741190099; bh=OHFR4sYUNL9XkHm0mmxqxD5bmQnl/NadsPX
	JkkT1tSU=; b=kNTLgnIU9dpirWMnFqyqCzd5U8jPmZMd2lvdyseFHaTwzG7OStr
	AfZVUFugfO49sjvSOPsc+5DnPLNmEow3zTxzn2QI28fAIMhb8iSnYqcm1JMLSGmp
	Uk4yAavEa2wrjZ2m/UHuFAoIQnibjLmsycidmDYOv+tioNL/Agj8OQknFX0rZkmZ
	T7bMWaYiE0nvZrhhY1CzPoae/o87KG4Hu/QzUUPkqMX/rqP8fI4Di4kf7VX4LiQV
	er64swTUMJRuYmDYSY4AOak0fbB4MSz6/vfPnZwq+7SK9pA2vcyaRGjS4MI5ob0g
	4xbiVQIsejMsiWbvTc/LkpXeJ3A4HoLVujA==
X-ME-Sender: <xms:UiLHZ3wBPIFZKhPqBC0iYZhlceCsDNTwBvBAvzx-viTtZK3AM7jw1A>
    <xme:UiLHZ_QlKB5Q3H0dtuZuOZEu7MyMwXMAxAtliftLy9qR7MjOEO6ONzI8nBULcoV_Y
    M5qW6Z9w7sKiTsU5w>
X-ME-Received: <xmr:UiLHZxW5gXW5OgOBGbacXew5T9cVJyTqJ2ck8anr9ymtjkPzuEOT4bFnr8JHw4dWkM3XA9dDRcCyPAQr9puvdXW1m0P7qZZkLXzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    ghhruhgsihigrdgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UyLHZxgYxK70h1XPeVtHagOzmbbD-VKtIokrvvRVqIzksf6F5SWpzA>
    <xmx:UyLHZ5CWh9mvC1xU46HPTyr3lpobRKLWDDmcnuhfpkr7bAPAw2q4_A>
    <xmx:UyLHZ6IXp5131hecqoYVKOSgCPm0_BaWA-JQvWO1qj0XrHmC1RoKwQ>
    <xmx:UyLHZ4AtVvcs2RlQaLqH-6tKYPyoCTwGq18y-LuCgadTjcafd3qb3A>
    <xmx:UyLHZ86N80WWmiX5yk6KWFJo7q0KNFMj96wpK2kLqh98aCOWanwjyJww>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 10:54:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Michael J Gruber <git@grubix.eu>,
  git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
In-Reply-To: <20250304083337.GB1297837@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Mar 2025 03:33:37 -0500")
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
	<Z8GVAjwZWOM7c2fR@pks.im> <xmqqseny40kx.fsf@gitster.g>
	<Z8WFcaEtMCD5C0EN@pks.im> <xmqqzfi2xl5q.fsf@gitster.g>
	<20250304073010.GC1283943@coredump.intra.peff.net>
	<Z8auRqylLYuwalAA@pks.im>
	<20250304083337.GB1297837@coredump.intra.peff.net>
Date: Tue, 04 Mar 2025 07:54:57 -0800
Message-ID: <xmqq34fsu6y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Oh, yes. I didn't mean to say we shouldn't sanitize at all, I rather
>> meant to say we should sanitize to values that simply cause us to do a
>> no-op in the relevant parts. That means we'd:
>> 
>>     - Unset a bunch of environment variables where we know that they
>>       impact Git.
>> 
>>     - Set config-related environment variables to read configuration
>>       from "/dev/null".
>> 
>> This is in contrast to the more involved fix here, which would be to
>> populate a temporary home directory with gitconfig files and whatnot.
>
> OK. I still think you'd want to set GIT_COMMITTER_NAME (to avoid gecos
> dependencies).
>
> And I'm assuming your "a bunch of environment variables where we know
> that they impact Git" includes $HOME, since we are inheriting
> dependencies from sub-programs. It doesn't necessarily have to point
> somewhere useful, though I wouldn't be surprised if some programs
> complain if they can't write to it.

I guess eventually we will come full circle and need to sanitize
pretty much the same set of environments as t/test-lib.sh does?

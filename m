Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C93194094
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 21:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738876453; cv=none; b=Ej1m+pvyRNxIvFosorEoKL+RM2Q63wY9t2NV6ZKezdiKt4SzQXa2Crikmv1BWrvIGY4Vy3b1WYQtH5Fu0XOWkCFz7tpWZy+qcRYVyoJrykCJGdziFZY7RAMR/+DsYKt7IZdui7c9KGi5LmH7xiROZXli1ALzBxUQBtd5pqh5V14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738876453; c=relaxed/simple;
	bh=35mipoRNBN6UR1uPuIlC8AL3+nMTEnxz4HI2GeuJZn0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ia9I1lvZZiBKo2mYuVXeJKr8f8JO393mKHo64GPBZZregbvJB6uFxrp7k/LpYLH8xHyFaOy2vpxSfjGpmHzoaiv5fb+Mk8Na81vFXd1d3TDszmvgS6rjE716k3T3ivYmtmhwfhXV1undHH1oy9OX7Nmz3nGWAxobTSWLen4bWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PrvWA6Or; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxRCK0my; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PrvWA6Or";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxRCK0my"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D80D2540150;
	Thu,  6 Feb 2025 16:14:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 16:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738876448; x=1738962848; bh=DevA5pi1nR
	iPhbQMXrxYnD4EL4kWm9m/vnAHyUjS4SM=; b=PrvWA6OrCGxEJr6cd6qtLBPEzR
	9RFtviqWUt9gSUdriyArQPdv7LjQwe6X+H+YUQH2O3gAG2eRwcq7QooN5feDY166
	Qh4Q611RvRPA3wDLG6h/PAZfYbGGsy+WqEuLbHdsvwJWxH597DHe5B+xulkjUeAm
	dxSqQxmAQEJS269Gk0RAdamo199lJAxtVF6Y8yB720fCC85ub27M6d6NlRPe4cPA
	N/nU19Gr5/gSTIz9CBKfAzDIO08mQ9Go90qnPMlB+p/hVtR1DKGqYxne/WF91IkP
	XSDF74EHCBKKjc86vdjbviJ/C1B/jpe6iwdnWduzEM5BcYtztH1HE+UDWWhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738876448; x=1738962848; bh=DevA5pi1nRiPhbQMXrxYnD4EL4kWm9m/vnA
	HyUjS4SM=; b=WxRCK0my6TgcC3ekclw7yrXGvAxuheA+2V+A7tzdP1XDLZH3Xce
	ieTTtrRhzrKKMSezZfmuoX/QNfk5w0WBuQ+EQJRZwnNUDVG3pTVI78SdkL8DNWET
	mdLtbK9FYZTMsyxKn5vK6kpb5m2x5VxlPl4GQuzNHs4EBJJSiz5M47uBp+KhFXNL
	WNv5x//CXLFedmgnwWwki48EdprNtzjXIpYFrubWGOFIW/If2FVdLV/zLAGBEy9p
	6Rrwk42KIlsyOdlBKeSHKa55L5/vy/Mbp8hMewwMWzX0KETrCoxQFJhLih9ldoJV
	gUW2aB+QaSbN8wPh2HGTOAUqafqOn7cvsJw==
X-ME-Sender: <xms:ICalZ98ivknXen1FMp0Wi2HuHdMR8wIqcpMOeECbOmtP4_Nfk4GNZw>
    <xme:ICalZxtP0whDhKYvY06vadOSDzKR1Xx4njPF_HuX2fqC58CCaJ_kNAEy2RqoDlfiP
    QZUqVqv7Xk9JZHwRw>
X-ME-Received: <xmr:ICalZ7BIT-n9JzQGnLYYyAk8pZnVm2b5EFVAB-8qGedpT4O2cXUHjvndxmRU8CiDr6bsqsTB1Jimim6-SOliEKO7aoimnFlXAxMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhrthhhrdhhih
    gtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ICalZxd_M3mLP61YW2GbNGE3YsFl23Jya_2T84xfSd8w6PjRDZNACg>
    <xmx:ICalZyOLkzYxjXrvun9potb1Oc7QMLtuYqWaJLstLuv-lWe1RolGpw>
    <xmx:ICalZzlM_up21k6-6QvPYs8Hm3yHKdhhW_tBk0t-ahnl60ImcJegww>
    <xmx:ICalZ8s766svKx8Zuvknos5n8Uyn4nm0XbRt9uapbFt3IHu7Qu8Z3w>
    <xmx:ICalZ_pYvlGLBO1QxyZRXcvnea_QFw55Y2bgb3DkADj8zhHv9N7K9_mN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 16:14:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
In-Reply-To: <CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
	(M. Hickford's message of "Thu, 6 Feb 2025 20:33:00 +0000")
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
	<20250120015603.1980991-5-sandals@crustytoothpaste.net>
	<CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
Date: Thu, 06 Feb 2025 13:14:07 -0800
Message-ID: <xmqqo6zeixnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> On Mon, 20 Jan 2025 at 01:56, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> We presently use the ".txt" extension for our AsciiDoc files.  While not
>> wrong, most editors do not associate this extension with AsciiDoc,
>> meaning that contributors don't get automatic editor functionality that
>> could be useful, such as syntax highlighting and prose linting.
>>
>> It is much more common to use the ".adoc" extension for AsciiDoc files,
>> since this helps editors automatically detect files and also allows
>> various forges to provide rich (HTML-like) rendering.  Let's do that
>> here, renaming all of the files and updating the includes where
>> relevant.  Adjust the various build scripts and makefiles to use the new
>> extension as well.
>
> Hi Brian. How about also renaming SubmittingPatches to
> SubmittingPatches.adoc? This is AsciiDoc according to 049e64aa50
> (Documentation: convert SubmittingPatches to AsciiDoc, 2017-11-12).

Do we pass SubmittingPatches (and CodingGuidelines for that matter)
through AsciiDoc?  They do not even have .txt suffix, so I suspect
it is not.

I would prefer to see the general rule to be to rename s/txt/adoc/
ONLY for files that we actually use AsciiDoc to convert to HTML or
manpages, and leave other sleeping dogs unmolested.

Thanks.

Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DA2BD5B4
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536418; cv=none; b=mV5m2JiuCeocu0S15u9Eqx304KspjpTR19LJmq3G+i/kvlfMOXySJjvvS9gpjb9j9tzI7NB/Zl00UGR84M1nLeGLNB4NolRnYJ3GsM83ibghbXY+KGxIqWY36YjBxici/gPdez6jpKE8bjwyKMg5eaQIWhGYZuRcsc5leiWr9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536418; c=relaxed/simple;
	bh=xxheDzSyKUgxaiyjo220A0v6X6yMmrahRrEbCu9bArc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FmCHpwWaBOm97HIGiJ61KFRZOZmwmZKvl59tyoyl77TQAmLHgU7jwtrKGwKAcwo2XSLxzlBC/5Ia5vH/gywn6aGqYsHzl4qPhBHuOXsPZtO/7DObVTk0ICf5mIozf9r/tHEvOa05BC79HJZFm+31kvTKXo5OE+8jJEZG/TW8dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c9mXTfbj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9xvWkF2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c9mXTfbj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9xvWkF2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F26E1D00173;
	Fri,  7 Nov 2025 12:26:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 12:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762536415; x=1762622815; bh=qXtiYnpnb0
	ioeNcVhvckyFK5c+w0pDKYdx+79G7uDaw=; b=c9mXTfbjbgAQOTBqZYxcNFg8AC
	eyWfqZGwm+bW5whzSqXP9neojg7tc0mogBKlffAt255Wq021y2DhxNz1bPPn9EtX
	EF31x5MHlqJmBN9BCwbjjZlgRSzCJ55pa+ImtzwiT1wEa8eFcWYmD01Altw5MVzC
	KN3TOYzoDm2lXC6yYBxkHh27rAOfLxtc3O5kcWinwN4fqDKYUbMXbqfgfZSR8U0G
	dyPlf4xZP2vE3ghGEPjY0krslrSRdjx/DprDyZFsmtLwUTOYjHlkbWb9pl57bVad
	gD/ZFzH0EorB+4Q8O0UUpX4co0l1udRK5BglF7ue0wTMncprrffbPjeaxDcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762536415; x=1762622815; bh=qXtiYnpnb0ioeNcVhvckyFK5c+w0pDKYdx+
	79G7uDaw=; b=g9xvWkF2CLO6Gej7Q/Zn5k8LEWmANaw0Rb1inI4cnRdC2zlVfAI
	rmZbjOZz4QhmqrMLVCHCBwz76BIZCqB6acCddybKSJhvSANeIx56GZZ/YQ9aSj9K
	Ye0u6lIxRQi+1nKKrenNr+0gwVGRlCuWemytD4PDOGhv8kWZSBaNffcf9xlXxCKO
	bkVF9rpa2V/uGflv+q+Kjeh61uW3qBo8lMbv5QFPcwCmyBnFjj5X9gC2VW/DPKYe
	qZtN7Q8fj1aiK6fOApcr/8ZS6eDs9z3AdeftIh2MMZ5F8pfRjxUEJr/jw6pUlmDJ
	RPvpwF6KI1p5vzTx3CxV3enIIJM3H4KmOOw==
X-ME-Sender: <xms:3isOadciEsjgLu8sQYMq3fPdVFfQW8CyKEIZhKKnfs9PcoUQe0QG9Q>
    <xme:3isOaSHmZiZDnROuHWDY7TRBkxfghTFlXkJD_eS2AbeKi0Y0gis9OaSUJ1jQ59bSz
    JsuLmWiTDrI1pVwcYm9afcjViguMeI5oR-bmSlcxWVFukubsACtig>
X-ME-Received: <xmr:3isOae00EDQKENGAeckegH5wbk6yJaQYn77YU6GG3saT1pVyCQoMCCfHUpX2qIS32iSXIbTtZwKKscb-m8B-zhQstL11UdbOj3Ny>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3isOaSmhkJDNhniRAvB8h8PpSt92S2VvXHmulbJ8lg-W0lCXpYLvkw>
    <xmx:3isOaW8xQdMUHb-fU1eY0cBG1n-_XLtR_f2Vf9uaInYA0FpzL9Dq_w>
    <xmx:3isOafoffF2N3ehqQ4Pkpp45Y0bRsDaY-plN4v6_2IGCWLoNsP9I2g>
    <xmx:3isOaXmBRe__FWIBL5hcWfairjILut4OzB7Ptj08vbWWQROz35v4xA>
    <xmx:3ysOaRAuvVOMbuJfYbpd_LRmAAOWil5x0B_hmXR5yFw41kKQQOD_Q7VO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 12:26:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
In-Reply-To: <ikzwvvyyhuhvr7picunl3r4zem4cn566zpjxpmh6u4oq6ncswa@cdfokimobtms>
	(Justin Tobler's message of "Fri, 7 Nov 2025 11:16:35 -0600")
References: <20251104021455.379807-1-jltobler@gmail.com>
	<xmqqa512sfcj.fsf@gitster.g> <xmqqzf92quen.fsf@gitster.g>
	<nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
	<xmqqtsz8nbwv.fsf@gitster.g>
	<z5mkdl67vx47na5critwtyz7cacvhs6iixy46ia3svdoq7xui5@ckpfnjw3dkoq>
	<20251107083015.GA18670@tb-raspi4>
	<ikzwvvyyhuhvr7picunl3r4zem4cn566zpjxpmh6u4oq6ncswa@cdfokimobtms>
Date: Fri, 07 Nov 2025 09:26:53 -0800
Message-ID: <xmqqjz01g3du.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> or we could maybe move the extended info towards the start of the line
> and leave the remaining bits the same:
>
>   :binary=yy crlf=nn    100644 100644 a1961526 e231acb1 M    foo
>   :binary=nn crlf=yy    100644 100644 31eedd5c 402a70d7 M    bar
>
> With either of these formats, the expectation would be parsers continue
> reading space delimited "key=value" pairs until they encounter a tab. I
> do think this latter format looks a bit nicer and I don't think it would
> meaningfully impact the complexity of the parser. Ultimately, I don't
> feel super strongly one way or the other though. I may go with this last
> format in the next version since it does look a little nicer IMO. I'm
> still very much interested in folks thoughts here though. :)

With this are your parsers/readers still using the output fields
that appear in the --raw output?  Do they still want the mode bits,
or object names in preimage and postimage?  Do they need to even
look at "M" anymore, as a new file or a removed file would certainly
have only a single sign for these additional traits like binary as
such a filepair has only one side by definition?

IOW, I am not sure if it is wise to shoehorn the new pieces of
information into the --raw format.  Existing parsers would not be
able to grok the above at all (they do not even see the fields they
recognise at the beginning of lines which is where they recognise
them as such), so I do not see any good reason to even pretend this
to be some extension to an existing --raw format.


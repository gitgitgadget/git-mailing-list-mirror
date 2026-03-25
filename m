Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA423DA7F1
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457716; cv=none; b=A/0aq8+zh+JwN/97s47ZYJtaSjHId9Owf2GXQuJjjijbIMYp9ih2sQIfaQIigOSVvgtqBaF2WRi/yfyVdhMP3rh8YWBUYOxKw52CqQWh2NOzsS0ui+kJ19gdjED4AMkf5iCjuZxaS21p5NNmAcETuj9m9m3044aZpF8dfx6TQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457716; c=relaxed/simple;
	bh=3oB4411tOwZP+Vz+GM5TB7p+MkAjKZfv6DMrZcT/jB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SMPsQu8x3OF0/hDGlw0XYp1HTTyq9eTt8fDKl9CLnr7jXIxtXu7yvq1yjoOX9ene8fwGx3BNbhCo76NlifScL/PZk4MTXp8rOGKQqDOVWGs/clBRkHbdobSWeu+7T3ZuxPXSDAOCnsBCjdlmoGXczuifVk6kCorj3Up7AJ0ShvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b3HKCL/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kczUoPwJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b3HKCL/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kczUoPwJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC0571400289;
	Wed, 25 Mar 2026 12:55:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 12:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774457709; x=1774544109; bh=EKKlx8O+FL
	sKxUXFUpQtIaP/5MMG18QkZ4IocRw6VQw=; b=b3HKCL/wbCLp9xpVtFkVKfGAX0
	Po3mj6TdtokD7ApDXu34khfSCpUENbZugEsuCGJKPKOeeDi/fSOIXRveLALSmmN5
	SweBjwhfiiC26axVrd1+k4uV1L4+rGU0A4P1T79vVqLkBdzBMj/J0cNDRrcifMV8
	m0piZkQwP3rxFxsAOEOAlwJTzUnTaw5D197D91k7FdxYq6xCTM2gzOEZlbPeevjz
	C+tg5y+Mb9/izxIVtcXnbN9xpOGzTPUERaNZCjGAIuUf14oJulPdySvTEBouahmX
	s9I2iuAayBmXHz/u6FVPayBVV3uovqmPv8OMnKwScXemH9IwcsoVudZ3l3VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774457709; x=1774544109; bh=EKKlx8O+FLsKxUXFUpQtIaP/5MMG18QkZ4I
	ocRw6VQw=; b=kczUoPwJNhAjeEV1jwLvCDrJ6CxdJqhaGLwVdSQBRCjzeg8oc8W
	m/LoylVvODJ1I1YXe/xORXTrZvuzLctj+fkqcSsQz9GyU24bY/B4Z2JvyrzDRdy3
	lQ/hE7J6W76EHQebcSwW0DqGg2WGDbD4fX/KmFImgjSsKLgh8U59XOXnGlorxo+D
	tU4UjqDlhxC86riCjVjWbAb4nmegU//P6EO3RZfkJehH8QFoegbMTKZkfl95HW8e
	4AnKXY0asJwkLO/jgKUALTyVW1+INzXONpiliCIMuG9oegQWhE7GZ+EDX/QdLYiA
	p6gyXeeE5DWH37PgkvM3kpT6NtSsOISx+dQ==
X-ME-Sender: <xms:bRPEaR8jSwNIzX35LGFQRtkvz-7aYoU0Za8ArBBUC2jN0Shb5VUKag>
    <xme:bRPEaZYPkSJFrpxqvxyVCchNV8mnkQjZIBail5Hg-MrqduvGyfCDqaV3VEyz7uasN
    b40egFlUqJs1-Siu17MZoYsdO_C-O8uB3yChsJU9ElGE776Zi2NnQ>
X-ME-Received: <xmr:bRPEaY3Bz8YwMMM61yRizbBAQBNx9Ikx0K02CtAT5iGBKU1MoBwTe-FAXrUwKE6P5bFOl0NfFSIpWDW-wiyFN7LZzUcGmHUUyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmrghhlh
    gvthdrthgrkhgrshhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirh
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bRPEacaGQ-b5_yVvNGRy0j7L2u-3hPYAqiGuDPZl_SgJhBtbDL8GZw>
    <xmx:bRPEaYIV1A72rn6Td0C5c117JvW9SFYuOsVpeJreApRcuEdixLGHpg>
    <xmx:bRPEaTETqPoyhONa6CHGgXP39BPPZ7sDhEG2zl0BbCTWJI9Y2Pv6pA>
    <xmx:bRPEaXuoAvg6z9j8BUKrBF5mHm-JIGMuqr5eloYBE8CqN5sC3ENCew>
    <xmx:bRPEaSjwvMJfl_OClI79aeLMTp_w3jk5EqtwHJrdIjlFlIfs7GQBFxHg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 12:55:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mahi Kassa <mahlet.takassa@gmail.com>,  git@vger.kernel.org,
  lucasseikioshiro@gmail.com,  jltobler@gmail.com
Subject: Re: [PATCH v3] repo: show subcommand-specific help text
In-Reply-To: <acOye5MbsFVOa1vJ@pks.im> (Patrick Steinhardt's message of "Wed,
	25 Mar 2026 11:01:31 +0100")
References: <20260323152937.257406-1-mahlet.takassa@gmail.com>
	<20260324184843.299223-1-mahlet.takassa@gmail.com>
	<acOye5MbsFVOa1vJ@pks.im>
Date: Wed, 25 Mar 2026 09:55:08 -0700
Message-ID: <xmqq341nx30z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> v3:
>> - include the requested code changes that were missing from v2
>> - factor shared usage strings into macros to avoid duplication
>> - restore blank lines between tests and before test_done
>
> By the way, it is highly recommended to respond to some of the review
> mails directly, as it helps to create a dialog between submitter and
> reviewer. Otherwise reviewers may feel as if they are talking to a code
> emitting entity :)
>
> It's not necessary to reply to every single mail, but going like "Oops,
> yes, I indeed forgot to add the request code changes. Will fix in the
> next version" can go a long way to make the interaction more social.

Hear! hear!  A new iteration without any introduction is harder to
accept without such a pre-warning to suggest what the author thought
after getting suggestions in earlier reviews.  Did they agree and
took the suggestion?  Did they disagree but took the suggestion
anyway, and if so why did they think the suggestion was not such a
good change?  Did they disagree and did not take the suggestion and
if so why?  They changed the code but not in the way suggested in
the review, but why the new way was thought to be better than both
the original and the reviewer input is unknown?  

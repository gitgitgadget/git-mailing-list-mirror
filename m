Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA91322A00
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550914; cv=none; b=EC7ukdKkAxhxtka+aJ3/d9b+TpbSpnxHnfCzH82il5cBsDV4/WbKamxwxJFPfNH1SxXChDnFjD6fZFRfB6X+pU/aMDekN8w7na+6YkpmfwpqeOPg9mEgohK6oT5LxCmy4x7gT744rfa52/IXrnC+fJY/+YDrj9NspiUSnBnD9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550914; c=relaxed/simple;
	bh=IqN9eEzoxCUKjxGXAPw9t/fcsfak1rgT1oHnxQYb4rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FVEYtJgywWMVetNlLQKgj57vSSLt8zmBkvPox6Qo7kPuhT+dz8NYzBdWjlsnmtyvEsHkjIlOuVijWR+3gPYBQfphbZuhlJH880N21B4Dos4adhJImK54Y+Ds4KQzJANPDCXo9IJ1zgyMlwnVe6Hi2QNh651g47lS8L8RcE7ZEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T12WCOkG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1cX9UBrs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T12WCOkG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1cX9UBrs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E45A14000AE;
	Thu, 26 Mar 2026 14:48:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 14:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774550912;
	 x=1774637312; bh=HlYB0fFRUtX5iBmitFC5EBbwPB7eXA3uz6x78zdEayc=; b=
	T12WCOkGL49rWmgXC62gwJklMt6hLDoHvjqCnxjHhyUoRUqfsGgo5HvdQK1IdH8r
	dmL0oe1diNU7yQHa+YOr5MywkK8mJH+F0gQd6RYT7pjJVjSi0qCxG4K2W5iShBPe
	knJqMO6ejsHeWADQjo6nbtoOj2V1HXyoWEscchdXBP+H2ogMNSOa11KpgNCgTYmA
	RxyK86T+w96aONWYih+0HiJo9+qdIoiygtzllx70fOVlmF//ZCu2kUSgv6X8pAfn
	6w2rc3Hx01tf9vJharGvU+kGrWJvNmLLoWGMUPrzqplgvLJiDc7cdOlxl054JCh3
	/h/V9P60+VHUOSu9iUGOkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774550912; x=
	1774637312; bh=HlYB0fFRUtX5iBmitFC5EBbwPB7eXA3uz6x78zdEayc=; b=1
	cX9UBrsXn9/jG+gsjNFObXrPdSlTmtYoqwaQ0O5SjfyZgH1/dCX7waOXpUGz+YlP
	4ilIPjVqxcWyR7W243gHuclKXU9zaGnMe+MvpLoQFGsBt2wR/TfmUPDpAxn4ZIEN
	dQrFh8d1Dw8G8R2i4o55NdQjhYNns1M+y6MEeYO3UJFsiyuT3To2pF6RglK1+JFj
	BuJWL+M9m70ZzDTI5qctUFbcWnkKtndj/KFi2q5GWZ6Cb0ui0S33kNmEGAgnZYxx
	FI4kpmIb9dKo5p+lj+oYR9+80wBhpPoaMNENJRiLX2o93Dejxux1vY7+/83fStpo
	Hptp36+VbF50MVqd87Xlg==
X-ME-Sender: <xms:gH_FaRnn1UKSEPz2QWJE8EPdT3keo4WFUlUntYoFjO98bK4uvCeIFA>
    <xme:gH_FaUTTkQ3Mvc_mtzBgOLmOqcfdIvUgFe8Gf2FQk8FbNCYK2WqrCHfMmFW56sspf
    SVsufsryIpHtVrQBKQEN8ouiY1OgS32kiBzR8cfn3edZnX8GtvPcvA>
X-ME-Received: <xmr:gH_FaVAUFLpk6A-6t4icDbKLFWZXTG29p0ObA0v8Qr6vmyMeYgE6MNoNTptPK19lvIMDqh1V2NIaR9a6TwPlBmSNAcimpE85rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:gH_FabQJV0dl0LJc-fodTicsnk2Cau89L_MdyvYS1lvViq4mdQb_iQ>
    <xmx:gH_FaTpVGAdwcFN55yGltokxP_e9ujxMwuykM6y38XS9OvhUxH0jGQ>
    <xmx:gH_Fadzm98m5Yg2VcVU9GF9GL32qXvGOotWPSwqRtYb-XcTEXGAhPg>
    <xmx:gH_FaYL9mcDpmpxdp6s3A3xVlVHn9lYYAgn5UxRvOapPzcvoefFy0A>
    <xmx:gH_FaUYzLB1qbIx8vHMTK1BTXWbx4ZP4E2yW4cjab_o9SaL5CLmCj9c6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 14:48:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: kh/name-rev-custom-format
In-Reply-To: <e33142cb-1ec3-468f-8080-ba3bad79ae25@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 26 Mar 2026 19:07:57 +0100")
References: <xmqqldfgy1ye.fsf@gitster.g>
	<e33142cb-1ec3-468f-8080-ba3bad79ae25@app.fastmail.com>
Date: Thu, 26 Mar 2026 11:48:30 -0700
Message-ID: <xmqqtsu2pgu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Mar 25, 2026, at 05:20, Junio C Hamano wrote:
>> * kh/name-rev-custom-format (2026-03-20) 2 commits
>>  - name-rev: learn --format=<pretty>
>>  - name-rev: wrap both blocks in braces
>>
>>  "git name-rev" learned to use custom format instead of the object
>>  name in an extended SHA-1 expression form.
>>
>>  Comments?
>>  source: <V2_CV_name-rev_--format.51b@msgid.xyz>
>
> I’m working on rewriting the functionality in the form of a new builtin
> git-format-rev(1) that lives in `builtin/name-rev.c`.

By the way, why do we want yet another builtin in the first place?
Wouldn't this be done as a new option to "git log", for example?

Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925E2F0027
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164661; cv=none; b=gmVR7R7ceP2h7vxptH5WTs5ZnEj2ULLOxxmephZxgbJU9k1kHnPSbxGEmaj/IIspoiaI/6UpFs2ELLBugTbw55JPpkpk6wVvoE+v8WmYlKN2qjzcAIc3NMwn5XJHtezac/pOQRu0aHzL+Hij7eBheRULX3ctvMAptp1VNSUAkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164661; c=relaxed/simple;
	bh=CY1ItZAXPerwfHgf5z5GN1opRZqjZ4NKaj3qpxiF2xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W473SXhUlXoate181jlPleq/LZCmT/hlQm4IoF3IaWhU9LEDONVFC2OREB82pea4ldeqssmqx0OQ72AZH6aMH9sv3yTRi95OVb1+V9Isy1FbNgpPa8Ryca2wyoGDseodQ3CVgG+zSYYVwYttO7HVDsywGKGY0cHOqxsNKvp4LkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F238DNTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJfzGESe; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F238DNTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJfzGESe"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D166A7A0257;
	Thu, 10 Jul 2025 12:24:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 12:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752164658; x=1752251058; bh=TvZN6R7aSh
	5LD4mDm+iZlh1ykjvKhc9lmRlIe57twuw=; b=F238DNTB6Xe+wVPtWmOfdMbiZT
	TLxfB+K9ouYRHs5bTDJvNNUHIWIsNCphoCt7GZ10NdQeeKzo8DSD+bJ7anhEI6ue
	24dycXoKCkFkuk/pOYf6bpxW5UBowXb94tDLQvqHKu8v0WVgeur5ZBtkCJUAtp/S
	dvN7g3GXYXwRCyoF9A0ddt3L9cWauPDjk3PpRYPqgpMQMkokpGalb9ZP4G/xMVcl
	HimkiznJdI2vqVdLjRevRhshTqdTkGybjQO7eI4JPn8T75Pqn2owvOH3KcTI9ZhH
	CRqMsHP0PJ7ausX4eiG9DyvdzS9TLiQu+YbLoL0/37vbXjn6epJTwSbb35Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752164658; x=1752251058; bh=TvZN6R7aSh5LD4mDm+iZlh1ykjvKhc9lmRl
	Ie57twuw=; b=nJfzGESe7zR8fSXhYIdX+lZoMkOcdq936GyhBtZ+0/VZ5E4jU+q
	/+bSUqntRexZqQJUMVEpd2/lD0NsIf4kYgGytWAip2Zu5OJOvVabLljeyQbiJ5Xe
	frvRcoUaOicie9QxlysE+t9PQIlyn7xcfAzkEVP8LKfC2FCrELz4o2+nzF/fPlkS
	tNl2SP4nmpOybFr0uhm44wRQ3H1RJEsPFk/04P5vbp8rEYNPjHMycId9bmzz9NTS
	djfDQus0kDxX5df3dJJw+nfmAtuufd3FRIOGc0PJ6yxGMcZhYq2qMrYEkQLdkgV/
	/GPeDsX0FVz40c0aS11ITOUoz9EC2c9mLMA==
X-ME-Sender: <xms:MulvaJth55DLxsgW99ByW-_79iKOQ8s51Daih0KRxmQLLfy_Rd4gMA>
    <xme:MulvaNEAmnoLt6OJgYpm-2LgV78QNyPXiIt733H67Y1Sc9LqgCxbhbCykrAxKNJ0i
    p8sYE9D1Vd_lkxssw>
X-ME-Received: <xmr:MulvaCzVm6DtVFaMWwr3WA-uIpjEilrolEVVAJ3Tywidocl9oK0Y7Psc0s_sruIXYk5qpDF4XlRKgXQCfLwL8qcEH7DfFyQpcq55Nzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtoh
    hmpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MulvaP1HdtlZtFTVWMXkFtnuNVNVAXVxlMh0C2VWjDfGFmAC4sDUpQ>
    <xmx:MulvaKrbERfuedmSjx4uQlNLGP5yRD2L-7IE6P3y6dSSwB8ULW-3KA>
    <xmx:MulvaEV8Uz77G2m7K7JScfInU_3QwuAs3uC_zYj2pVHvwO-Qjten7w>
    <xmx:MulvaLroQiEU1YVr1Rtwk7oWQ7QOmJxqI2xsWr1l5MB-6vA6H4Bvxw>
    <xmx:MulvaCZtpR_Lyi_cQ4eG11rJa3yQhPmcHs8Mp8DAqu_rbWLW1jGwR_Pm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 12:24:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  irecca.kun@gmail.com,  Eli Schwartz
 <eschwartz@gentoo.org>,  Jeff King <peff@peff.net>,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v3 3/8] meson: improve summary of auto-detected features
In-Reply-To: <87h5zkcbk2.fsf@iotcl.com> (Toon Claes's message of "Thu, 10 Jul
	2025 17:25:49 +0200")
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
	<20250709-b4-pks-meson-cleanups-v3-3-29ab15b9ab85@pks.im>
	<87h5zkcbk2.fsf@iotcl.com>
Date: Thu, 10 Jul 2025 09:24:16 -0700
Message-ID: <xmqqqzyo6mkv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The summary of auto-detected features prints a boolean for every option
>> to tell the user whether or not the feature has been auto-enabled or
>> not. This summary can be improved though, as in some cases this boolean
>> is derived from a dependency. So if we pass in the dependency directly,
>> then Meson knows to both print a boolean and, if the dependency was
>> found, it also prints a version number.
>>
>> Adapt the code accordingly and enable `bool_yn` so that actual booleans
>> are formatted similarly to dependencies. Before this change:
>>
>>   Auto-detected features
>>     benchmarks      : true
>>     curl            : true
>>     expat           : true
>>     gettext         : true
>>     gitweb          : true
>>     iconv           : true
>>     pcre2           : true
>>     perl            : true
>>     python          : true
>>
>> And after this change, we now see the version numbers as expected:
>>
>>   Auto-detected features
>>     benchmarks      : YES
>>     curl            : YES 8.14.1
>>     expat           : YES 2.7.1
>>     gettext         : YES
>>     gitweb          : YES
>>     iconv           : YES
>>     pcre2           : YES 10.44
>>     perl            : YES
>>     python          : YES
>>
>> Note that this change also enables colorization of the boolean options,
>> green for "YES" and red for "NO".
>
> Nice, I'm really liking this change.
>
> I've also reviewed the rest of the patches, and all looks good to me.

Thanks.

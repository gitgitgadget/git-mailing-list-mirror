Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8EAC2E0
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293159; cv=none; b=LBes4scMODFAEFyuE7FuUiC5fWzo28GnCqDNk6y4oKbMrUjZ+e6LFQEavgy70WZoGywo1nWs+6SOBiqPFBcgP6tj+8aTo7Bfjb7CSspCEy1A694V5lDpoyI9QizQD6U9SWjbmw3KyzuFwdjWJGqC5yTQ5ZVN/xkZFl68PywsyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293159; c=relaxed/simple;
	bh=8DM0Rkr14cBwqjkEZc9U67YxRJCqtOJy4FLqArF18W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0LIH0fgUKgl2cXY8uGZYGa7pm57VlHQgp51VZZ6BHrMWZTp6+nvYrVRAdtX3E//VLpYaR7amYB4dwWqbmUc69Xr/sIoMEfTj1bdasJ9NvkHmJHb33pB6VM0Aa3jqqWTsLNL5Nc0YUwiE9TFHgH7szmdqI4fFK7D8iR5Ngd0utU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZOP8N6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Om3Isg6T; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZOP8N6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Om3Isg6T"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17BAF14001A9;
	Wed, 23 Jul 2025 13:52:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 23 Jul 2025 13:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753293157; x=1753379557; bh=yf8M7TtFJe
	hJdqqIz3lfekk88jdJjQwy7vus+rNRD+k=; b=WZOP8N6SLDu7KiT/lxKSHjI+d9
	xtwURld6jQRVINTqb7/dp4n/OOz8ZRyoHzDeCK4OsDpBn+rBVzruaXkaMEqEcup/
	1us7pGV8wSypkTE0vr8Qlqie40ixDsNX14VdREQ+dmDHfbjZrR1G5IFY8swMaOXR
	ykDO/VqvTjGE0vWXQMOu5iLsNf7ZCE+pAA29dvyBOTs/xiiLOFSSUFyghJorW6tj
	0tjVtvXf4KnM0GMVdpGemxbYQphpQzfF6wtB2AXEIADixRKPOajlzn8Clln5SRgk
	9Xxwxw+8VEK8Z0btMuSGxUwTJBFe4YOe8DFWjsuZ+3rBhbiAFMk/8h2hWSmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753293157; x=1753379557; bh=yf8M7TtFJehJdqqIz3lfekk88jdJjQwy7vu
	s+rNRD+k=; b=Om3Isg6TuTgefHhA866Q97KNLayGkITnybD0Dtl2xNBg51PHha/
	6uwt/2FlB11MwifleKavcITvHUllY6VkJNWznhaCmtAriKipW8nso0FITcEHT+24
	qPAVCqzxaSvz68dNGNq1/aHMVgWGSfw7yNchvypzB9lHSKuwnvGxQt8axiF0c608
	zbjs89OSv6OYMiAvlrY4hoE/sfTn3Z9va9fktgtGEtCyesOt7yBEBMfZVbZqh2O+
	cDl8q3a4V8DJ87kMlcegWu5jIym2b7HG+bxBYvByQmGDwRTWMxPfz/wfXjJjhmZg
	Sv8OCxqhE6xAcynP0vG76IgcZMKczjuqDtg==
X-ME-Sender: <xms:ZCGBaH0GSi1XddejVr_7rc08hK5ETTt5L_hdWE4ONJ78ZYp13_hPkQ>
    <xme:ZCGBaDrt2Bbn08mGMHpIzvMjYB89Mh1irUnQIIcOwhtkT7bpr6lRLv3YqzEohBxVF
    HNqpMBBMl6pf3cxvg>
X-ME-Received: <xmr:ZCGBaOWLpitYKKwKrEuWaQrsG_FI2Z4PFDmEhNpv8ypNdMhD8RXDKnYJoAeGfDiRPOgJTM-wZA7Wa9fNkMqY5ZoPvhQpXL97HKBcEd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrh
    hgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZCGBaOYiagyuALZlWdKjVdHABC0UFj6qqsR5Aa7IqsDk-k36IRVIow>
    <xmx:ZCGBaLff4JYEmtv1uN_BAIh8bqsZrip_Fyejq3AOmJDRbLg48X7jiQ>
    <xmx:ZCGBaI0GTKlG1hNNVQvT3Gtcp4AqA-ZHwaLQrPLa2fh2HCAHHEceiQ>
    <xmx:ZCGBaCJzpkFFKTxJ0BZu4aYo45zCVyjSROvr_tJpZLJMktWHKbS_gA>
    <xmx:ZSGBaHKF76MS7aDugkOyuMdX0O9GsM1uVxXAoAzyRl8EEIrdVdVjQeEl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:52:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
In-Reply-To: <xmqqecu6om3t.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	23 Jul 2025 10:25:42 -0700")
References: <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
	<xmqqecu6om3t.fsf@gitster.g>
Date: Wed, 23 Jul 2025 10:52:35 -0700
Message-ID: <xmqqy0sen6ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Aditya Garg <gargaditya08@live.com> writes:
>
>> +	if (mark_seen) {
>> +		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, CURLULFLAG_SEEN);
>> +	} else {
>> +		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, 0L);
>> +	}
>> +
>
> Why so many braces around single-statement blocks?
>
> According to
>
> https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions
>
> CURLULFLAG_SEEN first appeared in 8.13.0; INSTALL says we require 7.61.0
> or later, so this may be OK.

It might be obvious, but I meant "may not be OK" here.

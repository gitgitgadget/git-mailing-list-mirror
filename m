Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1031E261F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139715; cv=none; b=ES/Gg+qvfS6woVW3LWDhQ+aJra7rQdAAvFNSXwjpnO3fFLA54OLyc/r9j5XnY1EfjtXpTh16O/tWpMGBb1WFzYCRKQp7qekLr+fMG1ES0UCUH9nHrAc5CFSw0mng/NNxS22pbNO5t6UqIVvMGGEIf+He0LPECz2JMLh9NZIYcaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139715; c=relaxed/simple;
	bh=5YI8Yhg+wFbM7+Br5ohmH6hlHew3qkb00pROcq4qNeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lyZ1ZxUp7BdgPuA8o9ypsmly0U0yBt+fC5uGY8uFvVI2nRmNuNzCX0Mxt18kbcJSFB/dedSDLhV9Cwq54D8tabA2Il4OBfEeAogeTMNyD/08XCZKUFE3XJBpWnCBU+HDolKGvlbmOnpA7KoExJP66ilmRHB63SzzR3//BtHoCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I0uCHkJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJKzXVWY; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I0uCHkJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJKzXVWY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DBED3114012E;
	Thu,  5 Jun 2025 12:08:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 05 Jun 2025 12:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749139712;
	 x=1749226112; bh=DrapKtyuI/OGr7pUv5GeeI2t7IFuUiCyIYGvv80Fsbg=; b=
	I0uCHkJmMv99xgRNXPViuh2sztlsvBJ8M4qJu7v9U3V8wpF81q4jHGF6k74JvZib
	oM58pdHTKfqZYtRySuwW/hivTjaE6Z/u3mfY3TSKPnkFIkhUzc5fCeDoxYByANci
	7oZudOiIuK2PSgDYubP9HP1aEwZ9FzaNQeip4S4Ql/pNF3lCXw6DsVjagnOZlrm4
	UWaJW0pGCi+gXpALY/wB8ehwOlBSQI2j5V79Nz09eefrLygnAAmb/rIHXF71sQIj
	Qc/JzwFT79Tjy7SYihRY2dye1F27pRJ1RiUTMDHzGnYMC2YDrLU4spn/5Y8g9uNV
	TdqzgI/h7yjKdnQUSY/NyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749139712; x=
	1749226112; bh=DrapKtyuI/OGr7pUv5GeeI2t7IFuUiCyIYGvv80Fsbg=; b=Z
	JKzXVWYt1V7Ri+WTRz/U/3yBoVuq8x9X89uQ7xmKeLaXIoDd5jfOWJiPmOf/bCyt
	I6yjSTXNOiUYgyoSUt4fFB85Ot07jpmpY2stsmw551E1ycKulgCKEUaxZ0UDseV3
	zLlN0ArYk/5dE4+PCMTC2BIonYGpFNHj6zu17oM2s82W8WB8snp8ErdgPySzh+jt
	VzeIrv+Qxk/+oFj3KlkbE9KF27vRye9i/YluzaZ5KwGit7+pEdDUw7FrYFM+naqc
	7nlDJWlhYbRJeMZzLvOqc03H6M40W3j1LKTd16ByOx5nqCTlPPPMshCfeBh4PwOe
	Q3Zp/V4H0zO9B8M9HNVPg==
X-ME-Sender: <xms:_8BBaNTFpOKfzp-5OVfgdeaje0bEvDKlBjXwM8DbOdiCQUwROsIA0w>
    <xme:_8BBaGzPSgkEg7-z9kZ4HtpwCpL04MrJd3wDlZAt1Pg6mgs4m_l267rpIvjMwBNnK
    A7D8K8_CO_rLOM5jw>
X-ME-Received: <xmr:_8BBaC2xJQJutgx0uAl0uDVZoETNNvPtHKVK2K2M1sZatUNq7NpKlOCwuODYRmAQckFTAJR7OojnVoMOgxxY5KMLRynF0peEjOnj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughith
    ihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrgho
    seguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_8BBaFBKmme0EsnIOfYll5TpBDFq1AQAPWKu1fPxu8PNA-4nWxUcNQ>
    <xmx:_8BBaGhIednDiROOhH2gUYtK1c4B6e4TaxeZFxhnYpYEMKm5Hl10iQ>
    <xmx:_8BBaJrgdwATTTWrSSnG19rbBubOtl32yTdcyQKeZWVPr6o-4Y9xZQ>
    <xmx:_8BBaBiPavNyoLiHfUS2Q6FCShAb7asoZ6AkSbG7m672U7RydQXcaQ>
    <xmx:AMFBaB3gIcoID0XDUc1tpDPy-pQywDQwX4bSsGAr7AOjJkHNbHv-dL-s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:08:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Jeff King <peff@peff.net>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,
  brian m carlson <sandals@crustytoothpaste.net>,  Ben Knoble
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v12 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <PN3PR01MB9597EA7301052F34B6FE3E48B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 5 Jun 2025 08:12:53 +0000")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250605080002.GA2998537@coredump.intra.peff.net>
	<PN3PR01MB9597EA7301052F34B6FE3E48B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Jun 2025 09:08:29 -0700
Message-ID: <xmqq7c1q9nnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Aditya Garg <gargaditya08@live.com> writes:

>> On 5 Jun 2025, at 1:30 PM, Jeff King <peff@peff.net> wrote:
>> 
>> ﻿On Mon, Jun 02, 2025 at 04:29:33PM +0530, Aditya Garg wrote:
>> 
>>> @@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>>> 
>>>    server_fill_credential(srvc, cred);
>>>    curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>>> -    curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>>> +
>>> +    if (!srvc->auth_method ||
>>> +        strcmp(srvc->auth_method, "XOAUTH2") ||
>>> +        strcmp(srvc->auth_method, "OAUTHBEARER"))
>>> +        curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>> 
>> Coverity complains that this "if" will always be true, since one of the
>> strcmp() calls must return non-zero (srvc->auth_method cannot match both
>> strings!).
>> 
>> I'm not sure what the logic is supposed to be here. If we are matching
>> either string, it should be !strcmp() for both. If we want to match
>> neither, then it should be &&, not ||.
>
> Good catch. The aim was to not execute that statement if authentication is
> XOAUTH2 or OAUTHBEARER. I'll fix this logic.

Yup.  I'll refrain from merging it down before the reroll.


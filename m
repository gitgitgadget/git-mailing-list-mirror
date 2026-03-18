Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843A62C234B
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848236; cv=none; b=JDpCJ82d73L5t1/7xSggjLdec5cdsxrkm7MK20qk9OgPaNEGm0/r9ooV8YJQz5949p+dL6ItNcvEjkXnh4PDS3fYDm/PbEoqtWVvbXef9Ruyf7S1m67GTk3+XQhv4/kV2SsH46fh1Z1oFSUxPTJ/UUBX5C8S4DWdjMN9/2fcqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848236; c=relaxed/simple;
	bh=0cHaVVNOqQkRh7essLiijdUsFs0TdqbArtC34rpmHnM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Nz3CG3OOnEPyOKhRqXLRdhx0dAe4PUsy2sM4bESim4SO0Piqn8jHuH4QLbv27JwAaQaB74ygpw0WqJX3t+c7bdBvf404/Rp6VSFhnpshCoR2XR882l8NCjUQjmnEpDgeL28ut91MC/GdUDgcrFN8X0EktKSDU/a/b0iDeouJQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=REUFAqFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sXJJF3j5; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="REUFAqFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sXJJF3j5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 88D791D000A4;
	Wed, 18 Mar 2026 11:37:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 11:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773848232;
	 x=1773934632; bh=0cHaVVNOqQkRh7essLiijdUsFs0TdqbArtC34rpmHnM=; b=
	REUFAqFprehMZuLiFecXBOnb9HsQtMYWR0Wfta7LF5UJ3Vw48uqP7k5f1s8r8792
	HPTAZrnyr438HIWfj5/7M6I70EY/MxTlbfvwUb8QrweCfJ7apYUxg2sd/mvO5LGB
	HhzWInpVHf6bXnW4O4z1srdQYyJl6AtcApdh8B5DN7PQDLFdJI71/TEzr9BbcUDt
	rgeqEWwXmLSLgqcP4heNpHFLskABpXBKNTBneyUQCkWAj0oiPCDfiHmMgyWrwEVo
	rzQY9GsqJyJCMqDeMxF0+2f1JL/NZUEcIhg/f69g8rTgJMJGcTP1Z8atemPBGdfr
	fQUxwdYkk1E3ink8EoS7MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773848232; x=
	1773934632; bh=0cHaVVNOqQkRh7essLiijdUsFs0TdqbArtC34rpmHnM=; b=s
	XJJF3j57+41F9QWn+WRWk8ux04B9wO6wp91KbfF7IGCxrKAMlexQBDZ0fNtnP8QO
	/ybNWku6PfbXo36JGcs2goIwINxtLn6B7roseqGrE+lBO64v5QO+5vTBQj5HquFU
	DtKNWUH9AHcxUAmTrDceUUs5wpNSz/jPidywvgHr5AuIKZKbzRWqmSQhWm2tv/uF
	zu3wBLKOWJ4yrmMYXQzn77rpEH34B3b08TnOCKAFahh8HNVo2xmQIwi6Dwy40Dwr
	OQImyEW3EP93fDq+IoHM9JyaGYXBthsRBm9shHMO+D3n/GuHWaNp0wtrX70/n8jO
	jyEUvKAR6JNU/xqj3hCWg==
X-ME-Sender: <xms:qMa6aZMPtfG7TAvqBP7yetptmsBmjWbaHoNUsR3PN8Z3JrZjYUOZKQE>
    <xme:qMa6aWyHKEf8wwJ-EZAiN8byqNIyKekyQ4Yw-S9eRevDeuSo6GF71eGJP1pcjX5S6
    u0pL7cqLuYkMprpLalRN6TnExwpfETaqZj_ZJqGSYnpzdUO2n3lQlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qMa6aX6B_vIzN_DRN6jRzQaZrOqDKMPY2Aen1CfeOH4uSot0nkCZ1A>
    <xmx:qMa6aa2ftuqDxM5Zw2g3O6Xv93Z5fa4CmX4wBCHc1kJvj58wW3LPEw>
    <xmx:qMa6aWDoeSZZBhCm6m1SKg_aMwy7rW5oUfbYCHneJU9PaFuOJ8KaAQ>
    <xmx:qMa6aU0cxv7M1o7LIhNDAmdb_f7pIaNjCSBx3494DPWzIDpA9vp00A>
    <xmx:qMa6aQj0ZgoLFRDI3GwWTWcVK-XPbMIbgfFtzoGiTh5xycXHv2YzRrN8>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1DA5C1EA006B; Wed, 18 Mar 2026 11:37:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALlot-drpGVV
Date: Wed, 18 Mar 2026 16:36:50 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <6eca2a08-78a9-4186-a199-c876f07415ad@app.fastmail.com>
In-Reply-To: <d3813f1d-174b-4d1b-b0c5-c6a8db260f6c@app.fastmail.com>
References: <CV_name-rev_--format.4ad@msgid.xyz>
 <name-rev_--format.4af@msgid.xyz> <xmqq8qbvz2dm.fsf@gitster.g>
 <d3813f1d-174b-4d1b-b0c5-c6a8db260f6c@app.fastmail.com>
Subject: Re: [PATCH 2/2] name-rev: learn --format=<pretty>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026, at 23:07, Kristoffer Haugsbakk wrote:
>>[snip]
>>
>> Or there may not be---I did not check, but you as the author must
>> have already checked, hence this question.
>
> This is supposed to be tested by `--name-rev --format=3D<pretty> with a
> note`; it has a note on the first revision but not the second.
>
> Here we never use this pointer again and we get a fresh pointer from t=
he
> strbuf before freeing again (whether it gets populated with a pointer =
or
> not).

Here I meant to write: =E2=80=9Cwhether it gets populated with any note =
data
or not=E2=80=9D.

>
> But it does sound better to just null it. There=E2=80=99s no need to h=
ave it
> laying around.
>[snip]

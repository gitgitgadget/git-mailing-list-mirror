Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E482D948F
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155054; cv=none; b=iWel510Hw//rmJ6f0Le9LNht0Yr3XyBLsM4FtenHH/kW8dfZJ35spyK1zQvn/EsvDMbLWcxr9GmqNhJhd87Go1IiHia60lW7kOqY4Lw+IDhsIYoMKHyCKwyhQTX5Cf77eDQ0w+FsyLkULtYchBnnojR9qp9cDjOpYie83Go/YNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155054; c=relaxed/simple;
	bh=kuc1GAKLjeYTIaA7Ng4/PH/eTLEZ3L71psO/HuNnpgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjJA/tncpckhdTwn/Mc/UdAOt4Kh8dN34QNS9fR0xtAOE1U8/t8EH8hlswunP8BI1o0YpDiimmyfvf7DFnPzOswt11FtxGlXCtwFKUbR1EeJ2RKAhYNPBGlIAXGRO/ggibst20HTHfipfPaR1VllrLb7PUfsU0tPqjejE0tHmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xojm42d0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMc+WG+1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xojm42d0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMc+WG+1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFF26140018D;
	Wed, 22 Oct 2025 13:44:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 22 Oct 2025 13:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761155050; x=1761241450; bh=BxH7CjRRKP
	hfHgkILPKUZZ/tQmhLwSrle8I4/9iZvk8=; b=Xojm42d0GJCkm6/rkEeLaryf2/
	hWYaLEXe5Jc54IKMQqKUlD8AhttfjB+gTkU4GV5DsfTcjZNfVPCCEsqGXzHFcQPy
	nITaPvLpOC5EXlmDldBz4z/aW/4sG4ceP3pMMlzKiOycgM2pagO4hXiBl6mOi+zg
	uoE7N6FYHyzN8v4SmUNP7uZRunKvj8phWWTZttom9bC4bufnKhlPbEyiobkUFuIb
	X/uibpBWadBa4+LujKkFnrmA/rP/lIEuT2iJFo2a0pSorVoHoxFJGaZX6kdKRhlw
	4ErtX68KXDQCYLQlXovLU4J5qfzmzhtPM3LHoBt3b+U5RVM9W6OifKrMtz0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761155050; x=1761241450; bh=BxH7CjRRKPhfHgkILPKUZZ/tQmhLwSrle8I
	4/9iZvk8=; b=wMc+WG+182chbmYQRbUfoxEvRGdigBBrrMhUwbTWClq0Y7OU0/t
	HEfgqG1sQ59ClbaOjXBXwENaW9++ueYii8C6JGhzX4LNn23EAGu9U+U+7tbYpRoQ
	XGNWL96skVubVVRVFZ07YiKvzNyK0MBhPpEVt3kcEidttShvY20PcHW6EYdI2rzu
	zFp2rLMJlC5FNjnDkGe12JLQDqNJ0awqddEMkbpvnyHtCXGzG9XKlW335fTUjdqd
	iJ5WjwzvhqdvxT5Gzpan/gie/aKK6NzScXAf3OCSPp8uXBFIw4rHfniQ6gzTJ+12
	JKmX3D6oKEjpHgupPn3kHecGwNREo9pHh4Q==
X-ME-Sender: <xms:6hf5aAAcRD9UGdaviH-qCn-sozMfMmUniOPs82BVDt7CnxTmEgyTMw>
    <xme:6hf5aGMtmehZ5b768XXnxSwK19jhw961px6hi-yH4dqj2k4mfNngSV9jyl4zHjuUd
    nFrUVqFSnHnP1b6wi5ZNS70M0uq25Jo4kHYMcLU2cnokOwPZKZWGBQ>
X-ME-Received: <xmr:6hf5aNafBqJBJCSpL7hFFM7-My8fggFCLlOy7CYH8JqTIUZC-ySY20xeTUwymA_2BMBCmoJOQlY0EJ9esmZEAKWpDcqiMmSZGDED>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsggvlhhkihguleeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehushhmrg
    hnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6hf5aNvBocGN6AxjiKkeZZFHi-K_rWz6PRnTr_aLaA1I6Itxfw_wdw>
    <xmx:6hf5aHMbZMyypWOsMNXE9IogRtG54STrK-r4cU4WFDvhA2IsQzjoWQ>
    <xmx:6hf5aM4gfY5KRb5G8Eb_3m6wHof59RgLSHaYkgsB1g_O1Ow22KYfKw>
    <xmx:6hf5aFSCsAYxFrUx62__2osZXi_RXClzNIcUTVsrKtaX5Jv-DF3Xew>
    <xmx:6hf5aFltxBPPAS8YmRIJ8c13uLjT3vdVidFkAGz08isvwzq9yxMYP2Xe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 13:44:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>,  git@vger.kernel.org,
  usmanakinyemi202@gmail.com,  kristofferhaugsbakk@fastmail.com
Subject: Re: [Outreachy PATCH v5 2/2] gpg-interface: do not use misdesigned
 strbuf_split*()
In-Reply-To: <CAP8UFD3OTMi6uxv+z4rTqJ4wVpmezSG2Yj8tZMpgptWaWU343w@mail.gmail.com>
	(Christian Couder's message of "Wed, 22 Oct 2025 16:03:50 +0200")
References: <cover.1761135129.git.belkid98@gmail.com>
	<5df667227b8b8951bad6c3cba54230ea8f6d3830.1761135129.git.belkid98@gmail.com>
	<CAP8UFD3OTMi6uxv+z4rTqJ4wVpmezSG2Yj8tZMpgptWaWU343w@mail.gmail.com>
Date: Wed, 22 Oct 2025 10:44:09 -0700
Message-ID: <xmqq4irqzv9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> @@ -887,19 +887,22 @@ static char *get_default_ssh_signing_key(void)
>>                            &key_stderr, 0);
>>
>>         if (!ret) {
>> -               keys = strbuf_split_max(&key_stdout, '\n', 2);
>> -               if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
>> +               begin = key_stdout.buf;
>> +               new_line = strchr(begin, '\n');
>> +               end = new_line ? new_line : strchr(begin, '\0');
>> +               first_line = xmemdupz(begin, end - begin);
>
> That works but I wonder if something like the following is not a bit better:
>
>                if (new_line)
>                        first_line = xmemdupz(begin, new_line - begin);
>                else
>                        first_line = xstrdup(begin);

Yeah, that is certainly much easier to understand without even
reading and thinking.

Thanks.

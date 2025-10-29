Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125D2EA17E
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754374; cv=none; b=CNbx1rLkejuUoRMmDhiErDjQCafKWPAj9I6OsXasHS9ORP4yhSERbMZxaxG4vemt4w0VvIvxs+2WdSU0yE0o5UYvr3BzLMrV5fT216Gza4/ih8JNfYdTaShWRx46nYbu589M4LD/5dwlVt0R+oVYVHTfywh0ZuHmxOyWdaawE68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754374; c=relaxed/simple;
	bh=cD/Byr8fmZv6JQG5BgsxedcUnXOKmNhfs8OKDeoM6k8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzp+RmuOJJjmff5mmO8kAjlp64wV+qAVIuouSnB4EcPr10iGWJEwR0R3NLV7IqayKgfvTqpBXJfwREPukl+bJzCEGOWgoXs3t1NSIAycE+zSE0mzadHz1OjTKhb5DK2K7LlnfWZIKD8jmidxADJ5dIo9rslpL//Ia8MYANCep28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gzG2ZwCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8L9VJcM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzG2ZwCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8L9VJcM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79F7C14000B6;
	Wed, 29 Oct 2025 12:12:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 29 Oct 2025 12:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761754371;
	 x=1761840771; bh=I3ZaYnyI4kmXK4QqWFkvyeCFwqph47ONvgGIpTbVUig=; b=
	gzG2ZwCalkFR33j70PkXs2wkBc1sx9EuFHKyWGNJoi0dMQIE6SJSCK2nh5/RPn5V
	MgZD08mD08ohjOARNNSgb3LqAXeTVxtHae9/p2s/UjwE5Inml7XPMZfazL9fXv/X
	W3rgZEumiq84sI3e2YPwaX88YUX27EK3f+j3Gt1r9AMshfRmruXd8Xzjaf7hxkco
	VFg+8BKFJh7HxRQjXQc0zwlVdfxfEztl7LLCvr2OUnYVyuTrefjcXSPsJNVpbfp7
	PcxbOqJ93ovOWxwMHn0f09VhMk4ivjQTcT510YR6/A28q/dVZSbaLsZCSkVEV3WT
	pA4gigTrIX3wQZN+qzQFew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761754371; x=
	1761840771; bh=I3ZaYnyI4kmXK4QqWFkvyeCFwqph47ONvgGIpTbVUig=; b=P
	8L9VJcM3RO/8cWUQrklAh5kOa4I/CUxGq3gLY1y0ayMAqYM3I9JAOEPInAoFMAss
	UWcS75n8BElkN9n9V8FoX9FppNhJzxG11jWmzqH4u+mJKdmvHx5geaZpKv6DR16b
	AI2ECVzR0DSbzQlS833DTSjncZ719tcNo4YMZ0f8l7rF/ROEnM7MA9BiFRXWufeu
	HvWY65hsQumNcur5o18epneKoJWzP+hxLV7vyJ5VI/bJUYF57JhT/NNLrNWpSNAp
	G8dAoeN7rdsog3s7hxR67ngpMd/pweOFtg0xH2DVHQ/4iVRuj8VAvEv6fi/DpD6Y
	P2uCPwfqWb1P5qaRO/drw==
X-ME-Sender: <xms:Aj0CaS0UvuxLJc6hHQVZwy6SwSXhZS6vu09AH_UD5E3139mutJF9qQ>
    <xme:Aj0CaXrlPmWjpnGcN9ljpUCV5DX0o1Hbk7K-tuXIxcq4hhOoYmzTCP7lkxhadGJUb
    mwG5u-vBzEAGv51vGmiVKpQsuOR18ZkE-bEbCWjix0SSMlXBP9mBg>
X-ME-Received: <xmr:Aj0CaegliX35RASRnSCFQGRJy6295ZJSLT4grvfiT9k9UUF692nPwTLBaROuCcOA3fRjvPPU9KD3DVgDg5pnz5A5KW6er61kdfca>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Aj0CaT9J4No7QNmvKkQCWshb1M6adgp0HxHUxelB5fC7EMY-r7UkJg>
    <xmx:Aj0CaaX54Vz6Xqo9fGov1iaX6kh0aINPUfexLf80HgFMBZ0QE2Q6hA>
    <xmx:Aj0CaXA_P97FGxSnEWwF5mF4NSY92_2QBK3F44j0UqGzriZrVbRJbg>
    <xmx:Aj0CafGeM9i5ZY_vfIc84AiFTFAG_5gEBGtzXtRUvZa_d-O9bAD9Dw>
    <xmx:Az0CaZzqpW7eI_CJCkfltl5lSUCqRHz8yPGo3ckSkH9v9sNcVq2o6T08>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 12:12:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] fast-export: mark strings for translation
In-Reply-To: <CAP8UFD3S1s3_p3m-ZzRO=B7nQwJvbYMBew8_MZWJwSJEm4oFTA@mail.gmail.com>
	(Christian Couder's message of "Wed, 29 Oct 2025 15:29:51 +0100")
References: <20251028081232.3068147-1-christian.couder@gmail.com>
	<20251028081232.3068147-4-christian.couder@gmail.com>
	<xmqqv7jzdtvl.fsf@gitster.g>
	<CAP8UFD3S1s3_p3m-ZzRO=B7nQwJvbYMBew8_MZWJwSJEm4oFTA@mail.gmail.com>
Date: Wed, 29 Oct 2025 09:12:49 -0700
Message-ID: <xmqqv7jxadq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Oct 28, 2025 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > Some error or warning messages in "builtin/fast-export.c" are marked
>> > for translation, but many are not.
>> >
>> > To be more consistent and provide a better experience to people using a
>> > translated version, let's mark all the remaining error or warning
>> > messages for translation.
>>
>> Makes sense.  Should we also downcase some Unknown and Unexpected?
>
> I am fine with doing it as part of this series, but I wonder if it
> should be part of this patch or in a separate patch.
>
> If it's in a separate patch, each patch might be easier to review
> independently, but a number of lines will be changed several times in
> this series. So not sure what's the best practice.

Rephrasing the messages may need more careful thinking while
reviewing, but if you limit your changes to only downcasing the
first letter, I would think it would fall in the same bucket as
"While at it, improve code indentation".

Thanks.

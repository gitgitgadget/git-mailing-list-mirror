Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF127B343
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773801949; cv=none; b=OJJUNmlADNPSlUHDAuf3GsdR4IMAii65S8Q751QyvjS8EzGWFNEXs+ieTHdquCio7MUdAMvMudQe3DnUMKzT2KA5twZQp1fyu+ehe4gsRaF3hLaiD6JliObpL1BFw0t+8i43pHCkYPV8R1JusVHF0yRXnuMxQjma31lZB2thiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773801949; c=relaxed/simple;
	bh=W0cWspixRkmL3GryELLfw6LSloO0DkqYxT9xn0m1yIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DS88mDRP9g5AetCXh5lY+zoGGwyqoXHdxZZyk4Y4lRWg2EWgvnxCRQDb5ekF0mjgb8OXr2Q6iKW8k00c4X3YG2lWKJBK34fUmcnwbbyt8grvlkboI4LeK4e51fQRYw7l/RqfbRexylWDjlMiNq2hniAbaS0AWQtGcnh8LPp+tP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RpnBuB0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xP8IkKyn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RpnBuB0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xP8IkKyn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69FB07A010D;
	Tue, 17 Mar 2026 22:45:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 22:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773801946; x=1773888346; bh=ARnqB1kab1
	QVGogi9dPzXHZ9wqyv1BkTUZO7TJmHHt4=; b=RpnBuB0I6g59qoa7AtPl5HIsUk
	CLfUgTAXvEr2kO1UkRAS/g2tdXD71RGsBKxDNm/9/kKoRU5QtOHCVflT4wcVw1BV
	HpNQRK/4PvJRXY/mzqvhVhUMfZik6C8fKUCwU3XJonQE+o03s4uWbeFzkQnvHSVd
	O7iPkPpJylii9bKBn3orlvp+0JiOcq0qgTr5KP3KVKn8DHENNI0XpzUJs7NVzBR2
	bA+VKhoywk0cByJBoSSqOZhEmNMafww6PFfXWzEEczg7h+Zpm0qBal9zaMEUjrS3
	PcibfNu2QduGjYqFMrfo7e30TAg/S1gGNVm6EAjhD052Wu/SXp35OvN9Wtbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773801946; x=1773888346; bh=ARnqB1kab1QVGogi9dPzXHZ9wqyv1BkTUZO
	7TJmHHt4=; b=xP8IkKyn1bmbxTXt3o/PvPyP5d5mISBJcXFIO/xYzrtjYBcrDR2
	wEVx3DOtGg0LHBnYEhkkgXJc08idHrj6rfiK90FzEyvZo1eafhRSQio79B03YerH
	tcDbeBdWvWeF2GU3ktliKnj4qRloQqxfMpZrqHHwCLS8rubLnRjYqeYkQrA2fqNc
	9bmFKpMpvbCS62v3QeoaQiGkcR2Jo6qxv7aqFg7q34IOF4Fyg0hmF78H0uaXrmvH
	cRgpYg6yHriwR0MqNwgAOD4gLVIBpJmE71PFEyjAjQxWtnto8bHZzXmt06MbxDWw
	+RbZcxgGMA/2Pkn8pr0QQsjBSTtSY/1XlOA==
X-ME-Sender: <xms:2hG6aUYIs9vebcbiDoWpcqdhkfFu4FGdy2UrYxtuMBukw3B2lxM-2A>
    <xme:2hG6aWYqYBxC55Rm-7xmqi6hyZb7wLsEXyg_l5-9yXo8X_ScIy06xq-mxGHqgF4lG
    GOQiRg70Hfebp3eniQzaIClxxfVerdJrnNHhPzg5VQglc-AhE_B_SU>
X-ME-Received: <xmr:2hG6aT-_-3I8X5TfyORPWRmyt2Dz0e0aj-jFKIGmRoGBpM6pPHg6XOSfHpvRJzGpl35t5ILviIVPGeWQLlTI3ho0UTeugwEs0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2hG6adgVN-xtlx01MC87-lVuFtwLlPY4NnnXN7Thcqz8nZFfQH48Bg>
    <xmx:2hG6abeSdTH6yuBe_mwQmKt7JsGemdWQQ6rejKyJvuIYdXxvIJ8rOA>
    <xmx:2hG6acovKvKtQ5olCZ8qIyHJapFSeUi4GgghF9iarPvniBFGrK1NEQ>
    <xmx:2hG6aYDoCMV249Ptzmi2ZXaMZGdXs-ENtStgjZyFPozrsRsQa0I3SQ>
    <xmx:2hG6aRd6FTAWWMr83aHys5H6wJLEunEBX7vEASBPx3yv20ZamCbN6gi9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 22:45:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH] rev-parse: have --parseopt callers exit 0 on --help
In-Reply-To: <20260318012214.GC720335@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 17 Mar 2026 21:22:14 -0400")
References: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
	<20260316220742.1286157-1-sandals@crustytoothpaste.net>
	<xmqqcy13mgdk.fsf@gitster.g>
	<ablCBkmOdoourCnO@fruit.crustytoothpaste.net>
	<20260317145543.GA1828@coredump.intra.peff.net>
	<xmqqv7eul71y.fsf@gitster.g>
	<20260317184441.GA574291@coredump.intra.peff.net>
	<abnwxmoOw-ZLT858@fruit.crustytoothpaste.net>
	<20260318012214.GC720335@coredump.intra.peff.net>
Date: Tue, 17 Mar 2026 19:45:44 -0700
Message-ID: <xmqqikatj1nr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Mar 18, 2026 at 12:24:38AM +0000, brian m. carlson wrote:
>
>> None of these seem like they're likely to care about the exit status and
>> I suspect that if they do, they are probably using `|| true` to ignore
>> the unexpected 129 exit code.
>
> Yeah, I'd venture to say that moving from 129 to 0 would be a strict
> improvement for the cases you outlined.
>
>> So I agree that there's unlikely to be any sort of backward
>> compatibility issues.  If the consensus is that this is shipped only in
>> 3.0, then we can do that, but I think many people are not going to care
>> and those that do will welcome the change, so I'd just rather treat it
>> as a bug that we fix.
>
> Nah, I think everything I have seen points to treating this as a simple
> improvement / fix that we can do in the regular way.

I 100% agree.  The message I earlier wrote (which contained the
mention of Git 3.0) lacked "even" before an "if".


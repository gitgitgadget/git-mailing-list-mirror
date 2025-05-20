Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914618BBAE
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755874; cv=none; b=m7wSYQv+kWgWemVZikqgn0OUbWR+XyXoYp/gzBMyjg5rsBfUsczD/GeaqN4QsnLvUs7Zq6bmaZjOt+WV0yKMVXL4CdZvEXfIcY8GIY1sEilyadwmin7VKwDnRYGYjWTUnojDlCFTGPzEu1O+lnwPDgif1KYCrWAwZRVQ8Rm0swI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755874; c=relaxed/simple;
	bh=yOizMX7G40zSr67598Rc/qmuR2eVy/UzshVcTrBOmwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DSTaDxEUVVwicily0vj3pEqFC7JRjn2wiJe1a/CWacpDwTJRx6eGlGMqfhvt8K68WXE1xrvDfALo1hFwiNvr1w99W3pqkudWDJ234ilWcuwlufjb4p/DRE27ViomdcARgbP5YQaMgp+4B3ChFv9bZUN2k5z6y1QOz3kakjqGTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cFoJPBGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEoUsVT0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFoJPBGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEoUsVT0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 532791380400;
	Tue, 20 May 2025 11:44:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 May 2025 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747755870; x=1747842270; bh=fakCLIJ1Ox
	yorwq2Wynkkrncq8Pacjsb322ruuSVWU0=; b=cFoJPBGrlmzuBu5/VCcl2nfviR
	20UI4qA6fVH8Hj1qsw6iizjB5sJ7+SGi6YOyGYzXEi21dChnipcl4z7rTbI9hQu9
	S3XUKWPOuyBlx5tMVRT7yx282uFzD/tyF3lE8WHMp7iFwZ8cJiOxjEiK8gQMqTh1
	AFXsDKjTu38q7JWYugmBxcbarLbY3MJHm+iZJZ9mri5uui20j0/t0lzCErwDzr2C
	4piBJSCw0OdplGWtc6dObYAYg1J6TgJeMMN+mT17NZ97TNfmDOgQ5lYG7vzl2VY6
	DWigFBtVonsUfYy6UQiP6aZyJHslVYHDkUYO5lP7/WPOISLHn86fenPyV5ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747755870; x=1747842270; bh=fakCLIJ1Oxyorwq2Wynkkrncq8Pacjsb322
	ruuSVWU0=; b=dEoUsVT08ZnIuGU065EqHCPo28nmAv5x+4MZVS/4O9DF7H0jyLK
	4TxSUjRJRibvVdiMztnGS+u3MrKeXj8vqroqyzT7kVg/M7bYdJt3FdGCjczz1NGo
	W4N17IiEIr1sbEIHaMYV2bAOOEFa/pkP765c0ya89HW1UWUvGDtTP+0oOXWj8lHq
	JISjjcTXNlLp0NEdcAzQwecnH+UKzZdyWFTurPQlahj3wWS/Li100lg5zRtMAc1Q
	6OPlZRiBnLHad7N9wATpWOsOG5VB5OS3YyJ0th6d9o4qetSlQdsgQWb7yaAWP+1R
	mG75vE2N6a28eDh8mcbgkm9z+yUG+l/u3qg==
X-ME-Sender: <xms:XaMsaPWgSmNlyagVWq3VD5rl7U-CcrlqidC97jaRkGzHhE0n5MmBCA>
    <xme:XaMsaHnCNHP1eYxMp-7O2xbYIQoKU1UT8yfidEhKW_bAIM3ZuZXAs4B5Gkuo6xLAs
    HZ9YxRuGm8sISEA7A>
X-ME-Received: <xmr:XaMsaLbbG6HrtIAr4mz_HEcI6V8peMRpWgEmSlkwOzh7Q9UE8sU_rIhhZRTJ6LIT9DNkCBU-87MElIfZfkkwmL6yAjcShqGHswnfsRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeitdculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgf
    gggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgih
    htshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedv
    ffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmrghtthhtsggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepiigrihhhrghnsehunh
    hrvggrlhgrshhirgdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XaMsaKV87UQH012CSPp6PPeQDEtIkTu7dRAM73CLCqDjByjDiojbLQ>
    <xmx:XaMsaJkUevGJpayMEwxP-7iaJEM1YyFcimDf393vsy7hYlg7YF4UXw>
    <xmx:XaMsaHfXbquT_4J2FhydbbvlEML63wjyV01tvjUbMAKDO6ZL719DVA>
    <xmx:XaMsaDE5GNopPEE8eTaioUp2nBmjplud4lok0WpG77Wao1EhqNRgrw>
    <xmx:XqMsaB83JMo5WVR_luaec6aDAHg8z99aLiP-S6zMJ71ajfm2V_dsZTV5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 11:44:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Muhammad Nuzaihan
 <zaihan@unrealasia.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Small patch to add support for MPTCP on Linux
In-Reply-To: <7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org> (Matthieu
	Baerts's message of "Tue, 20 May 2025 12:54:41 +0200")
References: <JH8DWS.72DKHPTI873H3@unrealasia.net>
	<aCeg_wjLCf0Sz_7X@tapette.crustytoothpaste.net>
	<BP9EWS.WTYEEEQZEN2U1@unrealasia.net>
	<aChhxRx7sMD47N_s@tapette.crustytoothpaste.net>
	<4YPEWS.J5JRNETKLXF1@unrealasia.net>
	<a76dda61-f60c-4221-83db-5e165a2478b1@gmail.com>
	<xmqqo6vokvpv.fsf@gitster.g>
	<7b3b8efa-4cc1-4547-b66a-c469626eac46@kernel.org>
Date: Tue, 20 May 2025 08:44:27 -0700
Message-ID: <xmqqfrgzjnhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthieu Baerts <matttbe@kernel.org> writes:

> @Junio: Good point! This RFC 6897 was a bit optimistic I think. To get
> MPTCP in the upstream Linux kernel, we had to make it opt-in, and the
> modifications we suggested couldn't impact "plain" TCP performances (or
> any other sockets).

"Couldn't impact" meaning that unconditionally passing IPPROTO_MPTCP,
even when MPTCP is not available, would not hurt at all and falls
back on using regular TCP?

I am assuming that that is not what you meant.  Otherwise, you would
not be calling RFC 6897 optimistic, and either the kernel or libc
layer would be tweaking the socket() call "to make the right thing
happen transparently" for everybody, and there wouldn't be any need
for this conversation to happen here.

So I am assuming that at least for now, the choice to use or not use
MPTCP needs to be made somehow.  Leaving it at the application
level, by the way, does not sound like a winning strategy, but
anyway, I think the reason why the platform folks do not take
responsibility and make it up to the application is because MPTCP
may not always be better than TCP; it may boost throughput by
utilizing multiple links but may hurt latency, for example?

What are the criteria the end-user may want to use to decide its
use, then?  If interacting with a specific remote repository over
MCTCP proves better, would the user safely be able to say "I'll
always use MCTCP when talking to that repository"?  Would it be per
host (i.e. if one repository on a host is better with MCTCP, would
all other repositories on the same host better off using MCTCP)?

What I am getting at is that the choice between IPPROTO_TCP and
_MPTCP may not be "If Git is compiled with MPTCP support, always use
MPTCP", so we need to see where the configuration knob for end-users
should be.

Thanks.

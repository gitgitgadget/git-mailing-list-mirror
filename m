Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D977E0E8
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759977427; cv=none; b=BhCRhu/KxFHmMTtLK4CcvOHwTppwwUQ2DKkh8iIkiYqIMx0umYQXMtEOBNouFChrD+kY5K9k+XzGNdNY08D4vgb8c0tMGuLXTxbJ+d6S1mKQ5PWeCFk7aovWe/wxazbUdrmYWKMvvZqX6T1qGSdyO7HSdHmAgohoPKWrOhDKmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759977427; c=relaxed/simple;
	bh=mhCZWZegOQPr/fMbdObMBd/yx5rsCVZcRauL7v/xcNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BupKx4iS+7oTgTcnEiuulQPjiFjHNOMmdr8PIDRAwT7a7P8fjTa0cV4CP5KqyoCwsnWU8OIQlvIav25dV3pDHl9PRnRVHwXwXQDEYK9G+8jINk+AeJu3OsZxU3NrM5RgYA5ilLsb0GQNyEhKfax19lSgmVvqoJUrSy6A4DrbSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SLG0LVht; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzweW2e1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SLG0LVht";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzweW2e1"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 603B9EC0176;
	Wed,  8 Oct 2025 22:37:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Oct 2025 22:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759977424;
	 x=1760063824; bh=4ioI67u4fXH4DP//tMj+7obyL8tLSWvYmhGDJgWKPBs=; b=
	SLG0LVhtliJvQXUW0ZhJibErumnznF/bEtC9S8TifL2JIz68A+mOzbrN9l08EZ7X
	W3GsTAK+em2TP8+8HJZLso8vWwqpvPwnHW9oj+kYez9AOF7UA8737ms9yUba1vGW
	uJHrbcIUbKOOfUjdCIaGhtTNVkcgc6SWUutA4ExJjZjEKSTCTBGDL1/jAgF43GOs
	xfFvazKonuzIFYg+PSZhK7ARfHb1GoFlJYXFgHUT+hnylg/fG6MOeuS+kBx+6oLL
	V/w44Dwnqu1xcx1SxveKvGBEa77Mmbg6C7E766pSbXaek+T8KNssx2rbgz0uySF6
	PmNYsbVZrcfYaVgxt4kPrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759977424; x=
	1760063824; bh=4ioI67u4fXH4DP//tMj+7obyL8tLSWvYmhGDJgWKPBs=; b=L
	zweW2e1W4LQg/+8CxARKDsmAVDJ6YpqARQO/qU9YsZxvS1Lm2SNojNGVA67t93OJ
	K01H7D80qGG4lLF+MQxM09Op0WbXqzyCd/ea4qVUaTXMyKw36Sx04s9lYKxhrNQW
	rrQNaIykrJyx6IrJo06TgO52Eoh1KwYBnGs8+3gnXQjc6Vqp2IV2jxeCAqDjcejc
	vEm39+OXBpGIuG/n6WWtMR3MsYuzLApLzpYebw00ZiMoSQsTfG9BZxdVJUGPDCYa
	di52Rwn2kTn5nPt8SsBPuni27WdoBat6/e2Ty/KP23LBIc/vmAYFbZnZvF9tlcWX
	9MsWlei/4G1fa/i2alrhw==
X-ME-Sender: <xms:zx_naIk2odCP_GxTjUlr5OGtzoHVeJDQ1T2ZSCmJZbx9TMm5uh8gug>
    <xme:zx_naEY1uzekxE6OY0k7KRNRCQvOgpYyYgVIEVRD2OTrw7gAxbZ_Iwmuuha2iGScI
    XC9NfMmw4G8V-WmA2yRgQdHyWDHwwx8lQuq19ZWa4QVYagT_GHalAQ>
X-ME-Received: <xmr:zx_naLHLwDBvuiWXOrcnvBhtM_gDsJYWqPtzk3rKXStyNPmVpDpJCa-PaIk1-eWPoXC5vtNyHjGqpvb3EuRzWXVpISfVsbM_sW_ktdscBOgbi99hdb9W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpefvohguugcu
    kghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeigfeggeelvdeiteeggeeihfffjeekleelfeegiefgffefveefgeejkeeffeefgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiise
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptgholhhlihhnrdhfuhhnkhdusehgmhgrihhlrdgtohhmpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggv
X-ME-Proxy: <xmx:zx_naLbBuG7Xdl_FkFEZcvVaF424Pvb3KCcRLWV2AxKmr4e0PaptIQ>
    <xmx:zx_naHzWmeaylefZUSn1kZdy6xIteUuTSDEM8ASD1GvJq7cSGvRWlg>
    <xmx:zx_naFQyhoE7lW-ylrFDJOxYhQ0LYQHNxDbOIOdI5OYCUomxiD4oPw>
    <xmx:zx_naMJOi4jlqBpWEv-n2mcSO_aDwdD57Z_2iiMm9BHud8EXXgUF8A>
    <xmx:0B_naFzj7vEQBOCJLstySQAWqzUrKXboqPv-o1DV4S6Hx3GR2Qx8E4hC>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 22:37:03 -0400 (EDT)
Date: Wed, 8 Oct 2025 22:37:02 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/5] lib-gpg: allow tests with the GPGSM prereq first
Message-ID: <aOcfzgxOwGemReNm@teonanacatl.net>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251007122958.1089680-3-christian.couder@gmail.com>
 <aOYPTKG9t4ZB_Mbi@pks.im>
 <CAP8UFD2VRfZuaycCdWt4kpVpRv_UhNHdzqJ2vL8uyKJusUttnA@mail.gmail.com>
 <871pncdfrw.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pncdfrw.fsf@gmail.com>

Collin Funk wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>>> Okay. I wonder why we even have to create the directory manually. We
>>> don't do it in the GPGSM prereq either, as gpgsm seems to handle this
>>> for us.
>>
>> Yeah, the GPGSSH prereq does `mkdir -p "$GNUPGHOME"`, but not the GPGSM prereq.
>>
>>> Doesn't `gpg --homedir ... --import` create the home directory
>>> in a similar way?
>>
>> I am not sure. It might depend on the gpg version. Or maybe gpgsm
>>  does it but not gpg. I will check.
> 
> If $GNUPGHOME or --homedir is the default (usually ~/.gnupg) gets
> created by 'gpg' and 'gpgsm':
> 
>     $ ls ~/.gnupg
>     ls: cannot access '/root/.gnupg': No such file or directory
>     $ gpgsm
>     gpgsm: directory '/root/.gnupg' created
>     gpgsm: invalid command (there is no implicit command)
>     $ rm -rf ~/.gnupg && gpg
>     gpg: directory '/root/.gnupg' created
>     [...]
> 
> If it is not the default then it will not be created:
> 
>     $ GNUPGHOME=$HOME/test gpgsm
>     gpgsm: keyblock resource '/root/test/pubring.kbx': No such file or directory
>     $ GNUPGHOME=$HOME/test gpg
>     gpg: keyblock resource '/root/test/pubring.kbx': No such file or directory
> 
> Collin
> 

I sent a series long ago to fix this issue¹, but it wasn't
picked up.

Fixing the issue exposes broken tests which use the gpg2
prereq.  That breakage turns up in our CI and other build
environments, like Fedora's, but I was never able to
reliably trigger it locally and track down what was broken
about those test.

I believe I asked about it again a few months later and it
did not gain any attention.

I simply apply the patches locally and then disable those
tests -- tests which don't run reliably are not worth
running IMO. :)

¹ <20240703153738.916469-1-tmz@pobox.com>

-- 
Todd

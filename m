Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A125783C
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571157; cv=none; b=Nz62+1TBTnUJvlak9519AEMPIMtdQ4pN2Usq2FTwDTwPe2TM+uK+67UkgBY7y/k0trkKjC0glqrrN1ZBstContfLKMGdzrM69rpvCBvxUBVPsMdpelfPSYn4p3o+cyvj2ifwKunINOUBf/X73eJqRlZWwxTysE9JaMUQogEdSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571157; c=relaxed/simple;
	bh=lvHSJ07axh3QbfZyVFGIWUwNzoBVDMAsCVKRzikUwhk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NXjy/Wgb3BCS3hb/2dD1RSiH33e3Z8Oz7gMXQjXHKnzW4uvnY6ztu6l3TEluYy14mQIXy5ENxyoMxe0Hig6jzSD4RUxUjUEaewGV6Woq2q65eptR1B4855EwtTGnWqZuOF3bPwhkHxrOzci6asWz+svCvrjTjIUQLy6RnuhH6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=K/KWzCM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hU45m5Cj; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="K/KWzCM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hU45m5Cj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C0C07A008F;
	Sun,  8 Feb 2026 12:19:15 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 08 Feb 2026 12:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770571155;
	 x=1770657555; bh=Q1yT/mNl0G17tF/FroHxK3U3tICoPU9Vmh5u6n5X5qo=; b=
	K/KWzCM6J9/YJb5ELgiMPpV7clkHn04Z4+Ir6NCVFXWwbZX6bplYzewO1Zb//dDP
	G6mWNDcoU5djLstuQJjiENKA4NL5bPW2jUwR31YazJickwHjN58bwO9cs99bPOtT
	TOsIPbe269w59GRLzkhKaRxeaSN+DWARYELDHmVhWSwuStNykf1BkSx7YFCngXMP
	oPt80vUv881ZVpncqGAGcsexJ13dGPGHBcxTSCKXPN8Rh9y3kH/OQ6NBXSWc2I+X
	kNi0Ado5JJWIm8aKcoe8by19YNY8XuxO6/h9sJmkIQMhVUBKTx7OxPybL/9pR56l
	4ozoPYiav4uICMcYWPhB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770571155; x=
	1770657555; bh=Q1yT/mNl0G17tF/FroHxK3U3tICoPU9Vmh5u6n5X5qo=; b=h
	U45m5Cjk+n+N7cGQqYEJNcQzTeGGCieJnrC5WdoILcAz0nZpka/5SA+wx1ZZdznB
	WJ6nRRr7YcNEJXCfT4ABWyCzOGbH8fIlGvHdUfxNasI4tanFaiZtU6ZNUol5d5Wp
	1eURjJtXRPayIU3K1gNumZQ+SaFyi1+0tObqoynKPZUmUAkxsDiB5QRZWCJWZXGU
	to3e5Y4qvogM7r8JEZFmJHOVIAKV5XVDFMj5wTrnpQ6bv8iEFJRzVjIsb057N+o6
	5jO9uKOxw1eGKCgFM4iswuFwCXdd77+r3S2alNMXs+wMI00zTOqIspKfT3gtECy7
	8c7mVug6XQHEz3Wrk/Plg==
X-ME-Sender: <xms:ksWIaW6sxi81UpbTAwo57lV8bLwF6sRQEN7x5Z7SHNz1YAXtUya4buQ>
    <xme:ksWIaasSeQvNP8x04n0R9XBCc9Dl_ttvlTGQKtK1i0aFuVq_D19jVrrWMxplLtzjo
    41XFpygAvwroYlTkp5QAnpM6dJcHqZFN_Y4vvkMxwv51UzQhvxp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleegheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrihhlsegsvgihvghrmhgrthhthhhirghsrdguvgdprhgtphhtthhopehjuhgugh
    gvrdhprggtkhhhrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhhvghushdr
    thgrvhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopegtrghlvghsthihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepsh
    hurhehrhesshhurhehrhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ksWIafOlfv9eQJB0KnxbihGLdNLFU6odfvD9lxEvq2zgdWnZb6nlZQ>
    <xmx:ksWIaT8Y8rwbPD5rbFqhr1H7Vn4dLDuHJrWpxtanNkiaLgCMO4iC1A>
    <xmx:ksWIaU57Lxlqkl9YCeDgR1FNKd1N0_hKsmmQWbqrEeKfbu87PcLQhA>
    <xmx:ksWIaR6Sn5JL_ioOTY9yp6DRk1MQOnR6UWtbtWLAkxKTchUupU_Ohg>
    <xmx:k8WIaelR1GpwVkjUInjTAtoJZlFbUla3N-7R-WTbpCi7mJatUs0OWMku>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 901121EA006C; Sun,  8 Feb 2026 12:19:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Sun, 08 Feb 2026 18:18:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>
Message-Id: <42e5ce76-7a51-452b-a66a-85ee57b00181@app.fastmail.com>
In-Reply-To: <xmqqjywo9fpc.fsf@gitster.g>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz> <xmqqjywo9fpc.fsf@gitster.g>
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026, at 02:39, Junio C Hamano wrote:
>>[snip]
>> ---
>>
>> Notes (series):
>>     There might be other things to do here. Mention it in gitfaq(5)?
>>
>>     =C2=A7 Trailers
>>
>>     =E2=80=A2 Reported-by: Matthias Beyer <mail@beyermatthias.de>
>>       =E2=80=A2 From this thread
>>     Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>>       =E2=80=A2 From https://lore.kernel.org/git/ca13705ae4817ffba16f=
97530637411b59c9eb19.camel@scientia.org/T/#u
>>     Reported-by: Matheus Tavares <matheus.bernardino@usp.br>
>>       =E2=80=A2 From https://lore.kernel.org/git/d0b577825124ac684ab3=
04d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/#t
>>     Reported-by: Chris Packham <judge.packham@gmail.com>
>>       =E2=80=A2 From https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJ=
DxAs9u=3DFGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
>>
>>     (These were all linked in https://lore.kernel.org/git/20260206090=
358.GA2761602@coredump.intra.peff.net/ )
>>
>>     Helped-by: Jakob Haufe <sur5r@sur5r.net>
>>       =E2=80=A2 For the part about patch(1): https://lore.kernel.org/=
git/f6e4cdb4-ff82-4853-aca5-0c152f287286@app.fastmail.com/T/#mc389dbd2ae=
02a007cbe57cd16ca4790ecc5a84f7
>
> The space after three-dash line is to give additional information to
> help readers, but the above does not qualify as one.

It=E2=80=99s not for you. It=E2=80=99s for the people that got CCd to in=
form them of the
years-ago context where they reported this and why they are mentioned by
name in the email.

I do go overboard with the writing though sometimes.

>[snip]

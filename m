Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE43016E2
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960473; cv=none; b=dBag9Cp7y160KGWXkR+DtQT0aVRny5ZldYkEyIloSAVkcJPUTaV+5O4abYLFMH5FJPQZiMlibsHbqrCjvQrrSqPYysGazbNvPRV4tSEBMxtXZjW4Udf/9HXTe0lU5AQQ8nwn4GKAStHqbWcwibtLijXE6HXBNKwgMKM7+4XDSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960473; c=relaxed/simple;
	bh=KKraAo1OsdS2e2bVEk6FrbDSTa8Op/8ASMnpblb9ZsM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f5O399XxpJsA1EO6dSiS5lUNGk+zdgCrbFJsIykyvh9Ec9g7Kss0siC2IqoXJuj7kV6ZYletcPLdpQAcG/3ORC+qnH4I/wjFwCA7m8nPlvJePRy5bRSwjHvid8XONNz3l1SdgscHKjUHAFxbyGDPr9qHvuXeSNSGzwilsJmOL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=krXHEkyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlbrnhxZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="krXHEkyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlbrnhxZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 052761400053;
	Tue, 24 Feb 2026 14:14:31 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 14:14:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771960471;
	 x=1772046871; bh=01iPaIpwPDNeQ+SjuG4SuUX1rplldMvPJFUi8o17Buo=; b=
	krXHEkyIVeVn1tkMU4qymYZqKcPBSwbi87Np1qlffl98yjcYK5trtBzBMJW4Of1c
	FHa7OR5SqT5FpKt/YAEos40InNpHZAlxFOB33CsK7adkdTmhbL7qf0isW7dvBhRQ
	NxrnOSYK8Eq04HpU7B2r7XcRD9REmyh1bavyf0I3d3GV5xOvthQEbWjQwnLT6r98
	KTcXyJV3bsStOyQjg5QYgGo+NWX1nKX9XROs3t9hdR8bZBqcfrDCaC01lCyFjXXG
	v4MPfb6TcCeB+yL9kUx1msVccbTdAUnO3LIKd5yTG+TfawyKCmm6CYJJWTbszT0E
	QfPWeaSg98qVyhQszO3KaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771960471; x=
	1772046871; bh=01iPaIpwPDNeQ+SjuG4SuUX1rplldMvPJFUi8o17Buo=; b=M
	lbrnhxZR1YQuAhX1mkX1kvJtHbmkYgt6aZaI5+Gmnxut7s9wytckZb1UnBA55Oau
	QdbBb7/d9KM5lY/5ZH0PtAGBTCpUp0coY4pCh/B+TwT6T4OF6mn8/PYJHq2GU2lC
	ZDuulVWdq8EJJ3bmYR1yjsSiiVonLEIcpi9Q+fX5KJCZYvKcOiNCk+yuLRSWwKir
	/8r5x2O+q3WTmPpU9tdnQIgaEJspG1Ckw7kVqTi4CBs4tRIMsgX3ydj7vZazpdEK
	X633e3ytvl7/9ZJvOPUOoNZ0Ql6QLvDIBYszEWO1SiFuent7FSVGzvvuu8+zQowV
	7oO/QoDKi4yCCG3KzrJ6g==
X-ME-Sender: <xms:lvidaaCzRrN0t5U1_7jKPniqMoX9p37YQP7aB8fZxAIWbCGFYeZwJdU>
    <xme:lvidafUOiw2eRii-r-NqMz7-XC0B7mAcRCixKjLkG0aMrfzYVD35CueGRIOx15JM6
    3-MpNgKsHEmV83FnU4w9hHx4td1rVAXunkZWkrrrZBMytnoH8QtBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lvidaVt8ZVAbGLvqNjZ1JaTg9qDK0nrWbWPmBWqdn7a_znrKuMELuA>
    <xmx:lvidaXwkwdr2i0AlCK6Zzkku4O89OGqLWRnjdyd3S43jPqiB6oLQjw>
    <xmx:lvidaQDAyTt7G6Oe5NqK_p6SpGizPbsBGBwouBuHUCTB12dvM1JOKA>
    <xmx:lvidadfelkZEqx4atEMKRY8bVF8APBCTDA3JNoI-koAgYynJzqsMrg>
    <xmx:l_idaQwHH7cX287J7CphmEYbtl2OM8kyXhc2EtFntTY41X4yql28iaOT>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7D361EA006B; Tue, 24 Feb 2026 14:14:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEXdV5rI5xcc
Date: Tue, 24 Feb 2026 20:14:09 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Jonatan Holmgren" <jonatan@jontes.page>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "D . Ben Knoble" <benknoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <1178ac42-0d8a-430a-9ca2-a170e4e6932e@app.fastmail.com>
In-Reply-To: <xmqqwm02ez3c.fsf@gitster.g>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260224171245.458377-1-jonatan@jontes.page>
 <20260224171245.458377-2-jonatan@jontes.page> <xmqqwm02ez3c.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: fix list continuation in alias subsection example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 24, 2026, at 20:11, Junio C Hamano wrote:
> Jonatan Holmgren <jonatan@jontes.page> writes:
>
>> The example showing the equivalence between alias.last and
>> alias.last.command was missing the list continuation marks (+
>> between the shell session block and the following prose, leaving
>> the paragraph detached from the list item in the rendered output.
>>
>> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
>> ---
>>  Documentation/config/alias.adoc | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> This seems to address the same issue as 0ed2275f (doc: config: fix
> list continuation in alias section, 2026-02-23).  Should we treat
> this one as a replacement of that one?

Yeah I think so.

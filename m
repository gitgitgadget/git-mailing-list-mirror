Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087EE202961
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985461; cv=none; b=XdEr++pb1LSygn735p1VRb7IBwEY9sO4oqVxJkKeU2wAe5wwoe12j4ERXj+rw1uKdFTYvx5W6YC9WvDfyjVlQ3WsSCgXU0G01jJvSVrxZX2w20xRSsayvHUranDXbC3PoZdVJsFsFrtmKcesXpYki0Bsnu+BXdiJkexIPQm99cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985461; c=relaxed/simple;
	bh=Gtcq3zkIyA2EcTDX1nJgzbltAAAjeMyYxhNffA5ahQk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jqcKoxPYs3bDyIXZWdrnZ0uxhr08EfH0IS1XbvC7/eFdU3En8gkbgav7R2uVFzLq8UdiPo9yaq7Faq8oetsevmvHKL2luhOZpdZ8QnXaYyW/STXPNqKzyiu/yXXJsiYVkxGtETlTIoFj8OAPItgVDcExSrm2zjKQ2FYU2lLX/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HMrnnjLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMzF/aGC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HMrnnjLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMzF/aGC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF3637A0152;
	Mon, 20 Oct 2025 14:37:37 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 14:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760985457;
	 x=1761071857; bh=WVfS/lTd6sGEWhljE5aSYV7iHxfOw9aSXa7BS1NCerE=; b=
	HMrnnjLzbcyBYG/B1Yz6YHYoQwdrttPeAbPgKl+6tB50mXR/E9OhJqyUxKMx3V6U
	oySMEWdRfPpEFI61TIFwprgr+wRvWQjPmy9XzXLLR6FpZHkD/ghNRybxPuQGw+zn
	/azBF50866uBd8C4DtqPC0MgrYT7prwhH3jrpFhP2gDcyB/C1SCiHig6QS3PUre8
	88Fj1QOZ+qf9PJ8saOU1NFpwPIkmzM83LTVAaqbDb4ApMBirhMhXqQx3YtaUzN5Z
	2QJIrZ5BnWDUVLfBa6abYdpOYEd+GU88PJqJJoXxeiiVdAorguDn3Ot4vSg6LPUa
	1/NnLLe6vww+2m0xDSCA2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760985457; x=
	1761071857; bh=WVfS/lTd6sGEWhljE5aSYV7iHxfOw9aSXa7BS1NCerE=; b=r
	MzF/aGCnVi4Rx1dE+DABlHf63yVE1mpyVbzWRhzldy586TZc+Nq8EONih3YdpATL
	GZTuqDHKLSZj5ef79aEyuePJvkx/jcpgfd5tV+CRTDV9V2XVtbP7onA2UDKub+M/
	WMRY5uDENYIepoeldacybjSDj219Ug1STItfDDBteCKx6AzbV/ILMEwghhpVbFYg
	pFI9rw4tdYPaQM2Wod92D/Ktpgmvd1ys4/TYPyy7WTMytug8dBGdvNAreUGGU+nd
	SAPOSkZ7TAuOlyVO/HjtEp/t2TwzOCyCgFxKhdYrQifJA7KUCwkZM8eZtPAJdRtB
	UGEyGCNA6BhN5AdfzAifQ==
X-ME-Sender: <xms:cYH2aOiQFUCha1VXtHplnDB6DBfr1dIZukBbm2L-EmAXs5wogfHjhyE>
    <xme:cYH2aJ32zUqF89iRtqrRu4oAcqF579pEBOUahOksXBbhZBnmPLnnIWU8wUKwHnVbI
    vWbO-Hvpd9DXtifAM5j9oZIVTtpi-5YL4eyrZcWaLU8t7ojmUVT_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhiugelkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cYH2aHmvmGwQbNqnmvHZHuxmHtxmjGsjIRbBROGD1VLLDr6VXmCvHg>
    <xmx:cYH2aMWW1qEOPx_XhzNCP-HzLu_0M6KD9MpHDOJQ-0XBQFs_eVWz1g>
    <xmx:cYH2aNvshLy6cPMUuIAHGuZ8-fvLh_YRUKCDY_mQHjhqjS8pUjzCDQ>
    <xmx:cYH2aPb0RflTmiqrEfH8G7Tf7G6s5xlg4B7jl3dPB-BOBtEBxhlmfA>
    <xmx:cYH2aD7CypaaqMdA85Le1cT9q7Ep6wuRW1TyqguNzZQwQBXnk1jWWoRH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4B1C71EA0062; Mon, 20 Oct 2025 14:37:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATeKP54mJ-4N
Date: Mon, 20 Oct 2025 20:37:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Olamide Caleb Bello" <belkid98@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Usman Akinyemi" <usmanakinyemi202@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>
Message-Id: <1cdc170b-569d-4874-b1d8-dd645c0545b0@app.fastmail.com>
In-Reply-To: 
 <CAD=f0L_4O9oLxUToLn3QwDopFCnYAKQwBPOXwb+xuPkqXh=p1A@mail.gmail.com>
References: <cover.1760869186.git.belkid98@gmail.com>
 <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
 <4bd36d2e-7629-41bf-9731-493cf3bd151a@app.fastmail.com>
 <CAD=f0L_4O9oLxUToLn3QwDopFCnYAKQwBPOXwb+xuPkqXh=p1A@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*() with
 string_list_split*()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, Oct 20, 2025, at 20:25, Bello Olamide wrote:
> On Mon, 20 Oct 2025 at 17:46, Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>> Signoff should go at the end of the commit message.  You=E2=80=99re s=
aying that
>> you are signing off on the changes as well as what was written in the
>> commit message before that line.  If I later add mine:
>>
>>     Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>>     Signed-off-by: ME
>>
>> I would be saying that I am signing off on the changes as well as the
>> previous lines in the commit message, including that line that you
>> wrote.
>
> Please just to make sure I get you correctly, you are saying the Signo=
ff
> should be the last thing in the commit message.
>
> Like I should put it below the other tags so that if you also want to =
add yours,
> It can easily go below mine and it would mean you are signing off on t=
he
> changes including my own Signoff?
>
>>
>> > Reported-by: Junio Hamano <gitster@pobox.com>
>> > Helped-by: Christian Couder <christian.couder@gmail.com>
>> > Helped-by: Junio Hamano <gitster@pobox.com>
>        It should go below here instead?

Yes, that is my understanding. :)

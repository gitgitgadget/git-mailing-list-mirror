Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D731771E
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678720; cv=none; b=NhVTglWG0QkIRqSLS65hgKBybWGU4Ga7c1wu0rh4ycuVUqLL+rFfenZNj67JTpG+ni2woY/LWMLOTSLDfVuTm5yHBjVjCuvi/zPKelZOIcs66oBIzrFV+eJ00T1Gp8ol9VCVqV5sM2tYcyfFmer4DTg4ZZsLA2DfxdLiOyiJUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678720; c=relaxed/simple;
	bh=PQlyV/yTdURS/qeTu5S7fZ6H51J293mEX3HNzuliejY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bLbhY5B1k7oi5mZKtp5iDrq3E/D7/Yfg6dcxqN1FvFp+EmZfog0OwPoqqK9iAT++wz+HUQ6Guwrxy1FY+NX4a9Fx1h4ZTGENFNkuK9/KyFgpg4kTp9Wn72sAvzmTkkft+GuwIwPKVsCJ6lac3w6oWBlrJmuM/tKSYc3s84tMDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WGzNMVrt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNg3lf0O; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WGzNMVrt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNg3lf0O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CEA05EC00A6;
	Mon,  9 Feb 2026 18:11:58 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 18:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770678718;
	 x=1770765118; bh=M+bKr2jsGcVUTLrv8zW1NZc+pUX+lrTWhAqyCF4Fiaw=; b=
	WGzNMVrtbMXZJzg0G8Ko6gd8JCDPnGPsYqH6osBW8KjB2xzGKSZbjkFeCRXl2Yqy
	Wcb/13YPB/WFW1yIBnMrpkqmm9LEAuAYsO1oQ+2KH17e5dHgzUQV0S2ZXoBu9gJ/
	i8uVaxlBHDUs9vVjb3Z7fSJWH+DiQR0Jh1HPKJhU3ReJo+8QzW8c+P5f1dvAOmFN
	CnHzSbWWClwQVs8ew0oT/WRqn/o58zV1YLgeoxHbDlWWiU4hdOKRShxUQhC8PH1U
	w3gUngnXFyNMs96JhjEzTHLwNp0o9R91GN2FeXTRxBo3Rr9DI+aJzcrblX5BvbT/
	VQ2P9wacLlz1BdZqlkJrag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770678718; x=
	1770765118; bh=M+bKr2jsGcVUTLrv8zW1NZc+pUX+lrTWhAqyCF4Fiaw=; b=p
	Ng3lf0OgHx15agTzzwZY0ZFZg0DH9vTdFIeOW94GtBWIz/z5LQiwlxBEjJ2m55F2
	cmFxDB+Vz2PfSmYUt3EIpd3gzaaecE7VVp+hN6BxjowuBmEALEma8ou20m+PPTVo
	7R31rl2PijQHIUo7OMwd/HOuNYTb033tYnipjEnjNvsobiodBpw4yE5eEgBx952d
	8ZeRi/4b0SSw7uZgWRySYM0QEKfGzu70ltYRgGeWlF/thMMZ1vGZXUOj+zGt3gBN
	DLzD/cRuF1Ku2fOn+mKApBQ11cGSeiRNVF/gJIN0q/IXlUf3j7pC51z0QDy2D7DG
	8FCWDZ87td1i25hU3ya6g==
X-ME-Sender: <xms:vmmKaY1A5Ai1fU_0-V3kXNfttH10fmKt8xJkGo2OQpTTxoSYFbvi8rk>
    <xme:vmmKad79uH48fCDsJE_QIeB0WccAVLdnUWqrGkXvChGnRT43ywJemMvipEvFMwdR2
    pUe5nni8_OlfqX5vHjG9rRpsRVrNQ6InpmlLnWG7-Sc46b2RpJ2Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgr
    shdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepjhhuughgvgdrphgrtghkhhgrmhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmrghthhgvuhhsrdhtrghvsgesghhmrghilhdrtghomhdprhgtphhtth
    hopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhgvshhthihosehstghivghnth
    hirgdrohhrghdprhgtphhtthhopehsuhhrhehrsehsuhhrhehrrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vmmKadHtLoHCp4tsAT0bpB1r_c5jy7iJCgCNSjs4gfnE3Nr7-H3ZZA>
    <xmx:vmmKaSy-8rarnGgV7yYhhYLjoTuM1SqrqT_jFicNx_uqpizXXuUPpQ>
    <xmx:vmmKaf18zT3tiaf_7DtKMXQTJ6A84nR0mm3xLu_IP-axIUI87-xfoA>
    <xmx:vmmKaaps0QXMWrI8Gy8U4yaX2FjDaXhdWFV6BNUpDAYyHGXZcpPgVg>
    <xmx:vmmKadd_ke46vwdkMoZCM_d7NsE-T56HHWkmlHPacYOGb80Vozyuvw-4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 362DA1EA006B; Mon,  9 Feb 2026 18:11:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2LExlyUAPtc
Date: Tue, 10 Feb 2026 00:11:00 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Matthias Beyer" <mail@beyermatthias.de>,
 "Christoph Anton Mitterer" <calestyo@scientia.org>,
 "Matheus Tavares" <matheus.tavb@gmail.com>,
 "Chris Packham" <judge.packham@gmail.com>, "Jakob Haufe" <sur5r@sur5r.net>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Message-Id: <80bbe45f-2c9e-465f-87aa-c7cb64175ccb@app.fastmail.com>
In-Reply-To: <xmqqikc534mk.fsf@gitster.g>
References: <format-patch_caveats.281@msgid.xyz>
 <V2_format-patch_caveats.34b@msgid.xyz> <xmqqikc534mk.fsf@gitster.g>
Subject: Re: [PATCH v2] doc: add caveat about roundtripping format-patch
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026, at 23:59, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/=
format-patch-caveats.adoc
>> new file mode 100644
>> index 00000000000..c666d709742
>> --- /dev/null
>> +++ b/Documentation/format-patch-caveats.adoc
>> @@ -0,0 +1,36 @@
>> +Patches produced by linkgit:git-format-patch[1] are inline. This mea=
ns
>> +that the output from that command can lead to a different commit mes=
sage
>> +when applied with linkgit:git-am[1]. It can also mean that the patch
>> +that is applied is not the same as the one that was generated, or th=
at
>> +the patch application fails outright.
>> +ifdef::git-am[]
>> +See the <<discussion,DISCUSSION>> section above for the syntactic ru=
les.
>> +endif::git-am[]
>
> It is news to me that adjective "inline" has such a meaning.

The original intent was to emphasize that the commit message and the
patch being in the same =E2=80=9Cstring=E2=80=9D means that there has to=
 be some
delimiter. And that can trip things up since there is no escaping.

But you=E2=80=99re right. This part can be dropped. It is already clear =
that we
are talking about delimiters that can occur in the commit message.

>
> Whenever I see somebody writes "X. This means Y", I try to see if it
> makes the result easier to understand to more people by just saying
> "Y" without mentioning X, and to me, this is such an occasion.  I'd
> rather see that sentence, plus "This means", taken away.

So write it like this:

    The output from git-patch-format(1) can lead to a different commit
    message ...

I=E2=80=99ll make that change.

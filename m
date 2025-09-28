Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D1202F65
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759087552; cv=none; b=X+iRZmUkUAiJTwTZ8LrzeTddJL9b5uN0KHS8hL9fyCh7/obdxFbfJGqKpRb7f9aP++qHdqtQ0hOtPJu3uHkcAKec/p2FsMyizLtIxamDg8wyE+OKPdthOEE7MU6eD6Aq/7YAt+EcsuGry2cx9E9xRuzgjTkliqN1sAmewp4O3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759087552; c=relaxed/simple;
	bh=YLP/IzHqWM22r6lkWjxRhbB7HOgwjmXkXsayuEM/9WU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HbK7IDDOacVfq/zTPOPgjDqVmQPLonULhCYgd6V8f6qEzUQyOIw0ZbfC+LBvz/o2KKmvBrJkoFyiUCv25tZMiEBw27iSfeTwq6BsxdaVTVd3FIxSS+/6jhg+UoLnhJGYmDZVGiz49vi9BkcmF0whcQbmXktlaUEmVVmH4NhfU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qkElOd70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LNeILpWE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qkElOd70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LNeILpWE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 36671EC0193;
	Sun, 28 Sep 2025 15:25:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 28 Sep 2025 15:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759087549;
	 x=1759173949; bh=aJRhOi+hsOOpHXhyH8I1qgKN7U4FfQrdElJ0YvfG++g=; b=
	qkElOd70grlhFnHLBmWYY4ExJUqrru/b8/NqyAaXCR9eIYMpbM6UNPT7ny6o2NGp
	pj9wrRTgVG3YuCFp7L9Ohz+K6FCpWw5GkDXFCOdLSQvtER7MpAtZ3r1zT93FyDdz
	fzQkqfWkTqg1ac7SlYf37OrqCFVTy/Fo2bZJFDudJNkbhhHoxeTQvArof1vClfpB
	FdOdai3LEH7frzUIlnEBd/1mPV8gxLy5V2VBo5LiE2iOlckdjMHHi1wUAX24yrjs
	HpEuRDIpjv+LxOgH3x+OtEbQMmpk0exnPqy9RfYoObZ8MmseDfF8p6ecncmUsXbS
	7iDYdHmjdDrdNecnaIOdug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759087549; x=
	1759173949; bh=aJRhOi+hsOOpHXhyH8I1qgKN7U4FfQrdElJ0YvfG++g=; b=L
	NeILpWEfhJDToLtoUrJJ9Rja8E4ARKxyVLrCS4SIBH/jZhiqU/3GRDYHTCjS1jIF
	1GM65yw8oub2mT0cRQjbAuZGx5PXka0wWwQTeMlHHjU+bqgY5tYOg2eqMln4POd3
	hS+67OJfIdz8U5M7K0MBtpY+XBzPvXKMYF9zmCbkOcSCkiohRbQ/DoqKjWUZjnXf
	OnnfE4UgZ7Z3dYGeMxtTud+Eh0NtapJf6ww5WohpfxFKvyuulI3GgcSQBwoIa9Ct
	F/n0Z4BAf8BrLGO5/6UhxMimfO0zUDudSgUi2gX5+siASnCF5RJswtb8Rsf0PHMQ
	dGXY4JNaw3CYK4itcuxNQ==
X-ME-Sender: <xms:vIvZaATI4_9DaROEInqbfbVIzN53AkYXaypwxKplpFqoZeQbB7HIqlc>
    <xme:vIvZaImV7lCsyt7jhB0DLltmtT5MeoXMQ1FRyWuP8AL-AaPNI3DYPGDteaPysSXGp
    h9JPh5_PWc9oR6WyqO5S4TY_CGzftc2ySeBcFvvhRSVi_rfk5eT_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefg
    iefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:vIvZaC84gN0t3rnEfXPr9f6FtCRuaXECOJOj09WNYlLpJmQvmsiIHw>
    <xmx:vIvZaApvQDeElw5AaJf5OUXNnBBS8RcfXeFWKI0uhpnhe1vPU12Nkg>
    <xmx:vIvZaPnAMF1TkCgsD2Y283BDSt_ZlOLvqOUXiFMiverqu8jVHdI8aA>
    <xmx:vIvZaHLLRex8z-3CukfjEPlxAm2-kj82VrPppolFsmr6DghbVRmo6g>
    <xmx:vYvZaBUCEdBfNDZlaS0njKXI6L7xxv3d9Q-SfSyPPOGHFI4sr6U6dkYj>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D29CC1EA006B; Sun, 28 Sep 2025 15:25:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AahvWzfxGFoF
Date: Sun, 28 Sep 2025 21:25:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <b7ded038-fc91-41cc-b241-1ace6b46069c@app.fastmail.com>
In-Reply-To: <xmqq4ism7eh4.fsf@gitster.g>
References: <0520e8f9caf.1759067095.git.code@khaugsbakk.name>
 <xmqq4ism7eh4.fsf@gitster.g>
Subject: Re: [PATCH] doc: patch-id: fix accidental literal blocks
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025, at 18:01, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> The options here are apparently written with the assumption that you
>> can continue a block like e.g. a description list by maintaining the
>> same indentation level.  This is not the the case; you need to use li=
st
>> continuation (+) for the elements following the first paragraph if you
>> want to be guaranteed a predictable output
>>
>> This is kind of subtle since only the last paragraph of each option g=
ets
>> rendered in an unintended way, namely as literal blocks.  This is eas=
ier
>> to see in the HTML output since the man page output just has a slight=
ly
>> larger indentation on these paragraphs.
>
> Hmph, I've always thought that the practice breaks every paragraph
> except for the first one (which is the same as "only the last",
> only when you have exactly 2 paragraphs; when you have more than 2,
> it makes a difference).

I don=E2=80=99t understand why but `doc-diff` agrees that these last one=
s are
the only ones affected by this change.

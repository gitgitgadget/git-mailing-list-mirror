Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A534D387
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761855970; cv=none; b=JipOaT5GIW0UY/tS22KOucK5p1xAgkZTKzigjRtuydVjUMUv0qXvND1a4HMtPMHU/w9eB8cypJ04RGem26CdhSZLI/sZZ3aFH6TboEuZEnH5eMEvGNVnyGfDS6oxLkOTAS5crYHQhGrJxP28F7psKjHLrRIDqtoHV2M6xYLy6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761855970; c=relaxed/simple;
	bh=bzXZFnqsykQv+KOBx67Pybh6SrjsD58dTdkfPtR7ris=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YHA+4YcEmx5D0zb8UqbZC+5bQm8Rp0tCqYgWvCORNBOo2NnEMQV+YIvvzZBAARCNkBdl6iu0gadaDgE5fR+QsdXqKyp2a75mMl2PFwA5TGui/K5ck1WATIy8ZPFtvm4p06Pj9dXGFU9WJt5UdhNJdz8rYmkqV47+yZg7rBfaYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VHOn1sVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lm5SRq9A; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VHOn1sVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lm5SRq9A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9952FEC02B9;
	Thu, 30 Oct 2025 16:26:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 30 Oct 2025 16:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761855963;
	 x=1761942363; bh=l2c5UQAbbVMfiJLeVdrAZIrhvGts9xUXJBGtoFlJVYg=; b=
	VHOn1sVwAZvOBOsIR8lKc5wob2JjjQ5ZQJGYiYHDgM4fiTXhnMl+/m9pJtKzvKmM
	rmlaSFtcRPvFbATDRvCYZBkJEIml29R0AYieNNP+DnGT3KfULTSa3IaImkrn1lZl
	AgMcxhXbJPkrLpDiKYUiBddOC2KHfQN0qJppopIgrdORUyMxtEZqaerduFjmKtRR
	JH4Ykl21iJlDIbSWJHgkZwd/aIehfSWqvZMg0846q3nY99rpwX2fNuTdlZfXtGHt
	YZbllBKjvQnvpjvcUmoQ5Z/t5bd7Nz2S+Snn1Kt4nSPQ4mVwh31uWqSuwJRE/5/x
	S1oTxcerRoxD8TtBlK+20g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761855963; x=
	1761942363; bh=l2c5UQAbbVMfiJLeVdrAZIrhvGts9xUXJBGtoFlJVYg=; b=L
	m5SRq9ANzgE0Kr1Pp2duUdZKOnHiUqgb0Y4taIK4+5xCZktQ4QJHj4orfWowNRxV
	6KyybuK1yDCywxj8Yel9/B9OztcqA/evcLG0FIaPsBauL5WeyNiDJ33BBrREjefL
	e8I7LJlkpMzWAplbYwANTyCRDGn5ygMsRX0mgEXL5lzZfDZ8T7dF4aSHIXKqhP5L
	zKslnQ7hqzNzEApztyQp0pXPOd6JDObvD4hmGCoHqOoRRY6SwwlIhayYbyTcNvl9
	yCd+DjEsG1NzrLcl8HxqZcnED47giWprAjTQNEHGFIV4jEt4u/oVBuZz6n65aJRV
	WJJG/M4STphs0KnI02Jng==
X-ME-Sender: <xms:28kDaRi1lpuRSbQOu2z1twqfQtTgc0it0VyixxqYIR2QeHPs5I2SNtQ>
    <xme:28kDaQ1_jUMVcZw3ZOFAqZ3W59V4AsBXYI8t0U_diMtSWLhPVt-Ave1R2OyYXskRQ
    kczxZVxM2GJHz6Ktvoiwl4DMFe-rmXqQBme15uVEAfozJWPufs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeel
    uefgleetffejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:28kDaa__oJj5Bl1ZOeaCfMI_fNXKsXsb_SUzFSEn6WTzbih3--dKKA>
    <xmx:28kDaSebYgJXLLhkGHJdlfHuhJB26lnk1ty8x3ROWNZcwuWIavguXw>
    <xmx:28kDaTGVtt86chFDz4a4IFTLckoqM8hTKsvWOiVNzMUfRYrnXEVLKQ>
    <xmx:28kDaQcNhVw_5Bc6kqU_iyP5vpchK_3iaHK2h26aTWPzFwRe5fSonA>
    <xmx:28kDadcfP9mwZTVWmqMhAEGn9lq8LWtsvCLfm5HW7BdtdUMf1lBo53AR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4ADE61EA0066; Thu, 30 Oct 2025 16:26:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6deAsQV7uqg
Date: Thu, 30 Oct 2025 21:25:42 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: rsbecker <rsbecker@nexbridge.com>, git@vger.kernel.org
Message-Id: <3dad5cb9-976b-4e60-9e6e-05c12c7d9f2d@app.fastmail.com>
In-Reply-To: <xmqqecqk5g7r.fsf@gitster.g>
References: <xmqqo6psjq2n.fsf@gitster.g>
 <000d01dc4831$ff049500$fd0dbf00$@nexbridge.com>
 <729f9bbf-b75b-4161-b8aa-505ff906bb8a@app.fastmail.com>
 <xmqqecqk5g7r.fsf@gitster.g>
Subject: Re: [BUGS] Git v2.51.2 on NonStop
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 30, 2025, at 20:42, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Tue, Oct 28, 2025, at 18:40, rsbecker@nexbridge.com wrote:
>>>[snip]
>>
>> Would it make sense for maintenance releases to have a small release
>> candidate pre-release?  Both of these maintenance releases have had
>> issues.
>
> Well, that is usually called "the tip of 'master'".  Has NonStop
> been having issues with the tip of 'master'?  For how long?  Why
> haven't we heard about it at all?  After things are merged there
> (which requires them to be cooking in 'next'---oh, has NonStop been
> having issues with 'next'?  For how long?), only fixes are chosen
> and merged to 'maint' to be the next maintenance release.
> ...
> I doubt any pre-release on 'maint' has much value in that anybody who
> are not testing the tip of 'master' would not be testing it either.

You are probably 99.9% likely to be correct.

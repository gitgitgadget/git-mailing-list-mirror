Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532242F0661
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035024; cv=none; b=rQdbWxPE5OteVybd0geOejvfv5YjQIR6FKJlsHRWQgzKD+fr7TQHFqstGvnBRSJJpPHyrUMktq1Jw3BmQTd5DYwhbfP2Gpz+hRNwKSpki6uvPUEkCqUUvBzQdyO2TjDS2UCSBm0T5uYvIQ50pX5JPjbFJXktd4WpRzz+lkUHjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035024; c=relaxed/simple;
	bh=A81V5G3YB7wfT+yr9PUq/+TvAjOI9avz5mgJrm7cDtw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gfxc3s+Rcn+k34YDiD5fL0it050yUWz3v9aCbtx77wAgHTMSEKKWROqQ2Ge9+xklY2Vs5eNNaEiiksLkWW0Eb2sW6y+7d1AfbTt0/EhKAy7STPxxZHdKRr+ZDOnv5x8wt096eaWdhCyWs2Ktx7aM0Z00+1ZBT4AQqMzYrwLYikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=FvBPVDI0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1Ove7Vo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="FvBPVDI0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1Ove7Vo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 54220EC008F;
	Tue, 12 Aug 2025 17:43:41 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 17:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755035021;
	 x=1755121421; bh=bBYvlBTiWhdsUDAIphnhtsMDePLx4TH/nOVvXyY4daE=; b=
	FvBPVDI0lKk1yE+FuSSwgBHZnKsMJT5gEm2UkvXTRTeVs4bgrLAIbxB+ZjX0ea0g
	yyGdthn7If0fm7hJdgDzLJFq3oYdrQYxSu8GPUs8YODZz2UNcOBNpq9I9HJhVpWU
	A5KTUPjCiO4duxkHLor6rv4rN4kxGlIOox9P5Kf6IHeped4XO/pgU+Qh5iNKzAdL
	br0m/1mldEc6rw21B5rSF/2wD6LqsS9eX5GsEgrrflOZzG1gZ10SaY2sgFLZxkA+
	0u6Cp2++Y7yzqK6bSmQHfpvI3q97fSUkHILrhzI/BVPusG3O631Ao04AaNo13LPq
	3QR5ACOE+TBkX6Rf6C39og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755035021; x=
	1755121421; bh=bBYvlBTiWhdsUDAIphnhtsMDePLx4TH/nOVvXyY4daE=; b=X
	1Ove7VoM87kwhHSxBJiDeu7kHVTDJnZcqfaWHKNesSp9jywC5SOvNsR8pMVMn1/s
	jeAU9m5eRVkSeqCuFvOz/2mF/rQbTaQ1CCH8qxs7cf3ZCD1U2M5LFcIZ1hhAuOoc
	E6pOKKQDpKu8cEZidoMhUEdOdStZlAZaJ3QcwOogrbaGIwp7yj8tr0Hsj57IsU5P
	+NwT12M+0U2f6dp5Y3csugKQmWzBUakcMFyLVRaWqpe6M7ZlP57/u0lnUGLokbDH
	9RXp/GyAyc8mtVaFzPL9FOHuZLgxYAFpr5XpA/i8Ri4cYjqCdYYcZKyE/lTyvJsk
	BPaROf1LqxA3V7rtatjug==
X-ME-Sender: <xms:jbWbaCKj_GeJjoI3nm51Q4rSpBHyMoLQp-Iaoe8Hb2aWWOrcJ2uGCw>
    <xme:jbWbaKIdcGj7jZVejJsh0EvQzja_v317hosxOVBx3mICqldUvZTxjvDeoRdXfb57y
    lXY2qwH8OeKTACJkCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeigeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epfeeiieeggedtfeekjefgvdetjeffhfevuedutdetvdejgfegveffhfelgedvvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheptghhrhhishdrthhorhgvkhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:jbWbaGTqqk-5ohftZwAfsfzCQL2bnS7KOjUErZ8DfUz0T_QxYFSb6g>
    <xmx:jbWbaFPazPN7T_j6Y1lICK9C5CV113TUtT7Xnhby4Dl1LT_KEYI5AQ>
    <xmx:jbWbaDbVeWd5NFqE-DOaiQ2KOqX6JDTV3WciCc6TZ8sYjAR_ryy0eQ>
    <xmx:jbWbaHxfIW5HKIExholAzpHHRrlmOD4LpIW2RaHVgo3jnfw0JqSROg>
    <xmx:jbWbaHPsgYJRsjCDa9zlJKSuIh5NOKGBcdM8ZsKM0D38E4BnQ7CFzPty>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0A20B7840B1; Tue, 12 Aug 2025 17:43:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcd0a5d45e2f65ba1
Date: Tue, 12 Aug 2025 17:43:19 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Chris Torek" <chris.torek@gmail.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <93133935-648a-4333-9272-c8528085499a@app.fastmail.com>
In-Reply-To: <xmqqpld0ql2e.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <f7e8e4c63a1205740c2d54368d7bcdd686882680.1755029249.git.gitgitgadget@gmail.com>
 <CAPx1GveEX_r8thqpux0jcbEsEyLpNOvRWEvogUp4m_cNC5=dbw@mail.gmail.com>
 <xmqqpld0ql2e.fsf@gitster.g>
Subject: Re: [PATCH 5/5] doc: git-add: explain inconsistent terminology
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

That sounds good to me, I'll remove the second sentence.

On Tue, Aug 12, 2025, at 5:36 PM, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
>
>> On Tue, Aug 12, 2025 at 1:35=E2=80=AFPM Julia Evans via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> +TERMINOLOGY NOTE
>>> +----------------
>>> +
>>> +Git uses the terms "staging area", "index" and "cache" interchangea=
bly
>>> +for historical reasons. Many commands have flags like `--staged`,
>>> +`--index`, or `--cached`, and they all refer to the index.
>>> +
>>
>> I think this is also a good idea. Unfortunately, `git apply` has two
>> different meanings for `--index` vs `--cached` (I believe it's the
>> *only* exception to the "means the same thing" rule...).
>
> Yes, I think the first sentence is an excellent addition, even
> though I do not know if "git add" is the best place to teach it.
>
> However, it will be disservice to users to say "they all refer to
> the index" here.  Yes, it is technically correct that they all refer
> to the index, but that much any intelligent readers can infer after
> reading the first sentance that historically these three words were
> used to refer to the same "index".  And what I think is bad in that
> second sentence is that it implies they may mean the same thing
> without saying that.  It is perfectly fine to say that these three
> words express some operation around the index (sometimes called the
> staging area).  It also is fine to say that "--staged" is sometimes
> used as synonym for `--cached`.
>
> But at least `--cached` and `--index` mean quite different things.
>
> As "git help cli" explains, an operation that can affect only the
> index would use "--cached" and both the index and the working tree
> would use "--index".
>
> It may be that "apply" is currently the only exception (I did not
> check), but it certainly is not guaranteed to stay to be the only
> exception.  If a command wants to work on both the contents in the
> index and in the working tree, such a command is very much welcomed
> to use the option "--index" to trigger such a mode of operation.
>
> Conclusion?  I would rather see "Many commands have ..." sentence
> struck out.  After all, that does not need to be taught to those who
> came here to learn about "git add".
>
> Thanks.

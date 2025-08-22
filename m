Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D12D6619
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755895066; cv=none; b=gQUzXAnBnG+pYMX+I0VqJfiBN4NhadX3ukNKxyGHhqoDl6qFanxBvem8T3nPC8WO9niMvIZ1FgcyyVokeBNiOh6oQVrdZPQ/fomyOTRy6BzLcZOZTF4L3NWR7aMpyizJiug7mOzp63ETicEkzaumbHrZ1qfuX7VGQurOvZs8CXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755895066; c=relaxed/simple;
	bh=xIg9GsQgZdZ3gksts3Opasna+vuO9e4LXgUumYmgEdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mozwhTOOKjdC13lcqXXhfuWPaYdhc0zTS7Pqmq3WwnCh8o8IX2tzG8EC5YE/fPosGBV/a4srPM4/9jGaX41hJmdRPNkX+NG4BgcvEsaskaIVQHncIp2seROkYvcOAsDCQrkyquf4cW17qpCFbX7vspDSEzWFSOeQmW2YZs4XdvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=UngHlvjF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArphZxlA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="UngHlvjF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArphZxlA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 862EE1D000D9;
	Fri, 22 Aug 2025 16:37:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 22 Aug 2025 16:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755895062;
	 x=1755981462; bh=IBcNjy9zINIGFLNyXOhc7abMeFfLuCzg0zmqJ6DlRJU=; b=
	UngHlvjFqYMGb9VJ7FerSItRUO9ePu5eFcmmDVA3SbYs/jxi1SKwA5VUZhTeQHoz
	EzCVZpvxR+ADrwEnFd+43RUETM4hDzuZ+VYkYHeJLhNAs5FOEWzyvI4FS9YoifQr
	I8UB6XGGLc0saPRTKrAdWSvb0mUFijzN/0SYklZ2IakYs+ATGE4IsaZfo1y2K+XJ
	bycBnxK9PWdFQdr07s4m0CL6TV57KpThP9MmvpHpZboFlC6J9MaeOW8md9dHxzcV
	ogP1Jfr4feFaKq8b0S1ohV70NK8Z9/kqca9lqm7UpG5mq87lVFNytQRRetnWbhyu
	8Pb4mzc6RvYmlFbhQ2Opsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755895062; x=
	1755981462; bh=IBcNjy9zINIGFLNyXOhc7abMeFfLuCzg0zmqJ6DlRJU=; b=A
	rphZxlAy0hQRhgxZegdDKwyj/8lVHpoKy5QHezqjL+QhKRFL4sg0YwgMoUI2xzvJ
	G49cuISs0cBWkdgIsatev0cpkc9b2HRqp+IG89E4+4xL2Jh5R9dCZaroHPcZW49m
	v/ble2c+hO76reGYHPapsyXE7GquVVuZa7y3SM/EFCC9DRD4puznaeBO8/EOhErf
	MMsNuOp7CbNfRythmDgijM56suVGckp3W7CXkXFPbLAjrUPek11SELcfqZ6VU4tx
	oxxZDi58R6iR11aCuL0XrOXh4xyHkb3vYaav69ZaGZb1c3y9JDSGWHGpCzc0oCJe
	mqr7GW2wSjJgAjEkMjT2g==
X-ME-Sender: <xms:FtWoaGuLGgBvn8GuYNv_Q4jN8XLY4EE_pAIQyz8aYbhvs0sgS12xFQ>
    <xme:FtWoaLeaKX0xBfzf39wI29Jbog2TrYq2o2nxLlrPMdq67II1Qi2UvOsepq79TKoUA
    L8hj_lfjiKlCZczyvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FtWoaLJMbP9IsUazJrhD_KbpjTxktGXiyJludhV9WdfiMYhfwLaKIw>
    <xmx:FtWoaP5ikoQ1geCmbbwJoQ6gP6g9g8BDSNiLacODQbJFn0Y0wvOQAg>
    <xmx:FtWoaP14nAytgdDlCwV8yhtnRTnpMb5-XwYyqQCaHe3ohTQ8kJDupQ>
    <xmx:FtWoaFdIl_B5KjG4MyhSkZlMy9OqcRY6LlmsC6c3zY3x6TFTxYKUYQ>
    <xmx:FtWoaKrgALkctGlNtIdWUHu3ab5H4UKtez_jW3SRoh8bBj1fFXBvs5AC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 287487840CC; Fri, 22 Aug 2025 16:37:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1RQzAbj9jQc
Date: Fri, 22 Aug 2025 16:37:21 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Chris Torek" <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <b30fe574-146b-4b1b-8a88-07014c9cab9d@app.fastmail.com>
In-Reply-To: <xmqqv7mgzbd5.fsf@gitster.g>
References: <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <pull.1952.v3.git.1755636370.gitgitgadget@gmail.com>
 <080720c059910c910161e250cd7eef54208c3fc6.1755636370.git.gitgitgadget@gmail.com>
 <xmqqv7mgzbd5.fsf@gitster.g>
Subject: Re: [PATCH v3 2/3] doc: git-add: clarify intro & add an example
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

"what you use to prepare the contents for the next commit" sounds
good to me, will make those changes.

On Thu, Aug 21, 2025, at 4:08 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  DESCRIPTION
>>  -----------
>> -This command updates the index using the current content found in
>> -the working tree, to prepare the content staged for the next commit.
>> -It typically adds the current content of existing paths as a whole,
>> -but with some options it can also be used to add content with
>> -only part of the changes made to the working tree files applied, or
>> -remove paths that do not exist in the working tree anymore.
>> -
>> -The "index" holds a snapshot of the content of the working tree, and it
>> -is this snapshot that is taken as the contents of the next commit.  Thus
>> -after making any changes to the working tree, and before running
>> -the commit command, you must use the `add` command to add any new or
>> -modified files to the index.
>> +Add contents of new or changed files to the index. The "index" (also
>> +known as "staging area") is where Git stores the contents of the next
>> +commit.
>
> Much nicer than the preimage text that is quite awkwardly phrased.
>
> I however would not say "Git stores the contents", as it is you the
> user who does the storing.  I may phrase it more like "... is what
> you use to prepare the contents for the next commit." probably.
>
>> +When you run `git commit` without any other arguments, it will only
>> +commit staged changes. For example, if you've edited `file.c` and want
>> +to commit your changes to that file, you can run:
>> +
>> +   git add file.c
>> +   git commit
>> +
>> +You can also add only part of your changes to a file with `git add -p`.
>
> Great.

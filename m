Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76218190063
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287797; cv=none; b=j6NQcOFOYM9F2udV1VauHPnjIKiiCPiuSYgHD1Gp3sXYKvcNuY8YojRr3No/JP7WY3cl3BzyVZmCNABe+O4i45W12T3ZHCmuVQQUmQYB3L0fMWDYQdIBqXaPzR9mivkLzrd7OlSUz0IHeZLojU5wSAnyoLLNDgKCu0U9ouO/Duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287797; c=relaxed/simple;
	bh=Pg7t3FejL5WBNU9duSld9fejlO+r1V/EWb8LQ+6oqRQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WQs/ukdTfW1L+vySMYVnz94/QTvG5PxETVTi6EC9Kb6bn1gZmxF/tl8jNv98PUIRLb2bCAgC/HMZa4UWT+ZqaLqGGlviiuPuku4r48O3utkhPOSeKgpG2vZtpwFE/DGpLF3TbrT6hSLqvK56wrnnH4GOz+x9PiIqP/Wvzn/nh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jGULfdp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSKmShFc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jGULfdp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSKmShFc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 976EE1380230;
	Tue,  7 Jan 2025 17:09:54 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 17:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736287794;
	 x=1736374194; bh=Pg7t3FejL5WBNU9duSld9fejlO+r1V/EWb8LQ+6oqRQ=; b=
	jGULfdp6p55jAobcXIwvJFvfTm8ZKVrwEhvAHsk+hR3+aG2Pi3xFxq5jU/KnnTtt
	PGwgHX86c5/qazuGWVctZmhdTXOUgPUIPZG5cytbwuVF+Om+c1uCLIMJ83NuX2x+
	JX8VC0SULfWbUoNIfPiTmV+bwi8VlYKLYHKWcfWjMbOvt/m7CghrTecVnW/TJaga
	MinPsVsXvfcYPAD5MjhjprpFh9kIIAid2Bj19E4ELsAG6E3UOm1t+D4vY+1eyvXt
	ifYPmBDGa5flKJ9YBCLmfF3wtuEbz6YUwH+Hi/v3TlTWwY2s3GeVbSpDiFsyNMD0
	E33T31G3wczuYPseEeQc8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736287794; x=
	1736374194; bh=Pg7t3FejL5WBNU9duSld9fejlO+r1V/EWb8LQ+6oqRQ=; b=S
	SKmShFcEtlltmfhkAU4kY+tGaC+jBWvzkgKY3wBhFd6m+mRu8Sq2Pf3EQ46EMYll
	Ed0eKCC5CNJx85GzMhWZzGt9jF68Fk+DbhsOXLcN7xJl5WphwwLWQhOsfxNnnBFV
	t2bfMuZM0W5eFlDdoVNFWny5FNV82IVLnUieFpjq0ZQV5Mo1+ITV5ofoB73aWNKj
	mEzU1mANhJy38BfFsbMHBwz3O1e2Zz87dfgJrFRLVjuqk8wW45nLJlc0HxzOFClT
	nucaVOvD9sh4mpaNcD8X4Au7K4lTahW47kRbSUf3pqOXaQvCEI905OJojvZ48tku
	ztk6l8aErLuQz8fP3oOPg==
X-ME-Sender: <xms:MqZ9Z0vRarcDs5c3WsY8Uk3gXABJaXpKoq1vm3NUOdlI3pCaUfRxEz4>
    <xme:MqZ9ZxebnlPK6CpCvMxEzFCIZiRBCh_IQjAKrFpe27R_sOX4yN_axjb4_zwc_wMtC
    FToBgxTZiiMhyibxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdeg
    jeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:MqZ9Z_wKc_yB4SsEQfwbYcJiH20vx2G0b77Ww9XKO6TGbMP5J6u8YQ>
    <xmx:MqZ9Z3OBDcaDIS_HTvuCYUQ1MHbIXyNH52uJHu6SjJlVXeBqHcSqlg>
    <xmx:MqZ9Z080VcKlwC3srkgcTTPdKNdwgyqgb6u4YSdjwBDduArKdr7_xw>
    <xmx:MqZ9Z_XbAIesvh3aKaqDqt1kpNkuQdmWUE1Anf7dCrlVz0687588ug>
    <xmx:MqZ9Z2LcrlVlmQBckm7CP6jyG3QvK6agB2ITcn3e3c8j7zmQ-N04F95_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 57F70780068; Tue,  7 Jan 2025 17:09:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jan 2025 23:09:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
Message-Id: <8aa4e7d9-b77b-4f29-9564-5c1d4ec5be0a@app.fastmail.com>
In-Reply-To: <xmqq5xmqs95j.fsf@gitster.g>
References: <20250107071824.GA594237@coredump.intra.peff.net>
 <f3ab08db-5dff-4da3-a075-7e9b3eaf1f78@app.fastmail.com>
 <xmqq5xmqs95j.fsf@gitster.g>
Subject: Re: [PATCH] t7407: use test_grep
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025, at 20:42, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Tue, Jan 7, 2025, at 08:18, Jeff King wrote:
>>> get rid of them.
>>>
>>> (It is also curious to grep in the expected file in the first place,=
 but
>>> that is because we are auto-generating the expectation from a Git
>>> command. So this is double-checking it did what we wanted).
>>
>> Missing =E2=80=9Cthat=E2=80=9D? s/it did/that it did/
>
> It is colloquially correct, isn't it?

I=E2=80=99m just going by intuition but I couldn=E2=80=99t make it make
sense in my head/read out loud.

--=20
Kristoffer Haugsbakk


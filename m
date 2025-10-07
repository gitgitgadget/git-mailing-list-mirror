Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983261E32A3
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867325; cv=none; b=kS8gs0uYozHg7e4PZNqYbicjt7i4Y5Br5y0CtO5Qz4W0VzvStCEklr8n9CjFQ0xN2tX9EnaaK/igJ1T/cS8VdLBaG60NiZ7UBvrVpfajUS9fJomhdiGIUA6jFTaOEClb5hBUZb+pYUrYAfH/3/0xWYNBDC/GZ9ElkLYKmgZIGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867325; c=relaxed/simple;
	bh=Cm4mO2lyCNhoeFJW7tFiy75sUuzsqYkQvCQu+VN5H8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NF7Lb1vjONTMULFM5qZJRMIqkOh7iTcMKRhPdYCUnOQ3DNREeY7eMP/aEzGTnY2uvGXsabf4sdYhc5oNWZu8EzbDJmS+Xy1gd8WRrpfQ6TRYwxISxgySkbFEGeOLUDvL/IyHAmgSy6wU6kyDVf2bcn38lCh7d97dsFIfEF/D7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K8U9X69I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RE3zz23c; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8U9X69I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RE3zz23c"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E66A1D000C4;
	Tue,  7 Oct 2025 16:02:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 16:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759867320; x=1759953720; bh=eNtEY4ucpd
	LfLkPstVf+dZRDzRKnjAzxan2EnbjC0EI=; b=K8U9X69I/3N0J0fGGDLVjvPzDp
	4uybeKahVBiXSuN81RkFaDPcTP9/C5zt7YGDvU1Qu7XwqCe0BRGkCG39GZsv419z
	IYH0d/UjElVN2P8PQ8gR86mT8bEwY0u/2T92uxVXoi32B6DrmF4LN6Da3RlMVW7x
	tWOAzCPN5qaQ8OUONEMahTqwZIU3yehtPnAS//Dc0XR69kzgzh26DU1NmBGSvbjm
	Hf8OaoQHLH50m1YkMla7UajTWWNDphhPp1OT9cM+ekwGmZLAqph+1IA0rNZcki/v
	HoNND4UluY08xnPFATuW7n4S6EKfxpCPnWujI+Jl1XlB/fY1DvrspV2zUASQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759867320; x=1759953720; bh=eNtEY4ucpdLfLkPstVf+dZRDzRKnjAzxan2
	EnbjC0EI=; b=RE3zz23cyr+3FEaz7tPHEIKdX2M+epz/3oYmNf1iqkt1Fe5AoB1
	AR3UedS4woltfuCKXwd2ZRf9Ihnsrb0Aa+qpZyDR9S8vuLkyBRClv8nfd9rBPf79
	AbjkFyvW6ucGxL2YfZWdLDNqiM+1WpY2xSAGoGKU1na0o+1y2i03AFHUr+5+aEab
	N3o9Wp2K9Kw6fIWLGcviVYljIJjEpN1ZnkzTOJzig07wkm3sC9B3nPYRESokA7p7
	gMcFl0v5EHHvDFttq6M3cZXr3wwwXx8zCs7zxGqPkQO5IwenOPC5YT7qPobkYfr/
	xfjHUS/+U0nTrdQz/t6NnrdVLh37KoQgmDg==
X-ME-Sender: <xms:uHHlaADvXxuBPKev-H0Kg1pLBx7uUfL8IE1-PAftnmJ2HUzVrfmVPw>
    <xme:uHHlaJapv0eQ6DbqY5wcCod1pxADg6xLPXPozHV-CYk4KRoEgtfQ6nU9nTBJ0sijk
    7SIDQM81iDgYK-e3jWAJEClwnZ0jhplqIhFIrpZH-WEsOh4T5Z9>
X-ME-Received: <xmr:uHHlaL6LUsz4wbmMTzMaH0RtGyvms0sTCuRi3LyGZzPZCypEueJUrza1sjRB1YAfYQ1OpCG6wlDCPkTSYmnwOHvptxfjKITZvMvC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uHHlaCZee0V2M0JZ5AXxbWYerIe-wAjawoYcGq_uG-NeZ3t2AWZyRg>
    <xmx:uHHlaCj3OmAjUtHLo307JJOvEy-FKTO7_jTD-whr1ZItQ1uwNPVbjw>
    <xmx:uHHlaL-FBYDF_x_VdOF6KgZpKP35MtHLN9ELgUGA9QuiX8ff3cO8fA>
    <xmx:uHHlaFrU0LysMEIHEYmWfVpsElySh-g_XR_qFRvA2kJOSxTkYH1Mmw>
    <xmx:uHHlaNqrSKdC0HaMo8cg_NM1zZxRri-cdUB0zI5bhA8geqWzXC9NNaf4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 16:01:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: add a explanation of Git's data model
In-Reply-To: <ede082ad-5031-4b55-8576-0a6315f16b70@app.fastmail.com> (Julia
	Evans's message of "Tue, 07 Oct 2025 15:30:47 -0400")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<aOUkZa4_fq1hho7Q@pks.im> <xmqq4isalk5g.fsf@gitster.g>
	<ede082ad-5031-4b55-8576-0a6315f16b70@app.fastmail.com>
Date: Tue, 07 Oct 2025 13:01:58 -0700
Message-ID: <xmqqwm56iiq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I think it's useful to refer this as an "ID", because usually we call it a
> "commit ID" or "tag ID" and not a "commit name" or "tag name"
> and it makes it more clear that "object name" and "commit ID"
> refer to the same identifier.

It is a bit funny that they do not exactly align.

    "object name" aka "object ID"
    "$type object name" aka "$type ID" for type in (commit, blob, tree, tag)

In any case, we should add "object ID" and other "$type ID" to the
glossary, if you are going to use it very often.  We have entries
for spelled out "identifier" but I do not think "ID" is there yet.

Thanks.

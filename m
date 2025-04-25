Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D278F4B
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591983; cv=none; b=dTfQl7JfVIvlK4wixxIZBHlXJGsG2mtgTFdhWKwQOFcleU+Wc8S7DDNadUIzHKnsZjDmAf24QOdrY25e9DBKxJ0WTrXZrao0UVQ5bILMZYVaP/xRMvzNz1zx+SZhMWx5vLtigklX8a2UZqBbHcw7UQ1KtBDAWW04fd4jMwmVnuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591983; c=relaxed/simple;
	bh=t0/j55JittF8rURWUR/X/KIduz6A3mQNXARr8I2B2EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YquVUBjIrIsYIJ0PtpCGi4s/oD1VTFj0imHJeSgGe6Jlcqi8Pfzg6znIz6N+dw/rX2Hf9V2XHkQd8rckGMFVeJvo2nmR4Akhp/6flr8BMiURQdG+q5AeE8xmld25lTGL9l+q/ABwFxEe0auFkyJRAmY7fh50SnSfHorC/zyjIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SaRbbhG1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vkcq+iug; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SaRbbhG1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vkcq+iug"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7E09254026E;
	Fri, 25 Apr 2025 10:39:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 25 Apr 2025 10:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745591979; x=1745678379; bh=RuhHv+m29U
	NmwbmiW1t58hnWYP3v1BOy1zItdQx4Q2Y=; b=SaRbbhG1Y/1HmonUaJb7eWYn7J
	MUPJA18O6DG1HJtFSsu7QK3xuR6hcNNgFV0U1Gk6oiCnHpPodnjINIGoi1Y+85Lx
	jREGiogapsBsqb0NwX1j3P5kBfKwzkhlTm6HtoxcqzuEM0YLAEhDh0NQPVRqIlz4
	i1Uh4nRbSXIwWrwWGmYl9cWSqlTkxaO6bRadLnmkeURhCV0oEVJOb5Py1HxLMld+
	30cM4oql81WIr87Xoa0LlTzz8R85PnQxPSqGZfrDfCq+g0bPBOk4yd6fm0+1Fh5/
	7RL9ueBVYRLhTbIbvVd5nsd/wb1D7zIElxuKfbin+Z6CGTzWG1FXRZZAl4Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745591979; x=1745678379; bh=RuhHv+m29UNmwbmiW1t58hnWYP3v1BOy1zI
	tdQx4Q2Y=; b=Vkcq+iugOAgyTjTmzPWirxwWhPinpVy1xgWZft0D5//kvNt7Grw
	37QekhJtcCxF0ZfKAkdSYkyD8Av1ELS8dnRLhOt3IKQQ0xEsf+/PoeFvdTuddRGx
	BV1GKyn8VV8cppU+Of+n6teCCZF732vMrWteJpHFGAtTmDhU3f5PTt38uipVrZoT
	1bhqD1+OkWrecm+GHzZHtCstiPVesWxKd2Kv6O6YSLDCb5hgwAVcILPHt38FJ/NE
	BNqjv7Zudt/EICZDddfbRBD173pLTKJ5p+H4GkcBLQHsLTx4FN8TYg9aptdsK4Fx
	J0LtHE/FygI885QgD7msVj/uZIMVp1s1XJw==
X-ME-Sender: <xms:q54LaML5AK8zV9zixGZ0WGD7ock9r9-SafuUlP6A3tiGGQMDK5oTQw>
    <xme:q54LaMK_nCbnH6AYN85Be7kKMjMyTIINIYXkuDWOIPOtt-SGzldvdUQYqNUfGjSBy
    BmfvVdBE_CFrsXG3w>
X-ME-Received: <xmr:q54LaMtJPj8t31N5hQ9FhznOtvjUi5qVXWMVD-q2aa_9q3YhJyBAAd11O9spIJAWoNH3mUCjrc2zQX-4GXRtNuoiLDpnag1R2cC6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:q54LaJY52Tk-vaWaxjpxg4Gx04GkPaZFY1hhg59Bg_d7O6ZnRspaow>
    <xmx:q54LaDYNxjH558g-SB6DmRGnQSG3C9jA24BhRXqPTQBRVTNbrj3xmA>
    <xmx:q54LaFDA4KMxbVUHxyw4uISNWNpzaW4dDNcK_C3WRsYFhmDPobPEkA>
    <xmx:q54LaJZT18-e0y5--PO9-gM15xKByQMewpfLuECqtqxe_7lnnTue7A>
    <xmx:q54LaLq4VlOmjaXdZDIdFk9CqNDXPZyraqDYFWbS59enCF_x-1rYcaih>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 10:39:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: skip unavailable external software
In-Reply-To: <aAtdsURaaxYO7pVt@pks.im> (Patrick Steinhardt's message of "Fri,
	25 Apr 2025 12:02:25 +0200")
References: <xmqqfrhxtdg9.fsf@gitster.g> <xmqqmsc5rw94.fsf@gitster.g>
	<aAsNUYUKJZbrMCf2@pks.im> <xmqqh62cwoya.fsf@gitster.g>
	<aAtdsURaaxYO7pVt@pks.im>
Date: Fri, 25 Apr 2025 07:39:37 -0700
Message-ID: <xmqqv7qsuwye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> But shouldn't the failing wget cause an error, too? So the `|| { }`
> cleanup branch would execute in that case and we can prune the empty
> file there. So in other words, shouldn't the following work alright?
>
>     if wget --output-document=...
>     then
>         massage output
>     else
>         rm output
>     fi
>
> Or am I still missing the obvious?

While the above "works", what is "obvious" is that it is way too
verbose and the merit of going verbose is dubious, especially given
that the reason that trigger the argument to favor the above
construct over the more concise

	wget && massage || rm

is "massage part should never fail".

We do want to notice a failure in something, if that something is
what should never fail, don't we?  Not necessarily so!

Our CI jobs are not in the business of checking and ensuring wget or
chmod keeps working.  If either of them fail, the more important
part is its practical impact to the rest of the CI job---resulting
"jgit" file is harmful to be left on disk and needs to be removed.

Another to think about this is to imagine if we are having this
conversation, had "wget" had (just like its --output-document
argument) a "--chmod" argument.  (wget && massage) as a unit is
conceptually a single "download the jgit binary" in this case, and
if either of them fail, we failed to download it.

So, yes, either would "work", but I do not think longhand is
warranted in this case.

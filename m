Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A092F5467
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134546; cv=none; b=qLsjIowBnyoTb7ltHPgiNw9S7KxVMGgGT3rj+8B0m9+UvsenDVx6mZTskUzJuXSc9UZZVDXgvcFp6BZM3Gs8sj5ipXm8N7uNpOoQR2ADenZsmKhW/QiMqfuXDWfezagkKTGCAsHAmQmhnxcxQkwXc8mGjIMMQjmFzS9DlCxmA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134546; c=relaxed/simple;
	bh=mzPMzs0q1C6TLR47nFi+XDHhqv5l5d8LD+D54ZCfRvA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FbrjJAEbn/v0OP6YogdnInowG8ygkI5Mo7lb1D5t+GvQreO8s9/rJROa5CmiC+muvXvw7zg1WPDyWRgdtQr0YnHj8tOb/bIgxoY+EW/s6XYJPkylbo8oPhmR9g3FqquuW9HB3wOd/UlVf7MnBREWqp1+HPtfCBqCSdxz7K1JTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hns4rdBw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jfh+2MA9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hns4rdBw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jfh+2MA9"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F22D714000D8;
	Wed, 17 Sep 2025 14:42:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 17 Sep 2025 14:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758134543; x=1758220943; bh=sxNf7giWwP
	OCBPaJNHkTovmyQoAFLcwG5JtsF+Wz+ZU=; b=hns4rdBwSxkvSbm712jaW/IA3m
	7WMolEaSMlUndtiDPMZIro8ZEr0uHLAg/VJqsNyb/nmWFvdQclJGj/Ed75270nTL
	od4mu8qFYs/vLofrLPAhzgcT0H5u3ISuGzDaRnnDSCLJaqDFAAw43fIYeI5wRpNU
	q5eY6GlyuJcNcwKrh+2k+tf1c5FZGY5RHvxe9Jzj+p9mVYfvywGfWG/rdgx0HwlN
	w/AN14y0uoSeOXXqFB4pA6h+GG6bt/wgxXWd4MiX8wiAJaVEg/wB6d/h0SlAKec9
	VA0y69pnvz8cI907FhnekzanFLBZWezDByXAT/nDSEM7nRhlxvDYkA/UtIrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758134543; x=1758220943; bh=sxNf7giWwPOCBPaJNHkTovmyQoAFLcwG5Jt
	sF+Wz+ZU=; b=Jfh+2MA9t6XbMM3lA71mOcEbkTrRgoGnvbhJn9cT3/AFiFPYxGt
	sqQs83SfNz45CCmrVxR962Fr9FqXIj15ZNql298zbixskdtz+cU71sMVyjJ6JxWg
	109frPLlkhaE7s9ePgp4z3eXcXMwzeMJbtuCX2ztU6xYwrTnj1bcuozxZzRXo37i
	EkF4/cdyOqbTssy+M3I+cg3fPJar5ibqt30bie1kgHFlEy9NovrFUOlpHckklhuz
	chJs5MpJe7See5JCZ1A9FHEHVEVKvBLhZx42gKvbiQMzfaXXq/5+lK6Ar/ww1yPQ
	ZyLset7F7qM95j32pieZI2fHOLIDLExUEkA==
X-ME-Sender: <xms:DwHLaGwZUmkzm1xkJzIFhTTaKt7X9t1oo0ScZ6tzn7mI7OyYmpef-w>
    <xme:DwHLaKs1H_teDGS5dptMq4-AvCLstdyo7j42gcX4Xyp0BOLafyNiG9t3n3eGyrXmk
    BHQrDVS4pgowbDr9Q>
X-ME-Received: <xmr:DwHLaIzrEp7vBX6XerfladM4Y38SFi_jZR5K2PiNrn6koE9Cf2QNrIDS4DbQ_QvdgpMer53Ketu4QlaFzWnJH427HUKqOq6Zap6Te9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetieejgfeiudehfffhteeggeegtddvfeeiieduvdduteekteegfeetjeejgffh
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:DwHLaNDhM0E6_ToGjwFOKdUjj4cNHoS3Koa6t5xDeYOsN_DHoa_wtg>
    <xmx:DwHLaGck6HojVeqCmu_KuoomGbaO76mBo7vBX05u1pxVWtLZX_4IUQ>
    <xmx:DwHLaHmAiNR4n7a722Ccjo34-mdhKura88jWVnz_dDc9MBb7GgAaBQ>
    <xmx:DwHLaNFt5X3IKluKnJ7OIMRbxwk8TLFWmCoyPZR1avT0UvKm19Kc-g>
    <xmx:DwHLaFX_kJ88UcYSihvVIo_1Fh00atSDX59rFerAdrXjs0llO4kOU36B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:42:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
In-Reply-To: <xmqq7bxzcgsj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	15 Sep 2025 18:44:28 -0700")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
	<xmqqjz23l7ci.fsf@gitster.g>
	<70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com>
	<xmqq7bxzcgsj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 17 Sep 2025 11:42:22 -0700
Message-ID: <xmqq348kdipd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans" <julia@jvns.ca> writes:
>
>> Re "refs": I think "refs" is pretty relevant to `git push`, which is why I left it in
>> (as "or other references", to give readers a hint that a branch is a type
>> of ref/reference).
>
> I have (and I didn't have) no issues with "refs" -> "references".
>
>> Will try this:
>>
>>     Updates one or more branches, tags, or other references in a remote
>>     repository from your local repository, and sends all necessary data in
>>     those branches or tags that isn't already on the remote.
>>
>> The goal there is to make sure the reader knows that git push may need to
>> send a significant amount of data, depending on what's in the new commits
>> you're pushing.
>
> Yes.  I do not partculary see the point of deliberately trying to be
> vague by saying "data" (in "all necessary data") instead of "tags,
> commits, trees, and blobs (collectively known as objects), but I
> agree with the stated goal here.

Let me change my mind here.

If you are trying to avoid overwhelming the readers by carefully
trying not to write things that do not have to be said at each point
in the teaching, I do agree that the deliberate vagueness I
mentioned above is a good idea.  You seem to have better "taste" of
knowing what the right amount of detail to give, a lot better than I
do.

Please keep these goodness coming.

Thanks.

Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D121C245C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878696; cv=none; b=H+E5XLw1bG6gP/Di6B9CBrTV0Y8J/4Kpo24BiCPJLRF0HM0cFiNcUBhdW00OYUKri/3zpjzN/fbiXKs51SFsGKsiGDtB/nvYqbXQDEjdQsVH0MQk9CMogiruwxa8tWNZng0FtmlyEx9NrNRRL5ACkI1mEXctk4BdcLhFvWPstrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878696; c=relaxed/simple;
	bh=5sDDofFbq0FHj81njL1YCMca1vYYNIuT2xkdDTtW1P4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UrBUjrsNnIph9h/3VNvyVtNEWCSNTklcmrWJKES2OihJckm1PUDctaKGXIQd/S9OLs1e6M6APPsalLuAsnZVnuUkU3IL2wQrVzLfSHTcN5kEmFc+sTTaXDLL7ViumgAqfhDXYrtoXHzJFlhzKVyelw2i4wkvTxVsZWlQ4Fok2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fYyV7GLD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCFQ/Ibk; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fYyV7GLD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCFQ/Ibk"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 947181380140;
	Mon,  2 Jun 2025 11:38:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Jun 2025 11:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748878693; x=1748965093; bh=rfq8jfTpkL
	0EQ00cg/TWVVQ8mzmUR95eMUhUf3nViOo=; b=fYyV7GLDZWyJQOvVRwyXMSsVHo
	ZMjMtlxznQ/tWL6kxohOKCASswxQBFrAA0ogGqoPVI2d2liimc4CpKL5ZcBIEMB6
	mw9Gdkr4+fOACGtP0RRWAj9GjD+LYlHiHwNhnIf9bjTtFv2AFPooFSlpqp4tFm43
	+m74u2fBdFgXlBZUEP1iusTtDcydaBMC3xfv5RUIaZPMXNQjxdQVIW6FL3Z/tajZ
	4ljd0kJVYP+MrwI7BAnW7bwhVqso0jczW8JMkwQt4ACbh7VEXEQ0F6PRy0NPUIj1
	boLpomi0hUcZy2mun/qRvhELaocGpevY4nsMAxpafKhzLydZPOeJqo3W7sUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748878693; x=1748965093; bh=rfq8jfTpkL0EQ00cg/TWVVQ8mzmUR95eMUh
	Uf3nViOo=; b=iCFQ/Ibkv/Iq6i6zcX1WRcT0G44spCeUUjXcsnPgHtOv3HY23t2
	pmBfjYwIilnepS3X//w2YIOL0FOO5Y9oAm/jyUYqnflzsRqU4FuNLVZLZfQLiehp
	h8hcle7ljno+NZ6dXb3KC5+ilEoa/hh8NobfwgucjON7ERYF0u3WXGg528Qal2U9
	dN/QuVqE1mbgyjbvMWSBgHrX1A6ptv3D6ylOj2UTImfxoDuPNV4EV3Xy2JrLgHmn
	aSUU6ls+34G+E9pJ9wT+BwE49Ds2oDrMMhAdPWRsSJKJfi4skXjgJmB+3z9QmyAc
	Ol0HOt2p9zdpCaG3UYiYRlPuOGppukPVfqg==
X-ME-Sender: <xms:ZcU9aJcLbIyGFOxALZBUcNXVPTxUbVcEfWvr6-i0oiS4mfAV5LzdBw>
    <xme:ZcU9aHO1lMXCnvnr9GTmX_OAcAilaPUVKaaETTfvKPdHpAwycaLxfoE1P9Kfw6QRS
    BPvmGR1OKfN7iEkBg>
X-ME-Received: <xmr:ZcU9aCjsurIYuCi5wVhC9FMA7gXEdde2H3VEdBLc-t1LpPY08MK0qCVWS-P_0sGLpdeF3jnw7UJIU1bG4AbwHgh4uLFizMUppAG5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefkedtieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZcU9aC_phbMz5Q-e7GNUOll3iTwa3fZapZ-1P6oehZmPufBaNHyNDw>
    <xmx:ZcU9aFtHHLWZkCij6itpvMBeAVfmP6EllDS53cSzZlEcaEpbI2ajqg>
    <xmx:ZcU9aBHA8LfoIJndeN9fIR0C8TcsJ7fPhfa3uABA2MJCgz8l94b7WQ>
    <xmx:ZcU9aMOeWt7ilAt11k6DkeC1mvXyyItU7uGC6PVf-sOjeuROsAU6CQ>
    <xmx:ZcU9aDR0KeSUvgeDbE6vdNQJo4xe2fD3Bs5XOKGdYIwiIxpKEgV79jnl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 11:38:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Toon Claes
 <toon@iotcl.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
	(Patrick Steinhardt's message of "Mon, 02 Jun 2025 12:27:01 +0200")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	<20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
Date: Mon, 02 Jun 2025 08:38:11 -0700
Message-ID: <xmqqy0uataqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> This series is built on top of 6f84262c44a (The eleventh batch,
> 2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
> drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
> couple of trivial conflicts when merged with "seen", I have appended the
> merge conflict resolution as a patch at the end of this mail.
> ...
> Changes in v4:
>   - Rebased the patch series on top of 7014b55638d (A bit more topics
>     for -rc1, 2025-05-30). This fixes a couple of merge conflicts, most
>     importantly with jk/no-funny-object-types.

Ah, the original cover letter material that was more prominent is
still left before the changes per iteration lissted here, so I was
scratching my head wondering why the series fails to apply at 02/17.

Will try to read it through before queuing.

Thanks.

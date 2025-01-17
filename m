Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387E1B4234
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153235; cv=none; b=DrEQqU6NqPdxeolp2VA4vb4JxbXhETHe48ZexvoyGiPGY3ZJZhH2zoSLQ40D8twgwRsRMzQk5OkNUl5eBwyY3oF5RUS21k7l8Mjl2OWrxsxnYvuP3MA5xI0E3Vv+iSJPeCAEVy6nSOdlnkBIGga6JLeACppY5J0lJ6eeV3ZVf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153235; c=relaxed/simple;
	bh=cMRUaD3LApp2q5/m76liRh0V8iCKCnVdEBKx05KKUIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yq0k74rI5105qH/sv1gnIT046mnxgACG6Qcfy2+qgld5hU+LQExajzTQbd9DsxRKM4ysI7XdGqeD8K+LwGH0Fbw0NTUC89Z4/tKtti4MvnBIRO5o74d5DaIRs47+BhMNgfP7gmr12yWWGSZWwoLfD1BD+irerbVahu3ZTwhBBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ql4L3gmp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CttKiSqe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ql4L3gmp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CttKiSqe"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED2911140192;
	Fri, 17 Jan 2025 17:33:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 17 Jan 2025 17:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737153231; x=1737239631; bh=15mHJOWxND
	Dbu7YDCLdI35sAoJUkEPtz3Hum6DGboBs=; b=Ql4L3gmpVyr/aqW1boJDV1VKIi
	3u4nZsrGx0yvwGm0Z1ubm0SkJmrmXm0SznT4nLelmW4UW5cVkq5/bmPAIM8QQpJd
	yXmjcLzfdGyaOv/tkA2Wht9Y3TLDI6s72khTIk5+rad4qiCMYISk+LjVe+vGnQ0K
	Xr9djJ+MERlewh7h3bzNkvnHTgroP9Px56aLkjBhcL5vEVTxgqpynm3moz8ImnOM
	0W+GzwMOUMn6Ni+FvPncfZKbYOtmgLjAYVgk0Ex7QphNcpa+XGYmjHJsmUIVTDse
	ILtBj6jwy/bGO5IO3jduLUCN7WJI8s2jHi4AsmTfxYqOdmU8W6sXMKz5KC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737153231; x=1737239631; bh=15mHJOWxNDDbu7YDCLdI35sAoJUkEPtz3Hu
	m6DGboBs=; b=CttKiSqeFgvQPGjNiSBEJjZ5fIQQseyCkLj30mgrdy11+bEBjOk
	pxvaTbEqGcqEWdNMI/Cyk/fC57LipyTgnYb8NrDmqllrfhQVDCormb82QOVuK4Lf
	wodQGGwCvLBcBDtEk0+fqAQkgqf3BRGAz53P9R+ymZVytOm00mbAkfM5V5awmzjt
	jtkOk1FCvHbXDN3L0+2yK1iEYlaGQihPna28WuT6Co7hFkhQ+OKM+puEWr8ozPT8
	woOtRywQt85bH04GzdHVMRBPQt8TiUstfnE7pNIBF1Cr15WccpuAms6EP/MWgsmv
	CChsXEJ0gfzE8Jc7WyNpKoCusMfdACAUPGA==
X-ME-Sender: <xms:z9qKZ9RYmH5SJbJ-euY5IvBg-wjJsvTgrJxOywfp5993kj43StD5PA>
    <xme:z9qKZ2xmEsruOMDj9eXauCoSdROyRpnvjBQcKkhBjV7TwkhZleeJ3Z_vY4KwVMiwl
    wFJ3JiHfYq9nYx7Cg>
X-ME-Received: <xmr:z9qKZy38ypzLjXouopgfjf-JqdRmNzjk1Wq7sPStwFeCIYw2S8dT14b8WjF2wLKzBnbVo5FwYQkik4NrnAEZqIeX15HEUd08CdcC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:z9qKZ1A5XeVumMUtS2I_nfhnq4KaVaPb5mW4OYhd46SdjRLiI5pHTg>
    <xmx:z9qKZ2gLM9w188CZZIYTBGFuqyP5aMQxL3xpXNNp2ViAnnUiFDrQJg>
    <xmx:z9qKZ5rnwdJT6YuNHyI_74Y84FQRuXtlOjXDw_4zFiNBk6I4z0__LA>
    <xmx:z9qKZxiKOXOTJUB6RSS6-ck0pxZ_v4_l6yVAPIKD2BAGF96Cj0M97g>
    <xmx:z9qKZ3ZAPO7DGz7JIIrB2iyxC3imBmfOdbdBeTHKfAb_PQSunm_q9ZP0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 17:33:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/6] version: introduce osversion.command config for
 os-version output
In-Reply-To: <20250117104639.65608-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Fri, 17 Jan 2025 16:16:18 +0530")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-7-usmanakinyemi202@gmail.com>
Date: Fri, 17 Jan 2025 14:33:49 -0800
Message-ID: <xmqqwmethxyq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Let's introduce a new configuration option, `osversion.command`, to handle
> the string exchange between servers and clients. This option allows
> customization of the exchanged string by leveraging the output of the
> specified command. This customization might be especially useful on some
> quite uncommon platforms like NonStop where interesting OS information is
> available from other means than uname(2).

After reading the above rationale, I doubt the usefulness of this
feature even more.

Shouldn't that kind of anomalies be handled by compat/ layer to make
their uname(2) emulated, or allow get_uname_info() to be customized
at compile time by platform implementations, to yield more useful
pieces of information instead?

That way, we do not need to add another mechanism that lets people
spawn an arbitrary command while Git is running, we do not need to
worry about security implications, and we do not need to worry about
people abusing the facility to throw totally random and useless
garbage information at the other end to make their stats useless.

I'll skip the overly wide documentation changes.

> diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> ...
> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> ...

> +test_expect_success 'test capability advertisement with osVersion.command config set' '
> +	test_config osVersion.command "uname -srvm" &&

If osversion.command configuration variable turns out to be
acceptable addition, I do not think we want to use "uname -srvm" as
its value for its test.  Do you know for sure how portable srvm is?

If you use something like "printf ' \001a\011b\015\012c '", you do
not even have to worry about how portable srvm is and on top, you
can test your unprintable-redacting logic in the code.

But all of that may be moot, if we take the "fewer customization at
runtime" approach.

Thanks.

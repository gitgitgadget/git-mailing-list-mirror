Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BA2CCC0
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859134; cv=none; b=LK08KP1g1n245vLg++lZxSM0kaToB0nx6tfXQI2tyuhp+DiMn4dnE7+1GNSKLRDRiv8b8u8+p2qeBeA8kpBXlbf2mv372c/24ZvQqovi42DEcpV3T0wtk7nrXTL8Rb78gWdW2Xyu8FIi+s/Ze+7QKMKqAdDXP7WFWUnn5jPpGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859134; c=relaxed/simple;
	bh=O6VIHf3kZLyNT1wqm97sFJAGj3AjCs7IHwRMB3Y9iyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jo+m9CkoB1z1HfXHb+bjP0FIBZpkO1NKzA1R1y1IdgjRwkcpATgc5VAsBnFsAwvu3yMhVxXTibdrXl1bPseBZUCzn2pCY9r/vZXSPODZUyVLuBHz3HK6ZWFFP3+8sr82Eev6hS9aF9thsBYsGpqEptmfJ6rTH5H2oz7DFkcPLo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b5Mty0+I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbVPa5cV; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b5Mty0+I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbVPa5cV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DC077114021A;
	Mon, 28 Apr 2025 12:52:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 28 Apr 2025 12:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745859130; x=1745945530; bh=qau3fUXCuq
	aSz2PEcacZDAs/7dW9Nwy2J1cCuHgw5Ho=; b=b5Mty0+I2/ELN1Emc1WMf3N9io
	dFGFFJRKFn0FKK0AtF2Vux8+4Gj6FP9O8NUqeKRdSyxQY4t0fVSV/vkJb/50EISO
	Moqdtlly1lPHpsis6o6hMXSt+KoAbXIrM6alEo5QByjjuLqp7CYm5NG0DH2Hzk18
	4ajLxf0WhJB3ierC9AgQNkbPjmEAx2zi72azrr019zJ4VsmfPkr8x1qq80thGcVX
	sZtRUnbwW/W+lu6QOWTeSMX0h3oe/v+BqoQx5uXGQ6CH3e8jy3BufREJAOfAA76c
	n3pvb/QphayFyA/mbAobI4EYJYnZ6djP7a7CoiVY3X4RDwrWYw7rhZO2DArg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745859130; x=1745945530; bh=qau3fUXCuqaSz2PEcacZDAs/7dW9Nwy2J1c
	CuHgw5Ho=; b=MbVPa5cV9CiAPYf9LSJ1Q5ij7JfO9SU5rNXFyMRT9ssaS8lpkr7
	5laDDsdikL3qncNwrrx1TB1Qu6NNilfhGzt7uxCIBL8sOoEc/zeV02UbIioKZWcF
	WDStlC3zBbGR1fl56+YDnXR8oI26JTHsj954t2i15jFHcMaJ+OD+2xiCVIKcFQLP
	sFKePOCOvYLJp2PTof7vlKIAeymXNaF5EUzyb9sFNUIo/zI5yQPAuJjVw/RqHqAL
	j6k7ice9xf6QP78F1EdpN7MvpYE/o7KV8jNAdeSbCSVCtBch9VoC8SbO4PGnjYEd
	xovf1XrNq+5giZ54YXOMKzZC39tcMoKxqlA==
X-ME-Sender: <xms:OrIPaDq_869oqZDkhycyfzVCR_KUST75nwj19dIPYJEwmwySQ31Wkw>
    <xme:OrIPaNqjBMZYMP-w_9AsYlH_oDQ4b49o-vYM5po55l6r-LZ1cfRikRt8qUNhkv_wx
    xxQwGNPEfLUOlLu9Q>
X-ME-Received: <xmr:OrIPaAP4h4vlYWqwj_mgUzhay__e7SuQRpBQwM2C1SqME02pymDIEetm7j3QfmXl73dfxhDd7enS9aKjrhJgER_VPzOlAjFMutEX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihht
    higrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrg
    hkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhr
    tghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepgh
    hrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvghh
    uhgvlhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:OrIPaG63XhMLOJqw8bzjDtCFV8hpVhGiIUCQyZPPCycvokxRkJvQcQ>
    <xmx:OrIPaC6yzBHqH69XCEWztt16T9X9kugfMttaPyRwlMlT8uHFyhfh8Q>
    <xmx:OrIPaOjNiyPQKYb4IELTOnKOzTQgR5EPAxH6Wd2ZiNo5DLKCXIWV1w>
    <xmx:OrIPaE6tAjIoBGB3kx6jo8-08OEupaaDxSoc2szAeA0_gu-11MYdLg>
    <xmx:OrIPaKpQs0hYnm0C06RNT-QDEtKKWZEt1WhbZ49jtun9EJ9efizY4sDI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 12:52:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Sat, 26 Apr 2025 14:06:59 +0530")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqikmstatc.fsf@gitster.g>
	<PN3PR01MB95973B932F4961FFFA9786CBB8872@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 28 Apr 2025 09:52:08 -0700
Message-ID: <xmqqfrhsdy9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I tested this patch and it works well. I've added some docs as
> well and it now looks like the one below.
>
> --->8---
> From e06ccabb5a0cef100e50e2b9d6d3c0a1769bda59 Mon Sep 17 00:00:00 2001
> From: Aditya Garg <gargaditya08@live.com>
> Date: Sat, 26 Apr 2025 08:25:25 +0000
> Subject: [PATCH] send-email: add --[no-]smtp-outlook-id-tweak option
>
> From: Junio C Hamano <gitster@pobox.com>
>
> Add an option to allow users to specifically enable or disable
> retrieving the Message-ID from the Outlook SMTP server. This can be
> for other hosts mimicking the behaviour of Outlook, or for users who set
> a custom domain to be a CNAME for the Outlook SMTP server.
>
> Co-authored-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---

Take the authorship yourself.  My involvement is at most Helped-by:
level, I would think.

> @@ -290,6 +292,7 @@ sub do_edit {

>  my $mailmap = 0;
>  my $target_xfer_encoding = 'auto';
>  my $forbid_sendmail_variables = 1;
> +my $outlook_id_tweak = -1;

These lines we see around here are all in a section of variable
enumeration titled:

    # Variables with corresponding config settings & hardcoded defaults

I think this "-1" deserves a bit of an explanation.  It is neither
true or false (and Perl's "is this true?" check on that particular
value would say "true", but that is not how we want it to be taken
and we special case -1 ourselves in the code).

Alternatively perhaps we could initialize it to 'auto' (without any
extra comment here) and then ... 

>  sub is_outlook {
>  	my ($host) = @_;
> -	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> +	if ($outlook_id_tweak < 0) {

... change this to "eq 'auto'"?  Then the value would be
self-evident.

> +		$outlook_id_tweak =
> +			($host eq 'smtp.office365.com' ||
> +			 $host eq 'smtp-mail.outlook.com') ? 1 : 0;
> +	}	return $outlook_id_tweak;
>  }

Somebody in the near-by thread mentioned that we could enable it
always (and if we do not find a replaced message-id where Outlook
may place one, we keep the original message-id we assigned), but I
personally think it is a poor design taste.  We do not know what a
random SMTP server implementation would do in that response, and all
we examined with any care during this discussion is how an Outlook
server responds.  Once we find a server that gives a random string
there that is not the replacement message-id at all, we would need a
separate knob to opt out of the feature---so let's not go there.

Thanks.


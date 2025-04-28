Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADF6A33F
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873245; cv=none; b=rLHi1ohKW9OVDbEIIZpRDFFx3BVGT+oV/tTw7s/JcwpoViNY6Szy8EwnCBTQS+9c1pNUBmIlExpla5ioMLTtoF5H5k032hhh/DT0yz0hoPCbJKBO92kDDLdQXWzjGxxSTrcbT/JH42X7dL6V4sUv5TpQszcR/P7JjZZ1ithy1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873245; c=relaxed/simple;
	bh=ip/dIbf9LBdTnf2K7lmA7ZQALGrBC0tObEP4vRGIgxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSsU6fG2ptVasQ+JS2E6aacrf8iNwXt6R7xfY1I34Snn+shfxS2uL+OgxmZOZuJsE4Mcvaq4Xt8pUrJoROzite/kV4Uenfk8WhigD3vqIM+MdXFzr77dO4DSxqivpJdpYzeQdWhAT5qbV+lZkshvE0T1cQc5N7PFILJ/thgZknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XSH19j9X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHkJ9bu4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XSH19j9X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHkJ9bu4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 402F1138085B;
	Mon, 28 Apr 2025 16:47:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 16:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745873242; x=1745959642; bh=1WUIWph+Xb
	LcbGRGU6O9+twF4m/2JH9NTGwe7a6QXjU=; b=XSH19j9Xawog5Mhp7WrenvQj3G
	KVxw4eVhV1s2L+Qw14xj5loC+OIptyntk17gRaWvvttFgcAjKaumYGybgRa7j1P8
	6RdtxSC3qQQVdU0ypEsGf1oahZKv6iol+8Nrz5E/mIc7F3nhfo5gVYlI5uRXMQkx
	Gvhzbuc/DlVQtM2XDEToqzpS4v8xruF86KgAIgYC/PkY1duYSkJevEShsIBqeeZy
	P1JqYHxRqQb/v3Q0SHCTbf6hN45ginZz7NLCLlOnti2srf/rSiHdmUkXhhh7yRXw
	O9IlLqlizJVEquxgjpw6ZWOqtrxCKgfE4Qs7gcNr8FqI1CKW4DOOcsUKUk/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745873242; x=1745959642; bh=1WUIWph+XbLcbGRGU6O9+twF4m/2JH9NTGw
	e7a6QXjU=; b=uHkJ9bu4uBoS4hrSsSPyEgvtK3+HK6H9h77lyZtxQaisVXLRIxv
	yVqaLaCVjL85otfU1fZUOzqRH5tkbotjMM9/Oy9Ng+ysbwovTMnwHpizzigHsSy/
	SAxvQypX/MQLqOXZgWjp8j0pEaNOQXlgrqTgclPHl1+qXfDym/Gu5I9l5DSKth+x
	Ztx1zk4PpXq03C/RmIQVljrbtF015XkAAJs6LcuVFwIbshgWsxwZ97ql8ZTolHhb
	9GiA45RmFhc+U5xfCm5C0/yZh3dPn0l6/pp1OP0VaBoR/ZHCunrKRyBOCQxbQR4n
	TYnnR18CpadB71Lmp68lUrZlYNZJSY8imFg==
X-ME-Sender: <xms:WekPaGTE16d7T16jB0TKrcziuPAkttKtCf_kWEwx-HYtT9GUicW0Fg>
    <xme:WekPaLySdl1u5zGMpiF2qu_GVvskOa4q0xQ1TAcm2OztDhUViF83flpi189BEFKnm
    ZlvCovHwn2wHkM6tw>
X-ME-Received: <xmr:WekPaD26AZiM-vwIo-nTYyOOQIJ8psvBsSabkWCHolcjBhWGIdE12rAcXpOwgTIVHb5eIS7cBgwqpKtEwxNC44grIzzbVvQk9NKf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihht
    higrtdeksehlihhvvgdrtghomhdprhgtphhtthhopegvhhhuvghlshesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epjhhulhhirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepmhhirhht
    hhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepfihirghgnhdv
    feefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:WekPaCCGLiFygs1FsYwd1N-TJl7qHjuI41y_4DmJDfJlaBvGRei_vg>
    <xmx:WekPaPifE4_7VIysECcjrkGgUk3Y2aCf62kH8BY_OtxBsDv67nwlLw>
    <xmx:WekPaOqImpaXaiJ0gDjjHMKF97nk3zcSNNcx7ztPMPQ95pMewEKKrw>
    <xmx:WekPaCgZJI2fPr5JL9UbmrRgKJqJ1tsdKoZDXcQfxFlvx_gsTyfIug>
    <xmx:WukPaOyWvU4tjZ2NNVY1acJUtUkjt_kNh2esXxPd9YN8Bc-tFUDUi2y5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 16:47:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: ehuels@gmail.com,  git@vger.kernel.org,  gregkh@linuxfoundation.org,
  julian@swagemakers.org,  mirth.hickford@gmail.com,
  sandals@crustytoothpaste.net,  wiagn233@outlook.com
Subject: Re: [PATCH v2] send-email: add --smtp-outlook-id-tweak option
In-Reply-To: <PN3PR01MB9597D897A65B4B59BA6FA93CB8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Mon, 28 Apr 2025 17:57:15 +0000")
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D897A65B4B59BA6FA93CB8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 28 Apr 2025 13:47:19 -0700
Message-ID: <xmqqh628au94.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Add an option to allow users to specifically enable or disable
> retrieving the Message-ID from the Outlook SMTP server. This can be used
> for other hosts mimicking the behaviour of Outlook, or for users who set
> a custom domain to be a CNAME for the Outlook SMTP server.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2: Replace tab with spaces in "outlookidtweak" => \$outlook_id_tweak,

Good eyes ;-)

> +--smtp-outlook-id-tweak=(always|never|auto)::
> +	Outlook servers discard the Message-ID sent via email and assign a
> +	new random Message-ID, thus breaking threads.
> ++
> +--
> +- 'auto' will attempt to retrieve the ID from the server only if the SMTP
> +  server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
> +- 'always' will attempt to retrieve the ID from the server irrespective of
> +  the SMTP server being used. Use only if Microsoft is your email provider.
> +- 'never' will disable this tweak irrespective of theSMTP server being used.

It is a shame that this is not just a simple boolean.  Those who
expect 'true' to kick in would be disappointed to find that their
'true' means the same thing as 'auto'.

If I were designing this feature, I would rather make it say:

    --[no-]outlook-message-id-fix::

	Outlook servers [DO THIS].  Giving this option reads the
	message-id assigned by the Outlook server and use it as the
	In-Reply-To message ID for subsequent messages.  Without the
	option, connections to only ... and ... automatically gets
	this tweak.  Pass `--no-outlook-message-id-fix` to disable
	the fix even for these hosts.

and make the implementation behave that way.

Note that this is a command line option that is specific to
git-send-email, so I omitted "smtp" from the name and instead
replaced 'id' with 'message-id' to make it more explicit what
gets munged.

But I do not care too deeply either way.  Let me queue the patch
as-is for now.

Thanks.

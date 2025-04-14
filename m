Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096511EB1B5
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 22:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668688; cv=none; b=tx1NGl85l4PZEB/ZjSub98yw7hnhUo/3j4dhYKfcBkRlDTbF5hc30JGICunz6YfzZjKkeWHCfic0O7OBrXPmASa7Bd0UuohDNRLOIunoFGpBFDw9z72QUD2wWVWa4v20Vi+/QvOPmzDKtsrB+k/gcntt1kYu4yJt6EeFW7nx6LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668688; c=relaxed/simple;
	bh=RqBb4AvfDDlc/YFxNt0b+uTAFgxMcTNwLuS5BOD3Zwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lengRikedYdClrb5YVnOuDUi9+z5/Y41y1fEb8WOcQHiJgjmBybHcndaJernyhadSbVzIk9MqI4vzKbf15ODCse2EkaLcdMMthzic/KgRvAqP06sbfq8ztvxBXBR1flHz8VaHq+2G80gZ6hYiJM6+4O2D8v1UuzzD3ms1gU5tI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a3TPKd47; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=diotk8qZ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3TPKd47";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="diotk8qZ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 044D5138052E;
	Mon, 14 Apr 2025 18:11:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 18:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744668686; x=1744755086; bh=uBCStdzBw9
	7b4r8Cd3v37koQyBovKERE6hPPPE25cK4=; b=a3TPKd47KMI05tJYT9ZftZng3e
	9NgvYtLv/OibHgAtLBafbqAf8ucU/fCrFNKheuKmDiIgSXUr4SAgRpcJZ5lQY+7E
	GcAo9DNFZZr5EH8Jh33q+iY3lnR2qGLMO493mFR8YSz9TzZcHWUUX1pCBnf7SNYJ
	0oLbvFOA6RiMMlP71ieNz+oJxo+O+VKbJ7qxr8aBWXnisduHkYJ6qovO9HmYJSOB
	eOzoQsQ4yvV9/RuCsGl9G31EqTg0FxxJFXuCBi3tnulaml2Ahx1mkyOpUvta1fX4
	yS4MoxgCcnnNZZSBTMmc9esIZHQtjRPBF3C9CnDtFzDEwFYMl28LNKt2mfVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744668686; x=1744755086; bh=uBCStdzBw97b4r8Cd3v37koQyBovKERE6hP
	PPE25cK4=; b=diotk8qZKeZlk8cIZxF25dqMNKHZsdEPSBA86coTOmSysnEbo8g
	WmJa86nxxrg+OMNZ5MFi2u8dWFM2W/9BTQN8gDKnmQX6U1bBoHe1jc7g2NHmJkEW
	NvLoUsM6SvbJEvD6GyBRPIi/yeTABXzlRbFCPEulwH8RHRWRwmFx7u25UnZUDX57
	FLgtZHfY3Q0B5wF/zkcnYlqzT560x8pQsCu2L+cGc5RvcuytWmIhyP4k+iuK1R+v
	VFz4yJSrvqivXn0JG0WarvC14QHG4NgO0D/6url1vuNkqsPsSrxxezLeR3VqERzN
	hj6ff5/pZd1NYY4mVfsGWOwAS9M4XAK7+xA==
X-ME-Sender: <xms:DYj9Z_QHOtymm8RlTv9qzZK_NLn4oCra1x1MfQj-oGBiatQfPUGzNw>
    <xme:DYj9Zwy3wByWVPmODXzmaLuNucjYJ3yh4m7m2QNNxf8FbBKXWeIC6etXkRgV64l1M
    ui4gDjJzB_NsNkRJg>
X-ME-Received: <xmr:DYj9Z00Q84ASEBFL1sUW7Mej-p5tS8_1wzMtvwISIqnFlTUXxZtHkLwsu_FQ0-y1GsADegQ-4Cp7bl5UvXbbUsbpZG9bIvBQt9ZR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DYj9Z_CKAlpwQEbclP6uNseF7eCFUbJau22vgGNx0YpwStLiSiZRyg>
    <xmx:DYj9Z4iMbA15r1DnxVtkmp03xWF8IFGRty3DfFJamE3LWFBUU55dGA>
    <xmx:DYj9ZzqiwDtwwGnzClZewcsS5DjW0OIucU99ui6FpFPUwqufpFvtNA>
    <xmx:DYj9ZzjA2s5ig6zfWHxdhQW19Ei7zTHE_WOXEQvkh1m-idBqw4ZJ3g>
    <xmx:DYj9ZxGIBM2KRJnyUweaKipq7DfH4QPM1TWWv3Q4897jpkRkee2hupt8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 18:11:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  toon@iotcl.com,  phillip.wood123@gmail.com,
  ps@pks.im
Subject: Re: [PATCH v3 3/4] meson: add support for 'hdr-check'
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com>
	(Karthik Nayak's message of "Mon, 14 Apr 2025 23:16:01 +0200")
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
	<20250414-505-wire-up-sparse-via-meson-v3-3-edc6e7f26745@gmail.com>
Date: Mon, 14 Apr 2025 15:11:23 -0700
Message-ID: <xmqqy0w2o0l0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +if sha256_backend != 'gcrpyt'

That's a bit unexpected name; relative to this one ...

> +  exclude_from_check_headers += 'sha256/gcrypt.h'
> +endif

... I have to suspect that it is a typo?


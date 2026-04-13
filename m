Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50253B47DD
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095300; cv=none; b=Lp1EYuLuX+eWtuA5HZc5eeSxuTdHdT6c8iSSOQRsqlHsvHr/+7Tmcet7A0MceTIhnG8BD5XRebwTg2f4iXacAYPhgldSt0M2u1/Ub84WWQTAmbkYJHP/7Ul9F9ngbF7RjonuxqBE2GGFNnUYSY7F0ya9mTLhPBN6SRtma5nyC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095300; c=relaxed/simple;
	bh=WcKdj9H2ePMbrvC+IxKxjNb3OrYrfk0pr9a0z+EypWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y62+e7Oh0sBM8dICnv2ZZI8K4wZBvjjRWtdhCzOAZVtsZv478lfI+IdmEWFJBbXYtjpDf3LLIH+y+/YczuLJxTcrfyhKZBH62bi2ZH/K34C8b+S4j7nLNzL8ZWtp29H+gZ8r5nfnuFT5726FmOKTYbbJM/LV7vyR6hyySRUaKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0uzq3eOB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DiFv7o0s; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0uzq3eOB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DiFv7o0s"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A3CF1D001C6;
	Mon, 13 Apr 2026 11:48:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 11:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776095296;
	 x=1776181696; bh=WcKdj9H2ePMbrvC+IxKxjNb3OrYrfk0pr9a0z+EypWo=; b=
	0uzq3eOBmnCTmd499ytRCoau5DamidwXec5MUucqdiMeeBKDS/5P+4Ra71WNyhHH
	IH1FEAEzXIuRNHRSI8n5RkwOxlTI4RdQDSTc0siwv7S3yhrHjBYC3UZ1g7ey/qYs
	F73wYvk/kZlvHv66YA6zeVdAxd4fF/xv2gAXFXy6hy39FSHw77R0LdeY/8Lkn0Wq
	Zw8yXl/H1ETETuTGKQkLN9j7YXJaexm+KgeCJJgMVvwQSizx0NGnYhOxS3OlNoka
	3QVd441F5xbywxYDvURyBLCjE5zZDoWARYwL+yy0LivulK9h1E+/Jxokda2Byxw9
	zbu7k02XQbhLp3I9EmuCNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776095296; x=
	1776181696; bh=WcKdj9H2ePMbrvC+IxKxjNb3OrYrfk0pr9a0z+EypWo=; b=D
	iFv7o0sqkGWSSpD618EmBsdyAQR5Hmkssnuaz0Im+YgZFlbWkxWDGy6G5VULaSpH
	TeZ4S4PyGzUg4GSsmUHFyPk8WlHuBislaZ0isQCkF9x+rIh2C67o3riUkxnAOTuo
	+SxkEdQbfS2igE81TpExp4TuEUxFOfWYlseDOcs2hsKgiTVBAVQGgm7OMLEYMdFe
	zxzQd0eK1emDsCygmRS7OffGab0Q+7Cf90bS/3XTzGveIBjSOOM1zLil8ppN1Npy
	mR5ds+LD0Dw7y04ddhPiC+AXmd5wQk2AlmZo5WMqKpKEyfpBTKbw87eX0ky1Wpag
	4w9dOAgxgjTihnbBO1DcQ==
X-ME-Sender: <xms:QBDdaQzsE3Y9bWeArLWK85x-jfeNUPhzVkW5upvcuJnaSkrTO6u_wg>
    <xme:QBDdaX-KDycPPr8RjTycGyux2aclHo6jid0YKUYDVTePadPduwCtqTm6WxWMPzFVg
    kq06eBr29FuKxhP8vVeX2KZv7jxRhQh0hIVEkY--QgEcA_3LH-qPA>
X-ME-Received: <xmr:QBDdacJs468n62aUIJpqZKXqVW6lp5GxoXz4GZI3jd36Gr_ZcTKdPmn3KzoqMwngakSOyUCdLr_MU3_8yuHNS06BKWzIB91sOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhushesuhgtlhgrrdgvughupdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:QBDdaVcKUZpdOABe2BitUXEk_8No9_snOdUD7jvwztrF_t8ALKF-9Q>
    <xmx:QBDdaT9gdeQ3AXjY-_C83lfA-QpMTjAOBn8nam2QiBdw7EEQu2dUtA>
    <xmx:QBDdaaqztqXYjMxWALrNoktb2GQ5Hz5ayYBVlNKSWNUI9XhlTvInBA>
    <xmx:QBDdaQCy9c4IhYNQn8iAWHgRNO4irTN1u9DRSgJtogmCM5WWHxIwgw>
    <xmx:QBDdab-7FXgjTMFEqH4JCU2bgglvlr_cQf3fUbAqo-Sgvo-S_x2Zal1y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 11:48:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Christian Couder" <christian.couder@gmail.com>,
  jackmanb@google.com,  "Linus Arver" <linus@ucla.edu>
Subject: Re: [PATCH v2 9/9] doc: intepret-trailers: document comment line
 treatment
In-Reply-To: <5302cfb4-f2a4-48bf-98ce-98b74e7a6568@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 13 Apr 2026 15:26:36 +0200")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V2_CV_doc_int-tr_key_format.613@msgid.xyz>
	<V2_trailer_comment_lines.61c@msgid.xyz>
	<5302cfb4-f2a4-48bf-98ce-98b74e7a6568@app.fastmail.com>
Date: Mon, 13 Apr 2026 08:48:14 -0700
Message-ID: <xmqq5x5ulv41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> [PATCH v2 9/9] doc: intepret-trailers: document comment line treatment
>
> s/intepret-trailers/interpret-trailers/
>
> Didn’t line up

Yup, looking at [0/9], I agree.

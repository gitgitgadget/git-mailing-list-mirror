Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474C1DFFD
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743276410; cv=none; b=g7nXt/SbmttesKBcivDfZjjlhn576ROF+9SsjqSmqJyb4TghcW5GFR5dtjl40jgEhsN+cjt0H+h5fYV5L1B59PiWx9qTzk6RUjbF+rZlfJ88W0JYaOzsj/l+iWa1ft85B6ukoP6ooHlEG47Gkkh7savpqqDf1EAH9bYFAcsGATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743276410; c=relaxed/simple;
	bh=xm0FQDD8rPP1malpSR38rc6EVu0ycBhmU4PBfE+T3z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILcGdk/nM0KlxokJKRCLby3cKAPsiLW905fVpZWNC+cjEDlxcAllV78/nKU275xYt1Qt7EkKlgGHZz5K+OWiCuKMjgjNPpco+oztsGirfODkpnvQeIaLLjcU/oOKcfqKNjhaLqYEzNMRONAc1JSQpvNKl94uWTdfooXfKwEPEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DjcL3Itw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMJxoz8j; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DjcL3Itw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMJxoz8j"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E7E6D11400A4;
	Sat, 29 Mar 2025 15:26:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 29 Mar 2025 15:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743276406; x=1743362806; bh=zHsc0CN5QF
	qF+lcReTj7axOcQKdwsQN0ZloYj9kyF7M=; b=DjcL3Itw7w7ycuLg2DsLJwoKEu
	+2afLfKiEenN+z+lMvGTwRY2edDx67HwiV+hW/6A4KuuvgdQpFIaItjIG9kSCN97
	6V2oOyiC1pOSwnCYn9wEK7pwUwqtP1Zud0/eVJ6P8paePdfew7fRsqIBmhXxcAbS
	oq5sVfRcVvPeZOfONFU2RhPW9/sC8W1gIiDrfvSK6ofyfgnHAJkBTdx2YCvFpnCE
	VUD63H5PpUj5s1xiWr7Tm/39sDfcRaLdblMc5weqI5S0w8wL0+duesWOvpYwQmeD
	RMofdiqfhUi+DGMx3NTIrJwHdkcgEF9RxAL8Es5lUUfEmsCj9lqT9PA+wnzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743276406; x=1743362806; bh=zHsc0CN5QFqF+lcReTj7axOcQKdwsQN0Zlo
	Yj9kyF7M=; b=pMJxoz8jMuVpo5GNzwcSxXn3Svk9KiJlAlhiHYkBbrBU6u0ReNR
	q+kDt5QvZbTavokrkT63fyGrRlGTGZvU3NaipSr8Y87Otmy4CWSTW6L4qTTdk/ID
	tUxcbTBl/0xV+j/xwwW3qYwwcO2scQiSl5xDyzVZDAvkqLE2t7Hf8KWLWs/KmqRz
	2ON2xYPY9q5+KZz6W/k1R69olj/v04pYa7cgLA32HrtFlSNLKpY6P+Tjfh0FJAw6
	Aqn0NnX4Bh/zmba732OxdoPnATlr2cTjlX6xVM7HblSDYQyK4w0mjNp2L+xcFXH2
	ZTFo19H23bQgq5HaP25It6BJPkbOl3uJEXA==
X-ME-Sender: <xms:dknoZ8ruL6vxz-JZwAQce72pMtgeGvbRGWtpgZ9lJ-XNsdZxT9Zx2A>
    <xme:dknoZypEIIooqALu2blpWiRsivWCj3LVMfAX5PV64OkJ8RiIW9CfTQDhgLYoI9Yh2
    BH8afNrMVbTQPiLTA>
X-ME-Received: <xmr:dknoZxMaEwdAPKtPBeseUyqI6MBVBdyn3q5blVsUaEv6jC_u8xNCauurUL5__yGFgqfvYInW_eFFhHdWnZux4bPXqv9g4qBuTIHvIFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeehtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughhrghrieduhe
    elheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehlrdhsrdhrseif
    vggsrdguvgdprhgtphhtthhopehrrgihkhgrrhdrrghthhesghhmrghilhdrtghomhdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dknoZz6Y9vQMezlcShz8MI7yJDQdHkDmQIPVssG_rX33caF3Mvq7zQ>
    <xmx:dknoZ75KMjP7nplo_SL9CDexTzULX3i0YJyh1UnpglO0IhuoVVe4Mg>
    <xmx:dknoZzgjnyf9y_fg3f4n7QbRfQeV8rku7V5xdMf98uKZpEP3GNSX9w>
    <xmx:dknoZ17go1L_e30eTetxkeo0wkCRF41NhzCPWttICwR5BzKcZ37_hg>
    <xmx:dknoZ4FE-ngItdZKXkDb5whc4jfPGeZsc4TqUqMv45jsTLd2at1TZaVM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 15:26:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Moumita <dhar61595@gmail.com>
Cc: git@vger.kernel.org,  "Johannes Sixt" <j6t@kdbg.org>,  "Eric Sunshine"
 <sunshine@sunshineco.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  "Atharva Raykar"
 <raykar.ath@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 0/1] userdiff: improve Bash function and word regex
 patterns
In-Reply-To: <20250328200525.4437-1-dhar61595@gmail.com> (Moumita's message of
	"Sat, 29 Mar 2025 01:35:24 +0530")
References: <20250218153537.16320-1-dhar61595@gmail.com>
	<20250328200525.4437-1-dhar61595@gmail.com>
Date: Sat, 29 Mar 2025 12:26:45 -0700
Message-ID: <xmqqfrivd4ei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Moumita <dhar61595@gmail.com> writes:

>     + ## t/t4018/bash-bashism-style-multiline-function (new) ##
>     +@@
>     ++function RIGHT \
>     ++{    
>     ++    echo 'ChangeMe'
>     ++}
>     + \ No newline at end of file
>     +
>     + ## t/t4018/bash-posix-style-multiline-function (new) ##
>     +@@
>     ++RIGHT() \
>     ++{
>     ++    ChangeMe
>     ++}
>     + \ No newline at end of file

For these new test, is it essential that these sample files end in
incomplete lines?  In other words, are these tests trying to make
sure that the function line is correctly found even if the function
body is at the end of the file that lack the final terminating LF?

If that is what they are testing, please add comments near the
beginning of the file to tell future developers that it is essential
that they keep these files end in incomplete lines and why.

If that is not what these tests are checking, then make these lines
complete lines instead, as they waste future developers' time making
them wonder if there are valid reasons why these files must end in
incomplete lines.


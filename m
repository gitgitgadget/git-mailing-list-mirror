Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0A26290
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958367; cv=none; b=d4wb+gx+CtWPRZqqD3exFSWLeoiChRqwJB2iy20zu+sWxWP6ky8Pem1fWhd1G1S0PU5t7mS0+0eODfgbXqWrCalGczaSnEDnWuhMO0rnjMZRcXTRWbxw73h0k92JwgiE+X7xTliAJUNRDa+UHcbAGWetkA7QDI/inZ5Z2GzeIC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958367; c=relaxed/simple;
	bh=8QnJlg/Mk20Rd+E+1RnZrEc0T33oJ0vq1w2ciak2OhQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lE6IVNq+dE1NK1jWrqmvGttkEJbp/TFo3MvDqI0U9kgLVpuHOt6nRg7Uq0B8mII0hlgKUkW+mMiq7iakM/rhd6z6trJYXygZGzz23HzCUoHuzikRiYpP068tkb3OLNf2oibvNtob41QPuonIe/vX02LupzEaU+ZtBWAKWs6rWYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PTGRjEpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U/xVRpiz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PTGRjEpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U/xVRpiz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AF9E1140178;
	Tue,  3 Jun 2025 09:46:03 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 09:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748958363;
	 x=1749044763; bh=g7TwOU+DJ80r72WncPmbJY1LQM9q358mmJ/lWUG16Lw=; b=
	PTGRjEplO8IlOJeFrrcf0b0/3imbiIzXYLCn2N+8LoaIb400hjwqZSk+y7tZ7lHu
	VFOKEVioVcHLeEdmCzNvvWvd1G16cLDYq6+q4Pu+maxMx+Qpz5S5n+SFkYC+wiV2
	mWs5fJFjc4L6zaYFSzRPMGgN72B0P2UYldRqmSKQz66Idi2xTQ7wHn6WgWvTa2nn
	420hZN0v84JwGfT6oMqDaypmphJUOtWFNY822AcKo7tFEaqv6zYZOP/4w3Z1SpE5
	6GuoxeIrTJPQHcHXc9J+PZkNSDCCHAkY6e43qTwbW7W4y6wf5tlU9SbYmaarMidD
	SMk2HcLUKubkPkrVCcOovA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748958363; x=
	1749044763; bh=g7TwOU+DJ80r72WncPmbJY1LQM9q358mmJ/lWUG16Lw=; b=U
	/xVRpiz1Uurf5+U3uS7PdaUg93SLtptNsgZIQfxSi78FhCcmouZi/F2s352uRS6h
	HxNwGnLS800n/QgOZYoL1Gk7OBPqFswD9on+zuVilAzVwfMtHwLPis2hhMz+b8nX
	JF2DHuR4qYMgTwfHTqXy6ciPnvH0FKuJQxHdz48O4qOKJJHSpTROv3JSHerz6i2a
	uNPqnl9TrEWXTmS/MxXyhFSCvlDHbWwn6bqA3ljkoakap/5t0mdDO/mQKvGGSgCQ
	tJLu8V9ieMNwB64xpnOIMUnBGj/MWB1Yi/N+gYVyxAtq7i4bnRVSCS2M6ToVvCTd
	YFTlrpd0tbT6GuushUn+A==
X-ME-Sender: <xms:mvw-aCsnn5GA8tNm_yI6ByaQo_sHppFh3CG4XWNd-gaPe1Q-TQovKaY>
    <xme:mvw-aHdrjquPy4a0EC_XPUGElbMnRgGwS0rJ1DSa3qAvDv93T_tzuMOvypXtVQQwC
    wEMhstrQ8eA_llv1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeegtdejieetgefhuedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetff
    ejffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspg
    hrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhn
    ohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    ihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mvw-aNwDRTsrJfvwfJjDTK3il_1dzRiAbXFUbDrkf3-gFQ6ZLpPuUA>
    <xmx:mvw-aNO4jdnwUCHqKlhClXB0Ia8yDHuQYLl-2VevHhYnRoBOFieEZw>
    <xmx:mvw-aC8ILY4Oj7bjEKmHE0ShQgPSGymmvdApcFCbO-ZWKyTfCgGf9A>
    <xmx:mvw-aFVSwcyDtOcyjbL7PLQGq3CC1CsrJAFDnmS1TpO19fJZwLpJZw>
    <xmx:m_w-aN9OU3tEVgSBRdAjfcLm9TjPdltGLT1vnE_1vIzwJIoDhY-XohCi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDD051EA0060; Tue,  3 Jun 2025 09:46:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tbeb4c5dafec16daa
Date: Tue, 03 Jun 2025 15:45:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "Yonatan Roth" <yroth@paloaltonetworks.com>,
 "david asraf" <dasraf9@gmail.com>, "Emily Shaffer" <nasamuffin@google.com>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <8dca137e-04a5-4609-89ca-c89c31ce2b2d@app.fastmail.com>
In-Reply-To: <aD7SoaRg4UV6ktJL@pks.im>
References: 
 <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
 <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com>
 <256e9e60-fdea-461b-b43c-8e6024b773a2@app.fastmail.com>
 <CAOLa=ZQTYTNiUhFW+kOqMro0rpWVTkyKop7az_6h7zgM8njRhw@mail.gmail.com>
 <aD7SoaRg4UV6ktJL@pks.im>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error message
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 3, 2025, at 12:46, Patrick Steinhardt wrote:
>> Ah, that makes so much difference.
>
> That reads better, but I guess we can improve it even further. How about
> this instead:
>
>     To retain the same error code as `die()` we have to use `exit(128)`,
>     which is easy to get wrong and leaves magical numbers all over our
>     codebase.

Looks great.  Just s/magical numbers/magic numbers/

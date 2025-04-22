Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575628F954
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337407; cv=none; b=SDSn90pVo+wB1SM4AHDfatb4SmqMiLPBtt+BsikcydIflHZLsfwnHRC+ze31JuMzuxbtuKLYEN0S9qby3i9c1hURSzA8/Y0GOw7sNuh4kno1m2egEuWsKr1+XGmbYAzBM3qrZTacZzIXmOkChgh3Vr1N99+H6Hpk2mXQrMtb1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337407; c=relaxed/simple;
	bh=yNr2oGS6iK+CJoVYWQbrn0j3q5SadvtcSjsyC0MJYgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aDihKNURmuNwq2XHrAf/cludTStFMXIBOY06vqvQEEGcVwtfJO7rFqV7cV7H7++V2DQsuFCjhs4fVmG4+MoOsW7+s3UP8ej+/CN8dEvACRI+skbUX+6TkbnaCv3NSDEda6VCEHdo4pE3X4TCZXgWAO44AbpF1WaHV/widiggBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cjXjDwNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnuvpAgX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjXjDwNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnuvpAgX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B75EF1380207;
	Tue, 22 Apr 2025 11:56:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 11:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745337404; x=1745423804; bh=CRwufZ0cAm
	qsDYhzEssgN81LZkAXFGS4RmWt+gbvN8A=; b=cjXjDwNFNxOnRrBGzIIgtalZQI
	Kv9rA51jTZwVEZBGrGpcQw+9GjtUB/lKt3tq4F6q5txWH6fAWqb993dyFJfzUf33
	1QCCkQKZ/n6me5OM9otztAC3Tpqy5x4vBkBPbbdzY40OOayuqCBZB6L0auBPUIjC
	VdvvCY5At+PJkFQsE59nMUhjmJo4q+xg76YiXpMB6HbvCbLwKdBI+5Dgidn82M4V
	Www/9T/3BUo1g1YnZ8MJl6OybXJbq31yFXAD0jhAcMeRt4H0Kyr6eun8A7K/6ibH
	QmyYtGGSrWorBdtlMFRCHnq6uJDr6c6Rp9/9xg2N0HtY8/dHzMbaE+nHbODQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745337404; x=1745423804; bh=CRwufZ0cAmqsDYhzEssgN81LZkAXFGS4RmW
	t+gbvN8A=; b=dnuvpAgXMogo8bj+K59G/CazPLTMbh4oofFsKbH8pWf2UlSsouk
	p+x+Jg34ptDYXoiotug4g1ndxFSUiNlQcjUZHSo2lAr+yM28WbfEybSQ1hcIEfiQ
	zM/6dcRESlyEU5CohxlDB/LQj2EmCFkt4q6XH42Xx1LBF211tEXqGNqtQq4B7Y/N
	3srt9G4DohLGw9XGXIwHebcGby9XzV959fdX128tRCfk3CN5f//PA05BxK5emxDm
	fTFJcSaCPS8+Nerispxsl0DcdCxvLNToDXx2HegnuyBeq1ePEh3Rk5t+58tEn0ZZ
	Y+vc1YCoSEgxEa4uAnThahPQBuRDJWu8IQg==
X-ME-Sender: <xms:PLwHaNpyugHPTcwEk_gAa_DtCMwMV05h_R5zL0P1Qr1K6sNfXS7xKA>
    <xme:PLwHaPregHRNePV_oaIdurzwvOTlgvlw5cHx6GTbpl__p1YD8nYW6vSjUM-wKARD3
    aGrwcclN0dEx07hNQ>
X-ME-Received: <xmr:PLwHaKPkC7XBbCw2luKyLGwicT7pAIWu50eZzhaxMnW29dpGo0Hs0mt0wW0-6k6HzTkYvMClHWbqds1OUb_i7LRaNnnOUEAhWywz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PLwHaI43oiq-kD0b3iLj9vVfDXEjuO2rKuYHe98rfMh9wmLqarYB3A>
    <xmx:PLwHaM7_Jnxr7ECkhEX_n2v0S1eqz4ZIxbmvICXjU-uEzwRpkCWlVw>
    <xmx:PLwHaAibPN0B7ODSA61inuztNRmWvD_ODI84KAdIQfxVGzj6BLJP9g>
    <xmx:PLwHaO7DFPQcf0WVDbebg0vBOkPmOf9XOmiupaPeT1RgzDhYXnHBvQ>
    <xmx:PLwHaPez8VlWXoxu129vnQm5jmhJ3-jOZIR1mvPG_QkehZSMahbUnmOF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 11:56:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <CAOLa=ZSSdp4KBHAviudJm=H+bP0aqru=LN2=4hsYsqyM7zLMgw@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 22 Apr 2025 05:11:04 -0400")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	<xmqqh62i6jli.fsf@gitster.g>
	<8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
	<xmqq8qnt7c9w.fsf@gitster.g>
	<CAOLa=ZSa-qQzi3iWPF+M5a4EsvGiQFX=2Ca=vzuqwSLWWXSw+g@mail.gmail.com>
	<xmqqldrt5bto.fsf@gitster.g>
	<CAOLa=ZSSdp4KBHAviudJm=H+bP0aqru=LN2=4hsYsqyM7zLMgw@mail.gmail.com>
Date: Tue, 22 Apr 2025 08:56:42 -0700
Message-ID: <xmqqmsc842bp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Would it make sense to just swap the order, then?
>
> Unfortunately not, this is a chicken-egg problem. The dependencies are
> installed by 'ci/install-dependencies.sh', which are not present until
> the source is available.

Ah, of course.  Thanks.

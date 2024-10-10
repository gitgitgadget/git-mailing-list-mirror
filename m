Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168C623
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518518; cv=none; b=fvFQCrAgw1tuGbFXNB/0kKywKET12Y6KZZYYAA5t1SKGnCF2yabcuQ6LZp+m//5Qtnf2TBn1acDuCBHBsZAelrKByvLGcy+ZY63ZhICVGBRDKPbX1dnLZT0yRrYdc9Xd/vCcNoObEsJo9bHztrb+4jGKl3/GqzAc4g5rnRnCN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518518; c=relaxed/simple;
	bh=0kAwW57r3hzDZA/EluqEefF2bhr1aQ45P7upypOmzac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdAkrQIj8xEx72Su8kn7nMVt42z2k5whH8DRJ4aUgAsV3JZNuVgaS6zCKba4d7df5LZo10IKCcHWycoEfDSAq6aAvFtslAasGh8SJimdxik0A5Ig6bOIc7A22zR/mE8qoGcyEi/7jaJqZfR3DovUTe3fchVuAsiD5tejvXntrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FrjQaEZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzCdSzW/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FrjQaEZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzCdSzW/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D69351380211;
	Wed,  9 Oct 2024 20:01:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 09 Oct 2024 20:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728518515;
	 x=1728604915; bh=0kAwW57r3hzDZA/EluqEefF2bhr1aQ45P7upypOmzac=; b=
	FrjQaEZeP/IQavlLAe5tVex7YQ60ovRHO0PI4oQGBHN0Blp1PEcdS9ChNjg31Dr8
	WNR3kSFPCnIc5KmZM80nIEJdLWLKCayQIInH4xCt1fA0i34IVoKf9pRQN95npM7p
	Z5UuDLX3BqaGYsvMWWOcB5e3Ujn0anOdfineBjh9Rc+ZVlpx94XLUPCME5Ha7sGe
	121DvTzCeD2f9T9k/0RF9LRxzVblHNWjkRWqKzwZGcK9y6t+0HmOBUQKvLQ59P9d
	yjstuTd3oyZ/75/Lg4GrluWUrkSzLvhcEHPFEYOuA02SLnLYO3bYY6Uje6tj7nld
	iMiq2Dw/TQeJHI00qDGoEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728518515; x=
	1728604915; bh=0kAwW57r3hzDZA/EluqEefF2bhr1aQ45P7upypOmzac=; b=F
	zCdSzW/ojrxK0ZVm8vZTflgbeO+kUURyIIrbLjfGM2I6GGJt4xYlazZIn7dHvWy0
	Xf1uRVvOniXQxIMEuxbe2wytuTvFKZogBc9/XHsvm80KFix3+AebVKdfNwgWXrlt
	/hBG9qt6YSIrLMmVgNWVXkpGmmLEDofRmy9iAU5g3ycOqQ2cRnEpIVopiTydo1HB
	C8eSu8fNCRfG57wxJR5OmcTVWKAVV2ANhTi4Ih78In22q8yGtX36T/yZL1xNYLg5
	L/IWPe1gi0oCzgfbxOfXF++u9NMNbccC7zx3wvuhr2fK9UeIuLO+k92fSMFBkmWx
	mBmpKy1Nq58FtCwj2fIBg==
X-ME-Sender: <xms:cxkHZxFWCaAICpYhyRg4SaoVLOTF_EdJwAgbTuPO9NEivBW3D2w0jA>
    <xme:cxkHZ2UH7-Q63WrmwIvqZ96wDM0o7FWINgpxa--TbccinmSLIr97wC0G7apKl9uFn
    VtnakCznS05PZa3Fw>
X-ME-Received: <xmr:cxkHZzI855jDpia5Gidj87BWW-C4yLhgt-ygLGENAVUhBsId2FSbSYH3hggBi4c6Sw0S41klzjWakg4HOy2Ct-5JGVRUvezvia94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefh
    gfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cxkHZ3H5hPmWQu-6yoa9nLqw6JHGIlmS3YRg6btX8pvwaBVBVt-sgg>
    <xmx:cxkHZ3V_KeTT_YcVSNN63f-xKcT9xddiFtaadVwAJIzcnQEOk-qMfQ>
    <xmx:cxkHZyP_8OTKaQQtR2n_XatyOWSTby91Az1wFgLHjSfJIH7Z2XSU3Q>
    <xmx:cxkHZ22ltwB7vJWdO8aezQZh0oys27YbOpL7hF1XCW-AEqaoL-MqmA>
    <xmx:cxkHZ5JhLMDc36l5RS-zl6s3kl10_WOw_dPx02BUL94Kloz7j5uV7PKh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 20:01:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 0/1] doc: merge-tree: improve the script example
In-Reply-To: <CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
	(Elijah Newren's message of "Wed, 9 Oct 2024 13:50:10 -0700")
References: <cover.1728413450.git.code@khaugsbakk.name>
	<cover.1728492617.git.code@khaugsbakk.name>
	<CABPp-BE=JfoZp19Va-1oF60ADBUibGDwDkFX-Zytx7A3uJ__gg@mail.gmail.com>
Date: Wed, 09 Oct 2024 17:01:53 -0700
Message-ID: <xmqqbjzsomfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Wed, Oct 9, 2024 at 9:54 AM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>> ...
>> 2.46.1.641.g54e7913fcb6
>
> This round looks good to me; thanks.

Thanks.

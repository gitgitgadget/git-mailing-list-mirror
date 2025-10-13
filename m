Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEFE24A044
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364429; cv=none; b=PULFwFFm5LmmhdTppB4rhgNTb+MH3IZSqKLm406lUATvFvEGaW4Q7Go7WQkcai7+dN54mATjzL658fIiPFpwCrs1ESw1p+28w8yJgIENtNWJoOG8KvH0WAh0BJMKV9PkpLYvYLNdp6DqaMP7CdZJDQRAPCIQ8y2kOCwhJt+lGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364429; c=relaxed/simple;
	bh=S4wwaSsxEi6vHMKZ9qTr5/BnMU7piKPBuwl7gWBdZPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUsTYz22NkMu2kZat/TB5+W0kGDCFMyZ760OldKUnDa6fofnFK+aZZ9TyroTE7kcurOrptgrUn4mP5BeU7muIJCKitoskGJegPdFPQ89qc2Gnf2zYNyEFXqfPHFuR7I5iOSP94lTcfGDy/G1zBdpu+qmWJYK/woBY7WbuO/FzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZRdufQOa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MKuJD+R1; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZRdufQOa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MKuJD+R1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6DC81400058;
	Mon, 13 Oct 2025 10:07:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 13 Oct 2025 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760364426; x=1760450826; bh=+up5yKb0E9
	iPQgvBq6/4HelSblpJrspjzjQbkYRmCPY=; b=ZRdufQOa7nmJBPDb4AWT/yJmp+
	+0L0n3xVEl00wAvtF5z8bjbIzC4HA7D0Hd3+V5Ajorizayl35EA4cpsj9b55+H/3
	2OfHXQ1eXnpR3Kw6bjdONcTc1StoaRlkDfHlwz4AvQhHQR2HeKCPNZa5BfeaCWd5
	trxiCjdhhcIAXe/iLjV3H3+/d+Kv7f2dMTAqzNNlq/2f/2Nq7gUd5OXgnahZEcZo
	6Tl8+xVd74EeWTvAr9pFhPh+TXsEfxuW03N9/84W+OL0ygRIxxjUD2EXRJNeokiS
	IJurIg4IT49KtXWV6L8BdnYnuwajbXWVhPOuZi+oJUzFrf4cN8GV3mFGPF1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760364426; x=1760450826; bh=+up5yKb0E9iPQgvBq6/4HelSblpJrspjzjQ
	bkYRmCPY=; b=MKuJD+R1lQR6HaXJiANW7QzErZbADaVlyEKq+7002V/bnJBi13f
	U/CRtwoNos4Z3vGo0c1bXzeAm7t/VZ1AwpqiIHYMIOveW4DGNoN3C39i5SdkQwOv
	h4PRdioeoDY9kHv3XB+vQLMyC5GjMQttelkV08c4Kl9bqfG4aTKulDT7xsta16z9
	/j2+DZDA68Ql8MhY2gr1OYZJu9fJPxUIUO+GtRNNp69qGN06VX5r6n4GLMVUu+X8
	TpLd87HzfhReGszEcJTDbBbdU8MpTTwsXWnYEX5l3Lmk3fO3wbrz6HMqnqSOu5NN
	m3X3N6XmFb91DAzY+VLraX8hWd89ooxujsg==
X-ME-Sender: <xms:igftaFtn-u0euloPqe-niBEqLU_Z2QJYqJ_oR60rVaqNkCRvOsWgZA>
    <xme:igftaF67LzCU1BwKLZN5z2pOamssiFrqmrcvLC8osbZ7KiTYmNpoir-oPMdAN_3Id
    K9VmTvGeKPrFXUC2-KPoWTykyqRkj5Wyoqu4PPn4cRfLLYds6dH2l8>
X-ME-Received: <xmr:igftaGJDz9lT8a9Uq7QFCE7-ELvLIYz2-cs6yPO2NHYGYvwTGfv1sJuPe3TUCNe2EXWUMTuuEQXP6h0lL2dyNvs4e7BAQaMJZ7jj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:igftaF5A7PZ49uSAmDrwruI2E7HoW2XFRB65ojeKF7E9h3Mu78v7nQ>
    <xmx:igftaJxXdakN1Gi7vB4KpLsb2PokA8ykHxNbJiWfuavfqjKAjqnuAg>
    <xmx:igftaJb2DaoLbrnHxqBwgrrHac5rjOnQptnXh2y3fw21MbhhkrRdIg>
    <xmx:igftaLTLl8eINo4Y4b9DCTAtABTSTtrEr-JrJxQnvJ97zhWExVMgqQ>
    <xmx:igftaGAw8kiIHbDdjvWx_RzMk_f0nCHmV1ggZq-MBKNcvBL_05-zGnM8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:07:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
In-Reply-To: <aOo4xWp2Sx-4QUUI@pks.im> (Patrick Steinhardt's message of "Sat,
	11 Oct 2025 13:00:21 +0200")
References: <xmqqecra71ec.fsf@gitster.g> <aOo4xWp2Sx-4QUUI@pks.im>
Date: Mon, 13 Oct 2025 07:07:04 -0700
Message-ID: <xmqqsefm520n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 05:00:43PM -0700, Junio C Hamano wrote:
>> * ps/ci-rust (2025-10-07) 8 commits
>>  - rust: support for Windows
>>  - ci: verify minimum supported Rust version
>>...
>>  - Merge branch 'ps/rust-balloon' into ps/ci-rust
>> 
>>  CI improvements to handle the recent Rust integration better.
>> 
>>  Expecting an update.
>>  cf. <aOdIRnB-SGQwj935@pks.im>
>>  source: <20251008-b4-pks-ci-rust-v2-0-d556ee83c381@pks.im>
>
> I think this status is stale, right? v2 didn't have review feedback that
> would require changes as far as I can see.

Indeed it is.


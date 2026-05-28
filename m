Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D81C3318
	for <git@vger.kernel.org>; Thu, 28 May 2026 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000135; cv=none; b=hQtKDEkJVP7ZDQofMHv+mxlpZT8GRB/GLxVm6K4A5xBunIm9OQ617mqwX+osn/iqdLDwGeVj9MdJ22Ghst7WM2EKwPT2UkJIu93x1YXNOy2Mghbj5RPB4Zv6KJ+25oNYZOPGF59TN8iSoZSwG9+cOwbo6ENa7GNeVIrMfwKI3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000135; c=relaxed/simple;
	bh=zqxv+A++DpljCX7sQHIoyhodLZh8aeC89lNFSNe9Ebc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jM+oJMfPY2yAENqE4jfVsrG6YgY90JVlTZLNRNEDojQLWDVZ73f87XD9W/WpehuBbbrl8u3bmZPgQEcIxOWQd7iwyCZsaEzforet2McAF7D9K/u4kngO9FBAshgJdwYf/GQnmpGlz4/56Fs+gDMsa7p6HocU4U7H+7DOQlDaaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h6e0D8AB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKcg3RZ6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h6e0D8AB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKcg3RZ6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 83FC4EC01E0;
	Thu, 28 May 2026 16:28:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 16:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780000133; x=1780086533; bh=zqxv+A++Dp
	ljCX7sQHIoyhodLZh8aeC89lNFSNe9Ebc=; b=h6e0D8ABr8OTvWutrnDZ03OYgT
	bIAHsR1DUVbox6sFsxBaOMNIomplgdcl2dgHoSQ/bUYRBlQRmJi1vInZ+PsE+tDC
	e5Hz9fEOIoOtPL0unlU2oTCYwOK121LO8Eahia76ei8sLrBp7pOsKMpYxc0JnlGS
	ZpiCWb6lYUw/4Y/8PQtStgb1N714zzPOX3xSAoFeQHA6oXFdZJVyzpfC2ZwcjCcp
	538s8ZgluY3CmK1OruAdgHn8BaldzpcFagFPSI7NLz+CVqmu017UXE/VCR2WXJ8q
	sLIQRvDGIptyAtV83Jb/51KxegqcgmfJA2VyjqQyES3BJBkcuSG2Q6lCLW+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780000133; x=1780086533; bh=zqxv+A++DpljCX7sQHIoyhodLZh8aeC89lN
	FSNe9Ebc=; b=GKcg3RZ6W0YJAL+9RIuJy60F73GDTt6j41xGaD0cr2ImH0XJhad
	b1cK1MPPf9x6dJMh97HoCuC74FHXdTWfMLvsUZPx0gWYo0EaWBKk4COymB0nuDCs
	L17PPxdqRDoQqZebPA9Q5Fdo2puaWTiPzpoFoeuQJU4nmuYSlQF7Vi+gtdLjeFBy
	bJfjQC4Y9d4Ohln0Z5TdOmpIDtXdCeOvA1OkjmWbN1OceTHkys+uoE5xBCVBeGn2
	hDbDLV93/gdvJa7m2/HJ48vPr5NvePaf2odVYFOFaxblDwy38gepSTUHuzTw+JT2
	551KTm+B/y+2Tc8riPcL4QpmG3uvVgDBV+w==
X-ME-Sender: <xms:haUYaowhLBVVsT0PXMHnTFdbkvtBSaMFCkkWG85hzSRoAftaah5j3A>
    <xme:haUYarULZ43CEd2hBa4fU6X0KSp5xJJy6wSNorniiBmUhboIrxVp7gKl6LFNQM8yN
    yPlKzxwGCES71Iu_gH8b0d042I2vtcxTnZqAgGDu9VLioExJB-urA>
X-ME-Received: <xmr:haUYaghYzR2rEcjXFoTN34pCV22zaITa9yYCTXiiPJAALjN0D2_7ZhtXUL8Liy02Y0mp-9Db73c8vATdhPEG2nAscDEYX1dvPp7x>
X-ME-Proxy-Cause: dmFkZTEnYCjxzVwqO/QmnKz2TANO+5s1W8Fk+Ydj+9jz/r0mj6Ilojof+ljI0HjL5kccgV
    UMG495NAkCaI8KrrXoBaiaIzrMRNTV778R71zq/uHMQWuqVSgCjjfTsb7mix5x3oPhJa3p
    JjZwF9pxvZlIieSkxzGBErsronDFoZqNephmjHxMuRsIEpJWZyT5GeGS4ypsZyQlIOhUSQ
    KuUcQWVW2iWxuh2Xcx8/viYvmR0Rn2/QwZDljOotGE6DUhpOOi0y21uCmGWgXfTJ97OQFF
    deMgDkJcwNPWob+A2vmptQEN/k/zEJL14Ehq38FSsafkjf0LgMjo4ywd8Bs804Pnx/yQYb
    zPfX5ZlYUlGs/7eYzMhhtuRw0fRuD1Ln33sKyy8axu9So9Ij8NfIa5wN3d6STx85rjWtUf
    Ge7nByzCS/dccIeC1LqGYWjfBmTfB/3gBaiWl4ycsrTAtm4vrAcq4Brq1JaBJ+3GiOiESe
    LGxKyV1V/TfL1auR0BOWD81/E4tp+LdL5i8AxaowN27xjd8YWJ0MmKhsEePkNkMb/rL21o
    VqakkyOMaS5+tmzx/TXVhvxR7pMzblGB/HdFkgaAOwF24owkIdbWmAkLzlBUoZHyX8e+hb
    j+1On0SS9kLqDFLdAFGPRXdpRrPNxvykfAJ/qwIPLN7gIpUi4fTrMQVe2lCQ
X-ME-Proxy: <xmx:haUYajDJzrmfSc3iLkGPxnthuqC8HkG6ztXxN-iJqFfyHOoNbtfCPw>
    <xmx:haUYautXSyYNVwP8W2h9UB7m_mUnZby-1f1DThFcbqNJJmFsJUriUQ>
    <xmx:haUYaveObbYkWCAlF3rDRi84rMFxMmGXvUOGaJnGCfJdXz4f91yv5w>
    <xmx:haUYar8Zj5sZIZh3smRAoGzwNYNvyIIIIlz4-Mj6Sm0FMb_M8eHxeQ>
    <xmx:haUYarRb4s2FdfCqEC-kG_TljO-AcWN5qF0qkEZ4Iott1xdrfFj1fyXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 16:28:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,  Johannes Sixt
 <j6t@kdbg.org>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
In-Reply-To: <7c0384e2-0d8c-17f2-9881-cf14b24c0a21@gmx.de> (Johannes
	Schindelin's message of "Thu, 28 May 2026 15:11:24 +0200 (CEST)")
References: <20260522061652.50078-1-siddh.raman.pant@oracle.com>
	<xmqqwlwwt0mj.fsf@gitster.g>
	<7c0384e2-0d8c-17f2-9881-cf14b24c0a21@gmx.de>
Date: Fri, 29 May 2026 05:28:51 +0900
Message-ID: <xmqqa4tjjn24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The version that that Git for Windows carries is actually really
> different. For one, it gives processes a chance to run their `atexit()`
> handlers when being terminated via `SIGTERM`.
>
> I'm afraid that the patch under discussion would severely conflict with
> Git for Windows' code. Git for Windows' code, that is, that should have
> been upstreamed a long time ago, but wasn't, out of time constraints.
>
> I'll try to polish the patches and upstream them.

Thanks.

Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82D5221FA
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875896; cv=none; b=mSrzRQ3FU7wliLMyoDdEh6cdWhl+cyXU6yQRcdRZmyfcHHqIhcSbQSFuu2uU2POfUTm4HrhE2Ekfkwvv9aMu2GEkWnNALAMLdH+H232oQoQpe9J5bQ0G6pVbyILGZyTqiNp2vE2DbsmR2nspNTDuCFDkUhPRqEIX/dXyoQ4dc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875896; c=relaxed/simple;
	bh=pvELPXgD11B5uIT5rBvzFbFvo2pginbhkRIN/YVySdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mjH8HIfNFcU/IVsceYZaXctXa0uKysofUHl/qy+EpDIp3XvS73D1JGgj8faowS8n/l5C5EN9ouAiV1fvKM9vYP6AjQqKJKIqrGSPGfbpTphGZnkyLBDpWABitaDPtQaJTVx5NbcZYb/DfDy69PmDRbOlzdpiRawkf9wWJOBvx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F2XigJi5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDbMO/7y; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2XigJi5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDbMO/7y"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C8EB0EC0114
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:31:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 13:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790875893; x=1790962293; bh=pvELPXgD11
	B5uIT5rBvzFbFvo2pginbhkRIN/YVySdM=; b=F2XigJi5mIv70pOUtkVbb2fKqz
	FslbvQ9If6wtOy5sEUTO3fTVlzlOQ/lhiSBf84X6AkzNhr5DvmwnEcLRo9t0VXi0
	DRSSwOSZzvZKgNRGPNJ4AE9qhlNgBV7dfJCUTEMsfMc66hdI+CWiJJ/j2ZjIszLe
	qIOL0rHlnumjC4zEcRqq6y8itzgV+h86tUIIaq59NqDRZXQzydjgEMIW1rp25Prb
	Iob5X181Cots+eQQeOzFC6aFiVYgnht4A6Pz/iobJfQMGN2tWuF7K1QN5NUyKSkQ
	AHA0soM40cY/Ucql5MzU2G16iChfCI2OmQGcg1u+MsthSWO6pmHX/UQK5SoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790875893; x=1790962293; bh=pvELPXgD11B5uIT5rBvzFbFvo2pginbhkRI
	N/YVySdM=; b=oDbMO/7y+xptMbzIaT/PkEqroQwOlr6IjJuEth7J518ya8o2Tlm
	NxmICJiPx0bSkrWogq+WRUVidkM+wup7DlzQ+s+Hh0c2qwX+nPweYqydrprFBYdl
	ZiM+ki2L66LaaY8O8v+Li2D2G2RFiEOootSeRBZZn9D2CF9nITKUU50o6uhkIdh0
	o2Ps2BddB0nw6zWHs+THd4hn+FS1msFjQZul0Q77UpagjjTFnsq53/8lenYvOu0N
	ra9vvoWpM60gBFVZ+r5JrHA06tTj341dvV2PNn0y0OWP1/o//zSHAvc8y3wTmXR2
	OSxYslGUHK8NH87dzn1y2sdSN88NTGpsixQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790875893; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ZU7eXFK+ZatwYvosLBQ7Ffxiib2Uig5EnyyOMpBx4LSTyYG
	HC7JIWP22TX2rY/6DxH02B8FcyZv9n8sF+No679C2b4uvAKeJ3AXdfTgpipL/7V/
	PNfpppKFAKz0CbCQjSAK/YNmRO5t2mS4rjNbBYg+3yg83Mzy/I4541/t6VQHXmT4
	uSDx/LkkGSfbTLRz0m7OrIyNBGM1u5O3jTEYx4f+AasK15Z8/dKsHJdUwhAoT+Qf
	HmtsMEmab97pb5TPwS3yZjN/b95TdwTr7mt0RJMpvVo2IOCGecTnalsTnCc32K7w
	1tLo0YuyBl8P4SYBlplneZwJBycBEPk6AniMIAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dHf8Mj/n5aM3XriCkyzxCnX0Ofop9tYjhmORmLSePdA=:pvELPXgD11B5uIT5rBvzFbFvo2pginbhkRIN/YVySdM=;
X-ME-Sender: <xms:9Zi-amgTreiqrK3F4-eu4_scuDhimkETF9hd5rPLwsPSKhntdhn4Dw>
    <xme:9Zi-auBzLwiHAh_3rInPR4AZ52KCaVcs204MBqjgPXZGz-LTiQHvgHRdoA-THEwv6
    YCRTmbDRCiYO08c1REZi80phtwvvi1AoYK7xUYQshir-dlCtA-r1w>
X-ME-Received: <xmr:9Zi-ajGkuZ7YlglRElxKcQ4sYl3YZnR2meTOUK4ITTn1nrslUShgBaM117D89IF0H1dm0a3qOYUCHt_OfmYsEAxBE4cia4-kvBNI>
X-ME-Proxy-Cause: dmFkZTGv436e6P3xcE0H2sk68j4eBbVMNaLjtz3U5Jj6YK19flTk5d1844ThuNd7jzka4h
    QrJzB2lUEd/zmt9+MdbAdUZF+n+TfeWDCzZsLlphyTwIUiHAuy1BvzLjxb4lbc3R8+PA7T
    FcHsRTQBItYRyOpYlJ536wr5+hfT8/wvwLPV9zmxrqW/rUJGRCHH4jAtYPGhxdCJ8wSwcf
    NwmYx5u630e1jLzNZvpTse00xjOMUFIP3PiBkP6HpyaGDkwSAj5G+wtsunbOkHfU43AoBN
    rrJbJPBu3LsnBslSE+PPzm+4rcZ2hySruZzBmDPrgt/BzhPutRfnv4pXCFHMjC5aK4lhPm
    420AyGmWkD28r1QUlf3A9xxdNXw6nDXt+mECYdh+9lNZkA0G+ltqhcGjykyo/UYj3dz366
    WA9aPaaI6uBwcHwHHYK9Qti2BekdrR7GqYlcGwjrBJB9DXt3O2KvrNXUpfIIqp01g+ktme
    wlmdgaezEd3PR1Ff8bAWQUPzkPn4JwzNNlRoVGfmE2wDYxUVwr7Rvs/iRKI8Drr/KAop2m
    3raqhnHAQPYdUYkrdOsSx3boIXxkrot8hq+1QAUnvzWHH0vSxTS7PU8TFOYbBIG1E2k3ZE
    cIZ2dAvKtoVYFkjVCaHZTfYt16iT8UHSAsgyUL1XMK/2KtzeeLvWPIFfXKEA
X-ME-Proxy: <xmx:9Zi-auL82hJCwg3_WxAb1xADH_KYAjDrCGDnURuqOUKVOg0kJFy-Bg>
    <xmx:9Zi-avntCZA7ySYgarzmfZ7nBDBFDLeZJZvjjpp5DyHNBVvuQ78kyg>
    <xmx:9Zi-auRWKt4eAqRuGSRsNib7oEE7Qn1r7CN-NX0yF0z-G5LpGoVHKA>
    <xmx:9Zi-apLqMvwTleDEJW4apBqHMynQjPjOKr6oFpf9YAWEf3JSSettkA>
    <xmx:9Zi-an0wXhiav6Fof3qRxaM4exLxyQqfzvGoTy8xnATlIvMl3wzlQRbe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:31:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alejandro Colomar <alx@kernel.org>,  git@vger.kernel.org
Subject: Re: git-rebase-walk
In-Reply-To: <ar5eereSq91xldo-@pks.im> (Patrick Steinhardt's message of "Thu,
	1 Oct 2026 15:22:02 +0200")
References: <ar5KL4_IKXYbx3Sb@debian> <ar5eereSq91xldo-@pks.im>
Date: Thu, 01 Oct 2026 10:31:32 -0700
Message-ID: <xmqqmrsx5nuz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Maybe that tool is interesting to you. But it's certainly fallen a bit
> out of date, as it hasn't received any updates for more than 6 years by
> now. Chances are it stll works alright though.
>
> [1]: https://github.com/mhagger/git-imerge

;-)

imerge is one of the best things since sliced bread, and what I
still occasinally fall back on when I encounter a really difficult
merges and rebases.

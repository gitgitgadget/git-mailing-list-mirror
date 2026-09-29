Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A357E5383E4
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707025; cv=none; b=d2QjeA/1q/Ur60boBpQisaIjLIF6AXqZUyL/jPMxmXjfS0Sjr0AhpLT0MkEiDSe6x/Fu+dFmrGyi761/tRHz+B1DVNbKOcQ0K8Ga1Rnn+qE70/dVnNlCIIlOyVC2C3UavMeA+HKAg0LzBB5tyM2vTGh1P4ZtjAygxuXb+QEyAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707025; c=relaxed/simple;
	bh=GoMA5ca2Edj47EzmkJlsmHf/1hWu0/88A2kCsy4IMqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PqC29ohUXO6gZyhdM3eGV+ivjx+MCRixscjo9aXAnvsicsOcpGEZY47LZV7DhWFg2OtHbD+PMDD8lPN4RhbdwILmMQXIe0xpYmRVgFQhg59NlkUXQDTDrEnsCH8ftKqwCqKc6jxkI16jTznHQDXOq0ldn4nEq9cpjOIFnQJhO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xd6MzKOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJR2ROfd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xd6MzKOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJR2ROfd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CBED41D00060;
	Tue, 29 Sep 2026 14:37:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 14:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790707022; x=1790793422; bh=DRXAdkKfSJ
	gbT/z3F4vRLCwpDWoh7jRolvvCffeLlp0=; b=Xd6MzKOvS1xk1aqVgD2Daw5nBo
	vFzFo16nK8wfYd89uPSQLZzlxuX8KbVexPpzwezFbNPnIQhfMxkfpLhteDg+t9QV
	eomtHBA6cFIrYZSahQFh0bec1SNHlZM3DcnrqmcPun708battb5TFJCMUP/p31bq
	S90+ntrlxH3XhNPxpkzegnw2a1/lT1iXlIM8qKrodn3+U7tGL/gP+vcF1loROmx8
	eivOVyZ7FEL8tXVHSMRiqj5f13oQ3dGsH31VYf0RTp8SptiV78y2iLQX3HTiCqaS
	RFPnb5v7/NYwVY6B/79ZCDFzeDapdIi9zj9J7gcm3x7lVD4vy4Ld3J5f3X2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790707022; x=1790793422; bh=DRXAdkKfSJgbT/z3F4vRLCwpDWoh7jRolvv
	CffeLlp0=; b=EJR2ROfd+OJG1EkWcxHDbIJKZGBNB66/xjpuzZHv4tQRcOr8Z0w
	uQENoyqsHnpR/ENV+4urjDXeTQcDx/YG3ySPi9q81nfgcjGVrvhbGT0KOolIyjgd
	OYZVm/y3x+BcPA5MeRDYrpQ2WHkx4yXlodlmp581XOEYvOQFbV10b9XxaAs7Laxs
	AruCYhvoNFqOnRc998tBpG1E9zX14fbyrKdXcmz7MVk5L1UWHnsBH6Z1VltcmzhH
	UxdavbwLmsqi5VK56LgfdV7sYW+J/kbvmeEYh+w7qEMv4+9jyKEZqDL72msedBDN
	pqxxV9sQii3odrunOO1XT2NA7E3zwgZ+XTA==
X-ME-Sender: <xms:TgW8arp7NXoZWqoVF7KPUkKVXQEp38pUHL6Q6gitEv2hCA1bo3fTww>
    <xme:TgW8asqKldSraoRe1EqsWZyUvILxglOF4UXycmGDai9lXCZ1Den-JPlqMRNsjNlYj
    PxH1BtxbuS_QeH_dErXqA6u7QEPGnRF_QGp2PbQRyqgs93gxhck0hs->
X-ME-Received: <xmr:TgW8atOhf2qobeFpUq2-3DUsLBY1aLgwfMiLuxwu0PL-s03JAqseuOH9O8-SNkzhW_GZC7wfs11nfQdmK4HW6EtK7mea4aEdg8DX>
X-ME-Proxy-Cause: dmFkZTFqzWnY+NpywGyHGQHCbkPRbIEUtMeL7NgkSLE29ZRAwH3ZjsxSffrihCrq6znPvi
    HFZz2/HwkzZ8nPxw2OtRBqkrTmWiFdjQVNlbVHnaDH+ulz+tXtMxVm+y9Kp6Ue8zzyYs43
    /ymShR4ryBLhTTwJfhKTR7mAoOaHlL4M8+w4mkB3dpcsToRRqQiCw6V6mQIU1k3Mcq4v2F
    zDy6bJQmdbM6V0uvpbEhZ9brzJEkSpNAyogR4t0YE/5iCmuMuFgzu6u+u9ey/AEzYAO1W1
    eKG0wX0Qfdo0fCwd7iwMKEGHFumulDhlegvGltYPwKB616VUJqhjhxgoY1Qmj2av53eOAW
    0XVVyaS7wiQz+0YTXWQT3qLR8qO2fhPOJiMUDrsgLUu60idQbVTJ+KKcoIggF7wxmoeQrn
    Zi9i6m6qwXHkscI6XlH8spgKaoV8nHnmnJpo53+Tuh3ChgavaveQQ3UbFAqK4akYsTFH8U
    uFj13mD8SrOgzg89CxQOY3iYE3vFaKNAFdjYtZpiUIjrI1x2wBDtjr5EpHrkGRo7pLRIzI
    ib8B4FRIzuFpylL4tCotRstqPu8m2GAuofDvMMX7qgBUrOGRLszltVqb8czrBDGeY0pKZN
    ZjV4fm0YcNSci4y6JtG4PHQwTRpsmb8838CY0nwrbEocYg2k5zoSCrGR5TQg
X-ME-Proxy: <xmx:TgW8atyGXwU7LQA2mkPSOrsKdEuq3qSATNp7SRA7ixuupxdF_lO9Ag>
    <xmx:TgW8amtJ5-RJIx_bqigMvL5qhieqHHWwEdRDaSFxcDQpV_x1IId_Lw>
    <xmx:TgW8am6yqgkGiZbZrBciZ36sfHpwWY63zIVNN8opBSNLNbA200K1xg>
    <xmx:TgW8alTgT-N0hUTEe_7z0avNiboeib9B0BMRc48jXqu-M067v5uiNg>
    <xmx:TgW8ajJuaaSPcQ0iqAwJ14AFpb4BKE6fidFus98-NW6uy9lCCcclZzvb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 14:37:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/5] xdiff: clean up read_mmfile() allocations on error
In-Reply-To: <20260929065131.GA1697497@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 02:51:31 -0400")
References: <20260929064935.GA1276867@coredump.intra.peff.net>
	<20260929065131.GA1697497@coredump.intra.peff.net>
Date: Tue, 29 Sep 2026 11:37:00 -0700
Message-ID: <xmqqbj9fhpkj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> When read_mmfile() returns an error, it may or may not have allocated a
> buffer in the passed-in mmfile_t. So callers must initialize the pointer
> to NULL and free it even on error.
>
> Most callers do this already, but rerere's diff_two() does not, and
> would leak the buffer after a read error. We could fix it directly, but
> let's instead try to make the interface less error-prone by freeing the
> memory when returning failure from read_mmfile().
>
> This fixes (part of) the leak in diff_two(). In theory it also lets us
> simplify other callers to skip initializing the mmfile. But in practice
> most still need zero-initialization because they may jump to free()
> before even calling read_mmfile (e.g., in try_merge()). But we can at
> least simplify rerere_forget_one_path() a bit.
>
> I said "part of" earlier. There's a related leak in diff_two(): if
> reading the first file succeeds but reading the second fails, we return
> early and leak the first buffer. We can fix that by checking each
> individually.

Nice.  Thanks for plugging my leaks.

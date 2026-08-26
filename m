Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA0A356777
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776274; cv=none; b=YFEeuoCVTU/FLsPPQIts8kSJrdEGJdDs8I1wM6/IH5ZBUHvGIKOX/hbTqFPLWEg6qeXNiCxdDkaSBOTFsZCYATwBlao7EFgXMTDnP95TgnTXEOSWzMRRaAx9WCzkQjGstGxTDZwGIhAAFUNUcRrOeoWAQZKKwist8CIi/liZC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776274; c=relaxed/simple;
	bh=oEemRM8Hhu9uWccQnyK+41GndJou/qcFStvlDu1Vqz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pRysRbjEwuW+H3C4v9Z943vI5KerZ6aKhIMiF8Cn6fC+1/gbJKiGJ+7ngOEEQIkCPe1wIpnDaPisoQrf4PVd9TExEBucBj0VZaBjn11hQiS+IXzrx1i0s6aBVy4wyYD5yY2FtdWcbwfl/+Af3T1f61R8SE6fQCw7EthWXKJtUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ueBUvuyn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FuuPSEEL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ueBUvuyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FuuPSEEL"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D6131D00029;
	Wed, 26 Aug 2026 16:31:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 26 Aug 2026 16:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787776272; x=1787862672; bh=zMF2fpGpz4
	3V2wvIJHw471oh3ROlPqVtKHDYJSviczE=; b=ueBUvuynfYa8NlHKHFfu09minU
	aE3fFYn3HpamgM7up2UmCiNkL4edF3dfonspvyNVYhVMj6odG2/p7q/gQJ7orBEt
	bMQ+sZswlDc3rtT7btYnl5101yva//XlZIaQS+Ohxpl+wqfKkFsLbwGU5OGiMlSE
	xhFMmnTPs9iJq3j/DRjsGcNNdV9+qC5DVVZBysfhuBjuQv1WDCBnbi7podrSWbMR
	Wu4QDWnNIhu3wFAs2AwfNG4ZLLe1Oo7ndYPU/MpWHbyoE3KlhRmq9Xyi4WjVKhe5
	2By45UztHDeHl1spuPJ5yZamKFV6MnNEnvhuxHDRngHYHtMYjSZBKwl8sRFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787776272; x=1787862672; bh=zMF2fpGpz43V2wvIJHw471oh3ROlPqVtKHD
	YJSviczE=; b=FuuPSEEL5RNmpz1kgnjYOxYHq4e9nhSs5gihfkiuIe/5SzKRVTo
	3jiA2vIepFtxAQlJ/uVfvFOeaxvxuATir3ecFD8Nag4NVrAsHuHGBpPYdAEx5UqF
	x0bOsABham88vJjHDQ9qFY/nBSsXiyidGtR2ThF6hLo+8rIrx9clvfpHQT/+uVXL
	Wjsm6EjOVtWOv83ZZgihD6k+Z5ZifFDtlOzENwuCwhWD87d1tLdQM82K32npkinc
	QFdGIOGgWwG3kEh/CELer0CFv8QKG2Zqvr1l/aghhH5/HQyka5AarLDSMZW1h/hX
	KiMIWywOpTg9TSmfeoR80oePtU4cXxHGw7Q==
X-ME-Sender: <xms:EE2Pahx2cgxhjFh9M3WiMKhNIML2-mzKoXUdInuY7eiMIBu9bjt4Ng>
    <xme:EE2Pajh2d0tvX_YuTtxnKtC2lvCkGS_Di3cudtlIMircxtKzZnd_E2j0vB5ui2gDk
    nzDpcRTW_D_x8zMs8E_z5UequFjQy2R16MwI7mqlx4Ph5KlhZqXdg>
X-ME-Received: <xmr:EE2PatmB9-wb-3BH8Jt9W0SBV8KSEgktazG-yKNR7j51xxR1CAdh6H4CXK5NMtjQ04q0ydV9Y4pFIseu0G8NGA6-p_RnAcCmMw>
X-ME-Proxy-Cause: dmFkZTEurOz3uUh6N+P9Srx1IL6hYicbvwQWI41GS59NF9mGMPSyZHhUq60u6hdEfuVgFz
    zVsyVwvUqGGBspbukact3LBJ83+tkB2K1uHdoHe6/hbtHAunAiLTS8LIOC5j4WsKtxtnIi
    j5xZY6X3enRemZ+UEsDUwqoIdz0uGCMKrdHQfUMLuWO73FPoeEBX0TbHjB7uBJGtl0Li7M
    EoeK/oxcYQ4SyYzDXsNnKfI8lIQ6rdxvu7xwHkza35lUwypW4OyEDUmw9OjC5O5qmoy00b
    7cBOW6Y4x1iyCdAbXhTofYdshG8T1ugYBOAE33/lVmIsUCDrm5Uk33cf8PityPQ5TrW4oQ
    QcpsTb6n3yRhbtl4F/Omdut3ZfbqIVFHN+k58PzFvfPYv3twvQVDTOEo5UrD3GGRRBBqu6
    Gm6nSiwoKBBTnnwujVnvzYz5GL+3935EaMI7gVCPIFYueBFVeTKeX/aCw8SO5nSncW8N+L
    93pUQR9JN+Y0/FOKQEm+rIitBrOGP7IfEpsarRLIj2OnKGdC/nd9twQU8yAaUx6JT3cPlL
    OU7wQLWyxd7Qy292tE7iPrmcs4Tj9Jemjwt9g/Ocj9+rSbMjVdOkDy+0U7dhcZpAYPwId8
    zdI6jHs4lpEJFWG9ADMeqQZgz5ew+qweaRaYbAmad4vAJg4rdcu243daz+rg
X-ME-Proxy: <xmx:EE2PapitxrRGF4lksBk-7jAk27GEvTLpltgrUvjLytcxx0wRJFUfCQ>
    <xmx:EE2Pah1OY5jkXBgBMiGn2Kerl64SPuC3ZO7EQce9zuzqHPApnGLciw>
    <xmx:EE2PaiKwf5UojcXLmkGOO7Ian35Sd0MsIFhQXiy2Tjt5Sij6Nq3UQA>
    <xmx:EE2Pahzmzq4w-17DQdVlKytAItCgLa_s6xbNh-Xk59B3WNtraVHHrA>
    <xmx:EE2PalOu7U9znnR_0qR1yF4T_q2Rftss7wSuoQO9IaTSxKYGy1-g85ax>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 16:31:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zephyr Yao <zot.zot.yao@gmail.com>
Cc: git@vger.kernel.org,  Zephyr Yao <zhihao.yao@njit.edu>,  Mahya SamDaliri
 <ms3539@njit.edu>,  Haotian Zhang <haotian.zhang@njit.edu>,  Martin
 Kellogg <martin.kellogg@njit.edu>
Subject: Re: [PATCH] apply: avoid leaking abandoned git-header state
In-Reply-To: <20260702041759.51572-1-zhihao.yao@njit.edu> (Zephyr Yao's
	message of "Thu, 2 Jul 2026 00:17:59 -0400")
References: <20260702041759.51572-1-zhihao.yao@njit.edu>
Date: Wed, 26 Aug 2026 13:31:10 -0700
Message-ID: <xmqqtsogei9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zephyr Yao <zot.zot.yao@gmail.com> writes:

> When find_header() sees a "diff --git" line, it calls
> parse_git_diff_header() to parse the git-style extended header. That parser
> updates the caller's struct patch as it goes, filling in the default name,
> old/new names, and new/delete state.
>
> But not every "diff --git" line found while scanning is ultimately accepted
> as the patch header. If parse_git_diff_header() returns a length that covers
> only the "diff --git" line, find_header() continues scanning for another
> header. In that case the partially parsed git-header state must not interfere
> with the later traditional "---" / "+++" header.

This patch has gathered no response.  Perhaps the e-mail received no
reply because it was sent in early July around the holiday, or
perhaps nobody was interested in the topic.  In any case, I am
cleaning up the "What's cooking" report and noticed that this has
been in the "Needs review" state for a long time.

So I took a look.

These cross checks are primarily sanity checks.  Having the parser
notice a discrepancy and abort is a good thing.  The user is
supposed to inspect the situation and fix a malformed patch (such
as one containing a stray 'diff --git' header unrelated to the
actual patch).

So I do not think we want to apply this patch.

Thanks.

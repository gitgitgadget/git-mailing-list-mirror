Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA78388E63
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037951; cv=none; b=WB/gsY+6DvFFVbclCX8CSnEhASGPrXQjOUyVXJYw0z4PNai6v3c0AggUTwTqYHp192/aBAeBQozb/lekZbkVX9jd3zjcKPBYPTVSnhbfPdGoRoBI9xK58zCsBKG4nDlz21Kv8v+PWyPJCGmA4n2jetPprSFMabnHDEK3aNrHjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037951; c=relaxed/simple;
	bh=2EUCK68TNVAWFdzmExv+nOlfkoQAHMOw/SwcFWAwODM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hvGcvUmRGjGk4iWRZboeaKcoQRJOhM4XWBOaRf0BFipm10otJP3+crh3IzPRiSRgN9ahBDZ0XN37hNTjiuAari0UHrKNjGDaRzNN2f3WrSCip+iykYZGCLYD2aR6+MtGrt1hyHTFeTE+Aa4FiKu7X2KhdoeJKW5PFcz7nttUslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zQKwkI4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9EkDXyd; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zQKwkI4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9EkDXyd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4254A1D000BD;
	Thu,  6 Aug 2026 13:39:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 06 Aug 2026 13:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786037949; x=1786124349; bh=2EUCK68TNV
	AWFdzmExv+nOlfkoQAHMOw/SwcFWAwODM=; b=zQKwkI4+oaMjLEESFDGm7ReSO7
	hh+4FJc33dn4K/+mFkyNFc6cEN3RfyQYNjjO/xnAXMLv98oPaBLlaUuXIWH1VCjG
	O0JNrG80fJjDYH+7m0V2/xOVeitXOn22nTPAKOkekWgz3wJ3GrYaGgQf798LEIcb
	60D14AiwHRl9SG85BF2SBXwUdveUIgxegLaBm0SOV/EQco1QdfzZMiY5n/SekRIV
	hzE2b0Yr86UQTpWCIgREoBIsa5ToB249Oa1+HcmOi7/ZgVL1qKbjCh+6/ZR+zxwN
	DijvJGbmxdXChXdksHRDVCZrl7QTwjJlCWJMO3WVfgy3XOoADIrUZN+vz+Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786037949; x=1786124349; bh=2EUCK68TNVAWFdzmExv+nOlfkoQAHMOw/Sw
	cFWAwODM=; b=j9EkDXydOkQRdDSbfqHi7QQOXAXBH2Z0+Y6DqRPN5tEPwwYnZiJ
	x6A7ZXj5OBW070/JaUWFetpc2X2EXhujDRSgCXz65o1f0BlI6LCzJhG/biNsJWjP
	mEHEzSbjt8+0HKY0fRQkmJV6D7EZTpb1CXAlSBr7WSz7Xi3kgbtnMr4r0ruDZxvW
	YGJyZT7FT18mmzwXvj3Jb+lTLWr7gefamZPSnWAe7e5Cl8sMR/aAoKbaw+DQ35kX
	u5k30xYWchl9pcmJqjnqOWu3Tn7ayS9x6rtdT3oFHMCO/lS13hKs676nKdbXIr1U
	ukDV9n6Xb1728MOe6GFcxIXvdESHnuoyTjQ==
X-ME-Sender: <xms:vMZ0alUJ9E2CTG_prDy_ewrK_qRZI574jU_0jo9T97nDvMoT7NTCmw>
    <xme:vMZ0asc909yd1OmEBvS0D9XgRTofLyE1vf0ppanR1I78Gdu3BUWkToSt-ZuyqVGKe
    yW2DZDdEdcGGRq_GMnusUhao7ZucWRljB1p1_NxUrQs2Et_BG1R0QI>
X-ME-Received: <xmr:vMZ0apuq-PcTcewgv8RYb8QmylJKdiN-g39B_t5fgqD615TEse7sqSnD6V1aT_hwmx9we8D836BdhI6nF6W1KvOnYLTVqQo9uA>
X-ME-Proxy-Cause: dmFkZTFftnR89awgvh5xE0WBdMZ7HpTkfh3+zeAFT6m1BVpW+CadwZB6QBc0p5xo4nQ64Q
    MW8uGrU9y5cBcYQSZBgw+s7N1nZ2Up2CXLeg4Ar1PgWvfVc5lsQr1UXNF9DEJ5uDOg5U6W
    3G9MerC+l2p+GU2sgRvEGONQPIL7lIFxofTNB3SaI/uzHq+KAtgzUKgkLAlEaQN4IjCgA2
    Mpc3YszY8RcNHcBSZT/hqKvNgvH88kLJX2PFmcmkb2HjpCSZfXyWtfvVrAqkDIVhbXcknO
    NtQhjbgYArlaKQVUMtb2W58P3JqJvkXr3OavcHSc5l1227KT15uf9dFCx1X9WbunGO4kgC
    K4wX4+tcKSoeuutoKU5FSjJck7tdt0tGkdbzi7sla6CqqxvC+XL5X0ItgUt4ZTMID/7J3W
    zIsvmB3y2T/x29wKZGiMbFuokwE4z+8SZu2XV2lgcyL+8HdxjRpO3by8UkQmQ6VCfiBHEN
    jT0gKfDTSI3vmhpZf1CMEWijqL+l2YTV1R989dMrHX/BW2PEfPa9aowEPCMlYI48RMj76L
    6O/OFsRErjo3Q2Lp+3rrkaSLLhkCI4yDjIhXeaj0YEbh31KyqyAiGCMHgHVf/tRv1jILnr
    2GTdyqSFdq+XhjOcrFH5p2uqWiuvD0Pd6ZTKAHG5acn/r+uoa8pc/FZlfE9w
X-ME-Proxy: <xmx:vMZ0aj8QrTQ57gibf8_FLkft5fBf6Ui_XRumBFBt20r9XFSZVehU9w>
    <xmx:vMZ0as1BcrtYeJY0gOzDrWmy4wnRBKsCZnxydDrHIkGNeHHcSikpVw>
    <xmx:vMZ0agCMvOn4htqgix9_q67FwwTweqJS_J56eTYRecc5EcBL9aUx_A>
    <xmx:vMZ0agfkSFFnc6JM7DgwSCBfCjniVV5YwaXhSQ1wylIu_jG96BlkdA>
    <xmx:vcZ0asYwYrneLrVl0w_FcfRJWuYbxgpnudJPKi05d639p6rPASSWr1Mk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 13:39:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: [PATCH v4 4/6] setup: defer object database creation
In-Reply-To: <anSgJ4pHuwJ5hylE@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Aug 2026 16:54:31 +0200")
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
	<20260806-pks-odb-create-on-disk-v4-4-ba8b4fdd2e3c@pks.im>
	<87tsp749be.fsf@emacs.iotcl.com> <anSgJ4pHuwJ5hylE@pks.im>
Date: Thu, 06 Aug 2026 10:39:07 -0700
Message-ID: <xmqqh5l7jghw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> It's an artifact from previous versions.
>
> I'll send a (hopefully last) reroll in a bit. Thanks!
>
> Patrick

With Toon's <87qzkb495s.fsf@emacs.iotcl.com> and this message, I'll
mark the topic as "Expecting a (hopefully small and final) reroll."

Thanks.

Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315C2475E3
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123452; cv=none; b=NLJpIkXNrwZoWL5NcXcoClMmtKx6e289TcESVpXut9tyzOXX3sIqbQw0SjJiakbjGmObgpQRxfz/87xqzhcK/pmZXRDCmdrUdCmFMDYk+noxr2UezefZCnynh20xlzsoAKNeKxqHaNfWYPtTPAhMm4sbGPA3PabcBAhSUWhQ6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123452; c=relaxed/simple;
	bh=ot/5AFboWUnKhl6wvyIZPtcomlLWW6iJgYhcytmHX60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IRy0KdRs+NMrTFFJtfylwk1TlnFUvFzlQpTcc5YSBQx069hEECJLqVv6q4E4FmtaUDJHoqOzU2D7rrxBt3ZA4v3kcVxUoKoBkAO3gRoFtEFnPdNhguAZM6ClJ2hmkPEniIxJLcwXIbhE/KV9/XMMoGxcZY60NOGMgV5Pv8ZI9vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kDsg3rUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s6Dqhm5n; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kDsg3rUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s6Dqhm5n"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C34B11D000EB
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 10:17:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 04 Oct 2026 10:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791123449; x=1791209849; bh=7FC0HAzsRz
	MoZ7I8SHi8BvePzes/Pc/vBil4ouy8hI4=; b=kDsg3rUj2cX5JSvf9E909a3eTi
	bR6dEdgW97JVo5KZOh3lQ5pclIxZqjfj7eo6EhCOm5A419HGb2tuOYf/qsSWH78w
	F3HRYAaLT0ovKCOu+JkQe2KQo3lWclzjaqD49qCE1FsARAV16mm7pyu7kze6Ickq
	ipC5lrFgOEm1f6V/KDlBafTQNmjVw1u2R1ydDTnK1uiQIHNpTSfvdzc0iYMpD7em
	RSBgyWcJW1SD2OTSiYRgdGe+n9aZ+7Zowc+BDus42Hg1Q76daeqj3PYytLTC7/9j
	lH4mPueyBIgHOX5BcHMPy7B54W8Js43zxv8YDsI2vCs/gWPS4/In7IW1tNOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791123449; x=1791209849; bh=7FC0HAzsRzMoZ7I8SHi8BvePzes/Pc/vBil
	4ouy8hI4=; b=s6Dqhm5nBJfyEzFvK3YAd+8TuR/IR28LPknUp4wiTro1TPb16rH
	+oedCSjz17AHpl0HTGBXKjPI3T1b1gOVf5d1pBRQp2kE9lxOoId2OPi1S9wXtaE8
	WpOJNxSN1DB1sPPjqAaA8kwBa98TjfeHMNY5HObyVmO/TrEYuMgt0BGeKkPtvueZ
	k3nQydTmeIvOr1p6kvm8QrSiezeDVhfkZ/gBU8PwgthjAqB1UcDhUoYFmmtsanGp
	WueobksIYM5/wZm7WZq1V8mfe87YFS2fXs95UTAb0j6ZLeN6JBfHJWl8il/XAaoR
	XSQsnfHRljEpGeXeBC2Nqls9CtexB68g4lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791123449; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZwwjVcf53QLxwwzlztvrHOg4shIc1O7pNSxUqgLd/HEbVG/
	NypRcApv+UYmOC9pWnDEo/QmmOscF3X4mqgN7C31FoyYamuFhlABCZN580lya6EV
	11JlpAiPrKCnfyTtQDDwehMaLcBrOsNTNlVhSTqYsDDdKXRm/vlm/1nCk5QcuIDc
	fDtOJ2wD2HiCsZ6esu3DYbUcG57Yt91I/uIqEWhB10KIYdbaVkwFj6G/UQXNbHjU
	kGz7mOhNpL7/UeKjcTxXSPAcXd2t0fa+zHs3faJA3P+xT7KLj5QHj6Z4v4l8ossx
	TK6BLvu9n21CW1l44apbMt4zcqDM9Yxiy/9mlYA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mghzMTnsXecXdai6nu/5kLIjqdW7PX0N9kbKoA48OR4=:ot/5AFboWUnKhl6wvyIZPtcomlLWW6iJgYhcytmHX60=;
X-ME-Sender: <xms:-V_Caqq4_HwxRvk4NZnA4_z5wopDFDb6PCZFp6Ayv4PTv-Zk3iolXg>
    <xme:-V_CavocalEJn9-bCkidmQf9pDsmFVeHnzh_HWnSY4wYUo4JhbYRJ7VbKfiNoAJ4d
    nBPwB-zneftdi7uRIR8jZq56hydsGEANc20AiheWM_dNAhvY7opgVY>
X-ME-Received: <xmr:-V_CakMAmfCCIlHvYz2mlf80E1H6EIK3y59aA1PoZVRPJShrhXIYn4h-IalQ1cBav81OI5Vx5FQbbTeBTrDfXRxIImEUvpX3-YQq>
X-ME-Proxy-Cause: dmFkZTEgZ/GWzww+SvZbzxCXcC9DqWDg+2kB/OZw/5rJEpSIdNRUQegS7dtAmiZ/RL1nRg
    6dOOkRjK3nGADo8Sq1u75VHexnvLx5s/eIKTu6zLcUy1pHCbmcPlWfnnHn8aD+F7/gYBgo
    Qm+EBowz/MVw+72mNwIFTFjyAyA8saPgxiVyAV1CoNrUMkwXNGqLkvatl9NkdtpzEwkJTB
    Q9pW6bAOdDzKScsATLK+15jUU/13bolWKMitVtIcQhvThfzYFBoWr7YFbFQ5Fh/ykI1kcl
    hQ2cFqoJ9wia+NxqgbwrD7VWAsn3eBx9iNlZipk7j7yZzLsjk6boUsYD6DZNZ3Nn1irIBp
    EhkIPW47Tkd8qz0S+rqI8fy6sjuBwZ90qPhquN8E/THY2Cc1YI3GaMlHVfVGScbLpi3+7W
    XTUMtuV/AQoUUwpAWPsyIfSpGa6ot0+FWw4Sh3JV1JxqTYW+7tmYjkDYhzf5ClaK6DM3Yp
    V0pyE3O47tKYe1zabwqOOfwMAykpSuOXwS26lvMxINBPioB9D/yWx0ACOEvjE44nps2C1i
    stkXhkQLwlrzq5rQp4meUnLUFYWuQ0CTLahiEnILdS8ZY+H1SMEBRGSivO0nc4EADiXN1u
    J1Q9UZ0vBJbnb5mTUHPL+PEjiobMNwuprPVoanp0FK83Sd4iAAZ10jkr76eg
X-ME-Proxy: <xmx:-V_CaoxcRRhUZziYmfOxgP53w29xCcGoFrF-qF74gVs2TGUhXRB7GQ>
    <xmx:-V_Caltl_wxlYnML7hnoi7gKukIkBP_cPZChLOEWlQv5pd_aO6e2UQ>
    <xmx:-V_Cap43SKaGzdai-QQJ55XfCRGMUcTR5CFTLqUVkxUDZzYn21PiJQ>
    <xmx:-V_CasS1SoBbbNCWpqsoicExTUhbm4HjftdvPVIauV97LvwZERcyQw>
    <xmx:-V_Cai3SAusQlWqB-H5JPpK9ZDkHBVUV4i0yXacEgeuwf2h94d3HHuV2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 10:17:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/2] history: sign rewritten commits
In-Reply-To: <20261003134058.23494-1-git@5ouma.me> (Souma's message of "Sat, 3
	Oct 2026 22:40:56 +0900")
References: <20260703145037.69832-1-git@5ouma.me>
	<20261003134058.23494-1-git@5ouma.me>
Date: Sun, 04 Oct 2026 07:17:27 -0700
Message-ID: <xmqq5wzhv9c8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Souma <git@5ouma.me> writes:

>     +@@ t/t9902-completion.sh: test_expect_success 'git history subcommand options' '
>     + 	test_completion "git history split main --" <<-\EOF &&
>     + 	--update-refs=Z
>     + 	--dry-run Z
>     ++	--gpg-sign Z
>     ++	--no-... Z
>     + 	--no-dry-run Z
>     + 	EOF
>     + 	test_completion "git history fixup --upd" "--update-refs=" &&

Sorry if this is a stupid question but what does "--no-..." mean
here?  Do we give that as one of the completion candidates,
literally with three periods?

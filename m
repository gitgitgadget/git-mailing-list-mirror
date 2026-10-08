Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8446AA9A
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454250; cv=none; b=ozvlbE9PQxmVPn2pUnpskHbEq5OYH+oQA5dzg+5L5KEzvzF0OrN6NXGz079MzyITHhLYiyxN11sSofIBdx20NXNNhpkZPJ2DzXLn1cANyDW7koHVa5WPuqDVvPP/jdckkKmTyyekG4wvNCeAK17OXA003O0wZLLeUjnNSEK0CPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454250; c=relaxed/simple;
	bh=wjglcH92AfoNUJBiw3oMYM5Lez9gyFE3t5e4EKArC8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+jNs6Yh5FtFBxjdG8ThXL2nYISK9Rm876eDB3Viq1NaO1iXvvBo2/mlq4DPM324jfhSjZOwXFTd4+9rbSHKo5ArBHGbOo2Os6/s+h9FJb4Y7spHi+FXB5eh8LUJ/b82zfqWRh4fQtfZQOnQ39d+WNE0dcPN3CrJxGCuaqFoMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uIcz/EV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A8swyQew; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uIcz/EV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A8swyQew"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A35C1400167
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:10:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 06:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791454248; x=1791540648; bh=PEAKjXNdiC
	VRsM3NxoY70c3A+p4PZ6PkaBnoD7utq2g=; b=uIcz/EV8pGAW7oeEV5DQSmQQnO
	fOGis2A7821SCzeGGabV2M8h3zmnM8ERjFj8yt5Ftw3FATSDDs/yMTGB6tlaqwPu
	OqWxTs4mV1LS3wEPTQnLPd1WR2lRKMYaw1pMZ6rHHkxfRBLEyOaAuLfa9+Yujupc
	TdtF5GnsDiNDzg1X858oY6RDXv6bysyWefIfHgSgjJ+q6lkTaty+Ww23MiBLOt4s
	HDGw0bVSbNGXPmJpiz022/2Qd6umq5FsX2ynfem02iDpnEpYj4PNC8jTzhZV/JYS
	FcFAUN59yepmD6C5UfJBK/jeN3quIHCgzLRqSgKytztnWb0BA1GlStGGF4mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791454248; x=1791540648; bh=PEAKjXNdiCVRsM3NxoY70c3A+p4PZ6PkaBn
	oD7utq2g=; b=A8swyQew/+Lt5hgOx2GpYP2ReCwWZBOnVEfh1z6m890emNHlvF9
	X7cM2nN0ngdO1OnI2dp7fzkQQUhsP7QNpcPsfMZ81R378ynfiFFSlKzOMFLZLpH5
	jdEilyC6XIqbDQKl+lPO1V9mWlvDii18K+eqfyzDMD+GjG6DTkThLHbfqS1Max/x
	s7q6Xj+QWrfzK96FoeXpur2WVI7V8z9N3rYlsqiXJeOstDSychvAfe85H/2t31Gc
	moLXRx4xFxm1F5x5thIrVJaczY25S9gHNwyKIn+i6DH8rTwiKHyPQYGgdaMHnN8i
	BZLAMhLdnqzZvOHTQxK/pFJcCnmjioCC25Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791454248; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jBTYxmfmG9IJzqaFTh8cysaGCliPF5RYlE7Hcv5md8EM8/B
	QFHRqRUsNqYlbtRPWjeg/HskIszltZViwL3maWPROJkP869YwybdaWp+Q0aAbVqA
	aO26XZymFV9KzEWPnhjOPSx2V+e8h/EjiVUyrK586tH0DTgEAY5Z4r+6+s2dySiY
	p55P3i1RmYqCtpfF7K4gCIvQLIjQ3KG3EX12kNnl6UpbMfop+1zym3l0yWadRvaj
	ip2dKaY2EPAKCrQeS9lBfvB+MasmzTrGPEYPw07bI/a1EEmkenAaVFFMreTp0L2Q
	SzjCjHD7lvense4UYbcSOhqbF4D+MD6HzlZ5ZzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6BUuqoIONWH91zoeb1b7baQwHib76/pl+9X/Y2eY/wY=:wjglcH92AfoNUJBiw3oMYM5Lez9gyFE3t5e4EKArC8o=;
X-ME-Sender: <xms:J2zHahrmzjNoohsPwd58oQ-YhBRegDSY92_52_PE_Cxu-YDYDZsKkg>
    <xme:J2zHaqoV-gAZue-bC1icofGQw8WtE02lbrJPSLTkf0IDZyxvLqfgZWrT6I3Em9Xqm
    ykHXpmGtvMELGHhVW2rbXb5dDzN5fzyzw_mwIHdhN1F1V_ak-fzy8o>
X-ME-Received: <xmr:J2zHajMDlOztvR6Dv0ThbZ_hLOai5foqYsBavMi-GA0ChqFwNNSuVg>
X-ME-Proxy-Cause: dmFkZTFkvPiEUi9XDiuJNTwgmgfKJdKeJOEZYKU+cSoHMho2Cb1B6RU7F+4hDJZAaMJF00
    6oMS2OZgFPV37XwwF1ar22ujC2uJrQy+JDC7mu60U3n4nLUxXDXw+qkIUisv+V46JraUgj
    hPvO8NgjBk7vxfaJWN4pbJjso0zjufnxwBkh6j/dV+V+8FnVR7l7YcjgYwq9f1gYOyGTep
    W7ua8TcgU7+qwwjL0EqkYIfcTG54LwBeAtT3eGKr9xdBvfLXjQpKa0WoKNGVk9PO941qzy
    f5S6uSx21wNdNp2bmc17t/84DPPGtg0bfopsFnRRwviECfdhBhkSt0TC9rC+KAJIeeSZRD
    PqfxtgmCzMnDOrirWbB0XrZ7RtFFfJxKBhoBOkIMIzn6BQX1mgFpEHCd8M7B7WdcG0hLaC
    xcrtwIJVSv2SuMT9DUVOwhrDijnLbOLFSPLH0ghxutT3BQoiBBHoVlSWDxQBXvixsqWwmM
    Apv6AHj6ZGSTsmaTWtpko2SPlAnJv7Vqq8OStXXEuqXJdxt0P7Zr9reVnPtlEp+cABx6cK
    3fXhDzWQi8ji2gu8GzwzqtXAys2cGC8RZ7U/N5+XrvgWG9WQ9mIFfrY9sxMlhBgPGQXbEF
    2uRyeEMyZJb1jSLM9RcWVsFL7b7pIeNwbg4CTxYMBsHneleAuwNnb+B5fwIQ
X-ME-Proxy: <xmx:J2zHarw8Cbyf72SUrdjcOnLLcc4CqNs1q5oIvtZWs5LYNteSOmeVKg>
    <xmx:J2zHasv5EA924q-F87cJLGMmC2z74eIZBy1xn4n2eXJUgBn_zm4xgg>
    <xmx:J2zHak4LYUrkiz51owOzZZw-ti7M0etw7f6EDqwbH6WDtc5mEKpugg>
    <xmx:J2zHarT3THOQRSSrYqPy3Y-L58XO_osjNgv8KiqW_EN33cyz9SBq3g>
    <xmx:KGzHaisHFb6OJ4FBf7xBklhAeD-Z0bd1K66Bl6Xrlo48WfmVLl3DxwgW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:10:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a7483d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:10:45 +0000 (UTC)
Date: Thu, 8 Oct 2026 12:10:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
Message-ID: <asdsIjNEUOpaAnX5@pks.im>
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791452597.git.maciej.ciemborowicz@gmail.com>

On Thu, Oct 08, 2026 at 11:44:15AM +0200, Maciej Ciemborowicz wrote:
> Changes since v3:
> 
> * Rebase onto 6de20f6092 (The 4th batch, 2026-10-06), the master commit
>   used in Junio's report.
> * Preserve the packed preparation error in patch 2 as described above.
> * Register t1425 and t1424 in t/meson.build in the commits adding them.

Please engage with the reviewers. Just posting new versions without
replying to them at all will very likely not get you anywhere. This kind
of behaviour is nowadays a red flag and often hints at contributors who
are basically just a meat proxy. And as a consequence, reviewers are
very likely to disengage and stop reviewing your patch series
altogether, which is frustrating to everyone involved.

Patrick

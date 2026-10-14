Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219505650E7
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006585; cv=none; b=KiNgNfCV3CA2y6lAVSVQtm467S3hUJb+aF9ZLcJxEWWOR/rnOOsQDNulDmj7bpSAfGJX/Tl7yKMedzUdDgFMyKrjMbr/2oQmuZwn82IFHq1awvA5sXtKnvhMz8hFVj5TiZzyVXAOxq8AcWxYYjwXa9K+WmwDWLMBrYhEOWIHyuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006585; c=relaxed/simple;
	bh=T0D5uxJd2S24o03Dvb6UPilnsVIJglV7No1Nhoy55qA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HrXwS6dLp0BTTaLJLONtqCNhab5Bs6RExtNqBJc6n7O67UfJx+vdTRcvx4QrYcZUH+a6Oui1vVhToy2RGYuJuXOcEaJBd8I8AUswV219fdKCm8Kgw+Ruj8EZXd/8B+28mYYiq+V8ao5q5R61QSHHi9LDz9ENzl7E36hD6MXLDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a7CpiXy0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHzUKMHJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a7CpiXy0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHzUKMHJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 31425EC04C9
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:36:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 15:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792006582; x=1792092982; bh=v1F8DcgZCX
	n//ERSONTjiFHWcZtiimZhCP9pMW9tM/0=; b=a7CpiXy0ZCFJ27nPkpa/5rqnjz
	4De7HO5+2c6slKqD0M21KTbevv9Ry9aZdtmaNgNLgRvqEfWe1DyVsRHe+6EerntZ
	c3z0LLjRWCceRLY9vIBEOutt4gGaCSsDQFYegeVZJ0rRFUEiEvqALYIVnvw3lU16
	Zk7/tAiU4LMw8VPrZHzuVb3kDF1jevDP2Yiz5WnE9OmIPIeUTMU+ykZ2l+Qhw0Ia
	ife10Su0cfs50aOgQs5LAgXKizCVMIQRxF3fl8FrvwnDIA8lSrl/u9Nmqdz82s2Y
	sC0AcPbFWkT6U+NcXtpjyex0K775vU535rrDu1bKba6VKz8GRaIiH9ZdqA6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792006582; x=1792092982; bh=v1F8DcgZCXn//ERSONTjiFHWcZtiimZhCP9
	pMW9tM/0=; b=EHzUKMHJ1gXoH5AogIperf1MYqTx1ZHgWLh0nojiCgtCp85FkFx
	fEValcgIn3jjEJCEZaOsqCiiLFqct0+Nzz3Zh1KVi4+tlkiD4+bfuGXugzJKWv32
	vzHtX0YyPzvEVFxlkRcLQZgQPebBqZ9uR++L+ov8cQzn8fWGy6zRLbVh3hL2+D3P
	l8XJRT34c3mVw+GLKkFZ8vLqP3FRDxTFyCVqn3aMObKTxbrZn6iAGw3RrJVJLDVx
	S5A3EOfsj2SF6auAtUM+wEwbMsoqIpDEjygjT5y6gPUGnHSX6uObrG/tcmjxQcWO
	en9aP8eGXM7LGaqkR3eRz89MoX9wn7rpbyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792006582; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HWF/uPMQHDa8xg38taASJnyx9rz1CeCnFa1SJ4CsIy1t2q0
	fC49KbMCAk0bAraetyGi7IxokyuX7F/g2xnAZ79zwMPrLs/qoJ+2grS/872c64cM
	iKg3DJB/4xgEudJtS4EjD3WDvPVS7Bla/YuPFMpQ6fuvgrwpKGvHUQSHnvZ5UaeD
	wcFxjiQEr3KeWH+Xgs2gU56VBiWLrXmnlnscR1bK4W0xg/Et5Epg9sTpNGWPrb4t
	a72LoPiahdJ5gjofizKrcHHe8tcLbsS8U2sPZdVLVPd/VuqOvcJBajvNFzPno/L8
	E3WFup0cK8y9Asp+UeL3wYGwUttYFhIgjRxYqrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:OEiICrRfIlq2gkWGxaM71abdVWA0RyT16YrPxYNSMa8=:T0D5uxJd2S24o03Dvb6UPilnsVIJglV7No1Nhoy55qA=;
X-ME-Sender: <xms:ttnParMY7VAOX6LykZ5Hn3Za-BrW_4w3AtdZ8RgvWeEoxT_NDW_bQQ>
    <xme:ttnPas08VZORGNSMdkeSKlVxHDxIa9YgN2fh0SUjXHCkbkexB_uKPQ6sT-peKtef_
    cNero8-BforXjU-UyzO9NJdSPWeLVImo_yTdSVvtGgGzfH0G8yqhHg>
X-ME-Received: <xmr:ttnPaimk-cViRTewj8-mDzPNnE2eLoC1X8mcr23RjV6VMDFnG6WyGBFtv7jhXlSC59PsNKH9X7VmSwzYipoK8Esc59kDX-oSrlgo>
X-ME-Proxy-Cause: dmFkZTENO+74k4HVeCoeCGUZQQKQ4LxUmOELKBieqTN1kXMpTp6FoqcztRmleR6uMd+mrw
    xHqQz25wU4sfXwagvNl5WINabTx7GA+mM7Q65eZYDR0qQ7PQNY5YqCo28E8FQUBDwD157j
    OyfHTGXGEWaPeDKD/2KZCvFXP34GNxyKom3MFa/R8/M/V+xjMvKcwjY3wAX5+pnKOwE7Y0
    iktsccesUdsCGzyj88RQGsRmZnA6V6de43XuwCeBfj+kGRrQFLBuXVvwdwmZ6LJDUeInLP
    reG/91ztSSfHeDHCIhlU8kjg9UregDGeBYq9SLvJC4JkC25Nuvr7xCpmI35MN65usQFgop
    uxplTHiDYPJkQGhRCGyrKCH7zcxGVQ7/hAOW0Kw/1J0uAUBZc6aoVtmnrqGMXwY3dRVo/3
    ifJ7In1D70E1wOL2hj7+kvo5FNI3gsSx9MtxCIj1+KgDAiFLsBwG6UFFAS/37z+ZJZWwD9
    rIYXaiFfYyWN2GG/6CTcBeDBWsRmvOnO1NMplAkFt4wUtypYJVGeI/qm4Mebrnv1BwkFJ6
    rga8zi4k4wbKr6Jun0yaR+pFNmhlg2ntxQBHMrk1SovnMkFpSKCHZ2hcrmpwgJtmERhoIk
    sMcyBS6s8Bc/Pf/H+CKPV0/VIwEi6tbcSaeJelXmqqvUc2AfOPslxSMdbJJA
X-ME-Proxy: <xmx:ttnParXlNP4u3zGCLqb_9N62PrFN_HM1VFRbb_5wkzGubzOmMb7uYg>
    <xmx:ttnPagsp2LBi-pdUeeEJ3siiMv0FzDwi9nS5OizMwl4c3qNS345JLQ>
    <xmx:ttnPama1CeWrBUFS1bzhnSWUqfGvA_5kUJy_JV-jGl7uV_fGW5kkDw>
    <xmx:ttnPanUoXULZb3Tx4XAS6WGGt-7kA2uHbN26OR5F6UUjsDQIlqg6LQ>
    <xmx:ttnPapuL2v6B3PseAJFA-jB2veMMVIOsKGtmDRNRDl0-d9w6FWMtTV5B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 15:36:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Marc Becker via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Aniket Gupta <aniketgupta3001@gmail.com>,  Marc
 Becker <becm@gmx.de>
Subject: Re: [PATCH v3] fast-import: allow 'from' to reference new commits
 and tags by oid
In-Reply-To: <pull.2252.v3.git.1791995252623.gitgitgadget@gmail.com> (Marc
	Becker via GitGitGadget's message of "Wed, 14 Oct 2026 16:27:32
	+0000")
References: <pull.2252.git.1791653078449.gitgitgadget@gmail.com>
	<pull.2252.v3.git.1791995252623.gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 12:36:20 -0700
Message-ID: <xmqqmrsgqdl7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Marc Becker via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index d9de2ef0d8..9001e2572a 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3938,4 +3938,47 @@ test_expect_success 'Y: rewrite submodules' '
>  	)
>  '
>  
> +test_expect_success 'Y: reference pending tag or commit' '
> +	test_oid_cache <<-EOF &&
> +		pending_commit sha1:85b46dd918355ff17b4109ec738723d42f235a04
> +		pending_commit sha256:17e650f097a4db6fe069c96935360d3ccc9b35c4018728c5f311a4217c2ced3d
> +		pending_tag sha1:ec6c4db71feb5f66615214dad2324ce030e777a7
> +		pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
> +		EOF

Looking at the output from

    $ git grep -A4 'test_oid_cache <<' t

tells us that here-doc used in the above is indented by one level
too deep.  I will leave checking how the "git fast-import <<-EOF"
should be written as an exercise to the reader ;-)

Thanks.

> +	git init reference-pending &&
> +	(
> +		cd reference-pending &&
> +		git fast-import <<-EOF
> +			commit refs/heads/main
> +			committer A U Thor <author@example.com> 1712563200 +0000
> + ...
> +			done
> +			EOF
> +	)
> +'

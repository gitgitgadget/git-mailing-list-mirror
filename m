Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12971E1A3D
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792286404; cv=none; b=ek+8mqvPX16z7iJjayrkJcmE5hPRcTD69Lf80rhXlDSzB5vofeA/n8yA4OjH/QnS8yAgoTAg72fw4gTsWjhGnHGBLzhbPCAABZexm8scMegEfvfwdLuSciVZCU4TVpb8Q9T5J2PXc2bcMYcyGgw31KTtkW+YEVJOBWbm9kqchY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792286404; c=relaxed/simple;
	bh=p3f5IrODalUdGY+QvCi+TR2zr6EaoPgbsiI8qABY9lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvmyNdcsKRot9S+YMlSB1faQMKbEJl53SRwCe/di4p5YaBS4frBk38725ZPGNOksMn9oC+3Ewf/CPkk8ypStmZRMz/UJgrTUAHopi4crEPRE+J+kPyA6tkVuay76fpzk7PUSkpXr2gzmUa0rvlgydVXu6Bc6EbtN92iL0BPS7Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hbR1yDlV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XV15pb05; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hbR1yDlV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XV15pb05"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id EF4531D0006B
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 21:20:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 17 Oct 2026 21:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792286401; x=1792372801; bh=qAcuye6hnY
	4jC4x/AhYkMoQyTYxyDBHziuaGNF6Kul8=; b=hbR1yDlVLNtpdExvJ24WhxJAov
	/NhyHn/dm3WKJUedc3b9LyaY3jL377I/ESJC1uqYf7uQPVRNEb3rhyosEsgOpTSA
	3ly+gbdISyffPj0THIl73GszMY7xcBzIODg/mV0nRvLftLNbyUeOe7shyf2oQaj7
	EsGMWKWRcVGdB72NV6MPj89ROmgGqhBtjG980iHzT/QyrvjiSLYXQz6eU+6qmbIM
	KyAsP053nWMh2r8e943nFB4wYqfn18YxvT/2WkVEsFM9neFQSEcQb69BiJMxZQUX
	PhgOECjGKLpxv3vGWBPotVhZNvBhdHNI4DcQ5sU8GaltmEs2zWxoF8AF5/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792286401; x=1792372801; bh=qAcuye6hnY4jC4x/AhYkMoQyTYxyDBHziua
	GNF6Kul8=; b=XV15pb05hVbuXEUIeL5yfz6mRu/3jonoFBmsXj2YNqVYKvuSQEL
	Fpzd27dxQEX2rhkeD3AEAELQ1iYzbengmIaF2T9c0AlyBG44Mo62ZraOnHYueALg
	XlFLUkhUK4jN83C1Upo8DRSE3hqc6uHCGJFTunO6T38D7pyi1inxnp28xCN0ZAKy
	UwwK/zn+8DJ4AgWMEPYBEvKsPX6Rw29D8wEveIoW5jUtS0plgQ46ltwfg1lzfNQn
	A57zYBgkEK4+VPQMZSqhCON3XLU8rfddDne8Axe/Z+pFRoq1w3xQ9MPywyhB0iGI
	+EunOUSkBy3edlExYzsUM+o4+1KwbX+rffA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792286401; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ry6hx/k4jMiKNAhdfGx+tzJ4zmv3f6NItTAzbUjQXM9NlrV
	x/hibkzoT6cwFUXba60R65DqrtrazOxotjn//QtKle2MNJZMyjmHCeVNRvWRZTYa
	oNPs2w06tvpmdwJhSN2bgNPK3RpcMIQnXhCqc0olmtGzX8ec+RId+gwMWRDIhN6u
	CGugVwbtKzWYPV3dQwMj6VlSPjQrlfvu9Wb60RjdHDy1Qd/upC7mZhR2guuZ4r7e
	3DcNPdtVqA1DPPlwi1L4teIMrOKW5QCzBWoahMmX65/1fB+apQ4x4290+ZbQFPHe
	VQndI5aS5yYCw30hnxkdv6FcJRnh9oJLH6qcxdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:kX++JC3fNp3ZL8ihkH9M7TD/R/k74GykUVPbjzJiAJI=:p3f5IrODalUdGY+QvCi+TR2zr6EaoPgbsiI8qABY9lg=;
X-ME-Sender: <xms:wR7Uaot6U3dGKZVphl52zqyO2SQKJtxD2y5ldKG369l0ZDPl-3Vnaw>
    <xme:wR7UasX19GufB70CkTQ3U4ubF548IyY_a2RXEUriuOdykDSCV71EAIfcFDMqIOGyY
    PFZjuzQctyS_4WztDoPPcHO4dMxksnk3FtNGbUmpKUx33e7okuclRg>
X-ME-Received: <xmr:wR7UasE1yhY0am77hyupERGibPWbXIg6f7TdGe8RfYhKM6j1lvE_-A3ZuyHJqJILxtDyw1S3J-6AjfAv0LlK12Oxcpy6akEi_nny>
X-ME-Proxy-Cause: dmFkZTEzH+mohD7M4aRaHcMJwQZHvcoeEF9xW7hh+M7ZCG/clMlywh0Q6zfMzIxYouXEj2
    C6sjGyuIs5TWMdCrSHdtWN1AlkWmx3tAtwp1RHcFn8Y+j5jXiNKc//JUl1wQ6ovGk5hhFb
    8bXw/4blWQjJUy6n+1DK4wkG2Jg0SdSU4pOnXFADI2kLUCFwo6pkvSPOWzBTVyNgDAWwVn
    8Bda1p6hq8T2oP+73mPcVMihTTiuYoGhmUhGm1fZY8vl46+DyVmVa5FT1xEtI9MpZ7eZot
    RTp95XiHiWYPSzU/n2adCIAIYdxr4xzrt06mEYyQwKTgBNNrGzfqY7IG/PlQjbw/x4c2f/
    zEB12K/RfzyhWt/vYURe6wkREzSCt9JECids6BtxHzAH7VeIethxX+tj1ARf6q/JQ2Jrw2
    wrTVgmK/gu8Qloyd/XrNh0wkUa3yryB3FohtaWMbAzPQOCiy9WGtxoHWbs7pSWTmWP96fR
    TPo8vssSwEgg+BTFUQxkXht/VDJJhYLSF6+PogLidKH1nDwkPJO2b6DLgzOFtxleL0Z3od
    J31dmfS+yBaNe+aCF870LPMgq9TUSoKN8P6T/Wzh3PBg/9tzX1uQ3nrpjM220e0WwFJ1Ii
    5xsCxvCJ4TEWrYR54a99Gq6X85NdbbC3ZymAYbFt/YLneJH5BCBkNLU2IDQA
X-ME-Proxy: <xmx:wR7Uam1z8dFluNOdxAmKkD69v_QObtR2xyl_Q7MF8w1d2v-cvvatoQ>
    <xmx:wR7UamPQE3VdTmsYbeLPOOetiyOiXnlx8ek1W0Av9xq0t1ulwc3AXQ>
    <xmx:wR7Uat4F6Z-x5WwvSF6lcbsNPYYCxUZQbWuhdxJeAX1niM0iubfXrA>
    <xmx:wR7Uao07XrRbbvG5pMG-xtv5Cu3__H7uBCEDvtllD8As-mp4Oee77g>
    <xmx:wR7UajUzQvVvtlzqLt23__o3HysnF0u-Z5XMbN7B5HTAKgv1bKYf5m5l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 21:20:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
In-Reply-To: <20261014181134.56220-3-iwiedler@gitlab.com> (Igor Wiedler's
	message of "Wed, 14 Oct 2026 20:11:34 +0200")
References: <20261014103507.35317-1-iwiedler@gitlab.com>
	<20261014181134.56220-3-iwiedler@gitlab.com>
Date: Sat, 17 Oct 2026 18:19:59 -0700
Message-ID: <xmqq7bjfby9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Igor Wiedler <iwiedler@gitlab.com> writes:

> diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
> index 4cc39af0f0..9c3862709a 100755
> --- a/t/t5618-alternate-refs.sh
> +++ b/t/t5618-alternate-refs.sh
> @@ -70,4 +70,17 @@ test_expect_success 'connectivity check of a deepening fetch excludes alternate
>  		--alternate-refs --quiet <deepen.trace
>  '
>  
> +test_expect_success 'refs of a shallow alternate are ignored' '
> +	git clone --depth=1 "file://$TRASH_DIRECTORY" "$TRASH_DIRECTORY/shallow" &&
> +	test_commit -C "$TRASH_DIRECTORY/shallow" shallow-only &&
> +	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
> +	cp .git/objects/info/alternates alternates.bak &&
> +	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
> +	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
> +	git cat-file -e $(cat shallow-tip) &&
> +	git rev-list --remotes=origin >expect &&
> +	git rev-list --alternate-refs >actual &&
> +	test_cmp expect actual
> +'

This seems to break CI only on Windows

  https://github.com/git/git/actions/runs/39084117165/job/117547610467#step:5:279
  https://github.com/git/git/actions/runs/39084117165/job/117547743280#step:6:272

I'll eject the topic from 'seen' for now.

Thanks.


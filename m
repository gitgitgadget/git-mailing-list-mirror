Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4135E1CE
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482733; cv=none; b=MM8AvVbjOh+v8QSf6uk9Tu2Dgp5wx1f7Vv/h8flignTH6h8AMAwBme7/8JdPQljV8Xof7lJWgzW2XtGoXNTqM44NhjKgLmJthNMiu7av3W36KTAdZcD+Hu/CU8S7TIP2/mRFIT/uxFc6ixRyJlarLC3WoFQStZv22+EiIBApNAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482733; c=relaxed/simple;
	bh=Ch8/rLrEcLdiP9ik27v1XqVzFik4kTu2UoW7AS3uLc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RGO2S7nmdGcDwlavnAmk3MkgwUAT7C/cl/y205TBw+Fx6or7YvNURVNYWUe0lJOJOcb2SVPaMVdz+a3n96AH5X9HaKiK2E+OyNcJylDqo3c14ABbTDPGjQ2TkeHKvOqi5zDICUd1PAc71P93t9lZK5JgEWiRp0KALATlP2Y3ZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eutO+T9y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=goyGO7G6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eutO+T9y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="goyGO7G6"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 587641D00054
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 14:05:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 08 Oct 2026 14:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791482730; x=1791569130; bh=rKLh/ozTAu
	+s0XfArIrxtbNf5aHg8VybzVo+61ssINM=; b=eutO+T9yXxkBx2OTBH2fB12+7f
	uju9TMBqBTMsdz96nAFQB/faHksnc95lxrMaFko/NByHnU5zMzrUy8qRDW86vXIA
	8ZBx589MQbxCDN8VoumX6p6Woej2Ecr//5j17pti7YiB+jI/qfxuHCwjgHL5B7IA
	4xXqC8ck6cGJX8FRCEEvxxllHS+VgMCd+RnLsGPpM5rGW8GC7Lzjes5CyZELW/lc
	HsCZgtpFc2LjKwk8hTJbDmZq9o6LtJsBbl+sdy7EI+UXmvVUXuXXzXmGy6OE+EV1
	V1UIU6NBIJP7lu8pOxxAAmnhTrJJD376oZipD8ejQucnJnOkGVtU0uxnn9qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791482730; x=1791569130; bh=rKLh/ozTAu+s0XfArIrxtbNf5aHg8VybzVo
	+61ssINM=; b=goyGO7G6qBgQ2eoyL3ZUCqAnXvX9i1hd3aVh6ZYyWDGJeXenccQ
	VAGk5BOPKe5WWWg2R+MkpjpN8bYi1JxQMZf/yP055AZBh5khspUYUiktXlXP3DzD
	fC/lZoJPwV5SEErrG0LluVi3+MiFFgbwT6S/hEyp8B9xVJpUgpSQTXovZ7TxuMIl
	FxJDseU+F4uVE7zNQdeVA+TLK/cds1tc3H/Gqpw+otopK0xa+rHJGXlfsRETeV6G
	heFK8fcWu9/K+RO8jm+UDCiMOqoLjkZs8A3InMrd39/K0hCsUTPTaayKebmGIs31
	1OOlx5ysHPYeYzVVqb9dnwuaqxwF2k5bLyQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791482730; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Hnt+gR+1vSwsV28aZYgNu2ZDH4VEU1KELbp1nlF9szgyus4
	iCcQNwzU2U2DZPoFiGZrDASanENiC6OVMEEYM1hfgw5T3XjECbh5e4ljJwwsHaKu
	AH+uvW+/uCUslOjgKQsuA/aq56xxLrOMgVLuH1BDrNsS01MMMx78GmvM0BBdZNFh
	1i8rMRHTu4r/lwDsZQkse/ZJkw8BGorU9hGKrLochGiwLaXINKv4qbQbjiIpRnIJ
	mPX2rHq3hDMep6fJ4rZ0FOoU+LSm4Pm6rpQddAHGcHr2aUnLJZyIBv+bsXfbinCb
	6oZjrCZQ3F3TfH2gQaWiwQK4mjEQsjFZGheQzww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:rJzUkrnfc8WgNIOzdKkYBDZFRbHa/vAa6W8zFF68O2w=:Ch8/rLrEcLdiP9ik27v1XqVzFik4kTu2UoW7AS3uLc0=;
X-ME-Sender: <xms:advHarzoaKtks8fXf723z8oWacl9CwMpWT3izRSbXFL9Fs2LY1AJ_Q>
    <xme:advHaqTAQjVppuhyF_EoxqgIGC4F8vIU-xYRQEOgfhevsQPamGiy5VIxAK2sRw2sJ
    y18JTTRvvekQ9Dft-odpTqGDKmu818WToHoUgg3zmCF34lomGGqJLQ>
X-ME-Received: <xmr:advHaqVrmeN3o11q-1LpeusPmrz5PlPyyY2N3ydzR_JnEM2uius2p125oNdNNIOudVQRnbbM6ObjJBourgQMkfgdicFXGOh52Orh>
X-ME-Proxy-Cause: dmFkZTEEpOPSdr+lZ8kWfItkmF7CsYGtT2XGo+dki53K5vqGC4BD2V/F4iUlzvqSPNm+ge
    3Ck2Aakufhb6odMJOaJ5nCX2mQFffFZ/lfpJpenVmw8ClxhL2wv3/3LfGCwaSbzNV1x69M
    sMrjev1cTOZ20J8ZIgN2AB+8SVWUJWS2osSdwo4bA0PCXes3e/C7iF2XcurOMr42xxV7Mg
    UZHhnHOpYajo9Pskjj2IkqFXZnU9qT+3U6dWrVzbSzr+4mJSPs3n72Cb8WijuFdHZieSam
    J1FiXcf5SnIxBdYRkQpwBZguB9X9wC2FN/89Bq7up0v3blWQj9cx0YgSMT6mB5N4FHs+OY
    PvKQ82Jg9oqxq+JNvB1HjpPMpQ6JY3zKr7SvBoqkKndpaun5OZ69S4gx8OvQbHADuVQ6vK
    JU7vIzeuRB3RK9F/L0zJw6DPWHqQKanzlwYt3gAE/uws88dyFt5x3zy9wBe2rGTWozSkCw
    LK3Zw4FJHL2g28mlfYGhutYaM1ymnw6WIUoIb4FJuta0lfmOQ3TvqjjJuVMqHiA4A1qNkV
    Khnv1SafhYSztlFVXbkmQt9jp0oV2xkiN6IrCl4MzXT10QRm2o5dO18zaO3FhygfV+0TGw
    aO/XN8EtLtZ5s4714FuoiZKSFT+n2BEjqOuaSu8L/K5aleHPwi+YYeHFQEUA
X-ME-Proxy: <xmx:advHakYhReo0o1U4lg9S155kPtjO3zoNLcF1GmPRFLiBdYyE4Kz4wg>
    <xmx:advHao1EHel8mnzfXuOtrYv0F3C6DUcY0-kdsVkb8pRXK7cj5tVsVA>
    <xmx:advHaugrn1OJSUzYu_SEEk3Cor6Ao4Hvt8h6T1MMq56nEVg4a6Qmvg>
    <xmx:advHakY1A87suo_udpJHBDKIS7C56Kb87X8jVM_UTpz3ioQSx94qaQ>
    <xmx:atvHahREBq2ffAt8ucgxpl4T0VMf7V8TDCjotXru-JhUYMwkQtew2Q3k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 14:05:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] t5004: skip SHA-1-only test in SHA-256 repository
In-Reply-To: <20261008-pks-ci-housekeeping-v1-1-baf015c589c0@pks.im> (Patrick
	Steinhardt's message of "Thu, 08 Oct 2026 12:01:19 +0200")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261008-pks-ci-housekeeping-v1-1-baf015c589c0@pks.im>
Date: Thu, 08 Oct 2026 11:05:28 -0700
Message-ID: <xmqqa4oo1313.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One of the tests in t5004 extracts a ZIP file that contains some objects
> larger than 4GB and then double-checks whether we can read and archive
> such an object. That test has a bunch of prerequities: it requires a 64
> bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
> enabled. Consequently, not a lot of jobs even exercise this.
>
> One of the jobs that does run it though our Fedora-based job, as it

"One of the jobs that does run it though" IS "our Fedora-based job"?

> ticks all the necessary boxes. But that job was silently broken: while
> the intent was to run on Fedora with breaking changes enabled, they are
> in fact disabled due to a typo.
>
> We're about to fix that typo in the next commit, but this will also
> uncover that the above test case is broken when running in SHA-256
> repositories. The extracted objects are SHA-1 objects, so extracting
> them into a SHA-256 repository is not going to yield anything good. So
> once we fix the Fedora-based job to enable breaking changes, which will
> make tests use SHA-256 by default, the test will break.
>
> Fix this issue by adding the SHA1 prerequisite.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t5004-archive-corner-cases.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
> index 768b0ff85d..c9c879cc5f 100755
> --- a/t/t5004-archive-corner-cases.sh
> +++ b/t/t5004-archive-corner-cases.sh
> @@ -185,7 +185,7 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
>  	"$GIT_UNZIP" -t many-big.zip
>  '
>  
> -test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
> +test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO,SHA1 \
>  	'zip archive with files bigger than 4GB' '
>  	# Pack created with:
>  	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file

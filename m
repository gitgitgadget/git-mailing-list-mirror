Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F0392C2A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315519; cv=none; b=F4oVAPOU6kjUdNBgN0gN/0Vaq+q8Y9ORUkG+lfnQn0Ubv3uDsHz02/hVcEE7aMLEXLdbRyIRDmQKyTwuUWgvmikGfI3iw/kNOoeXxJvfpkWcaTzFYN9k1UzRM9ygIOLFK4uFWeVE0GUWu8BlgRhzOFcstqAugRjBE519xOfnnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315519; c=relaxed/simple;
	bh=gUCytJbaE9UOFBHI7KeLaAECEcHqOqpZ3tysRLN14Y8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GR/rcCUKoCopDjtekOkjlQHC1YtiH3zpGg1Vg+bX8cVMh5Xf5aam24JrdeljfW5KQ0UFId8Lin7/yodctMDdoVqMNFxS6gVxQgVE52BG0USoKyQ3DhbS5lg5SewRx/5WE+Xcp0K3pu5MKJO9yjVDv2A+l8Zei5TdrIAc1trO+DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oDFZ6Qru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=StmPU+Oz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oDFZ6Qru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="StmPU+Oz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE7547A00CC;
	Fri, 21 Aug 2026 08:31:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Aug 2026 08:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1787315516; x=1787401916; bh=dXnFCTeiXx
	UaTyn7m92Kx6XuPzUiS8jn6HhJRtvdSUg=; b=oDFZ6QruGk7wOSCpf9aSR/0xXL
	Mu76wXxR/lCzc6pYBTaBV7gjYjETt4tHbZFQqFp+lXwSGDqjIBdadH8E6Y2szvdJ
	8S2kHdIM51T7NZIJojsqwwW/Iu4YjcxP1VeKNVAxmqGykBfE6xllOPvZjvHzoTco
	g0ixKLzv0I4GduzDb5GWj98PR+ZDM3Ce++SlbPJnkyHQQRgQPtQZngTsd3tcwYOu
	KLucZMiaRUfcUksIOXNTbbwCY/Ghux3ZFANXiIlSDjCfRmxRBD1lnxc4/nOO3crA
	/xe6rr11Y533ajPqzIWw2wqFtpWuNDr4dbcsRnJ5ZLKg70lL0oCPPs7lfvdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787315516; x=1787401916; bh=dXnFCTeiXxUaTyn7m92Kx6XuPzUi
	S8jn6HhJRtvdSUg=; b=StmPU+OzT4nDeIVQJwEk1Vdd8ffWeMf9CsV9YSR8CLPC
	F1DD0qzUxzdccTvOcJ4c7o2CXfMsmyi0NplVB9qINPUCzDULYNf0cf8Bf5T7+0KG
	9S+EQnDzdjytVPKOmRwn+JUMKYDqtYOmA7smgkSjVG1jc5sTEWQXws0N00SzF3ID
	wSnX5Flrj8FKk0MHy6CGt9vJajxiM6y0w6GRC31+W6M//0qS1JsX4hBKpFv0iQb3
	ukobH+tUw/J5PLecTWy26ci11VwlHNTGyE3+R2ZsKpVCfO/Bdqj8go1IjEZXwjTz
	UCN7LtDJ5sA/feCYg/UOaMVEYbCM+AHtM/OcqQOn2Q==
X-ME-Sender: <xms:PEWIanF8Ry6oKsnqCk74soXuLlvXn6p8h9WYWh4YsF6c4QHB4PsT2A>
    <xme:PEWIaqUh_XyW-zNxWsZBKiz8yJzBPkb3TlSOjTOzMPn7h5DwI8aSdH2JSN2hA4ei6
    -b3vqfyWeemGeneeSXPSIfa4azSoxIGqeUzhQl7jZSPmJc-LcUtxLY>
X-ME-Received: <xmr:PEWIamyHZvLjHdwUUIA-_XspzViutPJ6kPa0e4XfVJKdYe4Sbxejm3USsXKOGCccKpP8E30r_XEp5Rw4IXLTG6GBLrHQf_mqHToGGqy25ZMe>
X-ME-Proxy-Cause: dmFkZTGRfne/+efkyWwt8eCzidsWdF45Ryu8RM+wkxLPfssCd9BkSc2Lk1oG7YS0OIQQ1D
    Q5wuFb7jGYpVuYp/+WfFELshqqBOoNx0XQuCaNWVQDk3qhykPBzDbxkXL8MEov0fZHeIGN
    y4kBGdbGMgetCp0Yj6yot53NWWeGlg2KW2Qo0wb81xnmqx1peCDvrlvMDtlv67OLw3WrTV
    UN+g0ksmCTaahmP+PujgNVSsRCc5KOB02krfXG6dThUQ+XYyVjXQxndduCqZmnieu5djf/
    xYUzGE979UdT2z6Y84df0alK/hP6hjClYtthZtI86HdZehW6UgJNH10u+42hMx5hDHOaZ3
    V4rFQuo/1oJaeR7gwkX5BfeTsWNL1EdJgVoWCBT/c2JIesgSKipOPvNYJsnHtcQwPrAxUn
    wHhZ9FQ3Slpk3oekqS6cD3E5EVbwhxybQXv4cYet2PgN1JEr4Iv7frLEcHnl744KNFJQlY
    Oe4XylvSiPS1Ti3vhz078pvm+GTjy/UG+c5CoV5YMxJuWPwX5Qo1/4F5+kXglQ37c6yKI/
    DeOe4rfoaGreY0mtIT6obTzJwioqOOCWSj5ABbNLL5gD5mJUHAkim7TNhsf4CEFQiVU3g+
    Jk8RRWm+UiEgY7P+nirgBo3zJN1J0byRjdkaApEm6V2gsKlR6g3pxHVoce0A
X-ME-Proxy: <xmx:PEWIagP6vPpv3EYh11V3yv5ael4ry2I_ZItUbeNEKpdRsAkIoI4Mfw>
    <xmx:PEWIav6in4lj-7Y03xoqNmy51tIWzJgJKcLAhtTWRuwW5bZawvvV3g>
    <xmx:PEWIapOFKClcsthKaOALF9rf25AW3wi7PQwJSA-TYAk_Pv88lrIxqw>
    <xmx:PEWIalmkW2e0Lk0P2ji9YSJF034wv7P-092cqHSjCKFnObREvhDwEQ>
    <xmx:PEWIan0WpYybvtR1bSFsSIc1remm_IzjV-WaFNzZhvI4_Hw8AP3qsHje>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 08:31:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df0a5901 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 12:31:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] fetch-pack: allow parallelizing packfile URI fetches
Date: Fri, 21 Aug 2026 14:31:43 +0200
Message-Id: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMBCE4Vcpe3YhCSLFVxEPaTpp14ZYsm0RS
 9/dqMdvDv/spCgCpWuzU8EmKs9cYU8NhdHnASx9NTnjLqZ1ludJefbFp4Qkb3DEEkbJQx3DFCW
 B1yLKnfW9O/vWRRiqsbkgyut3dLv/rWv3QFi+dTqOD3E7SNKKAAAA
X-Change-ID: 20260821-pks-parallelize-fetching-packfile-uris-b1ad24a82fe0
To: git@vger.kernel.org
Cc: Ted Nyman <tnyman@openai.com>
X-Mailer: b4 0.15.2

Hi,

this patch series prepares git-fetch(1) and git-clone(1) to handle
fetches of packfile URIs in parallel. This can significantly speed up
fetches when the server announces a bunch of packfiles, as shown in the
benchmarks in the second patch.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      fetch-pack: prepare for threaded fetching of packfile URIs
      fetch-pack: allow parallelizing packfile URI fetches

 Documentation/config/fetch.adoc |   9 ++
 fetch-pack.c                    | 228 ++++++++++++++++++++++++++++++----------
 t/t5702-protocol-v2.sh          |  44 ++++++++
 3 files changed, 227 insertions(+), 54 deletions(-)


---
base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
change-id: 20260821-pks-parallelize-fetching-packfile-uris-b1ad24a82fe0


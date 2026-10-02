Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8984E322A
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958493; cv=none; b=Kq5Pkkd8a/HnAsciUA8ELA9Pnl9414h8ETdUmvxKzLZZzUvp63MtlNXYF9MgJFtOdYLGaQzOrqcdQSSOq39RgAy5YVqz3Wiy+GGytIYlvhqmOPdm7m+ae0fuWiZ8mWToClmFMYFCOMgtCO9hdnwQoasGs4mgzLU/w9MycUhkDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958493; c=relaxed/simple;
	bh=/RTKN3h/NwjsCCV0W0WoME4ohArHIYzn3Fki68tKrzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=id7VohS7sRB9CJQDIpQ/4JycPESAYZ4ryp9MF0BM1u4pT9JhFLA/kJN8twTYbwTSRaLkT8zcGxMzfk13+USwrYqKLZqD5LKe2cUGHw7vjigeUOsJb2ycB8dIkKx8MivHG54ox0zXamO0+SoDQuPe/Xhyku+bHYozNtfNpjJjJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYJ5KBes; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyO6GhFJ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYJ5KBes";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyO6GhFJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 64DA07A0134
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 12:28:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 12:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790958491; x=1791044891; bh=/RTKN3h/Nw
	jsCCV0W0WoME4ohArHIYzn3Fki68tKrzA=; b=MYJ5KBesynYyfHFN0AMt6Q6wpk
	HNgrOJTyi1s3cVrhhrL+f6Yi6zW09TkYBdv7b8EC53fB35SpMC8BntldLcjENE/i
	UM8/M/Qel71jvpiw73a2wHMsr7ECuEcALfFS9Bo/tSFK7RnmSpjNrI/YOi2546OP
	OyQO+y6f2mK6XPVj5U1VV1jQe+zpCiy4NEawqfCSDItQ/ZaonTjbobjxuf5U6qoh
	A9lwzGUqBipYI00N6Y93ZHSLzfknkzeChJhm+ZIF9UFsjSehCQyrdxxvY4IsHqIZ
	wbhvMxAifDV2PphTgak7v7NnCgpaepIHGARL2MZKrME5XWoO3aLpp8pilUUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790958491; x=1791044891; bh=/RTKN3h/NwjsCCV0W0WoME4ohArHIYzn3Fk
	i68tKrzA=; b=IyO6GhFJQtwC5xglvIGFdO1ymH0fZIheIQ/EhBHowb5LHpA0TUW
	ONiEVwYAhE2uceIKIwSHM6p1yKUR3rNCgou0U3gydXQb45QJ6PCdtqrLitFUGh1u
	Y0vkeW/+f7EvYEX50ZMDJZSRPxmT+G2M33XhUUawx8LN5A5teracnIzQtlO8qOY0
	g/0gh62lOh1tdILkzSvT1qX69VBmlm9c3GQ2iHFVy6b+Eus86UgjfI9Ojf9nwtqQ
	QN8Vg2BEoKHKYeP0IvyZWEWgJzMhQDMfF6RV83jgkpGKrRqyb20mmxDTOm0U9Ytx
	WLx1ejmlGl9PT2mxM0daDt48PQ+prxzMtbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790958491; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:tHFP6fkKJjOWshjEWUpa0yBR9w/THpd5E2qxZ99F5nl+df1
	OvE6jRawmXTEZWP/JePfXOjqB8AI1gdEsKIEEx+3Y/n9l/I4mR7huR1CRXCuNrxg
	h6e6Bs4fbpYGZ8DSdGuNy4uV4+js5d1icev+OhdYMPgajTobQY1mZiA3/2ByFD3w
	XcXrUfQEELXBTIBLYTMxgYecet0z8apZX8meFf31kE0VVCHamUI7IrZHSMFXQM8J
	/EGiSNlDfSUoVV4M/HdjStZHfNlNR14B4XDKdTNQpBc75RAlWbx3l7yVYhncir1w
	y2xJir7dTXmQ1gmd9/DlSYilMo3zw5UF5pkDUXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xdPzCDvazrLCKI2gXwn5587/sJnkWKjCBAWRT5vYvQk=:/RTKN3h/NwjsCCV0W0WoME4ohArHIYzn3Fki68tKrzA=;
X-ME-Sender: <xms:m9u_askQrdd8-9z2miYbGw26HUft1eVhtXMDo3CIof7ZIhK3y953fQ>
    <xme:m9u_avj8gRBiwXxUPDfXq6fPx_Ye1uNxDjqkw1EDj_LCSh0jODakskdZTiqFDRVx6
    RwbwVZPzW6wRH5Gh5rDeHo_Ox2kQcU7Lg-kn_TfFi3dVrwxcpy_58eZ>
X-ME-Received: <xmr:m9u_akfgAl4MUJSvgAzubwSpWSIjivsAWcKv4gKmCdKHyx_kXgiXAsEBkzvM4rYj50KFoZUKogTCLHEIKgPkz8bzm3RhFt7sKzgC>
X-ME-Proxy-Cause: dmFkZTGOVX/blgTwWbvBys8CEP+d+/ebyJTSN4r4MNhyJdNCnDd/wPDb1bJseg4qP7Zwfm
    RsayP6y6itnmF/d1MSksGCwV0M84JNSq9PGwl7dNqd7D6k8OBFcbJiY1c8/Ko8f5wGHVR2
    VcFFQBO6sqgY8UyyC47u2me7dAHmME+UqlwUH6OdgtB0M3OxtFS8szqykjAUPuBH/A4UBU
    8f3Guq/3wIa0UYfrR3WERYCzcMMvG4cglE76UxUtDkCTEGVf5ZVVa84UkBrSuPH2rlTufC
    0FaV9UoNbQWjukqFvj6lbedpPOhISlqAo8nTuQW/dH9xZ6FZZ3JgOxt0aTPbc4tdNm9zNd
    K8dVCLDJKDf3yv+nDHyXht679RJJWJKqeI8OFFvOQM5FcfKKfPCdhNnAqckJma+8xp/LFO
    jQ8EPkfT5olt8Qt/Ictq6EHNhamff43vtKw5q+1DKeWpLWquzu3E03RWPFk4Llut9oU0g9
    buRq4nOxNk/cLhmrFypNIO9AJSMJcoV5qCv76Rf4p8z163i0namoMx7irMrY6GAzPlcwz7
    nSroIe48+IDjmjR7cIEWYv8hiYapA5TyUNY4RxudntKsGASWc4d1b1qTFpDxJ+sV5zuKYX
    jCB8fj0zk4bnTLeB7mcBEGljqbddwbWF6ztJMJMfydN8kWjc2KgYyEi6cOdw
X-ME-Proxy: <xmx:m9u_avi3GtS3uXIiha2uHqCj4jPgDUMaOpt796KkPi_a9l3_vJcV_w>
    <xmx:m9u_aszzvl9C6ryXDIq0uEhefd8-WgF-XSn-74WeZzKIsCXv-RriPA>
    <xmx:m9u_arM0l4pinVb6HnPagb3vL8sj3ujymNTwJk4V1t1oHy1UlR5xbQ>
    <xmx:m9u_atW4xrjNs_MtUAsiCEbyF0UQ5RQVP8d69GTnvs3MZvoMvVmpjA>
    <xmx:m9u_aqHmziL4fCBcwLVawV05YpLeCTaXjd_5y9yc3Smhd39sEEjYbMfv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 12:28:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5 3/4] remote: add "git remote add --limited-fetch"
In-Reply-To: <b45f3cf0ab1e2dccd87cc4615e0ba15e6cc996b6.1790925198.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 02 Oct 2026
	07:13:17 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
	<b45f3cf0ab1e2dccd87cc4615e0ba15e6cc996b6.1790925198.git.gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 09:28:09 -0700
Message-ID: <xmqqzewwxe1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A remote added the ordinary way tracks every branch it has, via a
> wildcard remote.<name>.fetch refspec. That is wasteful for a remote
> whose history is only worth following for the branches actually in
> use locally, and it can make "git fetch" negotiate history for
> branches nobody asked for.
>
> Give "git remote add" a --limited-fetch option that sets up
> remote.<name>.refmap instead of remote.<name>.fetch, so that
> "git fetch <name>" only fetches the branches already tracked, plus
> the remote's default branch, as described in the previous commit.
> It is rejected together with -t/--track or --mirror, since those
> already say explicitly what to fetch.

You forgot to remove ", plus the ... in the previous commit",
probably, when you updated the series to stop doing so in the step
[2/4].

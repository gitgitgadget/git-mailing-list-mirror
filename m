Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2051481641
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200830; cv=none; b=hxpZ3lthz8plq7m035nIDV7XARZkbTlB6yv2XX4lkoe70fsUhpTHU7i1Li+eQCGzDbpePnuRyYt95lW4POQzF6lDz9eIQhZAnidP8bcLAppmfRlBEJseaf3K2MgPWEVJPc9/D9wG4Mz4ze/36uCra1K2IX1xK0tGyM8il6ZHTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200830; c=relaxed/simple;
	bh=t+ArDmu/Sw4NPMhOc5zk9IaniXGiX+rXCb1XrOOU2yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfH5MxSUoYJZi0wJlSk0BqkC2qW5a9dL67i7AmEv1gpKIGMx+h8N9XLP/T9JU1UuHB/djZv/wDPiUCPmIKF1Lh8oA/oUAHx3sMxoaEUOJRLT2Unqc/TVZJsDGZ6W+6FUm3ChIz+Y55TlUT9WvLBXlf8uzVqbsx0WbzeVqZmK1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wzl7xDNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2L1f9CQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wzl7xDNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2L1f9CQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A339EC01E8;
	Thu, 11 Jun 2026 14:00:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 14:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781200828; x=1781287228; bh=NmDFF/s1+J
	N9I1mqpyjN2pKk1fqwFYr7NMxFc06WJXA=; b=Wzl7xDNcp4sugox0fLz0vpffar
	4qiTVwdQvBYC4s59o+OPflPX2DV4arFBSsW9HqY1LhrsJgAN/PNK75Z2+B2CrSla
	jwcASDV5o+/OHtHHtSJWrJLzihx+297dW8YfWmRktgsNpzwJ1KmJ2ZnME74C3YSs
	doIhKS1M+l+YhFKN1EUd7NdZbgI2g1tUMHiFH9OFNjsByvoKokosT01LJMMlYcoC
	UzA1l3YhZgWq7WfemFK8LzV9TLS4oRqvahnv9mbhjLRPGb8ZS5PamOQQNAm0EqCy
	rHSECuRcYRg2+GNaOcvh6IZLrUUpJXcJCcO8Nu5ngA2RKPxvlY8pYBN2sYqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781200828; x=1781287228; bh=NmDFF/s1+JN9I1mqpyjN2pKk1fqwFYr7NMx
	Fc06WJXA=; b=c2L1f9CQ/wbq3eeF5Qwvs38EajyeX375NlzUYBmy4nCgMhUFs/l
	/hqQ8pKxlSOgPOuP/520Y0khxacmIqGLfATWwnvnI1Pxqf8V3vtogp7j8Z+p92AK
	z1xaCcIXWmFp9SxwGAc4GwobSnshAa+JIipEoqVVm5HcvxY68XFwiRDqL6T02aDl
	TXGfuQwg0z876VFBvEGSqP+KV1Rl1K22SHM+yXD6z+9vOY30pyegpn9ChELpDoUZ
	jYHjwSZ9/Dq1DAeRkE8erfg/CU+HKhggwrwgtBY3E8d/EXUpED9yf5jOlcNzds90
	nGehCztmX5ZH+Ip8WJpaOJSA//1MgWb/2tA==
X-ME-Sender: <xms:u_cqatgO3lFdA7KGwUd3U7touQuw9o3jm7A9l4PLm3sKAOGLNiB3mA>
    <xme:u_cqarXR7z_1s8fwBPv7As6UC51EcSt9OAgmP1ZhGkX6-Ieucu702kVzDhwFDSto0
    4CTWTw4NKv7y2Tzm1Np63nx_KtN4_96_djq4mjIf51kF-Dj9B47>
X-ME-Received: <xmr:u_cqakW31l6GxTDuUbRTD7TBpmqJog3B5EoQwGLT55aGaAi3N6dVHt1kQKTyHTnNFL105upnm68gD5LDIcqbZPul5-3P2F64uZJd>
X-ME-Proxy-Cause: dmFkZTFMmnFmEldTIFBAvKGKq484xT7XMxz0h5wd/e8RBSUtgh9PinTkgjYgj4S7Uv2WZQ
    e4fhNyuHhcUL4Wpp6NlN+yFvvlszadqhGuAWVDJk785UkyHsyMKlH86QMN9z5LhS5py/5K
    ssnbp6rabDKjUvHe4/1BtbkyPV9NcwRBI+FwTcTLht3T9LhpOjTNr3sCT4T8URPrQFveHP
    lelHwc6wBMTZmaYGk5Gmmp5Immne0Mr+skA1HcLtQ2FpF3QmDQPAxv2c+1DX6N0OBpt0NL
    RVj2Vm77jLzONJOU/dO65YhB3ChGJjdNMrhosfMReKDgSJP6skC/924SgkSYsKkALW0Bq4
    Yec4hlVouSvf4bouuL0ReXcBC2Q56RnRJTtYC/AsV2lDxA0J/qekY1FEOuBd/itLPBa6BE
    U5CUFC2WwNxko9SoQdCzIjsYspErmnZNXEzErJokSfRw+3+7ukliMwA4hTCR8xetcmso40
    vhQU5i8qyQpH4ndy1FeypgcN1FvFTsvpkjAn3V949nfmzn9Ddmm3DdKZ87aE+aMjGGJo5c
    0NXjEongQe6QQ42jsQKBPE5Ri4VOD9CvACWPAtun1E0ON+MqEC1qgL9fizcYkm4ClATjYj
    Ekpb9n3OcQ5ZUzI30GgidKmu4AQlpo2IftHcSGCOw64dOaiedhpQ2mMrae2Q
X-ME-Proxy: <xmx:u_cqajgl4KKXuI6p6bA58Nep8qW4RoASngi4SbTV_4iPe2Fdo6XpZQ>
    <xmx:u_cqanafiKih5VheCtCX4HjXp1066RRNHxaqFAgY4xdYC4CtxxOmNA>
    <xmx:u_cqaortBdUVmqmxx8HrbrF0xRtKoVtGyFZCtqSv3v1F-bbf4gUoJQ>
    <xmx:u_cqasP7a5lyBQ6vxsSdicbzm8d_8UUabdxQRPok4-geevN5luY2CA>
    <xmx:vPcqagocjU7Wfie9d7rf52sye-6l4uasCBnCdtQyBSo6TcqcBv99owiJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 14:00:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 06/10] reset: introduce ability to skip updating HEAD
In-Reply-To: <20260611-b4-pks-history-drop-v5-6-34d35725559c@pks.im> (Patrick
	Steinhardt's message of "Thu, 11 Jun 2026 15:27:09 +0200")
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
	<20260611-b4-pks-history-drop-v5-6-34d35725559c@pks.im>
Date: Thu, 11 Jun 2026 11:00:25 -0700
Message-ID: <xmqq33ytneiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that in a previous iteration we instead introduced a flag that made
> callers opt out of updating any references. This was somewhat awkward
> though because we already have the `UPDATE_ORIG_HEAD` flag, so the
> result was somewhat inconsistent.
>
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/rebase.c | 14 ++++++++++----
>  reset.c          |  9 +++++++--
>  reset.h          |  9 ++++++---
>  sequencer.c      |  4 +++-
>  4 files changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/reset.c b/reset.c
> ...
> @@ -129,7 +133,7 @@ int reset_working_tree(struct repository *r,
>  		oid = &head_oid;
>  
>  	if (refs_only) {
> -		if (!dry_run)
> +		if (update_head)
>  			return update_refs(r, opts, oid, head);
>  		return 0;
>  	}

So when refs_only and update-head are in effect, we will call
update_refs(), even if dry_run is given.  update_refs() does not
seem to pay attention to (opts->flags & RESET_WORKING_TREE_DRY_RUN)
at all, so wouldn't this mean that we would update even in a dry-run
session?



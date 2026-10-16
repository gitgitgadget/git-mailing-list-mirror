Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7946E175A85
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128707; cv=none; b=mty0g8mLO7qyu9yigHnPlhxC0e2lfh3On7OHaEfKOvZMHRi1xJniJKGJU5Lw9qeKO/iiZprtlj6XUMou7NXc8SXUhQbgcwiSPLZ+eePY8iUspAMCcHJnIAozLbpIblZK355IM2punvrgJNFzl1v1RzGOGxK/K4us7l7b+ppXPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128707; c=relaxed/simple;
	bh=eSD5iXiLH/6c6fLfyIBI0ZKFNYsnQV7AFkLRz8p0M14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrpmLqbJ2L2qxuedM1RrQgVAmB+GgdLJ8TgObjFPEe4zU6ClFCxNz0jaJYi4AuIb1NMJOpVhG/1jtAvaJEZL1KGYqCjCtRJX4l2qtPbMomdpfYZYLW1DBDMMSaFQl1RnozJgELAE0dCvVAwrFQh+KV3bLeLZprrzkiKIs7YwVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kLn4+AnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ml+YQKOe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kLn4+AnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ml+YQKOe"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 89DF6EC004E
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 01:31:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 01:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792128704; x=1792215104; bh=eSD5iXiLH/
	6c6fLfyIBI0ZKFNYsnQV7AFkLRz8p0M14=; b=kLn4+AnB2a6+5g3kYQw1xoRv17
	gt96OPfzCUI3Ge63fuDwV7Oo2wCzwkWG5exuiR5FMlBK5rsggTGiX2cJZQg23x66
	Va01/611SqXte6Ct5kL8LMQ1lmL+dHYpuzNPIcbiolHan5y6VNuSOYVIUQLtzCCo
	nRSfHnZMGCIulTr+Qcs0FNnqQDdWHqIi2r36sPmnW/S0YOXO/S1z2vtheAoVwWvK
	dRH+KTMFhT/er9hJNZ6Kwhxh23/yYVGeoo0gbrncWpmVzbVZ3+1Ktdy7LFVsSgCa
	6Z97OTEL35TxungbnUodWzrRQXl94jIliOjy0v6A25ciQs80lsDtCggI1AEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792128704; x=1792215104; bh=eSD5iXiLH/6c6fLfyIBI0ZKFNYsnQV7AFkL
	Rz8p0M14=; b=ml+YQKOexV5tpKjtJjaYUqTM3TZGURtuVMwNLQgsLQnJD99XAM3
	BKytcv6oQvHDMlQQ0bUI7GSBTggDuuP2UeoSpYM7G4TKhQ5siC7FJ9JVbokA3LHV
	R4x1MoiMxxhrCFEaHr3ggtt63AjPYf1Ha/6x6L7iGiQFmZQdN4OLK7IH5B9B1dSS
	TMHdQlaw8DptRU9vLJEif1ilzhM+cz0D/3cxy+ZH3em6h6020HtvEZvzahDh4d6z
	RUuLMAfbdDgkVVMyd0dJkVwKVFAl+2QX09x6DXhSkpE9UAgZeTlxwU78cwCovh7Y
	9pSwoLWQAaa2OP8dLq5Q1dk+f2+sWPD6PAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792128704; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jBMM9eUP/w+Ay5kx9JS0gqPgusWpb6L8blfWuaw8SWWE4mz
	Bdo/pNpt1DGrXG/b/2zNjjDI8lcPMCeDms+JqoFGovb80ASKbdViSbtKemSaSK0w
	HHmLaTaefKJIM8txFtt0dG6AZNjUBMcKUej+db/QqwgMFoeWF563GxKyUrdwkAlU
	x/30Yzf0mKNGGbPhNwnKP2YgSW4S9+5R3Xngu++YX1rk8wommowiLH3bFuEeFNdZ
	xn3ziqBVfxCbeYWEPqy/j/5fFBXTNpmvGKZg/uZcc0rgNlcKRzxTQlLUG5cm4Yf+
	cvksvZwNRFShRGFGrrtM/YRCipLeRHPWeIWPm5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eUQKjI9vOajvAmuW5xr3xx0yTblXe0YsRIcg5hVYprY=:eSD5iXiLH/6c6fLfyIBI0ZKFNYsnQV7AFkLRz8p0M14=;
X-ME-Sender: <xms:wLbRaoRDjNIwh77mcRXY5pZUxtKfdIkFHT7oSyWfEuXmKQzwSK3jMw>
    <xme:wLbRatNO4xHJMAvBp-t5RpWKAIJehv4G0zuJzEK9K5l0iOCVIoIfFQvvFxf95NPVL
    AwH1HiyLp4zxF--LD7J3jc4GsMterAup0xtssur9OhRnjvQO8tqow>
X-ME-Received: <xmr:wLbRajMqnK_QsUMtJnd8H_8M-vqXNsmBGWO3J1qZoI2Ezwa1YS9DKg>
X-ME-Proxy-Cause: dmFkZTEH79noq6ZVjdCRJ0c/4Nj/0OUaTxBfGokUxsib3/ODzDow1OBET8HgWxta57zUvq
    YNzow+2Otca5RJxsWK/0SkjTjXdYsoYl5JwmtUYOvKLssZP3Z5mmO1BlhzFj/C5tntBtK6
    kzPTdxJS6yL2r/GtoXrYuk80cBJ1Q25vXzo+X6JDdOYaGG+CGpdaIROx2eU0zyXxQ32XrP
    JtEyDNUOnLIYQAI8huOhsV8M4wIdHKR6JBB13mGXxG0dcn+3HN72YM5PrPQ/I4rZD/2jV/
    Ah/C5CvjDdwkKigFIODQAxzVa8A+MA1wKh3WW6nkFJ+c2xDnP6Yj9odsO2wKv/qyIZbIab
    AMKsFsOTrP2NWL7lla7YU8Y/0mKvOrjv0TZXg7VWLsfKNfXRcwUxvo0M75qbbbU+Q4u3bk
    b/C131FlO0k4nZXp6zO42zqGWkHFzx422pAoVJWajZEavy8l/UjSwqj73AuoQneIHObS4P
    IvR/c5GYbz9tXBSPNNlUCJY39Hj2XFsvXUqtED00vXF5xud7s1zsDD4as7WQEeAobz1ImU
    Ztz3mGnfGEFgVM12k1ecdJEzOcDDyD4dhO0/YgRztp+jkZHbDh8a7vbDlBHTrijSS8SRe9
    gUxxL56aSGwF1rSxaEV73RhvCfTZtNMbCIP9EA5DFk7PNcXzYbc8oKlHFC4w
X-ME-Proxy: <xmx:wLbRaltNNh04TDHBrSejSM3b47S1bDwFRcwcUoRZ7ixjFOT1Fs596A>
    <xmx:wLbRalUt5N1u2AdU_fuixe1MVke7uasFG64EmJ_pB7aqiLbYU0gp0Q>
    <xmx:wLbRalsszwVINNEeQtrzX8ogyP19THmAsU_F39xM9Ais1LtJMBmBiA>
    <xmx:wLbRapWuxtZMEW8jGHIGbxKdf4T7ejdGTnOxt5xM22p9aR36KDpOmQ>
    <xmx:wLbRan08Rb0vV7h1776kBExepGq3dChD8wVzeaze4LwKFh2H96cgdJV_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 01:31:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 898b1972 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 05:31:40 +0000 (UTC)
Date: Fri, 16 Oct 2026 07:31:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v7 0/1] repo: add revision filtering options to "repo
 structure"
Message-ID: <atG2ukqpl5pA6V0H@pks.im>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
 <20261015170518.48395-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015170518.48395-2-markchucarroll@fastmail.com>

On Thu, Oct 15, 2026 at 01:05:18PM -0400, Mark C. Chu-Carroll wrote:
> Differences from v6:
> - Fix word duplication in commit message.

Thanks, this version looks good to me!

Patrick

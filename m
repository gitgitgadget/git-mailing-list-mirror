Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE037D11C
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765643; cv=none; b=VkeOkGTFutB5i9qxWgF1czT42kAQN3oZGViJtDZcIaDD25KwQcRCNH6xCu3A5XdHZw58F7O5HJn4hhNesrIsUKSGIYTgAJTgO30V2EiGhw/6szkepREb547yDPF3OgnIXQm0L8RElGEufbyTSIDwUwzX4JHmyJbMKdOhWWF8BuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765643; c=relaxed/simple;
	bh=5kkO+St2sKX/CdSMMyktR+7dzcladCqGC7o4f1+S8qU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dV2o80heGHZMX4ViyaKl5fvRRQCkxSkec/LhOCRLS6tqa/fBcZJ0polVVWLrIEb2E7VJmRWDGgnDgGW19tttIpR1btS/8X/ThlxD+qmHIHB4tpwdyNKr2ilLyLPek/V1TZRINGehofqka5WRaSTmHX5jPx9ZgfLFU8Vjx6ZG/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a8KdHDnB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PID+xOQE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a8KdHDnB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PID+xOQE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 108CE7A00EC;
	Mon, 29 Jun 2026 16:40:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 16:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782765640; x=1782852040; bh=gYppqvhHRK
	PjODeN3IoBoYupozxMwCBR8C4Cuxy+wjc=; b=a8KdHDnB/PFJZ4qjDqo7PugiQP
	/4XsqwAHlkPIoTU0raKceqRhpqT7nwMSwfcub0ywNwnWebw0EOY9A+HFXTowLSYA
	6OvK8F/hwBFGLQLXeDB2jRaSYtti6Fb+LgzotDzMW9whPL1f6mLeMTcL7N3Gx5l+
	v6R9kuhg00zWlgPO1s1XLWQxnLKSZYmazOzkDkytBRGrPMUjQTciRhjGlR0iH9mN
	fLH8pfI6VRwZmiFsGoxB83BSRgwOnAPwQgzY3oDjt5w3rscJgdltiR6C9OaHrHIk
	Y73s0T+xY43s4rPtQcVO3SZnTiW+kuieUzjCvcOXrCZGJM0MMa+6+HeEKgIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782765640; x=1782852040; bh=gYppqvhHRKPjODeN3IoBoYupozxMwCBR8C4
	Cuxy+wjc=; b=PID+xOQEZIhd4/YWuMJsnazbakWsSK2rS6STL6ClnpxcIaVG8ea
	p7z60WCX4iPxOI2xB80phStebzdONBJHt59CSYH5idryWAzbyA3O50tzpyNJBzzc
	+OoqoEse5fJS1z4x3qso0Vi1Wuc/licJqI1ZFmr9z2iZSp0fp2eXFdOi9x9xYIzq
	h2HAtofDl7p+nJyYIO6xldWvGgMsY+2DCTk3JeC4xHFePABdBooRN/6oyUERlrRX
	3oKOcrGQYr7tdWxwRa1Nj11UwL4m4IFHKWUyejDS3q/wA9QgDOyM+YrNRxCVgSOz
	JDMKYhFelSEWmn2aZJJ9gQ13jSTMWzqk+4A==
X-ME-Sender: <xms:SNhCavz0drZQ7i3b42Un5aJ3AIYKsmZ2eyKE7EAlV4Q9choGF7OStQ>
    <xme:SNhCap2XxCOgdmqo751OonlnaZTBgQdZymX5DA-n2XtRfKbSRCk1ecmbikhGTHYE_
    TRR_j_QXNL1GFY_T6xNuXSfVmQhkXA9ch2kOeY4MhopsuzGdYBQQA>
X-ME-Received: <xmr:SNhCas9wxUwoBVacQvKVR_X0CDALty-OT55YDtv4M506dFI3c6v1-7xD31aeRC9puM317y3DNeD5L7cAo3BzyyfBa9xFe3Xj0T4tcKM>
X-ME-Proxy-Cause: dmFkZTGOr+dHhQuBx29JSR1h5hIP7jL7kc0QOdJqLk4nHHRjcPYQct0HhKupaTWrlQc8uU
    6Bk7M2v7880gO82SFdBnIM2CbQZKdFZ1rrj3Qd8qnc0wPW5tqtoo6nq2HACJm5tIH6dc5Z
    Qmqxl1vyBipROBY54uGtuDma0cQdOnKtCD/SuIXaX75S5uyQ6NE0t66Pm/Owytz3UjM2/D
    fMtKuzAWlp7VCsbShzUPg9nnDvynR8kI84IailLMUtTjORppQ/9IzNqknlAd9pEl13ZTNK
    93+U3Yc7X+fUt6MCe6KyO1Uhg4v2/RQe3VmJSLCIjze7TPlUQLPdYcWTHDGVHjQXGmPvlX
    ssruLj6OfEsDO14wLBcT67ZdWhrxcZiDSsTSdZ2ERs2TbE4Rk68/o3q9CbilvSmoxG1wdy
    LSo56XmbxQQ6zirD2vtgOX6Pz/sp+cf6r7zC9I8w3UG+taBEdXmV9nmEz4IfRPnSzt+W4Q
    Spsj68+VoY+IIRMBRJ6bvshGK6FB9rqSSZDMjBrIWltVNt6RDPQGnNkiHEOcFnuPhonKZq
    e0h+5hnZUpyqcJqFVM4yWfcBcus/IL6vKN85YSxMotzYiDB2N89ipRyBbIo3LrkDwsmcrH
    c5f7mKFwp92LrkaLVkts4tsFxQadJMmknvSkAWdiRL07Tmigba7Gx58brifA
X-ME-Proxy: <xmx:SNhCapq3y6Gq2bSidq_2ua7IVafIvI_4x2npYkfflx70_LOY7csRNg>
    <xmx:SNhCamS4KToBZJP5l62m-rJz4jaWMg_I2mixLe7nxf6YQKLwZc1xGQ>
    <xmx:SNhCasMQPwVu6WVi5dWjZbVHr5nBPbUeAuz_bfLdL-0u0qNuukNGcQ>
    <xmx:SNhCakhRtDu7GKE2irat0Ka1xQONdLB_8Ym3WLIBScSCh5dXnbprZA>
    <xmx:SNhCamU2MHai2VcGymRDQiBAu2CrXGTejqYE9K7Tz3TLpwzcDbrm2C3v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 16:40:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,
  Jeff King <peff@peff.net>,
  Karthik Nayak <karthik.188@gmail.com>,
  Victoria Dye <vdye@github.com>,
  Derrick Stolee <stolee@gmail.com>,
  Elijah Newren <newren@gmail.com>,
  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v4 0/3] Reuse --contains traversal results
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
	(Tamir Duberstein's message of "Fri, 12 Jun 2026 17:49:11 -0400")
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
	<20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
Date: Mon, 29 Jun 2026 13:40:38 -0700
Message-ID: <xmqqqzlpulkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> git tag uses a memoized traversal for --contains, while git branch
> and git for-each-ref repeat a reachability walk for each ref. Reuse
> the memoized traversal when generation numbers can bound the walk.
>
> The first patch makes the memoized traversal reject cyclic replacement
> histories. The last makes the non-memoized path report reachability
> errors.

This unfortunately hasn't heard any responses since June 12th.  Are
there remaining issues with it?  Or do people fundamentally have
objections against this change?  Or things are too busy in general
that there are more patches than there are folks willing to review
them?


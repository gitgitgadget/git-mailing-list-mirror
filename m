Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F335FF5B
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783919942; cv=none; b=ZOGkNN0Zs0ZdyV/jwnHw1hAIFItvwzVJGP2FqHgCYkjBwUSQw212f0zai79yVI0xAD46a8JX9phZ5eEjYnxBbJiDy9OEY+yk4S2bG0G3DLyzQjnjtMm8j1h4Sg8z2BytBw52slNXubMUfhK2dV0AQ9LVFN76lNXTvOHEqF8MMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783919942; c=relaxed/simple;
	bh=Z7YhhR+QvbAfScUEvqpj/c0c33SiHDAFpQO+xfmqeQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAV7sr/VZUtZtg3VhriG6r9pP965ehf+g1Eodt1qTcMYCZzSEP83rsQmKBVOWNSzIEnrINNTYpSNQPViEcbDUX0DFSsfA8VZ+cH9IJliKPWCUnjhKjjh+zWjOCOr4LIsINbQj6zpVze3ZYnEBQRIg2D9MZiHyJzhXl+B704MMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aNnIxEoH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IR530e1A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aNnIxEoH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IR530e1A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A295B1400098;
	Mon, 13 Jul 2026 01:19:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 01:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783919940; x=1784006340; bh=21tHUpdTjD
	AFiWoeE7MstRfXkUNov2WvEaw4/lypURA=; b=aNnIxEoHflvZrTZyDfuQxzWeSD
	Ecgnt4oIwy776Va5vTYiquRrieYwGiAVL/jkx+9YrIfqzIsYMutFVW//aJ96Ird/
	+2d6cWYNftZ8lcO1h0rJg0ql69PB0vrr9htPNeryHXCTKiAj+UblqT91FDURYLh/
	9Q2Husw++FsfFYJl7h/08UqEW5fLsRUaBqqGAfCbWkb0W2iUJdiJDkgKsEITIkaE
	rBCeQHFQB8eys4feb6SoE+vPGpeT1B6GScQGx7b4BMe6CS0+dzVNHmMPf9a/bj4i
	nQ293FLkkHE/lWeHvXCGuv3kadEuOBdktBn8tUlr0RCIowJRFrsrLBVEhuRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783919940; x=1784006340; bh=21tHUpdTjDAFiWoeE7MstRfXkUNov2WvEaw
	4/lypURA=; b=IR530e1A0DK0OkuxlC9AJZfl4a1Od9sHwfhx5LAKC2TvzLje4tN
	kwz3ouOI0LFLwTDqm2QkHcRU3PNarFBU1lt4gSp9pg4Y6BiPdBwNPnlepIhosTCq
	MoeIbY8+H4eyR7AJZ2b5PQjLMT7DvTMHVRzXxfMTeScZ/1IS6u1Z6VasWkxale2Z
	AFGgC02odtB1+kIRdbacQMXvKvxuydG/3+pq8NQLzt1z/sRAsEIQCME+ZcuUHqrL
	48CjQdbTn5En3e6d/JZB0PxxA+uHU/lIT2HaRBc6LYFQj5WKAxjQQAESl4kv/2p5
	4Ob0r9WUO2v7M59EozIzLkJWzuZpZ1Grz6g==
X-ME-Sender: <xms:RHVUamed5WG1qQWh0nLorpQM_7a__ZXj36WDD-159HBBFsk7-qqtdQ>
    <xme:RHVUanqG9Bj-0iDx119T_zEH5asU076UIWWMU11ar8XgrEbsu-6kOUN13OE6FSs_W
    Cgul8L4EONu_6DjcjXVVBfjXHyT5-x1xJdYlZq-M1K4PMHS0M-2KA>
X-ME-Received: <xmr:RHVUak7m5Eny96gjmkH3EmpJu_cZaKtMD97DoOkH2t8ZKwLa_AOFfnhjBYw0Fy2vGFVoKqxgay7IK4vLELHTH0nXC9r9Tuxmbrdp7p8z>
X-ME-Proxy-Cause: dmFkZTGsUIFH299Vf9XiqzoR2Z10BXjkxoFHiSb1MiWIhxtJQ6gSkG8RmWvsW06yC5JnQI
    OuM0vo17MRsrgb4qlgYRHt0Xr68VhiIxS0mpaxR8gyC3k7YJZbia/vszW+FTW0xUq2yU9H
    U29gdBh/Iq8igQJnxIHpTwZbwSbhkYxUD+LfoVDqmlvxdDZcTJ/3QyNdO2REa0NiUfUfCf
    XwkvE5ZRJbyRekZ7tU0bkkf2OY/hoCkH93MIS0pMeOjvVsRghmC01st7CJ9DCOrW1vkBpD
    ljdNF1Mg5jTJN6WTNGPJdDcFaqSMvAhg1tGggaK8y6kVDXWujJ0UpNryRkb6S2KtWfXchW
    o69Op75017Zwv00LTLdk+OygWRvKCqeL2nyq98xw5RENX1A2tX01MMGRi1SsWFm2jA9IuB
    WaPpaW/jVTADSk5Jus3QvVvlkBYyzyoR/fYYM4RDzDRMjEMYpvlS0ykq9+NH37FUzv04Mq
    fo/mDAfX//WIHsrU2oclolBm4/C31psTR7FiHhnFqR9QO1+q2JgxZqT+z7ygg2vocP3iGd
    uYuyJoX6wuIim47Ix5hBvyDZQ0QTVAjbmGQxiejt/fnlEB44/upHSwg7yz3k+x/0u0OBys
    m3jwmdpt6tHIydwbZU1t7j3oSsAZu9s9tdHgKMtlM+4vS523W5uX639OEVmg
X-ME-Proxy: <xmx:RHVUatqmEvriMlwX_JD0g7kf_EODGbIUFYxYmmDBI06BTIi9rhDhsA>
    <xmx:RHVUamhiMoN4fnt8DYI7HrcPRRx-aCOM-EP4bHqU49GB4l0JcxOxmw>
    <xmx:RHVUanLXThM6x0z4xqjg-ha1-dlKHaHV3oRFyHnMhnAwKdzgW3-uNg>
    <xmx:RHVUamAxDfXVU2w5MQrCISlAFaCgUodxbc8HGUlO3eTKKBQbjIwykw>
    <xmx:RHVUalgITSB6vQV6jCvDKZtZ4RQ2tYvQ7df9X_7aZmyc7mCqIGmV9_O2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:18:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d79ebe2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:18:58 +0000 (UTC)
Date: Mon, 13 Jul 2026 07:18:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 00/11] receive-pack: use ODB transactions to stage
 object writes
Message-ID: <alR1P-RGZNmjyiUE@pks.im>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>

On Fri, Jul 10, 2026 at 11:37:11AM -0500, Justin Tobler wrote:
> Changes since V3:
>   - Removed ugly line break in commit message to prevent eye strain.
>   - `odb_transaction_begin()` now only sets the repository transaction
>     on success.
>   - `odb_transaction_env()` now bubbles up error when failing to create
>     the temporary directory.

Thanks, all the changes here look good to me and I'm happy with the
state of this patch series.

Patrick

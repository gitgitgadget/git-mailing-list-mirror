Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE13D5663
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238960; cv=none; b=XYFCva/EsYit21A6IjWjFOmXBJ1L4hgEN2S1hIhVyeoKVm5lDUixntq3OEmT+Sx8BPHDOyM8ZA68l9lCYr9Ry3rUwgtT3JWu9w1vLQKumN1O0wgtoFqklwb17CGWIuU3KM0qDZindg2bRbTQwln52HB0wVID27UUtiHWslFoGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238960; c=relaxed/simple;
	bh=kaKtEBNQnyZC19F5UUlkeWPhh8E5D2JaHd/Wz8DXbfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AlytMocd1oo+vcomGU2oRSR8wyu2nfn9K6LV8Du0lFegsPrFZKdv5ljOGiagqHu8fTR+EBNV5Celbm2RmRTEO02kIAiCsr9faAxLJW5N8F0AoFrYpT3OuRp3U7+VcHrzSoKUCFZcBIcXVLGGQAUEN5sD0RM6uQPHwU+5de82n78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OgPCTZEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5QB0dl2; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OgPCTZEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5QB0dl2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E90D37A01B2;
	Fri,  3 Apr 2026 13:55:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 13:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775238957; x=1775325357; bh=4NwmZfm9jv
	XCVjnlnbeI+1TnOQzTrCP50wDQSxv+9Dw=; b=OgPCTZEipJ041x+haSOS9XptbQ
	cY5VHnWN2lu2CY61Z5SQzJLAHua+CeXo6LJkCCJOagj0dtY3tLo97x/eXQltc9Eu
	MykvCrV6dCkwNetOpg1Ngz+SpHRamcPl02VeUT1mnSKYx6rmHCDicrcQDNrTS3Fu
	CPawt/ZCx7iWJtNF186uIoAVg/6lUxx4U57udXRxgc+PfYLYTuTEF7lr6+tiNg1f
	7nE6eib9F5Yq294+zRrTYpKUfBeTWOc5uAO7M9IlIoe07PN68+JenBfIdnYW/4KE
	35DjSgpRbV6UQDkYfXc2n8iXOEB3PpTQ3c0CTNcI6PM+sCDhlpHvC+bLAwEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775238957; x=1775325357; bh=4NwmZfm9jvXCVjnlnbeI+1TnOQzTrCP50wD
	QSxv+9Dw=; b=A5QB0dl2ong38pFWTIN02AO6AX3L1xarTy1nFTlEPTBy4yXRyoc
	dLPB32FftrYGslX7aitlkfrWu4uUwT4u/B6eX752YXx8TptfJhIb9HRNZ2hVyR9b
	rFW9tnb+TVyJk1GAWgngVyYQTfwnK5mlSp6Kk4OdWiNLBptBEXhCXkf4xf21v6TR
	vBfIyec/OJeKh7Ojur7d7pl7ugumpKfND/LCzIv5e4Yh8D6X/emDKwsg1lby8S9M
	P+ija+Hw9frlhM707tJN/+rwuT0So9yrQD7cTiXgtrQHEOZA4CDbzWtd7JwAKUcq
	Ge84p+JW4FfaJlt6OwwGPWuBiOjebdFg6hg==
X-ME-Sender: <xms:Lf_PaTxtGT91F5TK8LHKwirhOZI2AB-hs2Wb2rWRnVTy06uT1KV_CQ>
    <xme:Lf_Pad1K-6Np9Fa8wK95bb3l8ek6HvfdOXwJueRIKLPU6aNHQEiTXkuBCEA1NKalr
    O5KINCYYm2DiK0STSZjdrA0ypobC81M2_2qkBMA04p_8r5Ni4CW>
X-ME-Received: <xmr:Lf_PaQ9DG8jy58cwcghP9_3t5Qc_PbivQS-zoZBL4lCbGbxTDa8bod7W1KExKtILLCaWpt6CdGX20LUNT8I1Gk58-HflCgOKzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeliedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffue
    efjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggslhhoohhs
    rggsrghtvghrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiug
    guhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Lf_Padq8O5NAED8g1Utv0lazR8hxXU39_46_ruREXcQQ0B8HxP9lfQ>
    <xmx:Lf_PaaR0kwJX4R_RPYOWeO-oSGbJT3cNS828YvPZyLsiNFRK3Zr1QA>
    <xmx:Lf_PaQO4ZWSlFuRcVmjd8BKOJU3x-fgCJDX8d_HcNh9AD2Z3cDNIAQ>
    <xmx:Lf_PaYgHbSh4vJSlEvha6jm2Qf_L-kxWBBYMQ7g01YEZePgbQbWc-w>
    <xmx:Lf_PacfTySMPBYx75XEBYfDtREeS7Oz5kRUgP6yCNluc5krQThSsJiN8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 13:55:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com
Subject: Re: [GSoC RFC PATCH 1/1] graph: add indentation for commits
 preceded by a root
In-Reply-To: <20260402211717.3604688-2-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Thu, 2 Apr 2026 23:17:17 +0200")
References: <20260402211717.3604688-1-pabloosabaterr@gmail.com>
	<20260402211717.3604688-2-pabloosabaterr@gmail.com>
Date: Fri, 03 Apr 2026 10:55:56 -0700
Message-ID: <xmqqv7e8lyhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
> index 28d0779a8c..0333fea95a 100755
> --- a/t/t4215-log-skewed-merges.sh
> +++ b/t/t4215-log-skewed-merges.sh
> @@ -370,4 +370,140 @@ test_expect_success 'log --graph with multiple tips' '
>  	EOF
>  '
>  
> +test_expect_success 'log --graph with root commit' '
> +	git checkout --orphan 8_a &&
> +	test_commit 8_A &&
> +	test_commit 8_A1 &&
> +	git checkout --orphan 8_b &&
> +	test_commit 8_B &&

On case challenged filesystems, you cannot have a commit "8_a" and
"8_A" without being ambiguous.  The CI failures from last night are
all from Windows and macOS X.




Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A571DDD1
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329677; cv=none; b=YeGEP6YSzjH/21m1/BH9mH7nHBmHX74LS5ADzZ5i7xrJj/oeqni/kWJUY1h49YKpWUfWxYRWKxTAuBiZxf+YUilJZPIGeS8UZ8sLKQVg9s6zbzxAb0D/UpY93DzF8UbUude9XvJPuCuTrcF2S1hAwqvN8+N7stQgUMS/2ZLxQmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329677; c=relaxed/simple;
	bh=lmIUN8NVGLHSZbfXnQtAs5ELT4HrWo8Mj6U28sE/oR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GCqN0AHkPIUgisvb3qku7SilYzySzVBfi5SrY0lTCU2FWx4rRvFhEog5iDPAzU5Xse6ADOuVJdoLCyxVryaSOSKCXq4ep9eLVyrO5cQko6qID320NRs2SE5/N0qfQOdPbpGHCbkKK4KcmxhOcRVMFWSms9vfSecdVEwjvfZNi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZDRSouZf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U83IXrZT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZDRSouZf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U83IXrZT"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5FF4B1140123;
	Thu, 15 May 2025 13:21:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 15 May 2025 13:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747329674; x=1747416074; bh=1VixxjHrLZ
	XRN54RFc4GYHvc9yqzcKQfW6bJWPOCWQo=; b=ZDRSouZf6jWK6oLv1HEQdFgPqF
	vPXyR7d2XTLdq6mJq/AUMs91B2xbKOQGD9jebd/fmImyvnDOY+U2JFw6UaHJ4m4T
	Q/fvaKdHN1Bp45AebbiGFzmeNKQh9L05SC4tgwZYeBFbIC1oEh8Xh0gESyAibAwj
	qTWue/TLokPVAXAWf7bP55PYXm5rFFaeLyFLizZwsRy7xaYlo8rQHZovfbvCFEBO
	n6oh7ffFyOVjqDFwVAatwS29WqoSStj8w/2kCXCeV6xAyba7AxRL5ljcUQ/u+6YD
	Vfh4MLCR5VIUKrSgNefdhFEvoWZZLEwHP02TRhTDKKy6MUjdwHtYPqjmHGmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747329674; x=1747416074; bh=1VixxjHrLZXRN54RFc4GYHvc9yqzcKQfW6b
	JWPOCWQo=; b=U83IXrZTPUgCEE2dEJCSsn8T5d8+zYUt4zWV/mtbmw7nUmerqQ2
	dk6yxDhk/tjzROCd22RHnf8HukYyKHbSkU1PcjBSRwbcJwJZcAI0IzIUhub5gEPC
	UzFUR+IlMf+Oj9TJgjairCeRbDIr7dqkMNCWR3SHbIiByxaBHkoHaUnPCo2/skEu
	ez79cDsIW94Zd5dRO+jw/mFb/jhMsj+vKjFF19Pq1UmXhW043XmbUMDH92NLn2om
	IdQgiw7VRJRH5J1jEmjLrxwMISdJSICcw6osWpnJWnuhoxSzRJXw0NAc/7P7RTME
	Lq7cHZ12DLke7yB7AknYQswd3X/Hb0deQiA==
X-ME-Sender: <xms:iSImaEqaDf4_ys4Zqar6uqg33FWEVhlxBO35TwWaFTsIEOi7adeVDg>
    <xme:iSImaKpJlxSy4ii4XyheGSM8LvD4F5W6YbgDWSvxNXq99E4mxAuhtKi8xmkqa9Xeh
    K_w02a24ypogGtimg>
X-ME-Received: <xmr:iSImaJNxsfz4KvN8UvtjB09sXYwhzvbqtHcEkp3JSe-F6hinvn32N3sIRiRB8pyP9LLo5seNHQ-wYE0AxO7Coi4OjrZjM-zJ4tI5Dr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iiImaL7Z_nUu0DV5Ro_63HuPM7x7HlBUW5grVknCgnFcOGJHsP0Ixg>
    <xmx:iiImaD4uj_B4e7uSUtSb_k8vYkvHi7YCcGEsC-OYcU4HiqQTob7WbQ>
    <xmx:iiImaLgAkfaXbpn_K_4ppB8Ryln0Yjy9ymPSp0YGaZTpHJBSDXNBAQ>
    <xmx:iiImaN4voO58LWQBM0brbLtLXWNIIWAJI7UJcDJQhFwgA1OTQtOTjg>
    <xmx:iiImaDnzEUJEiibG8T8tmQ_Q41R3W8mbIMtLEeIL7VPzxx2eI6a7C6W4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 13:21:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/14] get_parent(): defensive programming
In-Reply-To: <35c4870e2c101c9ef72d1657c8f6dd077cecc5fa.1747313140.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 15 May 2025
	12:45:27 +0000")
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
	<35c4870e2c101c9ef72d1657c8f6dd077cecc5fa.1747313140.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 10:21:12 -0700
Message-ID: <xmqq4ixl23jr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> CodeQL points out that `lookup_commit_reference()` can return NULL
> values.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  object-name.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-name.c b/object-name.c
> index 76749fbfe652..ca54dad2f4c8 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1106,7 +1106,7 @@ static enum get_oid_result get_parent(struct repository *r,
>  	if (ret)
>  		return ret;
>  	commit = lookup_commit_reference(r, &oid);
> -	if (repo_parse_commit(r, commit))
> +	if (!commit || repo_parse_commit(r, commit))
>  		return MISSING_OBJECT;

Most of the time, the check for "ret" we see in the pre-context,
which is a result of get_oid_1(), would prevent an oid that is not a
valid name for a committish to even reach this code, I would think,
but with possible repository corruption, we may fail to "lookup" the
commit, so this is a good correction, I would think.

Thanks.


>  	if (!idx) {
>  		oidcpy(result, &commit->object.oid);

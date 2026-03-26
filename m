Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0195D392C5D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547145; cv=none; b=CD5Z7NtSLB36WRAj58EjsFubMCPktkfkXHd5kYTuVf5eLSu4pgDJ/8ulBw9y5l2FoXXZUuEXpp93J1CBC1PdOvRAJS62XmDGrrvkCQ5BBbsBSJD+MJJ2q8dvMP1dvaMacCHyHkgO0seMOCdk01LWxZ+LQxialo9jDtkR++hLW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547145; c=relaxed/simple;
	bh=2cOcBnn40Ux2ZxblWF7NEGTWahCosoFe9/yaInKOmkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lSATvdm/CB801xkR/+XTKehpg02w5gyi3urFLaUuwU+lIs2yjRtsRCRpkxmZkp2phgOS5qpTn9qPRVOurHQMoBS5UOjGIyofZFc7J5f5SAYRAgDDlP6rfAF0QYJgkmavUmvfucN8t0VTKPeOpDLDTSAE3vXbOgnQD8mxycnzYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=alyW4YpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iuMhSdkn; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="alyW4YpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iuMhSdkn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1582D1D001BD;
	Thu, 26 Mar 2026 13:45:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 13:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774547142; x=1774633542; bh=ILP1bN0DeY
	P+HaeN05UxfeEh8dwZYFlXg2Rpj53P3JU=; b=alyW4YpNPBat9biZzaqWQW8T4A
	bfIVU01AxEZd3toTJ/zS0578vY/+5qfKA+wGMnKTJjck6+syFOdVMif5tFQS42tA
	3YNGvFoFW8pzCNM0n54YHott00SyxUTLYk4lgEasFHIXA20K3PwJPewkXtEuaf0K
	GcBbiWWLXqIq5FbdsF09+Fhma6hxViB/R/sgRSqpNbM9Q/5J9xzd/tFjntBrlotk
	S/WbSXeO7QOnsVVxZRAmQNdOG63oV7FlAPSSPJkSiisMq9UCYgbBqWL7E7ZtZ9Xh
	PkEB8U+sdWTu5W4zd5iAfsJifS1oBEuyND/xvjYARuts92MFhWv07/FAwFNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774547142; x=1774633542; bh=ILP1bN0DeYP+HaeN05UxfeEh8dwZYFlXg2R
	pj53P3JU=; b=iuMhSdknlL/ewvAlYkusflpelQRnSSfk9djtyXsTVCOwJJLDRA8
	XnZbJWN0mYCVR0bUghLisnbAttlpXUI71xAo1sQA5L7GOTEpUPH3rr8xtFcStnuu
	WLaVqMtZlMC/thdCOQRa5aEH/fN/pDSUpX/iaIlgWO/6+mChQMU3WQvY5uqA+Qeg
	4ympqBm9y6exmlKr780akDwbzvfy11KTp7ypAfE3eAqyO7rCX0x2yg2LRcLEN26b
	kgBJHmuIA9dsnFiltoaGq1LPD19yncMHcJ+/rE0y5tz/JJf4nk3blW8ertZHDeT5
	ZtYYxxQsb9iJcVsqGsWl4KNvH1eBJrdYQIg==
X-ME-Sender: <xms:xnDFab3bFxg4UM7H3kbmjJVuRa_-mQaJ_09hxVjw35_2jHBm8Kzmbg>
    <xme:xnDFaREe_4y_aV6UFJhmu5Ee1j4cjCuZs9AVuD9MMmbnxPZsoz_evFOH_RFpNqjVi
    kdLQn7RHDXBzDPUxL2mRbe2OPjRKAZqPNfcopBn_28w4TsztgwmQQ>
X-ME-Received: <xmr:xnDFaQ4hOSFcTLOkDBhPOiENeHH92R3ZbaC1xlAAb19u7a9pi1dZox8zcIi5p5CLIoqHifqiUrSgVDNr4NGVGS3U12FL8i1QAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdektddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesghhruhgsihigrdgvuhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xnDFafu0De9Ks-vp6cUA_ow9Zv_Wo6ebziwPyVfUdyccohX2n334Rg>
    <xmx:xnDFaZ7GFEhu7T_Zf30uJvMhcU2PAAO_Jp-O5ScS74UAdQyzHWdJRQ>
    <xmx:xnDFaSXTiMc7b4g2Ysls1ywwsTaOKw7bms082zRJ2xpZpuu547zT-w>
    <xmx:xnDFaT84_CYX2lwULvk_XeJcsNLHlzmv9xluYAWpAk1MvniSmJ-j3w>
    <xmx:xnDFaW3b_tyEaPPwyP_ThYmTlcgPWKiy76-muM4pp0tO-RSdqJ364EpL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 13:45:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Michael J Gruber <git@grubix.eu>,  git@vger.kernel.org
Subject: Re: [PATCH 1/6] do not discard const: the simple cases
In-Reply-To: <20260326173402.GB2447148@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 26 Mar 2026 13:34:02 -0400")
References: <cover.1774537954.git.git@grubix.eu>
	<a3a1d2759a0ec5a3ee285689832832e5e3a63768.1774537954.git.git@grubix.eu>
	<20260326173402.GB2447148@coredump.intra.peff.net>
Date: Thu, 26 Mar 2026 10:45:41 -0700
Message-ID: <xmqqy0jepjqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Mar 26, 2026 at 04:22:47PM +0100, Michael J Gruber wrote:
>
>> This patch covers the easy cases where we deal with a non-const pointer
>> to begin with. It is solved by the cast `bar = (char *) foo`.
>
> I think we can often do better, though. For example, in this case:
>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 7c4857be62..bd277e5911 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -852,7 +852,7 @@ static int get_urlmatch(const struct config_location_options *opts,
>>  		die("%s", config.url.err);
>>  
>>  	config.section = xstrdup_tolower(var);
>> -	section_tail = strchr(config.section, '.');
>> +	section_tail = (char *) strchr(config.section, '.');
>>  	if (section_tail) {
>>  		*section_tail = '\0';
>>  		config.key = section_tail + 1;
>
> We know that it is OK to cast away the const-ness because config.section
> is writeable, which we know because it just came from xstrdup(). So why
> is it const in the first place? Because the pointer is in a struct which
> may be used with other const strings.
>
> But we can untangle this for the compiler without having to cast by
> using a non-const alias, like:
>
>   char *section;
>   ...
>   config.section = section = xstrdup_tolower(var);
>   section_tail = strchr(section, '.');
>
> Which I think is safer and shows the intent more clearly.

Yeah, this is much clearer.

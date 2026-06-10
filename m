Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8157A383999
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122052; cv=none; b=SpxW5Xy1EJm8ZTGONR4IZM65+MEVhz5mVoeo+G/wC5+ibh7U+pXu6UOHf0P6gDXm9K/s+xcCR0PUzXJv8sdEiRC09Ff2O2Wz3tD+1Ld7TxgRNqFq0gn1uPPJIt38gB68Pgl3jQwPwWaXL/jGluplWBP/riNu2VRyX/NrKiN25Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122052; c=relaxed/simple;
	bh=57gugp/ef7LVa/d13ZVQFPx8ghmvohsR6/hB/JJS6fI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jSY2vu2emWvRShuaIx7xb3L2Os6+6QrLCAWigeCJToB2sfOGv0SKS9/Im6ZI/oJ2LOuKNJ83MZRt16S1o8IVgGacToAgJUazgzL0stNvKkG6RTRVF8ULfUqy1ERj1OqAkLGa3pB4ZwPkH8qTt3dIzZv+rBHH+CHzx+rcLbOTKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZrjbCDHS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XF96wK7+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZrjbCDHS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XF96wK7+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0AC414000C1;
	Wed, 10 Jun 2026 16:07:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 16:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781122044; x=1781208444; bh=xJzaU4/fee
	PBsaCowAVI5gnObt8LK0yZGcvW2ZEpr0w=; b=ZrjbCDHSdViSFTClVvK9pnwAiW
	ozAE0g0PUDMXKPRtLpBt5NIerCsU5QfOOUDkM8kVgLTDsN2+UFfOwj65FwNz24hI
	kspPa3ACa4su6LDj6mXpq9G6LAqIqMsW2Bknr8XSZNcreclePOpX13+rFhQAvLXp
	BU3/848qq1mzMhuzyaxu5+dXGJxHqHBB/If8lgI4nOZ+D4xOogHvPNWnkxixgwhf
	IkvktSuOetCywQ3SY4nga4DUzfBHvB6BbiXSrzl8afuLfu7OIV92t6zcFR3t3z2h
	gBdlpvMgYQZ7HrnRLKub8V7rh87TSmriW9ROTeu9lYyAYdBeqZjIkabUpujw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781122044; x=1781208444; bh=xJzaU4/feePBsaCowAVI5gnObt8LK0yZGcv
	W2ZEpr0w=; b=XF96wK7+zxxtoKJDgL4aDVlL51NDSmWYvkEWhr1gAVDFgAxN7sL
	mTcoeTkUVtQv1F/j32InPj1G/C3D075r9cfChb+fDriOB+LLnpkmgmjN8gZ4ntBL
	16pwEiwTM/UoQRxvUzo1g8fSH0FDlY9+fkusc3Remnj8VSzE6WnMzMWFTcPbl6+B
	PTDnQKyI8HJoKKCH5NhFGLJU2OZf2DkF2OrKl7kAMdQP+dlhyN5Qh8b59NGc6AlV
	mvwDzEuOzavPM+Cp9NCE5eNwM2dDR9dW375Tgd++zhGZeZ7EQv0SMoBYTt2lpdIS
	IBaIUDvHwuIk4dFFTq6PPFGrwbH7ehGpi2w==
X-ME-Sender: <xms:_MMpaqNBavXRZLIqoEbLjjDbu0gtq2rR3qliV-0oHUCgoQ1DcAy_qg>
    <xme:_MMpagZcTINjwa3nkxGlI0ULruRtkRiEaaqoUuyr53FggDM8owNcE5wwkGGPtHFsi
    _CbxfcEFKc2T1FOQw63aMVu3_xJ2Sy9VHjWHpAOizEqWEc3ajnS>
X-ME-Received: <xmr:_MMpauqaNsAdjnSZaWunJE4xC6l3AeFzq3OOY-D0-MP8GeukpLLJma6estaBxpj0sAGchChBjOGEMSHVbA3PgIDFeGbGXEAXh1NY>
X-ME-Proxy-Cause: dmFkZTGjSglPJWTbv//jYldenc38djQXPRHMEUjIam3qxrlGKMiklzvbhQbGl2q33CrAJF
    Z2YMrER//2AIxEzagAegIjIiVG0M4VP2phAGqKz2VOa3bYsnmPMVPqlAghGWq0vjZlN+4/
    fMYzoxNJ/Y6T98KUrLgKy4mGPFNk+Rjuv0jgMCr/5mmBfAprv4Ykg4Ag6oXIi350SH3fQE
    P+ix805UWpqw7ZzrkWEXSo0v4j+w4aCu6jpMOMjZXSF7EqJylOdiItD4qiVdqOhEiFjjT4
    xN27eJyEZI8cBrFQoDxxdp7cPKEQEAM97QFHfhD0TJ47HbhA/h1kF7q9H9dOVi1OV9SLpL
    Abhv0RQQhqHzSOzT7h7eiz4xqk32SIvPAugXFBFQFb04cw9W2b+ierSCiOyTEXEAfDtsID
    OUyYKlBau1Yq/aID6Cy7CKpf1hWOch3CQr+d3WPHcAhKNCvlFDC4D6gROWiq/W8Ng0c6lU
    oHvB8IZgfDS6XabRI+eYD4Q5BSL5TWgkWYB5EqoabTTZKUuJAMtrjronosORlYLKuH6Y9V
    G3BR8lKy2vl0h93fq/ozcnKnC1oZTEqQC/6JHzgq2h9CgdvRwu3Mq1MrLueqYpINPU1Tq6
    dIPDEY6whm6l9x0FQwou4Oh2I5+0CPz3leN8oB8c5o+OW73bAyK5V20RsX3g
X-ME-Proxy: <xmx:_MMpaka18Ip1F54rbiTNVmnAQcGCnl_arbSt-x0Xt_pIEjqR_wVsaw>
    <xmx:_MMpamSOQ6Yh74sTSet20nem_NPuXz3W2t8lNk1ovvKoYVce5TtY3w>
    <xmx:_MMpar75coOPsusrmjTwhrju6heg3RL7GPr-LNC1EPYQ7BOoo_FsaA>
    <xmx:_MMparwTULHJU7CmPjtRQbY8vAccuMluqqLwDW8CQrmXo3bbfmQXng>
    <xmx:_MMpapFe-AOVYzlUsSW2WQ1So4x0RphTCTsMkuR36H3eUliHok09HjJ5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 16:07:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] doc: git-config: escape erroneous adoc markup
In-Reply-To: <xmqqecieuqdm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	10 Jun 2026 12:50:13 -0700")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260610185148.23920-4-taahol@utu.fi> <xmqqecieuqdm.fsf@gitster.g>
Date: Wed, 10 Jun 2026 13:07:22 -0700
Message-ID: <xmqqa4t2upl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  
>
> What we see in
> https://git-scm.com/docs/git-config#Documentation/git-config.txt---commentmessage
> is rather embarrasing.  This would be a vast improvement ;-)
>
>> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
>> index 8439ce97df..708e88cdeb 100644
>> --- a/Documentation/git-config.adoc
>> +++ b/Documentation/git-config.adoc
>> @@ -119,10 +119,10 @@ OPTIONS
>>  	Append a comment at the end of new or modified lines.
>>  +
>>  If _<message>_ begins with one or more whitespaces followed
>> -by "#", it is used as-is.  If it begins with "#", a space is
>> +by "\#", it is used as-is.  If it begins with "#", a space is
>>  prepended before it is used.  Otherwise, a string " # " (a

With this change, I wonder if this '#' on the next line gets paired
as the closing element that corresponds to the second one on the
previous line, which is not quoted hence can be taken as the opening
element?  Even if the one on the second line does not get taken as a
closing element now, if a future change adds some word with '#' that
does, the second "#" on the line left unquoted by this patch would
then require quoting, no?  IOW, would it be better to do this

>> -by "#", it is used as-is.  If it begins with "#", a space is
>> +by "\#", it is used as-is.  If it begins with "\#", a space is

so that we do not have to worry about "special cases" where it
becomes unnecessary to quote "#"s?


>>  space followed by a hash followed by a space) is prepended
>> -to it.  And the resulting string is placed immediately after
>> +to it.  The resulting string is placed immediately after
>>  the value defined for the variable.  The _<message>_ must
>>  not contain linefeed characters (no multi-line comments are
>>  permitted).

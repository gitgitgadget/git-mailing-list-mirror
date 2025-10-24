Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE103019AD
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342296; cv=none; b=U55B6R/LP566LFfZAzxnNdR0jWC3zsWuqCrYMzyB/VuQ9XDN47w3U6xaIznyvrdiUjb9+oS5gEm6eBaUwcOFHELlV+odnidDC0hVm02IG0Dpqow0g5500L1N8NVqeFm7b/a56iVIMzhfECM8XXpdh6SHcj7qcxylqpglVPswhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342296; c=relaxed/simple;
	bh=EdGE8v6lCrUDPjAfNpTBg0W16DmF9Ss6jni8J22gDys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLuBbuyRqVULWyPvORRxqlT0HlInmIxQwdSsaoqqGw+T73wES3EBv97voZvBaj0PCq14VtMIuKWY6Wzsj6HxnhJSHVybVhwZNXlkNY/y46RZ8284FUCVtKegXKhswj72Ws/kJ6jdBMkZdmNnjZ2/WczBkmVa8MAcjf71FAWQLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YKD3T9aU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFYBWPYO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKD3T9aU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFYBWPYO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE23E7A0231;
	Fri, 24 Oct 2025 17:44:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 17:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761342291; x=1761428691; bh=oBuggRt1D1
	o33Es3i6a0gbeOAZRNu2OvYtL+6K+aoMs=; b=YKD3T9aUvmQBZjeoIBJoNAkirY
	+lrFqY6kbtD8Sd0lFmchicAzVRodGxKar8mS+zR3+Vs/eGlBC9hF9hBAJ37EBgtV
	K6MpIVkDZiZs/Gf06LDChjMPrT6vFkngwjutHGZuG5Fmkg/m3uqIQHQJ6Vn84ToX
	Y0CWrB5gQI4o68+k4PrkGaAFQwPDF2gIFL8Tmv9vyJBMbVcoWHFHwVq70eR3xyfh
	N94LSPbx/iFbqLR9zT0fXSOrXjEW1nS57Y0Zcz+nrd2JKoyjTzVa1nPcd21/A6cF
	HxvUSNxkAkvHtk85k2wFgDZMOnXZ1xOAxg3Kh4AucH2rL6UCFuPV8W5kuJzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761342291; x=1761428691; bh=oBuggRt1D1o33Es3i6a0gbeOAZRNu2OvYtL
	+6K+aoMs=; b=WFYBWPYOtxPP7kpBUlGuWILtyLWryoMesMHciscfffSeSgEG36O
	zxQyKFn9Is/6BHaNzNtzf0t4cOsbOsfBhlKVnDvkvyqTcuZ8VmF18g8Mka7Q9cAP
	M75oIEeCDMZZnn5Dm3C8Upl7NAIxTDMsdNB23xvAURW7cMxrHLtUeQYqGNG+GjR4
	FdaNZxuAD0erb+m3n0doC1gTYr3ERp9ExMQn40/3/JCwo7OMJS/JaR7Px8hlr6IO
	U8DoLBfRpbI+DN/wT5UWZZoHaFADdKvW8pa00nb+Exitz1BrMdYUolnzrUHfkA6Q
	sUjpZfcbxzqsWS9secDRn4biPpn/JDFJCrA==
X-ME-Sender: <xms:U_P7aLuMgJjkm5mJMxc39sACt2-xUyWaMX03lUi4-30IKLiCqk-0jw>
    <xme:U_P7aD7lYQUL8MJcLOPK9l4_baBN0v4g_JcYhaed2abl4fXBHoc3RXIk8Pgpy9zlp
    AsZTDgp6P3lTyKPJ1NxgJ7BppP6gMiZmN0SqJrtSThXQ24WjxijyA>
X-ME-Received: <xmr:U_P7aMJXSowUSmkbQL96pCiajHA46H0uhR98cV8eRNp7Of2DEJVIepSW624gW4WBGU3sbfEXNbcZCTQc9qjNFDIGV5JMQfRIHevr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:U_P7aD4tIpKk7s8ps6KrSb2JsAze0sVIWLybmXWIhdxbUrrNOoYdhw>
    <xmx:U_P7aPxyvND_mHhOt7GRMPKEH75FgW9sRZQ40Jb0rSXpqVXfRA8R8g>
    <xmx:U_P7aHbebMI3ZVYuixvRXvKG93GLF-9S21tBn-lSZRVSNB2nEtuzog>
    <xmx:U_P7aBTG027_qqskf6mIyLHCkHcdhlDX30huFlgAp9zUBqAyObJxzQ>
    <xmx:U_P7aEDK3iZ4wedV3yaqu-To0gn9Qxu8FcpTB5VeER0kT8XYwXZxKd8t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 17:44:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] object-file: move loose object cache into loose
 source
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-6-1a4202273c38@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Oct 2025 11:56:05 +0200")
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
	<20251024-b4-pks-odb-loose-backend-v1-6-1a4202273c38@pks.im>
Date: Fri, 24 Oct 2025 14:44:49 -0700
Message-ID: <xmqqzf9gnfe6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -2006,5 +2006,8 @@ struct odb_loose_source *odb_loose_source_new(struct odb_source *source)
>  
>  void odb_loose_source_free(struct odb_loose_source *source)
>  {
> +	if (!source)
> +		return;
> +	odb_clear_loose_cache(source->source);
>  	free(source);
>  }

This had me confused, especially the source->source part.  Perhaps
call the parameter "loose" so loose->source is the way for somebody
who has a odb_loose_source to learn what odb_source it belongs to,
or something.  Of course the round-about way to clera the cache that
now belongs to odb_loose_source by taking odb_source looked awkward
in this step, but that awkwardness goes away immediately in the next
step.  And the parameter of type "odb_loose_source *" called "source"
here, instead of "loose", still hurts after the next step [07/13] is
applied.

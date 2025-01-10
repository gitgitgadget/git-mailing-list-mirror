Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EBB20D513
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518922; cv=none; b=kGAx31olrTmUtfcBWW65dSzOxn+ZWwgRxcPlEPD7ZDKDWezjm8UjrTp7gBvUTJQ4i3RjID2JA99Z7jJxi1UEmHpu0A+O0F0Tlo42A4XW15/34BLpB8qQ8Qzclta+765ga221WPbYP6A1mtx/kcmCS2MtPoXBGeNm4ybf2CyJQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518922; c=relaxed/simple;
	bh=PQl7P1xCPfwhQtuh0u+QobDCQSu/3hv8e3xpcTZVt+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bC6yAzIEbIaPy212WjkyUnPk29jILfXWkg176rit/pYw2sZP/wrur3ja9pDPwJX478WDVEzlajH3BthAmgz+5reUvmLatgrGmMeNTv8QmgQjJls1Fquav74unaPxGmT9KfD5gOt+/H5Xf+VUje1AIp2zVbGC7FeB+oOw+ruGUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1tvqVT5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wl7w4Szj; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1tvqVT5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wl7w4Szj"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E20541140130;
	Fri, 10 Jan 2025 09:21:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jan 2025 09:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736518918; x=1736605318; bh=g3ZgieqJQo
	RxNuV6ljxZQnzoPq/ABcQZd8xMEjoG2hs=; b=1tvqVT5J6SaWWE7yrqbZ8x0UHL
	WnrWHK8yXrpPY6hwHY/0EtVOtXyAVvlahslhIkwyQ8wS2vnGjd8md4kIIihrdrFE
	+aCn9wfuCLyFmL9kWJe3W4wKU877ed1afw3PZI+8/h42UlytvmvEeDsYV4XQBniA
	Y7tKoqUR1g4Ua0qqPmI/qDYDrQwKh0S8X2l7n2u4YYNKjdp+IVVo3Ed3JStJmOWs
	mYwaks4nF43JJMb8CB0OJpKB16U4OgXzWmsgNHUY/LBDiqjwnE/bVv8ZUFu6pZ4E
	gWAUGH2YVf4YdOAIVmC9hzVgKEGvZWW/A9aRRUedJcKZEEwcCNpms5Vu+dXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736518918; x=1736605318; bh=g3ZgieqJQoRxNuV6ljxZQnzoPq/ABcQZd8x
	MEjoG2hs=; b=Wl7w4SzjB9FhGgBmHsHU8m4AndrtJVWfjmfxq6NYG1fTWC9WhW7
	wKJcWEC4CNNGI8spnS3cgj1W+7hBee9W14kXpofqqfncB7Nkc6WeY+WJH30gVW3C
	r/V6Wnx6GqqPzBdpWs3oWx71Eiliyl8yn0bAyDRJ7qG1fhSyidTu5ctUPFY0rigD
	vsdLSoVyXlDQNlZ3uv4SjNJH2W0YWZj3fKwS1AQ0+xNEQfHf4WPwuaY/I3PLNvLT
	hFhi4KtMHos+9XT5nZc2I4XY1iT+ldeZvWSM/Ewj3vHcLm4d5UzWIw9F4lH+ktzp
	dVA+8kS6i/mS+E9/wOC2dsFvIrRz/tNGXsA==
X-ME-Sender: <xms:Bi2BZ-d427DRtJyWRCVGb2Tfe6avnTrX_PBmhsKRAogy__Y5soI3cA>
    <xme:Bi2BZ4Mg_IpEGc0-wHSR_4stRaVuvtCTkWQfLuADsTtMMGuYXJXZGU_6WKfk9Gde4
    MWtbuBVDmp8mNqqag>
X-ME-Received: <xmr:Bi2BZ_jhszwSaZbN82E7_iwgJcAIpicfmUxmpsrzARdj5jadTBha5DUwq4hUkFM0AdlEvBs3v3iee3ovQFITn-GkZ0gepYoild8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Bi2BZ79yHxubADMFdpmHXZp8IgNSQYbHCOmZlpeEhHnETgN3zf4BJg>
    <xmx:Bi2BZ6s503PbfwGzbCIMjRdIoj9aJDat63eNd_647ZeKKVlfgc2Trw>
    <xmx:Bi2BZyHMSQuIyxYersyndQ7eV-QXgDk_-3-42XaWG-ttVfVFzhqu2g>
    <xmx:Bi2BZ5Mh21rCFTq2L4iqb2lneQsWrOjmZQhpMOMANcROJ2JFz-DVcQ>
    <xmx:Bi2BZ8WXn5msbYn36HUJP7DBU0jQ8zx5xcneiP-4Gop5O6Yg7mTdxmc_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 09:21:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/2] builtin/blame: fix out-of-bounds write with
 blank boundary commits
In-Reply-To: <992502eb-5131-228e-1915-a35038211f4b@gmx.de> (Johannes
	Schindelin's message of "Fri, 10 Jan 2025 14:00:41 +0100 (CET)")
References: <20250110-b4-pks-blame-truncate-hash-length-v3-0-e61f25b68f30@pks.im>
	<20250110-b4-pks-blame-truncate-hash-length-v3-2-e61f25b68f30@pks.im>
	<992502eb-5131-228e-1915-a35038211f4b@gmx.de>
Date: Fri, 10 Jan 2025 06:21:56 -0800
Message-ID: <xmqq5xmmagvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 10 Jan 2025, Patrick Steinhardt wrote:
>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index d7630ac89cb7bd6e9ce5d72c6a98aa433b3b12da..7555c445abe7ca2fa54670ac8fee1d95a6dbafe3 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -489,9 +489,9 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>>  			fputs(color, stdout);
>>
>>  		if (suspect->commit->object.flags & UNINTERESTING) {
>> -			if (blank_boundary)
>> -				memset(hex, ' ', length);
>> -			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
>> +			if (blank_boundary) {
>> +				memset(hex, ' ', strlen(hex));
>
> Using `strlen()` is a neat trick.
>
> I could have done without slipping in a style change (introducing
> curlies), but the most important thing is that it fixes the bug.

Thank both of you for these last-minute fixes.  Hopefully we can
have them in today's release, and we didn't miss unexpected side
effects in them, I hope ;-).




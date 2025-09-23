Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CA1D90C8
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648942; cv=none; b=stMk4bs0iEd1TKWelhmLSxOZVBfK68rx0OGnLUTeda2PXpkkdK5AK32lkEf50vMjNxZP+K59932h4OzWX52oduqbLNPUSYmF/QKDTjLYhDnTF6KZdbX8iPs04IAb+3k+tsKiiYHIETgJJXGTEPfz4oEHw5Rs+iQhI2n6dBsPDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648942; c=relaxed/simple;
	bh=HBRCzdfx/vLoWKTcUqm7ELJdx5CZ2oDcLbWSplRrDtk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e3zA+mrACCrn90gjNyXAgFz8W+2ClLOU5UH22rg3qExo1C8y5yP8WbYlURgCjPh/el4BY7r5A1YyW0Yq1EvfxHmTmBGlAngeiP5wa+053LHMWLBoGyJY8lswSoLNQn0kh10TggKDFy9abT/+iEEhVpL9WRQolq5xiHVwp+9TGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1kKQvaHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epO51yyq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1kKQvaHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epO51yyq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B9671D00340;
	Tue, 23 Sep 2025 13:35:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 23 Sep 2025 13:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758648939;
	 x=1758735339; bh=mzIbo2d3dqb9gjw4Si/nC0vHZ3IiJaWBVtz4W6i9X54=; b=
	1kKQvaHWB+4hC6pyR8kCY/5i1u3/eWo37kUtl/MFQAPbMmn1gAYapbotNKhPWkng
	GuY1ioHq5ssTUWZ4AGipv1/NNgJKLbbgXA0AEsIVAa/gGyzGF0h+7A+SzU3iwdyu
	rfzlHRG0ZzrZU2ubkAcLY/NgppIVNHHqaHs3kMwlc+OjISVgqHmoi3ULk3IbAoF3
	rGqKCar0+Yb8RJiTnKFcVf5AUbqaFFGhIwvTfJfBU2M6IhuGLRArC6+bhPTf09zG
	XeRyDNeXVVNW7QK6EjtqUwnhzPl4SXTAVjJwbCbJicCg/bividNOQyKf/X/kXFQS
	SECQhZ5j1tmJMYeAkIJHaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758648939; x=
	1758735339; bh=mzIbo2d3dqb9gjw4Si/nC0vHZ3IiJaWBVtz4W6i9X54=; b=e
	pO51yyqmKdvj8s1hfaSZ7i/xyEtTnZZrJyCRzNPspvViAOfNbUks245qLMxNxR5/
	5dqV5GY6ZTWfjQQl4UvFOvesvUxBJDq7bnZGVhnadRaObrl6hylIUbj6YPKsyHlJ
	Y0/huO01Cy3By32juoGvDcvMt4rqmlQ3NVGkXe7pbM8r4GCb7MRQfGG/7zGFlO3O
	HJaZ61vagUFYjFqNh+DvaPClpAiZoqjdytiR0OsiqL/THDqNuE3z7w9Jo13SGIkD
	zGXlMhvs8v+DJ1MIr/UV9H7THjrlaB8MM0R8gERNDLWYAZeWgyXtYNJiklMuAJOS
	pbkNEKUFRCgsd2HIi8rgg==
X-ME-Sender: <xms:a9rSaBYICOGZMcZC5_54O1xEtTygmiYgBVC1O3nfN7HCb8r_sePVhw>
    <xme:a9rSaP0syUEnnpwOtVOQnEKiLF2Hdv7oYlnlEBfW2lCpiaZccRR6Ncg_FbSLFxiXz
    isn3UdbxEdFxgeyWuaiBYvO9uRhOxNo_Ax8ri9PGVGlId2lF6QV>
X-ME-Received: <xmr:a9rSaBV-zdSeMfOOGFy1ITDmleDet2CV_SKNk_cOBenDCCYu16yyMHO8KstopJ3NbV6T39c_wT8HXBQNYeV2PRjXcdxDCbrQL8ju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a9rSaJUQ7JRJle55XNv49luFaOBcUGDxwpPaqvjvGfrM8Q_dy0mnZQ>
    <xmx:a9rSaAdpJmlageil65PL-Fwp4tHa1Jo5c8FmeD9KIsq5koVAmKJMjQ>
    <xmx:a9rSaCWDvDbNYfiyYb64TMMeCL3ndjIngZAZckfESUPp1sxBAjnOkw>
    <xmx:a9rSaJceBhb_YlaC17CHGEeeLAPl4ScltWJlQbbk68Xes1x86X-WxQ>
    <xmx:a9rSaH_dV8q0hg2vkkXzVcQq5yQiE6MnR0GD79DT8q0NpseQnj-nlrfP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 13:35:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
In-Reply-To: <ba9b7fb2-c990-44fb-a506-0800d02854a9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 23 Sep 2025 17:53:54 +0200")
References: <cover.1758574974.git.code@khaugsbakk.name>
	<bb065767336.1758574974.git.code@khaugsbakk.name>
	<xmqqikharvyl.fsf@gitster.g>
	<ba9b7fb2-c990-44fb-a506-0800d02854a9@app.fastmail.com>
Date: Tue, 23 Sep 2025 10:35:37 -0700
Message-ID: <xmqqa52loyvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Sep 22, 2025, at 23:58, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> git-format-patch(1) is supposed to treat Git notes the same between
>>> notes output beneath the commit message and the notes output for the
>>> range-diff.
>>
>> Is this an opinion, or are there things that existing pieces of code
>> already do to achieve such a behaviour already?
>
> What I mean is that
>
>     Notes (...)
>
> Beneath the commit message and
>
>     ### Notes (...) ###
>
> In the range-diff should be from the same namespaces. It shouldn’t be,
> for example:
>
>     Notes (presentation):
>
> Beneath the commit message while the range-diff has:
>
>     ### Notes (testing) ###
>     ...
>     ### Notes (scratchpad) ###
>
> That’s the point of passing `--notes` to range-diff.

OK.  So it is more like "range-diff is supposed to show comparison
of pairs of patches; if format-patch shows one set of notes after
three-dash lines in its output, range-diff invoked by format-patch
to compare its patches with another set of patches should also be
comparing patches generated with the same set of notes".  That makes
sense to me.

> Thanks for the explanation.  I’ve added `.rdiff_other_arg = STRVEC_INIT
> \` to `REV_INFO_INIT`.

Yup, I think I already have a fix-up patch mixed in your series in
the integration result I pushed out last night.

> Could it be as simple as `log_arg` or `log_args`?

Yeah, that is much better than "other" (where it is unclear what are
the "primary" things that "others" are in contrast).

Thanks.

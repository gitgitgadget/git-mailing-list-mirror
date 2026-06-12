Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22BD3B2AA
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781292753; cv=none; b=PcNxs2e5GGO5888CPShLSxTJUeeW1K6K/VNtNvl1ZJWnIXngn/RW2u5JtwRNv70ptU4Rv2eW+yFtk4fYTUFW+6plF+Y8jU+ixbBuN/vB9tSD/L/L4WeYB3avff306QDxG88IHeR4KyVilH2MlZw61wCRw0iasSToMpmuuCnDtV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781292753; c=relaxed/simple;
	bh=NuYfzYM50rSlXrvzhIXVBmrFQAFfkB3arSpGrTeiBkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uobNabgV2Dorek1QU2iY5yQIZ9lFC59kTKuN7hZXWa4dfi/aB4sEsQ7CL0n/fCNWZYxy19p8vADzcSoDdXm7Xtc8mAvtOj2i/rxEF+KNeNPavFo7xW1X1q4clhXfZ25zm+WEp7+cNklDzunAFnLKHtGwVYdd81jZ6++9xoHA3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dFGczcJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LuS9Zpdv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dFGczcJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LuS9Zpdv"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C6E7A1400080;
	Fri, 12 Jun 2026 15:32:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 15:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781292750;
	 x=1781379150; bh=0w5jiypqWja3KhpeAGCCuRoZZpRoUwViLGKkC6a4AwE=; b=
	dFGczcJHitfVIq/yj1kW578qZey57w0p5+98enzzmnzqsqIx00Up3GmSyqoFYHmr
	5aSDPVVw5pKluSpZWW0NkUyq3cYo551ccSpTvjlPi7AzJqxxu4+O0GjTC4BQcR9C
	gTHwhYLdrWJQ+p6vDvKztEpLtba5o2M4+Ly0E+C84c7jH5r6dqTliTQp1cUFaHu/
	3ascnWmpDRSgDH1yjG27+83APS4h00LAU46geafqEP3Eybm5ASXt90SwfjX31bwW
	WyC9gjcM4rv+2y8RakZ86/qUnt7K7KI2qO+bti5Nc5XIC/4igAkjcWnNklaWZh0k
	Fj7n3bqo00dQDJzTVs8UpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781292750; x=
	1781379150; bh=0w5jiypqWja3KhpeAGCCuRoZZpRoUwViLGKkC6a4AwE=; b=L
	uS9Zpdvue9JKE2rSr/e8stUWie9tt+zyPZhMCK59xmZ2iJdLg3/dKvbR2CvEwX8H
	9wdFN5vbUicw7PYUv7LuemmRJ3r/vVf4ip7OXyHyiDEJgeAElZtmzCgQCuyrHktn
	jw1nheSmY3jRcEyqzSfmG5BCUZlBObWD0B03xiUdTD+NmBMeEIXsaNXk7gAZXPRt
	y1IngS+LNVFxFZ9RsSFPJPkTqdY05w7XqKtX0kD5PFS9tnPQlAH889x5/BtTmr4e
	BsTZ27iTlThMaVlGpiqhJEKJgsoUYRcxBGmahC5GmhbY8mgZl2oWkXPCXO0h2jES
	WD8cJz7FfSjJzUnZ/GH9Q==
X-ME-Sender: <xms:zl4sahLfGM-Phf5iTpGDFPHGOmFmPWPigZLNDoDPoWnN5oVN75xY5A>
    <xme:zl4sasMhAlU-sK2Je3KmFnUYdqNJR99prlm6czS6GM1C9qyM966Q-p4J1na2mze5Z
    VaxUav3URLM-pjXEtjFhn2vIBN_zQr0OVqesg455-IfnM5o7OqxeA>
X-ME-Received: <xmr:zl4sav5PjukmGzo489Q9bpRgAAK52e0tkrGXSZEa4slRN6wKNMNum-w0CPJ0cOfTvBtIE-uGkoQWv1smU5cGWo_TzWsM0IGS6u2N>
X-ME-Proxy-Cause: dmFkZTFkHa0Vjn6LxLBnvTS8n/UGIwa7pWsReYiG09zpsLVfuOnCsy9O+7wQ92WSgKicEw
    CbbAc8gFoMlnfc2w0mO7lpdUXHcKSuAYe+6P2CKMiQKoJy5QJWO6Mw8Sz409cN3aDFAXny
    LZ6+pY/lsurMqHszwp/tq1VQzFSx8FGmxoTeC3y5zwDCf62oWKqRBCaG4YJOhEPWx5GYLU
    F9NZSHwqq2SJJORvouGy/jURlTO62TbmzWEYhqdOOhR27/rZ7ERfDoPgZUYJO5UR2wa+H/
    /GM34ruMNNe6trh7aajCO1aGftIxL66ksWkytNRbNGYaEu09hK5dV2p7xWh8TOT1eyN0WR
    IhZEIZeUUqRIDzZExty6NVBhLNI3Vu/gf1mamr1K5ZwrDOl8/n4LFyJUIVyvhX2n3RhT7l
    dQU97qOQyZ8XcAtWBb6GAasBVa1kyN/CWNDg/hCX1ODe43PLIC4IA8tpKy8yj6vJ3dss3V
    nibAHyY4bZZ/N2h3pbOJQSEGfTDdrvWGm+MGGsmB5hB+XyCsokq5LWqbhhKqSs9R8jfee8
    GZwX9ZGj3mOVGJwMA2vK7S0fOacIR+9zG1BGpzPwQpv+Nu3gGpQftzgerfjTq3Iq8OMEG2
    wWI1/eebQ6zy5uZCIlq7M7utvwMiNRdrDOzIkXlF5S1NkGHR/5M94Qj4gilQ
X-ME-Proxy: <xmx:zl4sau5gh8T8SRa23AIcMYBAcDrfKw07y6Lzb4daCBjFY9Kb5fSupA>
    <xmx:zl4satGnYDasaO9SrdjNkIQGlcbPTHt_qkNcLwk7mMqCeJdAuTBWSQ>
    <xmx:zl4sauU3UdGpnCfXsNm3JyQdmaDOjgdHGHNBhyhQIWF_jx8P_SadGw>
    <xmx:zl4sahXbq7dv7bf1BOnJJC508IyVL2nyk9nJVl4e8PcFMvfeiejEnw>
    <xmx:zl4samteptMG2SybCOaElPxjqcTJVk3703Qaz6YLY2BYIYoZG_pM3-Vn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 15:32:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git <git@vger.kernel.org>,  Elijah Newren
 <newren@gmail.com>,  Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: Automated reviews by AI (was Re: [PATCH 0/5] Duplicate entry
 hardening)
In-Reply-To: <CAP8UFD35cLP6FcEuPr+SghKae1ew4JWLWYAoMQ-fuEOu-JmZdg@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Jun 2026 15:29:24 +0200")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<xmqqpl2a4f09.fsf@gitster.g> <ah2PLBluBFy44AQI@pks.im>
	<CAP8UFD35cLP6FcEuPr+SghKae1ew4JWLWYAoMQ-fuEOu-JmZdg@mail.gmail.com>
Date: Fri, 12 Jun 2026 12:32:28 -0700
Message-ID: <xmqqecibh7w3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Jun 2, 2026 at 8:16 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Overall I agree that everyone who is a core contributor should also make
>> reviews part of their regular worflow. At least for corporate
>> contributors that might also make it easier to communicate this to their
>> respective employers. Regardless of that, my expectation is that there
>> will be times where it works well, and other times where it works less
>> well.
>
> Sashiko (https://github.com/sashiko-dev/sashiko) is used these days by
> Linux kernel developers and seems to work well for them.
>
> At GitLab and probably in other companies, some of us also use AI to
> review our work before sending it to the mailing list. And yeah, it
> helps find issues before our patches reach the mailing list.
>
> In the same way as we require that patches must pass CI, do we want to
> require that patches "pass" an AI review before they get accepted?

I do not think so.  You (figuratively, not limited to Christian
Couder) are welcome to use whatever tool available to you to help
you polish your submission, and the higher quality your patches are
(e.g., fewer typos and jumps in logic flow that interferes the
thought process of human reviewers), the more helpful you are being
to the community.  The use of GitHub PR initiated CI run falls into
the same category, I think, in that we do not require you to have an
account and trigger the CI there, but you are doing a good service
if you made sure you caught breakages on macOS you do not have
access to otherwise before sending your patches to the list.

But I do not think we should require you to bring your own token
budget to be able to contribute.

> The benefit would be that it would hopefully catch a lot of trivial
> things like indentation, typos/grammos, etc, and a lot of things a bit
> more difficult to spot like memory issues. Perhaps with some amount of
> prompting/configuration (for example pointing it at our
> CodingGuidelines and SubmittingPatches) it could also catch issues
> like style issues, commits that do too many things, refactoring
> opportunities, etc.

Yes.

Similarly, you are welcome to use tools including AI tools to help
you review others' patches, or help sanity check your reviews of
others' patches before you send them out.  The reason why such an
effort is valuable to the community is the same.

But I personally consider that the use of the tools (not limited to
AI tools) is up to each developer.  What counts a lot more is the
quality of the output.  Just like PR driven CI at GitHub is offered
to everybody who wants to participate and is willing to have an
account there, it may help those aspiring developers if automated
review services are made easily available, but it is a different
story to _require_ use of such service.


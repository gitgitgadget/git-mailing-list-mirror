Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A313BB4A
	for <git@vger.kernel.org>; Fri,  8 May 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208623; cv=none; b=Tf/b0i7z3D3rgKvCkGuYLPySYl825AYNxlGu38ymnxVltCSF2oexcd3LGZgE9R1NCeGb/7P2XbHpldd3bjIUC2Y+UFmQr7FmbT8ch/VTygNC2B5PMZv+hIxvBq2MVNmIWaQX4sUPCVw6vO+d+BsntiGoO4SeYmkmsIVrMU54RbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208623; c=relaxed/simple;
	bh=F5xdXltys9IpP2zjW8PMxElwXm1v89JULatYBPgXJkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cQNoxqDJBznWb+EtJWH10BvoM5i7Y8ShwCvSOV1eQufPaI6mkzlWTki3psb4lFIgn7n8jTlPyxVu1bx38QvYKsynXoOf1z61dvJuvy5NWaYEVha9B7fDwoa0W86gdyeEqavaAW7TnDvoZXRF60MspMFLE/VlCqoEFhYATvdwDaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tu1rtuEk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnIfqwxw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tu1rtuEk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnIfqwxw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DC2B21D000A9;
	Thu,  7 May 2026 22:50:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 07 May 2026 22:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778208620; x=1778295020; bh=tljNoIbitQ
	ZMnHHBzRJ16jLpprPdHCLBSjSrl4pguS0=; b=tu1rtuEk9cVzEG+JhD+a9K/Qbt
	d/NV6lxLssuNFCd9UCCBltMxDVitu1bGwI7eY9t9GeNrxq6U4tn1Ge5p6+JWQ96v
	ANewjJqIc7UXmmDcXZziZuMSTdH/hBQ7EC0BgbGPBOMgvScRh7jwVUB+0sP2YStS
	HcydVZZP2fgsIisNCCyfqv9elRsNK8R2KDcwrTvYOHoprH+Z1FPsOTtTcRlEZXiK
	7JAmES1KBEDh6qhe6+ui6VYLRBZm7O3qu8NHGOkw2UzR08kaL/3Wy1UpgFhnJttm
	zKZaw6liOIpkzUcCbhlFwIMLXuS5cGOarX0M0SfNEQv+6hIsj8ka2y1BvdQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778208620; x=1778295020; bh=tljNoIbitQZMnHHBzRJ16jLpprPdHCLBSjS
	rl4pguS0=; b=EnIfqwxwMcZRu1TkG4GikLMXaBZpl546wwrRWrUDd0KWS8Uiikt
	XrKpUHs8Vo2QBFFqdpjnrfNaAPPbZcTVos5T6O7js3hKB4m5O7rewnujLLWMCaRz
	H/JSWf30HgtZf6BgG7cvJr16+S+WqKhL7ksYKdkgDEDK1R3R+rXV86L9R5peBiTZ
	1uCfCGTKen6ERyhrzmr8zLSc4XZso2Q484CK/Z6XtqX/GBBE9WEYE7gT5pyOPa78
	3SLNmbpKNxd24PZvYVMv24tBnQQUu73DYjjHZ5AlszdOAcojtJ8RJ838cNtxBRu3
	iKi0IhOg7i0k/csQrMnlHfL7LHjwd82m7HQ==
X-ME-Sender: <xms:bE_9aXMXGbOGiVoWlRnks9ZhR-yr1mZX8aTs0fohmBsH4E5SW39Q-A>
    <xme:bE_9aUNSkiPoUJ9bBVRglaoU7zvKft-mxO3IcKyB-sbXdAq9kdUqAt1mbaxMpLBf9
    45Kv1ebBeF_VVn-TenOMZAcy44ej7OdRiFw1cwu35TIxWgzsAVrWrY>
X-ME-Received: <xmr:bE_9aYgUPXYFA5fwwlZGi2_mvHjIqMOzO68c4OWwa_7ywP_smPRPAlKoi_uvT_TYYIb2OMkzMAIyk3krSXMIBDY1pNPE1u8qVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bE_9aRtcg6TMUjwoPSh5vc8USVlhMgemm6HocW7YNOYtEFlO-FXMGQ>
    <xmx:bE_9aeRNR6ufYqe0xoAJ-gG8-RpXasLjde_k4zjobkH-ex3wFJJ7TQ>
    <xmx:bE_9ad1h1NXOi0fmmu1FIHlaSsu2PQTxb281eZsSRpAQxvSLDDVnAw>
    <xmx:bE_9abuU8Cz57y_1qkRmjPoHr55lXKB5n0wxhhN73oaC5kWdq7J1jA>
    <xmx:bE_9aTb2VKTJK1jy4e_vOhdGvUZTeDgwpweZMaWfNAwSRMWZwIEsiigE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 22:50:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
In-Reply-To: <xmqq5x52nhg6.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	05 May 2026 21:56:09 +0900")
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
	<42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
	<xmqq5x52nhg6.fsf@gitster.g>
Date: Fri, 08 May 2026 11:50:18 +0900
Message-ID: <xmqqqznmfwd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> 
>>> Derrick Stolee suggested [1] that expensive tests should be run at a
>>> regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
>>> on push builds to the integration branches (next, master, main, maint)
>>> so that the EXPENSIVE prereq is satisfied there but not during PR
>>> validation, where the extra minutes of wall-clock time do not justify
>>> themselves.
>> I like that this will be run as part of regular updates to the
>> important branches. The important bit after that is whether or
>> not a human pays attention to the signal of these builds.
>>
>> Junio: Do you pay attention to CI breaks when you push to
>> 'master'?
>
> Well, it is way too late to notice breakage when the faulty update
> hits 'master'.  CI failures should be noticed before breakage hits
> 'next'.
>
> I often notice and complain when I see failures on 'seen', and
> sometimes I help original submitter by bisecting, but I do not
> necessarily have enough time and bandwidth to help everybody.

To more directly answer your question, yes I do pay attention, but
not only when I push to 'master', but when I push to any of the
integration branches.  I pay most attention to breakage in 'seen',
so that I can notify authors of new topics early.  Sometimes you may
see many pushes only to 'seen' at github.com/git/git while 'seen' on
the other hosting sites are not updated with these commits, and if
you notice them, you caught me bisecting the breakage on it.  This
is so that I can eject offending topics and notify the author.

But this does not scale, and I shouldn't have to do it myself.

Making sure the topics come in a shape that they pass the tests
before they hit my tree is one way to reduce the need for the
maintainer bottleneck.

> It would be best to find problems early, and make it easier for
> individual contributors to help each other by having a concrete CI
> failure reports in their forks that they can point at when they ask
> for help.  And CI run when I push 'seen' or 'master' out would not
> help as much as CI run when they publish their forked branches would.
>
> By the way, please expect slow responses as I am (officially) still
> mostly offline for the rest of the week.
>
> Thanks.

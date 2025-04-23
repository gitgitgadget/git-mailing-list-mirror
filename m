Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809C2223DFB
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438683; cv=none; b=ZCiQtjgRacgDZRPmla3yh0W2fkkeDTMfkYQ2Mh6rL3+coI7bF8CUXnOKa1WVG/Q2m/+AXH3lng2Oknj0bqsRaTUkLOA4NfUl8CsM3xz+0+4rjhwhdw6XlrohpNjNafV3o3XhHPtWsEPdv1jbtd3/w53RI7WOHbPH6QLElXPZqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438683; c=relaxed/simple;
	bh=hOQ5mrsnq9ndmTk5zjT9VxqlHeJzXFFQ29tDU2zKhME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UsVc+gbZbjO13BP1y0rPXKv7KA7PtqfLP29De/fCy5quTJAhwaa6OQI9GSRuPnZxKZUgiio9pFeZRDzUP7LJVwRYxMvLXEnM3SVWv2f5rnyo/bGt1hQ0ylowhJX6hCACWUdYtcJn/k5rc8AEJ3JvSmVefnWYt+YtEUR9b0pZeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M4VJkwUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJeiKO+h; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M4VJkwUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJeiKO+h"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DD281380196;
	Wed, 23 Apr 2025 16:04:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 23 Apr 2025 16:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745438679; x=1745525079; bh=hOQ5mrsnq9
	ndmTk5zjT9VxqlHeJzXFFQ29tDU2zKhME=; b=M4VJkwUk6MvuLLZz2KcRgILPyC
	b7EGOrdriAalm0iTIin4pR5GswAvobbv6bIziVZHlAdRqharlSFkA0Q7SlbmSxPt
	elCFryj8+U09RtE/Mvga2f59afxVkGbOOA1yQ3S4GU5V8zKrMruCXZjueI+d3ZSg
	NgBfZEZqok0CVaDEEQ5S4jEjbMm/B59YsdkX8ddm7axDVz5lz0ELb3WGxdTr4tkx
	gs+JkjKeOz7SXdVQHo7XkN8ocO1WL2ySEEhw09x4rwXzOp4D0N97pL/ZIwxVl2lF
	97f7kEj7+EVWgLgZOO39LICI6yjVBas66vVohQqsYOouur6I0D7IDmY3c90g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745438679; x=1745525079; bh=hOQ5mrsnq9ndmTk5zjT9VxqlHeJzXFFQ29t
	DU2zKhME=; b=ZJeiKO+hAdz0WSdwyDOixHsIyRVkzvsa2Swi5GPwdIlNHyLuEqU
	lXCOYYj6Q9GDEw4ui8/G4Fvrw47GSFZSPLA4vRC+M2dgcOO0qjCmSKKz/NX990r4
	bGyrcjMGxT89pKVyvxRge7LR5n5wrlnkm0THhpAKqsSBEy0/LnWOMHEhXcyPfbGo
	6Ju/6sLHXG1QEqFHOR1Y82ubhWpS033GwWuwzt6lksmXa5P9n0zqqahYNNEODDEQ
	tACF8DY//iLKhEQdG340hDZWQY5UMb8E+c6XW1zz/AzxKD8H+RHmIBAp0HRjTwkN
	UNxTZqmoLOOS1K4HrkNnSaL7rDqEzRMk63A==
X-ME-Sender: <xms:1kcJaPHhDj14N24C4u9vtzKdSRGVzb02eHEDHahjTXPF5qC3rjxASw>
    <xme:1kcJaMXVdu5E1Uy5pTxxbHBntIzdeQDSm3fsALolaQhmYFHupUscknLUfrvk8qpWg
    NPp9KZjZy56CJ1PjQ>
X-ME-Received: <xmr:1kcJaBJbpCun4XJpgLwtAoYJ-gkXm0-dRGlGHbaVHsReKVt6_lvk6S34S2EjX91mhkR_xgql0udQtsNmsEZIaTG3hmZSZJPaZUNJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1kcJaNFeSBQcNiczuR7HKaIgvHYymBYJ6qJQcJc9DUu1y0lgao4uxw>
    <xmx:1kcJaFXp74q-uufwGHPlZLVP5yOW4QIr0f3oxcerpudgJoZR6cW89g>
    <xmx:1kcJaINTCwXYRzU1KW2pifXVbDNj42PRAeouKXIks8SL90y2Q6S3fQ>
    <xmx:1kcJaE3SO1yDWTzgACOXJLfV0AvIEO7zFvTfiu1kxFgeMd-ZjBtG-g>
    <xmx:10cJaI5pPJ4a5PMfZFcVEWageR-Xi7P-tcGJePfgb7vsBxvFXTgAsvCA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 16:04:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v5 0/6] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <xmqqtt6ezshm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	23 Apr 2025 10:40:21 -0700")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250423-505-wire-up-sparse-via-meson-v5-0-d1e2be4b2078@gmail.com>
	<8a907622-a975-4f9c-86b3-54b8f5447709@gmail.com>
	<xmqqtt6ezshm.fsf@gitster.g>
Date: Wed, 23 Apr 2025 13:04:36 -0700
Message-ID: <xmqqv7quwsob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> phillip.wood123@gmail.com writes:
>
>> Hi Karthik
>>
>> This looks good, I've left a couple of comments but I don't think
>> there is anything that necessitates a re-roll.
>>
>> Thanks
>>
>> Phillip
>
> Thanks, I think the first one that stops us from using tarball
> extract may have the biggest impact on the CI, and might reveal
> some other bugs (like "this test used to be skipped because it did
> not run in a tarball extract, but now this is run and fails"), which
> may cause us to scramble to fix them, but I think that would be a
> good thing in the longer term.

As it takes quite a lot of time to do full integration of the day,
during which time GitHub CI is idle, I pushed this branch alone as
if it were the tip of 'seen', and it seems that quite a lot of CI
jobs are now broken,

https://github.com/git/git/actions/runs/14624509129/

with "Process completed with exit code 8." at the end of
ci/install-dependencies.sh step.



Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8441EDA36
	for <git@vger.kernel.org>; Fri,  2 May 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216348; cv=none; b=bOK1WvgMaOdM7ECxfs1/w1CDkN0IM9cfRiWytyV1uJuYOj1g5huLT90iFrayKxfDEX/qafe8mgJ7up/+4Gp1bK1Ko62O7iLZ9JoP3jx0jCyD7qmKcXn399mYBgieVOceEID5mOG71VcHeXxqy6VVTTjAC0Y0+tTLLW1axAScjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216348; c=relaxed/simple;
	bh=mg/Ppnpa9HqYLGnA4MDIPbR4pum+DkrDoUe5tJ4PJMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KIUVrYhmFU4gpeFspo/CjlolP2PsVF05RPirHPa/vAOqWY521eiyzwoPV0hyRxfiH22nUys/1S+svhnh5TV/0w9mCGdoNRyPPgE1np2PFi3ocWP/TcL8FPsGkVXPpZRJS8i6BhNwk1H8h1nqAlQUYdwHqE2tEwaV62+8pWuTxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kIop+zxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kAfX9ARa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kIop+zxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kAfX9ARa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FDE61380F95;
	Fri,  2 May 2025 16:05:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 02 May 2025 16:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746216344; x=1746302744; bh=1naCGyDbpr
	zKAa0IW60OYjTbAKZ+nux5LGsf1B3bZgY=; b=kIop+zxZByv+DFZ0rp7Stu8jq6
	AAYmAd834pYq8BhU48Y2Wn3YVBA2HhxReDe8GTh9XJKWmssaa86k/26Lbr1Go6aW
	ROnFKYmBvw4UlTWxFBIHg5PPypaa6VyKiMa2oXP26ou0F8A3PE2i9SOAMM6tfvuQ
	VH6qMVDYcd0rDleK4zsj693QSjZREakjccnp/aARuTvyPlFkPOAynv17SjqDBY6s
	4zG+lVZZCHDNcC6kDhchXgmcPdNASpgFXs4b0WzkFm8TauQvXv6GOdqAKplJNjhw
	pPGgJufJApfJBYc1pw9rZ1P5LScXmNgbjri892sEHOLBjAISuQQSmacA76BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746216344; x=1746302744; bh=1naCGyDbprzKAa0IW60OYjTbAKZ+nux5LGs
	f1B3bZgY=; b=kAfX9ARaqw7Wctg0j1292bLcV4NbV+8tPrWqIq4ycG52VZ42Evl
	LLL7OklaN+mqzN2W1buoriRxeispYE/66Bw2+Sn9YwHdoIceSNzxHOW1sYJCUzOj
	EKgWUMbau6bpV57XnqGTGLjxQfYEN0rPR4B7eKk1LEi1FAmMvJ08l1AoQJd2VKUf
	hi5kJjW8VVRHHsn+33HLZ1sdTPORUWHU33c3mOFHLqj73oQvSdk5+ELzgaLLifjn
	9ApCZry1rbrmHs53NgTH9K0YN3+Pa/KP/tXxBcA/9fmn52hhwYKEk8TKhWuNsEJ9
	7pPObES4tDl8Ut4ts7DfXqvkEwBRIDrKfYw==
X-ME-Sender: <xms:lyUVaMh5F3AjvtbCWAIsDYJX3-YIAIgYqyh-dPI8AFhus6XdeexTEQ>
    <xme:lyUVaFCmvs3feeN2jtCEWbIS0l-8J3IhByZDQdUX16AOqwWG3u89lpiP3v_oLq20o
    PYE6zU43sVy6tN76Q>
X-ME-Received: <xmr:lyUVaEEIuYwOT1YuWhtUzNCkpoBXi3kkn-H-u0uFgoCWe7JIxYedSzkqnVgEyn4UcGrfkhMTZGNpZ2916ZPSGax562aaCjSJNLMj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeffeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lyUVaNRVAmdIThET1LXrPkbzPu3DZbLQY1NyOMSL8chf34XZjLjBtw>
    <xmx:lyUVaJzHziitf3YUVuJufpzOxKuV1Vdq6pC4A-mqc8JNOsP7ciY_SQ>
    <xmx:lyUVaL7BF_R1MsT-paHWzYXbfq8Tq5yiD0heT10P8OKSY6DYsc1Tbg>
    <xmx:lyUVaGzD8xcWNiQuxDqWwSTRl_jnztlToCtUHjvipowd_e5ATeXIeQ>
    <xmx:mCUVaEj-5K5OmpEQLIk45aYO-1xsTz46VE4onCHjiq-NxHxQZtHXAiV3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 16:05:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] config: values of pathname type can be prefixed
 with :(optional)
In-Reply-To: <aBSHugZcH8NusOcI@pks.im> (Patrick Steinhardt's message of "Fri,
	2 May 2025 10:52:10 +0200")
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
	<20250501214057.371711-1-gitster@pobox.com>
	<20250501214057.371711-3-gitster@pobox.com> <aBSHugZcH8NusOcI@pks.im>
Date: Fri, 02 May 2025 13:05:41 -0700
Message-ID: <xmqq1pt6vkve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I can see why it may be useful to allow for non-existent paths. But I
> wonder whether we really should be skipping over empty files, as well,
> as it may be assuming too much about the semantics of a given config
> key. In other words, are we reasonably sure that there won't ever be a
> usecase where you may want to specify an optional and empty file? And
> are there any use cases where an empty file should be ignored?

If somebody goes back to the original discussion that happened a few
years before the patches were originally written, they might find a
use case where it is more convenient to ignore an empty file, but it
is an old patch series, so I do not remember the details.

I would not be surprised if the design decision for an empty blob
was done without any deep thought or motivationg use case.  After
all, this was "I had nothing better to do, so wrote these out of
boredom" patchset, as its cover letter said.

If somebody wants to carry these patches forward (which I am hoping
because there were a few people who expressed interest recently, and
because I am not all that interested, certainly not more than those
who wanted to have this feature), I think that the right approach is
to extend the system by taking advantage of the syntax that was
designed to be extensible.  In addition to ":(optional)", we could
add different variants like ":(optional,ignore-empty)" with desired
semantics, for example.

Thanks.

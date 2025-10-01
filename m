Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E56286D7B
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336910; cv=none; b=EQnK8kMj1Ybbg4JTzbi9JtuG+jYQiy/LOg7H+BCA854eniOT2D+EeCwfek6dR5++Mh9ZpqD2Ow5TfodObQp3QzR0HsOhp60uKD1KixfbJ3AuZ6A+aL0QjT5sJkX5JjjJp4N+vJOoVjj6k5PL1p/xzTvWbEb0V9uswgaowE1vkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336910; c=relaxed/simple;
	bh=PYaGyvwk/Xs7rP1FfCnU+UHtQX3bbBRn5XNtXv/cFbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7wHZeASH4PzrbjdmGbtnyFLvUDERaWLj+mf4QK8ZuHPqNhKCBDWhffJNTEBJchWlUuSg+d9SQVq76m2wV3k88ayRxMPI5+yOPbt5SfERX2RrpudHNbnodfzbUmGKFsGSrnLVaMgn1qAhFDz2IJvWh6B8tn6tEcIhVN1VudyEeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGpxW/61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gW/BzZVZ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGpxW/61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gW/BzZVZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C454A1D00292;
	Wed,  1 Oct 2025 12:41:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 12:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759336907; x=1759423307; bh=Cw8p0LHC4H
	WFXKpEL2VRm4MoENnWHMzu8ps9uyjZt04=; b=XGpxW/61GYxLsXry5qSAZTz3Yj
	ux29efPjhv+fXoOTNoM5VDfF253sMm0BZkBzov6YlplN4gI8z8zoPCZt6qLiUbGx
	9E4trHF0RVFMCje/N1lXYBJj/iccjgda46FUxLQk8Wrw6lY7puTVzJ9BJ/t5KAKu
	QUiQNdH8/q2+aoHS6m8Vx7eMSAy/B/39Puy9hy+waprrYYJIe+NH/2OjSs4T+DVn
	B+9OrnieKDgx5bukkRoVKJsWNOQ88NCMVLd7SiDfRJEgSatZdqVer9JNYNzmRaMl
	Q4A1Aditiz22KEwiqvjQG0TosnBo1j69BOAxG29rbSMsEF5QWvCuTzthllBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759336907; x=1759423307; bh=Cw8p0LHC4HWFXKpEL2VRm4MoENnWHMzu8ps
	9uyjZt04=; b=gW/BzZVZrHCUQ755lRzTOYu+k5AkJwf8SidTlVMCeaSivVsaq9R
	TMqmlqdmyc+Ajn5daEkhNloheQFdUCOHUoq6PGphW/lDhnW8n8DHXD6hZm0jdFat
	M2DzjqOuxPk+Ub7mazqNYxTg9X3WzJOWpjTRy3PKd9C3WhwTklQYWOfx/HhIAe2Q
	kN4OZ7KLi0/mEKkfchKh08mYc9uNJMUm0vTE7qZH2RuwbTnunsK+dHSXIngNHOVf
	2+eqtkVpgILiobQ+dojCnthMV2A4eHwSiCVBDZrDx3zB81MtZ7SoW4Z2PS+nWxdk
	59UIE94vKW3T/UI4T4pVLk6p4PUkZt909rQ==
X-ME-Sender: <xms:y1ndaCBk_0-Hvgmtz2x2P9W14EnHUjJA_BX7bGYVKyT-qDc5cdGB-Q>
    <xme:y1ndaD9ZBEM86fxrzDKEy4qWiW1rokpvEJjP5cHnzd8oSkyWF36asZFOqRmN_Lb1U
    nrqZruLG2P8_ESMPwauhB4ZfqCorsJ0A394QQggfU4cFrcr8EUN8VI>
X-ME-Received: <xmr:y1ndaC-imo1KDRpqp2rK0o-4Pf6bNDoMTDaO3CRXvyQP8sj2jXNF7GMf1hkohcbVwbna3_prRP8yD1CKnUH9JCaGNuIioofVQIRj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhhrihhq
    uhgvghhoghhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:y1ndaKfLq2ahuz6-iVEvVjJubj2Rq0Rxc4uW2pzbZZZCS8oU-h9WOA>
    <xmx:y1ndaLE7cwoPvQi3Cbn0hiAKeu_0uv6uPS1j6UcPSgoeQMvFTKC_4A>
    <xmx:y1ndaIfxborZU9YYAAc1uhR9ZwjlSh2iBX1To7q9CUwqIDKYdiH2Ug>
    <xmx:y1ndaFEqg8bRWIriepU6y-V5wINdTPJC8JherGtADruHxliI7Jvdpg>
    <xmx:y1ndaHkHj68aayJnqWZBuj9ML5rSBhrlW_DOVWEXiAQcwFeKQEHptc8n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 12:41:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Henrique Soares <henriquegogo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How mantainers check Git diffs and patches?
In-Reply-To: <aNygY8Cm7LEaBzV6@localhost> (Henrique Soares's message of "Wed,
	1 Oct 2025 00:30:43 -0300")
References: <aNygY8Cm7LEaBzV6@localhost>
Date: Wed, 01 Oct 2025 09:41:46 -0700
Message-ID: <xmqqh5wi3779.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Henrique Soares <henriquegogo@gmail.com> writes:

> This is a simple question I have related to the PR diff review process.
>
> How Git maintainers use to check diffs and review the code? I mean,
> sometimes I see that there are some large PATCHES that is hard or
> probably impossible to review only using e-mail client.
>
> Do you use some syntax highlight in client e-mail; any pipeline that
> automatically download e-mails and apply to a local branch; or for each
> PR you save the e-mail file then "git apply" to review / test the diff?
>
> This isn't a technical question, I'm just curious about how you do it.

Even a very small patch that applies a change to an early part of an
ultra-long function may be hard to assess depending on how far the
effect of that change gets propagated through the code flow to
affect the code near the bottom of the function.

Patches are medium for reliable transmission.  Once you apply the
patch to your tree (perhaps giving it its own topic branch, perhaps
to a detached HEAD with the full intention that you will discard it
after you are done inspecting the change the patch brings in), you
can use any regular tools you use while developing and reviewing
your own code.

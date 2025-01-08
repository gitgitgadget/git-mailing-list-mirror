Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08C315B99E
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352228; cv=none; b=tX7lnNw0kmkjnPDRFHs402TWCkxd5Pn/fYINU+WGdLG++DNcZf5GuZ0ZuXMSCuPrO8w+bKfa6Ir2LteO4c2VfQfdVu64JtKRu+ZHkyxDQGRahv1SqOWpdwMYjva2BNMUzHVlz9QPps5cFNdUSFpojrvwf/V96rIA7wnWNpXy2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352228; c=relaxed/simple;
	bh=h5mBp/SK3brGGqDFCR/2x5IsTHclLVVkT3wCQ1zUO00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NO5V8eX+DbgvvhTMEpgusuFhV1lXvq9hrSj8Nq85HOU6nH7qgpUUDpH2JV8TpBtE+yxI2IvB0IQPFKxMdgXAz4qA7QMXsy4o9ZcXbZgDM1hEXcF5ROdS8lDh9oY9ZhL8Lzo8JXFjuVdj0I+NPqtN2nOiiRZfCjF73S1+MEucN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SS2G3FeH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfH+CkDq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SS2G3FeH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EfH+CkDq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B6B1625400E6;
	Wed,  8 Jan 2025 11:03:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jan 2025 11:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736352224; x=1736438624; bh=jznAXEjeai
	jkrr+eZ6u2Byu4mW1HWkD9IAn7WIY6Rqc=; b=SS2G3FeHzuVy3lu17JpM175Lqt
	rd/hsEdhCOLDNONA6dOQaLN5mquUrZbfYqE4vROSq8BnoCthsG78Ye8t04icTolg
	QvfvcA6r7N2HE63I332XWUmthQd7i1upZ8R8QHJMdStAGP/n8t+qZPgvOkI20Vn0
	U9asq4svQL7El4Kz1hvUnAQk8DcryGVj2W5+kbx7RUt2/7UqJmoM0LSdoiRK211H
	J0IMmQ1qA7Ec4lBrDeWMszV8/DqXbKOKQv8AU6CMbOH/hpM1TkGfWUYgNOBXzRIO
	PnFoMdwZl5qOLezUkmsQ6kSiLDOwg7JvU+9UxuxeUHFHc/M8xA7h6oWuvvKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736352224; x=1736438624; bh=jznAXEjeaijkrr+eZ6u2Byu4mW1HWkD9IAn
	7WIY6Rqc=; b=EfH+CkDqROC6iZhTjMaoqDsYQYnVQtltVTJiNZyqr54xP3cZoKL
	C+ZyhSrF6BI8oDByfc8scmFpqKhzn6K8wu/L5RxxSFrz6O/syTQ6qkR2bF+Whb3h
	UmUvlhb6IKcHAjICLcMuDFbQsO3HORqovc3d9qcakMqR3glh/FqX8HigLfEX5/Hc
	uTmqWrJhXRfHh5Om+v6maD352iKFM3HXcHF5Oi6NF3RbOcxTFL9r22HdijGmenDd
	lJQdjJ0bMXaiQV4GbAiP/Af0fy4uFnen6foFA2GA8rLaO0opuY8NUpstPl36+0bV
	I/4gaTb4a3ncgfChvmHA6DqLRb91JXsKATg==
X-ME-Sender: <xms:36F-Z27jfnpN6t4gheeO3mOimD6BR1d0xVYfCAML7QJ1oiIfetLH9Q>
    <xme:36F-Z_7FuX0tzkn2TE3V9pPiDwWo_8itF_rAWy-NgLO5ueK7vgbWwn2gb7Mf2aVWd
    rlB7tdLO9cpokUtmg>
X-ME-Received: <xmr:36F-Z1fZgzGwiNFYvzOsYeWpe76Fre2GxJD8bviSbibQfJPV7FA7t3fmAB0Q4swc-rQ1GxTQO-YNr98dutR2vQsiH-v0FzNGjioA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgrughimhesiigvih
    htlhhinhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnh
    gvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:36F-ZzIgf53M_ZU9lgEaN3S81S4Ph0ytoj5DcjxJUVw-sYvjK7JcUw>
    <xmx:36F-Z6JlaYwbTZtCqYAg8HZX06r2sAc3ZK1dh29EzYbRjpisy-BGMw>
    <xmx:36F-Z0xubigeapcI_7MGEFTCwTnbqlBlqcuO5kVRkTz4vkqygAm_Dw>
    <xmx:36F-Z-LPynZAmW37697qAOQjbN1feScmMkDvnEB_MyQGbSkJfCfXrQ>
    <xmx:4KF-Z_G43QXQR5wYqm_UXBv928ipFvOVY-7eEWTs074ifGXqDZCKO5ng>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:03:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Vadim Zeitlin <vadim@zeitlins.org>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Would it be possible to add an option to disable validating
 submodule paths?
In-Reply-To: <Mahogany-0.68.0-2854301-20250108-005035.01@dark.tt-solutions.com>
	(Vadim Zeitlin's message of "Wed, 8 Jan 2025 00:50:35 +0100")
References: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
	<Z320RGb0tqNyvvxt@tapette.crustytoothpaste.net>
	<xmqq5xmqqk9j.fsf@gitster.g>
	<Mahogany-0.68.0-2854301-20250108-005035.01@dark.tt-solutions.com>
Date: Wed, 08 Jan 2025 08:03:42 -0800
Message-ID: <xmqqjzb5nvhd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vadim Zeitlin <vadim@zeitlins.org> writes:

> JCH> Sounds reasonable, but I wonder how this would interact with
> JCH> bootstrapping.  Should it be configured in ~/.gitconfig, possibly
> JCH> with [includeIf] to specify the directory you'd store a bunch of
> JCH> repositories you clone from outside, or something?  I guess "git
> JCH> clone" without "--recurse-submodules" is simple enough to be used
> JCH> for bootstrapping, and then the configuration can be set at the
> JCH> top-level superproject after cloning but before "submodule init".
>
>  I might be missing something here, but if the question is about whether we
> need to have any special support for this in git-clone itself, then I don't
> think so, it's a rather special use case and running git-clone without
> --recurse-submodules and initializing (some) submodules later while
> symlinking some other ones is only a minor inconvenience, if that.

If you say so then I'd stop worrying about it ;-)  I am not a heavy
submodule user myself.

The worry came primarily from the fact that this was reported as a
"we have been using submodules happily in this particular manner but
with a new version of Git it stopped working" regression.  Your
set-up was created with an older version of Git that did not have
the problematic "defence in depth".  If you or somebody else wanted
to recreate the same set-up from scratch, would "git clone" that is
unmodified, other than conditionally disables the check introduced
by the commit e8d06089 (submodule: require the submodule path to
contain directories only, 2024-03-26), let you do so?  Or would it
also need to honor the new configuration that conditionally disables
the check, and if so, how would we make sure it is read during "git
clone" (which has kind of special chicken-and-egg problem with
respect to configuration settings).

> ... Should it be something like
> submodule.validate instead, perhaps? Please let me know if anybody has any
> better ideas.

Is "it MUST NOT BE a symbolic link" the only thing the validation
does?  Would there be extra check on top of what is currently there
that may turn out to be useful?  If the answers are no and/or yes,
"submodule.validate=no" sounds like a reasonable choice, but I am
not good at naming, so we may want to hear ideas from others.

Thanks.


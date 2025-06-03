Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E893155C82
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994159; cv=none; b=KdlBRtwqAAQ8PQ7diBMLcR4+stJjpZR9wtxMGwxZGERc4FL7JAhjugLDFV1E/rC6Ef4LiAFaxXzQZD0IQyfUdVOQcWo4wd65G7WkukhgWB9Q34DsTuB4hLxblVrQkYysM/8P1W0HHb08+4AjZzdCZPBnaTF7452ka80ISDILZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994159; c=relaxed/simple;
	bh=DZZTlKe7/vXqhZEP0J/QqKooZzq8JQYpSxnqJHyotFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qRPwmlFf5EAJOWyFHEIw6puNosoxXHKgNR0ro9ZAnxbqlRm0QpvVaLyjzwR9lQxdrd6gXWgu9qihU7iF+YubNY8XFJRMdHOyqPZhhaKR9Rys1RlM+JxpKVZ0CamHptX6YJxccl2EzuwvrLbkDSaQERx1FwlFtEtFjRjRZhzhrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SSOtyLpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X7Ev6EZ+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SSOtyLpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X7Ev6EZ+"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20B281140138;
	Tue,  3 Jun 2025 19:42:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 19:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748994156; x=1749080556; bh=HaBTQBt0dh
	wx5Hc0rgGq8giP4oGH7kz50YAOtAxJqRM=; b=SSOtyLpy2+7x1+SIVd2afGnF5/
	fslYeT1IHUcxabYw5bnWLU1vncbYu5isd6U+CxGxuU8UGAAeCxhZWpJkyIVoQdXM
	RWNkIfSqOjFx6fB8uFwrG/ZhyfHvopk4wgxOpV3Yc0s2WvCPSrZixmGOavZIh6xm
	TjQv2MUJ8qaUqNGrSh7LiV+660MEbHTT3WRxYyi2NzarhxbmNbHpnyP/vt5i3t4U
	xFdglJqZ3bfGKQhy3ukhZlIuTcc4kyjCzy2PZzLhrx1pux5F0t0W810cVu0XVlAo
	cN7YzsVdVQ2e9PnOgggty4lLMoQTjMdcrHRd723xX66EJGUrdYyZ0QMpRcDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748994156; x=1749080556; bh=HaBTQBt0dhwx5Hc0rgGq8giP4oGH7kz50YA
	OtAxJqRM=; b=X7Ev6EZ+qCQiLVakditfw4D4kVGMJ/QZfKuu4RYTNzgZSVuJP8U
	L0S22U0t9yQFhCcyYKaLdPby4DYkusIv+sGvhj7wjlRLlh91dGzuAwN8KawmQQ7d
	8jfza8pm+7ogp0p2PxbSZqRcKaZe4YXiIdMv/CIOAN/evJjQ6KZWVrrI+m/oHu+C
	b1riBgK9Qb5CwUEaXltYI1+iY3iYtQo2VGvmHO2p6i/3m/g0KBGdww/SiJHNLwBg
	Vi75W73szn09XE7zmT8OkONrm83DKbCwTdDy/hvMJEsSqVhLgyzXA0gDgkkitDqE
	pMsUApX7ew5aJC/XqezdzbkGymqhaqjj10g==
X-ME-Sender: <xms:a4g_aInHH30VseUFR8gpBElqfnZsSvd2R8rhD5tWnV4Kqx0NeQlpPQ>
    <xme:a4g_aH0nD9wvhAZJJ2nG92NQS49nIXupzcVR0lzOhPCKkvlGSgKlBplVY-3EJ-OvU
    srfGTdGbYTszT8wHg>
X-ME-Received: <xmr:a4g_aGp2ihTDlAuz-lv48dkBNkFNyGX_COEpH0adyEwUHN4EPbxC6m59r6zUEBE_-n1zijqE_0NW2MQ9p4VgoVpTNbULjDLGsOKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkh
    gvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:a4g_aEkT839eGAZOv6NzGS0-epIj8461Cwtg8RtrDkyoNqywqqIG1w>
    <xmx:a4g_aG2QYi8opj9HA75mNEHKr4U3dC4TWxA7Qu1IMGGrUseAWFsUEQ>
    <xmx:a4g_aLsIHOZyuy1EdOkDEae6D1LphsDG2dciWEuDtkdalzaZExCxBQ>
    <xmx:a4g_aCVLydJudsFmmVaillLwLXFyuvWekLNnXPqUAFbQRzSETemClw>
    <xmx:bIg_aIS9yrSXsIgHFLWg_eIGYq5QsGGaBfzOfq2B3ZWFP_1yYJj19OGc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 19:42:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: issue with git submodules and a clone.defaultRemoteName
 different than origin?
In-Reply-To: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com> (Jacob Keller's
	message of "Tue, 3 Jun 2025 16:06:27 -0700")
References: <4f638125-39e0-43a1-9c58-35c2d433042f@intel.com>
Date: Tue, 03 Jun 2025 16:42:34 -0700
Message-ID: <xmqq1ps0gzo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> fatal: 'origin' does not appear to be a git repository
>> fatal: Could not read from remote repository.
>>  ...
> This appears to be due to the builtin/submodule--helper hard coding
> "origin" in "repo_get_default_remote".
>
> I am unsure what the best way to fix this is. I could have the function
> read the clone.defaultRemoteName, or I could have it check if there is
> only one remote then use that.. or maybe add a new submodule remote name
> option?

Is it is the nickname of the default remote that corresponds to
'origin' in other/most peoples' set-up you are using for your
submodules that is causing you?  And because you have
clone.defaultRemoteName configured either in the superproject's
.git/config or your personal ~/.gitconfig, when you activate
submodules, the "git clone" used to populate your submodule
directory from elsewhere would use that custom name?

What I am trying to figure out by thinking aloud is if there a place
where that custom name name is recorded anywhere in the submodule
repository (or superproject, but I somehow doubt it).

The clone.defaultRemoteName configuration variable can be overriden
from the command line of "git clone", and even if the process to
activate a submodule does not let you pass the "--origin", you could
have updated your clone.defaultRemoteName, so the current value of
the configuration variable is pretty much useless.  

Your "if there is only a single remote" would probably be a better
way.  The only reason you are having trouble, if I am reading the
repo_get_default_remote(), is because you are on a detached HEAD.
Do we know where that HEAD was detached from, perhaps from the
reflog?  If we are on a concrete branch, there already is a logic to
figure out what branch from what remote it integrates with, and that
would give you the most reliable answer.

> Thoughts on what the best solution is here?
>
> I'm thinking the following:
>
> 1) check if there is only one remote, then use that
> 2) check clone.defaultRemoteName and use that otherwise
> 3) fall back to origin otherwise?

I'd insert 1.5 to figure out where your detached HEAD came from and
use that as if you are on that branch.  That is the source of the
problem, right?

> Perhaps we could insert a step 0 where we add a config option which will
> have submodule clones use the given remote name + use that as the
> default when in detached head state?

Going forward, it would of course be the most reliable if we wrote a
distinct configuration variable in submodule repository when we
activate it, i.e. when "git submodule update --init" clones, it can
record the nickname that was used, so that none of the 1-3) above
methods have to be used to guess what the name is.

Or, perhaps we can update "git submodule update --init" so that when
it clones, it ignores clone.defaultRemoteName configuration, so that
this codepath always can rely on the name being 'origin'.  If you
are always accessing the submodule through the toplevel superproject,
the name used in the submodule does not make a difference, no?


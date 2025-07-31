Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EC202962
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996630; cv=none; b=nTsE+jGAabnT56W3/fpp+M2OJUQlUTXu4kiSN1qiLhDbSHBRX9wU+kHnP6nuLBM6DoiNm3/JyJ+iEzr1IerzbAHngbMxgLTa1FkKqlQNoCAXxY7Jw+iZBfLZ5JVT6FeQnFxb1zxdR/5vMSdCOiMfLpYlbC+FeoAZV5WCSVYRtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996630; c=relaxed/simple;
	bh=YWgXS/2E+ZZRbKDZBvh+wG+dsWosEQXlb191XbC2/zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VfMuChIrAaIvAHt+PQbnnysR2nSHUNAlqknCREQtxN8WOZYofd/2v9TJVefw6iTMvl5VFqLrJGUlOLvdNUm3PkjjS1nCf4iR5wayC4X94syEHRTYsK9ElD0S3yZIc0+nWqvGYu5D6nzu0vyl3fPfrRVFtlNm16vi7JTvl8cMpAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WW7O4UU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcNd90Pa; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WW7O4UU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcNd90Pa"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C7DEEC14BB;
	Thu, 31 Jul 2025 17:17:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 31 Jul 2025 17:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753996628; x=1754083028; bh=FyNG14gfNp
	haXuELH2lz71xDcUwcdOTVnys+aAC38Ms=; b=WW7O4UU0pM7w72TFBQJ42hKjSe
	Sdo/xL8SabSkJIt7zzkZxbfOjjy+rj6Xt+UEYeECSySldl+xVZsgOgULVH60XH7F
	x9/mEIoZzYvEY2UunjdKBDmbHBc1NOOFEEHNtQ11qCah2exYMPMt9qwVdi2DJ+5y
	ZJzmGpsdm4FJHx4s6q8C0NyRKVRv4dhqbOxqDnVrd6l0L2wGUo/h3aX8dqgU4Amu
	Q3m65kUzygjYUc3gomSAJfE+dnAUi6P/z+x5x+6wosA31EM9Kje0h0DD5OhMy24Q
	Kcw6nvl/IEaKp0NA4p/RgfH4BeIkgqHtaopla32eyet85WI7hEzGnlHopR1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753996628; x=1754083028; bh=FyNG14gfNphaXuELH2lz71xDcUwcdOTVnys
	+aAC38Ms=; b=NcNd90Pa12hILXKP8AsuhcK0KdFmBwHeFesFmptdx9asKlfRlV5
	VRLxVPVZR3tFua+rqLu1xFmfpq8Ez6JqueOrjLDorCYLR4dQbOQCEyvuLWV3VUS1
	R8g82ZwyFidHOHHsWOR9hX0XxwuiOikk06ukoMAheoMGx+GSLwfC0EOFODfFsGH+
	U3c89Gx3BCn1F7s3R6MKe9S2m0u2S45/DrqD5X0iTjwUdEZeoUbugScJOM+rvikJ
	bZA3HnJPtfjMusB3uEbuz8lOm7L+tONwasaGXMITwgVqclPP9Bnzrqyo7IeC46Ae
	OB16RSke5ziTTOCeb/kyc5Kip7VEgHa+ITA==
X-ME-Sender: <xms:U92LaB84Jfych1cC1mmINOFibwo7C3ZJ2RwGkBscbwx6SakW8JmEGQ>
    <xme:U92LaDSbHFbGUcIcMhOqEVV1D5ba42HHEAxyfuohbX3BQHRpSJ2vz98C9_wM3ywfD
    vo0Nr5WCCYfUFt4_g>
X-ME-Received: <xmr:U92LaFc7Phi6H_zJ-1jBtKGqcwRghf8ntDHIMulac8REryTt0Q81npP56LyX6Bn5UzzCtb1pN62nR031s4T1nh__pY3BXzYPBE8CvDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:U92LaHBCuKk_EzcCHhcdS2MA_phfhNnrnSunRR9Ko14rEeK1DWritQ>
    <xmx:U92LaHlJsoCv3rJQWXRauQez_G-bYvSqlb4aEalQ6ZluecOKRYsUGw>
    <xmx:U92LaCdaUhcLMCxQSgXvXtyQlAPDSReg3l5iyp1J7cl9GvIVJjf5og>
    <xmx:U92LaLRnbGeU1--usEPdxfgI-zDG2AD-4HMSI8V4GmOGxNgRLAl0BQ>
    <xmx:VN2LaNaLgCAfvgNSU59Z8wAHAoPPZONNM2mY9q54lKjM-AF65kNTkf5S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 17:17:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/3] config: warn on core.commentString=auto
In-Reply-To: <8b57598042642dd0c56e39be03c1c45a62accfb0.1753975294.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 31 Jul 2025 16:21:54 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
	<8b57598042642dd0c56e39be03c1c45a62accfb0.1753975294.git.phillip.wood@dunelm.org.uk>
Date: Thu, 31 Jul 2025 14:17:05 -0700
Message-ID: <xmqqa54koyb2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> diff --git a/config.c b/config.c
> index 97ffef42700..c36ead76005 100644
> --- a/config.c
> +++ b/config.c
> @@ -8,9 +8,11 @@
>  
>  #include "git-compat-util.h"
>  #include "abspath.h"
> +#include "advice.h"

Hmph.  Do you still need this?

I do not think a separate advice_if variable is warranted in this
case.  They see a warning that says that their "auto" will not do
anything useful in the future.  They will keep seeing it until they
decide what to use, and once they decide and set a value that is
different from "auto" to core.commentchar, they will stop seeing
the warning.

> +static const char* comment_key_name(unsigned id)

The asterisk sticks to the identifier, not type.

> +static void comment_char_callback(const char *key, const char *value,
> +				  const struct config_context *ctx UNUSED,
> +				  void *data)
> +{
> +	struct comment_char_config *config = data;
> +	unsigned key_id;
> +
> +	if (!strcmp(key, "core.commentchar"))
> +		key_id = 0;
> +	else if (!strcmp(key, "core.commentstring"))
> +		key_id = 1;
> +	else
> +		return;

Yuck.  We cannot help the joy of last-one-wins here X-<.

> +
> +	config->last_key_id = key_id;
> +	config->auto_set = value && !strcmp(value, "auto");
> +}

It probably becomes simpler (and easier to debug) if you made the
type of .last_key_id member "const char *" to point at the variable
name.  You are not switching on the .last_key_id member.  The only
use of that member is to be fed to die().  And by doing so, you can
drop comment_key_name().

> +struct repo_config {
> +	struct repository *repo;
> +	struct comment_char_config comment_char_config;
> +};
> +
> +#define REPO_CONFIG_INIT(repo_) {				\
> +		.comment_char_config = COMMENT_CHAR_CFG_INIT,	\
> +		.repo = repo_,					\
> +	};
> +
> +#ifdef WITH_BREAKING_CHANGES
> +static void check_auto_comment_char_config(struct comment_char_config *config)
> +{
> +	if (!config->auto_set)
> +		return;
> +
> +	die_message(_("Support for '%s=auto' has been removed in Git 3.0"),
> +		    comment_key_name(config->last_key_id));
> +	die(NULL);
> +}
> +#else
> +static void check_auto_comment_char_config(struct comment_char_config *config)
> +{
> +	extern bool warn_on_auto_comment_char;
> +	const char *DEPRECATED_CONFIG_ENV =
> +				"GIT_AUTO_COMMENT_CHAR_CONFIG_WARNING_GIVEN";
> +
> +	if (!config->auto_set || !warn_on_auto_comment_char)
> +		return;
> +
> +	/*
> +	 * Use an environment variable to ensure that subprocesses do not repeat
> +	 * the warning.
> +	 */
> +	if (git_env_bool(DEPRECATED_CONFIG_ENV, false))
> +		return;
> +
> +	setenv(DEPRECATED_CONFIG_ENV, "true", true);

I know this means well, but it might give users a better experience
if we went a much simpler route.  In your top-level project with two
submodules, you may have core.commentchar set to auto in the top-level
and only one of the submodules, and then you let "git" go recursive.
Wouldn't it be simpler for the user to diagnose which one(s) among
the three repositories need fixing, if the stderr said something
like:

    doing X
    warning core.commentChar is set to auto
    going into submodule A
      doing X
    going into submodule B
      doing X
      warning core.commentString is set to auto

I dunno.

> +	warning(_("Support for '%s=auto' is deprecated and will be removed in "
> +		  "Git 3.0"), comment_key_name(config->last_key_id));
> +}
> +#endif /* WITH_BREAKING_CHANGES */
> +
> +static void check_deprecated_config(struct repo_config *config)
> +{
> +	if (!config->repo->check_deprecated_config)
> +			return;
> +
> +	check_auto_comment_char_config(&config->comment_char_config);

The handling of .check_deprecated_config flag is a bit tricky, and
it is great that this design allows us to write a similar
check_foo_config() helper and make a call to it here, without 
having to worry about it again.


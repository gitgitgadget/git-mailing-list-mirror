Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283F1B87FA
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494761; cv=none; b=NZlAL8AwVUwplPR7uc4A/9gXasOBSOGVv/T2bgQ5x3iqDvtCPkM9LuSsEo792BPJdqRxdQteY6faxIr0pQj+AkkD35y4eP2pNLX8LLual1F8O1/rbHzxG2adbjCblakALZH2UYTLD2dRFdrfW80zrO6mg4zXKox6uoLp1u6Cv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494761; c=relaxed/simple;
	bh=3Scstprq3fvRLKSfREGwkGXrP8JVBjqnRLj9sQxb3Y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j24Ik0l91w0YuyacxT/KgDx9y8KyV2Dg9K8UwppXMXb4Eqy0hqO9UcTEZedA9w49pNJ0Z3kqANPIlsTqb7x+UkWwbOTmLKdrOdTECDBk9DmMUNG5KEKqyzldpcvdfXmlI4aDEfOI0I1bk+9zjpk5/5E5lOgM7wh4eieruBiVNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/D9Iqw5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5KV7821; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/D9Iqw5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5KV7821"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76A3F25401E5;
	Tue, 21 Jan 2025 16:25:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jan 2025 16:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737494758; x=1737581158; bh=L1NI6LJYWP
	ZTjpl8YVn00XbvxuMVq1W8Il8PwQCY/Yk=; b=O/D9Iqw5Rm6WUqP5T/nd3B8LzG
	hUBNtBdekR+vzUDpZCuRSbTS897qANqZ6X0mYS18CLxcEFJ6D9TcRuLcNw97fVW3
	zyV1b0ypnrqEGqkKxFstnHYG1jynU7fktmogcvTW9xZ2X8p2qe/m9AYw4gjMg2js
	4cTNRDCmz9ZyuXQuzR0MdLsa+37+fm1hFXPVWw9rpqmdMB+B6jvD64jUL9Dl9Hws
	dSUt7ivKBS4684cAQ1vT1LE+BGcB5R5zX6o19FkvlERCCd54pcZR7uyXwZ5PWZ2U
	CS5ye1IXreO0XtGp5/GapHCfZJ3N47efGnHGAvycY0lC/RrnB43/K6FYpk8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737494758; x=1737581158; bh=L1NI6LJYWPZTjpl8YVn00XbvxuMVq1W8Il8
	PwQCY/Yk=; b=I5KV7821rwIMFAXf9FpRv0acVv6uYTcTgwdyrh29mqB70LozN0t
	zxdvs9ukN+I+YynowZmHZkuJAgcgv3EXfSTgCF0S235WLRqAnJ4U0PtrVliBJHoX
	1cEyVbMRQKIVpznmgRRIuG64u8KeFQrEcIOjIGsRZLf/Ww2XgQIZuf3Yq3s3ztJx
	01WD6cmwelMid+jAiOdzM1rCBaxi39CEkKkSHufCqA20tZAWob5mFa4HzrAW4XBO
	UNBKYcA9OQ8Jz+3IXpUCoPFLIF29utCSqU5c2XqAAmz3lGszIgk/pQUCjOcjrzSk
	EDRCMwuk2zPyrsinzi1C5mh+oqkPoKpyR+g==
X-ME-Sender: <xms:5hCQZ3WPwxl9u6x9ufCXbSRlax2sQDej4zS-ECwn-PjcFERp688mtA>
    <xme:5hCQZ_lO-agSWnFuXGw0LwbWqBu349JPEpFHEqnYG1SnOCc-7nVGrtJinjcbq0ZiF
    kjv3x12tg5QgRCQ0g>
X-ME-Received: <xmr:5hCQZzauBqJre7libq0el_4kV1_fUJo4ryvm9EFMa8ZgKJG0SjwZXNwjadkGdov_EHwUN2JCxCgjSgryhJvQVUCMoPpzhSMaJT2e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgsvghrth
    drtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehrrghnuggrlhhlrdgsvg
    gtkhgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:5hCQZyUdCLBlgThybvo2zy2rOGKuKiuwf9HJgjYXKrM8BeNCTfdWXw>
    <xmx:5hCQZxlrA24zfE4TiPW4jSeNzySB3zgk-75LsX2UclXhgXb_Nf18jQ>
    <xmx:5hCQZ_ern9N0ujQDyjHrEhbcVFujeq6EPIkU8bquE2NJ1g7PH4z3WQ>
    <xmx:5hCQZ7GzzbuHOHrbciI8B0y2_AW2ytpR_X08A-1oGCvDSPs1EpV4Hg>
    <xmx:5hCQZ3WJKPUMGdNn1xuwzdhlhkl_PuJ3RyCSvEonTtCPmaex_UNAGULB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 16:25:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Robert
 Coup <robert.coup@koordinates.com>,  Christian Couder
 <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v3 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-5-c7e539b6a84f@pks.im>
	(Patrick Steinhardt's message of "Mon, 20 Jan 2025 08:43:02 +0100")
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
	<20250120-pks-remote-branches-deprecation-v3-5-c7e539b6a84f@pks.im>
Date: Tue, 21 Jan 2025 13:25:56 -0800
Message-ID: <xmqqtt9ryi3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +repositories at all and most users aren't even aware of these mechanisms. They
> +have been deprecated for almost 20 years and 14 years respectively, and we are
> +not aware of any reason why anybody would want to use these mechanisms.

I am aware of one reason why some folks may prefer being able to say

    $ ls .git/branches/*pattern*
    $ echo "$URL#branch" >".git/branches/$shortname"
    $ git fetch $shortname

over the configuration file based mechanism, especially when they
have to deal with dozens of remotes that change the branch name to
be pulled from.  And as I already said the above while reviewing the
previous round of this series, _we_ are now aware of it.

I however am in favor of deprecating and removing the support, but
that is not because I am not aware how useful they could be.  I am
and we are aware, but we haven't heard anybody jumping up and down
to advocate for its undeprecation for a long time, and that is why
I am personally OK with this removal.

>  branches::
> -	A slightly deprecated way to store shorthands to be used
> +	A deprecated way to store shorthands to be used
>  	to specify a URL to 'git fetch', 'git pull' and 'git push'.
>  	A file can be stored as `branches/<name>` and then
>  	'name' can be given to these commands in place of
> @@ -162,7 +162,8 @@ branches::
>  	and not likely to be found in modern repositories. This
>  	directory is ignored if $GIT_COMMON_DIR is set and
>  	"$GIT_COMMON_DIR/branches" will be used instead.
> -
> ++
> +Git will stop reading remotes from this directory in Git 3.0.
>  
>  hooks::
>  	Hooks are customization scripts used by various Git
> @@ -238,6 +239,8 @@ remotes::
>  	and not likely to be found in modern repositories. This
>  	directory is ignored if $GIT_COMMON_DIR is set and
>  	"$GIT_COMMON_DIR/remotes" will be used instead.
> ++
> +Git will stop reading remotes from this directory in Git 3.0.

OK.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 1ad3e70a6b..e565b2b3fe 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -640,10 +640,12 @@ static int migrate_file(struct remote *remote)
>  	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
>  	for (i = 0; i < remote->fetch.nr; i++)
>  		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
> +#ifndef WITH_BREAKING_CHANGES
>  	if (remote->origin == REMOTE_REMOTES)
>  		unlink_or_warn(git_path("remotes/%s", remote->name));
>  	else if (remote->origin == REMOTE_BRANCHES)
>  		unlink_or_warn(git_path("branches/%s", remote->name));
> +#endif /* WITH_BREAKING_CHANGES */
>  	strbuf_release(&buf);

Interesting.  I wonder if our new warning should talk about whatever
end-user facing interface that triggers this code path.  It would
help them wean themselves away from the old interface, no?

> diff --git a/remote.c b/remote.c
> index 10104d11e3..5feb0ae886 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -293,6 +293,7 @@ static void add_instead_of(struct rewrite *rewrite, const char *instead_of)
>  	rewrite->instead_of_nr++;
>  }
>  
> +#ifndef WITH_BREAKING_CHANGES
>  static const char *skip_spaces(const char *s)
>  {
>  	while (isspace(*s))
> @@ -308,6 +309,13 @@ static void read_remotes_file(struct remote_state *remote_state,
>  
>  	if (!f)
>  		return;
> +
> +	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
> +		  "for removal. If you still use the \"remotes/\" directory\n"
> +		  "it is recommended to migrate to config-based remotes. If\n"

Do we have a way to concisely say "how" to do this?  If I am reading
the caller of migrate_file() in builtin/remote.c, it would be

    $ git remote mv foo foo

for any foo in .git/remotes/* or .git/branches/* hierarchy?

Of course they may be an ancient leftover file that the user even no
longer is aware of having, in which case

    $ rm .git/remotes/foo

might be an OK answer, but even then

    $ git remote rm foo

would probably be more appropriate.

> +		  "you cannot, please let us know you still use it by sending\n"

I do not think we care to receive a piece of e-mail that only says
"I still use it".  We may want to learn _why_ they cannot switch
away, though.

The same comment applies to the other side.

Everything else in this patch looked superb.

Thanks.

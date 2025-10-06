Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916B2DA759
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768648; cv=none; b=C6hVsGhULreV1rVQG8re2wuanEicGKzuxKiaFMMx1u3qHc/7j3eZUMB66s2+I9PikeSACrzUPqjI00CfiBqvZ/ZVqVzoHlnqb5ChAg5K7x8A1dU0wkFJbgqY3xHw+KawNrXiToJ5p8izF1NwpnZ+rZWzM6RH0ZdcGB9Vmi1iiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768648; c=relaxed/simple;
	bh=kc09lycPEpkkLZNfPfoPN4iiPxClrvwvgzMVbq4JGFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXl6+YTTbVJwGPZIqKsX5181tgnqd+kfLbFVWgJ40LwORWfJJ3LobwjDTdxOLkAaU2K5DUkWcpEb+sK8d6TM6THEcab8tWdAjZXfnIXDRU7meb2mrAVx8ND+9kKf0+amg0z2YobSufZPEcOLhJksElhwqqjl8AYex7Gp4a5PeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q9uV+VSL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aL0reLDE; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q9uV+VSL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aL0reLDE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B24FB1D00189;
	Mon,  6 Oct 2025 12:37:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 06 Oct 2025 12:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759768642; x=1759855042; bh=q8ywO1juCr
	NouGdjT7RAoHqEbllkrcruuxVB3I1TM9M=; b=Q9uV+VSLg8eFVatNk/qEy4j2x7
	Ad+9uApxNwEdjiPYx/9N7Au7lurhfjemwBThBy/QiCG47cCZrbk+GZRRXK31IRpp
	1NWHNps35WE7h8dUAyMNzsQKL5cx/4bryOQjHsVu1zpuXf9/tpU7orNtHSTW0EHb
	C+lYX/elHyeJCb3BejUXLWy6bncB7KxtlO+W0qyqavz1TK6/zmbT6HGnKUtaQnlz
	FsAwmwXuclOa1AU1iDZn7R/f28vEk6xzYLJqA6b87AuH5cqnEeIn8SEr5T94wfYU
	hj/aZdqIXc/i+yDYS7a2MCy8p3D9zzeJ1H9OwR1WGDx1WLIUIeSy37pUGJLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759768642; x=1759855042; bh=q8ywO1juCrNouGdjT7RAoHqEbllkrcruuxV
	B3I1TM9M=; b=aL0reLDEj0OSu/0hG2OOjUlNePwJ+o7L61GtIj3nuq1kdGnJAam
	dZbfUxBX1kQaL+5LMSAcGDrKM2W/RwXd1MLeK4NlnnFEwOFwvqJxc2ug6uxkSoCY
	i+oHkCTSn7vTVzKPj9HfcE9fnWEa+CsVbqTQQN0ROq+rF3Rrc3mNTPx++FRhC1wb
	ZndzFmvBXllzMhrP1cmdI8yVE3YcNSdO8C2o4C9BS721tUIe3JwHgk/hXE1OLno0
	auyP/M+5D+7an6ss9u10T1NxH7PRBJGhTfVmWWdDEYFVA0YWKEsqX4i/MDBL+0EN
	nzAEnS69vCaov6bWFIi8FJhpnev0H6DEPxA==
X-ME-Sender: <xms:QvDjaIqKrJUamWU8xhTK7du0WyEYbXH873CLKOxMRdi7FmgT-08PRw>
    <xme:QvDjaKdjWN8G3xmejmsvoDfTncWrgovHMUqXbcctq94ZlJu20GogeVtfmI2V7YiY5
    JnkTe82MVobjGnMERX_O56-GX9E0YUp9fpHIryNEvHFgZYdbTeejg>
X-ME-Received: <xmr:QvDjaImxb_oOi_FNyr5z1S3-XFQjaIoS0bkjDOzS-cH1hceKFvUl8OUbawL90SxdF7zaH_ix2_DBs4_ywXGxfQ_WCRlEdXwP_J8n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:QvDjaJbqCabcH6iS6lsr7d8aZC4ca131ZRpxt2SyQH5Q_B4yL5SZ9g>
    <xmx:QvDjaF48zjcSP9tIB-TTSW6UL_-AOW-_ECnuOV5jcCNNLsppz-LMNQ>
    <xmx:QvDjaLD5smJq_BvjA8hkGTDsQYCYu3wpmk7G521RBxPJxMxn00IZ5Q>
    <xmx:QvDjaL99YWrEppTp0owcx9aKV1krS1Hrlc6NVikK_4VK5On75aOmmw>
    <xmx:QvDjaFmpRVJoZ_0xqWwKo9RXsl5UqfZSQlzbrVnlTVB-RwSNaHwjCdRo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 12:37:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 1/5] submodule--helper: use submodule_name_to_gitdir
 in add_submodule
In-Reply-To: <20251006112518.3764240-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:14 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-2-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 09:37:20 -0700
Message-ID: <xmqqh5wcq94v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> While testing submodule gitdir path encoding, I noticed submodule--helper
> is still using a hardcoded name-based path leading to test failures, so
> convert it to the common helper function introduced by commit ce125d431a
> (submodule: extract path to submodule gitdir func, 2021-09-15)  and used
> in other locations across the source tree.

OK.  To me during my first reading, the above read as if you found
an open coded logic here in add_submodule(), made it into a new
common helper function, and made this part as well as other locations
call that new common helper function.  Of course that is not the
case.

Perhaps replacing everything after ", so convert it" with something
simpler like

    ... to test failures.  Call submodule_name_to_gitdir() helper
    instead, which was invented exactly for this purpose and
    everybody else uses.
    
might have helped me to avoid such a confusion.  I dunno.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index fcd73abe53..2873b2780e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -3187,13 +3187,13 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
>  
>  static int add_submodule(const struct add_data *add_data)
>  {
> -	char *submod_gitdir_path;
>  	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
>  	struct string_list reference = STRING_LIST_INIT_NODUP;
>  	int ret = -1;
>  
>  	/* perhaps the path already exists and is already a git repo, else clone it */
>  	if (is_directory(add_data->sm_path)) {
> +		char *submod_gitdir_path;

This hunk is not related to the theme of the change and not
explained?  I think the variable becomes used only within this block
after the patch that loses the use of it on the "else" side, so in
that sense it is not strictly unrelated, but is a fallout of this
change.  If we were to mention the change in the log message,
something like "Also narrow the scope of a variable that is no
longer used in the updated code" would suffice.

> @@ -3207,10 +3207,11 @@ static int add_submodule(const struct add_data *add_data)
>  		free(submod_gitdir_path);
>  	} else {
>  		struct child_process cp = CHILD_PROCESS_INIT;
> +		struct strbuf submod_gitdir = STRBUF_INIT;
>  
> -		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
> +		submodule_name_to_gitdir(&submod_gitdir, the_repository, add_data->sm_name);
>  
> -		if (is_directory(submod_gitdir_path)) {
> +		if (is_directory(submod_gitdir.buf)) {
>  			if (!add_data->force) {
>  				struct strbuf msg = STRBUF_INIT;
>  				char *die_msg;

So this is the crux of the change, which makes sense.  Where do we
release the resource aquired here?  Let's see...

> @@ -3219,8 +3220,8 @@ static int add_submodule(const struct add_data *add_data)
>  						    "locally with remote(s):\n"),
>  					    add_data->sm_name);
>  
> -				append_fetch_remotes(&msg, submod_gitdir_path);
> -				free(submod_gitdir_path);
> +				append_fetch_remotes(&msg, submod_gitdir.buf);
> +				strbuf_release(&submod_gitdir);

... OK, where the variable was freed in the original, so if this is
not the right place to release the resources, then the original was
already buggy.

>  
>  				strbuf_addf(&msg, _("If you want to reuse this local git "
>  						    "directory instead of cloning again from\n"
> @@ -3238,7 +3239,7 @@ static int add_submodule(const struct add_data *add_data)
>  					 "submodule '%s'\n"), add_data->sm_name);
>  			}
>  		}
> -		free(submod_gitdir_path);
> +		strbuf_release(&submod_gitdir);

Ditto.

And the only nonlocal exit other than die() inside this "else"
block appears _after_ this part, so we are OK.

Looks good to me.  Thanks.

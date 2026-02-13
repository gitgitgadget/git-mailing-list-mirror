Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0E2C029D
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771018539; cv=none; b=sd9nTZGMuRypyDDI3tZT7P8+zi6eZGTdPt9uBJeYNGp+1wlYldc0R8GgzFHjKcRx2WgPKHyoHye2ofpxvHUph4y9APWQYg7AnPBiy99lepGJhifF+gTv7kbERP3FU63tiZP5ijqZRy7dKIFxLaJI+v5mOLWFuMNMZ/dd6vsnL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771018539; c=relaxed/simple;
	bh=7n8r2NYMmi7pFWRRy4MTCDTNTYXlJ2vkG5GAPVL3ubs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PobUb4XqfH+kzeRa32m4v71asaYpM26PdapM6UTHoUCl2B9NIe9Z+rYS5su0aamGWKfcWlquaLGgcssZsfovbIaZvWvN0A8V4ivgzGFYWh022qimd07AuwEzowsuusQV+DYgnGrMmk7cUNA/UWdPeQZ5pRp88RIOh8s1mYGXOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k8nwByzt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVSw5tdQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k8nwByzt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVSw5tdQ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F04DE7A00CD;
	Fri, 13 Feb 2026 16:35:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Feb 2026 16:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771018534; x=1771104934; bh=Katt88n6FH
	lBpYzxW4hel0pE8qb76cihiRFmBb+Kvkk=; b=k8nwByztp8aJ6+jGoDCJ/j1bg7
	r5kN9X/NTbq83DGWV4WG+kQXy1GZr/R2YwVx5GIIPOFKE/TU3lemcQu6eUObgjWr
	s4uyh5AfHyTwi2vx80d5x3WL8r13shAlcPvl49PnRRRYTHC38UK9E7IGQw0MoiO1
	SW6iAs/b+UQLK28LpnW1HqtfzSNEhbBNCYaoEsfwFcCn3su+MDa6RBDm4aeUC5MV
	wEVoJGBgX7eKWblCw+2aWh4n9tAk5bJMkU2SFBDAt+wcVbXedWT16/tXZ5j8R5sv
	38mTBUUSMAPIc+HRGzrQ4VeCPcXBLVIbxUxZ0NPoZS/u/85Y8eALPf9qHvYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771018534; x=1771104934; bh=Katt88n6FHlBpYzxW4hel0pE8qb76cihiRF
	mBb+Kvkk=; b=AVSw5tdQ7NtpJGF9/1jYIJC2YTnBB6Fe/k2eSIJ5sRb8eHcrfbN
	SB0xTyCHGQsmJff9kctnzo6h90HLFn9GHG5V7kNHyrd3vbG/pfBF4EvkKb9FwDko
	819y4HRHDoQGnPxULOeeKEk8r9OkeEzFsY4fg9hLUECZ7f0QKX31hNE6lzNQcrG1
	aeSgzcVf6++vgNaUDHm7nwJO3As5XFOXsAIy7tN2Wej9aV/0i8daPkEIGQ5OdBn3
	aEEATF+p9XQmeL3nP/Q7Bv9PMY32Kbd47/QDqCBcMYvACo7sQmJeJvxfKd5HikFc
	unsUl/q+dHnlSh45JMtfPMMBIj95qmB9u5Q==
X-ME-Sender: <xms:JpmPaa90wtbhrku_u-RjKp-1sGflrvvleD9SIlSJPypXMO50sA1zHg>
    <xme:JpmPaRupI9wuEXtO94HkxAqogii13Ef79OuyFksjiaOda2BVnZWwiwNgYNgSRluKz
    XZI0Tza_-GyabrtbuuCHLVibwb7l_OVO9sIKy3_vI0MZi9B-GVChO0>
X-ME-Received: <xmr:JpmPaVBQ64EAhQnioxSJV4pj6y7mq7yz3RvKToY8t9W2GGAA5W0lBcshd9fqSytgp-CRZ0Q7BlfrunVcY81jd-01ZY1Tf9TQfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:JpmPaRUgOf6aerAnUp3MafwXUUgAgB998eMANDBsUqABxAdvWOE0Sw>
    <xmx:JpmPabC8wgfTv0nmxgg0iE4tW2VygnVbwwyeYJrYkVr8QkWNxcm17Q>
    <xmx:JpmPac_ERiSRi1esLD0VYKGAs9efYelIst0x-alL-ZxnbkJSBXKKaQ>
    <xmx:JpmPaaHZsn8w3MD-mycSarunDx1PWhokSMXmzTuA6nINYrOzTacKZw>
    <xmx:JpmPaYj6ZxMyykEL9cOvJPPCpXacefZVowwtg5_FMIUEWAvaDWfQDbx1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 16:35:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [RFC][PATCH 1/2] worktree: represent the primary worktree with
 '/' instead of NULL
In-Reply-To: <20260213120529.15475-2-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Fri, 13 Feb 2026 17:29:53 +0530")
References: <20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260213120529.15475-2-shreyanshpaliwalcmsmn@gmail.com>
Date: Fri, 13 Feb 2026 13:35:32 -0800
Message-ID: <xmqq7bsgl42j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> diff --git a/worktree.c b/worktree.c
> index 9308389cb6..b29934407f 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -101,6 +101,7 @@ static struct worktree *get_main_worktree(int skip_reading_head)
>  
>  	CALLOC_ARRAY(worktree, 1);
>  	worktree->repo = the_repository;
> +	worktree->id = xstrdup("/");
>  	worktree->path = strbuf_detach(&worktree_path, NULL);
>  	worktree->is_current = is_current_worktree(worktree);
>  	worktree->is_bare = (is_bare_repository_cfg == 1) ||

Presumably we left .id = NULL from CALLOC_ARRAY(), so this looks
sensible.  When releasing resources from an instance of worktree,
we'd blindly free(worktree->id) and in the old world, free(NULL)
turned into no-op, and this xstrdup()'d copy will be freed in the
new world, so there is nothing funny here, I hope?  This one, and
the change to is_main_worktree() go together.

> @@ -127,6 +128,8 @@ struct worktree *get_linked_worktree(const char *id,
>  
>  	if (!id)
>  		die("Missing linked worktree name");
> +	if (!strcmp(id, "/"))
> +		die("'/' is reserved for primary worktree");

Makes me wonder if this is a BUG not die; where does id come from?

	... goes and looks ...

The only caller is worktree.c:get_worktrees_internal() and it is
feeding d->d_name that came from readdir_skip_dot_and_dotdot(), so
it cannot be "/".

By the way, I suspect that get_linked_worktree() should become
file-scope static, as there is no other caller.

> @@ -206,9 +209,7 @@ struct worktree **get_worktrees_without_reading_head(void)
>  
>  char *get_worktree_git_dir(const struct worktree *wt)
>  {
> -	if (!wt)
> -		return xstrdup(repo_get_git_dir(the_repository));
> -	else if (!wt->id)
> +	if (is_main_worktree(wt))
>  		return xstrdup(repo_get_common_dir(the_repository));
>  	else
>  		return repo_common_path(the_repository, "worktrees/%s", wt->id);

Good spotting.  This series needs to spot any and all places that
use these other conventions (i.e. wt->id == NULL) to identify the
primary worktree and rewrite them to call is_main_worktree(), which
may be a chore, but once it is done, it would become a lot easier to
follow the resulting code.

> @@ -277,7 +278,7 @@ struct worktree *find_worktree_by_path(struct worktree **list, const char *p)
>  
>  int is_main_worktree(const struct worktree *wt)
>  {
> -	return !wt->id;
> +	return !strcmp(wt->id, "/");
>  }

OK.

> @@ -566,7 +567,7 @@ void strbuf_worktree_ref(const struct worktree *wt,
>  {
>  	if (parse_worktree_ref(refname, NULL, NULL, NULL) ==
>  		    REF_WORKTREE_CURRENT &&
> -	    wt && !wt->is_current) {
> +	    !wt->is_current) {

OK.

> @@ -629,6 +630,9 @@ static void repair_gitfile(struct worktree *wt,
>  	char *path = NULL;
>  	int err;
>  
> +	if (is_main_worktree(wt))
> +		goto done;

This is a bit new.

The original did not say 

	if (!wt || !wt->id || !strcmp(wt->id, "/"))
		goto done;

The only caller is iterating over the resulting list of worktrees
returned from get_worktrees_internal(1) *BUT* it already skips the
primary worktree (the function MUST return the primary one as the
first one, and the callers MUST be aware of the convention).

So I am not sure if the new check is even needed.  Or rather, this ...

	if (!wt || !wt->id || !strcmp(wt->id, "/"))
		BUG("why are you feeding me the primary worktree???");
	
... might be more appropriate, perhaps?  I dunno.


>  	/* missing worktree can't be repaired */
>  	if (!file_exists(wt->path))
>  		goto done;

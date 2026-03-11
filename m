Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3978732D7F1
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257181; cv=none; b=i1ojeON841xurHYo8Ct6JM5juCdq2ecmztuVSBKWQ+1qw42IgxRgKv7EjM/JnV3Ce1upuJz43oPtVvaf6TDUo0stXfsHtpig0LGGzFu6IsqDGv5qtrgDLUQoQfl7ynhH36olnTUIG7IBHGTnkl6/vFpT8BZEIjyvSPapgW5+4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257181; c=relaxed/simple;
	bh=9Zi+PJomfNDPWvWUfRS3hzZmsuFv7qzMkAcK4EvBn3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtzbXAxX5MH1YVn/4aFRjW72Py20qEI8D1zCkkM3FhK55p4hslxs/Cw6VRr/3U0+DeaE2QWiRYAi4e8wxJz89Wrbm8rNX7Qb9k9px12A7A1IRixCgmFoEl3xor0SuUauLVpHOdfBHFha/Dk8BNaiDUhTfr4jJFsop0DpPjekdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iiGNrqAA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8AMPaBK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiGNrqAA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8AMPaBK"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E8E6D1D000A4;
	Wed, 11 Mar 2026 15:26:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 11 Mar 2026 15:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773257178;
	 x=1773343578; bh=7U/BPkoaTQdvaTrxdPzUStaZbQtAhqaS/3ZQzHBQyIc=; b=
	iiGNrqAAgUbs6auZRRKrbl/ZopKC+7orXAEZ9HPGmFZdJdFUKoKUVIWALA1w/7za
	HLJ4TktNJujf4fZIrlkzq79OuU7CJYcgji0z69PL4WuddzgU92N5gF5qoNSQp4B0
	igba6L0jHZ4w375ON58pAq08Xe2x68pHAXEOmskVuDa9nb4WuEykY4WhshYe3Ims
	7zDzRw+J1fTnqeDmKBAjI2C4va4gmguiJcnAfI9Bt+5sk/BTB1pY9hW0xK/wCqrW
	8P1pYviCpamRmFgDqolxo3zXc8lZsFXK8Jn1b8M/Ftaga5lUHGgAjgB1rJNG/Xzo
	vgQoTDCO7wLnO4woAMQpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773257178; x=
	1773343578; bh=7U/BPkoaTQdvaTrxdPzUStaZbQtAhqaS/3ZQzHBQyIc=; b=B
	8AMPaBKtIDKu6jgs7NVkDSsysaipwDwwKOQYnncOslArqEbutbXh9R65eb5hb8UK
	5j3zTS5k7LPhbJ+NuS5zmxjlJuWKKSSms3zoin1NPZvmENuUaYEBiDHAgel8Etjv
	PwaXQR8CPTmjJtBqBZg+BFdCJCGylEQSCH6BbW9VTdNw7A01cICE2jrT4Sat5zmV
	7nepnhvD59mIJokHYeC8RJdjoBIvs+z+k+idNks/I5bKXvz7jdv0UuGpnrnnFikC
	LLRSJgAzPzUFRhNc9C6sSLyTqLC/5ruUR8D3UqAx8kgnC4HO2X8pwL421ZfblJlI
	BCK6rLPV6DzwhaMyZ1f4A==
X-ME-Sender: <xms:2sGxaZirIt8wSKZqv8nohTwP1WTm-vksL7cTV9sZMUs4txZuth6GLw>
    <xme:2sGxaamG2Z-FdR1fsZdsku68MKj7wWn4HLHZHE1r8swbAyKKZ5w_nhDmpWmNiEPTf
    LGBVOT94H9NTxqzff7s3nrgslsoSeUkfTVr0_PZ5M6f5kU5Vp_4eA>
X-ME-Received: <xmr:2sGxadhkDKQTGAHBYr39OKxDLnX6GLZr0HvGhz9UPuyzFDFj2njzmukh4hb-25KqB-yKLBjy6N9VT-PYKGOTafPBT5139D2dwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghkkhgrrhgrtggrhiesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkh
    grrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:2sGxaVEBdnPFHatfXttHf3mhWnJyxcXq_Z9hQYIJa_uSDUwvrwsvAw>
    <xmx:2sGxaXstN_94SchEjF3x72XIrr3LZnWWC2d56agyavR-8N33gkjLIA>
    <xmx:2sGxaedWwa3xOr3jU3KObSA-U6PyycLwX0G4nMlOp816eEsM6ZuQ1w>
    <xmx:2sGxaVnzGbLNhHwZ0d8fPn7qV-NMRC6LQuJhF56k7oFy8Rv0ZUJwfg>
    <xmx:2sGxaSW6Rikar7NInbDdSB4jqB3HfKeMOGPsVp0evWhjbEyx3xdX2x2q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 15:26:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  l.s.r@web.de,  ps@pks.im
Subject: Re: [PATCH 2/4] run-command: use repo_start_command() in strict
 callers
In-Reply-To: <20260311151923.4178655-3-bkkaracay@gmail.com> ("Burak Kaan
	=?utf-8?Q?Kara=C3=A7ay=22's?= message of "Wed, 11 Mar 2026 18:19:21 +0300")
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
	<20260311151923.4178655-3-bkkaracay@gmail.com>
Date: Wed, 11 Mar 2026 12:26:16 -0700
Message-ID: <xmqqsea6np5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Burak Kaan Karaçay <bkkaracay@gmail.com> writes:

> Some callers have been freed from global state and they do not define
> the 'USE_THE_REPOSITORY_VARIABLE' macro.
>
> To complete the mitigation of 'start_command()', update these callers to
> use repo_start_command() and pass their local 'struct repository' as an
> argument, completely eliminating their hidden reliance on the global
> state.
>
> Signed-off-by: Burak Kaan Karaçay <bkkaracay@gmail.com>
> ---
>  builtin/difftool.c | 4 ++--
>  odb.c              | 2 +-
>  pager.c            | 2 +-
>  repack-promisor.c  | 2 +-
>  send-pack.c        | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index e4bc1f8316..15ac552edf 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -257,7 +257,7 @@ static void changed_files(struct repository *repo,
>  	diff_files.out = -1;
>  	diff_files.dir = workdir;
>  	strvec_pushf(&diff_files.env, "GIT_INDEX_FILE=%s", index_path);
> -	if (start_command(&diff_files))
> +	if (repo_start_command(repo, &diff_files))
>  		die("could not obtain raw diff");
>  	fp = xfdopen(diff_files.out, "r");
>  	while (!strbuf_getline_nul(&buf, fp)) {
> @@ -437,7 +437,7 @@ static int run_dir_diff(struct repository *repo,
>  	child->clean_on_exit = 1;
>  	child->dir = prefix;
>  	child->out = -1;
> -	if (start_command(child))
> +	if (repo_start_command(repo, child))
>  		die("could not obtain raw diff");
>  	fp = xfdopen(child->out, "r");

Up to [1/4], we called start_command(), running the new process in
the context of the_repository, and if these "repo" were referring to
a repository different from the_repository, we risk changing the
behaviour without meaning to do so.

The difftool command, however, would not be dealing with multiple
repositories so it is very likely that the "repo" passed to these
two functions are the_repository _anyway_, so these changes are
correct, safe, and a move in the right direction.

> diff --git a/odb.c b/odb.c
> index 776de5356c..8ec279f84e 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -535,7 +535,7 @@ static void read_alternate_refs(struct repository *repo,
>  
>  	fill_alternate_refs_command(repo, &cmd, path);
>  
> -	if (start_command(&cmd))
> +	if (repo_start_command(repo, &cmd))
>  		return;
>  
>  	fh = xfdopen(cmd.out, "r");

The only semantic change brought in by [1/4] to start_command() is
that the object store of the named repository is closed, instead of
the object store of the_repository.  The read_alternate_refs()
function calls fill_alternate_refs_command() to run for-each-ref in
the named "repo" to find out the refs _they_ have.

But then, do we really want to close the object database we have
been using in the context of that "repo", that is different from
"the_repository" we have been using so far?

Of course, there is no guarantee that the_repository is always the
"current" repository object we are using and trying to read the refs
from this alternate repository in the codebase in an imaginary
future where we can start from one repository, add refs from an
alternate repository, and while doing so, we may add refs from an
alternate of the alternate repository, so always starting from
the_repository may not be correct, either.  But even before going
there, closing object store of "repo" feels more wrong than from
"the_repository".  Perhaps repo_start_command() needs to be aware of
two repositories, one that we have been using and neeed to close the
object store if instructed, and the other one that we want to launch
the new process in its context?  Keeping "the current repository" as
a global variable will drag us back to the similar issues these
efforts to wean us from "the_repository" global are trying to
address, so if our new repo_start_command() does need to be aware of
the two repositories, perhaps it needs to take two repository
parameters (i.e., where we are coming from, and where we are going
to)?  I dunno.

> diff --git a/pager.c b/pager.c
> index 5531fff50e..9a23ed958d 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -169,7 +169,7 @@ void setup_pager(struct repository *r)
>  	prepare_pager_args(&pager_process, pager);
>  	pager_process.in = -1;
>  	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
> -	if (start_command(&pager_process))
> +	if (repo_start_command(r, &pager_process))
>  		die("unable to execute pager '%s'", pager);
>  
>  	/* original process continues, but writes to the pipe */

OK.

> diff --git a/repack-promisor.c b/repack-promisor.c
> index 90318ce150..dba161a11a 100644
> --- a/repack-promisor.c
> +++ b/repack-promisor.c
> @@ -125,7 +125,7 @@ void pack_geometry_repack_promisors(struct repository *repo,
>  	prepare_pack_objects(&cmd, args, packtmp);
>  	strvec_push(&cmd.args, "--stdin-packs");
>  	cmd.in = -1;
> -	if (start_command(&cmd))
> +	if (repo_start_command(repo, &cmd))
>  		die(_("could not start pack-objects to repack promisor packs"));
>  
>  	in = xfdopen(cmd.in, "w");

OK.

> diff --git a/send-pack.c b/send-pack.c
> index 67d6987b1c..c339c3d1ca 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -92,7 +92,7 @@ static int pack_objects(struct repository *r,
>  	po.out = args->stateless_rpc ? -1 : fd;
>  	po.git_cmd = 1;
>  	po.clean_on_exit = 1;
> -	if (start_command(&po))
> +	if (repo_start_command(r, &po))
>  		die_errno("git pack-objects failed");

OK.

> @@ -459,7 +459,7 @@ static void get_commons_through_negotiation(struct repository *r,
>  		return;
>  	}
>  
> -	if (start_command(&child))
> +	if (repo_start_command(r, &child))
>  		die(_("send-pack: unable to fork off fetch subprocess"));
>  
>  	do {

OK.

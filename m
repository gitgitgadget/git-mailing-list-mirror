Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28059E327
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892500; cv=none; b=duU0J72ZOYNR9o3vpa0K8L5mBTWPiSh16rtLE0VV/ffNOiPc0QztKTFxdw6EkcApS+4y9GabKk7XEDWDtJ/AN41ZskAgd0n3h8KU+VI//l8V0hnpq9zYppCWOAEZfypZBdItz96TnNNls2JeWX8bgKhVLjy4X8d/gWw9fQLqLFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892500; c=relaxed/simple;
	bh=KeHk8wYlSqyUMeS8b/BnDNVplFm77yz3hO8rmb/bEAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kt4t0M6+K0tWltSbMQnkwJnif4CwExjf+QossTUDp9Np8nEuun0Fys/B0798Hq3w3mT9ZTbhStFr+yNirp0rj4Cu67guqB/cPeIbpXojbLjxVfhdNeDyS9wSNjtdnX5PDUaXYD5GzkyUZGQiPgBcVxaAM9bbiIHK4yhBgJ9DPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8tD3iAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=peiSuQ69; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8tD3iAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="peiSuQ69"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1CC7140004D;
	Tue,  8 Sep 2026 14:34:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 08 Sep 2026 14:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788892493; x=1788978893; bh=l6ja5/HyE2
	TpsqWdRUUtqAIdKfGCcIgcrHbVCvNt9JY=; b=f8tD3iAzWjcyUcGfALbe3XVnQv
	1SJSmieeR0xvSAhga+ZjEkOzS2g6JDQaRyi420INBm+v3zxnFY22dgAlJW2kMk47
	V8UXKutoY4JAs/BMMwWDu1Y4vtlI9cf2uCMBZ2fivJioPqWVPteblXkZmHSQXcUa
	hssF39fQmGflPKeqcIm7G9Wc3Sfe67EYjyJxDCNkxIsPMGx42gAjHn9i+Yr6s8gO
	9FZEufJXyCaZB3v9dm6UCRBg6w45PplUsvv5ifKmjTlkgHvgjSDxo4VAEdh8y7BX
	AlhPuhf+sZws1QwKroSdczyuX/RiUt+6N6Sc5OOM/evI8cdYD+HC+9HdWtYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788892493; x=1788978893; bh=l6ja5/HyE2TpsqWdRUUtqAIdKfGCcIgcrHb
	VCvNt9JY=; b=peiSuQ69hrzLqjKS6uIvaD79VHA1mq+MaNJjbFDkbNx4nK354+4
	/jS4+XGCavFum3HK9PdcCNyVp/YXK4jzoBJFss2IkBjS2xtMt2021x/2lC0FPRnb
	5knpOR+F3PO0BD8NGY0BU5a4f9SPru5kaMcI+W29qrBPFIM/rU5FUfJziJkL4vPn
	dGQBOumYHVppWicP3eVwBUiKF9/QfHGC0IXyMvv0lhswZtMlgX3ND7Ng0KGY9xF8
	bPijG6M4+qKZ+ZuqAZx35aFUWnJnxPQ5Bj7DgK1tvlZce33KxE7D/sImvXwFfVby
	zb4hez/rwfRYKzHwOGwbvqaWJJYBtLfQvXg==
X-ME-Sender: <xms:TVWgahm6MFQ97ebbDmsKw1mL4PBpA8LDcAUksi_SteQPo3FNg0SGyQ>
    <xme:TVWgar6tZmuUE0NOmseb-OoHPEy7S6YV0RWNgl_4XVshRSkZgn4iTRUa0-OtLIqpY
    u0i1XACcdQn3sM3WCOGv3W5g07u5XfOcaTxyCBu7y192fsPslUlHqg>
X-ME-Received: <xmr:TVWgat1rhX0MeCl9jba_kzDpAF3kiWBUC5QRQT4xYQ0YqbIsPqHujmFFushHWHlFJM0JkCz42BMSbbQcJdZhwG4CpQl1mODRQLLA>
X-ME-Proxy-Cause: dmFkZTFZ7kBp1oIYG8/o3gshgTBJgMTusxXHsK+ItvWCcBH0CgF9i0VTGwxyGPWROisbLP
    E2KL36DBLEBwOKkUX4ltwDKPDS/ywis84ixW3yT+zRxCRderpUQxWByVq/U5zobmxQJrgW
    QFu7UVgi0+8rpXb/1vwXTK3zW5LrT7KSkipZ1GooIn9zFYwcqmzRD1Gi3Z2Ue+Crwiy5e1
    zK116GU39wHjhf21E3OfHK6tlixjF3yjuLYOPiCz4qEXBP4NdRqnbkAbrza2F9Ys9my6it
    7sLdhz5mi/UjuWyC4UJJ5PqI/WpoPHuMeK5bZwXB37YDK338CYch+ocUpVbMiep494A5bD
    +efWNZRHRxAShFEF0Os0UDbYlqweDAl9aJBZjTWXkf+TE/2FB5sWAptVQCREt63PXbwUzA
    prK2if9TOfMstjLlEzSV6bsClduaPitKkPlMazJkxBYVXkzWgUNY3Cygvsw6aBexRfLM6O
    LOAMTJPI0JMhYFGcavmFZB+R/c/7c1PmUA0sbKS4hgHRf5B/KwjH9/XzXTxlfXhCApFlbH
    Ck3Yj2UuiQGUvxcYP3Jo/WlIFxC6bzFtq8t+oKxnaYKvMt5Le6KVK723Qiv6bfvhk9CZhI
    x3RQLWAlpiFOljNlNkWzhMdGMEWz2bazdXqb3SyujQRXcgHl6P4bnD7tXxRg
X-ME-Proxy: <xmx:TVWgauGYXNvaCy0xjxfgf_kOSK3y55KepMst1mbLDDN6J_uYYPVQJQ>
    <xmx:TVWgakjMcc2vcOgrq8AP2rLEJkaJsEREc_f3C7udPl9XJc1PQ-ohAg>
    <xmx:TVWgapCoFFo04a5jEbIhoUOug_CfFj4Xj_rl06Cy0mn3yLCBUUo67A>
    <xmx:TVWgauR1wLH0xiPeG0WHKehzqe_MRtqBOt0AhM_AvM4ZeULCMzW9KA>
    <xmx:TVWgamoTUTmNS7e3MG3n7un7SfzHQ2T-3aZBtbLLqPyAJaYmN723MJsE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 14:34:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0
 on trusted repo
In-Reply-To: <20260908164129.560396-6-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 8 Sep 2026 18:41:29 +0200")
References: <20260813154748.2378747-1-christian.couder@gmail.com>
	<20260908164129.560396-1-christian.couder@gmail.com>
	<20260908164129.560396-6-christian.couder@gmail.com>
Date: Tue, 08 Sep 2026 11:34:51 -0700
Message-ID: <xmqqmrtrwq0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit added a new "uploadpack.lazyFetchTrusted" protected
> config variable that can contain an allowlist of repos, as well as
> functions to check if the current repo is in that list. But when the
> current repo is in that list, we currently do nothing.
>
> Let's instead set `GIT_NO_LAZY_FETCH` to `0`, which allows
> `upload-pack` and its `pack-objects` child process to lazily fetch the
> objects they need to serve a client, for example when the filter used
> by the client and the one used by the server don't match.

While I agree that it is a good idea to make it more lenient to work
with remotes that are explicitly marked as trusted, it somehow feels
a bit unnatural for a configuration variable, or a conclusion
derived from the setting of a configuration variable, overriding an
environment variable.  Who is setting this environment variable in
the first place?

If NO_LAZY_FETCH is what server operators set and export, I strongly
suspect that not honoring it merely because the new variable could
be used to give them a finer-grained control would be very
surprising experience for them.

If the answer is "this never comes from the end-user or the server
operator.  We used to automatically set NO_LAZY_FETCH from the
process that spawns uploadpack because we trusted nobody", then I'd
imagine that we would prefer to see that code that automatically
sets NO_LAZY_FETCH to inspect the configuration variable and to
decide not to do so.

And I think that is what the code is doing (in other words, from a
cursory read, I think the new code is doing the right thing and it
is just the way how the above is explained that I found it iffy).
We used to say "when serving a client, we do not lazy fetch what we
are missing from our promisor remotes by setting NO_LAZY_FETCH" and
it was unconditional.

I think what we want to happen is:

 * If the server operator has NO_LAZY_FETCH set, we honor it and do
   not do anything.

 * If the server operator does not have NO_LAZY_FETCH set, then we
   see if the configuration variable is there, and if there is, we
   let it take care of which promisor remote to allow by not futzing
   with NO_LAZY_FETCH ourselves.

 * Otherwise, we set and export NO_LAZY_FETCH just we used to.

and what you have in the patch is close enough to that (you left the
historical "disable lazy fetch upfront" so worst case you export the
thing twice which is not necessary).

> This allows server operators to properly control lazy fetching. It is
> their responsibility, not the client's, to decide if the served repo is
> trusted,

If "the served repo" refers to where the client is fetching from,
trusting that repository or not is up to the client; if they do not
trust it, they should not be coming to you.

I may be misunderstanding what you are trying to say here, but what
is up to the server operator to decide is if the promisor remotes,
which the repo that is serving the client uses, is trustworthy,
right?

> As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
> environment, this works for `pack-objects`, which performs the lazy
> fetch when serving a client, without any further plumbing.
>
> Now that "uploadpack.lazyFetchTrusted" is actually doing something,
> let's document it and reference it from GIT_NO_LAZY_FETCH's docs.

> diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
> index 32831fb879..8b531ca724 100644
> --- a/builtin/upload-pack.c
> +++ b/builtin/upload-pack.c
> @@ -42,10 +42,13 @@ int cmd_upload_pack(int argc,
>  		OPT_END()
>  	};
>  	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
> +	bool no_lazy_fetch_set;
>  
>  	packet_trace_identity("upload-pack");
>  	disable_replace_refs();
>  	save_commit_buffer = 0;
> +
> +	no_lazy_fetch_set = !!getenv(NO_LAZY_FETCH_ENVIRONMENT);
>  	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);

I am not seeing what is in the postcontext of this hunk and in the
precontext of the next hunk, but I wonder if we can just remove this
xsetenv (without "no_lazy_fetch_set" variable at all) here ...

>  	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
> @@ -62,6 +65,14 @@ int cmd_upload_pack(int argc,
>  	if (!enter_repo(the_repository, dir, enter_repo_flags))
>  		die("'%s' does not appear to be a git repository", dir);
>  
> +	/*
> +	 * Relax the GIT_NO_LAZY_FETCH=1 default if the served repo is in
> +	 * the "uploadpack.lazyFetchTrusted" protected allowlist and
> +	 * GIT_NO_LAZY_FETCH was not already set explicitly.
> +	 */
> +	if (!no_lazy_fetch_set && upload_pack_lazy_fetch_trusted(the_repository))
> +		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "0", 1);

... and instead check the existing environment here, and do the
choice from three possibilities I listed above here.

Other than that, this is a great endgame of the series.

Thanks.

Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F82190663
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390241; cv=none; b=E8+RrzqGDuXcL0d3UImK4UbshXTUnrdsMsARGV3s7lFvVzMdZ9d6TQ+8oiwUBoe+TVp/nb8GT1KVIneoM5C+u6PQIZeXGqsxIdpkF27US77Wjq6dPb4TOHzSHRIs2dAw45KzaQ1I8QmEBJUBSs77fIoL3CgLITf6TFZIXSwvtsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390241; c=relaxed/simple;
	bh=TPYVcg/Qbpp//DBoeByB+GJmXbDiA9nQGfvG2ZlEZZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQk8z7sdX/dJYsokXzFJy+XzqKT1PWZjDJbcgLeMOlmlipWLBRpeV3ekueZu4GeX6YNcXp2JzBeIowqnAYsGZd9S19gq9KykKs78wW/qYTRSFMTxkwA0eLEk+FAxBLbIX7am91ALvvfD1tbfkjhKF6TEVyAOyWcMPH+AQIHkjJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l9H1kPej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ha9Lr6jR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l9H1kPej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ha9Lr6jR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32474114022E;
	Tue,  8 Oct 2024 08:23:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728390238; x=1728476638; bh=prGNEZz4wb
	8cYQYm8s1VIRkRUJcpKm4lK3JCVtME0Fc=; b=l9H1kPejIeDoxCrQ/9KUSqYL7x
	FPS4o8LIlFGoajKzeuoz4Qu0wXAixKPNT6gZX+QONEiU8Ymvgz/FqfKz7R+A6R6z
	eT4TVhJFExgSitW9fgijfY55zuKeIYZRcpkaTUgoeTJrBR5s2Fh8GhGDYbeubnE6
	gt1GTdptiOqqzBE6qT6gn86i7aWBfGK7syavrNvyAtsKyNH5NlteZtSPOgjfVV81
	aCyeQSO29DUb9RlscKnl2+mQYlEK/aww2U1BB0yZYZI5MH7ICaTMonZuIJtVXgyd
	0UBn6VLaoYcrdJfWdVsG2ATMaYjFvOApGIsC5OYBgaNCfyGqEI6K3VPGGF6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728390238; x=1728476638; bh=prGNEZz4wb8cYQYm8s1VIRkRUJcp
	Km4lK3JCVtME0Fc=; b=ha9Lr6jRsYcQzAsjXgAz8TmSb1u/ZIQ25Un0vSvRLvFB
	sGck3jwaGmi47aXXxtQHxS17mW1MgSwyNqAddZkqcDpb6I+VyGLlcQl9DQGbCIRL
	hg/mp5kHmMV+dRTPnN0+Hr/QwpjoWds+2NPP2pSa+9m7rO4Z+Pwi6joVdkyBqRR0
	aMyKXZiuBYGKRHTMDZOD1KYuWrSKeP4RrS1Shun3aVwpxQGD8vsigzFNfQPsW+lB
	f1msZ5bzblIsBv4ZM+Hvi7/uTpWAeZhYNMA/FasMfqk0TSCUoF29M93Hapz+dvJT
	63qHNOJBHiXAFR+X4Z+iq/z+XUOcueK8PdVAvyk2cw==
X-ME-Sender: <xms:XiQFZ8ymea-hp-e6hRHHxquvcPyPRy9NniHrrzYzj-nSgYOFcwdsrA>
    <xme:XiQFZwRprfa9cUo9poTnfacgZZkLeLUO93ebUnq10N7DYdjtRToiNifimKOtli0uv
    Ev6BRIi16PCN5eusQ>
X-ME-Received: <xmr:XiQFZ-WmPxMZGHBysAuZDFbhrJxBqZbfUVUHGKsNIu64ulNxNNDaHwJc-E7FSPd52zSzXCUwi2bFpEKiUudgqNsO5ZfRAA2EWoHdfqumleBqIdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejfefhleeutd
    dtffeigfevudegheekfeffhedutdefveeftdejtdeljeelkeevtdenucffohhmrghinhep
    tghomhhmvghnthgthhgrrhdrsgihnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XiQFZ6g5CxiCPOSFUvibven6_wzO_nK2KwzVfyN0lQdUOkzDPCr6sA>
    <xmx:XiQFZ-BAuGXXb8X8AhMVztJcBKRDLbWkyadWPacKlcXoW69kXwAhpQ>
    <xmx:XiQFZ7J7I2kpyj1IL0YSfZ5POyamLKwX-NaHuOsNT9oFyvl2zKssgA>
    <xmx:XiQFZ1Ao83sk4J46jFtdAUCvoCdsohACz_3J1KmNa-VQXgzHJyzXSQ>
    <xmx:XiQFZxOKNsqjQ4t5WtPjGMbgWMuOv4OcxCeSEU8NffqPAlw02jHNdb9u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 08:23:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ef3ba75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 12:22:54 +0000 (UTC)
Date: Tue, 8 Oct 2024 14:23:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [Question] local paths when USE_THE_REPOSITORY_VARIABLE is not
 defined
Message-ID: <ZwUkUuQgxaE2-djk@pks.im>
References: <ZwQSWcmr6HWTxxGL@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQSWcmr6HWTxxGL@five231003>

On Mon, Oct 07, 2024 at 10:24:49PM +0530, Kousik Sanagavarapu wrote:
> Hi,
> 
> I have two questions but a bit of a background first -
> 
> 102de880d2 (path.c: migrate global git_path_* to take a repository
> argument, 2018-05-17) made global git_path_* functions take a repo
> argument.  The commit msg mentions that this migration doesn't change
> the local path functions in various builtins - which were defined using
> GIT_PATH_FUNC.  This was also the commit which introduced the macro
> REPO_GIT_PATH_FUNC.
> 
> Skip to 7ac16649ec (path: hide functions using `the_repository` by
> default, 2024-08-13), GIT_PATH_FUNC is hidden under
> USE_THE_REPOSITORY_VARIABLE and the REPO_GIT_PATH_FUNC is made its
> arbitrary repo equivalent - which can be inferred from the following
> portion of the diff
> 
> @@ -165,19 +130,10 @@ void report_linked_checkout_garbage(struct repository *r);
>  /*
>   * You can define a static memoized git path like:
>   *
> - *    static GIT_PATH_FUNC(git_path_foo, "FOO")
> + *    static REPO_GIT_PATH_FUNC(git_path_foo, "FOO")
>   *
>   * or use one of the global ones below.
>   */
> -#define GIT_PATH_FUNC(func, filename) \
> -       const char *func(void) \
> -       { \
> -               static char *ret; \
> -               if (!ret) \
> -                       ret = git_pathdup(filename); \
> -               return ret; \
> -       }
> -
>  #define REPO_GIT_PATH_FUNC(var, filename) \
>         const char *git_path_##var(struct repository *r) \
>         { \
> 
> (the GIT_PATH_FUNC macro is moved to be under USE_THE_REPOSITORY_VARIABLE)
> 
> Looking at the expansion of REPO_GIT_PATH_FUNC ...
> 
> #define REPO_GIT_PATH_FUNC(var, filename) \
> 	const char *git_path_##var(struct repository *r) \
> 	{ \
> 		if (!r->cached_paths.var) \
> 			r->cached_paths.var = repo_git_path(r, filename); \
> 		return r->cached_paths.var; \
> 	}
> 
> It seems that REPO_GIT_PATH_FUNC isn't an exact equivalent of
> GIT_PATH_FUNC.  That is, REPO_GIT_PATH_FUNC expects even a local path to be
> a field of the "struct repo_path_cache".  An example of a local path is
> EDIT_DESCRIPTION from "git branch --edit-description" (which inturn gets
> used by "git format-patch").
> 
> So my question is - do we want, in the future in which we are free from
> the dependency on "the_repository", for all the local paths to be a part
> of "struct repo_path_cache"?  Which in my gut feels wrong - one alternative
> then is that  we will have to refactor REPO_GIT_PATH_FUNC - or am I missing
> something here?

What I don't quite understand: what is the problem with making it part
of the `struct repo_path_cache`? Does this cause an actual issue, or is
it merely that you feel it is unnecessary complexity?

> I got into this when I was trying to refactor builtin/branch.c to be
> independent of "the_repository".  It was a very naive approach of just
> manual conversion of all the git_* calls to repo_* calls and similar
> changes but the compiler started to complain since I overlooked
> GIT_PATH_FUNC and some variables in environment.h which are also hidden
> under USE_THE_REPOSITORY_VARIABLE.
> 
> Which raises another question - why are variables such as
> "comment_line_str" and "default_abbrev" hidden under
> USE_THE_REPOSITORY_VARIABLE?[1]  They don't seem to be dependent on
> "the_repository"?  Again, I might be missing something here but am not
> sure what.

They do depend on `the_repository`, but implicitly only. The problem is
that those variables are populated via the config, and that may include
repository-local configuration. As such they contain values that have
been derived via `the_repository`, and those values may not be the
correct value when you handle multiple repositories in a single process,
because those may have a different value for e.g. "core.commentChar".

> By the way I don't expect this "naive approach" to be the right method
> of doing this - I was just tinkering to get to know
> USE_THE_REPOSITORY_VARIABLE better - since builtin/branch.c also calls
> into ref-filter which heavily relies on "the_repository" so changes
> there also would be appropriate for the complete picture.

Yeah, in the ideal case you'd first adapt any underlying code that you
happen to spot that relies on `the_repository`. That doesn't always
work as it is easy to miss that something implicitly depends on the
variable. But in case such a dependency is missed it will get to light
eventually as we continue with our quest to remove `the_repository`.

Patrick

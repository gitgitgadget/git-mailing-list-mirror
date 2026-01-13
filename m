Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38F32DB7A1
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323391; cv=none; b=gLZd8pApu4Mk0Y/nBoYfjpV/EA5K4j8BvkXsV8jnK/XH4HO90H4hEzOG69qzn6hwBG04O/oVJprloSd6z7RZkbNdaO4ocrXJmGTSNszMFJNlRJuqznJs6ReNgRqrdjKAs82TW3mGUNKk9baVNF+Ubf/Od9kzoCN+2tzh6Xk5K9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323391; c=relaxed/simple;
	bh=pJomECVkOEbedjpPgbPlv9IHJm6TRAhLsVV8JClrrAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7K7PTy8bEnFx/2I7ZeOLaoFn/rHgubHEeM3km7195hgo08Ejl522mf2FSxKwFu7NwJVNjGnq+PzDh9WgoetQgRzqd77KmZuACcGQrfF6Zp5zPooH9/KC6Ix+2ifgXvEhGfthWc6FJvnTbrsPi0dy1c4oRzWVuuH+y/CU67KhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RpBdW4US; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oz8eUyty; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RpBdW4US";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oz8eUyty"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id F069A1D0011A;
	Tue, 13 Jan 2026 11:56:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 11:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768323387; x=1768409787; bh=cXNtIiw9am
	/9Kw9/e1OpHH/MG89WTN8Y+P8xdAi0d/k=; b=RpBdW4USz/4JjrQaVxBYo6agAj
	L0rdqJ8Hr3OuQ2GvpDliHK/VRMhKuig5kl6xeGRc6G/oRzGHm0gHjOSDA8+xhaIi
	c2Jqrj/cXObdHKajzzxn3m7KNCEfC+5kvKzWdFmAD0kpFtuvOHZSttqXOOMfjoT6
	1KnsxE1nbZmuVGz6IuejnQK+JcOa+CxvlK4Xg6nDe/2RQuMH5fA3H2m+FKEXcC5/
	286zSVg3tZOUv5X1EnPPADBbi9n7Qer5DIx5GF2+9BYahujaAUmS/8yWI7/kM5mk
	yM82sgJ75F74vnSBb2u44+DP58b8EwP7BLvLmZXw8a9Z2Bq1/wEJHbCKReSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768323387; x=1768409787; bh=cXNtIiw9am/9Kw9/e1OpHH/MG89WTN8Y+P8
	xdAi0d/k=; b=oz8eUytytDgnnNDeaiEZ5kgp2JypEcBZlc1V/PiypH5rwsEHJut
	xgco+GzU3Axbs0+c14u4L1OfDTQ2kRKEdP2WjyO/ykLiNttNTfvaVei+5ivVq/aE
	euaOEGIGXJNrJJT8mELX9vlOOEJh+XcjIQfNtLLQb+RoYdTMipwuFQxkavvzL9M3
	Ih0eU84BpncU3bSirNMCRauZLZMVvUjYtcLUfOCQHol3E1rBtO4eQyd6kbcLSdV7
	CJ100Jo/5jkE0nndk2cvNdNUk3bkws3OlzxRZlGd0MxP54HYRNz1GsDh4ehP5u4I
	G5aZnKtOUyPf3yYk+PJSJ7ZV7Z99p7TUZUw==
X-ME-Sender: <xms:O3lmaWtqon2Divv5ONYyAb7kjmx7kgbLO9OgW45FZF1Siq5JAwNFsA>
    <xme:O3lmaeBRG4HwDHi3sSPF_1ysGvMjYm01dkmG62ZFGxH-fq_UDmE2hQVjTXu9egSYh
    pWxu5nr7yqsuyzk-0fU_6FYfjD31Bhl6Kgl7xRMhKIT7AfheMw>
X-ME-Received: <xmr:O3lmaVbxzsVPDx1euuvhav7-3eeBh4ZrAoNWmxFOKUykWJMo6AypXP6wbErjEDPtAe7afdwsSPb26SHDtfiBzscI9LAou6ZlsqAxPNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhephffvvefujghffffkfgggtges
    thdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepgeeuheelveevleffkeeg
    hedvhfevfeekuddujeehheegkeetueetueefgfduheefnecuffhomhgrihhnpehgihhthh
    husgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O3lmaRW7xEJZj3qkmrRRQy7GydOmhotMAaxBUvwdszZxlvmXj3OBMA>
    <xmx:O3lmacO1tFymXHOhzayyiRONanASg3bd_oIXb6F7UCPxIDs6KGnIzQ>
    <xmx:O3lmaTZMpI9YZTobn_kulIgpO6FxjFRGgJdGX0JWqGs-8JMl4_-EHA>
    <xmx:O3lmaT_zO6TJ4mV3GdTsMDhEQ6xGG_DOSmYJIbYoPP2UBsHe2J-qag>
    <xmx:O3lmaXJOubAert6K1zc19ZKRrtNdCvsywDOITxEjp7tRdOigshnOuydz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 11:56:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [GSoC PATCH v1] builtin: stop using the_repository
In-Reply-To: <aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local> (Abraham Samuel
	Adekunle's message of "Tue, 13 Jan 2026 17:16:20 +0100")
References: <aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local>
Date: Tue, 13 Jan 2026 08:56:25 -0800
Message-ID: <xmqq7btljvt2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> The builtins use the_repository global variable which might
> not work well when running many repos in the same process at once.

This is true, but ...

> Stop using the_repository in these builtins to align with the goal of
> libification of Git.

... in general, each file under builtin/ is about a single command
that _uses_ libified part of Git.  So it is perfectly fine for the
libification goal to include "libified functions should not assume
that it works on the_repository, but they should accept a repo
parameter to tell them which repository to work with".  But it is
not necessary, and I would say it is harmful, to subject builtin/*.c
to the same criteria.  The builtin command implementations can call
libified function by passing the_repository to libified API function
that expects a repo parameter.

> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> ---
>  builtin/bugreport.c    | 13 ++++++-------
>  builtin/bundle.c       | 13 ++++++-------
>  builtin/check-attr.c   | 26 +++++++++++++-------------
>  builtin/check-ignore.c | 27 +++++++++++++++------------
>  4 files changed, 40 insertions(+), 39 deletions(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index f78c3f2aed..77eb8bd9c1 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "builtin.h"
>  #include "abspath.h"
>  #include "editor.h"
> @@ -37,7 +36,7 @@ static void get_system_info(struct strbuf *sys_info)
>  		    shell ? shell : "<unset>");
>  }
>  
> -static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> +static void get_populated_hooks(struct repository *repo, struct strbuf *hook_info, int nongit)
>  {
>  	const char **p;
>  
> @@ -50,7 +49,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  	for (p = hook_name_list; *p; p++) {
>  		const char *hook = *p;
>  
> -		if (hook_exists(the_repository, hook))
> +		if (hook_exists(repo, hook))
>  			strbuf_addf(hook_info, "%s\n", hook);
>  	}
>  }

It is not strictly necessary to churn a file-scope static function
like this one into taking an arbitrary repo parameter, as the only
caller of the function, presumably cmd_foo() in the builtin/foo.c
file, would pass the_repository anyway, whether it explicitly names
the_repository or passes the repo parameter that it got from its
caller, git.c:run_builtin().  We _can_ consider a change like the
above as a preparation to potentially move these functions to the
libified part of Git, so even though I said it is not necessary, it
is also OK to perform such a change.

> @@ -93,7 +92,7 @@ static void get_header(struct strbuf *buf, const char *title)
>  int cmd_bugreport(int argc,
>  		  const char **argv,
>  		  const char *prefix,
> -		  struct repository *repo UNUSED)
> +		  struct repository *repo)
>  {
>  	struct strbuf buffer = STRBUF_INIT;
>  	struct strbuf report_path = STRBUF_INIT;
> @@ -141,7 +140,7 @@ int cmd_bugreport(int argc,
>  	}
>  	strbuf_addstr(&report_path, ".txt");
>  
> -	switch (safe_create_leading_directories(the_repository, report_path.buf)) {
> +	switch (safe_create_leading_directories(repo, report_path.buf)) {
>  	case SCLD_OK:
>  	case SCLD_EXISTS:
>  		break;
> @@ -158,7 +157,7 @@ int cmd_bugreport(int argc,
>  		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
>  		strbuf_addstr(&zip_path, ".zip");
>  
> -		if (create_diagnostics_archive(the_repository, &zip_path, diagnose))
> +		if (create_diagnostics_archive(repo, &zip_path, diagnose))
>  			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
>  
>  		strbuf_release(&zip_path);
> @@ -171,7 +170,7 @@ int cmd_bugreport(int argc,
>  	get_system_info(&buffer);
>  
>  	get_header(&buffer, _("Enabled Hooks"));
> -	get_populated_hooks(&buffer, !startup_info->have_repository);
> +	get_populated_hooks(repo, &buffer, !startup_info->have_repository);
>  
>  	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
>  	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);

All of the above look fine.

> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index 1e170e9278..ef21ccfd89 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c

Is this patch meant as a microproject in preparation for applying
for GSoC?  If so, we ask to limit one quality focused one per
applicant.

https://git.github.io/General-Microproject-Information/#only-one-quality-focused-microproject-per-applicant

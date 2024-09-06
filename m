Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B71465AC
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619614; cv=none; b=DEIxlJ2TPnEwiGey+qYmbQrn+ZDAHZxoisKvWrDKMCTRgVadxZ1Ym5hGOYh5tk9xICtcWyQBO2GOIBnJdTzFoCZQCKMdK7Da91tFadwGe6RsZspOFE/tyNNn1huqR60R0s+n1Z2jp7nAg2kRIbLZ6U/p0HW7JZYNmo9YVT0T69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619614; c=relaxed/simple;
	bh=DQh6hqJ6ceXlQ05OcHlLuOBXlxIk5gHb3C/kqm4UmEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/NW8TLstzu8srXLFfeSe0R5X4qesFxEPVfCnNWb4RtyYEO5hjiBhCD/3rlfK6W4G9foLr3qALBUWGGww2uFo4vdpj8onC4EEXbJYIlBZY00MQ/2KCPzUfyRVu4z5bq//zf+6eg2EkIusDaVjSRRmZI+oERTI3s/YtfjWGLIS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tc51hBLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXj/Zct5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tc51hBLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXj/Zct5"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C4AD13803AB;
	Fri,  6 Sep 2024 06:46:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Sep 2024 06:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725619611; x=1725706011; bh=C/2IlBqaQC
	YbLJQjxRQqQ/o5EKc5EVu1JOVBgFoloaY=; b=Tc51hBLpYEXBzP3UeuGICQShaK
	jF+LM4CBZn8n4po7QcRwTTtBXZausX/h1v0YI0VdyxGCi5Ovtyb+NyvHB5BVrdNk
	AEcBAW6DEupPd2a+qnjvbpTwyRlzRjR/4/gk3Far4vREbUVX7Z4vV8/i/oSKYgwC
	Nbw7YO4g33Xbkmixf7H46EEdjcBQDe4v+rKNi7eh7o7u4ZrTD0I8AEjBGqBcVMki
	QXV1dYS5tkPwMtSrb5dJlyw7yRy35zPWdOl8XdIzykaQi8BwFTXLfFH4Cq4iCKTW
	IZ8iUJ7OHoEnuEi7JDt04JCa35KpDZ2tVB4NfoUtZCSVBD1vu0s9HmJqvDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725619611; x=1725706011; bh=C/2IlBqaQCYbLJQjxRQqQ/o5EKc5
	EVu1JOVBgFoloaY=; b=mXj/Zct5PsIPw6zAUWseleFxeLPG01JPJXZFywYGAeXF
	Vh38st6yhH03NhmGB7e/l3gruMW+wllknaW2+7mjIqEbjyM4xUQzvoXAMxjjzKef
	1jnLXW/5EpT6D3b34P+JcfsHb8PaWBRMSu2XJiV3MuTB7YUKf7ZaaL01AiwdH/Fo
	r0A5c/b46Bdx+6wrgfl+wz6QOGd0dcG4WCYltFyK28PvdM3eTMLChDqsmwCZPfuh
	w3ityD8+/c+fA0eWJijpc3xdic8ZjvVh22S0GbzCXamtzQTAgBJQzSWHbZFk478W
	5qfrFD/d/sr2h2osXEhJEb38XpTPUwbs1458N9l2Mw==
X-ME-Sender: <xms:mt3aZlAThjtF37oRdX9_kZTKSeqwPKX7SGtzRb-mKUJv6Dl2wYdWWw>
    <xme:mt3aZjg1JkO_yk95-c-DxfwaGWZmg0sG_fkRE9VyvKWMgC0kg7T4xaqmdMQteTSbX
    sy4YLpT_kHTvDKsrA>
X-ME-Received: <xmr:mt3aZglRFYJHms6ZIvozn6kct4H4CDLkvmy47Wq_0eYNRE_IdW99GUix7paU1vGcge4a9JY3Het3nH7MP4aZo5zDmTX9EvVTcOClpD3aKCNn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mt3aZvwCEVEuUnFeX8265sJ8iOwA-jRKOF7Yce26yLjn9RCRvUMWIA>
    <xmx:mt3aZqRxgFGTdw0Yku0P_m0YvB-O80ulGXMRvqRjupVq4kOSHAvNPw>
    <xmx:mt3aZiZX4JUSjdrq3Hhzr2Ror1RnZi7hMrYq0dIZO9qmklZnfMbJGQ>
    <xmx:mt3aZrTQdhylKjfyIWEqOyV6mYAFzkb_gTTW6nuk10vCj0GHNYUFAg>
    <xmx:m93aZoc7MsC76mh4WcuC1c16dUocDuEfrjGwzm8vvZOWVq2mCGUt5UcM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 06:46:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fdefe8e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 10:46:34 +0000 (UTC)
Date: Fri, 6 Sep 2024 12:46:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/3] builtin: add a repository parameter for builtin
 functions
Message-ID: <ZtrdljxBJtnaUEla@pks.im>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <3301a34f76303c43feaf4eb9d6913fbeec439e97.1725555468.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3301a34f76303c43feaf4eb9d6913fbeec439e97.1725555468.git.gitgitgadget@gmail.com>

On Thu, Sep 05, 2024 at 04:57:45PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> diff --git a/builtin/add.c b/builtin/add.c
> index 40b61ef90d9..3b9bc93ed9a 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -358,7 +358,7 @@ static int add_files(struct dir_struct *dir, int flags)
>  	return exit_status;
>  }
>  
> -int cmd_add(int argc, const char **argv, const char *prefix)
> +int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
>  {
>  	int exit_status = 0;
>  	struct pathspec pathspec;

Nit: all of these are now overly long as we typically wrap at 80
characters.

> diff --git a/git.c b/git.c
> index 9a618a2740f..0ea6e351dfd 100644
> --- a/git.c
> +++ b/git.c
> @@ -31,7 +31,7 @@
>  
>  struct cmd_struct {
>  	const char *cmd;
> -	int (*fn)(int, const char **, const char *);
> +	int (*fn)(int, const char **, const char *, struct repository *);
>  	unsigned int option;
>  };
>  
> @@ -441,7 +441,7 @@ static int handle_alias(int *argcp, const char ***argv)
>  	return ret;
>  }
>  
> -static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
> +static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct repository *repo)
>  {
>  	int status, help;
>  	struct stat st;
> @@ -479,9 +479,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  	trace_argv_printf(argv, "trace: built-in: git");
>  	trace2_cmd_name(p->cmd);
>  
> -	validate_cache_entries(the_repository->index);
> -	status = p->fn(argc, argv, prefix);
> -	validate_cache_entries(the_repository->index);
> +	validate_cache_entries(repo->index);
> +
> +	status = p->fn(argc, argv, prefix, startup_info->have_repository? repo: NULL) ;
> +
> +	validate_cache_entries(repo->index);
>  
>  	if (status)
>  		return status;

Looks sensible.

> @@ -736,7 +738,7 @@ static void handle_builtin(int argc, const char **argv)
>  
>  	builtin = get_builtin(cmd);
>  	if (builtin)
> -		exit(run_builtin(builtin, argc, argv));
> +		exit(run_builtin(builtin, argc, argv, the_repository));
>  	strvec_clear(&args);
>  }
>  

Why don't we need a check for `startup_info->have_repository` here?

> diff --git a/help.c b/help.c
> index c03863f2265..e7cdfab6432 100644
> --- a/help.c
> +++ b/help.c
> @@ -16,6 +16,7 @@
>  #include "parse-options.h"
>  #include "prompt.h"
>  #include "fsmonitor-ipc.h"
> +#include "repository.h"
>  
>  #ifndef NO_CURL
>  #include "git-curl-compat.h" /* For LIBCURL_VERSION only */

The include shouldn't be necessary. You can instead add a forward declaration.

> @@ -775,7 +776,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  	}
>  }
>  
> -int cmd_version(int argc, const char **argv, const char *prefix)
> +int cmd_version(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	int build_options = 0;

Patrick

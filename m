Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812A8F4A
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735542962; cv=none; b=cPZFR/4XvSR5jTdGBADV4HKjsXaEr6qXF5zNLJBOVNXQxUvhkYXTQjECIkQHa9NjA6sPQ+HZq6CRxgn1aAImYqjzUOyVv/M6K7wotO7bMVnpZqDHIJ2oeD9a4xkjHkQkIWbflvNbVQsr9AJ3RXqXmxugoK3YQXkKaCRk+VWh/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735542962; c=relaxed/simple;
	bh=DHvqZgnxsvYUr5y0hiHEOnpRx01vIqkaJjfkyP0AM/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfKgjzgIeYiQVCHMUPUfq/++rBk8FK4sW706ztmo+KrChCbDjWcyUANY0a5PSADN+9jhZDKhKUBJwcKOJWKefTptxpNLXe/yorXw0P1XviBmLQSeQQHlWARTzgUG1g89dOX0soKOuBbELgRrcUp/vnYd/W7WVhi3USYOA1k3OdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQWxzmUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvKLMko2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQWxzmUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvKLMko2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8761111400FB;
	Mon, 30 Dec 2024 02:15:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Dec 2024 02:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735542959; x=1735629359; bh=hyphKGNM+t
	Xu0RSyzTKZRcr74BawVQ8s3qX8y9SMHJQ=; b=bQWxzmUiiXyB8j8muoN0UsP0KC
	1CdqKYLt5ik+uGr8q3tX4J6MVs5GjZ7JVL9EEvHc7Y5OSdh5j0YzB4emc6yk6/3P
	MFGRIdgsuhPHP25CPo0Hs7o8g46iE8kDAwcS7nVOi3RnrYfH2f5hxhmAqm//tboH
	exxlzhxpqIoMjgBNhLjDC2tQhQq1vy727HPMPNSL99wWiiUncRbEz17SEbCGw8Xr
	2CrRs2DOAduOmLJfn+dmutHP/au7+0EPEplS8qHjNcaw2saFJ3R+XylR3b7A2X7x
	S3mv7CMDcz4U/anWVyNipSGY4qH2MlS2s6zTBttGLS87blacSpdlVjDd3JuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735542959; x=1735629359; bh=hyphKGNM+tXu0RSyzTKZRcr74BawVQ8s3qX
	8y9SMHJQ=; b=bvKLMko2HBBPNyVBTRO3+/Bd/ybR7aD5ZgWRMhMn2i5x6q9Lfid
	Gwv5lzD0UiX2+70HkpPwhMBJ1X1DtBtljSTlfi6Iv+scXwzcCiYLSn3i7PaxtywD
	XU7QyCYApTm4MpI5oZU8q1M/w7sMMJglMtl3HjocL6gPF/vDj6arB22bRRo3z7XF
	h6ptyBQkILMBRytIyYQsLMc8OKP1IZ6g7pZJ3CxC4EypmjFbjge9jcdn3cfISS/9
	tyYTSCfvJZKwA1aAaibn7ngyEXeAtnlc0X7Ap1sKvpWqpCn+4ypA+RD+axbKakNP
	icWdEuEtKieRNysq5/fOz7SlZDyA1+woB7w==
X-ME-Sender: <xms:r0hyZzmVwmfZ4jJp_qoFKrLPWZoO6Dv4uDjfSxQVkBNRoECjeP9_dA>
    <xme:r0hyZ23bbEZ-FS2TI_Tj2GPi_Ept4OzUlNhPri50a9ZjmAmuo0FmgUzKqv7i4FFkE
    U6GzrYv5wmpqsVbhA>
X-ME-Received: <xmr:r0hyZ5qzWY9d3mpQyaRsD7W5bEcV7xOwDOvEW7kJzvsytodNgcWoGn10S2Vc_WLQ6hORpACdi6g4m1X_cTOSajg-MyeebDxAsZQqsS0F2itGM-0H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:r0hyZ7lAaQOIdtLuEuP8RKJofJLyEfYOngX4JvrlYau9HpTfnPRF0w>
    <xmx:r0hyZx2Jxli3bAZhb4qYGbk_DFFbcVgCFhXfUlEItYAy4vvRwUxN1Q>
    <xmx:r0hyZ6sLWznzdxDv5COmZhv4x1wr11Rd4Cag5hAaGABmKAhlig1CKQ>
    <xmx:r0hyZ1Urgbbd5U9ChO0uq_tA_Zl5Ka1hetX27XJ2ZZcPkPckmx8LUA>
    <xmx:r0hyZ8TvyiMOi5NrYyltFe92_JXBsEUnZ3uP06qv3BsqppqprzwOzLih>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Dec 2024 02:15:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40b76b81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Dec 2024 07:15:56 +0000 (UTC)
Date: Mon, 30 Dec 2024 08:15:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v2] maintenance: add prune-remote-refs task
Message-ID: <Z3JIpDQTDrQuoEN2@pks.im>
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
 <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>

On Sat, Dec 28, 2024 at 10:07:41AM +0000, Shubham Kanodia via GitGitGadget wrote:
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 6e6651309d3..8b3e496c8ef 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -158,6 +158,26 @@ pack-refs::
>  	need to iterate across many references. See linkgit:git-pack-refs[1]
>  	for more information.
>  
> +prune-remote-refs::
> +	The `prune-remote-refs` task runs `git remote prune` on each remote
> +	repository registered in the local repository. This task helps clean
> +	up deleted remote branches, improving the performance of operations
> +	that iterate through the refs. See linkgit:git-remote[1] for more
> +	information. This task is disabled by default.
> ++
> +NOTE: This task is opt-in to prevent unexpected removal of remote refs
> +for users of git-maintenance. For most users, configuring `fetch.prune=true`

Do we want to make this linkgit:git-maintenance[1] even though this is
self-referential?

> +is a acceptable solution, as it will automatically clean up stale remote-tracking
> +branches during normal fetch operations. However, this task can be useful in
> +specific scenarios:
> ++
> +--
> +* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
> +  where `fetch.prune` would only affect refs that are explicitly fetched.
> +* When third-party tools might perform unexpected full fetches, and you want
> +  periodic cleanup independently of fetch operations.
> +--

Nicely explained. I wish we had more such documentation that is taking
the user by their hand and explains why they may or may not want to have
a specific thing.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4ae5196aedf..329c764f300 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -20,6 +20,7 @@
>  #include "lockfile.h"
>  #include "parse-options.h"
>  #include "run-command.h"
> +#include "remote.h"
>  #include "sigchain.h"
>  #include "strvec.h"
>  #include "commit.h"
> @@ -913,6 +914,30 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +static int prune_remote(struct remote *remote, void *cb_data UNUSED)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (!remote->url.nr)
> +		return 0;
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
> +
> +	return !!run_command(&child);
> +}
> +
> +static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
> +					 struct gc_config *cfg UNUSED)
> +{
> +	if (for_each_remote(prune_remote, opts)) {
> +		error(_("failed to prune remotes"));
> +		return 1;

I wonder whether we should adapt the loop to be eager. Erroring out on
the first failed remote would potentially mean that none of the other
remotes may get pruned. So if you had a now-unreachable remote as first
remote then none of your remotes would be pruned.

If so, we may want to collect the names of failed remotes and print
them, as well.

Patrick

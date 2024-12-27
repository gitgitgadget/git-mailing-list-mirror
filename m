Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D612A177
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735290466; cv=none; b=fIRBz6IPcnwOvSXdTr1CcAUmz0hQD88azlV2c5SqFrlRBevKttv4ZncS7BEXuLtYrn6CeL0lD6zWzI6Dbez/deYRv7bBvP8dHSjFKNuhcZZydu94ianzrlkSDcPx6nQMVMCPW4aS+b54ZDtf8A+UwZTx9PID+dZVQqOQm+zTTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735290466; c=relaxed/simple;
	bh=YICZIVUn2tQEqIR/VxO2TzAn0T3SQH24ZQianVCycVA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FTVz3rnzFACyRJBBSiwjJ4aPYiUJB2jQrWXIMkXLKmd4PuTyy12+9k3ZMyOkbp9y06Fo7H7NW4b7q8yC8peOOFhxFr+AkgQVVivMSKSkz2BV3CJoL6AswuRDQg/pXenFe8qyLkDbp8i+PPVJxkBZpE/ZCWdlxqffSW/Upfb3Clo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZvcCNbQd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mmqFE7NV; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZvcCNbQd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mmqFE7NV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F32631140151;
	Fri, 27 Dec 2024 04:07:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 04:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735290462; x=1735376862; bh=kDkmb1u7p2
	2JbsuxjO7r4lsi2YoBLKSg9hL+cgWzgGs=; b=ZvcCNbQdkZ49BrIYAE/NCAPBAx
	hv54BQhellhEMkxeXERox3W7XOD20eFWo9LRrd6mDK9askdg/SLydsibEyZVY+4j
	XQtYJ80PrDmy1zZX/VMvqq0CKZMzYBQhztGoCphOF4dOIqQV9f2TWpHsvLFqESPK
	Z/hw9GnMa46etl8B5ycvPt68iDYeStaTyQos3Erx/9ufKVl3tkpxjfBKpX7Ztj7e
	3DSdJQteC6EUfc17M2gafZk3NM5UArHvi6+E4xZt9UGsUQcENfMdNoJSoObxjgfg
	sivekasZink5KBKMYkyyqH48zhqPxJAwWovUuigTZyj+jq9tIDV3Q2lEZjIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735290462; x=1735376862; bh=kDkmb1u7p22JbsuxjO7r4lsi2YoBLKSg9hL
	+cgWzgGs=; b=mmqFE7NVm12xOb9N8L9AMg+fHjzjsx9ff0Bsr1EdAwHd303jOFx
	9p7bq8k+zb/LZRtyRGoV5cZqGC3Wjl8KdMTSfxqddibKTTsaICMirPj2J2TmMRK0
	o6vxWuQyAtDRM1tboiQzZp15y4LKjQjvTQ0YUFg/qH0P9yHjDuGdIeMldFM9+Wz7
	jOL1Wd3XVy89eBrFd/WbFOmd8ckWkWAaNIIO2WMBGU9Wne8/093SEcSKlhzJvUIE
	VPI+03KYtQR8ngJI5gy2qwIpheWK55EQPvc3CeV1em8xx/qxemQpzvbVVz5f5zCs
	+lLCwFKSe2doVCqse4yDr65y/EgX1UX89pg==
X-ME-Sender: <xms:Xm5uZ4fuSKwrDVd_JkIjSktWr13PV7bJzyrXLS675cnG6Jy2cGQY-Q>
    <xme:Xm5uZ6P1xB9SwL5Z01zpfUuBBi9jlygK6bjSug_eIud5ehdbd0uvdp_efoKGSDRlq
    5RnMIcjcXibUp_saw>
X-ME-Received: <xmr:Xm5uZ5hgMT_qvh64qAlq_bfT121MhRreHTFW46DIrB4uDuRabuuDVkP3rBle-cbfUP2wNBgO4WRN04uiNfsgJRq5wjLGZH-8Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueff
    teeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhhusghhrghmrd
    hkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:Xm5uZ98c0mVMJXhnS3ug0oLrBjwnxtIswc0JYTTh7Aq7BvhlhZOgrw>
    <xmx:Xm5uZ0tpPlyc7Bvthu3W2TFQutjgy3qMNUU0jUhSaufaic_2CXcRNQ>
    <xmx:Xm5uZ0HTNvVUJgIjCrh0_GyUm8KolF2o1NLJSfzp04MWPRvgV9fRTQ>
    <xmx:Xm5uZzPqrTqzALik46i8o9tyIG9rdDCoI9huxio5VimR5kGqDtoD4w>
    <xmx:Xm5uZ-UnDEdzyPr5WtwE4Z1ejXRFKHUtpC1sMiYE-zE3hQ2KRRqbzSm4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 04:07:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Shubham Kanodia
 <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH] maintenance: add prune-remote-refs task
In-Reply-To: <pull.1838.git.1734946566885.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Mon, 23 Dec 2024 09:36:06
	+0000")
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
Date: Fri, 27 Dec 2024 01:07:41 -0800
Message-ID: <xmqqed1tv6hu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for a patch.


"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

You'd want to check your procedure to tell GGG about addresses; I am
seeing these

    From: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
    To: git@vger.kernel.org
    Cc: "mailto:gitster@pobox.com" <[gitster@pobox.com]>,
            "mailto:ps@pks.im" <[ps@pks.im]>,
            Shubham Kanodia <shubham.kanodia10@gmail.com>,
            Shubham Kanodia <shubham.kanodia10@gmail.com>

and Cc addresses in it would probably not work as-is (I've fixed
them up manually).

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> Remote-tracking refs can accumulate in local repositories even as branches
> are deleted on remotes, impacting git performance negatively. Existing
> alternatives to keep refs pruned have a few issues:
>
> 1. The `fetch.prune` config automatically cleans up remote ref on fetch,
> but also pulls in new ref from remote which is an undesirable side-effect.

This makes it sound as if fetch.prune configuration makes new refs
pulled, but that is not what happens and that is not what you wanted
to hint.

	If you run "git fetch" with the "--prune" option (or with
	the fetch.prune configuration set to true) while having the
	default refspec "+refs/heads/*:refs/remotes/$name/*"
	configured in remote.$name.fetch, then ...

> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 6e6651309d3..0c8f1e01ccd 100644
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
> +is a acceptable solution, as it will automatically clean up stale remote-tracking
> +branches during normal fetch operations. However, this task can be useful in
> +specific scenarios:
> ++
> +--
> +* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
> +  where `fetch.prune` would not affect refs outside the fetched hierarchy

The word "hierarchy" hints that things under refs/remotes/origin/
(which is the hierarchy 'foo' is fetched into) that went away would
be pruned, but that is not what happens (otherwise you would not be
adding this feature).

> +* When third-party tools might perform unexpected full fetches, and you want
> +  periodic cleanup independently of fetch operations

You'd want a full-stop after these two sentences, by the way.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 4ae5196aedf..9acf1d29895 100644
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
> @@ -913,6 +914,40 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +static int collect_remote(struct remote *remote, void *cb_data)
> +{
> +	struct string_list *list = cb_data;
> +
> +	if (!remote->url.nr)
> +		return 0;
> +
> +	string_list_append(list, remote->name);
> +	return 0;
> +}
> +
> +static int maintenance_task_prune_remote(struct maintenance_run_opts *opts UNUSED,
> +					 struct gc_config *cfg UNUSED)
> +{
> +	struct string_list_item *item;
> +	struct string_list remotes_list = STRING_LIST_INIT_NODUP;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	int result = 0;
> +
> +	for_each_remote(collect_remote, &remotes_list);
> +
> +	for_each_string_list_item (item, &remotes_list) {
> +		const char *remote_name = item->string;
> +		child.git_cmd = 1;
> +		strvec_pushl(&child.args, "remote", "prune", remote_name, NULL);
> +
> +		if (run_command(&child))
> +			result = error(_("failed to prune '%s'"), remote_name);
> +	}

Hmph, is there a reason why you need two loops, instead of
for-each-remote calling a function that does the run_command()
thing?

"git grep for_each_string_list_item \*.c" tells me that we almost
never write SP between the macro name and the opening parenthesis.

This loop does not stop at the first error, but returns a non-zero
error after noticing even a single remote fail to run prune, which
sounds like a seneible design.  Would an error percolate up the same
way when two different tasks run and one of them fails in the
control folow in "git maintenance"?  Just want to see if we are
being consistent with the surrounding code.

Thanks.

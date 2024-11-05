Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DB1B5336
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 07:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790720; cv=none; b=ZdtOk1L8g+aI+rqJJA7jVwClXn8jNb3hVYjvHmWPJMGYd+rc6XN5fnsl2IeXHiJkTWHKQ2bZJNOv2vfIJxlYxjafkD58JaaeaG8OoSiir7g+k4qvjpeNiqPEa2rpWkGJQ/orMa31yHgffxEwYfdXA4lRnN9qN8gYfC73/3l6WaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790720; c=relaxed/simple;
	bh=KyXYxoWWW/L6CY8MUx5SfXjDULX6uCh0mjnHHDU1h1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6lOY6NQXlmfk3AAjbXHMnGfH8mJQtbwhT+YU3THhUi8kwSE/V9Ga+fDrgqj5YdCxdPFYksbCAtVWQDncUEdEPAmLXGTjxPaMkrvBSuiAV2jaMYUQLcoXLPq8qVMsBljaPx8GiafNmU12Um0muZbTv57+mRI9ZM1Z9mDOcjaDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TuDU9OUa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxnmKDP3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TuDU9OUa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxnmKDP3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A3A14114011A;
	Tue,  5 Nov 2024 02:11:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 02:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730790717; x=1730877117; bh=tyj/klDX02
	sF5yBTvBFNfkL8FAfrXTYlgwHyPu6oW0U=; b=TuDU9OUagM3LRV2CfTaoLt/aoj
	bYIVkPtj0VcclvQGLjjSFA3aOsKykm4Am3mwvdAs9UT+D0WtQw2pyvVuH9z0viek
	luphHrjEqu63okxty8DlVdnB9wfWYu8UZgoIr/up3IzXfkJrBFKMJQK/jxcXN/Yh
	0Es+A8/6Zy6tjRqxNx4eTXWmEKkSiduNgBlOPaO49N+c30tOaQFEcbZjlfLO+dnj
	waMOBs/T4N8Lhfb3nLArMWGRgWG1HwFEwvetvlHHD6NsL02SBrHPIFmfH1+ggA2D
	ErcTpvyX5UpKuclwYM90yzeB2W9yj1ioNPGXN+Mt0FFgEeJLHR0SWgvbE1OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730790717; x=1730877117; bh=tyj/klDX02sF5yBTvBFNfkL8FAfrXTYlgwH
	yPu6oW0U=; b=YxnmKDP3VQNyOEPmRDKPofvsSw/0XdHFX9ig/JoMIYu73nilvZO
	qjzO0ddUoOC2iQNWOn4Ib6JDVneG/ZO8A+WOVAAyhxFSRUmxfk3QQG5PPMhEndsS
	po2hJ9lqC2bW6BcQ9nZabMv2Bo2cHQ1RvYTtJo3kmNVJ78G+/6eBVZzy71r5i6CZ
	SpZFi9WkzOOkEHwWLmAuPBSh2wBSbooB3y+1oL8eyJUsSWKhDGMOf1hu/cMaYjTb
	P6r8rLspPoqB6Dg9zRYRuwh7yEWiGltZJhFkuMk8h+i/0xUQma48W1bKnM6MbI0o
	3mQ4gKp8gw+Z6URbIh8hxsxP8Mrmg2rQXqA==
X-ME-Sender: <xms:PcUpZzwaOBjHZk868GmdrdU7ZCJG7Y8p6_M7PsNiSTNSVNYpwH-wxw>
    <xme:PcUpZ7Qvuza_1zR6oVI6T-Zt-wzttVSsp2EGZZPyaDasexTeVqLnZ_yqxRQt_cBOj
    6ESnlwFDuHLLG0lnQ>
X-ME-Received: <xmr:PcUpZ9Vf34PZy9IdtQxbdvXpbumAyhtRM8B_l44iy5IhMqUggbHibniVl3fMmb1wtpfFP3b6JFrUZHlGMdqDMylP31X8EMJJV9U3eRbpx-ez-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PcUpZ9iXdCncKt5HcxOGMQLPGrIRciyzxpUc26BMC6WI2O_AHBYG3A>
    <xmx:PcUpZ1B7dO4fNhGBj2wQBwWeIabWQXkQ7TbXhjnPM-DXbQac3DADRw>
    <xmx:PcUpZ2L9CL0NHT07R8S3dsS0jam0wLMAa44LiItJOkM6sooC0E2Msg>
    <xmx:PcUpZ0CAb5XNxYLcvszlkPQR80yDgFP5fxTCwK3QcvSrPCYB8Ikm8g>
    <xmx:PcUpZw_XOCJIXnFBd8wFjgS14hNfEZtCMOp3GciQuDJWvw6v5gY1TMQ6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:11:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2eb87a15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 07:11:34 +0000 (UTC)
Date: Tue, 5 Nov 2024 08:11:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZynFNQ8SnvTJlVdN@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYcPwLB5oLTFUo@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZYcPwLB5oLTFUo@ArchLinux>

On Mon, Oct 21, 2024 at 09:34:40PM +0800, shejialuo wrote:
> We have already set up the infrastructure to check the consistency for
> refs, but we do not support multiple worktrees. As we decide to add more
> checks for ref content, we need to set up support for multiple
> worktrees.

I don't quite follow that logic: the fact that we perform more checks
for the ref content doesn't necessarily mean that we also have to check
worktree refs. We rather want to do that so that we get feature parity
with git-fsck(1) eventually, don't we?

> @@ -66,6 +67,7 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
>  static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
>  {
>  	struct fsck_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> +	struct worktree **worktrees, **p;
>  	const char * const verify_usage[] = {
>  		REFS_VERIFY_USAGE,
>  		NULL,

Instead of declaring the `**p` variable we can instead...

> @@ -84,9 +86,15 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
>  	git_config(git_fsck_config, &fsck_refs_options);
>  	prepare_repo_settings(the_repository);
>  
> -	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> +	worktrees = get_worktrees();
> +	for (p = worktrees; *p; p++) {
> +		struct worktree *wt = *p;
> +		ret |= refs_fsck(get_worktree_ref_store(wt), &fsck_refs_options, wt);
> +	}
> +

... refactor this loop like this:

    for (size_t i = 0; worktrees[i]; i++)
        ret |= refs_fsck(get_worktree_ref_store(worktrees[i]),
                         &fsck_refs_options, worktrees[i]);

I was briefly wondering whether we also get worktrees in case the repo
is bare, as we don't actually have a proper worktree there. But the
answer seems to be "yes".

> @@ -3558,6 +3560,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  		} else if (S_ISREG(iter->st.st_mode) ||
>  			   S_ISLNK(iter->st.st_mode)) {
>  			strbuf_reset(&target_name);
> +
> +			if (!is_main_worktree(wt))
> +				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
>  			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
>  				    iter->relative_path);
>  

Hm. Isn't it somewhat duplicate to pass both the prepended target name
_and_ the worktree to the callback? I imagine that we'd have to
eventually strip the worktree prefix to find the correct ref, unless we
end up using the main ref store to look up the ref.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 07c57fd541..46dcaec654 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -13,6 +13,7 @@
>  #include "../lockfile.h"
>  #include "../chdir-notify.h"
>  #include "../statinfo.h"
> +#include "../worktree.h"
>  #include "../wrapper.h"
>  #include "../write-or-die.h"
>  #include "../trace2.h"
> @@ -1754,8 +1755,13 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  }
>  
>  static int packed_fsck(struct ref_store *ref_store UNUSED,
> -		       struct fsck_options *o UNUSED)
> +		       struct fsck_options *o UNUSED,
> +		       struct worktree *wt)
>  {
> +
> +	if (!is_main_worktree(wt))
> +		return 0;
> +
>  	return 0;
>  }

It's somewhat funny to have this condition here, but it does make sense
overall as worktrees never have packed refs in the first place.

Patrick

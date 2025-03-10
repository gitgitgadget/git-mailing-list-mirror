Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54229406
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589427; cv=none; b=tNkne/gg3C0ToR4JJj4Qg9PgtmKYhldWCb4Rv0ECA8WLZXwpwsB9TI5lgL8Qj4Wsrmk50MTyV48MRKC/9Am3TnyXFNKzE1HD7ALO7Dos1/yrzd7x4TWLVdcKwXc+9dVtRP/J1M4bsmaXAfYBC5bjjE1A+m1HC2JT6bFkoP0tPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589427; c=relaxed/simple;
	bh=R8w100Q1+YCJz4lKr/iUZMTSSk883+NLGiizvx7C5uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7+VoAghGG9A00HWRmbr3mVXXsajquu4UuvZr/o8G/5a2kr1ysm58o5MAl61ln6KiggjRSHAKiWIjgsS71hqnUuANzK99m/f9tlHhNAF/zGKCdhLXpI6qXvLk7dPfsWrXLx7+h2XFOz1SleYAXjKtrkisKa/RVearUE5KpZh6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChzT91z9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxq4mNHq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChzT91z9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxq4mNHq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 579372540185;
	Mon, 10 Mar 2025 02:50:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 10 Mar 2025 02:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741589424; x=1741675824; bh=VaA5q1Ja9J
	McSvZz4StI4XAv4hIddRwZoJpCJaH5Mv8=; b=ChzT91z9hhmqy6EdZBnEwhaWoZ
	CcIe5Qe+DrsvZUnl3QyRA1mI7Wb9uAmihI+r/k26IVUghdS2to14BxV7EiypPS2g
	0H7VvSgEld9CsP2suTmIHNuZtLqhpo7IZ6d5CJvOGezQ1/57BwMbe9NlYSKY8Z5R
	6yyeBF5wnlyOFzD2K2QociXZduvfL6fnz/CXNLSGBZLrBChY6AU3sn8AXU2O+Zvj
	YaBJR01AV/ofR+ytREOVhC/JsTcsSsyHy1A6iiTwMrZX3gGYROJbwUksMzpmm4M1
	M+kBR6QmTPng7zlDxnb5S491zZ92M3niVvpoAFzUHwjz9SYLHB9eanLRWJOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741589424; x=1741675824; bh=VaA5q1Ja9JMcSvZz4StI4XAv4hIddRwZoJp
	CJaH5Mv8=; b=mxq4mNHqB3dFj1vijBe8IrYWV9GUTWiK6tTbid3yRguTiY1W+fr
	7LbO68gxYGIgI4nE8zHvyfn1qz5dZEImEbwqBgopoQyoNyd7BYbJq4MyVZVaBN8P
	k3y6kwX9RvxdWN7+RVDk3E66RmeUk1cKRMV+VvtxZT7KmF8TIesyavPtmC+ZvDHI
	jhz/CJ+BwVq+x4PmS95o2tZrJN/9/pKt3vGoGs2SlbycPOGw2rfM95EAxyziXQid
	JoI+Sqf8a8VEoWZemYgPO5r5gemOqmnM26RHtrpd6L/BC8aZwGvZfKKWHLcoa7iw
	JEZ5repwfRQM2+KIaqWYip2zW5dGuwQt7iA==
X-ME-Sender: <xms:r4vOZ6m1iJh5VIC_6Y4ehQBht-_hW9tz_JZ1tBOqFwHGDnQtfF63LQ>
    <xme:r4vOZx1LLRODq4jiiKJRIvnYA7_VdEM-UkgWH0_OPVy0oo4ZCZnJgCrgdwRYFE63p
    xohmZNEMG9kfMls4A>
X-ME-Received: <xmr:r4vOZ4ph4Tfwg_VvqCaLhPpETceFm4vep9Kmr27ZeEx0FfVzA-GqF9_rBfTyyyiDl9TaxHqLDzPSba8RqvHYvKpo_4BmMgW7mFUL3TmIdUrcBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggtthesrgihnh
    hprdguvghv
X-ME-Proxy: <xmx:r4vOZ-nvsyQhQhKfmoWeSta2rT1KMVwppVtbYhEg4ND5sOrAIbqHEg>
    <xmx:r4vOZ41AOL_9KG7ce9OZY2iL20vrr-kY39LfBbyy8KuRimuKS1QD2w>
    <xmx:r4vOZ1vG1D0wS8Hj3jiRMX2j-S2yrOBs11gYQi4rXS0FPJmIri4HaQ>
    <xmx:r4vOZ0XIT7ZrGf6t1YdqzOXcnFzhqGcTBrHkBoZCKj3ZBapFYhsvew>
    <xmx:sIvOZ2DygzrnalA2JVdoXp9QdatoGIbW32hcG3TPT2yrra18XIeP-EVf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 02:50:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e2bc260 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 06:50:20 +0000 (UTC)
Date: Mon, 10 Mar 2025 07:50:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aryan Pathania <contact@aynp.dev>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9400: prefer test_path_* helper functions
Message-ID: <Z86LrOEhH3CJOIey@pks.im>
References: <20250308090358.25429-1-contact@aynp.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308090358.25429-1-contact@aynp.dev>

On Sat, Mar 08, 2025 at 06:03:58PM +0900, Aryan Pathania wrote:
> use `test_path_*` instead of `test -[efd]` to avoid false complaints and

Nit: We want to have full sentences in commit messages. Those sentences
should start with an upper-case letter and end with punctuation.

> output when running the script with `-v` or `-x`

Hm. I'm not exactly sure what "false complaints" you are talking about
here. The benefit of `test_path_*`()` over `test -[efd]` is that they
actually print information _why_ they have failed, which may help devs
to figure out what's happening. So it's kind of the opposite of what you
say in the commit message: we're now printing _more_ output, not less.

> Signed-off-by: Aryan Pathania <contact@aynp.dev>
> ---
>  t/t9400-git-cvsserver-server.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index e499c7f955..6c7cb1964c 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -254,7 +254,7 @@ test_expect_success 'gitcvs.enabled = false' \
>       true
>     fi &&
>     grep "GITCVS emulation disabled" cvs.log &&
> -   test ! -d cvswork2'
> +   test_path_is_missing cvswork2'

This isn't quite equivalent: we've been checking that the path is not a
directory before, but now we verify that the path doesn't exist. It's a
sensible change in this context though as our new assertion is stronger
than the old one, but it might make sense to point out in the commit
message.

> @@ -285,7 +285,7 @@ test_expect_success 'gitcvs.dbname' '
>  	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
>  	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
>  	test_cmp cvswork cvswork2 &&
> -	test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
> +	test_path_is_file_not_symlink "$SERVERDIR/gitcvs.ext.main.sqlite" &&
>  	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"
>  '
>  

We tend to use `test_path_is_file` rather than
`test_path_is_file_not_symlink`, but I don't mind it too much.

Patrick

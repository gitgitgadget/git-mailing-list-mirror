Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5F168BD
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178344; cv=none; b=fNPxowjy7OTK2gPQd0xewOwuYaw2YJYBVHKs9NEBupbp1ebl79/QYrUp4uQygsh8OkPRb2MzstnsQJYwfVAmDC85WJ2wEyvFGd09AXq8mGl0qxyXZxkLFy/tlbj1SXV0NC6DCp8OGQQ6ofF4HwuIBrKw2pHDNqDNmaff8QC6UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178344; c=relaxed/simple;
	bh=RldLfMls/+sFFb19CMTLYWebEgRXiXx+wEXCPu9VwrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JU7ipALRJvwRYcQrXlltQllfBi4rF1Tar511eRBsdpms08lgZQnT2tlrwHFFZp16Rqt4HEGTwZg3vNOA1rEVbdw65vqOM4TNIcKzZrtGMxeuc9gZ8/aukEqltrfbbL8Z5lrRoeVVcf203lyayGT+KBKtzhgQMfZWD8YVUl3c8Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FEfWBsDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDQhagh6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FEfWBsDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDQhagh6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28E0914000D1;
	Wed, 26 Nov 2025 12:32:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 12:32:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764178340; x=1764264740; bh=BfMlnw+HVo
	dJNLRauTKWI/LP5P6PMWwcyBYw8J7gqaw=; b=FEfWBsDuq4vSbcwuODpvGsLPpy
	CMagXjNJWAFoLVX/UUgzaq0YaS1d+fZnNWXgAOqzj7HpJYLEsBQk+l3XFe9MPrUm
	1RRQWqdV7GX7bakdj/08mvJHrAElUgu3E7q7dBnKz70khHi2mX/83pZoJWaz6vHK
	bbXt+3+Tm6tQ+mESG1nSFPo8+Lvqzs0E8zHAeEugdid5KfSIpYmM21GrH6JuV3jm
	b0XaAtTkKxNam5WXwHRa8oZPvhDvozXo0jmBHxUFudJPlVE5Zo6UGwxBHrdto1d8
	UFsFczvF+T80x6FwV+sNdU+7zbitsCBfCaSONXkbU3DmeKPg9t3rcOv9YOBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764178340; x=1764264740; bh=BfMlnw+HVodJNLRauTKWI/LP5P6PMWwcyBY
	w8J7gqaw=; b=SDQhagh64cxUaAc9rI7cDU+Xb799ZN5yxaTH7ug0L/yJTcn1fE1
	takiCaTgYlQEhBpFzTL3+vpHOKqohUYjnUG15231ZlkcNo+f3KnZmhyOW5CtiYJB
	fe+UBLT+0qD/WSm9cmiZN2ZqAGtG4uAcQzaGyz6AJv6UKkOtIQbFEe+o1MJo04KT
	jNjHSFqmu5TGrb5vptHUQYjfUxVx9hpaQH4z2lEANifYN/VIC1MFK7ABjU1ARNDx
	tTZgVPd14176EPjs7EO77xI6fBevmCjQQyGaUAggsNhtrHGlbtWKHeHpBPX5ALDR
	ezbG+eOmxS72dvrzZ1SfMwzVO2epzOPPQJg==
X-ME-Sender: <xms:ozknacUukJGyPoCsXfJLRSnxpVfSHGlW_aEcDsprxq8gaSIEReuSuw>
    <xme:ozknaXmoM9tSU6oicgg27XbVWDY9HaWj46fHMnKYEvxotOHa1a3FCwBOWk23OUNXR
    pIh7LiTWyAuGADu8gKZ7vy68n_Z_ir2rM6xSizKUVeYdGMUjJiY_O8>
X-ME-Received: <xmr:ozknaVZ_0WmH0RBh3sTDkrhUvCxGXmlxIt3iaClzPCVjwc1l8hG_0R4HLS_tAQYLZkohqUUhVcyvjMbrT35ubc3YCx4vZNVX58sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeegleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ozknaaOJAhdSNVGfW7GVVfDOUm_G_2_LCU6CQcQRgpyFkcCV__bVJw>
    <xmx:ozknaSZCQv00XAPj_ZTRRBo8VZdEERy22EpDm2NDz3u9nDdZ8hV5Bw>
    <xmx:ozknaQ2cQpoSmWbU7Cu27pVoXg9tyw1CLIcXqNiIYifzOVUMD3POEw>
    <xmx:ozknaQczdzCEQjZ7JuKNmIWoRXHC81udT9Cg0mtSimZYIAUig5UdSg>
    <xmx:pDknaS0BvnyUfHwWBZP79lF86FNRPgxSVV8ZWU6jBfISoM5Gejr67Zu3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 12:32:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] replay: do not copy "gpgsign-sha256" header
In-Reply-To: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 26 Nov 2025 14:33:37 +0000")
References: <4f04af5790353b074cf122c450c1cd3f8d1cecf3.1764167611.git.phillip.wood@dunelm.org.uk>
Date: Wed, 26 Nov 2025 09:32:18 -0800
Message-ID: <xmqqh5ugog2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When "git replay" replays a commit it copies the extended headers
> across from the original commit. However, if the original commit
> was signed, we do not want to copy the header associated with the
> signature is it wont be valid for the new commit. The code already
> knows to avoid coping the "gpgsig" header but does not know to avoid
> copying the "gpgsig-sha256" header.  Add that header to the list of
> exclusions to match what "git commit --amend" does.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> We should perhaps think about how we can centralize this list of
> exclusions as we now have three copies of it in builtin/commit.c,
> builtin/replay.c and sequencer.c.
>
> This patch is based on maint to make it easier to backport.
> Unfortunately that means it conflicts with ps/history which moves the
> code that's changed here to a new file. I'm happy to rebase on on top
> of that branch if we decide it is not worth backporting this.

I'd rather give priority to fixes over new development.

Thanks.

>
> Base-Commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay-do-not-copy-gpgsig-sha256-header%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/9a2fb147f...4f04af579
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-do-not-copy-gpgsig-sha256-header/v1
>
>  builtin/replay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc9..d12e4d54872 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -67,7 +67,7 @@ static struct commit *create_commit(struct repository *repo,
>  	const char *message = repo_logmsg_reencode(repo, based_on,
>  						   NULL, out_enc);
>  	const char *orig_message = NULL;
> -	const char *exclude_gpgsig[] = { "gpgsig", NULL };
> +	const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
>  
>  	commit_list_insert(parent, &parents);
>  	extra = read_commit_extra_headers(based_on, exclude_gpgsig);

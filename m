Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88570221DAE
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394489; cv=none; b=QHMmkhxKWImj5MRgR9BtNztFhojN/Spb4pHHrQ+WRVt2eRI+PD+WwssXka9CN+62Xa0BKy+J96A+xQxSOJdwzeCLsW/SeMIAtnJYNyP98xCEwuz5jSX2mf1RWra7ptU43jWTDrd4XKk9oW0XqklAu1JUuHtdHms92fHDblGcwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394489; c=relaxed/simple;
	bh=F+2mcZnRIfMPXu/URkfvApvV6Bn3t/y9BTS34rBjjys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YPktFC17zEvQAAG62ag8B75yz7vhQr+3fjDaCT+wVd6zbQizy16Juo/+4MwQUJ2fX6T05zJK2xHPfY4bY4TFrC5BMUTCwBH3Ct+m8iz183qRgjLk7GpCk9HauewYqjSOXnTe607JliuBapi0t/Cqwx9zQJP7SmnvxceVVauwv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aPW7ULD9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOvGvxvt; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aPW7ULD9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOvGvxvt"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FD037A0114;
	Thu, 28 Aug 2025 11:21:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 28 Aug 2025 11:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756394486; x=1756480886; bh=aAGO+yGxeg
	gVtVq+zo0ocrY3nOOjlrhNtL2qxsZgK7k=; b=aPW7ULD9MaEUQKW1DFb8CCYXLg
	DQjM4e/nhCkh8qnAeNKpnzQdqMDEUbpuLqyfizcNcXECt6LS3uaH/WCwT5U6zeYb
	t/Qs3B6we45coe/L+/6F50KnHv+xZ0YEFSn7ahY0XfA3/QZUuCn5cM8dmdWM0hbQ
	W5gY01escvVKQ3nA6y2w53F7cmb/icXeQGBTe1WNEzoDvSjEMONRGO6vD/w+93yc
	q2z1kuLspIyouifKYIYOeOJ3xEdVZ07kT/ypQJBgJA5i7+RFDPriM/RVdYBjhoa7
	ClDOprHLWn9c4mYnXBuA3xQsXGOr3hdOx6tC3a34NrrPNOeK3ivGGtMb7h+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756394486; x=1756480886; bh=aAGO+yGxeggVtVq+zo0ocrY3nOOjlrhNtL2
	qxsZgK7k=; b=TOvGvxvt2OA7oWPdfOGv6AFq6+ISfmsGJCqMd/TxTK1lAwrrIwz
	3BmxgR6G7iXzpG8VE0I7ysSThaWA3Qsu6ImOGR7OX0w2gTCq6hmgItF+HAutx/FU
	x6w98tsieD8KOGAlA8QFnPKVw2I2ekO67dtwpCoSrAMo9BAZ/LJMB6GFEuFMxkW5
	lLEciNxAIVUff6v7yrCeOB3O6x7A5EYiH7lZFEmp7rskLnpwHewkdDJMkfi1Qklt
	VeDdUGzISPODPP0IbjWJ61okgqzTKyPOOZR80m0i1ga+m1fjZiI39tuV2JGr97Lu
	amT0osDJE14yGyp69zwfnU9EfX3ZwH2X7RA==
X-ME-Sender: <xms:9nOwaEVhT_z-Ux_Dd2ZwJNqZwjtTuhlIvPfi973aPD8JnhnciJ3Meg>
    <xme:9nOwaKGSbcajSEOjLZSWPDpKRAANir6q7ojsAGkb5tEaLKIuj4lDdKMWyodrxqSR-
    ime9IWeGFLRn8uTMA>
X-ME-Received: <xmr:9nOwaIfR5e17vt68Q-O3Cetw9DL9W-Y1pgHJZAaD6w3gg6gJbeexJbtTXGFJQpZQg6vhvGrv09WvRXU3WEB_7ZneONTbtIfKw0P8Cys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehptggrshgrrhgvthhtohesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhord
    gtrghsrghrvghtthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9nOwaDLaiQMTNIS6GEib0S1HCNWvNwsXzkMzcWZOXTT9yMDTcNGcyQ>
    <xmx:9nOwaFEbDDQTgXL1IZlU-Uq6C18aa0_3EZOyFpKZVXj6JxUhpuxUNA>
    <xmx:9nOwaOCoz22m9EhPBh_cY-Gx6jqrOUYOZsBR-yXc_PPbNMY7dH8HXg>
    <xmx:9nOwaA-CZ4pbsdMP8yb94kiV9MUAVhU9tZwSnu-CRuUeWpM7t2P0Fg>
    <xmx:9nOwaFhnTbWGKtvh_8SxVcB3tUbv7onz4P_5tFJtH5_s8QR2a1g6X0OT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 11:21:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "pcasaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Paulo Casaretto <pcasaretto@gmail.com>,
  pcasaretto <paulo.casaretto@shopify.com>
Subject: Re: [PATCH v2 1/2] range-diff: reorder options lexicographically
In-Reply-To: <ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
	(pcasaretto via GitGitGadget's message of "Thu, 28 Aug 2025 08:38:07
	+0000")
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:21:24 -0700
Message-ID: <xmqqa53jxyiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"pcasaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: pcasaretto <paulo.casaretto@shopify.com>
>
> Reorder the command-line options in builtin/range-diff.c to be in
> lexicographic order for better organization and readability. This is
> a preparatory cleanup with no functional changes.
>
> Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
> ---
>  builtin/range-diff.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks for splitting this out into its own commit.

I am not sure if "lexicographic order" fits well in the context of
"git cmd -h" that spews out many many options, shown with related
options together in groups.  I find it aggressively annoying to show
left/right-only far apart.  A user unfamiliar with the command would
look at the list, find "left-only" sitting in the list alone, and
waste time and break concentration wondering what in the first range
is so special to deserve such an option, until they see "right-only"
further down to realize that they are symmetric.

I'd rather not to see this "lexicographic" change done, but others
may have better justification (note: "for better organization and
readability" I just disagreed is a good justification) that may make
me change my mind.

What I would change, if there is something suboptimal in the current
output from "git range-diff -h" that deserves improvement, is the
lack of the grouping header before the options for range-diff
operation (i.e. creation-factor to left/right-only, before the next
"diff output" group begins).

Thanks.

> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
> index a563abff5fee..283583a80d0b 100644
> --- a/builtin/range-diff.c
> +++ b/builtin/range-diff.c
> @@ -33,17 +33,17 @@ int cmd_range_diff(int argc,
>  		OPT_INTEGER(0, "creation-factor",
>  			    &range_diff_opts.creation_factor,
>  			    N_("percentage by which creation is weighted")),
> +		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> +				  N_("style"), N_("passed to 'git log'"), 0),
> +		OPT_BOOL(0, "left-only", &left_only,
> +			 N_("only emit output related to the first range")),
>  		OPT_BOOL(0, "no-dual-color", &simple_color,
>  			    N_("use simple diff colors")),
>  		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
>  				  N_("notes"), N_("passed to 'git log'"),
>  				  PARSE_OPT_OPTARG),
> -		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
> -				  N_("style"), N_("passed to 'git log'"), 0),
>  		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
>  				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
> -		OPT_BOOL(0, "left-only", &left_only,
> -			 N_("only emit output related to the first range")),
>  		OPT_BOOL(0, "right-only", &right_only,
>  			 N_("only emit output related to the second range")),
>  		OPT_END()

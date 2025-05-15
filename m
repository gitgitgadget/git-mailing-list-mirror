Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E281548C
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336874; cv=none; b=Ix3B1zwbjtXJxJi/G146mYbUURgn9IgpmqVuCSn482YLY/0w0T0AF48STkSIACdz0B8DrFis8lWaJEVhJvbmZsvb+MMszsxcnyoAtEJ9untOpOrs0N5sYyP3pkwVPIZWL2nj7DbRml8pjm65FbAL+9H7dlq7lOPHXYn3kWO8eRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336874; c=relaxed/simple;
	bh=nRer32hDaLNokxPJ3NvnfERMPp3PeVuWxKu9V/U5Wr8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l14R+B+mmNxZsnRRJr1I+yTreypg++8naBKO95MT+e186exO4o6wDDYElA3Pd+yvsRWbHUj10BwVXhrKhATOdCzDXEmAZRGK9bj3BtQoRbjqAggc7dZYuEbCUAiCr5O+zkCijefofIMD2u8oUbK6C5b7aWIsz7/8gEhOMrpRsdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VpnD2Un9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ih58qbWT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VpnD2Un9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ih58qbWT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45471114011B;
	Thu, 15 May 2025 15:21:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 15 May 2025 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747336871; x=1747423271; bh=PZ1JUazdto
	aEl/jG/1yAxQwUtQbT8OG2wC8EoUcY7Pw=; b=VpnD2Un91UjIlMPoXWr+e0YPXK
	vgP+WgISOK7+H50lWs2PT9SpH8MF54QZ6DP0qb0oMp4mZTLsGOnhDTI6KN64FEHl
	QDRRQMb7PTHgsgWPd4WeEhPEswTa+zlmvtq7Rb31fuEUrKaWLwuwKKmx/Ztnd8ud
	CqA0uk/NVZCE2SRh64A4JTonoxcF8CBIf7jOoUUIOyyixFzGJwmDbGT4qcMyk23Z
	MLhs8FMqP9buWwQkPdyu+UtSjMvmZfXdt08DTEMgiJnF5ZRWSNjZq9+cot7XslJQ
	ocMYb+v0Enuj7bjoIMfi+G/BQoXuF+7GC4UucVrNrLwz6AwM/WiLoLHlKecg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747336871; x=1747423271; bh=PZ1JUazdtoaEl/jG/1yAxQwUtQbT8OG2wC8
	EoUcY7Pw=; b=Ih58qbWTJRQPx5C8NLu0KQcdrt3+9rAuPYzQGKTWlxzdLM/Dvux
	13ZyZn91pJ41bYQ9C05AHLbFoXZTyutYATd9x22YLgnbth/N2wEsiR2uhYFFONjx
	VcyQb7/LrxVMbPcQNhHhoWkHOa4IAzIRJ4YpRuyMPfttbDl1Rp3UL6F4twFI3V9c
	2palL2JUdNS5ZBaiGPTE3bnR+T27DIukkzaXKnzxN/n7Z282E6nrgTwceuhBrtVL
	wqJX3viKXUvddsOwZWBURRefY86WAx6VCJfJAuPRu+D8EA3I8pgttJB/kRY42AtC
	Ko3g4N2oYjH73n3PXn1cCdDWhBJwsWRRiWA==
X-ME-Sender: <xms:pz4maOEeHT2Bq9JujsC4-1D4dhz19iiM5-Icmcg-mfWmiNiTk27j_A>
    <xme:pz4maPVnhgzm30gFWoMcdqPn3Wn6_oXqW43lstPWuB9uNDoUwYkAbadjzdnE4pC4r
    zS92TuGjZMy56vQ0w>
X-ME-Received: <xmr:pz4maIK53FlTHw-3XAdpZNeq8lB06Cld-_vQ0-jP9DLSpIz6iPv8DiWZ1XcMif8HqL6Cw20WKKs_9rWSBZmW1ffx9l7MXEbqMJgnxg0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfedvieetvdfhudekkedtiedufeffuddu
    iedvieefgeffvddugeefkeeikeevvdfhnecuffhomhgrihhnpehophgvnhhgrhhouhhprd
    horhhgpdgsuhhnughlvgdquhhrihdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pz4maIE0YZbL6NzMArNpRxmWCiRPArVr7Itug5go5gdWpN-EZ5TVSA>
    <xmx:pz4maEUFv90lwxOFD-Q1TmYvQBFHZVOnmlGwp9JHhV4xAgGU__Odbw>
    <xmx:pz4maLPYkzs150XooZd8Q6SaGJ5pJ2HQ52zKI-rYeW8UGZvy_HcT6A>
    <xmx:pz4maL2nRaTrwyBR70cBqtoCdc85qbsJrVz2yymx9Tg43gZ7f3n2Tw>
    <xmx:pz4maKhl9elz-pdYN2v6Z3b9HTmxxAWvPBn3q9S9fW28twrd0Vvj0IL7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 15:21:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
In-Reply-To: <4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 15 May 2025
	13:11:48 +0000")
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
	<4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 12:21:09 -0700
Message-ID: <xmqqldqxznmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In c429bed102 (bundle-uri: store fetch.bundleCreationToken, 2023-01-31)
> code was introduced that assumes that an `sscanf()` call leaves its
> output variables unchanged unless the return value indicates success.
>
> However, the POSIX documentation makes no such guarantee:
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sscanf.html
>
> So let's make sure that the output variable `maxCreationToken` is
> always well-defined.
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 96d2ba726d99..13a42f92387e 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -532,11 +532,13 @@ static int fetch_bundles_by_token(struct repository *r,
>  	 */
>  	if (!repo_config_get_value(r,
>  				   "fetch.bundlecreationtoken",
> -				   &creationTokenStr) &&
> -	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
> -	    bundles.items[0]->creationToken <= maxCreationToken) {
> -		free(bundles.items);
> -		return 0;

The original said "if we successfully parsed and the value of the
token is larger than the token, we are done", which is probably OK,
but the problem is if we were fed garbage and failed to parse it, we
would have smudged maxCreationToken to some unknown value, and the
code path that follows here, which assumes that maxCreationToken is
left as initialized to 0 will be broken.

So the problem is real, but I find the rewritten form a bit hard to
follow.  Namely, when sscanf() failed to grab maxCreationToken, we
never compared it with bundles.items[0]->creationToken, which makes
perfect sense to me, but now...

> +				   &creationTokenStr)) {
> +		if (sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
> +			maxCreationToken = 0;
> +		if (bundles.items[0]->creationToken <= maxCreationToken) {
> +			free(bundles.items);
> +			return 0;
> +		}

... the updated code does use the just-assigned-because-we-failed-to-parse
value 0 in comparison.

I have to wonder if the attached patch is simpler to reason about,
more in line with what the original wanted to do, and more correct?

When we fail to grab the configuration, or when the value we grabbed
from the configuration does not parse, then we reset
maxCreationToken to 0, but otherwise we have a valid
maxCreationToken so use it to see if we should return early.

The cases we do not return early here are either (1) we did not have
usable configured value, in which case maxCreationToken is set to 0
before reaching the loop after this code, or (2) the value of
maxCreationToken we grabbed from the configuration is smaller than
the creationToken in the bundle list, in which case that value is
used when entering the loop.

Thanks.

 bundle-uri.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git c/bundle-uri.c w/bundle-uri.c
index f3579e228e..13a43f8e32 100644
--- c/bundle-uri.c
+++ w/bundle-uri.c
@@ -531,11 +531,11 @@ static int fetch_bundles_by_token(struct repository *r,
 	 * is not strictly smaller than the maximum creation token in the
 	 * bundle list, then do not download any bundles.
 	 */
-	if (!repo_config_get_value(r,
-				   "fetch.bundlecreationtoken",
-				   &creationTokenStr) &&
-	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) == 1 &&
-	    bundles.items[0]->creationToken <= maxCreationToken) {
+	if (repo_config_get_value(r, "fetch.bundlecreationtoken",
+				  &creationTokenStr) ||
+	    sscanf(creationTokenStr, "%"PRIu64, &maxCreationToken) != 1)
+		maxCreationToken = 0;
+	else if (bundles.items[0]->creationToken <= maxCreationToken) {
 		free(bundles.items);
 		return 0;
 	}

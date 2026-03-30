Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13F137F736
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911236; cv=none; b=vGnm894N6pzNH68QZL4LMXa5wK4K58z2PQflMO3yYKLiKAJZy5uM+3O/jPzDzAF3a33A3E39ndOJkhk11zWgmiZiPmzMS2uFiPr3aghshwJzsMoA2bzmOd1QjyKFTJAsET1bv4tZxw/+ABlzF5Xo6vEvTt1KTJqWAyKag7u6SdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911236; c=relaxed/simple;
	bh=3rLDiEvUtfcZPzes8X99XZBS42xU6iDrDmKdspRmb2E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tVhAI2xetnPt/m9v+s0UGkjT/p2V7OECDA1P06qnBLuLlkvNh72TNSuMfWXcu+Z7/zEKpDMPXTHF3ZKpJls1SEAnDRs5BPE9JBGby1o8HnYVK1ZBxcCB4qYS5l2zyOaGE9Cp7CXKZ81GQ0rBPIGBldLhkUy8t2vDRk+MYwHMNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YoGGD8D+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xMz0f5Rp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YoGGD8D+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xMz0f5Rp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A90BEC026C;
	Mon, 30 Mar 2026 18:53:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 18:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774911227; x=1774997627; bh=orEtD2SUmV
	V8IjArWwFfKXuOPwLiG/h1GIKatega1Oc=; b=YoGGD8D+ApCVs5AhQ2w3nBuHS9
	kNUmXgmRXDNgfmBfgmnnuDG7A60LAuenMjUgUO6IOFamS35loASvxTN/u7CF0xBc
	Ir7Mm8gwcor9NKdxmYx9B3+XRMSWirQawjj/PLMiubi1xMtu8dXXTB6otDqs//ra
	TySWZXI7yzg6rNEn3z1kSuN8echTaOyKui6tq+HfNmqKB2pCHmEi0MViEfj0bxH9
	gVIXAwZhnsyv1E1R2y7BKFBoONv/7LwMR7A10ci7TOTeDsF58si6jLm4myqxmZZ9
	SX50MR4IqsfewhcwB3BmxC6ofeiJrb8OyQZLIkSLrO7cYpqs3sRXHhY762aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774911227; x=1774997627; bh=orEtD2SUmVV8IjArWwFfKXuOPwLiG/h1GIK
	atega1Oc=; b=xMz0f5RpqmcnYdqLczbgK4a/FjbPkyHxf7PKi54scEKAP/Tjnhq
	QBIttCsdgfJRl/aLF9nzeffmhRwOxKtU2kqZLkccWsiVYY/0O21CqhkECxIbz4/u
	45e5AhC5fGJy556k6SGxrTDjzfkSS9P0zHUn+wnyOBjxkxKU2qZMvgz2bg1IruET
	7MDD7AyDCgB2N+RW2haggg9YU/bWe7N89t8dHiqMwFPYe9bX6aX39gFMC4smAs65
	DHLNB5nLehGLWBRFXOlt3WzT/wc/hLibHtwy8zWRdDpAHiFDI1jyVaJ+xTgm+FGM
	JyJnIy9JwDnNyFyTRgWwZBQXZToPa6uFfBQ==
X-ME-Sender: <xms:-_7KabW-SA9Z3qfo7GIIrXsABXmDH01ebPLnFI7c84R2qqM1dqPxbw>
    <xme:-_7KaWKx39Q7m5ZvhQG3vEaG9gF3xoD_rmHeXq__5WcabZfJYYC7aHx0MdeKvQfjN
    e8v18L6vaUA8O3USklhInimWAHDmLsp9TNPlEoSpSsmEWIE0Sj1TQ>
X-ME-Received: <xmr:-_7KabBnEqb8Xqt8wke7njHdNJ502gC_nvG62-VfANf9gMw4lHD9ZQDt6nD020fAg2_7I8fkP8leB06XNwP_1T9LGXRPI-aOQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:-_7KaWf7yoIwz2e5GOODwC1iLHWI1eZF3l2C58SOqmJsFkmpZUe8dQ>
    <xmx:-_7Kaa3Ev6QquGVS8cfFjTtdUaIcmLdKyS6itASITvIqoDv33Z8dPw>
    <xmx:-_7Kadjhd9eVk-BLzC1KO4RDNGvJl9Eck5urc71JFv0yWvEJiS55kg>
    <xmx:-_7KaTk1Gr9iuhuWu5Z9VQMu8EdgslphTYXZA3Egkjn37gSRItpdDA>
    <xmx:-_7KaQLdOw77R7WQHBISbzxMJysQqb_LnEFwrRQCrGsyAYYeNNJUgxUj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 18:53:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King
 <peff@peff.net>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH v4 1/6] xdiff/xdl_cleanup_records: delete local recs
 pointer
In-Reply-To: <da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774890003.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Mon, 30 Mar 2026
	16:59:58 +0000")
References: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
	<pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<da32a9747c7bde88b4fe33e43ae48c7092d57d9d.1774890003.git.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 15:53:45 -0700
Message-ID: <xmqq7bqt6i9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Simplify the first 2 for loops by directly indexing the xdfile.recs.
> recs is unused in the last 2 for loops, remove it. Best viewed with
> --color-words.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  xdiff/xprepare.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Interesting that the latter loops did not even have to have the
extra pointer variable.  Nice clean-up.

>
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index cd4fc405eb..d6e1901d2d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -269,7 +269,6 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
>   */
>  static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
>  	long i, nm, mlim;
> -	xrecord_t *recs;
>  	xdlclass_t *rcrec;
>  	uint8_t *action1 = NULL, *action2 = NULL;
>  	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> @@ -293,16 +292,18 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	 */
>  	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
>  		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
> -		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
> +	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> +		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
> +		rcrec = cf->rcrecs[mph1];
>  		nm = rcrec ? rcrec->len2 : 0;
>  		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>  	}
>  
>  	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
>  		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
> -		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
> +	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> +		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
> +		rcrec = cf->rcrecs[mph2];
>  		nm = rcrec ? rcrec->len1 : 0;
>  		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>  	}
> @@ -312,8 +313,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	 * false, or become true.
>  	 */
>  	xdf1->nreff = 0;
> -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
> -	     i <= xdf1->dend; i++, recs++) {
> +	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
>  		if (action1[i] == KEEP ||
>  		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
>  			xdf1->reference_index[xdf1->nreff++] = i;
> @@ -324,8 +324,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>  	}
>  
>  	xdf2->nreff = 0;
> -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
> -	     i <= xdf2->dend; i++, recs++) {
> +	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
>  		if (action2[i] == KEEP ||
>  		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
>  			xdf2->reference_index[xdf2->nreff++] = i;

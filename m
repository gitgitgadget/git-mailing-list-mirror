Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA85433B3
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022960; cv=none; b=h1poPEEFr7fhOCC18TS8omHUh1t08EGz9dyXrCdiE0Jbu8S9T/Z81yCsxVUlKfQOuhAIb3AMaotEhFyV5t7OihHLt417uqIBeddJyBogM7Wmtf3tOgKeVWGDLQo/NSOZh6Ok9wwN5b75QyNVcaYYKkUK4fBl/NTH2TOj5E5aPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022960; c=relaxed/simple;
	bh=h8hHDh3fFlC/RmlYyxJWpJ86bHphxDDcLZ/l9APv1Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc7AJ7Z5txBDFQp6vWjhIdGCW4w28hfwiMUftLo9qRgKKAjDdS6lXRt8oKfAkPRD4SrrCSmHFiq/fnZWd/snXIju/7nLIeMpREuzV9D20B0Wx2WFgbr7/Grrf+ghZ59Ug27TEQzPu5Sqnuh8rK9eaGcXPbGDFmF5PXkk0D31nK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F7O3okwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Un94KJdU; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F7O3okwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Un94KJdU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 099A711401FC;
	Wed,  4 Jun 2025 03:42:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 03:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749022958; x=1749109358; bh=ldN34OQejL
	fx2vDjWIaZVakwPQJS+7igUHEY1kVqr4Y=; b=F7O3okwYgvORPeH4XadMMIAoDf
	EpDyxwSePoZL+N+/Vs63ffrOA3Pvp59aFDL5KcVHkc1+f51No4lV9OGE1rNmDKxu
	kErlyYTn/IDaiae2arzrfK4YmNg2FZdgTK7jW95vSVigfouBBBEOLvBBJsHcJh3H
	1+cErgnnO5/48wXTQ0tgN5XcmjxKZF7Tms1bn9HseoGlMfLMn7phtEp57EWHSAvl
	LUQ8ra/WeJ24TUkCDlTO4Ee/QmKtQ65XH4RNcdmAnRvkPbPzkJuohACU7dExR6CS
	xmszFNW5rd5z7rcHtlh8/unVIlS9o9PvgNuPiSxaELzk8au6d5Fm4eK2WycA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749022958; x=1749109358; bh=ldN34OQejLfx2vDjWIaZVakwPQJS+7igUHE
	Y1kVqr4Y=; b=Un94KJdU9gD3pSVqKsY+U50ydNiSLlbjwlyANzEcCNNdDAs4Aiu
	slAHOYTP8E6ANVlLI0bzWsfMRFai0/9hTeDzhzMnyZMPOT5kBmMWfeyZDygN1fZn
	W5hLydb426kr1xa6DF1W4nkr5YyBCrCFgY6126m/wFtdL6IvXqrHBm+mJEF2LWy9
	iALWT/cc0JOd8PjgaYI/Wuu0OfvxR+tSNT7rDyZV+6NCZ5BVlW9+BwXMKi3yQ5WQ
	6LByNp+fNubqCW3QT3VJJnwvR5fCFWm//G2/uZCoeusqOOqUHc+VG/wkPSHh0Ic8
	Ub8Am8d9YwalSN8Pgjo4mFWMtRZWAaMFoHw==
X-ME-Sender: <xms:7fg_aPyCULKNIbBdt7Jc9ZC2-RxgRl4Nupur_eszgL3RWQo3I8HqQA>
    <xme:7fg_aHRJPNIXhj9a7fiBALVQnw9HWGuBCX8onHbIA09KMv-I9GZNlPQUWg5lNCCF3
    BHQN_c0bmjFqxeR0A>
X-ME-Received: <xmr:7fg_aJXW-fPCOYP_g9WQp1nuG2MhpHn4nHY-U1Tk5AE2viIngJE79PRgL-r5heIYQ4zDF1SunDPj0bs9ie0jgK1Dqhl6ySBdjwqP0QHHcE-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjh
    hurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7fg_aJinaaS8g6EcObg_nBqv4qRBdFIod7kQOtTwiqwa1rcltuBySA>
    <xmx:7fg_aBCw8nmU5bpDOpQZkpX-wXhuxwP9ToXueqk2g_CjxBbFmdyQaw>
    <xmx:7fg_aCLzKaapra_J3XR6_lStkpqsJE83YmLPyHjDDk-AEbE-W8n7Rw>
    <xmx:7fg_aACjQoIqWWHoBwbuyCG-ht4tgLuKjMyps1O7seuCiGbrnxXKZw>
    <xmx:7vg_aC-OwkDCiPowDe5I-UR3zf_We5GZ-hAjMhila8Mm7UDW3uyTBMRM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 03:42:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db146405 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 07:42:34 +0000 (UTC)
Date: Wed, 4 Jun 2025 09:42:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] commit-graph: fix start_delayed_progress() leak
Message-ID: <aD_46Qxh9oVj-P3U@pks.im>
References: <pull.1986.git.git.1749006675784.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1986.git.git.1749006675784.gitgitgadget@gmail.com>

On Wed, Jun 04, 2025 at 03:11:15AM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In commit-graph.c:graph_write(), if read_one_commit() failed,
> progress allocated in start_delayed_progress() will leak. Add
> stop_progress() before goto cleanup.
> 
> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>

Nit: it might make sense to send multiple patches that are related, like
your memory leak fixes, in the same patch series. That makes it a bit
easier for reviewers to group together related reviews.

> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index a783a86e797..ee48980248f 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -311,6 +311,7 @@ static int graph_write(int argc, const char **argv, const char *prefix,
>  		while (strbuf_getline(&buf, stdin) != EOF) {
>  			if (read_one_commit(&commits, progress, buf.buf)) {
>  				result = 1;
> +				stop_progress(&progress);

This function calls `stop_progress_msg()`, which knows to exit in case
`*progress` is a NULL pointer. We thus don't have to guard this line
with `if (progress)`. So the patch looks good to me, thanks!

Patrick

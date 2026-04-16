Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571E20DD51
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372950; cv=none; b=VJ9cU7Xj/kiu5U4epT2HdMbLMrQzE0ZADj7RAgclTPHzvJDiF/1M+skcMJOUaVW7WRCepglEwDA908Z47RzAV+/qsCd0plKCYgTLhBysrYePWgOZuxbjOYNaBW80sS1W0MGaTG5WBnfFwmOtmIJQO8OjCQxbKK1Apgr27NadJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372950; c=relaxed/simple;
	bh=vOVF58KhdC8ltkyWPTmKUS8t4hZFbb1LnkgyecdupUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEI49C7C4imUVYQD9qnTM6O/DzSaaAqf4pGhizviu36AGZHeUFz5YVvwrt85fdw+hgqMrtRevI52KYlTUv6DN4/IMnveAF7FGaWd66S63FAiqGFlGKqTjWzTWlK8Ul08IfattpMvvcLf580Ls5uvfQiOQbu033J6AyEEk658J64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EoWR2fVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EYE6AAOR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EoWR2fVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EYE6AAOR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6848A1400033;
	Thu, 16 Apr 2026 16:55:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 16:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776372948; x=1776459348; bh=ViSUTvML6Q
	eyI6xBLaAQzlGv6+xEhaEyvo308zfGDEI=; b=EoWR2fVKBkd+ZGSUg1YqYWRiOQ
	RGPosMWprDNWzbTLKMnnFX2lCO8Z3gkOdmIelt4VrO9Yiq3j5ekeMz+rTuu1TuUL
	aAxmbOyoyQsweDprE6Jowls/mKKk37NONAE6CGugrfO5aSWhEc9pj8Q59Gd9q7Ss
	Z2ifowgkLfz8HnLgBlB6U3qI3rcDF2v6+CdMwuvni5CPJKhfrQs+hXrF3tKJ35LL
	3aDviSLDp0M6mWSIMtlzDGkCjOkEvx4NnLnzVK92ai6vlhrVDWEAXntHyWOnPN9k
	NMyxF42JbHSlb+e7K8/+QSdy3XISlItSupwvFXWEY6bpQOaiYS2Vu4tDGU1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776372948; x=1776459348; bh=ViSUTvML6QeyI6xBLaAQzlGv6+xEhaEyvo3
	08zfGDEI=; b=EYE6AAORFtOkwrh4x+8KWlGONbpa91BI7Z/wcNLtUebFIL2FxQL
	hrU21XeTmcxdynynCKC3BrNH29tPuD9O9mk3XVtBeNY6XxfpxU/fSmFgF86o02Wm
	cBdXVtlbUP7SYZChbmPj+i+VxW5o0IyjKgrWrDxH45gD6bsTlPY4PI4b+HnPnlZc
	wnHyrUyFy60HSWqkTGZUQoYuDh/yllqLJ/wT0WnMstaNgr/17pd/rgSsSPgDfngs
	UXpwwRfYWEzRrRtJpIVPnXsPDUE2hjwUGn+R2YXEHkfFtMcTHklw1irQgS0P2G2i
	KlxFApydfE4ArkHzW9hamZNTC+anOXo3pKw==
X-ME-Sender: <xms:1EzhaV3LqIpNC838STsfqw-dwUTNI0I8xclrVyACFz3UAtwNkLyB8A>
    <xme:1EzhaS8Lfes1keJZFwAf_R5YXA4r9YWp-aYDJuYOZlmIOgEj1StrgpviO5cBcP6YX
    _XM3VHwPIUByL0psxxcoWkBYNNVI6N2L6vbKnO4WrW_SMXhjKKOvQ>
X-ME-Received: <xmr:1EzhaeOPsFDvuNXxdkN7sKNUeQhGrlTbpwng-iVDerogg9mE0jeiKQ1cHl0rOOwoQOeW6QlutnQawKmHgsEtZcIVo8ONhyffQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1EzhaedfWAG3PW4mPvUW6s98XCN83nlfacnt4YXMqfPVTav-9qK6AA>
    <xmx:1EzhaVUc1OhQy4m8nqhuf_14Ux9if_IcgS97fjcY69b8PcrPxzor6g>
    <xmx:1EzhaejHHIy567jY-b47O6iDKZXoM8s1J4tHAjBlD0FUEAXwPF0iMQ>
    <xmx:1Ezhac_V9FOHr-PN87uhn-DAkO_FYuHtWDQ8zco7IRWlZBoxW3nZ7w>
    <xmx:1Ezhac2ItMBem2hrJXztlBdWJuytL0oIQ83LFMhMkmgTXyNBkc8GPFZa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:55:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] MIDX: revert the default version to v1
In-Reply-To: <20260416200659.GB1887222@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 Apr 2026 16:06:59 -0400")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
	<xmqq5x5s540j.fsf@gitster.g>
	<20260416051732.GA48541@coredump.intra.peff.net>
	<20260416053435.GA646718@coredump.intra.peff.net>
	<xmqqldem22uw.fsf@gitster.g> <xmqq8qam217m.fsf_-_@gitster.g>
	<20260416200659.GB1887222@coredump.intra.peff.net>
Date: Thu, 16 Apr 2026 13:55:46 -0700
Message-ID: <xmqq5x5qzktp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2026 at 11:45:49AM -0700, Junio C Hamano wrote:
>
>> From: Jeff King <peff@peff.net>
>> 
>> Dscho reports that fetching into a repository with Git 2.54-rc2 made
>> it unusable with Git 2.53, as the recent code by default writes
>> version 2 multi-pack-index files.  Version 2 is the base of more
>> advanced features to come, but using it where these features are not
>> used is a strict regression.
>> 
>> As deployed versions of Git and its reimplementations may not be
>> ready for the format bump, let's revert the default version of MIDX
>> file we write back to V1, and adjust tests that exercise V2-specific
>> features to explicitly request V2.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> This looks fine to me, and you can add my S-o-b if you want. But let me
> propose a slight alternative that reduces the test churn and may make
> things easier going forward.

I did merge it to 'jch' (which I also tested externally) and then
'next', but haven't pushed out the 'next' integration out to test it
externally, so I'll chuck it and replace it with this version, as
the "compact is the only thing that needs v2" sound like a better
workaround.

> diff --git a/midx-write.c b/midx-write.c
> index 0ff2e45aa7..a89ac53045 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1259,7 +1259,6 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	struct tempfile *incr;
>  	struct write_midx_context ctx = {
>  		.preferred_pack_idx = NO_PREFERRED_PACK,
> -		.version = MIDX_VERSION_V2,
>  	 };
>  	struct multi_pack_index *midx_to_free = NULL;
>  	int bitmapped_packs_concat_len = 0;
> @@ -1275,6 +1274,9 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	ctx.repo = r;
>  	ctx.source = opts->source;
>  
> +	ctx.version = opts->flags & MIDX_WRITE_COMPACT ?
> +		MIDX_VERSION_V2 :
> +		MIDX_VERSION_V1;

Just a sytle thing but I'd prefer to see this written like this:

+	ctx.version = ((opts->flags & MIDX_WRITE_COMPACT)
+		       ? MIDX_VERSION_V2
+		       : MIDX_VERSION_V1);

because you do not have to worry about the precedence between & and
?: with an extra (parentheses), and a ternary split into multiple
lines is easier to spot if you write it at the beginning of the
line, with ?  and : aligned.


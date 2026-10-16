Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502655349A7
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175724; cv=none; b=PumHNpGwpcHFhHN9lFd8bLs8pwGPQg0TpwuFnzbwpu18Z/4H68fbd9c0d5alGIV6fdbqTFPnKPWx5pCaneuPjGiacrnF9+Eajg3mNJ1T2lI5j++em2chkK6Rt3vyLOJhStYvnyNTtHEaN10qpDzO6IEbbYAfUznaVKapyu9AIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175724; c=relaxed/simple;
	bh=0mJAqaKleivMyCdJWRZre6xTv/LLnOp6Q/PPTxg6i0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjDZUpQY8BXgKZ9i/EjUtKmPtvA9jNBi11Fmdrxmdz0QKtjMoHzaPMlcoMTagwhWHboeP6WWvhS8T9FVr4+JEak4ByhNWDpXUDCgL6yK76Fw9VPy7fbKU6RSnyvmvq/eTauP4FfaJRzPQ5SwPy4UIrpl1iml4vDZKPWhI9yt5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aY93VQd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iXK6GVyc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aY93VQd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iXK6GVyc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69B9F140012D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:35:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 16 Oct 2026 14:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792175721;
	 x=1792262121; bh=JpGUJZDot0j6AtCYwUStElFTvGptXIqCzY1QEeYl2ug=; b=
	aY93VQd/1qrKrHm45uVPoiGtdWYxdH4d6HD/gWmnUhf2toN6I/rus10pLr8zZxJz
	eIg4JT8XU8pOgmvaSbRoNxobSXsH3TKo2cnVVjiaMWIzvuErSdS/Qjx2qU9BlCiL
	JInaUreyN5m8qWi5phIO+ntPz4vv0/NZSmzlX5aw/WQ0SHtBSkrEbc+eu6x7Fz0U
	YE3t7N08uxy+Xh5MMVRD7uSBGvCF49elQJnS79c2MlQWcnm5hjbOF7i37dCSkyyG
	7fYelkm+W6Hc3tg5k5azTvDnRvxrKUQtXI7JaspxZDfBEOr1yPyKjvQBTlZlCZ9Y
	PbDoGvbpZBPHHEdtNgGeUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792175721; x=
	1792262121; bh=JpGUJZDot0j6AtCYwUStElFTvGptXIqCzY1QEeYl2ug=; b=i
	XK6GVycC1mNlpCIyE7pQNZlzPyNVU8ktx8hGVN1wxsqhO+CXqSFGMtWtr+V60cTH
	bzdO/6DdXdx24sgRna3uE0JusmuSW9KCc8WQ5slpzwDbLJHaam1WeO+JBNVDoFcP
	7xy1kCUpFF0AE92l2SJaqeQrFjEXIsZKLjbb16Yw5d3JVYa6e0yrKqHZPEIlKFl5
	+8NMnqVFKJIJmqZPZllCj7TrDBGJjaCTMa/Dp6bt5xXh2WciI+rlJXkw31enFMG3
	SPMIRsG3cN+hH2wrZGTmnVOv5IPbpUpqELYmZLPg14om+bwtw7Y/n6t92NIG30aV
	+UJtOXZEycQF9u1vf87lw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792175721; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XjdAdQ3P8yh0bufSUI3Cv5W9fuAQByREgK3CrlVtHkI54kf
	Cl0SHOsa5f+V1pv8iCjGQbF6unHn2ZVNfIIWq4L946ocbl9/+hpSzYM1AfveV1gK
	VezFerv4hgbvaFU7lla1rcZnTUvKF+MFKHXpttzN1zCwXwYpZEsUxnyAIhyWn9rE
	4SPcJMHXBkSSdd+ZXy120Cc18EUHgnUQQsUDi0tirdi48A36jS27xaHx8aqANGlp
	K4z/TGyTzsX6CNQrFmOvdjmhKuqXKb7xth2x0OZUgSn/yOeuW7xz8Rv5yfIkAfXa
	r6/Sb2C2rFiZGgRzUqHSGt5poCYKc+HHtentjLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:5q+6eNTy0c5ohdyBTdm9Z/+Gesav7fDAfyhA1geuyxs=:0mJAqaKleivMyCdJWRZre6xTv/LLnOp6Q/PPTxg6i0M=;
X-ME-Sender: <xms:aW7Sak12kzcTfpGdPf3ICluxz7x2FNzoswHFx9MO1O3z8feUtmVJbQ>
    <xme:aW7Sal9zOxZKu9dkJYNoqaP5maJkgbLBP9ahEWHSfbsNPFGdVzB8VH4H8ojg2Taf7
    3FAvNuV-WU2FEOWKWYed5se-Z_sPMknd-zfQ3i1sMUswi8oURv6daY>
X-ME-Received: <xmr:aW7SalMMnkHv8OnZJqFUgBUP7VUrGIv4Lql9dirXddm8Iu5g4CMnlw2nBQTg19cSstYKj6ul6K4A98NXY9PgswwIe0vAdNLdi0tb>
X-ME-Proxy-Cause: dmFkZTGPZJyfzAAft7A4dD+ZoseXHcsT12e0r3N51QqCHxaT0YPIanEh9Nxu+NKvN6mlFz
    n8yxuvu0PGHTL1v1VHfOzCD0MFPAIDA30S+vtK5esjJvoVO5MjLsNfri7N6FHPYJEuro8z
    0dbf4NE/ecnU/vuH+2sXKK5MkW3Ro+ZbwC/SdbVRqfPgXbdLlAJgzNsLnqyRkt8ofiHFpL
    rj9srFzHCmp0GVQ+xpOLQz+/DjMwM20r+X2h3qbUlnTLsSEw8oZM+McvW7IobOZ8fpn5nV
    e9YkJ8G3ormZRTOoULiYWEk5pChB8vm3F7W1qPwPsFqgu09h8p1Nv8g+Sk0gbeKKZTn9K1
    LSRE7kMYPII2aTDnr2LMjD0/Cdrs2l66vCqZknIumVzREBT4cSnpF9JCwvNQnzrHd85Soo
    FOjVB8MtHeuopzFdXRMR5inYzMpPFPgGSRCWl1isxgVs8E7gVRF2ydr4kfoiiaSU5lbbWc
    vXvy9nbZIQmOeG7Nu1V7X0LzrbU7moqQNMOwY5e+ioQkmUKIDIJ49TzmOIxaYAzO9x/zeZ
    F1b6w/KnJ7tbJbV9kQV5Ou1sx8rOuZQ8ZRTIEC/DdC/61jC35vO437UPxPlXTXRZeeSbU6
    fK+/gc7mMk9HCKxeKKdMi6At1Dx77lsL4OCRXlCI1mWYh7ekRNhNrm+fjttQ
X-ME-Proxy: <xmx:aW7Sapf7gstAb3bJR1jsxhY1mJ7sBsBV1fASoCkvKA1X6lu-T8Y7yQ>
    <xmx:aW7SakWGGGuBI_bgj0iIInf6pdrUgfe66hrx3SM-ft_c_4XcWGOBsg>
    <xmx:aW7SahiDq0NVTQ14ZFo0Zo72FI5ZP5BuBxoiYJLoIK-tOLFgDvRSOA>
    <xmx:aW7Saj-pJ-iRpFtabKtFCqJSni7qwgHwY_CyAZy11SWDJklPWW43HA>
    <xmx:aW7SaqWwCdslKYOeVrelH8gwIzS4-90cteKKkeBuF2Bubjj_0cB-0k-A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 14:35:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Antoni Borowski <antekborowski11@gmail.com>
Cc: peff@peff.net,  git@vger.kernel.org,  jpoimboe@kernel.org
Subject: Re: [Microproject] describe: do not translate --debug output
In-Reply-To: <20261016171835.90420-1-antekborowski11@gmail.com> (Antoni
	Borowski's message of "Fri, 16 Oct 2026 19:18:35 +0200")
References: <xmqq4ieotc9x.fsf@gitster.g>
	<20261016171835.90420-1-antekborowski11@gmail.com>
Date: Fri, 16 Oct 2026 11:35:19 -0700
Message-ID: <xmqqpkx9fq8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Antoni Borowski <antekborowski11@gmail.com> writes:

> The --debug flag is aimed at developers debugging describe's search
> strategy, not at end users. Translating this output makes it harder
> to grep for known strings, compare logs across locales, or paste
> output into upstream bug reports written in English — all things
> developers routinely need to do.
>
> transport-helper.c already follows this convention: its "Debug: ..."
> messages are plain C strings with no gettext wrapper.
>
> Drop the _() and Q_() wrappers from describe_commit()'s debug-only
> fprintf() calls accordingly, and prefix them with "Debug: " to match
> transport-helper.c's style.

Nicely described.  One nit in the proposed log message is that you
are not removing any Q_() at all ;-).

> Signed-off-by: Antoni Borowski <antekborowski11@gmail.com>
> ---
>  builtin/describe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)



> diff --git a/builtin/describe.c b/builtin/describe.c
> index c0abc931a5..775f9f27f1 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -351,7 +351,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  	if (!max_candidates)
>  		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
>  	if (debug)
> -		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
> +		fprintf(stderr, "Debug: No exact match on refs or tags, searching to describe\n");
>  
>  	if (!have_util) {
>  		struct hashmap_iter iter;
> @@ -419,7 +419,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  			}
>  			if ((c->object.flags & best_within) == best_within) {
>  				if (debug)
> -					fprintf(stderr, _("finished search at %s\n"),
> +					fprintf(stderr, "Debug: finished search at %s\n",
>  						oid_to_hex(&c->object.oid));
>  				break;
>  			}
> @@ -477,14 +477,14 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
>  		}
>  		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
>  			struct possible_tag *t = &all_matches[cur_match];
> -			fprintf(stderr, " %-*s %8d %s\n",
> +			fprintf(stderr, "Debug:  %-*s %8d %s\n",
>  				label_width, _(prio_names[t->name->prio]),
>  				t->depth, t->name->path);
>  		}
> -		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
> +		fprintf(stderr, "Debug: traversed %lu commits\n", seen_commits);
>  		if (gave_up_on) {
>  			fprintf(stderr,
> -				_("found %i tags; gave up search at %s\n"),
> +				"Debug: found %i tags; gave up search at %s\n",
>  				max_candidates,
>  				oid_to_hex(&gave_up_on->object.oid));
>  		}
> @@ -565,7 +565,7 @@ static void describe(const char *arg, int last_one)
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	if (debug)
> -		fprintf(stderr, _("describe %s\n"), arg);
> +		fprintf(stderr, "Debug: describe %s\n", arg);
>  
>  	if (repo_get_oid(the_repository, arg, &oid))
>  		die(_("Not a valid object name %s"), arg);

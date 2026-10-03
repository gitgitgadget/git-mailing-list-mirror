Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D82C11E7
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790988943; cv=none; b=pUzA1koR6ObfGYmFaaqUeOh9vl94+TUUJ6XrohiqPeVF2uZe4zRQxOoWkC0TWrTj+UgY18yPJy3mXQPJR3xOHh968dLScuii2ptFLuC39cBuBoxfXRL4GXkBGs7hFZ1nTTpBu66LWFpGd6PonUcVuXlmcWsDiKPeJOIRBYlmKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790988943; c=relaxed/simple;
	bh=aHmSw9lG04xsGogtRe4/7vTufsjw6a9TU/dAv+ASohE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANRODEhssycGWFrt7HR11xf0ht2bAxnB83xNGRoBE3EsPtQr00/62H7OZPPDJoynNZ/UI2KNdaUtpWm/WPQ/6oqFirzAlck5RjA1mHS8wjaHBV1OR5X9O2vIEcXP0X1T8tD+INI1B9K1BcV1bpLiG6PvEpXC+1pFnbP2VgsXs34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UHW9N55u; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UHW9N55u"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6defc0a3724so137043eaf.1
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790988938; x=1791593738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1zoBtr0OsMYDK5xK/ky6z06wE2Bb5Dk8KbhSXBGdhs=;
        b=UHW9N55uiiL2wMsB99QOWqOdQfhGHPHCa/+sXb6snuA8o05OoC/rtuM+p5vZ4F5KH7
         A4lmaLhPtcIXDcFMaDRfcFQp6Iu7DgjRsx+9XRIhgOyrsuBrzZk3A9t4TXfHIayskzKV
         OeOweqoMTJs4xfHqOWNHeFXLyneu1ISPSLM+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790988938; x=1791593738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1zoBtr0OsMYDK5xK/ky6z06wE2Bb5Dk8KbhSXBGdhs=;
        b=b4oNo7Hz8cwwJV+IfvQgo1aTcP8fEba7JtodVjVh+CBih1Up1Svv1VU2JvBNc9XLVE
         OKJxXF4OexPcYzYYkIiSBXRn3XAdynllhNg5SVKOHf7Bwk01C2hVu220oS7eAgOr07HO
         bycfCKXSNt3kPcckl7CnWgGY/wVdRx+pld/38XotjZuIZM11hM39kIZt1nPdQF3lWUk1
         3qUn9uZcXWDQehMZPgXectQc/sXS4TfpX2iARYfuQiig8wapNJ7HHBD1kT6EUOMtoQ4g
         v5aYM1NDqKAHK9u/z/hUku3Cca8oih2RyZu02Zs9RLJEWYHzX53Y3rwQRyNJKzSSTUwU
         2FkQ==
X-Gm-Message-State: AFuF++nsc3SQ0ahmIpsUyEAZtGjvNI1l2bfmUnNchDpX0KDHqQ8D/Yo1
	xmG+QDtc2G9TtE1C19uWLh3ZDmKN5JWiXyQtXeRSD/tAiZm1bBRvsPJamXT7pRdBG75D8MmhgpO
	I0iK1kHo=
X-Gm-Gg: AYBFou1PvCHO8dPEYmHNd3emmQiANyLVFT55r2DbKzMCvRfOqbftoS4myW5QI+SkQHZ
	IVjBmzD9CzX4RMn9ufIa7/CVEPUfTfSTzWMwbZgilTlUSbQqVR0RgMqq8E31IHqlWhuIRlZYO/O
	0KtCYDRWc0q70L+zrdz3f461/2WyKJgJvVQkEgk+44EU8feNPYrxpwC/PLCJZZMSD6EzR2BEn6g
	oijmxV6xSPFyD67yPcKTYMAI4tIrFD4mSRSm8V/IZ/rHeySwET65tQQNHu+NfPG02WCUfpA7CzU
	7pSW6ZwIXUr1BzkFbxr/bN9aCLxa0DNrQtB58zlyFLYPR+Wms1a9gVbHneRyeGXC5JcrPM9UWoc
	3pVMrGvniTg8gKzqBM0mOF/pjfm8EbjQHZx5Zs9b/3RFRbpQDli7MtIke+JpcH3Cr1uvGl0FxKo
	MuvPVOR5vDTQO4+fQqHuIKGrTnkvkznUJ4GT1ZfEli0DKad6cBn8IbulISwZgepOSqcI2NSdnsN
	28MpVq2Ehy0RdxQIMHFVtw9cxWsBcMC1W/rV+6oI5pp3tIRaW552CDRnKX9kIzpHY4zo3OPOmJS
	6nqea3DQcoubTw==
X-Received: by 2002:a05:6820:c3c4:20b0:6de:aeea:5c90 with SMTP id 006d021491bc7-6df33c96e7cmr2590983eaf.26.1790988938563;
        Fri, 02 Oct 2026 17:55:38 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df3afab7adsm3928847eaf.10.2026.10.02.17.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:55:36 -0700 (PDT)
Date: Fri, 2 Oct 2026 19:55:32 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 2/8] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <asBShFkQRWJX4RQU@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <940953e5c407046ac6789367f3341dc8ea73d07a.1790827875.git.me@ttaylorr.com>
 <20261002231336.GB834759@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002231336.GB834759@coredump.intra.peff.net>

On Fri, Oct 02, 2026 at 07:13:36PM -0400, Jeff King wrote:
> So it would have made more sense to me to comment it there. Of course
> that is hard when there are two such places.
>
> I dunno.

Yeah, me either. I'm happy to change things around if you feel strongly.

> > +	oidset_iter_init(&ctx.extra_roots, &iter);
> > +	while ((oid = oidset_iter_next(&iter))) {
> > +		struct object *obj = lookup_object(repo, oid);
> > +
> > +		if (!obj || !(obj->flags & SEEN))
> > +			add_pending_oid(&revs, NULL, oid, 0);
> > +	}
> > +	if (revs.pending.nr) {
> > +		if (prepare_revision_walk(&revs))
> > +			die(_("revision walk setup failed"));
> > +		traverse_commit_list(&revs,
> > +				     show_commit_pack_hint,
> > +				     show_object_pack_hint,
> > +				     &mode);
> > +	}
> > +	oidset_clear(&ctx.extra_roots);
> > +
> >  	release_revisions(&revs);
>
> BTW, is it safe to prepare_revision_walk() twice on the same rev_info? I
> could believe it works, but I could also believe that there are hidden
> corner cases, as I don't think it was ever really intended to work this
> way.
>
> Maybe OK for the vanilla set of options we are using here (as opposed to
> taking arbitrary options from the user). The rev_info is created locally
> in this function, though, so I guess if we wanted to be double-plus sure
> we could release and reinit the struct.

It seems to work in practice. From reading through and thinking about it
I couldn't find any obvious issues.

Just as well, there are a couple of spots that I was able to find that
already call `prepare_revision_walk()` more than once:

  * In builtin/pack-objects.c::get_object_list() (with the exception of
    '--path-walk') we call `prepare_revision_walk()` twice when
    exploding unreachable objects as loose.

  * In reachable.c::mark_reachable_objects(), we also call the
    `prepare_revision_walk()` function twice when given a timestamp via
    `mark_recent`.

This all works since `revs.pending` is emptied by the first revwalk. But
it is under-documented, so callers relying on this behavior may be
surprised if/when it changes. Probably good #leftoverbits.

Thanks,
Taylor

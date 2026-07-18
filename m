Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E343F08B
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784408566; cv=none; b=GtTgrZnVhsVwXDvAyKebVWprRb8/F9/ylwexq4nd4vY+0e/RQ/5p/ngS6kpNzMPzvs8oS9naV10B/pQasTxKd3oyG+Z2mglVNQTg4sQ7fFIYPXkhyDrp5Y+FLNDKVmuYIKi8cG383Dv80FltsQvF54PJ3wKAALBgUHe85McNyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784408566; c=relaxed/simple;
	bh=8GtrqrKdksLz++m/VfilsmAH8GleS7qVmy/+DLzxlZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zdk/7cS6H0d2VcFmxjyyaws+iG55swXzI5ZpbwEAi1M/6r5gqv/9mVw3/8k722cJ78SbvfSufZ1TuRWA0P/FFzQuOx821tFyMmGxkt/ZVctPqu4Tre2QdHaDAQ6v7e4bqMnJniNJpIeVBRk1Uc2eZbuDdDchwEcwWbpaFdlnDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PmeJboJW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PmeJboJW"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80e24970f1dso43183877b3.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784408564; x=1785013364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rv+v4Ny1WXVN2ZhW9KCq1HztX4U0A5p25VwrTg6Svew=;
        b=PmeJboJW424pl4wQgda5S/0kiHpKjQVS1n52N4nBHJ0yjgZaTAQNHghILSJ63cewab
         bJBVv9HEMP0o+gJugXDLcrxL+RIFRXYrCV4CQkrQMwvnf4KSius/1gsOeSLcGNA2hHCC
         asO7eN0DTxQBOHzd90Q9KLz/CYavItk43rHmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784408564; x=1785013364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rv+v4Ny1WXVN2ZhW9KCq1HztX4U0A5p25VwrTg6Svew=;
        b=aPu/zs6O44Tno/sDLSUoy7QTfY16fO6ZabINLf3p6NAdhHSFF2qRHsV72q6cxBR9WD
         VlWxS9K5vrtvpSquqEMV/GeCfhy0te8Ntr7l9C5irmiO08hMIPzZ8nPTUAz1fLuxg/mJ
         mcrwnd1beKABedmT5ZQFS7eDb1Q1Abp1tFnryD+5Luk9HLoiCvA+vXS1A5UsPHdfl4R4
         SBO3WomECY1AZaZC96Hn5g4a4M56xc1SvvgY38T3k6j5fxHqzWABWDBRrDkDnETCq9VV
         m5EK9loxBkHNvDi7ma1aKxJLD3XTIJaW3+vDs8H+NvWd0UrRHWHs61VxtbREY7NJnmVO
         5gzQ==
X-Gm-Message-State: AOJu0YzZ5c/gKCPF5SVaFLoYQkholnL6soiVBOw+MjHuavARR5I/q+hy
	v0WNxSgL9O35MO388EDk4sEt3kphfT7ReHwlTbZsEktiCvT0SdUSnrKrMLfGwdI6CSIT0HZcgtT
	bOr5olp2eFg==
X-Gm-Gg: AfdE7cmcJ0PY9R68uUsR4nEyFuX7cRhduyCTpTzIrv2O+C+bR/AvyPsM8O0IKM+lJhe
	UnPw+75PnIPNpL0v/xjrg2IBvx4n4nJawtrJAnQj7U/narqkYw1l//o5DMYEFk5/D9wdPFZ90HN
	IszUE2Ia9MEkRoLP+KkhuXYzzWEm76L7feA/1Rz+IeP1S0Uj12hJebGi/wET6i4mTPK6c2XxwnE
	cNgNeaER1H7Hqw92Bz20AiR7jQ6yq2xrW/u2oOibDaxHuLD9UyvPKEqh+0a5ncLuyaC+gEK1H8Q
	G7TduTTrtn3Z5Z5e50/+4+14i8JiqomzRPqYj5yHrkzAKjUjXcndDnRrR31gVQyIXidDLL7yH0v
	YOQ55Bz+AcYCc7ulDyN3yCUVhkIluD8EhjlRdpQiu9jvbFRlMpIb5RSpv54e+SY5BOlKGo6bPkK
	y2tkqddnAc/rv4X1yfqi2xKVfyyHjvtZMJV3c9mmllCo+n+ebaRCb3IUHGArk2y4CC1lHIsg==
X-Received: by 2002:a05:690c:c4cd:b0:81e:4aa9:d02a with SMTP id 00721157ae682-81ef22c9b1emr29178697b3.6.1784408563734;
        Sat, 18 Jul 2026 14:02:43 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42be12csm34937547b3.36.2026.07.18.14.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 14:02:42 -0700 (PDT)
Date: Sat, 18 Jul 2026 16:02:40 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <alvp8KsZPKqCyqma@com-79390>
References: <alQ7U8TOWjhasaWk@com-79390>
 <20260714074506.GD4058320@coredump.intra.peff.net>
 <alaxDPps6mg32C0g@com-79390>
 <20260718090527.GA30873@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718090527.GA30873@coredump.intra.peff.net>

On Sat, Jul 18, 2026 at 05:05:27AM -0400, Jeff King wrote:
> On Tue, Jul 14, 2026 at 02:58:36PM -0700, Taylor Blau wrote:
>
> > > So I have the feeling that there's some ulterior motive, or that this is
> > > part of a larger system, but I don't quite understand what it is. And so
> > > it's hard to say whether this is a sensible approach.
> >
> > The implementation motivating this is write-through in the sense that it
> > first parses and spools the incoming pack, then replays those exact
> > bytes together with the same ref commands to an upstream receive-pack.
>
> OK, that kind-of makes sense. But is that intermediate layer not
> indexing at all? As in, it does not know which OIDs are present in the
> incoming pack?

It does. The receive path computes object IDs while ingesting and
validating the incoming pack. The index I was referring to is the
durable index for the stored pack, not what we would compute in memory
during receipt of the incoming push. That durable index is built
asynchronously after the push is accepted.

> It sounds like you _do_ index it based on this:
>
> > In retrospect, I don't think the cover letter distinguishes this well.
> > The pack that we receive over the wire is stored byte-for-byte as an
> > immutable artifact, and the per-object physical index is derived
> > asynchronously. That indexer is designed to operate in a single pass
> > forward over the pack.
>
> So I can see how REF_DELTA makes a single streaming pass harder. But can
> you actually do a single pass even with OFS_DELTA? You'll need to look
> at earlier bytes in order to resolve each new object. And possibly
> recursively. So you must maintain random access to the new pack data,
> and you must maintain some kind of in-memory structure, at least for
> each delta family (especially if you want to avoid re-generating deltas
> over and over as you satisfy a long chain).

"Single pass" here means one forward read of the pack entries, with
random access to a disk-backed store of already-resolved objects. But...

> I.e., I am having trouble understanding what makes REF_DELTA more
> expensive than OFS_DELTA, either in terms of random-access to the pack
> or in terms of indexing memory. It's more _complicated_ for sure,
> though.

...by restricting objects to only be encoded as OFS_DELTA, we can always
load the base object knowing that it has already been processed. That
trivially permits you to avoid holding the entire pack in resident
memory, since you are able to look-up the right chunk(s) as needed.

If you have REF_DELTAs, the story is much more complicated. In that
case, you must be prepared to keep unresolved deltas around until the
base appears, which may be very far ahead in the pack. Alternatively,
you could build a map of pack positions by OID, but even in that case
you have to keep a pending work queue to be prepared for deltas whose
base object we have not yet seen.

> That doesn't seem all _that_ compelling to me. I think the more
> interesting thing is that in the worst case, a single REF_DELTA can kill
> your pipeline entirely (assuming you are trying to do as much CPU-heavy
> resolving work as possible while the pack is transferring). Imagine a
> pack like this:
>
>   0: REF_DELTA(abcd)
>   1: OFS_DELTA(offsetof(0))
>   2: OFS_DELTA(offsetof(1))
>   3: OFS_DELTA(offsetof(2))
>   ...
>   N: base object with hash "abcd"
>
> You can't resolve a single delta until you hit object N, after which you
> must then resolve each of 0..N-1 sequentially because they all depend on
> each other.
>
> The problem there is not REF_DELTA itself, but the fact that REF_DELTA
> allows you to place a base after the delta which depends on it.

Exactly.

> If _that_ is your main concern, would it be worth a tighter capability
> advertisement that insists that bases come before their deltas (if they
> are in the pack at all)? We already generate packs that way by default,
> and it would really just give the server a license to reject these
> non-standard packs.

That would address the ordering problem, but is weaker than the format
restriction this receiver wants. Even a backward REF_DELTA requires an
OID-to-entry lookup, whereas the retained pack's reconstruction metadata
is addressed by offset alone. Supporting that is possible, of course,
but adds another way to locate a base.

> But now I'm about 3 levels deep in guessing at your real issues, so I'll
> stop for now and see how close I got. ;)

I think you got pretty close ;-).

Thanks,
Taylor

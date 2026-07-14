Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304F42BE95
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066322; cv=none; b=aKawOvE3oUPekDKUBXdTRGSyZu6ZaoZu1rxAEn/inB4Yd+0H0+FntXJvRvMhapHU58PGwrSRzrTVIKkw20HTWJFvD2wspDfkvEIyhXBCcn5hqKRLe27ayVTP/srS+9IEn3HqPIm5x7Y82Vu0Bv7FyhJOhcMawDW3M64eQ7G7CYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066322; c=relaxed/simple;
	bh=Fj9HghccAhE2TRPztkhk00qd8Qk7DiDpLbN0tWgWoiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG1dXg9ow/sTNwzPDWHybUsN0nokolDhFzeUssK/ZbXqx9w1ispwxSJgNPMBUycQcIBkhXt7XjiC6kyJ8DUKDtywG2GUuZsdNEAziqHiUlWAaAOXg3G17wp3AF+3HgOS9mF9bd2+U0FWsiSVMP43ASCmCl96b+Ph4RJtPbRRKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bvtq457f; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bvtq457f"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ff88549786so58286626d6.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784066320; x=1784671120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHWVCp4HoeNzEZnlYxqhuQCF1/bzmE0Yd5HkogzXGgg=;
        b=bvtq457fWk2U/af8Fu5d0gxhRKVrOQbhSFoDg39EwlFZP3flXv/OabsI1i0ZBPCEaW
         QXpTqVT2k8TIaPgD6DOSqeWToXiu2NFs5DiPXr8SKIlJyeL1O4B+nYQqu566XJYAbBAY
         KhdbRC8aafS52HkbIwQMm4ynwrrmI+T+naH4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784066320; x=1784671120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHWVCp4HoeNzEZnlYxqhuQCF1/bzmE0Yd5HkogzXGgg=;
        b=f3YFfoUTyiO1MfBj9DWwm6Rsb/hA/3Z2BT/j/4FwJm7zbPdU/P23vW2FHdPNQ1YxKk
         1kFISUciZ4CwLYbsDYIZgVoE5TJAiXt53kQiWafZ4PKX8VwBqSCEnDwgsHJiyYyhm+jU
         YzrWooo8IlDv2sLH0ZjaYh6Gsyyxd0iMwer0OCT9iFxN3r1DmT7j9Y6XHEfVSvhwZH7S
         h4icy6ZnbqWOphzG6zjETDqxwVHDhNEnSEaMV7HjlRd6WInjWvJtQEhaF+YK2thHShfN
         kPmXuwxXif8h7g93ZkmTjtYrjZr4tw6/XuiScfvyFI36I/O6u8wbO/d2lyT8VnB+m0LL
         SZKA==
X-Gm-Message-State: AOJu0Yz7AOCEWfvisWdEoRf/aiFGhCqJJAR9HuTfuvQ99ui1m3dxzsQW
	/8ba4Z1pw9mUX8AIR9QP+w5ROj17XCaIjN/Q1AZVtRJhJVEaHHCEpWXYxVtj9QZjzWItJNUuawV
	pp51+NuDQBQ==
X-Gm-Gg: AfdE7ckT3QoojaUqDTMvzIMQ713G8dEtBNZiNHL63sKos7pmLYdlcy+yoUQj16PNYXy
	dVR/0JdYy/fPr0JBu2EAtEeKJD87WZ9dSgI+Jg+rPJk2f6vb00ov9EC0mcaF+LH/VmKx/EagMtz
	+CxRqYJ4TiMF8zzw+1d+B7CYd47dA8DnsCB/t1f5wUQZUFJkX/ahnVAYdvJwB6a8mLdUWL+gXRb
	CwFQ7YhBafd4xXuSgZFgbDbyirbrFLPTyqXQ3F67fVo0DOCNez0qY8eFO+g6XuRlluUvIgmqPSM
	OOkUNwV+Zxfi+kd4VP6KdllaLtIQ+iuwQKeDpdvSi1rCR9fj+zXcEDMK4A478jXosS72oVBvxAh
	txE3kv4gbydZcnyRZOQr2tfmXTUGnByXm/53FWAG1M7liQnlNqHzcdPDq59bnQf0bWGKBn521ab
	r2Jl7dNN65Klxn0NS+tUnoHQMu
X-Received: by 2002:a05:6214:4b0f:b0:8e1:4508:ee58 with SMTP id 6a1803df08f44-90758df60e3mr4793556d6.40.1784066319993;
        Tue, 14 Jul 2026 14:58:39 -0700 (PDT)
Received: from com-79390 ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm179184356d6.19.2026.07.14.14.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:58:39 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:58:36 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] send-pack: introduce a `no-ref-delta` capability
Message-ID: <alaxDPps6mg32C0g@com-79390>
References: <alQ7U8TOWjhasaWk@com-79390>
 <20260714074506.GD4058320@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714074506.GD4058320@coredump.intra.peff.net>

On Tue, Jul 14, 2026 at 03:45:06AM -0400, Jeff King wrote:
> On Sun, Jul 12, 2026 at 06:11:47PM -0700, Taylor Blau wrote:
>
> > Some 'receive-pack' implementations may wish to retain the incoming pack
> > without first building an object ID index, in which case requiring delta
> > bases to appear earlier in the same pack makes them easier to locate.
>
> This explanation puzzles me. OK, I can see why you might want to take in
> the incoming pack and then sit on it for a bit. But surely you are not
> going to update refs without seeing what's in the pack, right? Otherwise
> any pushing client can corrupt your repo.
>
> And the only way to know what's in the pack is to index it. At which
> point resolving REF_DELTAs is the least of your worries there.
>
> So I have the feeling that there's some ulterior motive, or that this is
> part of a larger system, but I don't quite understand what it is. And so
> it's hard to say whether this is a sensible approach.

The implementation motivating this is write-through in the sense that it
first parses and spools the incoming pack, then replays those exact
bytes together with the same ref commands to an upstream receive-pack.

The packfile contents and pending transaction may be staged before that
upstream request finishes, but no local ref update is published unless
the upstream accepts the push. So the usual receive-pack connectivity
checks still happen before the update becomes visible locally.

(Apologies for all of the hand-waving here, BTW. I'm trying to describe
the system in generic terms to make clear my motivations here, but I am
somewhat limited in what I can discuss.)

In retrospect, I don't think the cover letter distinguishes this well.
The pack that we receive over the wire is stored byte-for-byte as an
immutable artifact, and the per-object physical index is derived
asynchronously. That indexer is designed to operate in a single pass
forward over the pack.

(Supporting REF_DELTA there during the indexing process is possible in
theory, but requires keeping an OID lookup around, delaying resolution,
taking another pass, or rewriting the retained pack. This design avoids
all of those.)

> > Bitmap pack reuse is different, since it copies entries directly from
> > an existing pack. Under `--no-ref-delta`, it must inspect candidate
> > objects individually, omit `REF_DELTA` entries from direct pack reuse,
> > and leave them to the normal object-writing path.
>
> Hmm. We wouldn't normally expect verbatim pack-reuse to kick in, since
> this is about the client sending to the server. But OK, we certainly
> need to make sure that path remains correct.

That is an edge case rather than part of the motivation. It is only
there so that `pack-objects --no-ref-delta` means what it says even
if/when it performs verbatim pack-reuse.

> >  - The final patch advertises and consumes the new `no-ref-delta`
> >    capability.
>
> What about thin packs? They'll result in REF_DELTAs on the server once
> the pack is completed/indexed. I guess we have the "no-thin" capability,
> but I don't think our receive-pack implementation support sending it. I
> also wouldn't be terribly surprised if not every client implementation
> supports it (it was added in 2013 I think to support libgit2). But I
> guess that is also true of your new no-ref-delta; only updated clients
> will respect it.
>
> What will/should a server do when they get a ref delta anyway? That
> again goes back to the question of: why don't we want ref deltas?

The implementation in question already advertises 'no-thin',

A sender honoring `no-ref-delta` cannot send a thin pack in the first
place, since an external base must be encoded as REF_DELTA. `send-pack`
may still invoke `pack-objects` with both `--thin` and `--no-ref-delta`,
but the latter causes it to skip excluded bases.

Older clients may ignore `no-ref-delta` and still get rejected. That is
already the receiver's behavior. The capability just lets updated
clients avoid sending a pack which will be rejected.

If a REF_DELTA arrives anyway, the receiver rejects the pack before
publishing the ref.

Thanks,
Taylor

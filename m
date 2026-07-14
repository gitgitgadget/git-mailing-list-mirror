Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE732C11FE
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001541; cv=none; b=h2FJuc8/3KvtZAaxYmkgYdFJ6ISt09ROLfGgdhjRgw11AAzFbHMs9VYod5w0pQWPKCPu+s+ubxv2IsyVTZr66nPkA3oFUcsaKyElrc70TGpfh1gphE4YVK3ITkVCnphjJcrGwzXPxNzPiSfdSeCPZ2qmWjWIJprtpUkJfIOznF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001541; c=relaxed/simple;
	bh=Se9zprCCU8Ucw/qwSwhYNWiviZGpJocYcx6LwZkm1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/81uDxlR5iQWXVZzg2JYC1peqdPQSpcpeyar+OBgXMQtoOwYM5OLa4AT2Oq3ACWjvXMaMpktvMb2L/whOQG77vtV1JfVXVP17Y6KPwRnOm7/Yhi753o0S/h6wYJOCqY54bIBJrvxOULV889Z/544cfl1M4oI3fZhwtkbz28sQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=aFlXNWoY; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="aFlXNWoY"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92edb12cdf2so33123285a.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 20:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784001539; x=1784606339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Se9zprCCU8Ucw/qwSwhYNWiviZGpJocYcx6LwZkm1es=;
        b=aFlXNWoYQWFn40vmKFoilf7WOcn/hKaJXdDGm8ODTCDIUfwaLLuOYX1RU+3adfwIwq
         HkUlmd5LAUw0DVt1KoApDyFjQI+6ALMHGr+soREbGOE0WDa5XO/bHWWN+UpmflL3Gh5g
         DMEQY9njH7M6eiaKe+/FOh8HCKiOUB3BvGjX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001539; x=1784606339;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Se9zprCCU8Ucw/qwSwhYNWiviZGpJocYcx6LwZkm1es=;
        b=hm1Xja5PVEcaqk6vrHnbadzegMqHKOqETU0ezjSyVBl/ygmve6JG2A/i0xIQTTgQO6
         8qqKrsQnyKWycSCLmm8pDXzCiGXki5PNlfevWHAN5d7e75BMSRPYU3L2oJU8eI7tzqHN
         ZWpZrVPK2t2H/IjUx8fhvFblGMuZDIQu8xOtS8n6tkB/7enUBwxYfmm1cLFNatG/adoi
         yWi+PNEmxQp22tnm0RVCA6lIvKn4P2LGRGE5hbww+y6NQuCHe7YiCj7iuY8+jCdeV7VK
         5gFW+ABiGhOwLYywaIhcRqBNk06eKuIcvMDirfGbiB3qSwqkZ6TQtY+HcYDipM1qlhUi
         kJEw==
X-Forwarded-Encrypted: i=1; AHgh+RryPoZ72oMxvGoAQJOylpyieiPK0dlZAEYXZoj6m/fm76/UH0S91+MNDGQFxbNhqRAiZeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw915CiFM8Qnkuy3kf94D1TSaWF3yfm7EnLxe8VxPfu5EfIIfrc
	He1hMmc84VO4iLZxrgcfvRuIR5QfiZbAitQqoOTI24fP7WPEjMjD47ucreG32EYVnlQ=
X-Gm-Gg: AfdE7cn+ukpONYbKjwOKyleh8ATTX79uxIMAJx19dJ6hRfR6A8BwoKdBufpIrbQCH5V
	wRM/bMrwT7mM1c04AJ2So992rgz93UlCOgvGMgsvq46pvz3CgzNR6hRVm3Knh6OjAyVECU4UAkz
	edT3UNSI0OMsB6NDNPYTfruyCdKP+mAQbpfMlpr8HhHhqnm57AJ/8uGkv19JSKMQXmL8dFAWEN9
	JupdJ2luEgnAczcvIXkWYZksk1nlwBuW3tTh35sZk3ag5H+58NE5Gfewl3M8GdYGahIl31pbsel
	L9HRAKRyFgVqq4AL85D/pHBQdEKwc28K0QEkodYy/afhVefm+Y6ewCqF0TXzNW1Mh3FWJIvlJN4
	PTtJM45X0neL6bByNe7/sg3FJk1WwBD7bS55EYeihZcHwpcJ8WYo10AXZ2Z7hSvQLESIJkADe5e
	km16Diq4ieameLfn5lYJw4qQ3vI7stI3ZP4Wk=
X-Received: by 2002:a05:620a:390a:b0:92e:c116:befc with SMTP id af79cd13be357-92ef2f72d80mr1163052885a.89.1784001538850;
        Mon, 13 Jul 2026 20:58:58 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm1343387685a.28.2026.07.13.20.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 20:58:58 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:58:54 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of
 bitmapped objects
Message-ID: <alWz_gRs_D0Y0aOy@com-79390>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
 <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
 <alFzja98avOoKjQE@com-79390>
 <20260711080114.GA1470749@coredump.intra.peff.net>
 <alS1rus9thie7NiE@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alS1rus9thie7NiE@pks.im>

On Mon, Jul 13, 2026 at 11:53:50AM +0200, Patrick Steinhardt wrote:
> On Sat, Jul 11, 2026 at 04:01:14AM -0400, Jeff King wrote:
> > On Fri, Jul 10, 2026 at 03:34:53PM -0700, Taylor Blau wrote:
> >
> > > However, the remaining `show_objects_for_type()` callers from within
> > > `traverse_bitmap_commit_list()` do *not* bother to inspect the return
> > > value, despite taking in an arbitrary 'show_reachable_fn', which itself
> > > may return a non-zero value.
> > >
> > > I guess this must be effectively OK in practice with respect to the
> > > existing code for the same reason you indicate in the commit message
> > > above, but we should change this function to *also* propagate non-zero
> > > return values to eliminate the foot-gun completely.
> >
> > The matching non-bitmap traverse_commit_list() does not allow aborting
> > based on callback returns, either. In fact, its callbacks return void!
> >
> > Whichever direction we go, those two should probably stay in sync (so
> > either both should allow aborting early with a non-zero return, or both
> > should return void).
>
> That's fair. But adapting `traverse_commit_list()` requires tons of
> changes all over the tree, so I'm inclined to rather leave both
> `traverse_bitmap_commit_list()` and `traverse_commit_list()` as-is.
> Does that work for both of you?

I think that it's fine to leave it as-is for the purpose of this series,
though I would like to address it.

I don't think we need to adapt `traverse_commit_list()`, though. We can
go in the other direction Peff suggested, which would be to split the
callback type used by `for_each_bitmapped_object()` from
`show_reachable_fn`, keep the former abortable, and make the latter
return void.

That keeps `traverse_bitmap_commit_list()` in sync with
`traverse_commit_list()` without changing the non-bitmap traversal
machinery. I have a small two-patch follow-up on top of v3 that does
this, which I'll send separately.

Thanks,
Taylor

Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF32248AF
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790989262; cv=none; b=mdUHJ/tYUzLbVcXScM9tBuwYRNhwjUkyH9MvUxlTMTS9tFR41169+8ugVNKpTpA+wpJD9Zh5osik2uk/A0Eakh2J8qnIQWh/ybwKGtj/UDrSF6Iok2mNdSdtPITb+Bs500RQ7G8/rC+6xP6dvcnBa902A5FrTQ/DeaUsPZhEWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790989262; c=relaxed/simple;
	bh=j7xV978IHydXxBF3u+kuX7qUySfIIiVp/H1MBbyJrjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoYTW8XcDcihf0vgUyE8bSdTmte7pHOM9Bvi6HGqJAdLMjt9WblxDIubQPvOQwicNq5fDHrtai0CgNHo0VaMSMVG9a2wnulNNENNUo/eELrlliqnmGhgL2f7NiSzbp8xfni/ZqLTRMyPuw3IOKNO0jkZT2PbcChFg9OB9UIPlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=H8dA4seg; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="H8dA4seg"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7dfso377318a34.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790989258; x=1791594058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MR7FPm+bup/8kPQkrmOcyRJAVlWDQF6gKRdxZ0JGx0E=;
        b=H8dA4segojap5t+ku7OEIsg+xVOTRu3voo9cgPJf2WUhTUiIQvm0mT440o5Bvrgzkv
         U+qqpIgpVWt62VcP+5vy7NMf37Wmzi7Z6f/s5zHX3mClsdTO2YqZSrju+7MllRtAKepW
         BNDZb4wLJ3jAzwqZCM06ohAB0ImlrDYsOQwVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790989258; x=1791594058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MR7FPm+bup/8kPQkrmOcyRJAVlWDQF6gKRdxZ0JGx0E=;
        b=PKFxXIbPhxsE6f7EcMz4EsmozKUzVXCp352THHHJmBwC6Mdnps+UMswSKGHHrmQwWz
         bcApflKI+1LdTRUFplq9/07Djh7ju0QE6NLNn6YgDZ2kDLrojSVVSxC//WItOHFmdwcJ
         4LFgdcZZHv4OpEd9WzpQ+U/ZXt3P2GB0MJ0wbV8qUSt98QowIiRbsa3XlT7692Po9cea
         SB2IFH/64JGFWTqmTywI/1qrncdE3SkG28z80RMqxbrFDLOdjkl8/tzwBW2FUJfm4FgK
         FJ7lFLfRLbObszxWvcOBVY79lV6Y4AQFvABNGyoJvRyg81Lqf7eRfAziWuQs7IXKjCeo
         A3lQ==
X-Gm-Message-State: AFuF++nSCYI3YyTj9xqMg+NFRTVD3OjaLqbAXaPpGaisoQ6HLx8fTPAd
	iRlCaqb7carterWH95Ftjci8sVMup8Zby9pmaYCUQSqk+nGcpdBGGhPEWH35lDqNnJ4=
X-Gm-Gg: AYBFou2RcQXOJdGYDshwCUuH2//9Q2+naLdhAc2e517F8+AnJhpnqp3srRD25Upz3BD
	zQQWK7vNzmaHnDarR/1yqJgF81JOg+rTJOPL/v/rRBu43FONwAupPLCQ4pP0k2IvtiHiY0QMIrY
	/DN0Z1I1Pvu7bGlTLpygl7lVuYVK5yj6uDo0oRYrGQcY5jVjlpE36COYqbmTlxls5lQhkxDQcaO
	8E2ua9EDmKeHQGlzaocG8MCutrIG+ts7WNZknHDcARcmAyr7lzMUO9U+rWav8+8Lcxpd56pzCxC
	JRlxbaqUaQdndoX2wYowToULpiXFPJlXKFD2fxu67cLGs/Ss69VYtRub7JP6pDjdOKr2fHb7IkO
	OizjqZKIzaltoTiUyNOpxk18EEESRSeS4XIAutv1GXcJeC+9MNo5pc+eYG11JMiJ/gTBharKNMg
	FKZED0O4OOAX7ShXQOA+d4m4Skf6TSKZSZXAlKboZSBF9FbXlMY+TX6tCSttKcXEff7NLBxuOA3
	f6e/6hbg3VHX26leI+VwKv0vlfOUkFmLhGLet4JW6TtGc7CRr8Esw8F6JcpOxkMI7yaXTGM9umw
	ar/TriAm+n0iGw==
X-Received: by 2002:a05:6820:a0a:b0:6b9:8413:89b8 with SMTP id 006d021491bc7-6df34b73393mr3434626eaf.57.1790989257753;
        Fri, 02 Oct 2026 18:00:57 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df3b2aa19bsm4455840eaf.11.2026.10.02.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:00:55 -0700 (PDT)
Date: Fri, 2 Oct 2026 20:00:52 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 6/8] repack: track the preferred pack explicitly in
 MIDX write steps
Message-ID: <asBTxLW9j2AIVlxZ@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <a85dbcd04c7957756848e5f3102744d20b509fc4.1790827875.git.me@ttaylorr.com>
 <20261002232834.GE834759@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002232834.GE834759@coredump.intra.peff.net>

On Fri, Oct 02, 2026 at 07:28:34PM -0400, Jeff King wrote:
> On Wed, Sep 30, 2026 at 11:11:58PM -0500, Taylor Blau wrote:
>
> > A MIDX write step marks preferred packs in its string-list entries and
> > chooses the last marked entry when executing the step. That makes the
> > choice depend on list order, preventing the list from being sorted for
> > membership checks.
> >
> > Record the last candidate directly in the step, borrowing its name from
> > the write list. This preserves preferred-pack selection while allowing
> > the list to be sorted without changing that choice.
>
> This is certainly cleaner, though it looks like the existing code works
> by marking item->util and then doing a linear search for it. So wouldn't
> that work even after sorting?

It would if only one entry were marked, but we can mark several.

For example, when `repack_make_midx_compaction_plan()` folds multiple
MIDX layers into one via a WRITE step, it marks each layer's preferred pack
without clearing the earlier marks. The scan doesn't stop at the first
such mark, and the last marked entry wins.

So sorting would of course preserve the marks, but may change which one
comes last.

> > @@ -719,7 +713,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
> >
> >  		item = string_list_append(&step.u.write, buf.buf);
> >  		if (p->multi_pack_index || i == opts->geometry->pack_nr - 1)
> > -			item->util = (void *)1; /* mark as preferred */
> > +			step.preferred_pack = item->string;
>
> I am certainly happy to see these gross casts go away, though.

Me too ;-).

Thanks,
Taylor

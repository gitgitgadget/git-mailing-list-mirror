Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EC374C2
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="W0nYV4VF"
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC788D5E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:13:19 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77ba6d5123fso202530285a.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699564399; x=1700169199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ovj4he2vuMABCWo6+dayrC9rGjQOieIID6zLzKFXRU=;
        b=W0nYV4VFDIIYhrNEyIpd/YzF5VghvM7oa3waZDZ96z3mh5CwRqwyS/tKSzjiOJkEKH
         gRpcKQ4VVRrAvZoJU4coKEGY6yAN/uRhFUIqINAcY5cXZai+Fwk8WCBvUgZhCf5UNJct
         5/S8NO7X1efJBCIOcVwtK+XpSiUj+ZvG7ykW1ycxtnZytzjVoHd+694g/K7eqaYePFlp
         vGNdK9yLXNJf1/1giMCWHKBJZisgEHiKiLL+7NMtqangfIspWCaYNS2oHbc+R7bhEwBG
         uMFHvNT1a6y3YTNo9jFcp3zUtaOqIs3DZYWuy4Jjs774CJz48ptRbrAgs46340wM3EHM
         Sqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564399; x=1700169199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ovj4he2vuMABCWo6+dayrC9rGjQOieIID6zLzKFXRU=;
        b=bE4GyOFvfoYmLXkuBCRO7f/UbdU3Fn73hJVrGoGqdeRt3yF9ncMTIYauEv+yGSGXn6
         PtAqlgKYZl8F7U2Jo/FN02M8iOo+tqRdwMq+vKgXxn6Aw6p6hm26Fzp0zQo0sksVl3p0
         +q0WFqcMdUgsZ9g/w5Da2I8BxJIqpNKjhePA9d/499qXzHKxtNhipy7OznddIxSkwZCV
         agB97a/3/Z57iCRWuURN/EH+hop8TkNCiLna0jMzvjlfyciEahale/w5+WSwQCFx0tVN
         QBNDttOSfUnTzR33P58MpplXy4oyS4K4N8jGw4rj+G5w8aF37FnB2N9P4stTFBn2uf4B
         mbMg==
X-Gm-Message-State: AOJu0YybTXI+sGanRxrrAJeLOV1i33VIXph1Jbf9dwR/IFnEBz7blYs3
	Ru8A69Ror+5Qc9haRfITwhmdgEOyXBQe3lJQoI9rmA==
X-Google-Smtp-Source: AGHT+IHOLFw0Uyea1kG10S1jm4TUesn34JtrZkqs7yb2uENub96JHENYkTPDQuhY+AQoWh3e5hzb5A==
X-Received: by 2002:a05:620a:4723:b0:76c:ae1f:201e with SMTP id bs35-20020a05620a472300b0076cae1f201emr730617qkb.27.1699564398981;
        Thu, 09 Nov 2023 13:13:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10-20020a05621401ea00b0066d04196c3dsm2398679qvu.49.2023.11.09.13.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:13:18 -0800 (PST)
Date: Thu, 9 Nov 2023 16:13:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] commit-graph: handle overflow in chunk_size checks
Message-ID: <ZU1LbV0/ciDdO1aD@nand.local>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109070948.GA2698043@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231109070948.GA2698043@coredump.intra.peff.net>

On Thu, Nov 09, 2023 at 02:09:48AM -0500, Jeff King wrote:
> So instead, we can do a division like this:
>
>   if (chunk_size / GRAPH_DATA_WIDTH != g->num_commits)
>
> where there's no possibility of overflow. We do lose a little bit of
> precision; due to integer division truncation we'd allow up to an extra
> GRAPH_DATA_WIDTH-1 bytes of data in the chunk. That's OK. Our main goal
> here is making sure we don't have too _few_ bytes, which would cause an
> out-of-bounds read (we could actually replace our "!=" with "<", but I
> think it's worth being a little pedantic, as a large mismatch could be a
> sign of other problems).

This is wonderfully explained, and the patch below follows trivially
from what you wrote here.

So everything in this patch makes sense and looks good to me. It does
make me think about the pair_chunk_expect() function that I proposed
elsewhere. I haven't yet read the rest of the series, so it may be a
totally useless direction by the end of this series ;-).

But I wonder if the interface we want is something like:

    int pair_chunk_expect(struct chunkfile *cf, uint32_t chunk_id,
                          const unsigned char **p,
                          size_t record_size, size_t record_nr);

So we can then grab the size of the chunk, divide it by "record_size"
and ensure that end up with "record_nr" as a result.

Again, this is perhaps totally useless by the end of your series, but
just having looked at the first patch I wonder if this is a productive
direction to consider...

Thanks,
Taylor

Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7E3A6F04
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320478; cv=none; b=FnFhI7a6MJD5yhP3CS9krGFY95OTHdn4ozscyVi0i0QX2p55Ibd0vQp21jKtUbZskyroEhHwoEmaWUg5YTPib+RYDXI37Z8RtjSwgyO/hYhd9mynqSOS3SDW2IIWGyyIWuy/6RG1eZ2yvUjEjyfhH3qHZnFsmqhsgJ5MOpLw/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320478; c=relaxed/simple;
	bh=kj47YD9nXWjiFXzcbuNjCsDVswKg63qVKr+5tmsC7vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqahP8Ur/Rf0YyXBHRGRjnQZL54+u1qv/Mh79FcXuRSmjp0GMXdWtYdMnbvEuB84QzAdGzwiJtneUKH2XMuoqLdf7bDHt8AYWXDIZiJ6rtunMcZ0Tf7VWUq1yHvSyNJvqKJFB0hnZ95g+AP9UqUIpdEhx0S2KeTv4YSA3PDKKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSYvy2zs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSYvy2zs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so104353485e9.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320476; x=1780925276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78oYPpImfHe/B3KGZmw6MdEthGORJ0Lv+FclXZI3I9E=;
        b=HSYvy2zsWqb94d9Q0ZPFz3N31iNAlnA6KN3J+fO9nAp4McQ1p7Ct9Zqx5y3oXZ4Rzm
         LPKG0HXyqNS/aDRP7PNkGgjgz9fk3gI/V2dHiEwXYGR4oqOar0J6rmPpGZ/ik50knDx7
         H6o6mK/Hd/Kfnmq17rAEkI1KzMA2+9WDoFpTkXZa3DDbsXCQQZKqcd9JWyxmZCCIgkC4
         iorqSMjESaKiCZ1EvgNwnbsQhNgN9I/m9Cb/rR8JNQ9nMEFRYkF8qUxPidJ31JqsaRhI
         eqJVAsFlFxmaBBM781/Jkzu6Z2pGdsGFf/q1ORxtQ1xU/37YsNOSmCkQfvPwotPHMaAa
         SS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320476; x=1780925276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78oYPpImfHe/B3KGZmw6MdEthGORJ0Lv+FclXZI3I9E=;
        b=KTNpimpdxfobu/ncJGfa2sdD5uErdXsslHdlGcbUHLteRMvhzWiU/zVz0dq8TO1tLS
         74SbfdTazxNxz7QeFKq6GOaYFRIfusUxf080pPXmiV5r+q0Cax0gThgDDbeHSzc+COaw
         BC+nUwAAkMd+D2lapiU7D4cnEJoXTr3Vp4jg4e8TMqS699RMZi9AHh9snFMWEK1+/44K
         apb6VUFC1TiQufy/XMbl7mkrcjJ4FRlSfCBltIoM2Q4JJraxdxNUuR+MkKCGN8qMbUQm
         EPrhCfBqL2ww1TC0BQe4TztgoP6+huqKWQAW9VceeLtvKvhlFUfUQpfFH7EQfsfvg6yG
         2+WA==
X-Gm-Message-State: AOJu0YxGGIWEg0rvMK+IoFqdH81W6DlkElJdU8fDQHvuyhd7ix1DEwek
	7W7EPVKnBG2hhhBUT0ED9CAAV9laGIE3Apvk2XxTtISDtsG5mfKCG2Dv
X-Gm-Gg: Acq92OGz2UzDOXE93uwyepq4LBtHlAdJX9+AZjZMg2bO1muIj6McOzgglWIN9dBKgKS
	x1l/zuFBSU0OB1Pb2Ox6gm/+lAocq1FKjk98gBRoVzA4M+X1aTzuHdJxkkQtkA7P3IIE6E75rXm
	UeKGFuFHVQ/8kYMIYE6DyALV1EB74veMcsMw8fsfue9p7nDVVlbOi3VqeyEXadTrTpnk/ptKo3E
	wA9QktOvH85WepNNeWpOHKmINwPOLg6w3howvWgrlj4utIn4BnNkiAlvZ3Kw/oftfCS1uOBHg9v
	t1nFSZZN3Kc9MJTifx+xTxPT2MOm4vj/GB55MRacIqAqStZC+UtCCAsQRuyfpOImsqq71A4r86Y
	Jj1e8jqd4Yf7JD2uRed2BmfSrpkIyl0N49kNuQ+BcFvO0/hd28k6e1lxQmyZn9Dzs8cgftr3lwH
	n6Pj4XnPJGd/+BgaPp5+eCHblJ8XtyTj33vPnpOKVC48jUsbnYldwQHDGTj3KOt/BUMnlXTPjUj
	8cc57lWX31bPF1dV2Y4NLM7IRLrSd+lOg==
X-Received: by 2002:a05:600c:3b09:b0:490:a7ab:bbee with SMTP id 5b1f17b1804b1-490a7abbdcfmr146508195e9.15.1780320475849;
        Mon, 01 Jun 2026 06:27:55 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c12f4d0sm80084375e9.34.2026.06.01.06.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:27:55 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:27:53 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH v2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <ah2I2b345uU6LKJI@lorenzo-VM>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <ahjUmMCKxREamQE-@lorenzo-VM>
 <20260529053659.GC1099450@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529053659.GC1099450@coredump.intra.peff.net>

On Fri, May 29, 2026 at 01:36:59AM -0400, Jeff King wrote:
> On Fri, May 29, 2026 at 01:49:44AM +0200, LorenzoPegorari wrote:
> 
> > Inside the function `fetch_and_setup_pack_index()`, when the pack
> > obtained using `parse_pack_index()` fails to be verified by
> > `verify_pack_index()`, the function returns without closing and freeing
> > said pack.
> > 
> > Fix this by calling `close_pack_index()` to munmap the index file for
> > the leaking pack (which might have been mmapped by `fetch_pack_index()`
> > or `verify_pack_index()`), and then free it, when the verification
> > fails.
> > 
> > Also, do some more cleanup by removing the useless call to the function
> > `unlink()`. This is not necessary anymore since 63aca3f7f1 (dumb-http:
> > store downloaded pack idx as tempfile, 2024-10-25), when
> > `fetch_pack_index()` started registering its return value (in this case
> > `tmp_idx`) as a tempfile to be deleted at process exit.
> 
> I think the patch as-is is OK. But when I see this kind of "also, do
> this..." in a commit message it is a good time to consider whether that
> should happen in a separate patch.
> 
> Here it does not make sense to remove the unlink() afterwards; you'd
> wonder why it was not present in the cleanup added by your patch.
> 
> But it _could_ be done as a preparatory patch. And the rationale for
> doing that on its own I think is roughly:
> 
>   1. It is mostly doing nothing, because 63aca3f7f1 registered it as a
>      tempfile, so it will be cleaned up at process end anyway (whether
>      we succeed in fetching it or not).
> 
>   2. It is maybe a little harmful, because we are going to unlink() it
>      now, and then later the tempfile code will try to unlink() it again
>      (so a simultaneous fetch could have created the same file).
> 
> For something this small, though, I am OK just lumping it together.
> There are diminishing returns from polishing it further.

Yeah, this makes sense. I will separate it in 2 different patches.

> -Peff

Thanks,

Lorenzo

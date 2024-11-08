Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F05233D6B
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089553; cv=none; b=o9UYFqu/0aKjCbtO7dnUocu9/rlvGP7KoceL/W54IMP2vITTzNOr5OO6IgpFvix3tIu2E8dg/dE8TAr0gkqHJ9vjHAORinOWZiTnnQbuOoXlg9V7w37DQj3a0rHChAMSlbPn2iv6JDO/Q44fzcc/Gz/EmzehvUCDAGjefMrfUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089553; c=relaxed/simple;
	bh=aL9agYmjYiWwjjMC0VWFQznPmmoDvBjlnZr2qTG7dZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpuSmvAZLxCPtKRRC484hMSJ4vyCY7KOMUhaPE7mCW5kA8jWQnuY4UJqTllJnj9e77knCx6s4/WYt7zHne68DCzl0LndvnAcRKFtEDPbj/ptqL1T5MR5uueJsirNs457w/0PPk78w418RqUHJYG2J78bRdoBKvuQY7UTwJe14HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gurdMFDm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gurdMFDm"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e681bc315so1890302b3a.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731089552; x=1731694352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPxyuU7W9FBYV7esHRBUxZ5baFgEn/evhIuWEMoaj6E=;
        b=gurdMFDmcuLTzyt3PqIT28VgISTuLYcNjQPOlWN7C+lXVD2DVNLT+/7y2SpVOuJhwX
         ftFaLXP/n3nPOnDa8bakuUHF4MGgjcC9cxv+7sTLvGzcC5OeXuRlUDj4q6LoqNfQjHpM
         a/p7YpT3bh+6El8nRxD67A2CBWusgoEK0d5LUqCXrNv2XLTlvZKJd3b+VCAzn9AaKbMa
         U9Ak5lGTmSwVSImjZw4ojkAoaCyaU+ghKDW+PksRbJ9ipDKmGJX+nNzmlMymRi00xNHx
         YAP561lS6mqQzi38zGeU4Jl2rINZrENb2Aixz5iuXjrSsmNRboVJ72Go25xTMjco9vaC
         L4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089552; x=1731694352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPxyuU7W9FBYV7esHRBUxZ5baFgEn/evhIuWEMoaj6E=;
        b=L9nAJl7sQaOIaAR+6inWHyNJ4NCmQpO0DzZNKT5O1V36t69To20wM9+v4cy9ZST9Ob
         QNQuWQ93ifovQVJu4dZeZpKCXNm+POuwpS1n7FRNdGP36jZJdZbzJSYzg8Mqb8ueACAg
         LR7HMLMWZNHrvmMy5C6vyxNMaFcpQJdFIqODNfpqyE51akGXfMQLb215T6hIXukjivLf
         5W17RGHoEPQSyF/L6oE8jjSIOwL9bxhg0VukQVFKNCNg2Tl3JoKGbISg23fxTcacbsHT
         sJH0oYGv4SSftdlMWnfOuOG6LpWvPd47JXtmbuk6MF5lSAKI5i8oyyR0jbgrrvsOgpLs
         mwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUulX4KZUnMNDZPMf2UStrfa9SI78JxVGPKXR6PTGJp1dMepTTu/xpyZcD/me4SYop3d90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyga4CxLIvYUTdZQ0nusLo33LMbFh1qWsEpLtJZmFWou6e6+y79
	XKSlUv0ZfWWoqPBDV+Xx7GPffhFqQd322asCXinmO91yPI+HI+um
X-Google-Smtp-Source: AGHT+IHdMzR6uXNoycGAsiMwSO4f7B4839+gutqnwJ+JwflLmg8T+oUpkH3OORi13pL3VtgSqbIN+g==
X-Received: by 2002:a05:6a00:4b56:b0:71e:7174:3a6 with SMTP id d2e1a72fcca58-72413da856cmr5563734b3a.0.1731089551561;
        Fri, 08 Nov 2024 10:12:31 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:9e01:5014:d905:84d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407864ebasm4041430b3a.14.2024.11.08.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 10:12:31 -0800 (PST)
Date: Fri, 8 Nov 2024 23:42:27 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <Zy5Ui0tHtKL1vYpw@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <20241106185102.GA880133@coredump.intra.peff.net>
 <xmqqo72rvjqk.fsf@gitster.g>
 <Zy2PV+yywkS64D1p@five231003>
 <20241108171637.GA548990@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108171637.GA548990@coredump.intra.peff.net>

On Fri, Nov 08, 2024 at 12:16:37PM -0500, Jeff King wrote:
> On Fri, Nov 08, 2024 at 09:41:03AM +0530, Kousik Sanagavarapu wrote:
> 
> [...]
> 
> In the meantime yeah, you'd have to spell it as:
> 
>   %(if:equals=%(refname%29)
> 
> which is...deeply unsatisfying.
> 
> I have long dreamed of throwing out all of this format code in favor of
> a recursive parser which generates an actual tree of nodes, and
> implements all of the ref-filter/pretty.c/cat-file format placeholders.

Oh!  I remember this, let me search up the thread...

Quoting you from

	https://lore.kernel.org/git/20230901191639.GA1955435@coredump.intra.peff.net/

    IMHO the code would be a lot easier to work with if the atoms were
    structured as a parse tree with child pointers (especially when you get
    into things like "if" that have sub-expressions). I think one of the
    reasons that used_atom is an array is to de-duplicate repeated mentions
    (so if you formatted "%(foo) %(foo)" it would only have to store the
    computed value once).

    But I think that is the wrong way to optimize it. We shouldn't be
    storing any strings per-atom, but rather walking the parse tree to
    produce a single output buffer. And the values should be cheap to fill
    in, because we should parse the object as necessary up front. This is
    more or less the way the pretty.c parser does it.

> But I think it's a non-trivial task.

True.

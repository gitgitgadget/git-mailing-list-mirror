Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F512B90
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983181; cv=none; b=NLQ4gNdc0Rb1Z/7vhMOOTgmw+tTgAkKuO8aL+naPWg8MgnSd8GN82CaZ19koFDel9xtCe3oXv4Phb93j2TCEUB6tiNYQ696UI1EwMpikRut3YByMDJxAfbl/Gn/+ppYJYk1+9x8xOOXJSEHU1o1ir3PSZtFjBbIvd7Q81wGpzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983181; c=relaxed/simple;
	bh=zMMF3ID6bEUKqxN6NoPu+e0D9K1Q4scFnzvyQT/j3dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghKtgbcYyJDyJufBBLysYhga6VwCIhWtEhTpPfMWgG285WvTK0yojCbVW3+4G3sx23uJnJLkQaimaYdCyLwBkPLFtMUN9OERlz6OstIAa15U1Je0yLVzyXXTe6VvgwlxKHlW+P5WvsfHmH2IUB9WClCWtkR6oH/jGiIC+ZbPvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2YLXlz+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2YLXlz+"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so689570a12.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 23:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707983178; x=1708587978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huzUfqbRysh41NOObqU1R/eKOat4FX6sw0sEmAfidWM=;
        b=k2YLXlz+Hnc3YrfMBwX+xUAj4eKd4qVOi/YPcMLPo49AqgCaXyqWowFHh9C1q4djV6
         yxlSLUvN3epK4j/vPG1CEp6DzNfHH5HFSQJsIckbv//pPSNlFOvno3gnYs15T6pmGl5C
         ias/y3XDI0YSbo/CYoylmwV7TiFyAr3U9OeebGfau3Zo4eSPO4JbekdmbZNWCz25wLS3
         oHXuBDcN12QCiYauwwWhrzOfeURw4aa3JJPaqySiTj5HqUDm23vi8zZpFplgRem9BY01
         4TyUH0svRTE3uRYdxAl5C14m84cimzFDGiMhLwgYJs1GsvZJe4sqW7NQGufZ0+IeHmts
         FGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707983178; x=1708587978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huzUfqbRysh41NOObqU1R/eKOat4FX6sw0sEmAfidWM=;
        b=fABqOfKLwNHKFLC0sbQPcSyAYX/+/1LslOG8cL9pdQdWSpGtGc51E7VDNdbN5sKsdN
         T1Bz/k+gJstUOuApZ4uGnu7p1aV825dDjhXqpIlUp+dZMTFCYRqOhzrAXJGNHBaxgHi+
         facNHfYdPToxHWcNoEMcfbtazPsUMXrBEilWwvWbFKGIPLr2EpTiV05H7Ie89oXLZo4c
         HtR2MstufeamOJFFsE9w02Rinb4xql5LtX2VgtPDdrtitDIpjzSlC7CTU2R74or0/Rpw
         l3JEKAv3/n/8ph4MwAC5XT7ENkPBmoA7pZMKIsc0BmG+rDozfHUpijHVldTWAgV5gIeU
         SnFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6NuUwngIx4hRy1YoMakX44r7A6iCelqmz582FvZZKkjeX7Lz+Bamjcl8Ia+jo+bb3YEQc59BfoT7GKv4lrWok21PE
X-Gm-Message-State: AOJu0YyqJAtJZfFq8wEHOMWSD1JkSTOn8ORQXB11iONd8GdzpY09jX0o
	V+4RjFyhLe33ZKBJqPWLCtujBanxzQ/iS5rOBm1ctYPvC4BAhjEgfCdy7e3UKIpYEbK/0Yz6OHX
	+AZKHpGHwRj4WFoDdlb5KDTZuMxyGtWKp
X-Google-Smtp-Source: AGHT+IGxlHVY4VeYQsn8/9AB648tOFYUiSH3qZ+NW8EOSe71rzXF35DoHauAKh8LX/3mrRilkEggreZIar5dqhbIhNE=
X-Received: by 2002:aa7:c1d6:0:b0:561:13eb:4ade with SMTP id
 d22-20020aa7c1d6000000b0056113eb4ademr762288edp.27.1707983178095; Wed, 14 Feb
 2024 23:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl> <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g> <20240213080014.GB2225494@coredump.intra.peff.net>
In-Reply-To: <20240213080014.GB2225494@coredump.intra.peff.net>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Thu, 15 Feb 2024 08:46:02 +0100
Message-ID: <CA+CvcKR9sH=qZB4oZvX9RWd+4H3Bq8WV_qUOiSj_Tsf=Dr_Xvw@mail.gmail.com>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Teng Long <dyroneteng@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Op di 13 feb 2024 om 09:00 schreef Jeff King <peff@peff.net>:
>
> On Tue, Feb 06, 2024 at 09:52:38AM -0800, Junio C Hamano wrote:
>
> > > That is also a cool idea. That would probably use the functionality of
> > > the cat-file batch mode, right?
> >
> > Not really.  I was hoping that "git show" that can take multiple
> > objects from its command line would directly be used, or with a new
> > option that gives a separator between these objects.
>
> How about:
>
>   cat some_commit_ids |
>   git show --stdin -s -z --format='%H%n%N'
>
> ?
>
> -Peff

Wouldn't that fail horribly with non-text blobs?

Are there examples other than cat-file that show how batching is done in git?
I'm afraid of adding something to git-notes with slightly different
syntax from other batch commands. The git cli is already confusing
enough with all the little inconsistencies.

Maarten

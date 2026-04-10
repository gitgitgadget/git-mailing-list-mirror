Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3C26B74A
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839448; cv=none; b=grHCyKjiQ7raj9ayDprgCv/AyOC6M6PTN6OqwvsuY9dpC/+5f2lucbxklW5FD9VIohUAHIAY8o+n5DWBbdpedHQOdluUzaBVXMrw374q9iCmgBY2iKKrPM84aUTiBcrw/NduCT9tEfPP3/eIo7TFohKAcMxl7M4lLCbF5uaI8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839448; c=relaxed/simple;
	bh=39WpNzvLLaSrjFKuFpR3IIWwY6ow62lyTY2rx+/jVs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsQr/sJgBC1v6ImydS0CjP0CWIU7ZraCt4YTaZpZyvdwhG2p9+kproRFeP0k+d8NPWh6kqWO8KG3/RBEtv5qqUWpIz516Jt0dagryL+nDCw/hBp7MNnIVjx1BSKlY6M89dPwcFABm7GTDLo5nQvoZsBde6DUMSeRYtfMgjhbyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4MOdAZq; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4MOdAZq"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43ccda008cdso1297137f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775839445; x=1776444245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67Z3yGNYmy1Bnti7njzNBNjDvV648RZi4uRceQ9ENUk=;
        b=Q4MOdAZq2DptTeZuRSWqIcnq331ibYdUEl7Kna9uN5EAAR7BEFYWZBn3GsZj9cG4YY
         pKfQxt3Zz1neHfGRh+B/weMUqYCCfaei6z+mgZz7YGuwT8WGHb7uzFEyBwEY0dPiGbxJ
         DCT/RuW7kK7PTvC+CKTyVt8JD8YZ9AkFpZmL3inZUHUgGo38ySmRqYEZtx+LbnTtFyjZ
         dp1HawC3O8NpspkBcOzMTK5vBEaX4BU/Dc26HiJlNx34kqCo0oFWbD/xgYkG4Wx/Vqct
         Axrs6R/q85HCfX7u7keOiySb/KPtXgnAeTAV0gaqoHCzT8oIZrKUy6zV9txW6eaYcNb7
         +A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775839445; x=1776444245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67Z3yGNYmy1Bnti7njzNBNjDvV648RZi4uRceQ9ENUk=;
        b=IJniqHbI6RClzpx9x/H6eVt9o+umog4/oMXy66sLQ706mqwhJp1PVnOmJIi7rnoZ8z
         kPOPMwJZXWCgFj1iFq2dkigBUD+5Akhusg5xKWaoZw2ucmcsjscfPzt5VjbC2VrAegxc
         oFNNonoLe8z5r4w2y4QzLlMD66nh9JctQA3sm9TeDTX+d5/nQ6GZsRWGzhnlRQ0jE/3E
         tP3HjFYWDnGZAueL50Z6EX2tdU8GwNNe1Otz/1pYKN8Odowql0zjB9XBMHSk5Mxal7Go
         VzLdL8l+NwiyTpDiQKvrBWN7j90hRIRn70OmtYJ3prpBxFqq1pRTr87a6yPwpVZULVGw
         R+fg==
X-Gm-Message-State: AOJu0Ywlkw8vV/mQ4HEoe5h+yF2APfhF5Yl4FXt3YYeh3wVg0pj1Hzz9
	EUcXPAsbLGEUBaWbTqHZ6UvRImO7/dpI/Qc+lSWwOdMGARu1Vw8aTyBq
X-Gm-Gg: AeBDietviH0DsJK1wZ/aN2CVdoiQDd9Hwcb6qU7olHwb5sKtpllGpFquW7sTGBGu/Uw
	/4K3T7N4hLvvPwpuLjTTvfcoda1+ybeZpaMGkvdvPukYS1Ri8M2Z8k2USG/TJydSt6ZZUdel2qw
	Ffh69x/iWa7YEeq6FjNspGrzri7EgwvjVWRzieECT/cndYHCAqYScPFcMhhj9iv8A5vbkdfasqE
	Ftaf2wsvOQQu3jtAd6diAfq2zkflr+5Dxs/f8e66Gdd9NWJBBB8P7OPDMRR6UcGy3zgsjCn/h9K
	InKMaYEHXDNdR6GzJsLWdyTLNeGH8/9MxSZSD2y4z+aHxQHEJn9LCjkZ/XKLBUubJMukyuMh42m
	r+bFVnjRQPUOibcZL8t3Pf1l3E80y1cgduF1WEuGZeMFHh6Sft4XcRPROHY+RZ4UY0+t4amxmuQ
	iE6fF1PMRtDeA7wOCIzcJ2QxoB9EGIn9mw6kWSZVonafJcmoSGE6wmJM85lfFk4EJAlQqLx93+3
	TSf3gHt
X-Received: by 2002:a05:6000:2803:b0:439:ccd7:cdcc with SMTP id ffacd0b85a97d-43d595c4d23mr7931490f8f.18.1775839445307;
        Fri, 10 Apr 2026 09:44:05 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm8445162f8f.14.2026.04.10.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:44:04 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:44:02 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 0/5] preserve promisor files content after repack
Message-ID: <adko0kvU5WX69GYQ@lorenzo-VM>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <xmqq1pgmrf4w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pgmrf4w.fsf@gitster.g>

On Fri, Apr 10, 2026 at 08:47:43AM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > QUESTION:
> > The "CodingGuidelines" explicitly state that:
> >  "A C file must directly include the header files that declare the
> >   functions and the types it uses, except for the functions and types
> >   that are made available to it by including one of the header files
> >   it must include by the previous rule"
> > where "the previous rule" is (if I understand correctly), the one related
> > to "<git-compat-util.h>". From what I understand then, I should have
> > added an include for "strmap.h" (which is needed for `strset`), correct?
> > And if I am correct, shouldn't "strbuf.h", "hash.h", "odb.h",
> > "string-list.h" and "strvec.h" also be included?
> 
> If you are using any of the facilities declared in these header
> files in your program, yes.

Got it.

> In practice many header files pull in other header files for
> definitions they themselves use.  For example, <X.h> that defines
> "struct X" may include <Y.h> for the definition of "struct Y" because
> the former embeds an instance of the latter, instead of having a pointer
> to an on-heap instance of the latter.
> 
> If you use both "struct X" and "struct Y", your program may compile
> with only <X.h> included without <Y.h> included in such a case, but
> the guideline suggests against doing so, because it should not be
> relied on.  The implementation of "struct X" may change in the
> future and stop depending on "struct Y", at which time <X.h> stops
> including <Y.h> itself, and your program would start failing to
> build, because you use "struct Y" but without including <Y.h>.
> 
> But in practice, use of strbuf is so widespread and the header is
> included in some other headers that do not need to, so your build
> may happen to work without including <strbuf.h>, for example.

Yeah, I 100% understand this. I simply found it weird that there were
many missing headers, so I was scared that I was not understanding the
guidelines.

I will add a 6th patch that adds these missing headers, in order to
comply with the guidelines.

Thanks,
Lorenzo

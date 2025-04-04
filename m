Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926822E62D1
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743738472; cv=none; b=Sl/YsngAZG/xkVa/2b83cEYXJb3/D2A9eNY7QRxlZByBZXam1WD9xfG2cK8+hdbYel4nQerCeuJPiYFLDiN16Ei5cPix0OGOYZtdjTRKwki+CU8XMpOeIOeb9RXxev/mqHkg8Whw51FvgahjcQvBDCnun5irc9eb/VkTIMJakw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743738472; c=relaxed/simple;
	bh=w1vVBHyUecfUhfUdW/7g7Z7mcR7x5f2PQ+2xheObQB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKC3MUHraPXFaZE+TfnyBADV+hOVNa4uMhaUh0NpaCIwp62uj4wvTzUD7Rqh3jJ6a9BwYHA/MJxT9kdcdm7VXGjFl3F9qMAVL4sl+sXywDFLD9A6yFVsI+PDtJDl9ugr2ECLAnXI7GxqGQ6Z5RdIzSIq1htNamxKwlGBrnwG3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XvGkBalz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvGkBalz"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so3541a12.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 20:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743738469; x=1744343269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dR2bPD+7NpVXQ0Xzef0PlWQ8MO/tgthYEux7OR2Jia4=;
        b=XvGkBalz6vjvnvl24zpuzpnKUx0wL+8TMH9u2JfFDRpV4AsMetXWYpwhQ331Bx9qHa
         V6K67C57O197GlU81cQJgqhMslPdk+tRBbI8DgRrWutHmm6boZ4O1E4IMZs0AwEZ2c4S
         ZXUVy2/R0CyPFMAj21DKIIpmE4xgzDoPCnWjzNhVF1Qj2Sf4uREJM+w5tu4c15iWZRhv
         odrNYJZVFHiOHX0/3gjqqARCb3PBeDkgNTVp9HL3xl0l25ogG3Lh9dnIaiAGjW6pBV6N
         nCSjjx/+fOxACKSWAVFK6ricXwOErWTCSdOmTSMwp3xd97f8/ZyKlsDsf+KceMccuELq
         S90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743738469; x=1744343269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dR2bPD+7NpVXQ0Xzef0PlWQ8MO/tgthYEux7OR2Jia4=;
        b=CyLN9Gu1i3nKsRRNIYIXfY6SFVVn+wNVAKhiGMyK1sAT8ufCZthhOR95LLbtATz51H
         I0mhmPBBlpmPBjIxzxiFwCWUebspTb5jHfMXFWjiubH75jK9Kiwjko4rrS6+PhKG6LC2
         cI0eTdXl/JQf/pGtCq0cfr3AI9uqXT8w1UZUOCTTLyDW4OdAhGHceJGZyirIwt6dpMNo
         7dOdB/WBk+9ApkDwd/IMxh0B0dOPz3fyvcZ53LdEH8K5NlXuxPiFAGY1TE+i07qr/TNq
         gHJT5nrXcOzZwLwPdzm5jKxyZo3Gdw7PQSC/VfcUoCLSIQi/SgbmNwgheLfLeKdwr+qO
         /E8g==
X-Forwarded-Encrypted: i=1; AJvYcCXJKF77bwArBzLN6ohMIc1nMyCkO/isAjUiBa4BdrC5yjXMnj+JPFGwjMd3cZplLIdEc7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eKIpfC1WNLfQOwexQahHYVjTQgoNF5eSJ9ASZUtnosV0sGw8
	ub5ckjkmWF5gSmOkvv4KI/HV8fzO1ggxnmnUNfBJKO2j3gxD92YwmZfGeHeDOwIjjpbFWCgaTJz
	t0qXQjrpDCFVVU0dZ+unEQ+6Xa6G1MJeOLhad
X-Gm-Gg: ASbGncs8qjc5ASNEh8araV7qqPAu6a1uOdvEAoCQGKIVLELxJO1LiktdpNB9e5LcTw8
	DJrrHH8kD9tbCUJKi7FjpezMJYUedcRYn3AYROxABq2aUgCqsbuuZyrf5bM1drGyNaY4Myfb+8A
	f6DMGNxe+KGfDiGn9asNPh3iQrpQ==
X-Google-Smtp-Source: AGHT+IHI/q1sW1AymEvDVtWfv7MvlxtUwxtoSUxShQSs41HN6IJClOtsZ8VuiFSN7wrmaLsMEORikp0hcdKbzRmEIeg=
X-Received: by 2002:aa7:ccd6:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5f0b484cf47mr62382a12.4.1743738468543; Thu, 03 Apr 2025
 20:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
 <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev> <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
 <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
In-Reply-To: <CABPp-BFYoZ1cuUMJPhWhtgntS0D-E=ZF+8_KS7gC+ShXjTrEDg@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@google.com>
Date: Thu, 3 Apr 2025 20:47:37 -0700
X-Gm-Features: ATxdqUGWLGxDIGfnomOhy9PnyyZ5RsSkSy-D_fqHmnHGykxE8FTM75U2sti7gYU
Message-ID: <CAESOdVB4yrDQ1v1BZtPiHDJwbaRVN6tixWg9eWNmBitXyqAh6w@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Elijah Newren <newren@gmail.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 19:40, Elijah Newren <newren@gmail.com> wrote:
>
> One possible simple solution here is just to treat change-ids (or
> there abbreviations) kind of like abbreviated hashes -- they aren't
> guaranteed to be unique.  If the user specifies a change-id and there
> are multiple branches with such a change-id, we provide the user an
> error much like we do for abbreviated hashes.
>
> Is that what folks have in mind?  If so, I'll be happy to drop my
> reservations about this aspect.

Yes, that's close to what we have in mind. I think I just didn't
explain clearly that it's mostly harmless in at least Jujutsu if there
are multiple commits with the same change id. If there are multiple
visible commits with the same change id, then you'll just have to
decide what should happen when the user tries to refer to commits by
change id. We currently let it resolve to all the visible commits with
the given change id. We may change that to be an error instead [1].
The user can always fall back to using the commit id in such cases. We
call change ids with multiple visible commits "divergent". They
currently show up in red in `jj log`, which I think we all agree makes
them seem unnecessarily scary. We'll probably change that soon [2]
[3].

So when I said that I think it's quite uncommon to have multiple
commits with the same change id, I didn't mean that as an excuse to
not consider the other cases at all. I just mean that I think the vast
majority of commits are not cherry-picked, so we don't need to
optimize the user experience for that case - it's fine if it's a bit
more complicated to refer to such commits.

I hope that clarifies. Let me know if there are still unanswered
questions that I have missed.

[1] https://github.com/jj-vcs/jj/issues/5632
[2] https://github.com/jj-vcs/jj/pull/5800
[3] https://github.com/jj-vcs/jj/pull/5850

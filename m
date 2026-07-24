Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E963F1ABB
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928049; cv=none; b=h/7z+xdT8imOuZakDoG9lAAg7lCHV9+Qibj3JSuf/e6HAOJo2rmUewlQMbboTd8Gxu6HD0U5eZzMWxX0Mkc6laKP6Qnso8pPaw9kpTCSlctQ1e134G8/jTB8gXXGK3qUd6kdrVHrSlW/nVDL+Wf2HEK3SyR5PWIJ2bWXFIJVdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928049; c=relaxed/simple;
	bh=32eFPTxUN1Sa3w3POer3JO8cPj6wAfvXQCAEmdUeVKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdIsVYfiH3mmy/mqL4z8585aQo97EtEs1z856EZsdB5o1c5STHC58g1n9nSXmw6VbY+dekGmkJHZxUQyEUgKDoLdXKq7YmixM9F5qhFJEGxUahZmln5XQewIbPlNro8fxABH0kZyq2isd/b6y9aa7irX3H1iJBOrh4BQoM67PDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=D9ycfvTf; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="D9ycfvTf"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66807ba2f0fso814913d50.3
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784928044; x=1785532844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GOugYSvTR2jtYUB1wyD1mPDEwCfG/+iUkjjc/fMDTXw=;
        b=D9ycfvTfkQ6PSbKH7nFrDuZWOv8XP24SY8PG+zQ+DfQjaI7GGftMBdBbWJ5IyQT/Rk
         aB4l6SKlC+gqU4qq/TfOi5QFGitFA6mlb10wCAoYk6Klpeesnhx6p0yZwwfWiCuxaLt6
         UtLkvrV3dNBaj5BbyrJ5Yt7Z4yNq18yvy3piw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928044; x=1785532844;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOugYSvTR2jtYUB1wyD1mPDEwCfG/+iUkjjc/fMDTXw=;
        b=jK9uQgHgs+vDMbpUj4FQkNkf/afRmmI+/+lR0tphph5dKllcVdjR7VFPDmCDH1CTXv
         PBiJCR7r+AvlKG2fqC4q5n0h1e7qFbSXzY7D6Eh0hHznxeFKL5hHgJh7eQPy4Sbov29a
         ybiCwc1tKfmrrroLCXryWfc+Ls1lAusekKiur33XUO/UgqOX6DF1toPt4sLXieJ/aJXY
         oYot0ivR3Av0SIrF76Eqc4lbW7Bb7PLlBgWDjFg8MEwvhDOk5a5lJ3gfEnSn6i8bUUVk
         joIE2jSYyg4k2mXsj2l6KinthkcveyS7AGULbkiQTgxSOScyqrExSIR/77wT8Xq4M4pc
         btIA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3MDCU4XXP+8B4o56+8A946m7kLfoQQIhi0Yt0Sf56m38rltmKH3xLqJXDK+IXBi/SNNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtBB/AwZXKU4I4Ao6N8g54VBzGgerus004abn5RWZO6gJWhXc
	g4ZIw6YcwKi+gMrL12ueOv8oQlh0TDtKG6lQHp7aEowlz3ItRPjjk6w3SzO35GK/3OE=
X-Gm-Gg: AR+sD10LrcPEP5CFyq50Y4og6OhzATT6go+vXKxjYGnbrC5MnpfdhbgfgpK12lXOu0Z
	kvVgd35hVk9QWqAmvIQzovyqEPBUUf4GaK5Ks0YWpeVdQGGVVopuF2tje9VbwfUjEZhemhEA5lB
	U4kjEvnueTogWp1jfHM0D3cGTJ6xGgvsMwrOqYF+ok4GwQv+Xn+NYPrVFOFjuPSqe1WYWy4IKvy
	ZJtDrZsy/Il57/TRkNhdFLg5aMGw2hvueQP0T/8u2tE2RX+ntO730VM7D3LIGZKh3RVO4ZZr+rw
	IvE0dbHnDMq0Gz1x0VmxYkwZ7f1FFY1Lp+Wba/+WnO5i5DizGjiBfGtdV45hVUO1jSp3aZy2eCj
	Ko9bjAw66D681aROfPrBDPe1fGmVOTesQRZsYukCdmy0BJsfkQuClhZZWGwD6L0doGXwGiFqrv0
	yRj88cO8VeO6X9RSZSYqoQ3U+zXWbZwpbEPaI3AXprcrZLSb3nGlVVH03QIZOeFXT9n0VhM5Gr6
	i0KxRcQP4Fyu6UDu5iFy/DRTrMU58Ira/tvJImzZnJm
X-Received: by 2002:a53:a701:0:b0:668:296d:3dc with SMTP id 956f58d0204a3-668a50201a5mr1925068d50.109.1784928044203;
        Fri, 24 Jul 2026 14:20:44 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6d30e62sm39269d50.3.2026.07.24.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:20:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:20:41 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: tnyman@openai.com, git@vger.kernel.org, haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
Message-ID: <amPXKfnoTzUuuyMN@com-79390>
References: <20260724091152.27794-2-tnyman@openai.com>
 <xmqq33x89zn9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq33x89zn9.fsf@gitster.g>

On Fri, Jul 24, 2026 at 08:27:06AM -0700, Junio C Hamano wrote:
> tnyman@openai.com writes:
>
> > From: Ted Nyman <tnyman@openai.com>
> >
> > The --delete-merged implementation declares a loop index at function
> > scope and reuses it to walk its strvec of upstreams and its list of
> > candidate branches. Coccinelle 1.1.1 spends hours matching this against
> > the separate_loop_index rule in tools/coccinelle/strvec.cocci, causing
> > the static-analysis job on 'seen' to reach its six-hour timeout.
> > ...
> > The CI failure reproduces locally with Coccinelle 1.1.1: applying
> > strvec.cocci to the original builtin/branch.c still times out with
> > "spatch --timeout 120". With this change, the same check completes in
> > 0.06 seconds.
>
> Impressive.  Nicely analyzed.
>
> Even though this is very much like bending the code only to appease
> the checker, the resulting code is arguably better in this
> particular case, so I do not feel as bad as I have on other
> occasions when we had to work around deficiencies in our tools [*].

Agreed. I don't think we should ever bend over backwards to appease a
static analysis tool, *especially* when it results in worse looking
code. But this case is a strict improvement, and just so happens to
address the Coccinelle issue. ;-)

> I see Harald already took this in the latest update.  Thanks for
> working well together.

Yup. Thanks, both.

Thanks,
Taylor

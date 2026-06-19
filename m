Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853CF17C203
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880421; cv=none; b=O+a0AVuIvogLe7RYQnOjTYJXXwIdnFX9e65PRiLhPtIVRdWGo7Aem5zW9ZTCB5O3J89FftnmDb1olis8QA7RMFNOpNY5QSQo0drstYv67mVhklVJ+ExbIFGzKOdo9vcVgyQfjOerwcBOwGBwt0fM+nPBtFHDrxr4SlgyKvw8ZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880421; c=relaxed/simple;
	bh=rFx/eFy+Zp+6i6vSNKsJPZSMuOSsVQTYJMLZVqlWWok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8kK6XqDHEsvh2qOLkti1OUo34BZ5JEAVPtIRLLJRgc+6el271G5/9uDa1YooL3dcxMpMYppXIWaRA+WCeh7vF2ciX6gZ7HYD5FkeMKwAvy+ttZyTNfj6SqlF1HPCYat6s6naZOH6SbRS4tErlbjHi5k7ZJxEh2BGBil9ioawhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=USXcWQPf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="USXcWQPf"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fe8bc0a01bso21645247b3.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781880419; x=1782485219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFx/eFy+Zp+6i6vSNKsJPZSMuOSsVQTYJMLZVqlWWok=;
        b=USXcWQPf04MiAhF/C31YGC7elCkHPcURX1awxnm4VZ9ZsSEcANkWIl0TavntINnfgj
         IaW61tq6WPLHtaIpdGXiNE/8lp07iTqwTrgZdgdeOxCnxZ5cUVN1GJqa3dNmXiUAMQbb
         GNk2d9zVSdHZQDuOKS/uSc+0E/DmG1psntPoZjoYThaZiUOyJL5c0iKP8PJ02HLrXORS
         nDL/8r4oulwuwM1+zG3sGGZ5Lpb9GUyNqeZsbtHpXPOxbI/GJAkcvDQGqwoazybsrV31
         6OAt92Fs+wRIL7MVFCnFS7aXbYaR+gNWSfxN1RbdoW8vf2i56QsBdleWV9YXCgnVCEGK
         PMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880419; x=1782485219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFx/eFy+Zp+6i6vSNKsJPZSMuOSsVQTYJMLZVqlWWok=;
        b=k+hdkmZlgvw64suluI6t/rmuUH2ChcuBxX5Mst+ve0tarO+8quIWbrvy68Q/V6Fobo
         AY8AyeQxBGVPIAPlG2xhH7lJf4NuVF6PRGlTD8hJiDQQe6O2CqKPlN6SVM5gUYkWbXuy
         5gT49tlz7srJbphb6dr92OWv7fx0xLvi6glZOzvaLtpqrXYiNj4v94/bnm0CWqLrc5By
         PijZgohpj2s0R6tizjN5PBTpy3psDGtShKYly/f8DjcXfBU95qnH3Gv+g6msXGV3h++9
         hS/HJMRTmu34M8rkc6ckZzaGgkh0dT76AWfTZ7r6SsJH+HFO7Ej91ttABOhHnFjtgHi5
         60kA==
X-Gm-Message-State: AOJu0YxO4KcbAX+ZXF1u+Zz0Hm2RQVBUkv/bmdrIVGI59JgAq8oX30Qx
	5nqR7tP2H0ddpsbV5qbL9WS94z9iCQbZgpfaA5/6btpM0Ze6KPviDb9h52cFocAddxg=
X-Gm-Gg: AfdE7cm3+Ta8q3pA2VNGENTz27EYZrbsQiJBxKlWx05t6K2ztqGcdRqA70waKcrBeag
	kIRV9XDmU02ZhVp7AK/PVhoXgzXdSr53iSUR/GoXsnSjEDqnV1p/m1jlVf3OhxNRIvjaSRIXaSK
	sni9+Ta1fGU1B169q+5w0RFjqXHmH5Ot30VbONbQNugzT73pb6kcILZc/rgN3bFFlGWlye2Bz4A
	WOqtRRJivv8op4i8TtT3ujQkJ3aq0Rg1AbdE5sf+BFnF5yi3507May1rZXEl5t5JfXOXM0eXyrB
	cHxVIsxrp2jIHPvaIMbcapQgnfk+lZfwaU16sz18cHfiXnISlnnKL8dr1nR4436CZXUBCBySLad
	IiRSzKaidraw28j1b6+pg0CfK87W1ulqwFBRC9UOcMfSgIAm0i0+H+fUZU3T9vg1fpVEeHLiN/N
	CI2c7U9fjDad7/CHeghOD93Aj2w1g7jbtahA5nOJDQp2UHLVujuR3GbyVvPVCrjLkgPBaY4Irl8
	0u3N4WHQ8A3WCz505vImD8fkce7hOxkjuhMGB04goYiLO4mUIRdXsfFbzpUEFgFo3bjsGJbLA4R
	bT7vvg==
X-Received: by 2002:a05:690c:6706:b0:7ff:f11:24c8 with SMTP id 00721157ae682-80135256f21mr40236647b3.6.1781880419505;
        Fri, 19 Jun 2026 07:46:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-80116cb147dsm12869447b3.0.2026.06.19.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:46:59 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:46:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ajVWYdTThVic+O+f@nand.local>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <6e4a8764-3c56-42c8-a87e-40a94c6c34e9@gmail.com>
 <ajVPJGXuhugDcT+A@nand.local>
 <ec45260a-1d4e-49d1-9aa8-9ec94ecd9b23@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec45260a-1d4e-49d1-9aa8-9ec94ecd9b23@gmail.com>

On Fri, Jun 19, 2026 at 10:36:54AM -0400, Derrick Stolee wrote:
> On 6/19/2026 10:16 AM, Taylor Blau wrote:
> > On Fri, Jun 12, 2026 at 09:03:41AM -0400, Derrick Stolee wrote:
> >> On 6/2/2026 6:21 PM, Taylor Blau wrote:
> >>
> >>> As a result, we can see significantly reduced pack sizes from p5311
> >>> before this commit:
> >>
> >> I mentioned this before, but the pack _sizes_ aren't changing in this
> >> example. We are computing them more quickly, though.
> >
> > Thanks for pointing this out. The paragraph following the perf output
> > below correctly explains the results ("We get the same size of output
> > pack, but [...]"), but this one is obviously wrong.
> >
> >> Since we are testing --path-walk on both sides, the change across this
> >> commit is that we are using the bitmaps for the "counting objects" phase
> >> and then potentially using the --path-walk algorithm to construct the
> >> packfile.
> >
> > I'm not sure I agree here. Because we are using bitmaps, we're relying
> > on pack-reuse to construct the output pack, not --path-walk. I mentioned
> > in git-pack-objects(1), but the combination of seeing "--path-walk" and
> > "--use-bitmap-index" together only means that we will use a path-walk
> > traversal as fallback if we can't get an answer by relying on bitmaps.
>
> I guess my thought was that we'd construct bitmaps when they are
> available, but how do we walk objects to get the objects for commits
> that are not represented by bitmaps?

Good question, and we use the existing bitmap traversal (or the
boundary-based one, if enabled). In that case we really want something
that is topological and not path-based, so we can terminate the walk as
soon as we run into an existing set bit, or something on the negated
side of the query.

> But you make a good point: we don't need to do that for functional
> use: the bitmap code does an object walk to produce a bitmap, and it's
> all in a layer "below" the pack-objects code.
>
> So essentially, this _isn't_ a combined approach: it's "use bitmaps if
> we can, and fall back to --path-walk if we can't" which is changing
> from our previous behavior of "--path-walk means we don't try to use
> bitmaps".

Exactly!

Thanks,
Taylor

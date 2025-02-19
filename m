Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A12286280
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003777; cv=none; b=Fkcqxp5pZ7yBgphN6G8AP75aul+J2nz7p+msXCzZ/cZ+u9CY1jGaZZt39Z9ZRhPvrlwOt9OzPyWK2PB/Rn4Z3bFnJShGoBjqq0ri5p5XCJw0YLU6pUbsiDfvvqttqSdPemShcv7dlpa1EOQ+zvsa9xXJtOgKE7Sbgj2oXdbzxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003777; c=relaxed/simple;
	bh=AICZX2YN1ZqQyVS5rFtCkCVJoc7u+yTNxWkdl3yWUsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWXm1bvJA5bN8G/tLrwhHDvQT8pPjRsn/8QJKo6vgZRbTCwyzsaYWKj5wM34fTKTQPXCao79cvJNOgoZg4E70fdWiGIRBo4cXto5YkMhymCd7pqr7+34cFTvmrIIJu8zNPDKsiYcAe6r9ZkopEZgYJNXrMCQLNX/Z4OoIql2GAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7a17Sm8; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7a17Sm8"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f40a38cb6bso146340b6e.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 14:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740003774; x=1740608574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTRSFIgK0/TPA2UTN8Hazj0X6mWtm/Y9L4WM+AtF5LI=;
        b=c7a17Sm8RVQXtYQPrOsZ+iZd9vp82FzqIW82kVaaFK3RJQM4E380fYdLsSCvEta6Xc
         CCjBgnrVQlvjuTv7tHQIarQXwOrqXKf2hWkrkmrfXbHZ9Zqmom/bycFJeZBeiDtj2W6m
         3NXTHvTK5f4beoe9l5Zg349nXn1Yo/TVuqvp7fMbQa+xjubV851EWn2aJW8lAkm4lyRY
         HUmXB55ySgsoZ80+xtj3/zY1V7VEVWR7bVIxFb+e4Rv7XYXqocZCY0J38CXTFZ95CeFA
         mdeMe8ua67xzlJ3nADXM/V61tKhLNEqIGB1Bzv9Ti+RuqBDmeUgr43Vegh7neZqgb8I2
         WloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003774; x=1740608574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTRSFIgK0/TPA2UTN8Hazj0X6mWtm/Y9L4WM+AtF5LI=;
        b=eaedpk/+6G+4grnVDNJIujVJ+xbD2/hla9IwIwcJ8zyMckN2WBCa8oo/ae1OrWKtgg
         XW/7RT8cseaY2J72qLVd+oOGkBsxbe4C6MjXmMJnDSlOQbPv2Z7w1rTj8BInJphiLDwp
         EKUg3Edu0z3DcG5c76rT9aYOTM1lSJIaGezBeUcs0gWMwrWuLJKS76T88DjeBUxTGkw2
         R+pqkbgnb+y9gNMBUWx/SQqMaVjTna9dOze1iksJX1tVoCI7cygp04XB7/r+179zExpu
         OQhDD9KRd6zgILVYh24NZJrRNSd2LxPJYH5F976Pj1v9ZIkPST6RKE2pMDT5QEeW6p2D
         1zYQ==
X-Gm-Message-State: AOJu0YzwHUc4I/J+K3r/uY1E7GPCG210fn1AwlStPj4/cIsLKQ8/5ISd
	jLjQJx05hwnmR6/KQIWhUysxjl42gTGyrivUdrxEtP5GJuFHzDAV
X-Gm-Gg: ASbGncsU1LsL3zD4KTMH2xDO3EQPFgL7DOcYK3L29ihFBdXvZwtYDdthSvFBvyOZ3tT
	EqPndY2yYj/iWOC1aUTapbDHv/8wnrThYCWEN5sVNjvrjKHEKJGj1RmXsxgU4PnSOyX/Ue5uETe
	eiqMPacQa++smxfQmCH0rkOz4vzcBy4Dwb9CIP8vGG7UJunuEGw7u1997fcaK/1+RsuEj0s+83f
	nUsTmcvoU/V2cCw1mVikMpq60PnWsRRMSoIpxh158BlHBZ2fPQgeqegECjLxbdxIvKyykQWSbcR
	EEvSKsp+
X-Google-Smtp-Source: AGHT+IHLV0xcmpfFcGVhLxCtYpp9dH42BnSEGEzLBMXJ96EBEBNeoFbLQvx+SkWqKp3KPPkE15Ht/w==
X-Received: by 2002:a05:6808:2210:b0:3f3:e8e7:2001 with SMTP id 5614622812f47-3f40f24db67mr4510183b6e.26.1740003773972;
        Wed, 19 Feb 2025 14:22:53 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3f3f9319cb8sm2267959b6e.16.2025.02.19.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 14:22:53 -0800 (PST)
Date: Wed, 19 Feb 2025 16:19:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
Message-ID: <5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
 <xmqqldubumxf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldubumxf.fsf@gitster.g>

On 25/02/12 08:50AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > +NOTES
> > +----
> > +
> > +`diff-pairs` should handle any input generated by `diff-tree --raw -z`.
> > +It may choke or otherwise misbehave on output from `diff-files`, etc.
> > +
> > +Here's an incomplete list of things that `diff-pairs` could do, but
> > +doesn't (mostly in the name of simplicity):
> > +
> > + - Only `-z` input is accepted, not normal `--raw` input.
> > +
> > + - Abbreviated sha1s are rejected in the input from `diff-tree`; if you
> > +   want to abbreviate the output, you can pass `--abbrev` to
> > +   `diff-pairs`.
> > +
> > + - Pathspecs are not handled by `diff-pairs`; you can limit the diff via
> > +   the initial `diff-tree` invocation.
> 
> Which of the above limitations are fundamental, and which are merely
> due to incomplete implementation that could be improved in the
> future iterations?  

Thinking about this some more, I'm a bit unsure whether
git-diff-pairs(1) should support "normal" `--raw` input. Furthermore, if
we do want to support it, maybe it should be the default?

From my perspective, ultimately I don't think there is much additional
value provided by supporting multiple input options for
git-diff-pairs(1) since the end result would be the same and its just an
intermediate format. As I see it, the benefit of the NUL delimited raw
diff ouput format is that it is a bit simpler to parse and likely a bit
more efficient as it wouldn't have to deal with unquoting paths with
special characters. The benefit of the "normal" raw format is probably
that it is the more intuitive default option.

I'm certainly interested in what folks think about this :)

For abbreviated object IDs, supporting them would make the input format
more flexible, but it would be simpler to just require the full OID be
provided thus making the input format more explicit. My current thinking
is to leave this unless others think it would be useful to support.

Regarding pathspec support, being that git-diff-pairs(1) operates solely
on the provided set of file pairs produced via some other Git operation,
I don't think further limiting would provide much additional value
either. If we do want this though, I think support could be added in the
future.

> Without reading the code deeply, a lot of them
> look like merely due to this iteration being at a WIP state and not
> quite ready for the general public.
> 
> What is especially curious is the reason why it is limited to
> diff-tree (by the way, don't you require '-r' if you are fed
> 'diff-tree' output, or are you prepared to expand tree objects in
> the input yourself?).

The tree objects in the input are not expanded. With `git diff-pairs
--raw` these objects are just printed again. With the `--patch` option,
they are just ommitted.

> I can guess that the 0{40} object names in the postimage to signal
> paths with working tree changes unadded to the index is something
> this fundamentally cannot work with, but you should be able to grok
> 'diff-index --cached', which does not have that issue, just fine.

I'll rework the documentation in the next version. git-diff-tree(1) is
the command I have in mind as the common usecase to use in combination
with git-diff-pairs(1), but it is not solely limited to it. As you
mentioned, there are other commands that could be used to provide input
here.

> > diff --git a/Documentation/meson.build b/Documentation/meson.build
> > index ead8e48213..e5ee177022 100644
> > --- a/Documentation/meson.build
> > +++ b/Documentation/meson.build
> > @@ -41,6 +41,7 @@ manpages = {
> >    'git-diagnose.adoc' : 1,
> >    'git-diff-files.adoc' : 1,
> >    'git-diff-index.adoc' : 1,
> > +  'git-diff-pairs.adoc' : 1,
> >    'git-difftool.adoc' : 1,
> >    'git-diff-tree.adoc' : 1,
> >    'git-diff.adoc' : 1,
> 
> This apparently does not apply to 'master' and the base at least
> needs to contain 1f010d6b (doc: use .adoc extension for AsciiDoc
> files, 2025-01-20).  Please clearly mark the series as such in the
> cover letter if the series is not built on top of recent 'master'
> (or 'maint' if it is a series to fix breakage, but it does not apply
> to this series).

Will do

Thanks
-Justin

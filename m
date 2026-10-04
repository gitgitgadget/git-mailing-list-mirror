Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D2364929
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791131131; cv=none; b=aNYX1BckXvsAzLxsWXviMQ9KGHBZAjYtwLhqBAjhFMKbd5qcbYiX1xD3zMSj3VmgIAoQ2K7TOsDIWHg9GWNYlKKpGvoYI8Zp6AgMTQbiSlH1ba1O2iJ4Vb5DqA7QDrg0qwsO6+b0TzPJx7MoLJPr27LCD0OfMdzsj8vTVFkLFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791131131; c=relaxed/simple;
	bh=PUIisq8fPM8r4kIvtpGDzZjN7H2H5zC9N/BSmk8u+AI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rM7gLm8NfgMZreMeEJtzR76vKYuOz3SfkXhgB+MCxmTUVJafpiXXbNdvJVi6M71c+1aGj+L8ne+VcgGL48dHsHj/+KX+MkYHafYxsUMUZZha/1jGfswB90w2AbfOtEmLfMQLZTTYPMAA6R1DaA2QTBOYYIBWrHu9J1vwjZry55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=noT/HP+0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQQ9A3Xn; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="noT/HP+0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQQ9A3Xn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F75F7A017E
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 12:25:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 04 Oct 2026 12:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791131128;
	 x=1791217528; bh=U3GfCTLzoQh7vzdwt1B3dQFjQG/QKghCpsmw5QV2CLY=; b=
	noT/HP+0DYofPiHtxCUh5iok5TUCKhARtfyfLe6KGZu/aFJuNxla3KfphLcj6o64
	0n45/QLss5l6KDtXZNC5VFLjq+WKZ9P+Rw+4kltkK/ZExd2nrgp3nydHZMRouW33
	LoLwTnE4e5cYuQN76sos65nnh36AYTm6ua+jdf1QGUlC9u/jd+hRX97FKrD1E582
	pXh97uq+KCae1SM38g52RUJRIIT44IBcV2BhGhO+P88h4yqaPHmJ43VWJ3VjH5Wu
	B9W4gm9zt4PAVZirdP+C1Y9fERcy9wxO+B5GxTf4XQ4kDM1KvVG0U052kttcnfso
	rnuqmbOlEKI+d/249bU4IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791131128; x=
	1791217528; bh=U3GfCTLzoQh7vzdwt1B3dQFjQG/QKghCpsmw5QV2CLY=; b=s
	QQ9A3XnCL09fSTU67t9aQ+b0zVmNxFVt9Nk3SQDAstyZmR/+LRu0m10Stb8nx7IS
	entlybdlBrcKY98UITML2nArm8hD9IqjlhS8R1XThq3YfA9I3VtN0HIExX7iis+X
	m82+6SkOISXka8t5lfZpJdyjPKaDiMXU5Q7C8WZb3gEiUysm4Iwt9vFC/Tnfv813
	aDkyJ6Wt4x9wTrU2TG1K0ICnxURLRg7ZfUT+xkQettLT7dcnECP6WML9F1fuYITw
	zhdMm4rRJRqN0nqPtC6mME/UrWkQ4/W6JK0kzXKK5EI9aUcs2A3n8gvjf3/icfSe
	3Zwrx0bD2jo/LMMZ+jQbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791131128; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:F2SmdXOSC4D9QOMKTVV6/OH0YSvCZuvNphjLohxP3iiYhd0
	Jp/t7J1lmd7IvfzH5LaEUB7eCff7QLcn4i1KEXFXa7kSJF2VupBtHVsEsPC8kMTB
	rgAn1nkShucy3n8+wozFE1bwDILD5em6PZPy1TackNVdGDjmLsUo/deN93Mhr8CG
	2m4wse0WXNFjbVU88zWPqnwRSBtHqVlKFFu4E9ZgOh5CxKyjrbC4rFDl+wMEaalp
	5BxJROdPr2WmlvSsLdq+tJugmWPms12WkqHQ+0lX6GE9IpiEMd60uxaS02BJzspg
	LN+5/3w7EqwzFuj8FFB2PTpRQmbAbBpNMnAAUWQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:Uxy8ho0bPgenqsylOB++Q6w9KDKx2TuB1QREhFKMlDU=:PUIisq8fPM8r4kIvtpGDzZjN7H2H5zC9N/BSmk8u+AI=;
X-ME-Sender: <xms:-H3CaqT-ARXmWfaMMw747QCPt5WJkowP8Dw-64NSOX9lGROt7oO1OQ>
    <xme:-H3Camqq_c4kBus__jzkCxuP-hY4r25OoB5dXxTY398gsTafid8HCiqgoj23iacVN
    ZlKRMuP1WGjUIaLO2x_Cu_RbtLjMjW4T6rMvkM94KQtqwR2MoMhvg>
X-ME-Received: <xmr:-H3CagJe57FLlbBlyf_-VP84yEg_UKpYNu8Ssbt9zDSOzG62fkyMlH1NvRWxkPpQsqZW_lOMk7WFsoaJElDCoBOOM4yoyYE4YuKL>
X-ME-Proxy-Cause: dmFkZTG2oDs4hZLkaYWZKFpHwrquwR3rw0LINeUU/u7JVETAaCd11hwBGswaJekpCUq9Y6
    n56YtwpBiv6TI7OFS8e0krv29agUbmrpOtQdw4zT4jtMM2aes06WwoQx8i1p0snbjH9hJ4
    fe/KFNFnfR2cddschys6jYrZu/aTsarVxIyNCQi/zXfCk+nKf8vvnFllJs+bCWBYJ2frCH
    qCzAZeWkZGku3lAap2krBtPx/x5QYqoXLJD7qxpNTWFUHmt+JfXskqzmM1eSKPWXpEi14g
    ifyEshUACmA2XH5HIXw0Jv9SK3ZRNWciLFHT7fB0QEYKat3daipk+hydzsvq8kuObA5spD
    I9TPKVntELRibf1exG+DCiBTTmKee8caqDe8UdZw+tEK4ol/GHBfQ6Xw2wvNbzSilNnI9/
    gVnylE/RH9Masyc4VLXcJG+DcGQirEoCIqMdJecVcOo78e+eyMPOq7pBmP0DBA1935eW9S
    JKbqEhAWBp6U+/VgsQDConZJNh75tD5UANCHPeX2HVq9qZHVctudebEFOTykv2w57lftuj
    wRhNZ5AooIqanI1Li6Zd2cTMfG59IL8LBPu2ipkb74JCLjZOnREC+TD+hqTOr8QCGcGH2t
    Mk+jlfqATMFPax1C8hFzp7C3oj2wYsQ/4a/LIiZ5zrjMw9dzsJK02Cfp+Qsg
X-ME-Proxy: <xmx:-H3Cahr9cYlw4pQp7NBG0K8Ii2jKfUpxvtRIxXN5BRz0kaxKA03F1Q>
    <xmx:-H3Cagzd-wO-Z77J2hNjqOkOY4S8_AoqDD27U9a2RjHpcCSSo1bZsw>
    <xmx:-H3CatM_4i2YZNP6eXBEdmC5iWFetslDTA3mCc6bxNOOeFUlEYJVNg>
    <xmx:-H3Cat4GavUKhFOmkWiHH7pSOP9OhwA-t0MgmaDzfVHCguRJAIN7lg>
    <xmx:-H3Cas4DrKaxuXMnXTGyyLHz4vO_qpW8Pz3O0o9t6TABFoaJmlAb2aKh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 12:25:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  "D .
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 2/2] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <V4_format-patch_learn_--range-diff-notes.d5e@m5gid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 4 Oct 2026
	12:17:54 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz>
	<V4_format-patch_learn_--range-diff-notes.d5e@m5gid.xyz>
Date: Sun, 04 Oct 2026 09:25:26 -0700
Message-ID: <xmqqqzi5touh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> git-format-patch(1) passes on the notes behavior that it is using for
> the patches to git-range-diff(1). In turn you get the same Git notes
> displayed in the range diff as the ones you used to generate the
> patches. And that makes sense in most cases.
>
> However, I often make notes between series versions that mostly prepend
> to the original. They end up looking like this:
>
>     v3:
>     [desc.]
>     v2:
>     [descr.]
>     v1:
>     [descr.]
>
> These notes are meant for the git-format-patch(1) output since they
> document the iterations. But including them also includes them in the
> range diff. And they have nothing useful to say there.
>
> Let’s teach git-format-patch(1) `--[no-]range-diff-notes` so that we
> can pass in different notes refs to the range diff, or just turn them
> off entirely.
>
> In addition to storing the list of notes, we also need a boolean
> `override` to distinguish these two cases:
>
> 1. No such options were given and empty list (use `--notes`)
> 2. Options were given and empty list (`--no-...` given; don’t use notes)

Nicely described.

> ***
> Note that using `--creation-factor` without `--range-diff` will cause
> the command to die. But this is not the case for `--[no-]range-diff-
> notes`; we would have to check `rdiff_notes.override`, which is a sticky
> value (cannot be turned off). The reason is that it is potentially
> inconvenient to error out since it would not let you turn off
> `--range-diff` in, say, some alias that uses `--no-range-diff-
> notes`. Granted, it is difficult for me to come up with a concrete use
> case since `--range-diff` requires a value, specifically a value which
> is probably not that reusable (revision range), and yet you have
> something like an alias set up with it. But why spend code closing
> that door? There is no usability upside to erroring out.

In short, do you mean something like this?

  Unlike `--creation-factor`, `--[no-]range-diff-notes` does not
  error out when used without `--range-diff`.  This flexibility
  accommodates workflows where users might configure default options
  in aliases or wrapper scripts, allowing `--range-diff` to be
  toggled independently.

I suspect that erroring out when only creation-factor is given,
perhaps via an alias, was a design mistake.  A user who wants to use
a setting customized for their workflow must resort to an alias
because there is no configuration variable to control its default.
In that light, the same argument for --[no-]range-diff-notes applies
here.  On the other hand, perhaps if we had a configuration variable
to control which notes are compared in range-diff and shown in the
output, we would not have to worry about these things.  I do not
know.

Other than that (no, not the "shall we also add a configuration?",
which I consider is outside the topic, but the overly verbose log
message that gives wandering thought process that does not help the
readers with crisp reasoning that leads to the decision which they
may or may not agree with), it looks good.

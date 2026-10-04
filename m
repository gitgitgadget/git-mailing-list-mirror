Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75C44A414
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136750; cv=none; b=LNhwYbTgVp6Q9OOVyXsyrnuyBc5GkVgQd6EjhWOTxzqB0Pmi3JvdfZ2nEk+8FjQvwPWryyxUxIwiCe63qwnDuGvJNkOakU90q+ZRGxRHGwLvjb7cexcBOAV1zHSWaOvrmB4HqMmht45T2ap2p6AObtMISWuuPEfUtnwg+f6FO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136750; c=relaxed/simple;
	bh=hSUispjP7B2/NXtA8vPPXEO1oJILdD+2xNy8qskN3Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEcIEG/ku2IoGd68dvCVt+34YQ3zm8OpfeuQlJGe2w7+7qYV+qUZKkcxNElCuW2RoNDQwLvW7GqW4qtoUbHFIppiCMQLHHc7ee+aZoDxt/uyc+psZHVDXzs+GQOmEi48MTdiZyTAKXgn2jyalqkT74vCmy9h9EkV57uxH98INhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=umYZRvWF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUzA1z8D; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="umYZRvWF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUzA1z8D"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C4FEFEC03AA
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:59:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 04 Oct 2026 13:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791136744;
	 x=1791223144; bh=bxF1L1JD6hZnPm5hrfD6JwheNCUxX1G/GGrxMszIQxc=; b=
	umYZRvWFOQLPqL0zTK6UGd0nt0KKYOX23GJuIhu93+GPa1NFwsZvnmCHEKgkJWPy
	MsMt+IcTKtby+q0YxrGTrqUuJ8jR1G8QjFKoiL+vz9eo1kWeV3ah/gN/Q2pnfbaX
	1yp6E2tMqvfeiBB/godUitPk1TH+L4Hn0rQKBOWWxNTcbqkJN8AVtGcz0GNYy5lO
	smDSNiDK3DpM62AgcSYJ165q/k/3duVhJtGZNYpqScm6W0kol2gDjDyhLrAdiKdt
	amJQkh1qEYvTqBD20YZZ/7xZgYpiXlLANMn6vJdkmL1JCw79gmVbDhpbzkLxPL6W
	Ni7rVxXQPpHNchOVY8klxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791136744; x=
	1791223144; bh=bxF1L1JD6hZnPm5hrfD6JwheNCUxX1G/GGrxMszIQxc=; b=i
	UzA1z8Dd4t/Z+Z9upYK0OcOyX3WbHMIAIdR2WN/pY4ZeAPK6CxPeDp1AM3OSXCsM
	Fz7eXe4Fs5ikmLvUcUIyGmJFtjkPh0pkDeY4guODJo2Xy0L7rNQrXTadAaIntJ5S
	U4ZHOyGjzLKw21KsO/cgIvqq5bWwZihthUnksVWSp7Ffab49G9t7WuYpQ9Bz87VQ
	JUo6FLtXAdsFXYcKrgFmgVBm73vQjTPUoxFyNCfI88X4Hs1XNSN7/JCm3NxCUsm3
	qTVahrrSqfqTp9yAuNNulOtERXRNI131raS3ET/cNlkVbm4QV+SUrlMTMiwCQleK
	4AzeLU+IEMdhhAzOkg8lg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791136744; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WVMZgyahA1ZU6m3jmIndxpaC5ihRyaRO35WwYEJr8uFb9Qt
	+b6Wcd9/kFjRjSwM08upFWHp0e6B0ubYKrUn4iG3PLiLiAkcDPVvXiG/bO9jey/J
	RCmDdAPJo+TxOVQwJyq0jt4Q7EzrD5J8ZJcohny6bw2+hiCN/T1Nuq0ipm28owhp
	ILq9AoHAYGIdW8QZq+Myf6Rs86FIp3Tv1Cf7bVymvxJ7v4In0beH2u0+W++sA9/R
	c6Y2+6fLTTYYlSk9fMLIm5graAArVaqK1W2ksh0WPrDstMgmHhHSf+9Vw3KkZtNI
	N4gmLdPgHcLjkT9rkTfdwxWRJxro8/W5hbHTlgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uTTYSMGLAFSeIlV7mM9BuctYJEsgm2yo078qmMqSYU0=:hSUispjP7B2/NXtA8vPPXEO1oJILdD+2xNy8qskN3Eo=;
X-ME-Sender: <xms:6JPCasD9evSMjke3MX3X4bAxBNbIWfcdo4xv3lw2hQyB9dh7dLZmgYs>
    <xme:6JPCalhLh2gc0gbwCqp2AJ89xR5VlzksW5WgP9dO1nu6VUFHoKhgpRUvco0z7LGHt
    g7YDIChEnulsq-eAgp8oIXi-23P62tESiLlBxJvJKeIVawhx1VmVhaR>
X-ME-Received: <xmr:6JPCakkyVkKPOcPEvuVkycQA47pZqVK-UqQdnKw9pRliHq1Cy-ff2cMm6511nrod17dJL7KRqSMn9sKyB4EtUq_LV8NInil4JZlVpYtvG0NOYqywtJNtrHw>
X-ME-Proxy-Cause: dmFkZTENFgYuwOe1/FJ1rM5UVm9xDKw8RXCljyKpSOhxLr0JavbT3iwW4UZ+3UsDO4zkjD
    TxGTzqZwXS6/hp5uWZjmZWsA8TeCHaYgjIGzVCl3qm2FwDRVtL51iOj6Qm7l2YGY6HzzpX
    OSL7MVoBWirxPEkEfPKJxTgMMiHP53uRrie+Cxlyi/+/L3Fi+SgdevZImdBn0HsePaleXF
    UQlgCpOpmSMN6GWVeZjT+BWgy3KEgtWiZa1Z+AE7czUjuHX+0XgDqqLpfkQuORDyMBDIrD
    /fhpNdgn04I1ApSwpf6lRnDo7LvFqWf/afAvF3Khy0t2jdtyQgRKRnx+jsnLQrUnPh4is5
    I6CHb0rBOLcgt3Cx4PlSTRMhm0BDxImpNPgDLf9665Q/JT6pqHiJFcFToBtdRdzb9Awcsc
    WeW959bo3dzCEKivt3eSpV6LPrY7HrBVsCzSL57glrKXyNXq6dQuj6M6CIOeZ8Sq1p2w5W
    3Jk/1v4bnPPQJ1QT7GOOJmIJ6bU6caXSHBMFPmQi7JE1BzOCKSKS16P1sDjnlkQl2PN0bR
    q4pueeSW9lNGho4bAccUZXvlluIZr4rvKa0gxbkpgJW7yF3o452bQsPBAXL+43aZD2dFH7
    dqpoEo+WKVqTUsKMZCm8nF/arWBQq3ukCgy0M6rIv9nRyhev6GxNRga637eA
X-ME-Proxy: <xmx:6JPCahoNTTJfx85oop3tN2Y_qKpsjrytovweHa8LW58gILMF8ubchg>
    <xmx:6JPCatElzfEA7dVfjvoUtr4rKJgveAGltcTmRCJsIYAu4WfklNQRAg>
    <xmx:6JPCatwtla04PtnbPho3_37HL99z_4rPF85WqBAPlFFbrXQwaVZMng>
    <xmx:6JPCaipCc4a2T2LC_Dd6YdkJ2Oxuik61EfS0MI4vfbUpykp-NnVNlw>
    <xmx:6JPCasGt6gGVDvTKPGUQ71dbmlhmQi0bMM5DvUjU-mlJueg3XTGILTJs>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 13:59:03 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/2] format-patch: learn --[no-]range-diff-notes
Date: Sun,  4 Oct 2026 19:58:33 +0200
Message-ID: <V5_CV_format-patch_learn_--range-diff-notes.d6b@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/format-patch-range-diff-notes

Topic summary: Teach 'format-patch' options to tweak notes output in the
range diff independent of what notes are output in the patches.

See patch 2/2 for details.

This is motivated by wanting to turn off range diff notes, but the goal
here is to implement it in full generality.

(How many of us `git format-patch --notes` users are there out there? More
than a dozen? Maybe just D. Ben Knoble and me?)

I have implemented this behavior for myself and used it for many
months. But that was hacky and only suitable for one person’s use.
So this is a completely new implementation. In other words: this is
new code, *not* tested for months.

§ Changes in v5

Patch 2/2:

• Msg: Shorten paragraph about “why not error out like
  --creation-factor...” while keeping the exact same
  information.[1]
  🔗 1: https://lore.kernel.org/git/xmqqqzi5touh.fsf@gitster.g/
• Msg: ... Also drop the thematic breaks (***). I think the
  paragraphs flow well enough now to the point that they are not
  needed.

§ Link to v4

https://lore.kernel.org/git/V4_CV_format-patch_learn_--range-diff-notes.d5c@m5gid.xyz/

[1/2] format-patch: simplify get_notes_arg parameters
[2/2] format-patch: learn --[no-]range-diff-notes

 Documentation/git-format-patch.adoc | 11 ++++
 builtin/log.c                       | 50 +++++++++++++++--
 t/t3206-range-diff.sh               | 86 +++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 6 deletions(-)

Interdiff against v4:
Range-diff against v4:
1:  bb60f300d3f = 1:  bb60f300d3f format-patch: simplify get_notes_arg parameters
2:  4cbd312fec6 ! 2:  676361b383e format-patch: learn --[no-]range-diff-notes
    @@ Commit message
         1. No such options were given and empty list (use `--notes`)
         2. Options were given and empty list (`--no-...` given; don’t use notes)
     
    -    ***
    -
    -    Note that using `--creation-factor` without `--range-diff` will cause
    -    the command to die. But this is not the case for `--[no-]range-diff-
    -    notes`; we would have to check `rdiff_notes.override`, which is a sticky
    -    value (cannot be turned off). The reason is that it is potentially
    -    inconvenient to error out since it would not let you turn off
    -    `--range-diff` in, say, some alias that uses `--no-range-diff-
    -    notes`. Granted, it is difficult for me to come up with a concrete use
    -    case since `--range-diff` requires a value, specifically a value which
    -    is probably not that reusable (revision range), and yet you have
    -    something like an alias set up with it. But why spend code closing
    -    that door? There is no usability upside to erroring out.
    -
    -    ***
    +    Unlike `--creation-factor`, `--[no-]range-diff-notes` does not error out
    +    when used without `--range-diff`. This flexibility accommodates
    +    workflows where users might configure default options in aliases or
    +    wrapper scripts, allowing `--range-diff` to be toggled independently.
     
         Add two tests here for the single-patch case, i.e. the case where the
         range diff is on the patch and not in the cover letter. These are meant

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.793.gc667de3f2c5


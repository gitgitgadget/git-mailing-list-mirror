Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578EB3AC0D3
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465675; cv=none; b=bRp4R/hZzSb+hkSxz0OX3MtD2MNSlbM2fx6T0bEImKx5MT8Tx5Yf8k9N50YHMhuDoYJ4EEWHtpKYu1go7/hxQZ12uE/JovcyWGtloXFa5GDS30uGbuV7CqLbXXybA661Cqs4VECJbTjW9oEn6DV8i0t7hZVqixYL7ue6VLffQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465675; c=relaxed/simple;
	bh=tJKega1crHFNJeqKgD//wpj2vGvqY35N1ioSyCp23Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGqP5uoQYaLhCGXxTCcfeLrtmrnxWI1TPM6CjHkShrZaVNDHUnaobEopXDNWM9iEeCE952SdlS1f4Z+b1V3x/v3OrURfC56K+qjTv6ic8QJn99U6RY97MtxUDIV6AU9IPj8EmBdzuFFV+mMNXtUS4X6oS0PEu+0RWfAdKbQnP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxvzeAJF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ax9ZaWr0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxvzeAJF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ax9ZaWr0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F423EC016D;
	Tue, 11 Aug 2026 12:27:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 12:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786465673;
	 x=1786552073; bh=VWFXv0z/84Ax4fyVW1CbK/Q6AQkP3dzfcC0uG1a84N0=; b=
	GxvzeAJFeZEVIQ2oRp/KK+W9gko+uutRtFuXyP4SDfZbPYf7gQaer9dgdYSIY2Mm
	WHuABul8mrLfyVCqjXwz3/obYOAKTCCIridquYhBaXhytXgSXCTnUug+5rQpzgp6
	Ofq1naIOZSvprxUb45OHLDIiK7nRnoScFEc7DLyamt5ZCFSZk7Tcko2gYACgbVsF
	THjdL2qbFeEtc07y1fxF4RLakDiIeBIJZM5SAa7f9KDboATaO6lTDlNNrxh19BVB
	rxyYdMjtKQRkz0+kvbfTWswPh5t2ObSS97v2g3C4xzaBGHaAKM4Dhv/x9cc/QtnQ
	AWTyo3f9snG7GMv3HEnR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786465673; x=
	1786552073; bh=VWFXv0z/84Ax4fyVW1CbK/Q6AQkP3dzfcC0uG1a84N0=; b=a
	x9ZaWr0/nxWN6Cj71sx2rtwh9HTIzF5wp9lihDHTFQxZlUn09jFcYsfUhlLXBonj
	4QaVQvPEd6cHFcjlRv/2TboLbFqY4Ry2LtskkBVVPY669Aqkt6oW15QioUdJu9vI
	M3MCX6b3c19A2zvMwfcDTcb7byNrMZ91mhKqmrvnYgP1ggL+3saT60F+4C07CxcN
	gJt7Hh9vSV930FcMKYKPfx887aBnDABTwPm0rP1Q1H9k5WSy24Xt0S3d31e8sGeS
	IKyR3zkPXoR5066qfNKMMaNP/U8ir+CFrHiXY27wWqG81evpTel71N6XbY+DPSDx
	oaqYfjWhVOV71RJdbb3WA==
X-ME-Sender: <xms:iU17akic1bo-T3Bc_7IbfLvJvz5h2rijZNr6RCOaES02ArCEFYdM5Q>
    <xme:iU17ajDaT9LpqRXk8l1ZNZCZPU5-Lt1lZFU9P3jgAdME_sjLPnh3W2mdHtb9mTyez
    aEt22026kbyTs_kURZoz1u8O0NOMdvEBc-wU2-wvKxWWmwUtWkbyw>
X-ME-Received: <xmr:iU17apv8j0KqZ0_NY4aS-Lyj0mJf5EgL19K0JgyqgGM6zecVL_M0BgidbHv9hYm0ysUA5q6BbiT29QYOZODgR92LwhuEUwD6aefJtLcO7A>
X-ME-Proxy-Cause: dmFkZTElR3W7pv9CIrYzxWccBfiDAOC+vwhGAnUatSzeI1ePYIyhCk+nxRAhdNvcSE6T53
    b8FpifFTJbqH1a7qj5ybaHg75A03L3XlZo7+/2MNI/NYMAWk6+3vKvPelPls/+TGFnBHop
    zKU/ZY+zD/kQFTYLdkdeKGpcOxMuqHIqEgT3gKodAtyjKtm3YkjvKWPh3clE1Mr/NLplnj
    XIMCXo2I3sFb2wHEiJ/WBWOkn0EQNIYgLSx1YneEbpudmpvzoli8LU5tObxfFfW8Rp1d/1
    0/47flAsFnV7G5uixW0XyrSfHbBwWVAsz5tASLoM87AN+el1+eiOjVUrNhCwmz7QxR4SJ2
    GJBCM6pOl4OaKfA2qGCs4K7X8nGEFwJsrXBdNBap48gUJFJ539/hr+fCLdHYIFwrXXzaGN
    pY4KrvFcoaqryRbUkr3kCM+uCYDUJIQPm8HHeF9qahQyFOmDa5Dlltg5W5tN+IROi2Oo/W
    CDLNg51mLtsTnX8cSMETy5jsxFaA50oqRf5YtGEZ7tNJOfINO5cYacEFX480KfgbIvJVaA
    9AV8QN2m5befc/Pctok8R5ejmqaXdi4bJFyW3IqpI0Xeol5MCrjKgRLCy6XlHhAcLlIK5P
    z9v0HHsD3IGtVNepXpDXWtwrlNVWTp/Hb5D0XTn4VrwCuEHhksM/lfZVAZ7w
X-ME-Proxy: <xmx:iU17agYZACUqDqQm0s3MA2Ht5qfvuuNJKS_nK5dJL8Sa8mFfdmb_3Q>
    <xmx:iU17akWJ1AZHHL_PQjukKlquDpqApg7aRs2zDQ6KoiN3-q3LaJigdw>
    <xmx:iU17as5bBtuVh9nL9lVEr6CfwqBhilkSoGtKI-84OF8Bxe-qEoqsJA>
    <xmx:iU17anjdrBkakZYzihkl5TmpSY-KQvFGe4IcYfx-THH1mL3VN5JK4g>
    <xmx:iU17an5u1vo_ycupoDzBGgQSSq7ThHebPR8do7dDKB9_6CHt_T9Hkocg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:27:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c24f5a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Aug 2026 16:27:51 +0000 (UTC)
Date: Tue, 11 Aug 2026 18:27:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH resend] doc: format-rev: use [synopsis] on code block
Message-ID: <antNhDECvV5Kynsy@pks.im>
References: <synopsis_block.af9@msgid.xyz>
 <synopsis_block.b37@msgid.xyz>
 <ansWZxZ6lB0tYIJD@pks.im>
 <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>

On Tue, Aug 11, 2026 at 06:23:18PM +0200, Kristoffer Haugsbakk wrote:
> On Tue, Aug 11, 2026, at 14:32, Patrick Steinhardt wrote:
> > On Mon, Aug 10, 2026 at 06:58:05PM +0200,
> > kristofferhaugsbakk@fastmail.com wrote:
> >> diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
> >> index 505a52feccd..836ba4b0c24 100644
> >> --- a/Documentation/git-format-rev.adoc
> >> +++ b/Documentation/git-format-rev.adoc
> >> @@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
> >>  formatted commit, i.e. the format `%s` would transform some commit
> >>  object name to `<subject>` without any termination. Like this:
> >>
> >> +[synopsis]
> >>  ----
> >>  Did we not fix this in "<subject>"?
> >>  ----
> >
> > Hm. I was always under the impression that `[synopsis]` is used as
> > exactly that, so it surprises me a bit that you want to use it for a
> > random block that doesn't look like one at all. But going through our
> > docs (like for example git-blame(1)) I see that we also do this for
> > other non-synopsis-like blocks, so maybe this is fine?
> 
> To be clear, it’s not this kind of [synopsis]:
> 
>     [synopsis]
>     git blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
> 
> This [synopsis] is for a code block to highlight <subject> just like how
> <subject> is highlighted in running text when using (_) or (`).

Ah, so we have different kinds of synopsis depending on what it applies
to?

> > There's probably a good reason for this, but can't we instead just use
> > backticks to make `<subject>` render the exact same as four lines above?
> 
> It’s a code block and the literal text is supposed to use quotation
> marks.
> 
> Well. I wrote the text to mean that subject is supposed to be quoted. So
> perhaps I should have written `"%s"` instead of `"%s"`:
> 
>      i.e. the format `"%s"` would transform some commit object name to
>      `"<subject>"` without any termination. Like this: ...

Makes sense, thanks!

Patrick

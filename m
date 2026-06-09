Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BD5B21A
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986867; cv=none; b=I31boTv03HOWs0V/DiqCHrEjcE+ryZxW+PVTxnctyPDrDiij2CvpEog/clr3CYdUsY15S/ypXG/WIX8/ahozH9BAKGKa+egfqS0dtikH5J866iKugaVUOCZOyVyA8fSQNDEgXpyRTgnjpiErbTtIpH8+iqxxy1NEyefEon76+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986867; c=relaxed/simple;
	bh=+HdLbm3PrvO/qugC79n8hollNYvqIrSWrspqHKYt/pg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bKGDKgL8nCD291VriP9REXvJPgoe70xCnugEBLgUAjYJzZeN4tCiMtnQgQnfmwZtFi3/x57L3pqyu0JKqAaAAAltHSaLg6BgJVN03uSVOGNmo6yXJcxXQRqUYtmtsv1RPhVRjS4lQi4MP06u6XjTF6d0rZCvzVZpWTUpK5MGLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pleceCzJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q08lLkJo; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pleceCzJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q08lLkJo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69D877A01A9;
	Tue,  9 Jun 2026 02:34:24 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 02:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780986864;
	 x=1781073264; bh=70ilj7nqaJtilRw+zHjk90daM43u046LecBxbRRwBaM=; b=
	pleceCzJ3tasy2/EMwwvgY7z93Jvqf6SoAw9nDbT8SY0d86RmK/9ziFpZi5xsUfD
	ycUEtFlyyZ7hD1+VepyJLPejCbSKzYBri5aS2wlx/14V1OpmSGKCaB4wjgTBLPDd
	JFr7riG9Hn/J8Y737n2FrQv9wiHVRzqF0ZwJfVqvyduxYR08KyEVzSO+BWFvbq3L
	PzIJ4efWrAnL/ohdGm3IdKDFshzCkFbKPKvZ5VlYugMm0GRsctVXl1/qeSlU1kpK
	91WIeC/PfNdoBz1G7G5PTeWUB4OU6QkzNWk/lEB1Vk6PHPqyO/tVcW14oVmFebsC
	GaXbDvs+5380DWbRpNVhnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780986864; x=1781073264; bh=7
	0ilj7nqaJtilRw+zHjk90daM43u046LecBxbRRwBaM=; b=Q08lLkJo1NWPJveax
	1oQVUY4C4y2oI7a4cBty0exwD/y5oMCuyDei5KXQcoU0l4Y8pHXRMDi4207WByki
	ewIg4F+jlMixCi1b2kVWkca5r1JSsvQLe6x78enN+ZEugazR/oM9dUoRdOW00a49
	4kD+4tZ9/rtJVuMKGshdwIyzj65quF+krX/qQg+25LRFJKFCeBLoclldsT/u707p
	wZ+abvyckSyVPqTTKT8yMXlJitT8tchQJBS+KlbdJ2P2h/it9/84pEmPLgJFtsbI
	2oAANafIeTZDhycSnrEaLd6bfdrMj3fonfCPT97JMce7y2NlsMsovjeyui+U/sdn
	jX6HA==
X-ME-Sender: <xms:8LMnai9mE1JqESTWu7wt8veN0J9w4HKWwUr8j45B85tGcVKT2UXlBDE>
    <xme:8LMnatiP8zA9DFtiwqLNuS-zoQ9AH8zAsDiS1MTPu_hvXPPvyRwh5OnS8SiX74x1w
    3fwhtL3XA-Zo9u_eJxFyGPpNlfE5CiPWdn3KDjJt3f1tXs-nsA-iw>
X-ME-Proxy-Cause: dmFkZTEwtdm5OWnMNILoC1EW/UPDKzwGM7E/aLrQJrsRyUMGETN7+V/7kpaHIfNc2gjk15
    OancAUB7kwMIUQlozYr2yxSVC5hpjW6eLYBIs5xKyL10lPu1j1UwFfsxMu5ryrfvDxrGZc
    vBBg67nSwCNOUvDWBoQpgwcevgMSG4nH90xq+qul9JkB2wr3MdHtdC2apSCMuJUdGy1inL
    DNP6P5l5mgFaLveGN/Jxv7ryUofthDQEcCjQR9YbuMhgjcQa0BFX3wVfQc1OXPCJC1S/V5
    yxWg0wT5WAv/n9q36Nu8HIVHaT8cS89dd7xNOGZiHJxavOli0SAr5Yt5JzTKba8+ctwHk+
    DK9x72hi1q0GAwIByrHbbm8e7r9K9DITK6gRS3QWzoZQbRff+482ZvpsVP5MtZuWUkDH92
    l+4WXdokWLUoabyvIWv34sBjUQ7aCVyelm/A9nZiY7zzE6X1Xy3a8wNBpCA4NyGP2NTEhK
    PP+LwWp+xkMOGSEIFtvXQYPW0A9Qv7SWsrDir102X9M9SeEtxomHiaUstoxcr/+XeZkKXU
    GUEoUgGfYxyLlCXVwbiHY+l01hccKP8kbBP+k+OuR+L5BkCQvG783kA+kcQ2QST8XH2189
    ocUWDHjeAV1xpBaCIMvMeIcoeUBZ/HUdXxXSWMyJFgIAF5SyocMyRTQ8uRIg
X-ME-Proxy: <xmx:8LMnahq3T-YIlQ27iYI8KxCECQx0KGWX81PP0PtN8QepyB0PhzXFXQ>
    <xmx:8LMnahmbRC4QaObSWTK3AVgcPMATAzMU0glPJ9i6ZbMfeBHqGLhcHw>
    <xmx:8LMnalz9YOkHzCYWtDeXgdXYeZm0Cg9STpdnKSALMpLPYUtbGM82-A>
    <xmx:8LMnaplzVHiJS4Ibqh938fcG-pLKNFj_rCOKQqJObwBrrnXmwha6Wg>
    <xmx:8LMnaidAW9_9xrWkYtG6aoLEafLMbJH1I8AKObhSxDUVz22u7v1F_Hem>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0334530201A3; Tue,  9 Jun 2026 02:34:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4zrN4FnEVLN
Date: Tue, 09 Jun 2026 08:34:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Tuomas Ahola" <taahol@utu.fi>, git@vger.kernel.org
Message-Id: <ef91b8fe-c794-4230-a298-43cebbf85e18@app.fastmail.com>
In-Reply-To: <20260604131457.19215-1-taahol@utu.fi>
References: <20260604131457.19215-1-taahol@utu.fi>
Subject: Re: [PATCH] docs: fix typos
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026, at 15:14, Tuomas Ahola wrote:
> Fix some typos and grammar errors in comments and documentation files.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>
> Notes:
>     Written mostly as an exercise on how to submit patches that depend
>     on other topics.

I=E2=80=99ve been thinking of how to handle typos for a few days now. ;)=
 The
following does not apply to this submission since the maintainer said
that he will apply it.

Anyway, it struck me that you might sometimes want to apply the typofix
on top of the original branch *if* the branch is scheduled to be merged
to more than just `master`.

So e.g. this does *not* apply to topic kh/name-rev-custom-format since
that topic is not scheduled for a maintenance branch (`maint`). But:

>
>     $ git log --oneline --first-parent v2.54.0..
>     d19e9182ab (HEAD -> ta/typofixes) docs: fix typos
>     5a7e9cc03d Merge branch 'ta/approxidate-noon-fix'

Your topic is. See `RelNotes`:

    (merge b809304101 ta/approxidate-noon-fix later to maint).

So it might make sense in such cases to post a patch to
be applied on top of the topic.

Just a thought for later.

>     f03649d802 Merge branch 'kh/name-rev-custom-format'
>     023a226b4b Merge branch 'jc/neuter-sideband-fixup'
>
>     As can be seen, these topics have already graduated to master:
>
>     $ git cherry master
>     + d19e9182ab097a722e32d459a9a58c8985831e3b
>[snip]

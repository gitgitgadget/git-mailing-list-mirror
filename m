Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C94938B7D8
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624862; cv=none; b=BJzdk9WANlWSqwSF8evFZsFh4cVEmrQdZPpVHGuxv5W5PT4zL3xNxn3oYWKE+SQaqb3kT/tp2nrjLUBKckgw5snVp/uxClp+1NSjFVoQObG0ofozWt+hsT2C773vyD/wsHtP1MDTIGUvyQOYp0jZnkJ6+EadMU7JyBcjWLJWwas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624862; c=relaxed/simple;
	bh=6CoXMDPS932k46QlYZRJ4D+Oxx2RpsOR50+Jl67X9Fw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dHC+z3oG5YP9WnZmQjWZM/PUsS1L/uoKB3PPQzR7dRXSx7H02FsUFduNs5MlJSbQbZvZBkkfNSgiJYkcuKKDm3kgc1/OBfNwnPouUT1QO8d5rYroiAdnhYGrYzypphVMI6VsF6M0bwDaIuNoXTuiEOSpHgZZEBzWqgkOzSrzxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iLBXhhrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKhe3Q4P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iLBXhhrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKhe3Q4P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0285D7A0111;
	Sat,  5 Sep 2026 12:14:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 05 Sep 2026 12:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788624859; x=1788711259; bh=caCX8QJwqT
	/0ZYS+pfz+OXSWzHOepZwgkuePwOOk9Z4=; b=iLBXhhrSBiQc/Dj8PnCQyJW+gL
	qHu7P9Vs52dafNB5CwWU8VHlGvTJaFBIR5z2fNg+ZIpERvSKWyLpFKQGFfJlJUfJ
	gu40/TT3h3VYN8dwldZ3KJVcbTYY60MEd4k6asJXgmOv5L+CTDGGx8mZjtfw6yZy
	CMmWGeBLfGEObJHiV44uTYtV5/pNnnBC6LFC2hPLa0H1iRXYm7vPHKwCxPd9fQ7W
	LFOS9LJ+/NFfyUBUYsYYGKRQ6cN1Tg07S6SxUHUxYdnRlFM/ETTxN2KccdpN5vFw
	Zd857lqYtbCPgegXHmhbeIX+OcwLYFj2lT90bnBjd7igMCHolw2OaiUhUJnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788624859; x=1788711259; bh=caCX8QJwqT/0ZYS+pfz+OXSWzHOepZwgkue
	PwOOk9Z4=; b=UKhe3Q4PdmzO19udkW8OAOvrgTZrZRE/I/hGs06LjIB8nk9O+uR
	X/s8yPAwwKyTIBLyxe1xK0IJldHrAGzN+SFkdYMa0XcsE7stDEhynb/a0ozI8qRX
	tsGrscmgEThw6vDTTQmlVsF044oF5Zag24npcMHRB+Leez6bYtdOSOIjIIC4ZY3r
	TaDY5YIC8b2pEv3x3FOHmXGui1O2unRXm8ya93djbtToS+JylHWB2EvYac888u6i
	TZhVfYkd5rwmtUNxqRltcamCLQzNc4tVXZAx7ql5uibjOJv9BHnnb3KqLZG2WDnF
	Kl0xIPnynZO9+aCNQIxxPFiK8boyG3geybQ==
X-ME-Sender: <xms:2z-cassvT00vAhoPqM_TOunN-xmIzb70cSNpSn_0oWLBGHuqTBNXGQ>
    <xme:2z-cagd8-ovZ5UGIdvhQ8AmxAgYyD37ti7Qo65MJrAYeWxiChI4fRQICFP0Lp8_S_
    4oiz2nQcc6oGFl0TnXqIOIxB5hraSFhD8H0LxJpAAEI5H-hG_ULWeM9>
X-ME-Received: <xmr:2z-caswmc3skmTZmR_CHBcRnvdR7WirfjrmhMUUS2jVuMKCaC5v6D_FgnBZp81A9_WXqmZr01yhQ47WgZ4z1vtkkGTXqknUQl_mO>
X-ME-Proxy-Cause: dmFkZTEvNB0PF+NBmtkCD05O3xwiusAsGSntjNPK4KtZBzlX3cOx5FgRt6i4TopnVe+vrI
    Irq590P+p4hAo+tANyqtIvaMMJA+aiI6JUppDaXL+GON1Jgw0EBP89N+cSNuOX3x2ItC7V
    I7Nam0YseVhUW89aCrJr077OY16MjLpYzB/aoXG9Tmqfg//TTTxx4TItLHElIJ3sri5sIm
    4B717cWsmYQfEZOLOsIQ1fWLl9AeUocd6IcOUHrzlmrE0RNEiLkJguTvrL8Kh2qW2jZAEH
    I1nfowITpEJpjGYLagsZ6ai/okjKIzTxArsLXlI9PxVqvkrzJQkN65CEWSJfBZBLhInWTI
    tiDJexKFmDIvWq5I0aWISghMLt4O2XADOL5n2aKqhhSP+ynW0ui02up8iD2yEThVZHK4xX
    CdxWu/HjRUPqWdiBg+GgU4o5q25PkbnjRLS52dHkjBugQHB/QeC7omayTxfdKIWxH3VXlg
    chTLbY01o/kaVqBRDTyCF/UpIeTu+ZOeTqew4qaX0WbetCnZA/oYzCFqIg8qM+0gMiHtOL
    GSuINntZTLsv0QvqD7r0ZrxR7RwxiXqmlDcwn7lBA1ixsWY/ExQk37FSAIIslbiQ3Qr67N
    /AGZHXnssr3HIgH0tTmRDe8m0Q7xlyndU/4AqCrwGFCum5JDfXhCsyetukoA
X-ME-Proxy: <xmx:2z-cauHaEoquyiqKUtnxJw6PSiB4OI0fA7S9u3lDTadFAyGylRqkHQ>
    <xmx:2z-caoyNWk3kfkyagbFaVVTY-7FQo-9K8BZ-jULsOh6jqv5gTvgTXw>
    <xmx:2z-cantaYH7U_VfRwLL7Ll3crbSSPLm7rXzKMtr-saLCTjwRANTttA>
    <xmx:2z-cat0boPt7sdV9-2tHGz4b3oJateobUApk1hpTbu8AHu9btXHywg>
    <xmx:2z-casy-3MeOexMm474gW5N-oGj2MAg2dKHJiR6Yf347FFyTP7FhNzUF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 12:14:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Yannik Tausch <dev@ytausch.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude
 pathspec items
In-Reply-To: <CABPp-BHviE8uLgh6PE=6MYkz_zTDZfKU9CbHQjJOeLgA=qpUSA@mail.gmail.com>
	(Elijah Newren's message of "Fri, 4 Sep 2026 12:19:17 -0700")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
	<CABPp-BF6hps9DibSV4ghbowkOD-NfEsHYFdLoKab0hCfEi9rgw@mail.gmail.com>
	<xmqqy0dh3r2k.fsf@gitster.g>
	<CABPp-BHviE8uLgh6PE=6MYkz_zTDZfKU9CbHQjJOeLgA=qpUSA@mail.gmail.com>
Date: Sat, 05 Sep 2026 09:14:18 -0700
Message-ID: <xmqqse3n65gl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Maybe I'm misreading the code.  Did it always grab the first two bytes
> of the element at the beginning of pathspec, or did it get an empty
> string?  By my reading of the code (copied here for convenience), it
> got an empty string:

No, I was the one who misread the code.  Indeed in the loop, we
assume all elements in the pathspec share the same prefix we have
found to be valid so far (the loop is about shortening what we found
so far with later elements in the pathspec), and blindly use the
first element, which is wrong.


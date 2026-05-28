Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C23E316F
	for <git@vger.kernel.org>; Thu, 28 May 2026 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969109; cv=none; b=XveicSIWaHVY5ch5384ADAdITjKkmLNLmCHvAjMmZedL0Wudm4DJxpEOPhyZSnm+xPj1mqZvL5IfdzHJ/naMXen98EvlQuRuSZ9r1oNUwj/wwt3l3ASeWgARQP2hHlyNyu/lijiDIxmtpChpcjFDPTmTFREc9XAcAn07JDm2nqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969109; c=relaxed/simple;
	bh=moVSKcmtfiWe3MK2XmpwWBoUL+wr2DdQOxuDtuAf4k8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p/gZ+2PXNECax2X3g5YxkkEnIQEJjhaEmTmcWkfy+fy3zhebX24uRQ6QUqz8yOZRHXMN9fB8nWF6z881aGlv4BTQq7inRnVfQmgv5mNGl8aBT5BwiynsVMI1zNj4smUcebu9h7iJtwv3/2gu2ZEx+XVplJSlJx85cfAzEmhvlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=sdqD19M/; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="sdqD19M/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779969104; x=1780573904;
	i=johannes.schindelin@gmx.de;
	bh=moVSKcmtfiWe3MK2XmpwWBoUL+wr2DdQOxuDtuAf4k8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sdqD19M/NEL6bmoOOckCu7xb5McHQbguGqQD2Hz02HOhgzgSE0swWIcK8rgiELX+
	 XM2U3e4J0hGuoi6gM7NUl7YkbZ7lBzhMqnU8sA5MT4Y4N+dlPLgNb5lVfp9xcl0nV
	 DWVobzJtYMem7CBtGblzPQGA7ZuMtj96VJiL3oONoWsQI4YP+weTWWozDtasrJ/A1
	 gUSkk58snf+ANQDBzsg2WwG5bgr9tOw+o+j1PjD6aiJSRCtxRhrmrcnzAmOg50S27
	 AZm5qUAhQTiv0Wcz92gknzk9jzipXKvykfc8xoAiaMfWCuSrNElFPJkGb81RBcPP7
	 P2rtfkDPTbD1WbDGIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1wlsoQ21Di-00XO53; Thu, 28
 May 2026 13:51:44 +0200
Date: Thu, 28 May 2026 13:51:42 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Joerg Thalheim <joerg@thalheim.io>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] config: retry acquiring config.lock, configurable
 via core.configLockTimeout
In-Reply-To: <20260517132111.1014901-1-joerg@thalheim.io>
Message-ID: <f449d0db-0434-f870-c69f-793f2b096816@gmx.de>
References: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de> <20260517132111.1014901-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:txKlS9smQri0BfYkcxtJkLyADbazcy08OwOCxDYU0MklyH1OMua
 f9Uf59RQgRmNGuy03zq7dHwkgk2ne3bbob5T61dZz+dVPTAZQU1ok4SfoIwmkE7qiFMUjXK
 Tkq9TVS7iZqiypvgSB61R8nojZIJKE6T6kdljtxNjrkS88+qTGls5Rpunt5GjYu/0UDc99b
 cfSqhst5xcdBB+v7NZc5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wH8MsBWC5cM=;ioGIeoBME3CnEWTxtV6phn7t3+f
 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
 YCs0q0Us4X0h1cTJfZ823U8C8oWEl9JN/UMK2Mo

Hi Joerg,

On Sun, 17 May 2026, Joerg Thalheim wrote:

> I matched the core.filesRefLockTimeout naming rather than reusing
> microsoft/git's core.configWriteLockTimeoutMS, but can switch if the
> downstream compat matters more.

I see that there is quite a bit of precedent for naming a config setting
`*Timeout` and implying that it specifies milliseconds, e.g.
https://git-scm.com/docs/git-config#Documentation/git-config.txt-corefilesRefLockTimeout

In general, I am pretty wary of unit-less numbers [*1*], that's why I
chose that "MS" suffix. However, the prior art in Git is clear, and I
should not have missed it. Therefore, I have no objections against
`core.configLockTimeout` as-is; I'll take care of providing a smooth
upgrade path in Microsoft Git.

Thank you,
Johannes

Footnote *1*: In general, I am quite wary of unit-less numbers in
configurations. There's not only the precedent of Mars Climate Orbiter
https://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure, I
also heard a story that seemed to be entertaining only in hindsight where
a German car's software improperly interpreted a British speed limit sign
to mean km/h instead of mph.

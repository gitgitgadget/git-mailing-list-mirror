Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0839022F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775490; cv=none; b=nDsM/TQTICH3W4pptTzEU5ApcbxJdHLfO5jHlpZfXFYnq4SCwDmV6ZYNtC8Vrsin73bs6porw56KeomGOBUE6DnKhKDcLyWBjLNzAQ4ouyXcTqRjAJzhhQ2Wlp9OfcHpY1MLnsejIi1uVvKIZcgGL82evTfxuJwQt1SOOl9CDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775490; c=relaxed/simple;
	bh=dDqM+QQfKxi+ms7dPYBZlxhx7WKeAtDk82GluyZAGFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0DQ4FJ42+Wq5POkz02TILvwbruvAbdKLjPZ0ryjY2JOMFIyv9qqiIFSrmOA+ZR0CUmDandBlsB3FHQ3FuWDHYghoNfymvgYKRAr9lNrejAfzitlQlZkWJHK5yV5hbChuFKJ2bCJvmJmzEi/DmoJpluykLo2TAnNlJWstfjEOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K2r9HMxo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K2r9HMxo"
Received: (qmail 296290 invoked by uid 106); 9 Apr 2026 22:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dDqM+QQfKxi+ms7dPYBZlxhx7WKeAtDk82GluyZAGFM=; b=K2r9HMxoeQ8QtQ5OdF4pVilVeb8EtHg9rK4AH8Um+jpGR/+hnmLCbaQcd1KxGs0BD/bjL2wJS7HmcReXVALE1xR7/yBR4toZWcD3EUOcbJjkhJxylYOVnnEoEgK0xdBt/sie23qVANqu5WQC8IBS8W5cAlHTAXR88VrxQvM/9MD/VgijWenwPwRqOWU/i3EgE3xILsVnHGYxHrE93EeJghAS5leg5OLE1i/vTAOZNwjT0/u6ZFmEsj4ckdW/HSj9V43DFKa7UI5zn2NiRTkXEBiRGQAc3piTsgxW8aCuOgcepOnsx2+clleoXUGRO0QJUd8+L3jCpby/YaIdgmSouQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 22:58:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490073 invoked by uid 111); 9 Apr 2026 22:58:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 18:58:07 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 18:58:06 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Patrick Steinhardt' <ps@pks.im>,
	"'brian m. carlson'" <sandals@crustytoothpaste.net>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260409225806.GA3133902@coredump.intra.peff.net>
References: <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
 <addgkjiB80pgKw69@pks.im>
 <021a01dcc827$4e6342c0$eb29c840$@nexbridge.com>
 <20260409203338.GB3076846@coredump.intra.peff.net>
 <029701dcc871$d055dd20$71019760$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <029701dcc871$d055dd20$71019760$@nexbridge.com>

On Thu, Apr 09, 2026 at 06:40:00PM -0400, rsbecker@nexbridge.com wrote:

> >> Please do not make the change in git-compat-util. This will break xwrite().
> >> We already have MAX_IO_SIZE working and verified from years ago.
> >> Changing that will remove our platform from being supportable.
> >
> >I think that was just there to demonstrate that the patch works regardless of the
> >size, and would not be included in the final.
> >Building with:
> >
> >  make CFLAGS=-DMAX_IO_SIZE=128
> >
> >is probably a nicer way of doing that, though. ;)
> 
> We had that set properly in git-compat-util.h for years. MAX_IO_SIZE should be set to SSIZE_MAX if SSIZE_MAX is defined.
> #ifndef MAX_IO_SIZE
> # define MAX_IO_SIZE_DEFAULT (8*1024*1024)
> # if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
> #  define MAX_IO_SIZE SSIZE_MAX
> # else
> #  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT

Right. We would retain that. I think the point was that Patrick was
dropping MAX_IO_SIZE artificially on his Linux system to exercise the
new code.

-Peff

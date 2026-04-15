Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06D315D3E
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776236329; cv=none; b=oStlopNgb8ryMSd1msWZbm6pVBqwCGHm3Rk8KSwlEFk/WRUeR3o4KsQ29oMeQf/3MM/NAP7ghXNSOM7twTUA23FQi4nT9RQmAaAvt1FLpBWFyZCZ1MAfUl1d3fOhvuCZl/PrHZiX73WB0OOcAqeRMFbG2zQ9L2wIWEsOQt52F/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776236329; c=relaxed/simple;
	bh=OLK4/y0TT4Kn2ZVI58seA5YsF0wRPIhb4ZVodMFarPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ7Jgt7WOMc+6HqQfiNaZlJd4ItDhj31F474dUSLCMUnLRfL/OtTu2Tb4goN6bwuuX3ES+1zEwqgDnI7uLcaeYIEMfzIGrcZRaaaa8W7f7v2tmhUbWT1JMedq7afPurhFGQ2GkHWZX6G7/7lzQNOHj8aUMrjR72CK0WhjZzu8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTjzMoY2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kiVfcNvS; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTjzMoY2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kiVfcNvS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4183F1400134;
	Wed, 15 Apr 2026 02:58:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 15 Apr 2026 02:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776236327; x=1776322727; bh=pg8Y2pwldK
	TcbSEHaQ7n2lvdAYzg7TwoilPR58oJimw=; b=lTjzMoY2JZN1lAPuayvcqeyvji
	z8ZVa7Pdi1yUaaJyp24SaS/PaF+roj6GCs9pwvmYozGYt/SvLybU8kV3m+2d1hw/
	A5ZwnGHMXsyF2SgPAtKYEbgLUcaEmEkdWIN5uLMDqYlnuJAEhiLgPP9eVxBsTd1R
	5P9uWcdP176HTAu14/cEhZQpfyAYKESY70tmwMolZ2LioXt0PSq6ObZJa5Zi6gFj
	/sMhnJImxTNVrEFkfi/dwWWK1TQsW4U2JQw87ET3fQGuFIMX5fheYcPNAZUblrx5
	UKhAyOvckt2jOfyc1Y8DLS2lCMqdcEWD7jU0xHkQ/TZn6hzYJ3FKXlQJbRpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776236327; x=1776322727; bh=pg8Y2pwldKTcbSEHaQ7n2lvdAYzg7TwoilP
	R58oJimw=; b=kiVfcNvSgCUmEI59c6rKCbFg1O0vPdXRi4h2IM0T3iq0NrPGopS
	+lglzgkZsa0b1zqVKjIs2prC3+x2n1c11WtPc2cAKO0/gVjnb2mRR0O36bDhTdis
	6ksEWkealgwt/joyuhr6wxPsmt9fd1XDWjzKK11jI0a0xG6ce+8gerVl87J5G6wn
	jWM2cvahmO2nmS2RessozgaUltEIyalg1Ln7SzzlgC/lJPqnIEEUxUgspCa6Xaqu
	REj/mhjMXvJ1k44MisxaFhRBMKqKqpirSWLcKdr5bGf5Ws9KLJZAPlDpbzL0b+qn
	O9Nhve8vSaHRGAEjb/Cvezy6p2IQdNzz3Gw==
X-ME-Sender: <xms:JzffaTEaoLSEhweV4NOUduEE3-1cSRdc3GrAR3KmWOIAuD_X4mxH8g>
    <xme:JzffaTk1XZf9SAZtBrCEVho0iRbYzGynN0W-En5_ogdpOo4tzGR1e250TNpDhH9RQ
    H36S5w3EYz_sDJOBucMhMxsSXtNcxFsHDfZU7zyJMT2lkBuFYlQZ9Y>
X-ME-Received: <xmr:Jzffaeli15czqMpl5KLaX0Sqv32eYole4PSWpJOr5YCPbORMXFI-sVyj4a40nyTtZeu_jrAM7l4xmjF3VQt3u8vMPMuEug3PLhXpjKPr0zE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffegheefjeduhedtffekueegfffgvedulefgke
    ejudeiieefkeelhfdvvdduiedvnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Jzffacvuv9BB4DEAlCmZ4I3H-4xKMhNC6wxqTQBx6MFGfjoHfUpYmA>
    <xmx:JzffaZmP-InPlkBR_WbNwXc2GALhqJP-Rt28BZ5nWFbWAoC4Ovvf0w>
    <xmx:Jzffafujt4z3wqVC6TBLRAgkYE8N6wjr_WmTDqpB6tFkCSpmgEhk5w>
    <xmx:JzffaXcUFyD4HYDG7lQ7UmA-Z57AsVIytTRLaANNLzakgEyMR1eQsw>
    <xmx:JzffaZqyoqmHuit--UyuOxxeVZCvgQIJj2IQgoSy7Rh9rK65Psq2Llrb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 02:58:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3704423a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 06:58:44 +0000 (UTC)
Date: Wed, 15 Apr 2026 08:58:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
Message-ID: <ad83IHKLtO4-gsG-@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
 <20260414062345.GA2902286@coredump.intra.peff.net>
 <xmqq5x5tbfsm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x5tbfsm.fsf@gitster.g>

On Tue, Apr 14, 2026 at 10:41:29AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Apr 13, 2026 at 11:49:23AM +0200, Patrick Steinhardt wrote:
> >
> >> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> >> index f3af10fb7e..f8bc77619b 100644
> >> --- a/t/test-lib-functions.sh
> >> +++ b/t/test-lib-functions.sh
> >> @@ -1195,8 +1195,12 @@ test_must_fail () {
> >>  		echo >&7 "test_must_fail: only 'git' is allowed: $*"
> >>  		return 1
> >>  	fi
> >> -	"$@" 2>&7
> >> -	exit_code=$?
> >> +	if "$@" 2>&7
> >> +	then
> >> +		exit_code=0
> >> +	else
> >> +		exit_code=$?
> >> +	fi
> >
> > One subtle interaction here is that the command in "$@" will be run with
> > "set -e" suppressed if it's a shell function (even if the body
> > explicitly says "set -e").
> >
> > I think it's mostly academic since we don't tend to use "set -e" in the
> > tests at all, but it may be an eventual gotcha.
> 
> Yeah, ugly, but this is tricky that they felt the need to explain it
> with an example in the informative section X-<.
> 
> "set" is described in
> 
>   https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_26
> 
> and the description for "-e" does not even talk about any function.
> The application usage notes associated with the "set" gives this
> 
>     Application writers should avoid relying on set -e within
>     functions. For example, in the following script:
> 
>     set -e
>     start() {
>         some_server
>         echo some_server started successfully
>     }
>     start || echo >&2 some_server failed
> 
>     the -e setting is ignored within the function body (because the
>     function is a command in an AND-OR list other than the
>     last). Therefore, if some_server fails, the function carries on to
>     echo "some_server started successfully", and the exit status of the
>     function is zero (which means "some_server failed" is not output).
> 
> which greatly helps.

The funny thing is that I discovered shells where this is not the case,
and `set -e` _does_ extend into functions. Anyway, I think I'll follow
Peff's suggestion and just enable `set -e` for Bash 5 and newer. This
should ensure that the behaviour is a lot more uniform without having
negative fallout on other platforms that don't use Bash, but we'd still
get a failing CI as we use Bash in some of the jobs.

Patrick

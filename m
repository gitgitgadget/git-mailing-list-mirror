Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31565277818
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355580; cv=none; b=JjsAbxq0YWsU2W6XyR3rDoAC1E+5mW8043i4+jLxVNkVT+O2364+81/7KFnvdTViEbWXu5haL86+MzxGxdnsrISXbiP0z9Nv7d9VovsBXdgniTYynn6aG0eJ2k74xoAJSj1+w9EYf+Q7JQmgskGSZ4V+2srsKii1cXWD6g0GrKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355580; c=relaxed/simple;
	bh=MyT9Q6eAMRD8qXhSY6AROSSz0xMed2z3OF7Phfn2zJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDiLqOCIr5VDlXAZqZZewEMpiRvIus0MNWmnWsBkubgHfEs0yW279494jLqz1o4JDhgwLQeM8yVCag2uzxrnOd3KIFYge9oRHXY/2l7PWvr0OrQAhLnlwieRnqt5+Lj9qeDARBOlXkq212J40gku4WNJ6mwmyc13kUAZC5X7IiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DpPDBIJq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fUC/bk2g; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DpPDBIJq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fUC/bk2g"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 629747A00A2;
	Thu, 16 Apr 2026 12:06:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 12:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776355577; x=1776441977; bh=x22byZSRTn
	d7i2+KFWAnVSANS66mrU1SGE8+IJGZeTc=; b=DpPDBIJqi0dSxcDnBVCsWoEmm3
	+1XvgRgcjdWgDwAyHbMeCPDlKqCYHnA3/15fTum/FT0jIquROcxeBokVfPLXObfa
	JWNgC22vqA6xpIZJ7qW3xkUZtvr4BduFyuwSK1FqolG70fU9KkyrGHNyqbENvcaE
	bMQY837zmJhH7wokd44ouMRC/sMVzpZToIB6eiaolwrFZ1ryYa1Su6N8O0X3NR1a
	8ftwis8ial8ajnztzjifsDhV4MITBWFmhA1d6aoYRgdlwRPA8U2Utudwo3sLANqE
	XjEM6a5M7hDFdIH5SVjoSwxNOMN6ZDlqmTQSZSLJP87pZmEuBWvWXPLJd54A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776355577; x=1776441977; bh=x22byZSRTnd7i2+KFWAnVSANS66mrU1SGE8
	+IJGZeTc=; b=fUC/bk2gkLbOriZObZPaNU/4LperMZbBXjezxoy9MnGL9PSWRSh
	YBrZ30hdF0GyRP4tWeKW6SVDYK4XTIRDJzK1B5h6P+u9J+ISzcLlMzkdN5PaTG6F
	SmJnZub4h4f0FHCigZ21vrm5yd1URyu4p7DkSmk7HTvb4vXNU8BEB3lmTvNRcZYf
	9fBKxnd5uVGkmjFfrSTgR+6lPTw/SU2qILHJ4sYb+LXxe5cQGp3WICnyy4hREq5Y
	kuvJG93Uh8iGwwGXh7P7gtmPRb1hYzuid7e+wxkJnLJO/reMd4tfH4hACo7sBVdk
	l6CEpikrK9wMhsS9NadlnqwgtC6ejH+gX6Q==
X-ME-Sender: <xms:-QjhaV5SgFaxwNHx9uG2AG2WLfm1oGf41rYSb7T_-jgdDnPsAGkL9Q>
    <xme:-QjhaZ5GevRWF91PMPaDRDOqvtTDtJ711xNtdZhrREGt039aqermNSw9VRjqLZUWF
    2G9lrG8JPoWAmMRJSD3CTbabJeUn_M7_W2wrYvrZHF3cl_crpZFzpU>
X-ME-Received: <xmr:-QjhaRcTFH_NmckB6wROSqL7TkTbHXew-jGRRoymP11b3-FPPLn9nH_zTGMEt87GWJFVgke30PiqseW5IA7Oz2l9RFnaIxDHVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiueelffehudduffffgeejleffieelhfelgeehledttdfglefhjeeukeehtdek
    gfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:-QjhadDYBon7ZhNH_C0aqzzTrW7-WsrPOeWrFDdwQ_6BUl6hETsO-A>
    <xmx:-QjhaU9mtmsLUcOGI-69YyYkOGvFNW8AuKVway0eRvCagn9M_4pvWA>
    <xmx:-QjhaYLX_t2oEVOCsfqsaW4VxK-SbrHffDwjrkS0Lq014g7_1ACFgg>
    <xmx:-Qjhadih42rLNSjn7zGvGJkCrKEJg9bSe3O8OOPjpO3kzfYhpR2wng>
    <xmx:-QjhacZolYdLUC_QoW6enrDNbQGrl-qdih1apa8d3J_ELqSAT3T9dsyl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 12:06:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 12/12] t: detect errors outside of test cases
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-12-7a90e5dccadd@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 Apr 2026 13:19:29 +0200")
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
	<20260416-b4-pks-tests-with-set-e-v3-12-7a90e5dccadd@pks.im>
Date: Thu, 16 Apr 2026 09:06:15 -0700
Message-ID: <xmqqpl3y3n60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  linux-TEST-vars)
> +	# Ubuntu uses Dash by default, but we only enable use of `set -e`
> +	# when using Bash 5+. Ensure that we have at least one CI job that uses
> +	# it.
> +	export TEST_SHELL_PATH=/usr/bin/bash
> +

OK.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index de7d9e7b92..1f7868c537 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -15,6 +15,15 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see https://www.gnu.org/licenses/ .
>  
> +# Enable the use of errexit so that any unexpected failures will cause us to
> +# abort tests, even when outside of a specific test case. Note that we only
> +# enable this on Bash 5 and newer, as `set -e` has wildly different behaviour
> +# across shells. The list of allowed shells may be extended going forward.
> +if test "${BASH_VERSINFO:=0}" -ge 5
> +then
> +	set -e
> +fi

A possible alternative would be to actually test "$TEST_SHELL_PATH"
with the features we want to be working, e.g.,

    out=$("$TEST_SHELL_PATH" -e -c '
	# basics - "set -e" suppressed when "tested"
	false && echo 0

	# <20260414225206.GA3486072@coredump.intra.peff.net>
	# ancient bash dies after "command false"
	command false && echo 1

	# <20260416054038.GA646814@coredump.intra.peff.net>
	# failure inside a function excempt from "set -e"
	f () { false ; echo 2; }
	f || echo 3
    ')
    if test "$out" = 2
    then
            set -e
    fi

which adds some documentation value, but I think "this one is
known-good, and we know we use it somewhere" is probably good
enough.

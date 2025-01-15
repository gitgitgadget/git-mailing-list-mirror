Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A324A7CC
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983955; cv=none; b=jujl37jnk/PvSnou9hAumulzM8NfAca4KIWsOAgOX9zq9+ZFHrD7uVpd6qlx2ASNTjyA9v2URlnjv9kLAnon3lnltwRrBl5aqWmSJfmuzDVHRtrNxahz8MK7SHiMJRP+rf3EeylvyvPy0+Ja4YMci7kY/+zrtACP293cdNNwmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983955; c=relaxed/simple;
	bh=WdckA3uLi6MAibzWdajthbBzP879P1MWEHIjOnua9bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Im1zYeke4rl9ofdCcRqR8YNf7FVKOT2vEW4S8psJCKX2kk8zGgTm4vUTWrZdF4NsD9Bdx+t5KkzoYn29xznSlqKd3S8Xv32I2ItvG5/+zGDC4sPK7nzrgXiTdKYoEnzOrnd9PSG0MtCI3DYcpZ4LGPCsootb66H14Qfo7KwzEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3IC3AN7g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dwebgslt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3IC3AN7g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dwebgslt"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D5190114010C;
	Wed, 15 Jan 2025 18:32:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jan 2025 18:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736983951; x=1737070351; bh=lSYUlug8kC
	E32NCkupD8LobtI5sRFDLkdKOpWtd5JeE=; b=3IC3AN7gBJIgwPvTlx8PSAPCaE
	LSJ9Cm6s80+uuAFFQxKuhWIKAqJHrx8UuU7l97luXhJ+q9+O1sLs6fMhG+53CiOs
	Bt5QJCbFnq/CVw6ptWNuWYFamU5JdixeKWsugiPzbi6bqZiSxM3fi52qbMIKio/p
	w5OilJ7V8aNxD8Z/35HVuJXIsPbuX9cyjNwk83IO8pgzTt6yw+zy/SozJaA92l8y
	FBj13Yv6G63uzRie2TuP9KH5SyUsO0kIpWlxLq3hm9nAcFVvENbFGdTHnM0cNjZr
	9eoUBp29wewsIcPogFu0Yn2mDLZH5HkQtCN5FmJBecJOwxC18Q/fICiU86aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736983951; x=1737070351; bh=lSYUlug8kCE32NCkupD8LobtI5sRFDLkdKO
	pWtd5JeE=; b=DwebgsltaVkgPVQXizha+hIQnAYq95knaC17IaYJhJt0TpktwJv
	3YylROIq2hv+6enukikgIQAPRMC9710gEROtz4ijZ2dxKpqaVdFd3mrjSzD6jB6B
	2iMmqhutmIbGBjSNwVEkYot3S+Tv74Cm0Sjevk7gKUPw9OUb24cj3vwKkV1JyLv3
	Rfe3IKgrUNXnznXlP3gcWj/h1YnjtL4GlNl+D8Tf0b/iACTqr5k4zmfmZnKNhs/E
	aRoaOZ7YE8TE9++N2oDnHvhiTa52oOMirTcnPMBltuxFA8cDafSMfEcrpDC+asOb
	jr8tFlDM3B5qG1Q8CS0L1JbWmkdR+3s8JTQ==
X-ME-Sender: <xms:j0WIZyVgvju1F-zMN7N3Zugv_xglM46qWAgwgXjfBUlONCekM-TzcA>
    <xme:j0WIZ-lJgnqgaW4emU4Iz-Mon_H_2MoFLaTEtXIZeLu2PO56tdsvt-49Cr0Nny8wJ
    tKz0WvOjdK2QCuCLg>
X-ME-Received: <xmr:j0WIZ2YmDWANnQuTbZSOmRNY4gtU9Lj7NKNPMUcQMRly5D8Rj9n8tHDNw0wlbTH183DPz1zs-K4cSTpsIPEv4fjyFAzIF6oofMMh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomhdprhgtphhtthhopehmtggvphhlsegtvghplhdrvghupdhrtghpth
    htohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhsthgvrhdruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:j0WIZ5VpBNW7qkqJou2saomLR0AktlQzqIgjq3SVkpO8LbnLX1AESw>
    <xmx:j0WIZ8mWXHGFqLBElULlWVn9G_OtA2hbTjPk282c_AUXqNTUBI61fQ>
    <xmx:j0WIZ-dlF0RxiUZ76hTEwwyRC6O6-s8lYyl8tfi3x-5pYi0bmCzqKQ>
    <xmx:j0WIZ-F-FblWf4ENuhnQCp-qFYX8EFrQTzQ87vVlMVrn7VX4xt1znw>
    <xmx:j0WIZ6YYSMSv1svAVdhulb0qqEtJhYe89B3gnQ1s8UQaRnDegsVm7kbE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 18:32:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115222728.GA132248@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 17:27:28 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
	<xmqqa5brydz1.fsf@gitster.g>
	<20250115212952.GA96537@coredump.intra.peff.net>
	<xmqq5xmfyc4w.fsf@gitster.g>
	<20250115222728.GA132248@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 15:32:29 -0800
Message-ID: <xmqqplknvek2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't know if we'd want something like this on top. If somebody is
> interested in just doing all the conversions in the near-term, we could
> do without the optional flag.

Ah, you are much more practical than I am ;-)  I was wondering if we
want a list of "these commands have already been updated" and behave
differently.

> Currently t0012 is permissive and allows either behavior. We'd like it
> to eventually enforce that help goes to stdout, and teaching it to do so
> identifies the commands that need to be changed. But during the
> transition period, we don't want to enforce that for most test runs.

Yeah, that is why the "git branch -h" thing has been left broken for
such a long time.

> So let's introduce a flag that will let most test runs use the
> permissive behavior, and people interested in converting commands can
> run:
>
>   GIT_TEST_HELP_MUST_BE_STDOUT=1 ./t0012-help.sh
>
> to see the failures. Eventually (when all builtins have been converted)
> we'll remove this flag entirely and always check the strict behavior.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t0012-help.sh | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Nice.

It is a tangent, but I wonder how many among the 40 really needed to
use usage_with_options() to react to "-h" in the first place.  In
other words, these manual checks for "-h" are done only because the
code _wants_ to react to "-h" before it calls parse_options(), but
does everybody who _wants_ to do so really _needs_ to do so?  You
already have shown that "gir branch" did not have to, and to me, 40
among 100+ felt way too many.

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index 1d273d91c2..9c7ae9fd36 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -255,9 +255,16 @@ do
>  		(
>  			GIT_CEILING_DIRECTORIES=$(pwd) &&
>  			export GIT_CEILING_DIRECTORIES &&
> -			test_expect_code 129 git -C sub $builtin -h >output 2>&1
> +			test_expect_code 129 git -C sub $builtin -h >output 2>err
>  		) &&
> -		test_grep usage output
> +		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
> +		then
> +			test_must_be_empty err &&

This may be a bit stricter than needed (things other than usage may
need to be spitted out), but it is sufficent to declare that we will
deal with any potential fallout only after it becomes necessary ;-).

> +			test_grep usage output
> +		else
> +			test_grep usage output ||
> +			test_grep usage err
> +		fi
>  	'
>  done <builtins

Will queue.  Thanks.

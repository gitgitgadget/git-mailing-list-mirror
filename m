Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443C3AA504
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472314; cv=none; b=JrMO1k6dP+ptVx2s82RSt4m7VDEolywegwknQfzb82gCmzA6PBRE+7GkLQGX0HT8cwV6lNV4jSMPZUebb791JciDtlo0SOHKyYi8kONRNvTl3w1UN3doHAaE+NMJmigSG7NWtPLFffy5F1APv7dIcKbX4GcYu+dblP9s7rxFK4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472314; c=relaxed/simple;
	bh=G01byKWw3FR7oRdEbruvHmOj01vUAsPC40yTCRulLto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RB6DnaSnqB729wHTF50SIr5LflGhEiHIIP2AaFV9Jew9clIwMxAFtExHHkhUDahRvlokvDb2nPyqW+qgv9PBBPECubSRVfWo3AWmZmgkBiMA52kcbzR+25Bb/fE6zj/GkDXiK4/Ct3dLnNq7/HSzrp9Dc7a6baSvO32aNnbkyhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ibZ0JbXL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHDxEXRK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ibZ0JbXL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHDxEXRK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B81EEEC027E;
	Tue,  7 Jul 2026 20:58:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 20:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783472311; x=1783558711; bh=u/hNemSJzy
	wI8HyYGb7e16Ioax3lEfiqUXW/n9fcaJ0=; b=ibZ0JbXLEdybYCQCZyIW8WbOWk
	uNc0Fl4gNi5Gx6WzR0AKzwXzfbnZ1EUo2qIAVy3qSVGKg0iAdWEt6kAPBMcqv6NW
	bh9KfRlpQmXpTJUbljhjLRP+iN4ONpg0pZ5x6nCZJsYxEMKXfQtKlyMOHMZZue8c
	kGGA0oVlBRLuetRCpV3IyL7gmb7yxzg9++YUem706QOExMlcCAE8ExBLtNu2+AUC
	Hq5Dk9kG4LV+RMLmq2I0zfvenAJ4FRG6u3nqcXaykalIs3WTjRo5evJJm3AgWj1r
	IeQ16vfk5bDQxUxQuMOLeJw0f9SvbobrajqObUJr01iZT+s17kDNP8x9tbhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783472311; x=1783558711; bh=u/hNemSJzywI8HyYGb7e16Ioax3lEfiqUXW
	/n9fcaJ0=; b=CHDxEXRKyw2bRYQnfwdlL7a2CD3LuTRCQcJQ4cZZXSaJA35EiFf
	cG28oJAJJ3z4BML2ItYCrFpUq3eIzTqNKW1tBY3EMPtDtZIRjFGCsnEUjpFZ45oj
	2GC1pVB2Cj9VsYTr4Zm4P49n0gYa64D+GV9VDFqTphnGu8Wn1a9XzTo6uyumtyaE
	M9a3MF6G/sFEfgF/nTwwvvoM/HWohzh6fAIBaEr4k/upl9ILNrE/eJhBDPW+56mZ
	U0rBVVxcfgSdCGxUrM/fJtB+hnx1I243XRwR7li5USHLv5fqDRwQ3FuQkcvLNyb9
	Av5/fSrkut7ucYh+lGUsYMxXrrwqw9fg2sw==
X-ME-Sender: <xms:t6BNarq8Npk6FaJwy7wzrICWZGSHJjE7DNguLtE0Daq9QKu3NRQB9g>
    <xme:t6BNaoNXCeRZH_7-zhoDA9f6LuEHd4-aSN1dXAYsX_KYqHyxoE4PiKdhFAWj-2Ivj
    L4L32ZYrMVCip5aVn0P9tZowTP1eKRlYQcs0NbVuJpCqCrQdhBWuA>
X-ME-Received: <xmr:t6BNar3Je0oivuRCvuybbHMZq_g4w4-VAeOT8Xu5IFmezPSztqPW2RBWBhBaYHxQES7klZ_SQR3-rGS0oc_sdzCsPKqe3Icbgkx10t4>
X-ME-Proxy-Cause: dmFkZTEkHZ78TMqeurmVmCkUcjfLW4JpRwdlRkX8FvAXCHqDBofpR+tai28M/HBGrWCE8+
    cvSnpZkQ7s5gvTS2GedQwnJmYt6LroDPYQLKaaabk1D8mRFkJXcHIL2uEdq8h2Fnck0dhM
    PmM48P31bNETFnsPAsPx2QwXsqPhZrUs/Fmv6fj44/y/m1iuNqDVy4K3AGMiZvdpLkfveQ
    8W6jz8bojc6lVFUIJWEwnSuF+pvjqaU2je/B/CVtsFPVD/ZqAocGoDO70h6AhKq2OH+HjI
    xjyvatTOYe9G7jr4zVJXmX/mkliNqTSymD3mUyfgbvbNwsNrlJyYOtHDjSYovNDtDIOoqj
    lbUMxvmP7gqmuJS1q5JyWqcDldnYI2HIov9/05g6QQxkOg4Ztln8PS4xM/3n8if8sAGH5V
    rIVtSASEtA9Fg265R/6fQocHXmhA4plCc6/r851Sb394kueS5hjS3mbs5anj1dEbdwny5t
    BoCPxodgTytptosVYrEbeT2Ev77h5lFwQ6pIZrzoYM7MhcYzIqv9ll7Jc5iJltrkyil0PZ
    6gAq+9jmW0fMEpfv1BNNu73bsh16u8OjmH7SOJ9t224veG94GueKzoMdCF5kiPU8zBhuFp
    GDDYl7zcurdb6eb82qOUsCR6okHw/Ccdmc6XEGn5I0a9OkLp1gkTsIayelNw
X-ME-Proxy: <xmx:t6BNavBovducXNzcGhbPZWX1857rqJ-FigFpED8IJNM2H_m2QrhuXg>
    <xmx:t6BNagJ-rRrruuJSutzubvrs8nmvLZDukyXFJx4iWfqC_Lf8wmeK5A>
    <xmx:t6BNagkpjjI0GKOTURCzHlBLnxAsc9Io91h8WngyPUoJCG6jJhJWqQ>
    <xmx:t6BNahaLuKrlraNB9qmf-Z7M3HHL5ZRVvIlzT6saC1X00cM6zSJvyQ>
    <xmx:t6BNaumpka8TA2PIDD8EQUPZJni458i_8_01vaHiOTbYtL2xsIBm-mDs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 20:58:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Shardul Natu <snatu@google.com>,
  Koji Nakamaru <koji.nakamaru@gree.net>,  Patrick Steinhardt <ps@pks.im>,
  Shardul Natu <shardul.27591@gmail.com>,  Ben Knoble
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v7 3/3] contrib: wire up osxkeychain in contrib/Makefile
 on macOS
In-Reply-To: <32af2c51a892c2fd646a867df7eb5224d5ea39c2.1783443745.git.gitgitgadget@gmail.com>
	(Shardul Natu via GitGitGadget's message of "Tue, 07 Jul 2026 17:02:25
	+0000")
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
	<pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
	<32af2c51a892c2fd646a867df7eb5224d5ea39c2.1783443745.git.gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 17:58:29 -0700
Message-ID: <xmqqa4s2z496.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shardul Natu <snatu@google.com>
>
> When running "make test" with TEST_CONTRIB_TOO=yes (which is default in
> macOS CI workflows), $(MAKE) -C contrib/ test is invoked. However,
> contrib/Makefile only invoked tests for diff-highlight and subtree,
> meaning git-credential-osxkeychain was never built or verified during
> standard CI test runs.
>
> Add a "test" target to contrib/credential/osxkeychain/Makefile that
> depends on building git-credential-osxkeychain. Additionally, wire up
> credential/osxkeychain in contrib/Makefile under "all", "test", and
> "clean" whenever running on macOS (Darwin).
>
> This ensures that running "make test" or "make all" in contrib on macOS
> automatically builds and links git-credential-osxkeychain, preventing
> future build or symbol linking regressions from slipping through CI.
>
> Signed-off-by: Shardul Natu <snatu@google.com>
> ---
>  contrib/Makefile                        | 10 ++++++++++
>  contrib/credential/osxkeychain/Makefile |  4 +++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/Makefile b/contrib/Makefile
> index 787cd07f52..7962a9ff12 100644
> --- a/contrib/Makefile
> +++ b/contrib/Makefile
> @@ -1,10 +1,20 @@
> +-include ../config.mak.autogen
> +-include ../config.mak
> +
> +ifeq ($(uname_S),Darwin)
> +OS_CONTRIB += credential/osxkeychain
> +endif

Is $(uname_S) defined here at this point with only the above two
includes?  Don't you need to include ../config.mak.uname as well?

The top-level Makefile does this:

        include config.mak.uname
        -include config.mak.autogen
        -include config.mak

and so should this one, I think, in exactly the same order.

>  all::
> +	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
>  
>  test::
>  	$(MAKE) -C diff-highlight $@
>  	$(MAKE) -C subtree $@
> +	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
>  
>  clean::
>  	$(MAKE) -C contacts $@
>  	$(MAKE) -C diff-highlight $@
>  	$(MAKE) -C subtree $@
> +	$(foreach dir,$(OS_CONTRIB),$(MAKE) -C $(dir) $@;)
> diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
> index 219b0d7f49..d9fba07e8d 100644
> --- a/contrib/credential/osxkeychain/Makefile
> +++ b/contrib/credential/osxkeychain/Makefile
> @@ -10,4 +10,6 @@ install:
>  clean:
>  	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
>  
> -.PHONY: all git-credential-osxkeychain install clean
> +test: git-credential-osxkeychain
> +
> +.PHONY: all git-credential-osxkeychain install clean test

Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9061A0B15
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507316; cv=none; b=TJUH06pBbleqYxPYHonDNPNZ5sFtff/zHVTdxtEdNy2m0JStiINUlf/TE1XfiVDxAAzaV9T5Bmi4WzbLFufHXm6BhXOg6OwxtFAyjAAgM0W9Zxhf/RpmT4qj6twDIcUzixKS7yP9gztwn6iKfQhM7eWWbXJHoZt36F4wSws6CRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507316; c=relaxed/simple;
	bh=2PZIiJ7brSziQ2j+YaTubgT35GKx7AIZxaL8Gn5uZVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPQgtFZq5u4LN0cLyw9Hk0r9J5gD+iaXa33cpe8emhfHjxpMzh4g+P+CAocpII7fsf2mDuqCj3T3/RWR5Fk142sZHeR7xb71bXVC5/08pOoYPcBMZ4HYXFDTBNa2r7j/hWzK6nRO0mwjQWf2TzgOSgs2O1LVZZWgWXUJvW9Evk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nZUSztsj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w/7nAcnc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nZUSztsj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w/7nAcnc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 76FD4EC04E5;
	Tue, 18 Nov 2025 18:08:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 18 Nov 2025 18:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763507313;
	 x=1763593713; bh=NuZUdX7F1vNO13bNZOKYEr3iZXOlcAR5udUbcMf2+lk=; b=
	nZUSztsjNF83GqjPcJFEH+onX9H2lffbB6aU5b+w6cIX+2hPatKW6YBSrVtp6/Ev
	sepzoonpqDLF4y4nl2jVGhnx/S0Me5dGYP9N2//8tyrtJY31Jht/1okFoQ5SJzKz
	aOGds1NRyMrFAQilT1y+Jz/wA5clJVlpyit8OCvtktXnIhu7v0sR7hVcudxU/yuG
	tGbu/TQxMuZjHVN8pwBC+/vEcqQCBxeji2i3Kc7qP5MbVtbzBdvLMlAxCDHJi9+T
	BfmF4WgJiRXpGSQMTuIQlS/7NRjyw4oVa5KNQYVAjZE1D5+heIMf5vGda1DRsgVL
	VJ6aNpWUPgC57cSq1zSfRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763507313; x=
	1763593713; bh=NuZUdX7F1vNO13bNZOKYEr3iZXOlcAR5udUbcMf2+lk=; b=w
	/7nAcncm3FTCqHMdyuXJqNn8GHS16pQnFbAyZQjzW93H31GVwHUh2iZJDJNRcpZ0
	7T3/ZEYGyTNX928A84yeYyXqbjdHXSOq0aw1CXhgaQzzHt9BWZfhliAzkn41ml/F
	gOE+wj2kRFC5J00l1pLkb+y3yQu1AF5SMA5rWV8doWeAqIMXJ337U6e0W9WmnXjd
	QEJ4/4e5o2Gh5y43euVNBBaBZ3lK6NxauC6GDTSdsuyLT/eMfUtFYl7U+NhrOl3Y
	lUDe7+bX/vuRBB1ZmEVGrKocyGJHsPzIgAhiEHAlrc4nH3y6gkZmmYoMCaaD/tRS
	ThmisOjEKxXXw0MN28/qA==
X-ME-Sender: <xms:cfwcaahB4M176aapzDQMMGTczg5rMB6gaDzM5DuDmco95TJB6MlfNw>
    <xme:cfwcaSClh71tYlipj6T3D5MWd_XernrlEnrSs8VVyObShAdAYmSnCZD075VxTW8CH
    lUX8j4uoXurL970pTqiPwu5195Ljtc8LpXrtuRRUlV2Hw15MXf_>
X-ME-Received: <xmr:cfwcaXEchvgf91vT9zDQ4blJk8_Hztuk1Ee-r_mutkbvRQsx3TEw5fToq7A5W1Dxrfj-vnymllqDC10Y7ueAAN5fH9wWtH3Qsafs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddviedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cfwcaSKw813N7IG0JbH4E_Z-sQr_CvfY5f8C1w-AHAxpmBU5YHbqcA>
    <xmx:cfwcaTnAmXki82hVoCuvqeo08e_C_BcUwjkHBX65NaKz9MTZeiVy9w>
    <xmx:cfwcaSRcTNrlhqtzXtux-rDmO5S2gmb-nz6uHW1Op3zptHNrPLJpSw>
    <xmx:cfwcadKmZj7ma4RrGG5BlSU55Dm7LT6Of8kqxMbHja-l2WId7Mz3rg>
    <xmx:cfwcabZADAevIhYiA1gMQTTl4uq9nkiZ4PwhXU8-itkmQ-0yJ9VsZT6M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 18:08:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Jeff King <peff@peff.net>,  Git List <git@vger.kernel.org>
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
In-Reply-To: <3b1cb53a-6427-4626-a768-1961e25514f8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 18 Nov 2025 23:29:38 +0100")
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
	<xmqqbjl0iax6.fsf@gitster.g>
	<20251118094621.GB530545@coredump.intra.peff.net>
	<3b1cb53a-6427-4626-a768-1961e25514f8@web.de>
Date: Tue, 18 Nov 2025 15:08:31 -0800
Message-ID: <xmqqqztvc51s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 11/18/25 10:46 AM, Jeff King wrote:
>> 
>> I also wondered if we ever use mkstemp() at all after this patch. If
>> not, we might want to declare it off-limits. Not because it is evil, but
>> because our own implementation is more predictable (and we can drop the
>> compat wrappers for mingw). It looks like there is one more call in
>> entry.c's open_output_fd(), but arguably that should be calling
>> xmkstemp() or git_mkstemp_mode(). But that's out of scope for this patch
>> (I just thought I might nerd-snipe René into looking at it).
> Thought about it before, but couldn't bring myself to ban mkstemp(3).
> Its only faults are lack of features (mode setting and suffix support)
> and not being available on Windows, but apart from that it does its
> job as advertised.  Which means ... it doesn't cut it for us.  Hmm.

When somebody asks:

    On this and that platforms, mkstemp() is natively available.
    Why are we using git_mkstemp_mode() instead?

after seeing this patch, I am tempted to say "Why not?"  Are there
legitimate answers to my "What not?"

 - the platform native one could be more performant?
 - the platform native one could be more secure?
 - using the platform native one, we can lose out custom code?

None of the ones I can come up with offhand sound very legitimate.

One upside might be that doing so would make the behaviour more
predictable, in that even on a platform with native mkstemp(), we
would use the same implementation as what we use on Windows.  But
I do not know how much upside it is in practice, either.

> --- >8 ---
> Subject: [PATCH] stop using mkstemp(3)
>
> mkstemp(3) works fine if you don't need custom permissions, a specific
> filename suffix or to run it on Windows.  For those cases we have a
> custom implementation around git_mkstemps_mode().  Use it for the base
> case as well, for consistency across platforms.
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  compat/mingw-posix.h | 1 -
>  compat/mingw.c       | 5 -----
>  git-compat-util.h    | 2 ++
>  3 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
> index 631a208684..57915119c6 100644
> --- a/compat/mingw-posix.h
> +++ b/compat/mingw-posix.h
> @@ -185,7 +185,6 @@ char *mingw_locate_in_PATH(const char *cmd);
>  
>  int pipe(int filedes[2]);
>  unsigned int sleep (unsigned int seconds);
> -int mkstemp(char *template);
>  int gettimeofday(struct timeval *tv, void *tz);
>  #ifndef __MINGW64_VERSION_MAJOR
>  struct tm *gmtime_r(const time_t *timep, struct tm *result);
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 736a07a028..dc3da7c6d5 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1174,11 +1174,6 @@ char *mingw_mktemp(char *template)
>  	return template;
>  }
>  
> -int mkstemp(char *template)
> -{
> -	return git_mkstemp_mode(template, 0600);
> -}
> -
>  int gettimeofday(struct timeval *tv, void *tz UNUSED)
>  {
>  	FILETIME ft;
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 398e0fac4f..0e6bd266cc 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -446,6 +446,8 @@ static inline int git_has_dir_sep(const char *path)
>  
>  #include "wrapper.h"
>  
> +#define mkstemp(template) git_mkstemp_mode((template), 0600)
> +
>  /* General helper functions */
>  NORETURN void usage(const char *err);
>  NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));

Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1944282F3B
	for <git@vger.kernel.org>; Fri,  8 May 2026 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208898; cv=none; b=nYo3zGk7JVwoLDv+F9m2rD4AZnfCa5mepa4JmtISjSm/QcpffWgZ8u/ZQqrcaY+uMQF2+lZ60DcNKbOYz1iMurgZ8V2eiTKzY09e/32eGP9xkOKcVfPggJZ4JANb0Rk9pY717nnR5GVPsXwZ261DaXKd9ywDD+LOG8FUE0mE6fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208898; c=relaxed/simple;
	bh=PLquTC3HZ/V/eeaXBFLFqyNuyC0OBQWG1++0yFqq98U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sBgVDZ5VePzz6mMtaAhziqeMx4mU5bMEDyVFEqtzpngOHBppbcRaIyUKfXtdbI2fepiIuhA+OhYiLYAEzqVQKh5htTqeK+s9OPlU51wVUYH0XBh+7A9lADVo0yfFPIktShp+ycoUoSXyX+KfplcsatVjWQ92CIjGIELvTaXt4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BRmRyVUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEiIJY9B; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRmRyVUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEiIJY9B"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CAA6A1D00074;
	Thu,  7 May 2026 22:54:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 07 May 2026 22:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778208895; x=1778295295; bh=mLW0ojQR7B
	3AnKCtcfrBAYpewY/wNlHqZukt9fOGekE=; b=BRmRyVUwJYgM9gbqv8jCGV4QU0
	qJI3tlEdaGCdt1q3B7APaqz9LYGEic43OP0KzDUoqY/iefvePzkxikLH+8GdW2yD
	6iMVvRVawfZubP1+LuLF1Ha+VI+UC2vlwdXcfVIwaG0/JlATFwmfl8QhpQQgCrWW
	dCV3kjvaRBjGzpHY7ntCKfmtV889opfXJQgLxqsHYtiMXeCGTTNjEpf5PH6rlhsd
	cRFbqLlmT6cq94PWjZVjyj+NrbZ/pVSjPbxs4IMGusfOysSPfW4Dgmxfr7na13gt
	UZLaisAeXqhq9eRJMGQT2uM0i8E8AmzyPO+HqBKZwZzmuDqHkJ+BJ5NISXUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778208895; x=1778295295; bh=mLW0ojQR7B3AnKCtcfrBAYpewY/wNlHqZuk
	t9fOGekE=; b=GEiIJY9Bj8UvfwDh7mMghN1CN6AB3g2IWSLBM9cg9Qvvg20sGss
	oSJe0omaTtdkiiB4H8n7+DdCS7RycWbl+VTVTdUqqIQyU7i+UiydZfTfI81m8kzo
	ZGaETD9lstyoweh66rLM/wMOtMFEP3C6ShBUKOml7ljqNf1cc287ojChCJouZF9+
	x+Z8mT3ofVJLGYI56tahmOhuW9ZhFO1mOc1R4YKvsH5XV0kIakgh2XxDsoppoxA4
	q756mkzRqma3P26C7ZPLZkQax3o9Hi6NmV4Otr7cZ1NcLKnevqKBuSYfmEonbapJ
	43G6ozWcUcjGMkS2IewhfRWdJqt9yc3ccLA==
X-ME-Sender: <xms:f1D9aSlO3xF3sDjMSa3TPf6g6ZPPX0Eff-bqc0t17rt_k6RDpbyrrg>
    <xme:f1D9adheis_TnB6E50Zw4AMSzjtDvAuvPgzWuLk5ZoLm44K41OI3SqXF4y4f_KmCj
    0XY0TeMUikHgwrlAKjdVDS4zlK7oUD0mxRM65X_61wqX2Q-nXEN0tA>
X-ME-Received: <xmr:f1D9aafMA7fz8V58EWJZSfkpsbLAR2iH1SlaZVlQzm0k3zsHXUI4XIwOE-eZ0nFr74w5JtJ--Rh9aq-zzo_u2tJbqJOXubutZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhnrghtuhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:f1D9adicXbaAD2Lbp4K-tyvDc8yKnsnj43F6QO43fF7pE1HWPB43hQ>
    <xmx:f1D9aSynWw79KUJGWfsQvRQkO6wcUmZFevYt4zrp0HM_glJWjDOKAQ>
    <xmx:f1D9aZPU90jZUEqpG7LQcb2YiBS9whclZv-llvb3e2fZN5Br4zgxsA>
    <xmx:f1D9aTULDjotZ-uy6JFniSvMn2SXDSCDJLy2K86RkFbmrcbAvyE4HA>
    <xmx:f1D9aYWKpBSFvIG_e1C8tHVwekK5EELwBxNNnmfEP_guNA92UzrH3hlm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 22:54:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Shnatu <snatu@google.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] Makefile: link osxkeychain helper against Rust
In-Reply-To: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com> (Shardul
	Natu via GitGitGadget's message of "Tue, 05 May 2026 17:26:16 +0000")
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 11:54:54 +0900
Message-ID: <xmqqlddufw5d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shnatu <snatu@google.com>

If your name is "Shardul Natu", we'd prefer (not 'require', but
'prefer') that the patches authored by you also identify with that
name, both on "From:" and "Signed-off-by:"..

> When Rust is enabled, ensure that the git-credential-osxkeychain
> helper is linked with the necessary Rust libraries.
>
> Introduce the RUST_LIBS variable inside ifndef NO_RUST block
> to hold the Rust library dependency, and use it in the helper's
> build target. This cleanly handles cases where Rust is disabled,
> making it a no-op and avoiding any build failures on systems
> without Cargo.
>
> This addresses reviewer feedback from internal CL 910223487
> by simplifying the variables and avoiding confusing "LINK"
> terminology.
>
> Signed-off-by: Shnatu <snatu@google.com>
> ---
>     Makefile: link osxkeychain helper against Rust

Thanks.  I've added to CC: a few folks who may be more clueful in
the affected area than I am.  It somehow feels strange that we have
to have RUST_LIB and RUST_LIBS separately, and apparently with the
new definition the latter is expected to be a superset of the
former, and it is unclear what are the things that should be added
to the latter without getting added to the former.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v1
> Pull-Request: https://github.com/git/git/pull/2288
>
>  Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f86173f93a..a17dca22b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1593,6 +1593,7 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
>  ifndef NO_RUST
>  BASIC_CFLAGS += -DWITH_RUST
>  GITLIBS += $(RUST_LIB)
> +RUST_LIBS = $(RUST_LIB)
>  ifeq ($(uname_S),Windows)
>  EXTLIBS += -luserenv
>  endif
> @@ -4082,9 +4083,9 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
>  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
>  	$(AR) $(ARFLAGS) $@ $^
>  
> -contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
> +contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIBS) GIT-LDFLAGS
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> -		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
> +		$(filter %.o,$^) $(LIB_FILE) $(RUST_LIBS) $(EXTLIBS) -framework Security -framework CoreFoundation
>  
>  contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
>  	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
>
> base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2

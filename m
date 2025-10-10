Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B21207A20
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125537; cv=none; b=vAjD9RgOx4z7JOy0+c9+DtJtN9/YPhMxoXsBb/csYpVfdtbL5TMHILYDQ9aGCdpvpjYY4BYlY+1uMMEaAmFs+nvlDpdki6HSwsCcK50yVqdihI1AIXsDEXQ82uSLGQK8lN6/Ccp8/zk+A/Wl674fwIU4p0mkZGdeZJ4P7teNPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125537; c=relaxed/simple;
	bh=mggVNbXOmzNsv8OOpxvRU3CzrDu1+jzDvslsdWmITy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1pDUten77umnuu3tddyC8jnpKwevjR3L+ovxrmhYmkL2t9Lw7jbr5WqfY4gWESkoff3Vg3NGPIrHDkst8ldPM1x6Os4XUp+MuGYPUPmyFb8QO2eaAwg0cAiZs8FpOoroYZcyTvlB6ETsnHBZ73F7kynWDK4EN3Y3Et2/tUNSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OjIMbK5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zCmVb5D8; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OjIMbK5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zCmVb5D8"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D0FE7A01A0;
	Fri, 10 Oct 2025 15:45:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 15:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760125533; x=1760211933; bh=skdT+RZfex
	6vYdY6ujcV9/IAeGG2ylUG7tAxg9GSH0I=; b=OjIMbK5HSq0isnm/rUHKoO+T1p
	EysDMBCKiHpo78n8IfyoFGNxx4rkZgwwp4oPqacN/ZPnYN78zChxSf9Frbxku64n
	cLVlXqRHG9k3mriG1MXKZMvD7nNjKDCiiRqxPP2tuplL0kIiFTzUa4bOF2EboKP1
	/ZnWiSr5SeXeQOIdPGTOVYtNur5Z0iZum2GuZpUdaMzc6bY4FuVzHU/UGmT/PfLR
	Cuu7thl1+L4japq9ebn/dxxPikMVNEk+E2OudQDaub1rQPr9DRhjnxVv3wL3r1Ht
	+VwryttUoH283FYg3KBSflsxMT6/pteDTN6SF1r1DuLdjQnAUT5+8UdC/NZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760125533; x=1760211933; bh=skdT+RZfex6vYdY6ujcV9/IAeGG2ylUG7tA
	xg9GSH0I=; b=zCmVb5D8jiDYzz+lrhAFEp+lKAfpTvbiS4V9U+40g4UGblAndv4
	Z3dzqg86204PvQHxWhmOyrBlrI6hmweh/hO014ns18HFhvdKInsA/NJm64xNExEb
	g5ieC09cKFHrh3kzrOhJe/txkdPSjivvaCpYYcdJ+X+DTdKwDdTkfh+xRQ4XCpRt
	slD0loyZ/z9MsCsAse6eEGhNc6NPMLOb5jir35yBySwR+oQQ1wIbrzKYDvlCrVMw
	ZtLJa2AXrWzfCTYhh8b5DDtE8nmkW02yl90rQbh2jWV5PTY0bzCPgoXsOGqS8ZDT
	KxBXwfBWLl9BESax9vWtH7FBIFqs4mZtm0g==
X-ME-Sender: <xms:XWLpaLCQynbrKzv1bYsJ_WVi-W980eIfPffHrIDKzXMR3vpkZNJNfA>
    <xme:XWLpaJQ-SH2jvMXsvfLZzL445idA6lX8-GdWnHT7Y8dynSJjmPH7BgUsndE9olyBz
    6stPh-eH4rheuR1y7MB4d3h3WzCqQS3nslPRAqN5y2Nd9Rdnsdmkw>
X-ME-Received: <xmr:XWLpaJoYzbLwywz6XghR8YEmphpaST7WpZU6AFEfxgeD1oadrrgQBf3YZ6dXCyR-CVG1NMRM1s5tyq7RDLwAHKICZyGyxgh75Evj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdhuhhhlvgesmhgrihhlsghogidrth
    huqdgurhgvshguvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:XWLpaLxW96mQt3aALJbAdryn9-UuDhDNqlIOGozpqszWCprDrAmvBQ>
    <xmx:XWLpaOLfXwGDeO13plFwloMCKHRMrgLRgxrQ55uKllcyHCkl6xrsXA>
    <xmx:XWLpaNIffnw4HAGmneyIEbYHfGEVJeE5GbS6782waTzrZw9R_rACwA>
    <xmx:XWLpaDtGzDEes209LN29qVIg7DLIFrCzVMFXH6rtXFsBqP3lDbag7Q>
    <xmx:XWLpaJnjmaNQ-0QNRSkTNCh8H395kYsUn7wdJR3XQ4f0CLF7Etbn3wx->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 15:45:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
	(Thomas Uhle's message of "Fri, 10 Oct 2025 19:30:22 +0200")
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
Date: Fri, 10 Oct 2025 12:45:31 -0700
Message-ID: <xmqqbjme8rs4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:

> diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
> index 97ce9c9..8ee6cce 100644
> --- a/contrib/credential/libsecret/Makefile
> +++ b/contrib/credential/libsecret/Makefile
> @@ -1,17 +1,21 @@
>   # The default target of this Makefile is...
>   all::
>
> -MAIN:=git-credential-libsecret
> -all:: $(MAIN)
> -
> -CC = gcc
> -RM = rm -f
> -CFLAGS = -g -O2 -Wall
> -PKG_CONFIG = pkg-config
> -
>   -include ../../../config.mak.autogen
>   -include ../../../config.mak
>
> +prefix ?= /usr/local
> +gitexecdir ?= $(prefix)/libexec/git-core
> +
> +CC ?= gcc
> +CFLAGS ?= -g -O2 -Wall
> +PKG_CONFIG ?= pkg-config
> +INSTALL ?= install
> +RM ?= rm -f
> +
> +MAIN:=git-credential-libsecret
> +all:: $(MAIN)
> +
>   INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
>   LIBS:=$(shell $(PKG_CONFIG) --libs libsecret-1 glib-2.0)
>
> @@ -22,7 +26,13 @@ OBJS:=$(SRCS:.c=.o)
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<
>
>   $(MAIN): $(OBJS)
> -	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
> +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)
> +
> +install: $(MAIN)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>
>   clean:
> -	@$(RM) $(MAIN) $(OBJS)
> +	$(RM) $(MAIN) $(OBJS)
> +
> +.PHONY: all install clean


> diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
> index 0948297..b1d7c29 100644
> --- a/contrib/credential/osxkeychain/Makefile
> +++ b/contrib/credential/osxkeychain/Makefile
> @@ -1,19 +1,35 @@
>   # The default target of this Makefile is...
> -all:: git-credential-osxkeychain

Having the primary target name on this line very early in the file
has documentation value.

> -CC = gcc
> -RM = rm -f
> -CFLAGS = -g -O2 -Wall
> +all::
>
>   -include ../../../config.mak.autogen
>   -include ../../../config.mak
>
> -git-credential-osxkeychain: git-credential-osxkeychain.o
> -	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS) \
> +prefix ?= /usr/local
> +gitexecdir ?= $(prefix)/libexec/git-core
> +
> +CC ?= gcc
> +CFLAGS ?= -g -O2 -Wall
> +INSTALL ?= install
> +RM ?= rm -f
> +
> +MAIN:=git-credential-osxkeychain
> +all:: $(MAIN)

What's the point of an extra $(MAIN) definition (not just here but
in the other Makefile as well)?  It may be slightly convenient to
write while the thing is simple and stays one-source-one-binary, but
programs including Makefiles are more often read than written, so we
should optimize them for readers.  I personally think this extra
indirection is hurting readability more than helping.

Other than that, yes, it is great to make these three or four
Makefiles look similar to allow readers compare and spot
differences.

Thanks.

> +
> +SRCS:=$(MAIN).c
> +OBJS:=$(SRCS:.c=.o)
> +
> +%.o: %.c
> +	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
> +
> +$(MAIN): $(OBJS)
> +	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
>   		-framework Security -framework CoreFoundation
>
> -git-credential-osxkeychain.o: git-credential-osxkeychain.c
> -	$(CC) -c $(CFLAGS) $<
> +install: $(MAIN)
> +	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
> +	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
>
>   clean:
> -	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
> +	$(RM) $(MAIN) $(OBJS)
> +
> +.PHONY: all install clean
>
> base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b

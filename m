Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E48F77
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982831; cv=none; b=bEtbuPYTjhMJAOXOF/sTCzY1dk8WCFsi1jLFv96RZhYXO6+7dmrZFyJwt3RFR6bLSNszuaHAkiLYHqkmYnv2VDQt0xEACr8zX4Sh0HGscDIXE7heXSNMBrCws+4Ba4xiZGomu5N3H9hV2ifhunhj69xa61Olau9WOUsk7w2e1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982831; c=relaxed/simple;
	bh=dZFNYhffa3U1s0IjyQmwaUgRZqaf4DnUErUOy4Bwdrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGy0Xb6fMVXqTj3e4MHS8RfPSM0v2iFeNKxsHJO6I1U4N77Mx5E0EabTKvwohDf4EzLCIqzfOio9rxDhn0qEmunRpe4k4lh1VsfVWZ5eUxQFISINbY5dC+WdcwPDaSf2spuVpR5bqO3xFXZXeZLxnMfiaQxgGrqPtyj70Ye46u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fcHl+D8M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rrnw8EgQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcHl+D8M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rrnw8EgQ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4DCEE25401B3;
	Wed, 15 Jan 2025 18:13:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 18:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736982828; x=1737069228; bh=zp2KzmzPIB
	1L9Rck2y1TM7ozOM+NEOeP6b3fI2OpkBw=; b=fcHl+D8M/lcTopsv8LIbZGiLIc
	anHcAfECAvrHN1/3fVipEsRti/fNov19TZjy5HGjrDlkzfqrmlkYRcphP4K/4pA6
	3TfLv+/UqqGugSBBTu06rVRRTqDLvUjW3vMN7gm3ACmpKsH8Q/JNyStZB7XAThdb
	4Rcr7wIqIJ3EnlTMC9wdzW4zUf35knxfN0yFnezeA58i+07G2pXTpG91fayNx5zy
	0PBbhh1+YEPU86BmvJ2It6xamNW/CSTIvNkNb19xsWqONq/hnhO44rUXdKKQXdgD
	Jv39RYqF5wa9j8Kl4x21Hzg2s/dOFjvX9wvM4xneHOpoEACFyj7jHL65uZ2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736982828; x=1737069228; bh=zp2KzmzPIB1L9Rck2y1TM7ozOM+NEOeP6b3
	fI2OpkBw=; b=Rrnw8EgQeWwzd7HaQA3ZzhdhUqSaf0U/Lb5MyjFIXBzKNBqm3nP
	esN3HJLGfRHCv/qbqJNDfbP9trt0hZkQ4vODELKtWOUiheys9hhi2SLA8Q8OSKB3
	4ieEwg3vRmDKQVSw4DayNK74miFbKgHEaixqgc4fB1RvUyrApbXw7gR6pWGCzC2w
	NDL6+uCOu+U5p4Yi4AdfUAZyeKOGibPiOKMctm927gdEK3BQ/BMLfDeF5lG5/xbO
	8pMaMBMCPwAswAlN+2sTbxt4896tBBo3fFoCzM6AIPQDkChWcW+knrhHMhM6YQ8N
	9VQeBsgYWLuhLUVoFnIIx7724PKThrxZX3Q==
X-ME-Sender: <xms:K0GIZxbIhyT25mgdC1-9FnZoNXTSDHQuUP0lY-h7pgq15658JVVB7g>
    <xme:K0GIZ4YR0lstyruUT8DQUOk2ZD0XdLMwrHYH-orL8XJyXuXNtDCF8y67-CbT4yFNM
    pos9fNG-AvBMIEDgA>
X-ME-Received: <xmr:K0GIZz8yGCcupCflb20OGKz6rkzFDZzyFP5UDYHJAoRA1ev4A4Ni0nAQjnhaxnqsdyxdFX2gYzZOm98TPk2ro6A9Y8RzNWzF7iuX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghm
    rhgrshhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmhhesghhlrghnughiuhhm
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:K0GIZ_pqaZsQJ5qopUkWcqkBaM7FSuRz8Ny8UPsEDmFis5hK9c7_Fw>
    <xmx:K0GIZ8rsuojVuLPXubL7wggKOjFtNeniP0WmMJmVi_n6Bu6N1zDfvA>
    <xmx:K0GIZ1Tqch8Bddu1qO6H1Jbh0irxJ8Kh-ERdYnAFyOsuI-9NOWd0ig>
    <xmx:K0GIZ0rPgvKFEESU87YjHGz4DKejgyegfmyhB7MrUZHVCjxd7AtyXQ>
    <xmx:LEGIZyg2Ce0eWyCKPslVZ8b89vB4Sr_0QeYgs-i6B86rwdACSuhK6_gK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 18:13:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  mh@glandium.org,
  ps@pks.im,  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com
Subject: Re: [PATCH v6 2/5] libgit-sys: introduce Rust wrapper for libgit.a
In-Reply-To: <5fc66cdb1628e0c9e420f3f0455779d7471f46ee.1736971328.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 15 Jan 2025 12:05:41 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
	<5fc66cdb1628e0c9e420f3f0455779d7471f46ee.1736971328.git.steadmon@google.com>
Date: Wed, 15 Jan 2025 15:13:45 -0800
Message-ID: <xmqqa5brwtzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/Makefile b/Makefile
> index 27e68ac039..47e864a861 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -657,6 +657,8 @@ CURL_CONFIG = curl-config
>  GCOV = gcov
>  STRIP = strip
>  SPATCH = spatch
> +LD = ld
> +OBJCOPY = objcopy

This assumes GNU binutils is available.  As long as our intention is
to start the Rust support as an optional feature, that is OK.
Hopefully the piece that requires $(OBJCOPY) is arranged to be
easily opted out.  Let's keep reading.

> @@ -2731,6 +2733,7 @@ OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
>  OBJECTS += $(UNIT_TEST_OBJS)
>  OBJECTS += $(CLAR_TEST_OBJS)
>  OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
> +OBJECTS += contrib/libgit-sys/public_symbol_export.o

This is compiled for everybody, even for those whose platform cannot
support Rust interface (or those who choose not to build it).  As
long as what is in the file is written portably, it is fine to have
stubs and entry points that their build will not use.

>  ifndef NO_CURL
>  	OBJECTS += http.o http-walker.o remote-curl.o
> @@ -3726,6 +3729,10 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>  	$(MAKE) -C Documentation/ clean
>  	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
> +	$(RM) -r contrib/libgit-sys/target
> +	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
> +	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
> +	$(RM) -r contrib/libgit-sys/libgitpub.a

Which one of the above is a directory?  The latter three smells like
a regular file, so we shouldn't say "-r" there.

> @@ -3887,3 +3894,12 @@ $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
>  build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
>  unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
>  	$(MAKE) -C t/ unit-tests
> +
> +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
> +	$(LD) -r $^ -o $@

OK.  We build a "relocatable" object, which is unconditionally made
as part of $(OBJECTS) above.  Even without GNU binutils "ld", people
hopefully can convince their linker to do the equivalent.  I am not
sure if it is healthy to assume that such a linker also uses "-r"
for the feature, so we may have to make this rule more customizable,
or make partial_symbol_export.o only conditionally part of $(OBJECTS)
to allow them to opt out.

> +contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
> +	$(OBJCOPY) --localize-hidden $^ $@

Unlike the "public" thing, hidden_symbol_export.o was not made part
of $(OBJECTS), so this part is arranged to allow people without
$(OBJCOPY) to easily opt out of this part of the system, which is
good.

> +contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
> +	$(AR) $(ARFLAGS) $@ $^

Likewise, people can easily opt out of building "libgitpub.a", which
is good (these targets are triggered only from build.rs).

> diff --git a/contrib/libgit-sys/README.md b/contrib/libgit-sys/README.md
> new file mode 100644
> index 0000000000..c061cfcaf5
> --- /dev/null
> +++ b/contrib/libgit-sys/README.md
> @@ -0,0 +1,4 @@
> +# libgit-sys
> +
> +A small proof-of-concept crate showing how to provide a Rust FFI to Git
> +internals.

OK.

> diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> new file mode 100644
> index 0000000000..7cd5007902
> --- /dev/null
> +++ b/contrib/libgit-sys/public_symbol_export.c
> @@ -0,0 +1,21 @@
> +// Shim to publicly export Git symbols. These must be renamed so that the
> +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
> +// avoids conflicts with other libraries such as libgit2.

Style.

> +#include "git-compat-util.h"
> +#include "contrib/libgit-sys/public_symbol_export.h"
> +#include "version.h"
> +
> +#pragma GCC visibility push(default)
> +
> +const char *libgit_user_agent(void)
> +{
> +	return git_user_agent();
> +}
> +
> +const char *libgit_user_agent_sanitized(void)
> +{
> +	return git_user_agent_sanitized();
> +}
> +
> +#pragma GCC visibility pop

I do not think we would mind not having Rust binding support on
platforms without GCC (and clang---I assume it would be aware of and
react to that #pragma GCC the same way?).  But do we allow this file
to be left uncompiled when the build wants to opt out of Rust
support?

> diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
> new file mode 100644
> index 0000000000..a3372f93fa
> --- /dev/null
> +++ b/contrib/libgit-sys/public_symbol_export.h
> @@ -0,0 +1,8 @@
> +#ifndef PUBLIC_SYMBOL_EXPORT_H
> +#define PUBLIC_SYMBOL_EXPORT_H
> +
> +const char *libgit_user_agent(void);
> +
> +const char *libgit_user_agent_sanitized(void);
> +
> +#endif /* PUBLIC_SYMBOL_EXPORT_H */

OK.

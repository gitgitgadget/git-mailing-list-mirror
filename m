Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54391392
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 00:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737504235; cv=none; b=iwW//RGK7989cRlhIAP8H9HvBaCmB/UR4GZH+uczBLaDwSMjBLueDl76m9X7BvVTRloiNoZsTzbBw132p8nCaAUGgYW25b4V0OWlZu4dRr2rqT4zWDvC8w+BPoZd61FLRP/roEvZusaDkIhcyaxFU5O/SY3KAiol9nn9alaqVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737504235; c=relaxed/simple;
	bh=lxGYZH1j5NhFDapsx95Jv+vOlmwLCCHDptEzLcGnwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU0aB0LjDDiWqYUBDTm8w6C6cSiuK6np5Ke3TA8g4vhk9glWIlJSUKzZYKdxc1cUMiupgE8KerQnLXFpdEWH+2+tXAHoMvatZyiHE8A78SGdWr3cP9zv8viU+FQFYy6HaLhviSPXqP8AC/levnDP/xE4OVa9Qzk9VCWsGzNIDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0gFi3Qu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0gFi3Qu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163affd184so27755ad.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2025 16:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737504233; x=1738109033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkvBEB2EYDa6tndvVYoABcU/yGjuYjCU3MRrstfEqWg=;
        b=f0gFi3QuaDQuBQc35iAhA6opnqWINIiCLKTAfkiFv3BWhIN2VQgME9hc8G220uSTWh
         cvN9JYTPe+ONg5eWsyv++k00Nj15A3gKIJDjy46NUzqPrAnYoe0UioSacIZt8cOhTckG
         yPu1LnCmIXMC/WTiCoIWI87vgSig0cHm+N2rh1r6X4T2tCjeu7d6kixhnyWn0zfPc0hz
         y87t92cH44iASIQf/2ZLSzQTiaz18Ao21i1z4X8NsTvfBaxsncohN/gONeijnmGKn8EY
         UGn6uqhmbvccN8KJTwUpBSzTIBci7PBDiDu+qQMPBr7300Q5MSufsCmimw/LVjw1R3dI
         mGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737504233; x=1738109033;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkvBEB2EYDa6tndvVYoABcU/yGjuYjCU3MRrstfEqWg=;
        b=lb154838mZE9pAerOgRA9OoLBuUTbqKbTE7KAkDYiyCkMDXKSRaxyCwW81heksbybi
         wuuUw4/zJOA+ntmpXWnTZN2nYzUgv7220KDJFn6zQ/zbZ6N3KNuXZaljuRQOnPIoYRef
         GqB4FmUOOHx69AZBCi/QKVz0Y+dd5Bt7/KQQluiZFkp4h3tw4KZPNPusTbSvFUnYMsp2
         Yt7Vij0DcnR4CfKXmpW/A7Kz6VT9IfXhRE4fVwZ6ap5nGKDDSENCaO6H2NEK0dV1TAu8
         etWrFnzxS7cxbxMHDBQjoXg/8xnh0WHBIRLblHV488fZb7rOWyOs3F+Cg3C9SIKJfig6
         550w==
X-Gm-Message-State: AOJu0Yxl4RFwJOvAYTviLyrhgwAbsmut7KjEwMYxdFTX14yCQfmFiyjQ
	SRLVTS5fNAeDdrsYNDK8FFPJtEsx0E9JQE978v7e94abp4y0vc4HpYyOkhycew==
X-Gm-Gg: ASbGncshLsQQL2bKlqtX47PmTPXns5iNFH9+If4KM1uNijD5vYFx6FoeTnpc//6sWTM
	0IlvtiphE8xbVrA4RyijVLGWMyOKGUmDdndgdzNsBuLaqzU+xnlN67Lm9bBeLr32s/pd85wRfk2
	R09ZfC+wLM4W/6mqtjvnE0j0Ol1WzBKgbmpH03gdKZ4LIOM2KRcC48QzG6b9ZNKQta8lxYw2dza
	CAvYv/kWOJ37RMFxLq7X1eh2FxT7N324h2YFV9L6FKmunKFqVLhngSReY7KDYMAj9YD
X-Google-Smtp-Source: AGHT+IG8Img93fb/tZJONmtyXbPMzI746UubAbZFZuGd07wm9Qu0+c3cRq77iOXKVX0MMxn3nsTF6Q==
X-Received: by 2002:a17:902:ed97:b0:216:2839:145 with SMTP id d9443c01a7336-21d8ec8a7d5mr506605ad.1.1737504232493;
        Tue, 21 Jan 2025 16:03:52 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:16d0:c948:f6ad:1381])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6ad43cdsm101953a91.39.2025.01.21.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 16:03:51 -0800 (PST)
Date: Tue, 21 Jan 2025 16:03:47 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
Subject: Re: [PATCH v6 2/5] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <d2qnphuygwjfi753pvhlhg4hunhddmqrs25wo3zmruruop6q3b@s6ustbmf4rn5>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
 <5fc66cdb1628e0c9e420f3f0455779d7471f46ee.1736971328.git.steadmon@google.com>
 <xmqqa5brwtzq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5brwtzq.fsf@gitster.g>

On 2025.01.15 15:13, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index 27e68ac039..47e864a861 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -657,6 +657,8 @@ CURL_CONFIG = curl-config
> >  GCOV = gcov
> >  STRIP = strip
> >  SPATCH = spatch
> > +LD = ld
> > +OBJCOPY = objcopy
> 
> This assumes GNU binutils is available.  As long as our intention is
> to start the Rust support as an optional feature, that is OK.
> Hopefully the piece that requires $(OBJCOPY) is arranged to be
> easily opted out.  Let's keep reading.
> 
> > @@ -2731,6 +2733,7 @@ OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
> >  OBJECTS += $(UNIT_TEST_OBJS)
> >  OBJECTS += $(CLAR_TEST_OBJS)
> >  OBJECTS += $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_PROGRAMS))
> > +OBJECTS += contrib/libgit-sys/public_symbol_export.o
> 
> This is compiled for everybody, even for those whose platform cannot
> support Rust interface (or those who choose not to build it).  As
> long as what is in the file is written portably, it is fine to have
> stubs and entry points that their build will not use.

Later on in the series we add an INCLUDE_LIBGIT_RS variable to control
builds and tests; I don't see any reason why we can't move that earlier
in the series, so I'll do so in V7 and then look at what we need to do
to make things more portable.

> >  ifndef NO_CURL
> >  	OBJECTS += http.o http-walker.o remote-curl.o
> > @@ -3726,6 +3729,10 @@ clean: profile-clean coverage-clean cocciclean
> >  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
> >  	$(MAKE) -C Documentation/ clean
> >  	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
> > +	$(RM) -r contrib/libgit-sys/target
> > +	$(RM) -r contrib/libgit-sys/partial_symbol_export.o
> > +	$(RM) -r contrib/libgit-sys/hidden_symbol_export.o
> > +	$(RM) -r contrib/libgit-sys/libgitpub.a
> 
> Which one of the above is a directory?  The latter three smells like
> a regular file, so we shouldn't say "-r" there.
> 
> > @@ -3887,3 +3894,12 @@ $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-
> >  build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
> >  unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
> >  	$(MAKE) -C t/ unit-tests
> > +
> > +contrib/libgit-sys/partial_symbol_export.o: contrib/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
> > +	$(LD) -r $^ -o $@
> 
> OK.  We build a "relocatable" object, which is unconditionally made
> as part of $(OBJECTS) above.  Even without GNU binutils "ld", people
> hopefully can convince their linker to do the equivalent.  I am not
> sure if it is healthy to assume that such a linker also uses "-r"
> for the feature, so we may have to make this rule more customizable,
> or make partial_symbol_export.o only conditionally part of $(OBJECTS)
> to allow them to opt out.
> 
> > +contrib/libgit-sys/hidden_symbol_export.o: contrib/libgit-sys/partial_symbol_export.o
> > +	$(OBJCOPY) --localize-hidden $^ $@
> 
> Unlike the "public" thing, hidden_symbol_export.o was not made part
> of $(OBJECTS), so this part is arranged to allow people without
> $(OBJCOPY) to easily opt out of this part of the system, which is
> good.
> 
> > +contrib/libgit-sys/libgitpub.a: contrib/libgit-sys/hidden_symbol_export.o
> > +	$(AR) $(ARFLAGS) $@ $^
> 
> Likewise, people can easily opt out of building "libgitpub.a", which
> is good (these targets are triggered only from build.rs).
> 
> > diff --git a/contrib/libgit-sys/README.md b/contrib/libgit-sys/README.md
> > new file mode 100644
> > index 0000000000..c061cfcaf5
> > --- /dev/null
> > +++ b/contrib/libgit-sys/README.md
> > @@ -0,0 +1,4 @@
> > +# libgit-sys
> > +
> > +A small proof-of-concept crate showing how to provide a Rust FFI to Git
> > +internals.
> 
> OK.
> 
> > diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> > new file mode 100644
> > index 0000000000..7cd5007902
> > --- /dev/null
> > +++ b/contrib/libgit-sys/public_symbol_export.c
> > @@ -0,0 +1,21 @@
> > +// Shim to publicly export Git symbols. These must be renamed so that the
> > +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
> > +// avoids conflicts with other libraries such as libgit2.
> 
> Style.
> 
> > +#include "git-compat-util.h"
> > +#include "contrib/libgit-sys/public_symbol_export.h"
> > +#include "version.h"
> > +
> > +#pragma GCC visibility push(default)
> > +
> > +const char *libgit_user_agent(void)
> > +{
> > +	return git_user_agent();
> > +}
> > +
> > +const char *libgit_user_agent_sanitized(void)
> > +{
> > +	return git_user_agent_sanitized();
> > +}
> > +
> > +#pragma GCC visibility pop
> 
> I do not think we would mind not having Rust binding support on
> platforms without GCC (and clang---I assume it would be aware of and
> react to that #pragma GCC the same way?).  But do we allow this file
> to be left uncompiled when the build wants to opt out of Rust
> support?
> 
> > diff --git a/contrib/libgit-sys/public_symbol_export.h b/contrib/libgit-sys/public_symbol_export.h
> > new file mode 100644
> > index 0000000000..a3372f93fa
> > --- /dev/null
> > +++ b/contrib/libgit-sys/public_symbol_export.h
> > @@ -0,0 +1,8 @@
> > +#ifndef PUBLIC_SYMBOL_EXPORT_H
> > +#define PUBLIC_SYMBOL_EXPORT_H
> > +
> > +const char *libgit_user_agent(void);
> > +
> > +const char *libgit_user_agent_sanitized(void);
> > +
> > +#endif /* PUBLIC_SYMBOL_EXPORT_H */
> 
> OK.

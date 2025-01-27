Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EF18D626
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019945; cv=none; b=gdfO3y8UpMBUMOTEh9sZIkzUnGuNnB1N/dHgDofOb584uyGCLfjaXuptmyxiSOY7IZMHI2atyCedod3sA0bNTztGjiUoaYkgXGimiBuTGWzbcFmxlJjJuOcctbMWWPEo+H+FfVYLfcF3LTGHAkFxD/cB/EwkZ6IpBk1eHtLamJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019945; c=relaxed/simple;
	bh=n5cU0bZw8gyt/FSttAQAyPGYmEy8v1GLSPeYz96Y0Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbstvRkV+BmZRO8NHL1LTVq3Xf+2I1bAyCS2Obvjt4QGB4gCIwEK+13ExGATSQGXPQrrBZskK/aOmELcDLG0crzF7YPTy1aPOaVcz+Sv28kEXVvlov2gdU4k05VC0b8+WdMrqSM+fbS8IKbBc2YKdWSAJ4jJz2VbIjlrcLGVu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxIGKKSV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxIGKKSV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-219f6ca9a81so21825ad.1
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738019943; x=1738624743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6mzxaL5RojOvdYvN4sy2WwjMF/dL7RaRJiqFYE62r0=;
        b=NxIGKKSVtiwJ1cR7BjwfKjfIOsqjEMcDcyv9JNOWwMqU5LWlyYKLOW7Yzwut04I1Au
         MQu8j5q6r7ZkF4yhgULMR4HhqAaTZVHm568wi2GRBBFyVb4gFQ6Rfv2RzQJSEPRrW4QQ
         yq/I5vT4Tw71JiAQRqYNX4CbMRF3z7lgCSr8WCsZ8vL9WntA5X1YmIVPgJQREnk+4zAl
         KNMHH+g/Rjt05LNeS7gl6IyqUf3b4JCeXudNgP3AeRtmxRapvCxXIQREPY/kKOLEXXR+
         AUYM0qG7CEipXwtTNfTzwCux1DUbHbFNkhvnyy7D5xoYvOxrQdn2l0YHEFJNAxS5NIZ6
         JofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738019943; x=1738624743;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6mzxaL5RojOvdYvN4sy2WwjMF/dL7RaRJiqFYE62r0=;
        b=VpxXOtRO/rUYIC8L778YI0DLJifSfvKr3Xu1dLsY5XVaDFKLybm13uxk6eJkO3/hNN
         kEkNDdlkEeRkIq577hxNNLVjwDN56Zy5oHF1LhU92g0W5wrn/+3nYIivv/pu4CwDya49
         Xv2voTYBGRkSWMj5ay1rJz/FLjqP3lZEyQOsxhWMtHU7SUz4zLw5fkT+wzdveh7L8q87
         lvs8huZBCC6a3SxXC/9LDh2bAHu0gCxgpIhRYFzpKNyAhFw5QJO8Kdb39FJ0jGx5+Nwk
         Ky34WwNSGtVE13PnApIEmkdtKiHt0LSi9W084VIFnZ0rv3RCVRrpyP9rgFNMd+BzCTFF
         8cVg==
X-Gm-Message-State: AOJu0Yz6BW4C+I3j2ko+jaAkHPhYmK5w9cU4owkO9uq6qiQ214iie35E
	NMOQ3PlWNr9kWOglMXU87FPM7HyxJh4f/Pdxa7zIQkWNSg1RsUdYNvO4DFEZrA==
X-Gm-Gg: ASbGncv5acyUyjuzOfWjwgu7QucfTRePnKdiHutIZXPH93M5ZZDoJx8/6IRIJ+WOYhv
	B7rE4h1j9PDVEZUci2mO3cVn1QRgVQjcuDfsJmVLvrp3ozj5LrTT+XgtOemKgZv1iKhXaFkvHHX
	0Wre57DknNUu775nrcYJIQx+TH385f2RQAMP4Rgqcl6JRcgXc/PI8TDeq9KXwTpCK2dyFzHMLI2
	xC6bK//q9TI3DDCpzWBMlQewyd1dkDWbIbRRdyjm162uhc67ajh32dbYcMeMrKrbrWVoo3dFIV9
	aco=
X-Google-Smtp-Source: AGHT+IF2EgVIZjHDOVPyZiMcw/dGXWHD6QJIimZ8xahsaPaz6iL+9bE8RXuU6IYsnsgyWQ1B9qdYMQ==
X-Received: by 2002:a17:903:284:b0:215:7ced:9d67 with SMTP id d9443c01a7336-21dccece379mr894345ad.24.1738019943184;
        Mon, 27 Jan 2025 15:19:03 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:61c6:8099:70ae:8d93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c595sm8007613b3a.143.2025.01.27.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 15:19:02 -0800 (PST)
Date: Mon, 27 Jan 2025 15:18:57 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, mh@glandium.org, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
Subject: Re: [PATCH v6 2/5] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <ebqg66cp3mttyrjne2gonmjis7v6djp6jmnpzjj6o6e7sz5taw@fezpjrflojm5>
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
> react to that #pragma GCC the same way?).

Yes, GCC and clang both handle this the same way.


> But do we allow this file
> to be left uncompiled when the build wants to opt out of Rust
> support?

Yes, in V7 this will only be built if INCLUDE_LIBGIT_RS is set.

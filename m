Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D51199EAF
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097255; cv=none; b=p4rXohYLLZWInNvXMEqyB+JtjzO1qLwFYIM4AteW8VGWksN2OS9EJg2Dt30+S+2YD+1LHcD6JfRpKLC8/qg+SZ6FERqS8v9J1/C33YV/Abw/D6+IfZAL1aAoQy8VMjz9zq2rX2PvD34l7e5XcOrOiBkbdlEtVxN9aTSBXTuJDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097255; c=relaxed/simple;
	bh=NekWp5GtxgyU9ok1rQ5nE1Fkc4BnlxptlSncPBxx1hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRFjEOSJBBNVBrhKf8qCFiVUvi4id9zdkEsf7jXvRLmpRvyLWvYFv3k+GnIY2ASOgCNF35MRP5+AVjF/I0KjYeXfsFZ9eFahofpMNlYvnTRWB5VwdInS+wrSdrDMVppO1basxZ5SkhXa7vlwE0Fn8YDrG0Y3gPUyaRuoIHDxYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7siGUDL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7siGUDL"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2163affd184so184705ad.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738097253; x=1738702053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anwKhqv/GsDj0agCBAPjZbVC8VlLef/4ubo3Yp9QSvQ=;
        b=S7siGUDLlZDyDDp0t8gYvPQ/yC5cXhctftHBLp8xc0+0wZnRWH0gMrCIl1Aqa7/Nab
         w1V9OCIvUzhua1GPnzqBIuGDHatNKWQLA52ykgUgnIOzVUdVhj8vkEFtTQHajMdv09R8
         dFQ6jqkQ7qpDFQqXdvbmN8ec7UClyo4CWC7vZaxSFKqulFf6FJStxYhRTpKd3Dp5m/nA
         0k47H1yyCUnLMAYGBu+WPMQkXTX1bFaESO48oojODP1pdpqLAS6XCg9gMWLoIgbEJsyf
         O1PKo0R8p7eM2X4V0sNDHYh5ShTT6zjpditUi4caxQBSKUgcrwXROpcOZWuHad4pYEjW
         ASwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738097253; x=1738702053;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anwKhqv/GsDj0agCBAPjZbVC8VlLef/4ubo3Yp9QSvQ=;
        b=W/FhcYWH6mb0j5IgHkB7VEcqWan/lt1XIBGi6lyYI4F8gkWSFQnjZM1GhVWmKFMrLx
         MfTCH2k36TwXRImoy0j8agzWtSFVAXMTX37287WG+NFDn6u6ymy0s6rYWZk2w6QoWfeu
         iV2++XKJeVHBrbOuPJ+3e8tmpCi7+8K2sr8U8k4iuaKNpxxlKxhwZF3/mdKrwk5c0Mmv
         Y59Tr1+Kipkx9smebWZN0Z9X0x1vPzbCKN7trwVLzz95v84/1Dwf3h/KJxFnCImBUleJ
         vN3FbgdBXJDAmwA7HPOmYcrXOMnoVajkTQPhmx0tHYYq68mBT8c4tOzllT/qJvxpc2GR
         vBFQ==
X-Gm-Message-State: AOJu0YwtJutidDSDspFvC6b3361Wsei/0O5nM/sBcFP1SfX3pb9mqOWW
	v9Pmh+cFn/v1NTys4tD2MNpb8pcaXb/eWsr3NOX54aTtaUnrwom0WS8dv6oGKmSubAIwQtNTAPf
	DMwnR
X-Gm-Gg: ASbGncswVvsRtirpVQt7PiFgaL9IIdrFAeFfhD1yK8SAKNi1xwWqt2ger3VCuvuQ5pD
	Hefi2ZIxtln2DiPK4VSCvaesW8N9L6M0YUKOlNCKcW7FWsFDlz0bUFMCWBJwZr1uMfci2iLjoZZ
	sfRridJYFGtFuf0w6GLgQh18+artyAfZAdDyarBt7NVmespMV09TtfMkBl+FLh4YPCwJcF6o8cX
	hJRSDFgbvkXlpw9ZKODu7kh2nCEtXNvZA27P7IVUUGLXLcC5Za6NKAtowMDHebw4h9WGvhPWzxo
	4STCsTAYl5FvtA==
X-Google-Smtp-Source: AGHT+IG5UN0v1M/tiHO2E0/op3i8JdFhy5dEVZSZNl3lbw/8xvgtWOfLIcdhwZt6BNXRbbc21bWl3w==
X-Received: by 2002:a17:903:2408:b0:216:33a:4b70 with SMTP id d9443c01a7336-21dd7f95454mr477605ad.2.1738097253159;
        Tue, 28 Jan 2025 12:47:33 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:ad31:b9eb:e4cd:2ffc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b31besm9991999b3a.54.2025.01.28.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 12:47:32 -0800 (PST)
Date: Tue, 28 Jan 2025 12:47:28 -0800
From: Josh Steadmon <steadmon@google.com>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v7 3/4] libgit-sys: also export some config_set functions
Message-ID: <hlfseilciwto4qajr2c4qvoxrfycef3jcvikpwj5aosopf3r3e@ohdkdqllyjxo>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	phillip.wood@dunelm.org.uk, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738023208.git.steadmon@google.com>
 <d67d3648d1bdb7dde5e475f3a8eba834cc0ea891.1738023208.git.steadmon@google.com>
 <8ed463cb-1191-4106-bf30-87e9e8bcc95a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed463cb-1191-4106-bf30-87e9e8bcc95a@gmail.com>

On 2025.01.28 15:08, Phillip Wood wrote:
> Hi Josh
> 
> On 28/01/2025 00:19, Josh Steadmon wrote:
> > In preparation for implementing a higher-level Rust API for accessing
> > Git configs, export some of the upstream configset API via libgitpub and
> > libgit-sys. Since this will be exercised as part of the higher-level API
> > in the next commit, no tests have been added for libgit-sys.
> > 
> > While we're at it, add git_configset_alloc() and git_configset_free()
> > functions in libgitpub so that callers can manage config_set structs on
> > the heap. This also allows non-C external consumers to treat config_sets
> > as opaque structs.
> 
> This interface is looks nice, I've left a couple of comments below
> 
> > diff --git a/contrib/libgit-sys/public_symbol_export.c b/contrib/libgit-sys/public_symbol_export.c
> > index cd1602206e..a0297cb1a5 100644
> > --- a/contrib/libgit-sys/public_symbol_export.c
> > +++ b/contrib/libgit-sys/public_symbol_export.c
> > @@ -4,11 +4,40 @@
> >    */
> >   #include "git-compat-util.h"
> > +#include "config.h"
> >   #include "contrib/libgit-sys/public_symbol_export.h"
> >   #include "version.h"
> >   #pragma GCC visibility push(default)
> 
> Personally I'd prefer it if we actually defined struct libgit_config_set
> here
> 
> struct libgit_config_set {
> 	struct config_set cs;
> }
> 
> Then we could avoid all the casts below. For example
> 
> struct libgit_config_set *libgit_configset_alloc(void)
> {
> 	struct libget_config_set *cs =
> 		xmalloc(sizeof(struct libgit_config_set));
> 	git_configset_init(&cs->cs);
> 	return cs;
> }

Hmm yeah I remember this feedback from (checks Lore) back in V2. I think
you're right, we should have gone this way from the beginning. Done in
V8.

> > +struct libgit_config_set *libgit_configset_alloc(void)
> > +{
> > +	struct config_set *cs = xmalloc(sizeof(struct config_set));
> > +	git_configset_init(cs);
> > +	return (struct libgit_config_set *) cs;
> > +}
> > +
> > +void libgit_configset_free(struct libgit_config_set *cs)
> > +{
> > +	git_configset_clear((struct config_set *) cs);
> > +	free((struct config_set *) cs);
> > +}
> > +
> > +int libgit_configset_add_file(struct libgit_config_set *cs, const char *filename)
> > +{
> > +	return git_configset_add_file((struct config_set *) cs, filename);
> > +}
> > +
> > +int libgit_configset_get_int(struct libgit_config_set *cs, const char *key, int *dest)
> 
> Style: this and the one below could do with being wrapped at 80 characters

Fixed.

> This whole series looks pretty good to me
> 
> Best Wishes
> 
> Phillip

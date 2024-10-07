Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659061DE3D4
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336121; cv=none; b=W80IXFU62XFS/jjRw3DDCB9wCVe7JrFRGY7yP2BdR/CaKbbHS24iXQmgzyKRKNYTNcFIgFNDs/NVCYQufIot79TN1l/Antll9T1JvGL/qbUH6fEovK93FUH3aJsqn75lfYSoWYcd22Y3cx33kJqXhT6+caR3ABLP7FKp0Khb+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336121; c=relaxed/simple;
	bh=rOOW0SMG0x5N0Oewx3da1jtMshF/+l3mIoIFca5lnRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1GeA7pZVTr4W3gv58XWxz1TCdnaeGxhh8W7OutHd70hzotgPygm/ii5negqw17WEECQl1nk3JBDqS+apAo7kubezEYHiuPVCXaTJiOOElNN/FVPBS3zCjH7hB7U8Uph/HzNf9ILjzpN5tbAEQXx3rX2SIdohGlfan5+knJrcLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3Y0xchK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3Y0xchK"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b3d1a77bbso66565ad.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 14:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728336120; x=1728940920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJ/oY+38WjCImNSgeJcwEDaGy7sl/jlDEvUb4bkAlsg=;
        b=L3Y0xchK13Y3D+hlWm9mJwedzdkxVDpNlsOiQZ+aGFMYy68xXIHAZ74TOzosJHvLH5
         4qEDdrueL4XMrqucF5P3knD9F64xoHzQ+Uq/qVdz8mTLA/34J7JJxnF38bE8HcIKcAbh
         olVO+p3TEmf1xh3SF2Y4p4YX4tbiaPh7ILQrmHo12QIllQ2UPJDJnFLp1RKzjfQAYWq9
         7IyRAQKHvENXlrVwixtN2MlpS925uNi208054flMGV+HGZa5tJv6B0IwAqulNB3k6t+d
         ckRucKZBCcMSl+62CZDUwr44Wk75QHz75Demm0ERhGlTTfZPqdumQUHNVKEvFBs01QNo
         MerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336120; x=1728940920;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJ/oY+38WjCImNSgeJcwEDaGy7sl/jlDEvUb4bkAlsg=;
        b=Z4J1oel/IQaiVi8wi1gFe+MQLvz43epaG+IiCrDylTL0Pp3B6V6oWnAk7PZ/4lsHSe
         Xn3i/1T0uiVB/FVfdYy6IGRnvMpUtHe65Zg/bT6z+RvWF7U10acHOGRjwPjbmLyKp0Od
         1RKgwWybYF8+efat9tJDBsBAUwLpGw0kf/j0W9hqCyqSFU/lM3+4CfWKqUrAdahb17GT
         IYKit6wBRs43tZ4BQfOpQ1a7QYH1ABGQRhM38LSvHRnYplSkZpo8IgPIH9VyGRn4mf8s
         pj5MIOY/ORRjO+5tqd3Y/6RGZ81rEJbZ9cX7W6IdvKYM0yanSJ27jBTHMoqxGS/7tdeP
         1bsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVq7AajkQcgpmPgiDKIOfN1lQN7wijH5c50mgz58fLJAn2QJkw7dATwDQw23TejHsj1bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyftegxYcIvoJaeL6SjjLCRuTYO8Vm9JYD+sxlyjupbKayW67f8
	XImD1AWDR4FhKz8LvEFQZIiNMsPWP6TeeX2bSPssxz49d6vlGB06h2cv0MkX6w==
X-Google-Smtp-Source: AGHT+IGpIwGFvnERjHxgeWg/FRyDwJNlR932/VHZKjTbwXK40XNZilFtxnh0Z9eqNHjjVlbaX67wlA==
X-Received: by 2002:a17:903:2345:b0:200:7d11:e8e3 with SMTP id d9443c01a7336-20c5019dd8emr880295ad.14.1728336119464;
        Mon, 07 Oct 2024 14:21:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2b15:5dbe:c4f0:bf3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d452a9sm4848143b3a.123.2024.10.07.14.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:21:57 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:21:51 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
Message-ID: <bjgxdo7sjueppt2y4i2psifuvgnld47jrusgpsao6fjyqfyld7@7hybmrhbdli5>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-3-calvinwan@google.com>
 <Zt_qOrrWubdU_yvx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt_qOrrWubdU_yvx@pks.im>

On 2024.09.10 08:42, Patrick Steinhardt wrote:
> On Fri, Sep 06, 2024 at 10:21:13PM +0000, Calvin Wan wrote:
> > diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> > index 39c27d9c1a..65d1620d28 100644
> > --- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> > +++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> > @@ -2,11 +2,37 @@
> >  // original symbols can be hidden. Renaming these with a "libgit_" prefix also
> >  // avoid conflicts with other libraries such as libgit2.
> >  
> > +#include "git-compat-util.h"
> >  #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
> > +#include "common-init.h"
> > +#include "config.h"
> > +#include "setup.h"
> >  #include "version.h"
> >  
> > +extern struct repository *the_repository;
> > +
> >  #pragma GCC visibility push(default)
> >  
> > +const char *libgit_setup_git_directory(void)
> > +{
> > +	return setup_git_directory();
> > +}
> > +
> > +int libgit_config_get_int(const char *key, int *dest)
> > +{
> > +	return repo_config_get_int(the_repository, key, dest);
> > +}
> > +
> > +void libgit_init_git(const char **argv)
> > +{
> > +	init_git(argv);
> > +}
> > +
> > +int libgit_parse_maybe_bool(const char *val)
> > +{
> > +	return git_parse_maybe_bool(val);
> > +}
> > +
> 
> I don't quite get why we expose functionality that is inherently not
> libified. Exposing the current state to library users certainly does not
> feel right to me, doubly so because `the_repository` is deprecated and
> will eventually go away. So we already know that we'll have to break the
> API here once that has happened. I'd rather want to see that introducing
> the library makes us double down on providing properly encapsulated
> interfaces from hereon.
> 
> Also, we already have ways to initialize a repository and read their
> config without relying on `the_repository`. So shouldn't we expose that
> instead?
> 
> Patrick

Specifically in this case, yeah, we should have started with the
libified version. This is an artifact due to the way we are figuring out
C/Rust interop as we go, and it was easier to convert it this way
without making the Rust side care about handling repository pointers.
But you're right, and I'll fix this soon for V4.

In general though, we're treating the initial version of libgit-rs as a
proof-of-concept that we can call from JJ into Git without blowing
things up. We might not always have the option of exposing
fully-libified code paths, and for our $DAYJOB purposes, we may have to
deal with non-ideal interfaces for the early versions. However, we do
want to use this as a way to motivate development of better, libified
APIs when we find real-world use cases for them.

We've said before (even before we started libgit-rs) that we're not
going to be able to make guarantees about early libified APIs, because
we're learning as we go along. I don't want to use that as an excuse to
cover up bad design, but I do want to be upfront that we can't commit to
fully libifying any given code path before we expose it through the shim
library or through libgit-rs.

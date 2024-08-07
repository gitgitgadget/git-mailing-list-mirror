Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5B613B59E
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071908; cv=none; b=q+gIMSKc4/mIYXsO0xfKv6IOhXWNnFiKCxscKBQ9Xnxuo+K3t/2F2NDy09bx3x6sWJnkQ+OXTA95hNJss+bcvnrBpOHWOF7mXLRR+UlxDXv0dXI9FMIJxUiQcDlKSVNXkp0VgADcehWzm1xaA+A4y/c9QiIV2Hv+Fk/6kwrf8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071908; c=relaxed/simple;
	bh=ukzTjgkc5LpaJ8y5Jhp5dOiKwXa/gnb7fIu3Yi//zJ8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4CQaSxRn2Hk89SjpSzmIiysULtOfMQv3Y1zWNSQ10jkcy0ttLT40Pp75FDvWp0wdaZ0r5tNyYrMJ2Q+kHfbe8N13BTsgtorFv8knxKABsz6r/tChNh666VX+jLqFrYJKtVVX6mucuu6UWHQSPAD4dlfPS7mD5CPUnnh/9RWvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eV33y8RW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eV33y8RW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc587361b6so4305265ad.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723071906; x=1723676706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpMrN0YvV7dP0/D1q+widwNoxuR5GScJLORbjbR8mmI=;
        b=eV33y8RWhEkU3RHr8xjfEEMvs80/YDNAo3D7EEcF3oJEYXLRKpdm4q7b0Yy4d2ox9f
         3q35jlU7CceEFXSln6xsQ/GE66yam2iMdFpfO3O3nPPdHJZzCMuF/kYznKwdeaDosTUh
         q9w3egRcsPalRPd2Y/PFn8trok7TnuVeydxBodm/tA/Su6xZ8Fb5ipuUMeXGBxEPEEfA
         wEz4MQpfhKabZBYvaIpdHqsQhAWC5Bu+qUgkdaWjTKIL0wt8dwFpKwWhKTDjkgQ5NR30
         smvyChsZw7yPb/wwROalWX/bI2SgEKh00n3JVd/+i4uOL8J3fTMD8ERj/5sl4qQVwlHI
         1JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071906; x=1723676706;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SpMrN0YvV7dP0/D1q+widwNoxuR5GScJLORbjbR8mmI=;
        b=ncsj1SkY6T5/dgkdGvKfFsFC1vKgPJrGaVQGcCJ9wa3fL4I98iQrL7lv6OlqL78gq2
         nSfytBUTI7NRYU8mVwPiwe3n6/A/XgZzCoIJtrdSkELCIX8sdb+GQ7SC8/ReezUzVkad
         g6aPvryQz6lCkTSfoVbmAjCyMeVQLv6WyCJQpWcffEplzqfjCifWlqhEuCm4cGAL4685
         QK0lwyIrzdZsX2GgIMS4+2m0nPNFFjmwNVfca4/Q51a05TCx+U54ecBdwSAwx6930jOj
         jq8FqAyz/nPCSYSRtHHzLd9lxXiT5qm2SBp6y/BfPxCvDRtIewprtk28IbgGQatAKxkm
         +3ew==
X-Forwarded-Encrypted: i=1; AJvYcCWcsW0RHGH1kktxqvTVaPUydIcc8Zej10NGLKPvFJTlbAnmaAXyJxv954HHY64N1n7F05gKT3R+V0Uzbv6urrLv33Dx
X-Gm-Message-State: AOJu0YzRIszQKCDPd55kVf19OS73RX8UaKmEm7zRJHrGELuGnhbv2Bf5
	7w47mPRiKf7LdOJye7+ivHX+InRI21C6wVIoLNEzrK/yv91zH6cuqKw35TvU/g==
X-Google-Smtp-Source: AGHT+IFzydVv1A05T/O7IszpBDEdd/aFecOaSukRV5OV82RUpoZvLFZdRCY0WfL12UJqQiY9sI6IyA==
X-Received: by 2002:a17:902:f549:b0:1fd:8e8d:8669 with SMTP id d9443c01a7336-200952247a8mr1463445ad.2.1723071905742;
        Wed, 07 Aug 2024 16:05:05 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f29de7sm111641385ad.26.2024.08.07.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:05:05 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:05:00 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <b5epjlsptw3punygmx2abmfnrkki6n6ta4fk3yse7iodlabr63@zss4z3575r7v>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>

On 2024.08.07 21:21, brian m. carlson wrote:
> On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
> > Introduce cgit-rs, a Rust wrapper crate that allows Rust code to call
> > functions in libgit.a. This initial patch defines build rules and an
> > interface that exposes user agent string getter functions as a proof of
> > concept. A proof-of-concept library consumer is provided in
> > contrib/cgit-rs/src/main.rs. This executable can be run with `cargo run`
> > 
> > Symbols in cgit can collide with symbols from other libraries such as
> > libgit2. We avoid this by first exposing library symbols in
> > public_symbol_export.[ch]. These symbols are prepended with "libgit_" to
> > avoid collisions and set to visible using a visibility pragma. In
> > build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also contains
> > libgit.a and other dependent libraries, with -fvisibility=hidden to hide
> > all symbols within those libraries that haven't been exposed with a
> > visibility pragma.
> 
> I think this is a good idea.  It's optional and it allows us to add
> functionality as we go along.  Platforms that don't have Rust can just
> omit building it.
> 
> > +[dependencies]
> > +libc = "0.2.155"
> 
> I don't love that we're using libc here.  It would be better to use
> rustix because that provides safe APIs that are compatible with POSIX,
> but I think for now we need this because rustix doesn't offer memory
> management like free(3).  I'd really prefer that we didn't have to do
> memory management in Rust, but maybe that can come in with a future
> series.

Yeah, needing to free() is the only thing we striclty need from libc
right now. Please correct me if I'm wrong, but IIUC then any memory that
is allocated on the C side and then passed to Rust needs one of:
1) freed by libc::free() on the Rust side,
2) passed back to the C side to be freed there, or
3) leaked

Am I correct in assuming that your opinion is that writing additional
*_free() functions on the C side is worth it to avoid libc? If so, then
I'm fine with including that in V2.

> libc also comes with the downside that it calls the actual libc
> functions, so you have to write things like stat64 on Linux if you want
> a 64-bit stat, but that doesn't exist on some of the BSDs, so you have
> to write something else and compile it conditionally, and all of that
> makes the portability of it worse than with C.
> 
> In any event, I have the intention to send a patch to replace libc with
> rustix in the future if this series lands.

Even if we can't fully eliminate libc in V2, I'll keep this in mind and
avoid adding additional usage of libc as much as possible.


> > diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/public_symbol_export.c
> > new file mode 100644
> > index 0000000000..3d1cd6cc4f
> > --- /dev/null
> > +++ b/contrib/cgit-rs/public_symbol_export.c
> > @@ -0,0 +1,20 @@
> > +// Shim to publicly export Git symbols. These must be renamed so that the
> > +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
> > +// avoid conflicts with other libraries such as libgit2.
> > +
> > +#include "contrib/cgit-rs/public_symbol_export.h"
> > +#include "version.h"
> > +
> > +#pragma GCC visibility push(default)
> 
> I assume this also works in clang?

Yep.


> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA



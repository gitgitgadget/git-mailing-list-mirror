Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4161DE2CB
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173277; cv=none; b=oxp7BpJGa6EvbVTyPeKM6wN7dqd6JzqmwOGzymkOj5rwLZcMajPbuM8/eP3MbzGmyUuZWKFu18A4bkJhczsyou1FlIHZqRlNQsbIZA//fCeEDpMG2Yqei+Toi2hXoHMZjocahceOrScgBG6WGIKHqc5+v25rSvNwXUQhyF+rRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173277; c=relaxed/simple;
	bh=JwjGuNhWuE3QF+3zOKM21A8oQ+P+8lwrDNqt52JOdKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2BzvTrZWhukARsOyuzQGFo7tZQsfwLhGh15L9EP46K2iYxBnOEYasNyMsl2LKfIvRR/z2zQ1+fcfil5sZlqiP4a+0N3In+q+4nWXSH0xh1FHUtoy7zOmmQEyxD0JSGvY7ZPlyAwWvg+ODxSqySFaJyOvlJBqgDcGXv7rcnWdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cTCN11hk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjGNfaWh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cTCN11hk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjGNfaWh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C153D254007E;
	Thu, 17 Oct 2024 09:54:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 09:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729173274; x=1729259674; bh=TVTyurqF+C
	4+0cHY4k/OtrAKdsW3Rv4h6yB7jcJP8y4=; b=cTCN11hkYuwK7HnNKeZnCpWqz3
	W/cRhh57CEjya+FqGH8wDN6e66eTY7WS/FGCR4+BUq6/Gi0xaPmjPK2j0K4jeRxs
	smArl+lvcu8Tb3gh773TNZ/t+kCrHmydcLFlzcGs2824GpqGtet2EFJSRxs8qulB
	M0t3chTrm3B7bit8pqW+Y6h5aTZ0PgVK/5nvN0N/7erhrjCuX4JHtKi3Yq/ACpJP
	FZc+KXiQUg/Nx7lS4Zp2/hrdoqRpoORDsnijXewYfUENbKYJ2PiBIPmdbAeBjkAq
	rb26bkuEcUpvh7ceC6BF6ZT6QpWTdpPf9pQqpglcGv6d/XSyep4Qr55fEiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729173274; x=1729259674; bh=TVTyurqF+C4+0cHY4k/OtrAKdsW3
	Rv4h6yB7jcJP8y4=; b=YjGNfaWh+ogiEj2AI7/QFUdLlzG1LmW3cozDr0H4ILJK
	pFvhsPSg4zo0MZwpo4aaseQUB/Te+GtW4RELc/kbiUkI71WjA1T2NgBYR7FpK5qh
	2cHKjMmcE2Yl8ztVwUiiraZVawtFd1JObSUTysrk/z5rsKNoyYholfi5354qMpk6
	0Ifn50JPeUEQ4U0c3ArlqLEkZwsx0bLsqkOxPeqxlVCp6mlkhBQ30bm+C0yAfCWT
	0mHxMmdhIYi3NRWvjQ5Un83Tucxje8QOmJfUTLBRZIyq77x47UiXkokxz0ngpeCD
	JDD7Sur8KxkkH98/eoh8uQtXC8vSqNn97PJZ4x6YfA==
X-ME-Sender: <xms:GhcRZzjn7xwDkoJPor9JpnlYWGNK07H79Sx6ZG97r9sKBbk8Lzlcsw>
    <xme:GhcRZwDfd9trNNG9Aszdi2FWHfEA3EipyDvMu7895jbbGtvBDzuSheR-FGaSpNuBc
    qx2JYg1X3MZRz0TDA>
X-ME-Received: <xmr:GhcRZzFLxK_8UblsyDYVfPf4_ML492rYKjtB9YxL8_W6Tb6M__3dP4TsurCFZVug8dezsaLQ2F6s8YP0WXJlmnwuqj2WeYWRSwvAQEzoQ6PaEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GhcRZwR2MUaJ0arlznpcuncGwwacqDeo3kc7Z6_rXYyzYnoB4eRcrA>
    <xmx:GhcRZwycCtMy6b7_UBnwOG-DV3XDUgoxLfNigSSLu_P1yqBoGhK-mQ>
    <xmx:GhcRZ27VrSdxjUIpG8GZ6e_mr5Et7umLvu5U6N0caz6xheeM7mZtjA>
    <xmx:GhcRZ1xFyqpPa93KCKSuuEbKUve2rRWkzifvXZ2AyNld9QhM54Ah9w>
    <xmx:GhcRZ886hiU5fEP5jpemW_hR6SpWRFjpqxHhcC0glqs3d-lN0-HTIXkF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 09:54:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50285ebd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 13:53:11 +0000 (UTC)
Date: Thu, 17 Oct 2024 15:54:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxEXFI80i4Q_4NJT@pks.im>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxESP0xHV4cK64i0@pks.im>

On Thu, Oct 17, 2024 at 03:33:51PM +0200, Patrick Steinhardt wrote:
> On Thu, Oct 17, 2024 at 10:51:05AM +0700, Bagas Sanjaya wrote:
> > Hi,
> > 
> > Since clar unit testing framework was imported by commit 9b7caa2809cb (t:
> > import the clar unit testing framework, 2024-09-04), Git FTBFS on uclibc
> > systems built by Buildroot:
> 
> Wait a second, that doesn't sound right to me. `wchar_t` is part of ISO
> C90, so any system not supporting it would basically be unsupported by
> us from my point of view. And indeed, uclibc _does_ support that type
> alright. I guess the issue is rather that we're relying on some kind of
> platform-specific behaviour and thus don't include the correct header.
> 
> I'll have a look, thanks for the report!

Okay, uclibc indeed has _optional_ support for `wchar_t`. But what
really throws me off: "include/wchar.h" from uclibc has the following
snippet right at the top:

    #ifndef __UCLIBC_HAS_WCHAR__
    #error Attempted to include wchar.h when uClibc built without wide char support.
    #endif

We unconditionally include <wchar.h>, and your system does not seem to
have support for it built in. So why doesn't the `#error` trigger? It's
also not like this is a recent error, it has been added with 581deed72
(The obligatory forgotten files..., 2002-05-06).

We can do something like the below patch in clar, but I'd first like to
understand why your platform seems to be broken in such a way.

Patrick

diff --git a/clar.c b/clar.c
index 64879cf..06fe3d1 100644
--- a/clar.c
+++ b/clar.c
@@ -9,6 +9,11 @@
 #define _DARWIN_C_SOURCE
 #define _DEFAULT_SOURCE
 
+#if defined(__UCLIBC__) && ! defined(__UCLIBC_HAS_WCHAR__)
+#else
+#	define HAVE_WCHAR
+#endif
+
 #include <errno.h>
 #include <setjmp.h>
 #include <stdlib.h>
@@ -16,7 +21,9 @@
 #include <string.h>
 #include <math.h>
 #include <stdarg.h>
+#ifdef HAVE_WCHAR
 #include <wchar.h>
+#endif
 #include <time.h>
 #include <inttypes.h>
 
@@ -766,6 +773,7 @@ void clar__assert_equal(
 			}
 		}
 	}
+#ifdef HAVE_WCHAR
 	else if (!strcmp("%ls", fmt)) {
 		const wchar_t *wcs1 = va_arg(args, const wchar_t *);
 		const wchar_t *wcs2 = va_arg(args, const wchar_t *);
@@ -801,6 +809,7 @@ void clar__assert_equal(
 			}
 		}
 	}
+#endif // HAVE_WCHAR
 	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
 		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
 		is_equal = (sz1 == sz2);


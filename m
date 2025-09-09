Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86B239E8B
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403916; cv=none; b=rhpR6ZcSYXn6/M2oPOwD+hTXgyZu5hY3HmQ+hfljGrFRtN6tfbAABOjl50el5s/9lw0i1MTcw8TXqwEpYl8xl5cUBJCMofeRkLPvQz0NLTmB4c9Xr46TFo027aswvNzsiU/PTpkIjbGzl5HIPvAK5qLpo5mm67p+B2c9C5ZaQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403916; c=relaxed/simple;
	bh=yekIShyQrhfLlkyZ8vibY2hgb2P/jz4JfWlxqjr5A0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJyresYC62tGjSxjMSvmVRnTY5OZRRYclc3DwX1FOoe/SqbvhgsmipyR14aDJRuR4HpIN7+Sp21RZdmfmokTdaL3rY44VhNyZU3Sx+1KiBdzo/QfsCJXhXTf74zWdG4w3xCGyTdlVRdB8zbaebQP84YUYGG0k4bOyQsxJk4j0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QrGPUHfL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mAhuI8UN; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QrGPUHfL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mAhuI8UN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 40286EC0188;
	Tue,  9 Sep 2025 03:45:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 09 Sep 2025 03:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757403913; x=1757490313; bh=UvRDgTtKyS
	RHSZiN7miChJqgnrro4JSfxNOdQyuBBao=; b=QrGPUHfLSUv3Ss1V5rzmeRPTnT
	9FUJcU2/fqCkbJ54yNGVJ2SFc9Qdrnw7lQlNVUuinv/STxdErfX6KwYmKR8Cl1TI
	vRNeGS+qW7AJDb0a/rAAjkFRRTWNDefNuCV677INGUO/yLtx2Lf7VQegtuxVCc+4
	wcGsh3YtHlIZ+h7y47exuGo2emExx7GZ7THi0344CxHOZDjlL9oAyOHKVrG64g8c
	j1gO0JNZWuF+3heXmXZ57tCqTso6B+3pupYYBl35ULVoQ8MLa6cEwoZCnS0sc5sa
	TYGYrwzOn0FDh8hclXA8IoPYNW6UAZW/qKE/xltPLW9nAqe+C1nut6oGFXbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757403913; x=1757490313; bh=UvRDgTtKySRHSZiN7miChJqgnrro4JSfxNO
	dQyuBBao=; b=mAhuI8UNzn6Qiz+KYuRfCZTVtAY+1uxE3YW0i60O+H7bWFzKZBl
	XkxJ1qnydixw1rYN+mVEtt0lAboQnqZ89om/dv2Zojs7E8cbQM3TpcSIl7qXCSOy
	552ysC84PYuHl4n13o//pOOcMx+CmPTPVjhb0dSWzrmMOUJ9aDV5mIXJgJSMFiWF
	OMY7GfbtcZDAXwhZKpl+8haOy1sjraSRp3soL3ea3xlOwp3013NuMXfla6MSmzDm
	hfyugsjH3gk8vXlqbOilXnqe/pc16iXRuS6Zu90fCQR88heMAucHitVkMpYU+Yq0
	kvuoILt/1CZetgA77mE0RleLyUNkJLQMG8g==
X-ME-Sender: <xms:Cdu_aAcCWLemmMxYGjF2sG1BG4sguW4_XvLQmyo0pTwbENvIuJ97Kg>
    <xme:Cdu_aFcvPUdwAKSi2hMUSGRvhnJ_7W3rMgNv8jPargEijcXBp4oW-GIfA2dIz-Cek
    FCQ7BQXBfnhNijzZw>
X-ME-Received: <xmr:Cdu_aK_Vk0y69KVcXD07GfyH2s4VjKCDLTkMoijQLj4CdSwOeIeL0xDIylqhhNMru03BHbjM6Ns3v1qonXffEW47eBg4jUmWMJWDRJP3MB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmihgthhgrvghlrdhoshhiphhovhesihhnnhhomhhothhitghsrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvght
X-ME-Proxy: <xmx:Cdu_aBmxopZj1cJCKKgOk8pJ-YlYUZLVnY1c4xz64pwlGR0ono8F_g>
    <xmx:Cdu_aM9e_0ljShcXPIeJDdqWLB49sb8wO7U5Z0qhan9U_IIBaVm5Nw>
    <xmx:Cdu_aPlhkEeX0yqZeXOLDsSamdfKH72kxAyOtca-S7gSxdnaKnE8WQ>
    <xmx:Cdu_aJ0tOtOvucpMYM_DoNtuIEDwPW2NY18V9jWZF94x55S729Zj8A>
    <xmx:Cdu_aBQZg-XAYREgKd7XnQbhXxKxgGELnv-7HAcpH1xpjfovUbthtcOk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 03:45:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a227bcad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 07:45:10 +0000 (UTC)
Date: Tue, 9 Sep 2025 09:45:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>,
	git@vger.kernel.org
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Message-ID: <aL_bAxZubXMOGWsu@pks.im>
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
 <20250905213708.GB612697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905213708.GB612697@coredump.intra.peff.net>

On Fri, Sep 05, 2025 at 05:37:08PM -0400, Jeff King wrote:
> On Fri, Sep 05, 2025 at 03:19:50PM +0200, Osipov, Michael (IN IT IN) wrote:
> > diff -u -ur t/unit-tests/clar/clar/sandbox.h git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
> > --- t/unit-tests/clar/clar/sandbox.h	2025-08-18 02:35:38 +0200
> > +++ t/unit-tests/clar/clar/sandbox.h	2025-09-05 14:10:52 +0200
> > @@ -2,6 +2,8 @@
> >  #include <sys/syslimits.h>
> >  #endif
> >  
> > +#include "../../../../compat/posix.h"
> > +
> >  static char _clar_path[4096 + 1];
> >  
> >  static int
> 
> ...seems like an obvious improvement. If we are compiling any C code,
> we'd want our compatibility macros, etc. Although it does get a little
> funny, as the contents of clar/ are imported from elsewhere, and now
> we're modifying that.
> 
> It looks like clar tries to handle portability on its own, so I guess
> another route is for it to add its own mkdtemp wrapper, and we'd import
> that fixed version. But it really feels like we're duplicating effort.

We're duplicating effort indeed, but that effort benefits other
projects that use clar.

In any case, we already have logic to detect whether or not the platform
should have `mkdtemp()`:

    #if defined(__MINGW32__)
        if (_mktemp(_clar_tempdir) == NULL)
            return -1;

        if (mkdir(_clar_tempdir, 0700) != 0)
            return -1;
    #elif defined(_WIN32)
        if (_mktemp_s(_clar_tempdir, sizeof(_clar_tempdir)) != 0)
            return -1;

        if (mkdir(_clar_tempdir, 0700) != 0)
            return -1;
    #elif defined(__sun) || defined(__TANDEM)
        if (mktemp(_clar_tempdir) == NULL)
            return -1;

        if (mkdir(_clar_tempdir, 0700) != 0)
            return -1;
    #else
        if (mkdtemp(_clar_tempdir) == NULL)
            return -1;
    #endif

So that raises the question whether HP-UX has mktemp(3p) -- if so, we
can probably fix the issue like this:

diff --git a/clar/sandbox.h b/clar/sandbox.h
index ff43159..5af36f3 100644
--- a/clar/sandbox.h
+++ b/clar/sandbox.h
@@ -164,7 +164,7 @@ static int build_tempdir_path(void)
 
 	if (mkdir(_clar_tempdir, 0700) != 0)
 		return -1;
-#elif defined(__sun) || defined(__TANDEM)
+#elif defined(__sun) || defined(__TANDEM) || defined(__HPUX)
 	if (mktemp(_clar_tempdir) == NULL)
 		return -1;
 
The `__HPUX` define is pulled out of thin air, I have no idea what
preprocessor macro that system sets. But something in that spirit may
fix that issue. If so, I'm happy to fix this upstream and then pull
the latest version into Git.

Patrick

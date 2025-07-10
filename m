Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B14293C57
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139579; cv=none; b=DGA7cpMjqcAWBDbgeJQGFWTnOD9CvfgDPrhqEzm55a8567RN4F1E8S3q6V/2wlj00ffxpSNi7QBbkg+d3+gnACHM0Cn6LKQatsvvlRy01A4dWWu2RlCias920ytCd+3ajy5Xrgt0LeNlqJuyFrwxt2nu+NyX4Jf3x4Ac3eN6EJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139579; c=relaxed/simple;
	bh=atniUJbHqd7SdwjY+URy4TFYACtIAzhVL2Xa2Gkadyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItNH1Ypyrt0xUGr2nQm3G7mN2cwm4qSUK40zjjglKLtaJ3QQPK1/+mjsAU3AS6xmbsvkfP5u/NVAKgUa9spMx23Fl4eta9s/8c1CtzFrBfA+8HrvfxLIzdtl8M3yX1XX1IstwGSOhALWTIjTQYD3cAB1GdMXD6DR1J8TCEBY3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EqBLDVqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0luQb9w; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EqBLDVqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0luQb9w"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CA83FEC00F3;
	Thu, 10 Jul 2025 05:26:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 10 Jul 2025 05:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752139575; x=1752225975; bh=EePVjPpmep
	PmjD+DtoH58l68fpinfB+6byhpYdDu4BU=; b=EqBLDVqkj7ictbCHvZoJh6dXIf
	zid69ug1qKTApMa3RzXoocvrqwk3aanwErhT+0Ga7cgaptvC4vAXoKqAERYZtf2g
	Ozx1u0xH29q4LxnkdB/en4MWDHm06kLEybUcEROCHULyzQaX4wdnqul4u6QXUDt2
	ROJ1XXSB3voNZkiPHvEcXDydREnH63qbZpn4JCLOlV8A0PvcybQp7H0bQCpPNlYx
	X6fdIM/EeWE7WGMtUHLR97r3v64YjkWU4bXEwahA7t08dr6lvXhA5sQch/ng9D+T
	5ccsBoYw5vxB8JRJzTzEvDrHVs4HWeXQKHzEhpD2JYEZ0eMgxe+OqGDirFHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752139575; x=1752225975; bh=EePVjPpmepPmjD+DtoH58l68fpinfB+6byh
	pYdDu4BU=; b=f0luQb9w6bWV3gCSOXsVK17SJT9wP/E5CS0Q8xI+2Emt/N1c0oL
	1Htxry9Ekg5FNIuA7lzlKQGAOTLvVJx4a2bR9CAhbOeL00O5Bx7x2vlR2a8fJYds
	8qnD1dxNFvjk6z5wqnOCr/K+myYBVGCVuXzq2Qx/EkJHvyh9J4bPMnLD9swUVyuj
	VvQ0KQ/AAqCLDBpaJLI3ZsNAvDl4qsmyCgvBOCrQet01RARxuifBsIgApzYdW+Iq
	3T6EgAP/Bz/3CIheSZqB4t2ghx6quaxyGaR5Rxjw+3KlwCiZTmAcEP1/KPTVhihH
	9Z9OnQdVk/wk14zew/mqt8BF5/A2Szy3+Dw==
X-ME-Sender: <xms:N4dvaAzowAOrIsl2wjEjtbapFBxlye3HdiPF-myJl4403VQsvyzq2g>
    <xme:N4dvaHidK3FWBW49SpzyP22SH0S3bpX6fsIJ8AA5l7qFr6sNjEOaLf6EDyJoDxKIm
    nXQVu-3nxRjyYP6CQ>
X-ME-Received: <xmr:N4dvaLxfdoLc3pAQQDFkuBye-d5ZQ8o9LBJuRxQ3UIi9yKglFEUvdzO5w2mkLfRmQceAGdHWXu6-qeMUknExEB5r-VKx6csyMT0sF8ATiOVRVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehmtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvtdehjeegtdevtedthfefvedtudevhffhkeekhfetlefhuefhleejgfejhfdvjeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthgrnhhhuhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhho
    uhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:N4dvaKImG5o4i_6thS8vB1EEqsfeVnY0ka5VgqYN2HR7CWsxlUQAKA>
    <xmx:N4dvaCSALiazXexXfv5AUNLgUY5-IOgda-Zdjzqu67uDA9mSqH4PuQ>
    <xmx:N4dvaCrx788nsT6YNR_lYMuUUlVT5LDSo89xp7aK9x_z5I82_4y-iA>
    <xmx:N4dvaHorvD3-btyPkGqID_7PoqOr_dqy2JfF3UqlIK728eh18FQ-_A>
    <xmx:N4dvaEU3o36nE1FfJYVpZRPQSwn-863c-IMj7npYemMNsMsxX-HTvMEV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 05:26:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d32239e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 09:26:13 +0000 (UTC)
Date: Thu, 10 Jul 2025 11:26:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
Message-ID: <aG-HMnO11lCYgPiY@pks.im>
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
 <aG-EfIfyXxmS_x22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="whvXeoV8WsznjDoH"
Content-Disposition: inline
In-Reply-To: <aG-EfIfyXxmS_x22@pks.im>


--whvXeoV8WsznjDoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2025 at 11:14:36AM +0200, Patrick Steinhardt wrote:
> On Thu, Jul 10, 2025 at 11:12:40AM +0200, Patrick Steinhardt wrote:
> > Compiling Git fails on Amazon Linux 2 when using GCC 7.3.1 with the
> > following compiler error:
> > 
> >     In file included from compat/posix.h:449:0,
> >                      from git-compat-util.h:26,
> >                      from daemon.c:3:
> >     compat/../sane-ctype.h:29:60: error: expected expression before ']' token
> >      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
> >                                                                 ^
> >     compat/../sane-ctype.h:29:72: error: expected ')' before '!=' token
> >      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
> >                                                                             ^
> >     compat/../sane-ctype.h:29:60: error: expected expression before ']' token
> >      #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
> >                                                                 ^
> >     ... lots of similar lines ...
> > 
> >     compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
> >      #define toupper(x) sane_case((unsigned char)(x), 0)
> >                                                       ^
> >     /usr/include/ctype.h:142:12: error: expected identifier or '(' before 'int'
> >      extern int isascii (int __c) __THROW;
> >                 ^
> >     compat/../sane-ctype.h:30:26: error: expected ')' before '&' token
> >      #define isascii(x) (((x) & ~0x7f) == 0)
> >                               ^
> >     compat/../sane-ctype.h:30:35: error: expected ')' before '==' token
> >      #define isascii(x) (((x) & ~0x7f) == 0)
> >                                        ^
> >     In file included from /usr/include/features.h:423:0,
> >                      from /usr/include/unistd.h:25,
> >                      from compat/posix.h:90,
> >                      from git-compat-util.h:26,
> >                      from daemon.c:3:
> >     compat/../sane-ctype.h:44:30: error: expected declaration specifiers or '...' before '(' token
> >      #define tolower(x) sane_case((unsigned char)(x), 0x20)
> >                                   ^
> >     compat/../sane-ctype.h:44:50: error: expected declaration specifiers or '...' before numeric constant
> >      #define tolower(x) sane_case((unsigned char)(x), 0x20)
> >                                                       ^
> >     compat/../sane-ctype.h:45:30: error: expected declaration specifiers or '...' before '(' token
> >      #define toupper(x) sane_case((unsigned char)(x), 0)
> >                                   ^
> >     compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
> >      #define toupper(x) sane_case((unsigned char)(x), 0)
> >                                                       ^
> > 
> > This error bisect back to 75a044f748 (git-compat-util.h: split out
> > POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
> > "git-compat-util.h" into a new "compat/posix.h" header.
> > 
> > The compiler error isn't immediately obvious, doubly so because the
> > actual errors are ~3x as long as the above snippet. But what happens
> > here is that we transitively include <ctype.h> after we have included
> > our own "sane-ctype.h" header. Consequently, the function declarations
> > that exist in <ctype.h> for isascii(3p) et al will be mangled by our
> > macros of the same type. The result is of course completely broken.
> > 
> > It's unclear why this issue only happens on Amazon Linux 2. My guess is
> > that it's either specific to the compiler version or specific to the
> > glibc version. We don't explicitly include <ctypes.h> anywhere, but it's
> > being transitively included. So chances are that later versions of the
> > toolchain reorganized their headers so
> 
> Hrmpf, what's going on here? Both this email and the first one at [1]
> are getting truncated... I'll debug.

I've tested with multiple other recipients, works alright there. No
truncation, the mail comes through as expected. I'm a bit clueless right
now. Konstantin, do you have any idea why this might have happened?

Meanwhile, I'll include the patch as an attachment.

Patrick

--whvXeoV8WsznjDoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-sane-ctype-fix-compiler-error-on-Amazon-Linux-2.patch

From fabacc9bc7ef7d462d1c7198d5edc18c76b82270 Mon Sep 17 00:00:00 2001
Message-ID: <fabacc9bc7ef7d462d1c7198d5edc18c76b82270.1752139420.git.ps@pks.im>
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Jul 2025 08:46:27 +0200
Subject: [PATCH] sane-ctype: fix compiler error on Amazon Linux 2

Compiling Git fails on Amazon Linux 2 when using GCC 7.3.1 with the
following compiler error:

    In file included from compat/posix.h:449:0,
                     from git-compat-util.h:26,
                     from daemon.c:3:
    compat/../sane-ctype.h:29:60: error: expected expression before ']' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                ^
    compat/../sane-ctype.h:29:72: error: expected ')' before '!=' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                            ^
    compat/../sane-ctype.h:29:60: error: expected expression before ']' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                ^
    ... lots of similar lines ...

    compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                                      ^
    /usr/include/ctype.h:142:12: error: expected identifier or '(' before 'int'
     extern int isascii (int __c) __THROW;
                ^
    compat/../sane-ctype.h:30:26: error: expected ')' before '&' token
     #define isascii(x) (((x) & ~0x7f) == 0)
                              ^
    compat/../sane-ctype.h:30:35: error: expected ')' before '==' token
     #define isascii(x) (((x) & ~0x7f) == 0)
                                       ^
    In file included from /usr/include/features.h:423:0,
                     from /usr/include/unistd.h:25,
                     from compat/posix.h:90,
                     from git-compat-util.h:26,
                     from daemon.c:3:
    compat/../sane-ctype.h:44:30: error: expected declaration specifiers or '...' before '(' token
     #define tolower(x) sane_case((unsigned char)(x), 0x20)
                                  ^
    compat/../sane-ctype.h:44:50: error: expected declaration specifiers or '...' before numeric constant
     #define tolower(x) sane_case((unsigned char)(x), 0x20)
                                                      ^
    compat/../sane-ctype.h:45:30: error: expected declaration specifiers or '...' before '(' token
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                  ^
    compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                                      ^

This error bisect back to 75a044f748 (git-compat-util.h: split out
POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
"git-compat-util.h" into a new "compat/posix.h" header.

The compiler error isn't immediately obvious, doubly so because the
actual errors are ~3x as long as the above snippet. But what happens
here is that we transitively include <ctype.h> after we have included
our own "sane-ctype.h" header. Consequently, the function declarations
that exist in <ctype.h> for isascii(3p) et al will be mangled by our
macros of the same type. The result is of course completely broken.

It's unclear why this issue only happens on Amazon Linux 2. My guess is
that it's either specific to the compiler version or specific to the
glibc version. We don't explicitly include <ctypes.h> anywhere, but it's
being transitively included. So chances are that later versions of the
toolchain reorganized their headers so that <ctypes.h> is not included
transitively anymore.

Fix the issue by explicitly including <ctype.h> in "sane-ctype.h". This
ensures that the header guards will be activated and that any subsequent
include of the same header will become a no-op. With this we can then
safely override the function declarations with our own macros.

Reported-by: Stan Hu <stanhu@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sane-ctype.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sane-ctype.h b/sane-ctype.h
index cbea1b299b7..4f476c43816 100644
--- a/sane-ctype.h
+++ b/sane-ctype.h
@@ -1,6 +1,15 @@
 #ifndef SANE_CTYPE_H
 #define SANE_CTYPE_H
 
+/*
+ * Explicitly include <ctype.h> so that its header guards kick in from here on.
+ * This ensures that the file won't get included after "sane-ctype.h", as that
+ * would otherwise lead to a compiler error because the function declarations
+ * for `int isascii(int c)` et al would be mangled by our macros with the same
+ * name.
+ */
+#include <ctype.h>
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
-- 
2.50.1.337.g200b4b24a8.dirty


--whvXeoV8WsznjDoH--

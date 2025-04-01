Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69549C13B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743477034; cv=none; b=fWDVdjHZ1r6jV+vt1svu/qOG6AHgjC9IMdH5v108tCaFKhrYURHkN3Q3pgwdiiW/ZF8WF2uPcOZycHUfaV8n3tSvU9c1ORUdO2241gxh9go1T6Tr4/bjcjFaxtLim7QK1wWB1aWJ4AjKHCBlnhATGlmWVxW7WCWMeuTCwbHiIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743477034; c=relaxed/simple;
	bh=E9rAt67lnbTQ5sFUlHBzEEprw21bDtOJ5ERXaRTbrv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoLGWHggX4xAXKklzJbZbDDhyXX7z6HU+AqIwpYtjpFq0SiGAsM5WNxRZrThrmccf70+ilSkydqcLcoRaLSmFtntMFTI+2HhvSJObKScsjv3Ed8lDPaU8WU6AxAmZHe5qbKBNFcmfK1Jw6AXBsEmvbYhmW6Quo5G1Xh0PtvBLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=euwpbU42; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="euwpbU42"
Received: (qmail 18002 invoked by uid 109); 1 Apr 2025 03:10:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=E9rAt67lnbTQ5sFUlHBzEEprw21bDtOJ5ERXaRTbrv0=; b=euwpbU429VOHMBfhNEMf79z4E0FcAGMOVdeRyFUab/CM9AQQmAQ7raDWkkGCKCMQ/tryCKTTehFrkL78btDiIpfQXtRNVvzbOuufiYKqiwCwyNIRj+BOwa6Ulm2ejXUjePKUDanRebWUIjsflGn31UemEZKY2OCJKzaZZOsAPJ48+xniLw33DE+jxDxg8TCfmQup0lJivJRZUIZttjiUwXKq5A3YFVe268CUg9j4hAqKCXP/fYRtRL9qyODshOs6GPL+oBtoCODaDxrUVvNkInNWTPllGagUoI2mcvNo2Mx4xx3BY5aWOsHS+MHfo1k64FEK1bcen/yadCnPufigJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 03:10:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11383 invoked by uid 111); 1 Apr 2025 03:10:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Mar 2025 23:10:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 31 Mar 2025 23:10:30 -0400
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <20250401031030.GB1087913@coredump.intra.peff.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
 <Z+rcVY7KqEuF1wFw@szeder.dev>
 <20250401023358.GA1087913@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401023358.GA1087913@coredump.intra.peff.net>

On Mon, Mar 31, 2025 at 10:33:58PM -0400, Jeff King wrote:

> That would be nice. I think we've discussed type safety for
> parse-options before, but IIRC none of the solutions were very
> satisfying. But this sounds like a relatively low-effort approach that
> buys us something, at least. I wonder if it could even be extended to
> use __builtin_types_compatible() on platforms that support it.

So here's a slightly fancier version that uses the gcc builtin when it's
available:

diff --git a/git-compat-util.h b/git-compat-util.h
index 8560c89374..7bcbe0b4ac 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -110,11 +110,17 @@ DISABLE_WARNING(-Wsign-compare)
 # define BARF_UNLESS_COPYABLE(dst, src) \
 	BUILD_ASSERT_OR_ZERO(__builtin_types_compatible_p(__typeof__(*(dst)), \
 							  __typeof__(*(src))))
+
+# define BARF_UNLESS_TYPE_MATCH(var, type) \
+	BUILD_ASSERT_OR_ZERO(__builtin_types_compatible_p(__typeof__(*(var)), type))
+
 #else
 # define BARF_UNLESS_AN_ARRAY(arr) 0
 # define BARF_UNLESS_COPYABLE(dst, src) \
 	BUILD_ASSERT_OR_ZERO(0 ? ((*(dst) = *(src)), 0) : \
 				 sizeof(*(dst)) == sizeof(*(src)))
+# define BARF_UNLESS_TYPE_MATCH(var, type) \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(var)) == sizeof(type))
 #endif
 /*
  * ARRAY_SIZE - get the number of elements in a visible array
diff --git a/parse-options.h b/parse-options.h
index 997ffbee80..b38a852a8b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -213,7 +213,7 @@ struct option {
 	.type = OPTION_INTEGER, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BARF_UNLESS_TYPE_MATCH((v), int), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = (f), \

That turns up several more hits, which all seem to be related to
signed-ness (mostly passing a pointer to unsigned). E.g.:

  git grep --after-context=-1 foo -- builtin/checkout.c

ends up assigning "-1" to an "unsigned" via pointer casting. I think
that's probably technically undefined behavior, but works OK in practice
to give you UINT_MAX.  I'd have thought that would give you infinite
context, so it might even be doing something useful (or at least
something that users might rely upon), but strangely it doesn't seem to
(I'd guess very large context values aren't handled in the grep code
somehow).

So it might be possible to clean these up without hurting anything else.

-Peff

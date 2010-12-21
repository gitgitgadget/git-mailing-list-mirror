From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Tue, 21 Dec 2010 09:24:18 -0800
Message-ID: <7vbp4f9gzh.fsf@alter.siamese.dyndns.org>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
 <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
 <1292846433.19322.1.camel@drew-northup.unet.maine.edu>
 <AANLkTimkxJHvTAvra+B-0bAQopd8s21ZrFCPG_ALbZZ9@mail.gmail.com>
 <1292863989.19322.27.camel@drew-northup.unet.maine.edu>
 <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>,
	Thiago Farina <tfransosi@gmail.com>,
	"Vasyl'" <vvavrychuk@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 18:25:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV5xn-0001kf-0W
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 18:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab0LURYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 12:24:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LURYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 12:24:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4E9A371B;
	Tue, 21 Dec 2010 12:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zbkhDHV/qnHc/Xt7Fm923NsClFM=; b=eEP+Xs
	sWLOfSh+DbEIqhpFCiteC9BPAOIzR07Lrr7Clhy+ipYqpFDipfyI6yotBCJYsoQx
	mqHsmBlm8erp4FHPwHm01+eVGy9Ba6ItKbb5q15G86mtnV2cMljXZ0/TdIZsPEyg
	EcCx8PP3VPlbzeYBD7hcqJ6HhtdHLDziA6iqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qFuAXI4eTx/KfSS22oq9nYYKSdwlJ9PL
	QLTsd4/bI1BRjF9oXlxezZm+drA1zc+Jn39EanI1KAgeiHxu7fIXaCmMcohSivag
	Z90xK1Y7g2tJcBSTczddrlvFAHIdTzPi+tg7eonFF1Vv+hBpiiuXcoBiMqLDk1rG
	geW6VBpT9+g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 588253714;
	Tue, 21 Dec 2010 12:24:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 461813712; Tue, 21 Dec 2010
 12:24:48 -0500 (EST)
In-Reply-To: <AANLkTinL6RytF=x7a8URoxGQoLHhx0ip7gRNMp+nRaNB@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 21 Dec 2010 21\:52\:59 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B708996-0D27-11E0-BA9A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164040>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This is pretty much a clean-up patch from my perspective. Do we really
> need two paragraph explanation for marking a function static?

I've already applied it, but I think it is much better to do this instead
(on top of Vasyl' Vavrychuk's patch).

A more interesting topic is why the try-to-free-pack-memory logic needs to
be disabled in the first place.  3a09425 (Do not call release_pack_memory
in malloc wrappers when GIT_TRACE is used, 2010-05-08) explains that it is
to avoid a race on Windows, and it looks like a workaround not a solution
("can be called without locking"---"why aren't we locking then?").

Not that it matters in the context of "trace", which is a debugging
facility, that this is a workaround.

-- >8 --
Subject: set_try_to_free_routine(NULL) means "do nothing special"

This way, the next caller that wants to disable our memory reclamation
machinery does not have to define its own do_nothing() stub.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace.c   |    8 ++------
 wrapper.c |    2 ++
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/trace.c b/trace.c
index 62586fa..0fb2a2c 100644
--- a/trace.c
+++ b/trace.c
@@ -25,10 +25,6 @@
 #include "cache.h"
 #include "quote.h"
 
-static void do_nothing(size_t unused)
-{
-}
-
 /* Get a trace file descriptor from GIT_TRACE env variable. */
 static int get_trace_fd(int *need_close)
 {
@@ -76,7 +72,7 @@ void trace_printf(const char *fmt, ...)
 	if (!fd)
 		return;
 
-	set_try_to_free_routine(do_nothing);	/* is never reset */
+	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
@@ -108,7 +104,7 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 	if (!fd)
 		return;
 
-	set_try_to_free_routine(do_nothing);	/* is never reset */
+	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
 	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
diff --git a/wrapper.c b/wrapper.c
index 4c1639f..8d7dd31 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -12,6 +12,8 @@ static void (*try_to_free_routine)(size_t size) = do_nothing;
 try_to_free_t set_try_to_free_routine(try_to_free_t routine)
 {
 	try_to_free_t old = try_to_free_routine;
+	if (!routine)
+		routine = do_nothing;
 	try_to_free_routine = routine;
 	return old;
 }

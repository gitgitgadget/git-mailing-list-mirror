Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12D18FDAF
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181280; cv=none; b=upop0pmD5dw4NnEln9sETsk3YKTKQvFfvUVtgejOtdP/MFS2MZJFErf4iZKFbLtblrL1XYBSdsFE16ameoyn0ygW6vpMuPNxClm39JyByV43s55Ly7MakKaQL6/PQihtfoNB/7G6bw+vkAdBtq2I70JZeN0E8O9NwMt7qCpM4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181280; c=relaxed/simple;
	bh=JtYwS8YxI0ZyXMYJbT/k+LeAQ9aD732vDwAXZRunjsQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSoINr43QLxQiViZoA3Z5euWsYeYWnlu4vD8kTYWDlSpx9+CHd793ldZSDaaAJAk6BLfUaWXzNHlZ257syGBDCE/zFR33FGTAWqBZ0iKVliHoG0ADIA2Ce6JFyjSHT6zY/jdEY+K02geAFClWmEkI36wt15cWuQguZI65WHTDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OPtsFyHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpHcGNhq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OPtsFyHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpHcGNhq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7ADD77A01DB;
	Thu, 10 Jul 2025 17:01:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 10 Jul 2025 17:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752181277; x=1752267677; bh=dutJDPpnms
	ZUIw9/INnqryvxitiHTCNaPXmTcRzN50E=; b=OPtsFyHccSKdFmoRoXqexV9UBx
	VoFyF4WyrRxEnGMJifV/WnX1yriczNEBA7XWhKz8gmaPjrrisTudUGouL4GeChEz
	f+dCntKxUYPop0eadnvOg1Z9bk4W2ijI4N8Af8auk2xWlPJLZBQxNJfr75pune4W
	/zB3yixQi5uq9CaPJi5L6ZcznI9F6u7KtGlqknASUZSNTb5RBbgJZ9syVrfCJt6e
	U1S5t3BHCjNbX6cVgN2m3rFcMaSmM366G3L5/wOANQJall4LVu+tjdhm4C6l7oLe
	mnRBFZY9oex3XwVht8QOAl8jjtWdLU8D3d/k2dgiPSkQjJoEWAf0BCKJy6kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752181277; x=1752267677; bh=dutJDPpnmsZUIw9/INnqryvxitiHTCNaPXm
	TcRzN50E=; b=TpHcGNhqs8ug7mSg2ooc4AoV+IQoGREN6xfDTzg0eGcUvMjxRK/
	jYSM6yMbCo96VuHEY1DV/Q33qYc2slIFfhUhxaJ2AuT8/ZJwDMsYVdLggKt/t5Y5
	DppTm3EyCv/Kphv7xUcv/SN0J/qVE9PEvk12wAA1BkDm6gG508JtdIF+ceA1YapN
	b35a75WOqSVhguG554diuWOmbyfFlplJl3VRr0uWlqDT7Q8LwXjf176I8jPGgh+0
	4lSQvHXypYtORbCUZaUxCTk1y8mlSf8j2DPSY4tS/mPn0ZUWgGd0KStv6lv3Cl/M
	updfRbTB5CxQFLfO0TacBv1o/tMAJxlaa4g==
X-ME-Sender: <xms:HCpwaByb5nfnzB6jCG1CbRpjCJJYOVcqxGVgAtpEHLScGGTBBtfe6A>
    <xme:HCpwaMzFbSWWFlFEe0t-Xnky6h5Wqsxll6q6sjuuinJL05rcD2CDuBscGEc2WYY64
    6eJn8WBrYwNVhQ0cg>
X-ME-Received: <xmr:HCpwaByqI1U7dW3mZuVCRgg2toSnrxnaqGvlHuEFs_hWBqMuRC4ah9KWzepYwhZo_zWVWgX2MzJ-NmObcjjRKYQ5-yimA0f-pcRjfiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrnhhhuhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkohhnshhtrghnthhinheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HCpwaOZS6pl0QufYGyXGSb8MoemNB34DjHIqRZXLw49pHl2FzFUfbQ>
    <xmx:HCpwaKVJRPOxy_-kWG6xlB-b956-Vp_k9_TQAx7UwcFzwfIWfYgIZw>
    <xmx:HCpwaEjhkj5cj5houOgmTuv9QWyXE_ws2f4IiQq7JHNarsHerlyDtw>
    <xmx:HCpwaAvdwbACa2pP7XYO40ii725ddGxSVyWNVNuL62Y9suyyxz94nw>
    <xmx:HSpwaBnBBrMAqYeounVkR4LAV2lT4iCsrVCpaDLj1CRSoR_jVe5PG49g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 17:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Stan Hu <stanhu@gmail.com>,  Konstantin Ryabitsev
 <konstantin@linuxfoundation.org>
Subject: Re: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
In-Reply-To: <aG-HMnO11lCYgPiY@pks.im> (Patrick Steinhardt's message of "Thu,
	10 Jul 2025 11:26:10 +0200")
References: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
	<aG-EfIfyXxmS_x22@pks.im> <aG-HMnO11lCYgPiY@pks.im>
Date: Thu, 10 Jul 2025 14:01:15 -0700
Message-ID: <xmqqtt3j69r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> > This error bisect back to 75a044f748 (git-compat-util.h: split out
>> > POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
>> > "git-compat-util.h" into a new "compat/posix.h" header.

So there was a subtle change in the inclusion order or something,
i.e. we used to include <sane-ctype.h> a lot earlier as part of the
<git-compat-util.h> that tightly controls inclusion order exactly to
avoid this kind of problems, but that has eroded recently?

In any case, it means that our definitions in <sane-ctype.h> will be
overwritten if we allow system-supplied <ctype.h> included, and this
is an obvious workaround, likely to remain correct as long as their
<ctype.h> is not so broken to allow multiple inclusion.

For those who are reading from the sidelines, here is the patch in
inline form.

--- >8 ---
Subject: [PATCH] sane-ctype: fix compiler error on Amazon Linux 2
From: Patrick Steinhardt <ps@pks.im>

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

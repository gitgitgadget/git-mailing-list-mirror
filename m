Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8AF4411
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 01:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923972; cv=none; b=X7K7AYDIOu0nQqDPuroOBhawSDuUD/BShARqpyqpMCWGllq8naszYukIXAxzBkCuQwIxiH4D8mv4YaJxe07KfDjcvRknENdQ/jqrUHHnm4TUY5GXmzAsLDDB2QzIZSzTgvjeA3b68rlf2MJ8+fLDG9C1cSs/pk+QZeEqcopgZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923972; c=relaxed/simple;
	bh=yiBV00rb4qbTjymicophakR/BbQmGP7X347RU0hgh2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ER+OaXoguQx6sVeGIXeJRF8tsYhEbPDDRQRVlMVlVQ3URE+I9QHC9uWzy/bKttzkro4mGru64HdMaNz4EqAiXn8oLlAIacqkt+NpQpw/WJ6qaarY0hbLZJUROoXIcEhdlgZ88KHMrC1bMJtfC+SpbKMdnaQZZRxw3+nFBqLcZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AovmA/fA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AovmA/fA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F07471FB00;
	Fri,  2 Feb 2024 20:32:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yiBV00rb4qbTjymicophakR/BbQmGP7X347RU0
	hgh2s=; b=AovmA/fAQRPS2coVkTYCwX2rXhzuOS7Y1JSqJLUuAu1dJoGwGdFYUV
	Kou04C+RGvxfIkmesHvhHdBCMM9U37FpC1cvvs8/9zXqmOlS7B08WMzOd2Pt9hFb
	9QTOYAVewVtCvc0C/Ej9rSOh+DAmt3Sd4L4okA0PN6EnnaPx/z/zA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E8C4D1FAFF;
	Fri,  2 Feb 2024 20:32:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88F6E1FAFE;
	Fri,  2 Feb 2024 20:32:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Adam
 Dinwoodie <adam@dinwoodie.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] some unit-test Makefile polishing
In-Reply-To: <b7b92f1a-9231-2f53-299e-ad58fc699284@gmx.de> (Johannes
	Schindelin's message of "Sat, 3 Feb 2024 00:52:16 +0100 (CET)")
References: <20240129031540.GA2433764@coredump.intra.peff.net>
	<20240130053714.GA165967@coredump.intra.peff.net>
	<xmqqh6irwtkd.fsf@gitster.g>
	<b7b92f1a-9231-2f53-299e-ad58fc699284@gmx.de>
Date: Fri, 02 Feb 2024 17:32:42 -0800
Message-ID: <xmqqjznmtjr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 212D463E-C234-11EE-BA67-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The line 753 of that file (as can be seen at
> https://github.com/git/git/blob/38aa6559b0c513d755d6d5ccf32414ed63754726/config.mak.uname#L753)

Ouch.  When it is laid out like this it is very obvious why this is
broken, and what its workaround should be.

Thanks.  Let's queue this on top.

------- >8 ------------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] t/Makefile: say the default target upfront

Similar to how 2731d048 (Makefile: say the default target upfront.,
2005-12-01) added the default target to the very beginning of the
main Makefile to prevent a random rule that happens to be defined
first in an included makefile fragments from becoming the default
target, protect this Makefile the same way.

This started to matter as we started to include config.mak.uname
and that included makefile fragment does more than defining Make
macros, unfortunately.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 281f4c3534..2d95046f26 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -1,3 +1,6 @@
+# The default target of this Makefile is...
+all::
+
 # Import tree-wide shared Makefile behavior and libraries
 include ../shared.mak
 
@@ -52,7 +55,7 @@ UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
 # scripts not to run the external "chainlint.pl" script themselves
 CHAINLINTSUPPRESS = GIT_TEST_EXT_CHAIN_LINT=0 && export GIT_TEST_EXT_CHAIN_LINT &&
 
-all: $(DEFAULT_TEST_TARGET)
+all:: $(DEFAULT_TEST_TARGET)
 
 test: pre-clean check-chainlint $(TEST_LINT)
 	$(CHAINLINTSUPPRESS) $(MAKE) aggregate-results-and-cleanup
-- 
2.43.0-522-g2a540e432f


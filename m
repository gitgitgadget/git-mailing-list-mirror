Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE9239E7E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961478; cv=none; b=eIf7uxmCkGynXdcce/0MamoI2nUMxZubrImq1Z4P2hrkkUVg5MfV+l/a7dQSIyqI18JcHcS8NyIDTIxsUAPIWhnR4oir7Rig6IuOtNTZQQyBMbpXKUQMYuc9Yu1+EB67pMYri+VD2JJs3tE9c9w2rQW2Gr94LYVCybVTQWnTs8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961478; c=relaxed/simple;
	bh=y3b557sh1z8gt51zlDT0pO6uUooev9vRCnJJ375uaE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a1FBppA8btcOLXgKLvjqo0aqOoupuK3lKdsrugT70bzSXkjuPJ7yr7ACAO8FdMtGUxlmSCpCxxxWbbPKQqg1vwZWL6FKGQz5JJHohnfTB7iiRzFZgv3FRxY4qkYtoIN69CTaMSsDPoUmAxUySAkYGnYuXSMaS+M5v0lG+n2tPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xNGXnyuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDWmesw4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xNGXnyuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDWmesw4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A6EF211400DD;
	Tue,  3 Jun 2025 10:37:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 03 Jun 2025 10:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748961474; x=1749047874; bh=wMiv4IXcCl
	WVecXT3DRWIhb8CfGYk7VnM7HeAiFvhFU=; b=xNGXnyuZ3KDYenPc2ytGGhTP6s
	aD3bQUHRLb6wQx1BFOXjogCPbD0lGVdQZrKOyouX/PyBpVgvcTMEivTNRKsY/Bdn
	egLBl9qPsB4K4pMi/MxlAaWhUzDGM0kCtRxZKiglCT3+nFUJluEYJh110IvTGukb
	LKJE8w3mVB4dx5InrLZVRCH4gl1IuSdbKMLT5PFOJkkXdQSTsG42ePbXX6Tjz9xl
	sAjT9hL7LefeTACh2TJPUs/2AXhzO5qYVlq8TvcG/uBMK4UklzDrlktXdYSdBGAY
	gGjbK8vw7ZXI4MveVdYc6vpNfWoxNn8rzY9iODHd0nZ33DSoS+dpOnPI8Viw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748961474; x=1749047874; bh=wMiv4IXcClWVecXT3DRWIhb8CfGYk7VnM7H
	eAiFvhFU=; b=EDWmesw4LFO8XljKd8/MHK0SYks8/6s6SqVCMHLeje+72p0N6B3
	SfLE0cO3bcIx2fHbBlw9xwVcwfFOHVKk/TjkLNMqpKHqMKg7gMo0FT8/yhvdI5H8
	uI9Hg8x4DMV0lj7Svh4dGdHA5HhBRRTOTD6xpDHl4oo/OMD6Cak3ECZ/IYkxlSL2
	2x+t3S6eEWVx5T0Roh0oIG3N0BzVoeoih0sPE4Kx54cBiAxx4aKKq4rCOhnsY6K2
	3ckRHpM+Dl/SdGv5gvb6cp3E4APWqC6P2uw64OlIxwzPALojHDNBbNoprJ9rIHkR
	9AQtQ0ZMveTw21R3BifPPCU+6qZmr3mZvvg==
X-ME-Sender: <xms:wgg_aPj0YSXkq8BUJzenzEwEn50pdo-DhUIlxA6bRBPMJT3W945Q3A>
    <xme:wgg_aMA5Yhmmz-b5XL9fh-A1ZmtxDIItKp5Bp9Buorijd7hx3NpbBgHF8SKmCUJHE
    L_VoV-ACXzcS6XD1Q>
X-ME-Received: <xmr:wgg_aPFuFcNx_gXmEibBqyIgk_TZXIfFIIg0IZcqPo6XE-F-dSN3dmKTPj6i1PkEjzzNb5RG9b7HkQuCZZM_XTtO66NZFzFppsIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhllhhinhdrfhhunh
    hkudesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgrugestghomhhsthihlhgvrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wgg_aMQu3Nr4kOLAw0sE9kacO-3HuSwu3qbXc5njoWPv9tXwURCjNQ>
    <xmx:wgg_aMzFt1JETu6qFxVRXWjH-BtS0230LkNSONFY-C4OdVX8oVh17A>
    <xmx:wgg_aC4c6xS3CC8Jib72obRZxPqiAMRCsMKKj3BEGpz4iHlVnylNSw>
    <xmx:wgg_aBzlcXRNSrWk7F7VHbMhvnz7ePgIfn_kTQ_NPH7OX5HchFmtrg>
    <xmx:wgg_aC0gwOTo54xLB0fsLTWllDMcINLc-AOtpcOfYDhD8n4Q8NmIR02s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:37:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD
In-Reply-To: <87y0u9qxk8.fsf@gmail.com> (Collin Funk's message of "Mon, 02 Jun
	2025 21:05:43 -0700")
References: <87wm9ut3uo.fsf@gmail.com>
	<47c58a78-d38b-4170-87fc-c9332618d0da@comstyle.com>
	<87y0u9qxk8.fsf@gmail.com>
Date: Tue, 03 Jun 2025 07:37:52 -0700
Message-ID: <xmqqwm9sriv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Collin Funk <collin.funk1@gmail.com> writes:

> Brad Smith <brad@comstyle.com> writes:
> ...
>> But as said, it is harmless. I can leave it in if desired.
> ...
> I would prefer just leaving it for any old system that may need it.

OK, here is what I will queue.

-------- >8 --------
From: Brad Smith <brad@comstyle.com>
Date: Mon, 2 Jun 2025 03:29:02 -0400
Subject: [PATCH] compat: fixes for header handling with OpenBSD / NetBSD

Handle OpenBSD and NetBSD as FreeBSD / DragonFly are. OpenBSD would
need _XOPEN_SOURCE to be set to 700. Its simpler to just not set
_XOPEN_SOURCE.

    CC strbuf.o
strbuf.c:645:6: warning: call to undeclared function 'getdelim'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
        r = getdelim(&sb->buf, &sb->alloc, term, fp);
            ^
1 warning generated.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/posix.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/compat/posix.h b/compat/posix.h
index f4c71f9427..067a00f33b 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -60,11 +60,11 @@
 # else
 # define _XOPEN_SOURCE 500
 # endif
-#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
-      !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
-      !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__NetBSD__) && \
+      !defined(__OpenBSD__) && !defined(__DragonFly__) && !defined(__MirBSD__) && \
+      !defined(__USLC__) && !defined(_M_UNIX) && !defined(__sgi) && \
+      !defined(__TANDEM) && !defined(__QNX__) && !defined(__CYGWIN__)
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500 */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
-- 
2.50.0-rc0-176-g427db30fd9


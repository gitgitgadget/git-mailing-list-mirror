Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015C73B8D68
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765588978; cv=none; b=Of2+DhXQw+Ot3Tte20dl6dg+PadzEz71nDzGzYQPGT2K5PdsTYeuz10tk6VRCwDIgpWOGzfvayxMZ9uDFFLSUwTr30LPlGep5WsqZkiU/9hAA/cW8/TIR7+qGDm5sdwdrOFnLEHTZA2h/9c5rt792PYTvJA+gPTdM0ynm0MHPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765588978; c=relaxed/simple;
	bh=Upr6aTcQdK0DkCDAKjEjBfNONjroCsfM229Yobuay+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+Svk+xgcMIXyPRSlZFeC83bvVsrdOjWVClIsHG3XqkfuX5KDxboz/oyDDuAZjZbqq+JI2/w2HNgL98ANpuEkb4Ld7gxiOXdgEOAEN1RzGol/zgf7fp7xk7uab5O/wI/NG/DmpOu7tS2dvYKXxW0IGz+m+D42TRYWxSaDBYqcdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bCS6dI/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwnhwR0W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCS6dI/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwnhwR0W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 38ED6EC0564;
	Fri, 12 Dec 2025 20:22:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 12 Dec 2025 20:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765588975;
	 x=1765675375; bh=JD1gISB7dsw09Cw86ekAtwehMpEdAgqAud1aciExThU=; b=
	bCS6dI/hpPDjU8BxFws+1ZiDQVNZrXuugwi9erDQnoLXnGcOLcK6vvS3cc5j4hUW
	ItENlPHOOomQAg5ha5ZCI9TSeju2Kwsk+qk3vUiZcLpOYxXwTWAyhNaxCGnIOmkE
	CtvqBUPgjYeNqZzJ7NAoznAqDiGl2byte+BWYzeOaIfa+UgqJx59a3YaFmbpJtka
	S9DIY42SMhVfBxl1MR2gyRLzXqlkS13VDLVKi/zMteBOTczKTzumLdVMAdq+owoe
	aCslVGeDj1mFGr+ky3JYIqk27ze+MkUoUXMYXqZmoe3vt7yiLsJlkAzaZSxyY3ef
	i261lJ3/1DrKuXOkrUzomA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765588975; x=
	1765675375; bh=JD1gISB7dsw09Cw86ekAtwehMpEdAgqAud1aciExThU=; b=O
	wnhwR0W9pw3DTb2HuU9OBydaMInAEPAfMg3JmSr605eb9shmr+FIcUtIfqYMk8Hk
	BHy54f4gQA0ncDt7vJP9fSL2QL7rt23ikQB9zesaqn/CZV//2/+685FrbbD71UWc
	PhNK8iAejlQ1PnvstGjaY1ky0Tb9i4DygsDWs9rhON5iY/RiuUC5spL0Pvj3hUpl
	Z2oEx8YbZ70aZsNrXJoB8ElRgavB898Zw7mizlGTipsZuamnmS4Ss9bkxadJZEIQ
	QCb441lBGyZgEbnXKZ6qxxKlB8hGQMBqsF84hKYwi7mjQWAcIe+BqOdqc/7DXvIx
	cqKMEkqn7atRItAIFE0xA==
X-ME-Sender: <xms:7r88aVuWjEhDk4a6YdWISzonVVMovmkjmTJhHM4uplK4HWYX5pK5Cw>
    <xme:7r88aVWtAtQ-XRSNaRrDoECcHlg7FCKwn9ELshDNWjfQzCDZ-MW_mePSetGGi83oO
    N6iWEMqil-uyCKbfAvUJ2JzMo6LbGug7bRkWXMWwTjUbBMCu-JElA>
X-ME-Received: <xmr:7r88aRG-TNDiBo9_X3gESKrdFZXBOiDH-NlzBCfczcediBimK81QUfMnOMaYHC93q3SaZiPSvR8-ehmfL1yKQDIvJDa9JqSQlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    eplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7r88aX1dvR5Ktg-7G4HsGEuy0HHCrMBDXiJvc7bQZElWq-tiqKo-mg>
    <xmx:7r88aTPZ8ALNbNJS9CrlZAuob0uIc7x6Y-cuYPMVSYcTnp4o6TvmoQ>
    <xmx:7r88aW6msBx2JeSgRiHj6zRs3_eY4RrAY8yb5A19g1fXfRayn9zHtw>
    <xmx:7r88ad34XhTgGID5RjWxxEuWqwUZl8Ne47-y5YsexNRG2BALXiAjvQ>
    <xmx:7788aXwyAU6XfYLHhEykczb7y7McdAbKDO6qv33zoI3aC2d5ZKTvwN_P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 20:22:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] contrib/coccinelle: pass include paths to spatch(1)
In-Reply-To: <20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com> (Toon
	Claes's message of "Wed, 10 Dec 2025 14:13:02 +0100")
References: <20251210-toon-cocci-memzero-v1-0-ae916a79065b@iotcl.com>
	<20251210-toon-cocci-memzero-v1-2-ae916a79065b@iotcl.com>
Date: Sat, 13 Dec 2025 10:22:52 +0900
Message-ID: <xmqqwm2r9nv7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

> In the previous commit a new coccinelle rule is added. But neiter
> `make coccicheck` nor `meson compile coccicheck` did detect a case in
> builtin/last-modified.c.

I can reproduce this.  I started with only git-compat-util.h and
contrib/coccinelle/array.cocci from your [1/2] and without [2/2],
and "make coccicheck" produced all other changes contained in [1/2]
and the leftover changes to diffcore-delta.c, linear-assignment.c
and shallow.c I reported earlier in a separate message, but the one
in last-modified.c is left intact.  There are successful rewrites
that involve eword_t in other files, so I am not sure what the
problem is.

I used the following instead of your [1/2], as suggested by René in
an earlier exchange.  I did not see any changes but I did not expect
to, either.


 contrib/coccinelle/array.cocci | 22 ++++++++++++++++++++++
 git-compat-util.h              |  1 +
 2 files changed, 23 insertions(+)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index 27a3b479c9..ae23114b68 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -101,3 +101,25 @@ expression dst, src, n;
 -ALLOC_ARRAY(dst, n);
 -COPY_ARRAY(dst, src, n);
 +DUP_ARRAY(dst, src, n);
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- memset(ptr, \( '\0' \| 0 \), n * \( sizeof(T)
+-                                  \| sizeof(*ptr)
+-                                  \| sizeof(ptr[0])
+-                                  \) )
++ MEMZERO_ARRAY(ptr, n)
+
+@@
+type T;
+T[] ptr;
+expression n;
+@@
+- memset(ptr, \( '\0' \| 0 \), n * \( sizeof(T)
+-                                  \| sizeof(*ptr)
+-                                  \| sizeof(ptr[0])
+-                                  \) )
++ MEMZERO_ARRAY(ptr, n)
diff --git a/git-compat-util.h b/git-compat-util.h
index 398e0fac4f..2b8192fd2e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -726,6 +726,7 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
+#define MEMZERO_ARRAY(x, alloc) memset((x), 0x0, st_mult(sizeof(*(x)), (alloc)))
 
 #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
 	BARF_UNLESS_COPYABLE((dst), (src)))



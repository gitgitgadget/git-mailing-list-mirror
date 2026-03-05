Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F7281503
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753696; cv=none; b=ddxQoBRCufvgMu5aHI4L0a3xNGWNchGMfQ3/o8QnyeQz/fZzu8ETjQdP63a/PmX8qx8PfxONJp3/GTUjuHLy93v2K7rUf3nv/yRy1BlGuVQe7TjmHyDeo5Xcz7ixpJoJD6rHjiGYxOGk8jLCcmGEQ2wIfdhWSfJyFykh6QonD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753696; c=relaxed/simple;
	bh=C1ZlCn/3S0uwR054d7AE3w1MhSg7QDaWDqcZu+wuOxQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJYYn9qQanoIXAWaVMtIu0NSJYTfZj9SN+iG97WXDGq6NGxeU355JfqkBiz5t9MtqE1esQmCQXN3kcJg1vgfykYoADhiFBHITy2pSE2SAf3gGuEZ03jOLaQrFiNLUG3X90xavIUNoir5D1N7iJAhujlijRyzYpTpZGSI1uk/qvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hNe591sA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pb5CnVMw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hNe591sA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pb5CnVMw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 635D1EC0582;
	Thu,  5 Mar 2026 18:34:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 18:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772753694;
	 x=1772840094; bh=crv9RfJiFbeBlu6HXUJZnCsOvA/fuil8Tmp9GX1kQBE=; b=
	hNe591sAanhN8h6qVkyCVwINTZm5kmThcQVNUt4UKYMAZ4OKSpT1DvrT9D4VxJrt
	53fQxWdbtoc57kALbCefSDB1VS9mWZRbEUQ8skgAVpHlaiXkYwSWWL8ifhibqLUw
	0xWH3nyG37m2AefQiNWQCnR0q1zTBbVNaBVaP6/N0+589WxuMExspk4vGO4D1uA5
	PY5o8ughUoR3MaBnvO3dz5wwqBJQD4pFwPytAerSYtPCmGh/WAwhSNB4lsu2PqXL
	YIt4N26sY8b9s+SYPke/nSzOhYcdKLAORerIK8WaV3hFyn6t/Vwy+UWfrP4WdvcL
	AswV0uGNJWo1tysWfTYO+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1772753694; x=1772840094; bh=c
	rv9RfJiFbeBlu6HXUJZnCsOvA/fuil8Tmp9GX1kQBE=; b=pb5CnVMwROwJWJYW7
	n4rqLEKOQwwonpJ0GcuZHeRTIxyhhMQfheJdn4GsrLLPZXoP7CSQywPGK/AByQAx
	/y3AQhuxi2LBq+0V+KcDw8zXF/yLYA32Ut3MG8P7Io3ceSZatqwNQhfSp3TM1sQr
	HLqmbLx6IMkwygw0VdiTvioUF8Am1kDU6qEEfprb1aslJ3CHc60EH8Wz6fFL95ko
	TD2z0K0ikN2Jznq2TBxS6wspkGLXh86qpgVZoDIjYYRFUPsiz8l2unwsbwSzE28e
	G0OiQEP4oaVnthGCoPQwpoUwDWVIO9iE2p6ZXi3h4FllHnFhgff8EBvyB+bbvV0K
	01rvA==
X-ME-Sender: <xms:HhOqac2ZZ-3mGseVQHxJq22Cx08nxNLBxiODc40Gi7bTKUd7mQQmDQ>
    <xme:HhOqadFJ2pB87H7V6L-Wpbgdzj9J2DBg6pAkyp1CrlkjjWnwFNB3irRelVWApUgyF
    bn-I37-f1FRP7MTuGPJGhErBlPDEp5P9CCE49jSH-fBtbwL-KL9RQ>
X-ME-Received: <xmr:HhOqaSgqOEp6WXA9lnAz0FWrBl9dwsWBxKILqtFqfWc5pTNhV36RdF-TwH6XWUrQRTJBNkWBUOIohFz9HBDvndnXKre_YSaP9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhveehfeeljeethfeufffgvdeige
    dtteethfetvdevtedvudehvdfhffekhffhteenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HhOqaQ8shMTUgKW3pycZ3hprqhZGIvYWqCX3KiW5GBAWh15eH-JDVA>
    <xmx:HhOqaRq6dvXoywZNUL9wkqf1eCPNi1K2j_LQenJSjV3QkJYVS_su2g>
    <xmx:HhOqaX-EUOhfhfVlUdIxX4hxwLN8Ji8AdsHOdufN2rUb_qP-N4L7LQ>
    <xmx:HhOqadU2-2NF1Ey0kcf_839rbXVhSzpFFvRNRRWmCzrwFGZzaasbVg>
    <xmx:HhOqaYOSVoQV8-iCa3sAuunsreQsOrAGuw5qTeJAr2oANQqL4QxMGUbx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:34:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 0/7] Sanitizing sideband output
Date: Thu,  5 Mar 2026 15:34:45 -0800
Message-ID: <20260305233452.3727126-1-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-629-g0c401728ca
In-Reply-To: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
References: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Git's sideband channel passes server output directly to the client
terminal without sanitizing it, creating an ANSI escape sequence
injection vulnerability.  A patchset was posted based on the "we
dictate what byte sequences are allowed to be used by the end user,
and reject everything else, but the users can choose to lift the
blanket rejection" approach, found in [*1*], but the discussion
stalled.

Here is an attempt to unblock the topic.  In this round, the series
keeps the "we know what users are allowed to use and reject the
rest" approach from the original, but fixes one design problem
around the configuration variable.  The value 'default' that can be
explicitly set to the configuration whose meaning is planned to
change across Git 3.0 boundary is now gone.

The series is structured as follows.

 * The first 5 patches are from Dscho's [v4 1-5/6].  These introduce
   "reject what we do not explicitly allow" framework, and by
   default allow only ANSI color escape sequences.

   [1/7] sideband: mask control characters
   [2/7] sideband: introduce an "escape hatch" to allow control characters
   [3/7] sideband: do allow ANSI color sequences by default
   [4/7] sideband: add options to allow more control sequences to be passed through
   [5/7] sideband: offer to configure sanitizing on a per-URL basis

 * The 'default' problem was raised in [*2*] and the 6th patch is
   about solving it.

   [6/7] sideband: drop 'default' configuration

 * The 7th patch is from Dscho's [v4 6/6], adjusted for the above
   step.  This loosens the rules to allow _everything_ (i.e., the
   same as before) before Git 3.0, and then rejects anything other
   than ANSI color escape sequences after Git 3.0

   [7/7] sideband: delay sanitizing by default to Git v3.0

I think without the 'default' that changes its meaning across
version boundary, the early part of the series is a good place to
stop, if we want to proceed with the "allowlist" approach.  Unless I
hear objections, let's plan to merge patches 1-6 (i.e., everything
other than ANSI color escape sequences are filtered out) to 'next'
and keep it there for some time, to see if anybody screams, without
the last patch.

I am still hoping that people can help the topic and make it less
risky for users who are affected by switching to an opposite
philosophy, namely, "we filter byte sequences that are known to us
to be problematic, and pass everything else intact", but that is a
separate topic [*2*].  The experiment with patches 1-6 cooked in
'next' long enough may convince ourselves that ANSI colors are the
only thing that needs passing (which I personally fear is a bit too
naïve but we will never know until we try).


[References]

 *1* https://lore.kernel.org/git/pull.1853.v4.git.1770113882.gitgitgadget@gmail.com/

 *2* https://lore.kernel.org/git/xmqqv7gcnwd4.fsf@gitster.g/

-- 
2.53.0-629-gb58d2f6a3e

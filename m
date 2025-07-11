Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274E195
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192448; cv=none; b=mHiJokZPy5UtDAF8+JA+5gnuuu28dSgySx2dCEzVUKVmBBMG2pIja/yMwzoJmH4IfLY2uUerHgOJ6XZL5ooH8v9r3aimhz99qc1Tezea6vHkaklS9UmYX8r5suxO4K4o0rYJbHQFnx/aBLNICEiXJIXkw9Gccwk6ItslXZFZOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192448; c=relaxed/simple;
	bh=HVe2Baf+IUq5SzN+V6EVuH6dhHLahHWmKkOXplOOHg0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gmli6+c5v1aS8clySdw37Mf/LUXsL4UaCe+nRSTTjWiI22Y406JwcZRsxw8TOENvSPiVeib9CjzSvY3xO1G4RM5RQ5s0pNdZizaCJgn9JPjUwaP1+ChSj2CZgLFDccY9tn98yeZEg4tU4PhWl2N6km0mT1omIwdGTq2c5PuEbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HXHGDzbB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWd+7hHY; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HXHGDzbB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWd+7hHY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E9E147A0186;
	Thu, 10 Jul 2025 20:07:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 10 Jul 2025 20:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752192445; x=1752278845; bh=ppwsFfIonc
	PQtfSQOvf2CdjpbGn38yHMD0lwbZZbyBY=; b=HXHGDzbBG2t2rIHNxod6D8nklU
	5wjJBNVxovdwbw3B450w8iYur9Im9qwQDaqkxFKyxnp8xLIZY7Z1XImjYuaaZh5f
	GGLcbgBPT6awfMMkX/UjDwSGYLX27hG1aQXOGkEK6GHtHT8n5ajuIYhyIJPXmdKX
	S45r9w0bKhIrgRTDhsSWWzR66d0fItOqVSenUnNn6gqkHHoiGBw5XipkRRC12+8h
	3b5NS4zn9aSKRWgqwv1TFI3WU4qlZaQIhDPVHSeVdNkYelzJYC7pAZT3vkmTPplM
	mVg0zx46TEY0r9ZQP3wQ4xi4klcsnnQ5on3fnuFEk/j8WECN5Rdi5EF7wOxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752192445; x=1752278845; bh=ppwsFfIoncPQtfSQOvf2CdjpbGn38yHMD0l
	wbZZbyBY=; b=OWd+7hHYJHeHkhju95wCfdMekImmztBRns26p9gJQcuYnitDi38
	qS2iZYeGRfztBX+0MrFoIZ4MA+ipw/CI4/bbkdz6u9zSPWqRBToMEoaRCrO28zeP
	YgnNAEH6mBvaTTxpiI+jfsrdWXR6TR4bxsNZfGOfMYmAIwcNB+abGgvuvi8jIE/K
	H3EDgR6SvCJZavwuaEUN7iJ7GX36lkeGT9Odnkuk+h4F1ARAz7CVQajDrJKQzsZC
	5L7DT1mZlgT3lyV2k3yiLTLWiWNjeZcGlCjOzhKjplP7hqyZR26l5/UpZVhP7DV0
	YmXgckg5ifgWRIOoWDg6Q8mVETYFU6p3iPA==
X-ME-Sender: <xms:vVVwaNzQ23VgC1yCZdm_UEONUezEzOBo13FeDuwdGqTPjMWYsuzN0g>
    <xme:vVVwaNeLVjMZ-0bHXYHIIErRjtSWvcFcOku7IpD-as_fegOcKttEuh9M1RBaiD2IE
    wm5b9y9vcuu52BH5Q>
X-ME-Received: <xmr:vVVwaJL9iiFgfobPvtuuR0sFKg6f9IhKKAIko7OlGqT3bg3LO3-V1V0J5DK7w4wD7VBt7uzJQ8BWpQspA80UUu3D0RkGGHyjDOnLnfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffkedvveejhfekueektdeutdeiteetue
    etleefieeiffefvdevjedvfeevheeigeenucffohhmrghinhepphhkshdrihhmpdhsvghn
    ugdqvghmrghilhdrrhhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vVVwaOGgXXBEWlfcSxXILluanZXGdl4ouleFBE-PsAsEGO4Dw-jMvQ>
    <xmx:vVVwaDqRawH9NwoR-ZxLq7OWSZDE5Ckf7WxlSG9so3lgvpa5wZSwEg>
    <xmx:vVVwaHSkU0gkN_1ZajK3aMJJ2RAQyxEFLOD7qQVh2ka2N62vGYZ_gw>
    <xmx:vVVwaAM1H9YmQNoGGJck5J9c-IYXt2dRuviuNvRYnAvmgj6sg0RMYg>
    <xmx:vVVwaIVqcpElLhY6CYQyzp8Otmf4RH2791dMHyd-Fi_a0zMTC7ZbXabi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 20:07:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: "What's cooking" incremental update report
In-Reply-To: <xmqqv7o08ocn.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	10 Jul 2025 01:03:04 -0700")
References: <xmqqv7o08ocn.fsf@gitster.g>
Date: Thu, 10 Jul 2025 17:07:23 -0700
Message-ID: <xmqq7c0f4mkk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Since the latest issue of "What's cooking" (2025/07 #03),
here are the changes.  Two topics are now in 'next', a few topics
have been updated with their new iteration.

--------------------------------------------------
[New]

 * ps/sane-ctype-workaround (2025-07-09) 1 commit
  - sane-ctype: fix compiler error on Amazon Linux 2
 
  Our <sane-ctype.h> header file relied on that the system-supplied
  <ctype.h> header is not later included, which would override our
  macro definitions, but "amazon linux" broke this assumption.  Fix
  this by preemptively including <ctype.h> near the beginning of
  <sane-ctype.h> ourselves.
 
  Comments?
  source: <fabacc9bc7ef7d462d1c7198d5edc18c76b82270.1752139420.git.ps@pks.im>

--------------------------------------------------
[Merged to 'next']

 * ag/doc-send-email (2025-06-30) 5 commits
+  (merged to 'next' on 2025-07-09 at cf940e82a1)
+ + docs: mention possible options for Proton Mail users
+ + docs: add a paragraph explaining the `sendmailCmd` option of sendemail
+ + docs: add an OAuth2.0 credential helper for AOL accounts
+ + docs: add outlookidfix config option to sendemail documentation
+ + docs: link OpenSSL's verify(1) manual page to know about -CAfile and -CApath options
 
  Documentation updates for "git send-email".
 

 * rs/parse-options-precision (2025-07-09) 7 commits
+  (merged to 'next' on 2025-07-09 at aefffa21b7)
+ + parse-options: add precision handling for OPTION_COUNTUP
+ + parse-options: add precision handling for OPTION_BITOP
+ + parse-options: add precision handling for OPTION_NEGBIT
+ + parse-options: add precision handling for OPTION_BIT
+ + parse-options: add precision handling for OPTION_SET_INT
+ + parse-options: add precision handling for PARSE_OPT_CMDMODE
+ + parse-options: require PARSE_OPT_NOARG for OPTION_BITOP
 
  Define .precision to more canned parse-options type to avoid bugs
  coming from using a variable with a wrong type to capture the
  parsed values.
 

--------------------------------------------------
[Updated]

-* cb/daemon-reap-children (2025-06-26) 4 commits
+* cb/daemon-reap-children (2025-07-10) 2 commits
- - daemon: explicitly allow EINTR during poll()
  - daemon: use sigaction() to install child_handler()
  - compat/mingw: allow sigaction(SIGCHLD)
- - compat/posix.h: track SA_RESTART fallback
 
  Futz with SIGCHLD handling in "git daemon".
 
- Stalled?
- cf. <dba9ae0d-1e43-4345-a7ec-b57a07d45a07@gmail.com>
- source: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
+ Will merge to 'next'?
+ source: <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>

-* ly/changed-paths-traversal (2025-07-04) 4 commits
+* ly/changed-paths-traversal (2025-07-10) 4 commits
  - bloom: optimize multiple pathspec items in revision traversal
  - bloom: replace struct bloom_key * with struct bloom_keyvec
  - bloom: rename function operates on bloom_key
  - bloom: add test helper to return murmur3 hash
 
  Lift the limitation to use changed-path filter in "git log" so that
  it can be used for a pathspec with multiple literal paths.
 
  Expecting a reroll.
- cf. <5DB7714D-4009-47C4-A8F7-1C375C6D29AF@smail.nju.edu.cn>
- source: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
+ cf. <7885EBB2-0D99-4456-A704-86362219AC17@smail.nju.edu.cn>
+ source: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>

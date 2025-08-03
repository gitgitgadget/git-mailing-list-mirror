Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B3381C4
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203988; cv=none; b=ewLSUo9mfB6fFTxLOpZvEW//XiFUPNwWeq/rJOVUit6BhF160CmtqkIY0CNI7MoDfZ6t8ouwogYJE6BqZluf9It23j3EoFyC7t1PXmUVBRdGbf8e3Ran0XzUZMewkk9fC4oD2bvwXGfTdbjDS0j0ePlfUh49z+84BUZeB00ExAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203988; c=relaxed/simple;
	bh=JYYWf5b4UaVv2XS7CqA/voCtVNebiqZd4wFX5AgsTSs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEeR8Ww++m1K+DidOCVZAUh2kTklBvQJMj5bsKtPDv/PeKnCApI4UGgX4E303/gHR3g91buuydFdXlEWpooGLBMKnbc1AAqeiFwFnVy6cB4884BnoGydk2/XJCLRK+YpwbW8Day4/utYjv7odW97mHwaDx/w//aDIi05/6qcqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h1ELhJrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eoO13aZs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h1ELhJrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eoO13aZs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8299BEC1275;
	Sun,  3 Aug 2025 02:53:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 03 Aug 2025 02:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203985; x=
	1754290385; bh=FvM1JifKMMSYoNMiFnjeuWiqUSOarv3R1tmdZItv2sY=; b=h
	1ELhJrFwfO0CCqwo66IHxeVnIY7J1xuZzQGsXyqZtpU1O6Wuq0Jkjm24pTaQ47s/
	2EzwCHl2aKqxK5Q8LuMzpb+PIxryJYBABWtbrs+3rx0SGKQCQpWonpIOB5JhoPVU
	hQ5TPzF+LKEmF1TwqxPDanDYb25I/bbxFhMptx02T5Nq39J5h24pdCkfA/7B71xR
	zTmQxpXCny8sLvVM6iHXNyuVWmf3Jfjd7+Mcp06jYZzkZCRJVgjeonWHHulP9IQY
	nxaqW09R+Y1WxHobvDFKvzEXwCvBpMuHZobFMejrCsnUW7U/dhG6N81KnZDsN0ia
	p1waGIl1r8QkIxr4flxmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203985; x=1754290385; bh=FvM1JifKMMSYoNMiFnjeuWiqUSOa
	rv3R1tmdZItv2sY=; b=eoO13aZsoQOLWaobfjmhoh59FGiYQaz3za8riCr1hmDm
	LSYi7SC3WcgLI1T960gW/V9WCI2rbyDvQM+ZML4Xy25VRmyLQ2aqbbY0O0Whj1pl
	+wxTrmjpatY62ZAWAvRdNQYoWIi1XHB9xlxsICkdbGQOHP7BzOsfEjSSNDl/hZ9+
	zdXZeQf+B73KgILZ99+F0oI5Mvj8qT2iWzvIubuots8SoS/2FCkZ7poLbfd2CmOm
	Oa+GzH9K89bYR9qM4DO5aoQYXmk/GIoF2xvMrwB3dvTX13CH5+Ri6iA+q4Sc+b4M
	JoeCdVipiuBA7IbWrB0k6+DnZm1ze+SkEOwnLyovLg==
X-ME-Sender: <xms:UQePaBuLCKeoUMy6N7nfhJZ03Ogw24Deac2ANc_4AOvEOS2C0HbcrQ>
    <xme:UQePaKpyyqYrDp5VkODjjnFlSU8ygg8JUD82vLvB7lks79XKrN4VPtdhc-MgX4nW5
    u5pIWV3yz1yeFkEAg>
X-ME-Received: <xmr:UQePaGnXyS9RK_KIPJ1iWw3UEMYbqUJLknenqJ3IBc_nfA4scoUCWr1GXVApN4W6oxgEj5RsarK_nhT2y6516Z6oyyYNC4Q6vLOa-08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepieenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:UQePaGyLCz0kYx3EiHCa1YvTky4UYkK0SOjHTFNPKCnJCnypBk396Q>
    <xmx:UQePaGlQVSoPXmY4nA1ovHMyLjKH7bXGFJJWDhGPKzijNiLs9FiqKQ>
    <xmx:UQePaHdF8rbTgDFNp7pYTWvkGtPwlqvbsajT4s7bK8tOhn3Pxup7cQ>
    <xmx:UQePaEp1Fn1ETiHGwxgDoSvyX9CSjAm5Y7B5JqKPjAkFI2sXaudkoQ>
    <xmx:UQePaEQw3PlddxHxyfO43pUOjVV2QDrrvpVFxepdSKgiCP47xSlBn8n9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 00/12] do not overuse strbuf_split*()
Date: Sat,  2 Aug 2025 23:52:52 -0700
Message-ID: <20250803065304.3325286-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf is a very good data structure to work with string data
without having to worry about running past the end of the string.

But an array of strbuf is often a wrong data structure.  You rarely
have need to be able to edit multiple strings represented by such an
array simultaneously.  And strbuf_split*() that produces result in
such a shape is a misdesigned API function.

The most common use case of strbuf_split*() family of functions
seems to be to trim away the whitespaces around each piece of split
string.  With modern string_list_split*(), it is often no longer
necessary.

This series builds on top of the other series that extends string
list API to allow string_list_split() to take more than one delimiter
bytes, and to optionally trim the resulting string pieces.

I do not plan to eradicate all the uses of strbuf_split*() myself,
not because I found some valid use cases in the existing code (I
haven't yet), but these patches would give interested others enough
material to study and mimic to continue the effort and I can safely
leave it as #leftoverbits to rewrite them.

Relative to v2, this iteration v3 adds one more clean-up step to
correct a callee that insists on taking a while strbuf when it can
work with any NUL-terminated strings, and comes with a handful of
typofixes.

Junio C Hamano (12):
  wt-status: avoid strbuf_split*()
  clean: do not pass strbuf by value
  clean: do not use strbuf_split*() [part 1]
  clean: do not pass the whole structure when it is not necessary
  clean: do not use strbuf_split*() [part 2]
  merge-tree: do not use strbuf_split*()
  notes: do not use strbuf_split*()
  config: do not use strbuf_split()
  environment: do not use strbuf_split*()
  sub-process: do not use strbuf_split*()
  trace2: trim_trailing_newline followed by trim is a no-op
  trace2: do not use strbuf_split*()

 builtin/clean.c      | 74 ++++++++++++++++++++--------------------
 builtin/merge-tree.c | 30 +++++++++--------
 builtin/notes.c      | 23 +++++++------
 config.c             | 23 ++++++-------
 environment.c        | 19 +++++++----
 sub-process.c        | 15 ++++-----
 trace2/tr2_cfg.c     | 80 +++++++++++++++-----------------------------
 wt-status.c          | 31 ++++++-----------
 8 files changed, 129 insertions(+), 166 deletions(-)

Range-diff against v2:
 1:  27de3d9a92 =  1:  2efe707054 wt-status: avoid strbuf_split*()
 2:  8f096e5a2d =  2:  899ff9c175 clean: do not pass strbuf by value
 3:  768b08907e =  3:  7a4acc3607 clean: do not use strbuf_split*() [part 1]
 -:  ---------- >  4:  4985f72ea5 clean: do not pass the whole structure when it is not necessary
 4:  0f8583e798 =  5:  4f60672f6f clean: do not use strbuf_split*() [part 2]
 5:  cefc2ec9f5 =  6:  d33091220d merge-tree: do not use strbuf_split*()
 6:  1c8ea097f6 !  7:  566e910495 notes: do not use strbuf_split*()
    @@ Metadata
      ## Commit message ##
         notes: do not use strbuf_split*()
     
    -    When reading the copy instruction from the standard input, the
    -    program reads a line, splits it into tokens at whitespace, and trims
    -    each of the tokens before using.  We no longer need to use strbuf
    -    just to be able to trimming, as string_list_split*() family now can
    -    trim while splitting a string.
    +    When reading copy instructions from the standard input, the program
    +    reads a line, splits it into tokens at whitespace, and trims each of
    +    the tokens before using.  We no longer need to use strbuf just to be
    +    able to trim, as string_list_split*() family now can trim while
    +    splitting a string.
     
    -    Retire the use of strbuf_split().
    +    Retire the use of strbuf_split() from this code path.
     
         Note that this loop is a bit sloppy in that it ensures at least
         there are two tokens on each line, but ignores if there are extra
 7:  a472688ec1 !  8:  dcecac2580 config: do not use strbuf_split()
    @@ Commit message
         config: do not use strbuf_split()
     
         When parsing an old-style GIT_CONFIG_PARAMETERS environment
    -    variable, the code parses the key=value pair by spliting them at '='
    -    into an array of strbuf's.  As strbuf_split() leafes the delimiter
    +    variable, the code parses key=value pairs by splitting them at '='
    +    into an array of strbuf's.  As strbuf_split() leaves the delimiter
         at the end of the split piece, the code has to manually trim it.
     
         If we split with string_list_split(), that becomes unnecessary.
    -    Retire the use of strbuf_split().
    +    Retire the use of strbuf_split() from this code path.
     
         Note that the max parameter of string_list_split() is of
         an ergonomically iffy design---it specifies the maximum number of
 8:  2b9957f31c =  9:  b894d4481f environment: do not use strbuf_split*()
 9:  4a5599836d = 10:  d6fd08bd76 sub-process: do not use strbuf_split*()
10:  cf6ecd2090 ! 11:  cb8e82a641 trace2: trim_trailing_newline followed by trim is a no-op
    @@ Commit message
         of a string.  If the code plans to call strbuf_trim() immediately
         after doing so, the code is better off skipping the EOL trimming in
         the first place.  After all, LF/CRLF at the end is a mere special
    -    case of whitespaces at the right end of the string, which will be
    -    removed by strbuf_rtrim().
    +    case of whitespaces at the end of the string, which will be removed
    +    by strbuf_rtrim() anyway.
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
11:  c2578b6b1c ! 12:  838fe56920 trace2: do not use strbuf_split*()
    @@ Metadata
      ## Commit message ##
         trace2: do not use strbuf_split*()
     
    -    tr2_cfg_load_patterns() and tr2_load_env_vars() functions are copied
    -    and pasted pair of functions that each reads an environment
    -    variable, split the value at ',' boundaries and trims the resulting
    -    string pieces into an array of strbufs.  But the code paths that
    -    later use these strbufs take no advantage of the strbuf-ness of the
    -    result (they do not benefit from <ptr,len> representation to avoid
    -    having to run strlne(<ptr>), for example).
    +    tr2_cfg_load_patterns() and tr2_load_env_vars() functions are
    +    functions with very similar structure that each reads an environment
    +    variable, splits its value at the ',' boundaries, and trims the
    +    resulting string pieces into an array of strbufs.
    +
    +    But the code paths that later use these strbufs take no advantage of
    +    the strbuf-ness of the result (they do not benefit from <ptr,len>
    +    representation to avoid having to run strlen(<ptr>), for example).
     
         Simplify the code by teaching these functions to split into a string
    -    list instead.
    +    list instead; even the trimming comes for free ;-).
     
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     
-- 
2.50.1-633-g69dfdd50af


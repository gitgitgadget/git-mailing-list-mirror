Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F5D517
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742157707; cv=none; b=f8czn0AGt3HSzr6i0U3RSxnpTPPPZhrm22b3LfRWsG43+Zz0QNU0BOEY8tfb1r5q2/OKMUGT6bQJhoxUzjGE1oyINVIJS7J3IeRhDB9vVJsj3hjMT8uIQqobvRJkrDyy6m9uHLkt9dHoZzzZqNwcwblpz6VHQ0pYJuMTqXTI2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742157707; c=relaxed/simple;
	bh=6IkVU4UZEYIb51gMoGHfpRwXl+rBL+ZtSykdubAchvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nc/ox++8mrHEJchDFDJXwWDiXD1cgftt0Q6KUGj3F0Djwkawys1TRulUcywbGImvApDXMrk+3fuEhVH9C5SabCHJa8KQy2AKW5ChY2OSmOZS4ylNy72QzWCC0g9nrOsdVgmT2SV+n0DuQl//o3NIhFrLMuzWAxPKF2tgKEODtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NWcuaKng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J+iop9rb; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NWcuaKng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J+iop9rb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 80BD211400C7;
	Sun, 16 Mar 2025 16:41:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 16 Mar 2025 16:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742157704; x=1742244104; bh=EI5PvzlpH4
	kq8liPOQXEamQHHwCRoO6XQbvodmZ7Y7c=; b=NWcuaKng4JaQh6R5v3wPZbNtC4
	Sc1nC7TQInRA0tE5J9qxtqS/m96Fe+RIP/EE5Bai+iPDYagCJvsiRNhu7INHtUJ2
	2BZY7up7UFt1t14JdD0hZodUinssTMz6e9MVVzjfErOEcrpc4f5l7RrouFpS+OVR
	m6sYJ0B+97XNQKbDmsVBLwFupaaG4atYq6+oMBF3OAMN8za9B9J1infUZvaSqegx
	ctE+7GFUINC/qPV2dzoQ96hULkCMpRuSSYzckcveoKKFy8t8t/S/PQDNHFk+Cjo/
	99roU+4x5rb2vljE0u8oqndgMUTv3m18FfF161NlLFGEuE4JVgf8RURFp9Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742157704; x=1742244104; bh=EI5PvzlpH4kq8liPOQXEamQHHwCRoO6XQbv
	odmZ7Y7c=; b=J+iop9rbw8LzSL8A3HInG6c8si19QzVhvZ0XG4utPsusLfLaer3
	onC0Fl6L+u+Gu627cn0f+osO6q5zuf9iWXyG+JgY2qdQ9ycJ10y+kTIQCjkWinoP
	8glXuu8V+DWSDAA9t+iJB9Ukue8JV1S8ZHJHbGqURIocVD7XzNNwS76N8k68Ycom
	XrOss7PDN1wrDeNve++sTCyjp7gvTwuDftJevOAiUmgbmnQcSrYYzIwI2woJmWqg
	tVzbN9uHHPzmiSCBpEAj2GR4H1juCBUZoL+tlsxCgUDpd2K+eQbyAZITIP7zZuGV
	xGieSU4C946tZgzfH5mATfI5v3WrUS6YJ4w==
X-ME-Sender: <xms:hzfXZwNRjwvOhOVb8L5ST71M8ajhBt9fZzv2GO86XcWQTdT8wpnC0A>
    <xme:hzfXZ29MiD-6x5xnRDJzz45_CZhmdlMxWkQrvcj3vT4KYSHbWrpcpIk--OP8-z4Os
    VM5hv7rxGA1TH10EA>
X-ME-Received: <xmr:hzfXZ3SdaDG1Ry6ykvz25yACmXR5gphQv6zXBkeMWzU_w36CiRmuF9V2fyWMETOE9bYjqC0iYkmPNlHFdam1OhiBoAEKCxxYdFV0gEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepjeejjeejhfdtgfeuteelhfdtteelgfei
    ffdvjefftdeikefgjedvhffhffetgeelnecuffhomhgrihhnpehphhhorhhonhhigidrtg
    homhdpshhouhhrtggvfigrrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hzfXZ4uu1AoF26TmNYsDrkCsNW5Z5tnzU5gHICeiOU612T7OgoQnAg>
    <xmx:hzfXZ4f3xl88M4e-MytFsbysv9hkVP0G753vvFvHajS7YIoC78rMcQ>
    <xmx:hzfXZ81KdU1YjIBUiapfcwQn94lLpFbB8kwZzMlPw1umaCTh2DxqZw>
    <xmx:hzfXZ8-YvomV7mvzmsQQ8aFqbADHYPbygDQUNWy5319R6nhsXbFUOA>
    <xmx:iDfXZwT9zo7bqF2osmw6B_GiloCEAhc3KK486xio3yDsxZWHuynHvNN8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 16:41:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Adam Dinwoodie
 <git@dinwoodie.org>
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
In-Reply-To: <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sun, 16 Mar 2025 00:28:20 +0000")
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
	<Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
Date: Sun, 16 Mar 2025 13:41:40 -0700
Message-ID: <xmqqr02wbtdn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
> argued that it was not a secure approach (I disagree), and convinced the
> glibc maintainers to just make it a wrapper around the Linux kernel
> CSPRNG, which it now is.  So there's no actual benefit to calling
> arc4random versus getrandom, and since it's newer and less commonly
> available than getrandom, as well as slightly slower (because of an
> extra function call), getrandom should be preferred.

This

https://www.phoronix.com/news/GNU-Glibc-arc4random-Functions

was the first hit of my search in the area, but I think you are
referring to

https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=eaad4f9

that happened 5 days after the thing got in and the code there tells
me that your summary of the situation is quite accurate.

So I agree that dropping this patch makes sense, but do we want to
do a bit more to improve the situation?

Here is an attempt to improve what we have in Makefile (and possibly
the Linux section in config.mak.uname, but that is improving what we
do not have) to tell folks that arc4random in glibc is only for
compatibility and they should pick getrandom() until the situation
changes.

--- >8 ---
Subject: config/Makefile: a note on CSPRNG_METHOD choice for Linux

arc4random() was added to glibc in July 2022, but quickly replaced
by a stub implementation that wraps around getrandom().  Hence there
is no actual benefit to calling arc4random() over getrandom() on
glibc based systems, at least for now.

To avoid enticing Linux users to choose arc4random(), leave a note
that their arc4random() in glibc is not the same as what their
friends use on other platforms, and guide them to use getrandom()
instead in the meantime.

Helped-by: "brian m. carlson" <sandals@crustytoothpaste.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile         | 5 +++--
 config.mak.uname | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index 7315507381..7214936295 100644
--- c/Makefile
+++ w/Makefile
@@ -155,8 +155,9 @@ include shared.mak
 # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
 # the executable mode bit, but doesn't really do so.
 #
-# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
-# arc4random_buf, "libbsd" if your system has those functions from libbsd,
+# Define CSPRNG_METHOD to "arc4random" if your system has true arc4random and
+# arc4random_buf (not wrappers around "getrandom" shipped with glibc),
+# "libbsd" if your system has those functions from libbsd,
 # "getrandom" if your system has getrandom, "getentropy" if your system has
 # getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or "openssl" if
 # you'd want to use the OpenSSL CSPRNG.  You may set multiple options with
diff --git c/config.mak.uname w/config.mak.uname
index b12d4e168a..6bf511f24b 100644
--- c/config.mak.uname
+++ w/config.mak.uname
@@ -58,6 +58,8 @@ ifeq ($(uname_S),Linux)
 	NEEDS_LIBRT = YesPlease
 	HAVE_SYNC_FILE_RANGE = YesPlease
 	HAVE_GETDELIM = YesPlease
+	# note: don't choose arc4random on glibc systems
+	CSPRNG_METHOD =
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	BASIC_CFLAGS += -DHAVE_SYSINFO
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe





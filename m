Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF443A1DB
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167863; cv=none; b=FDVB0zC5VqyaMqsikiGY8jMWJhV0bl83DS7L1D7LUYoba107xzTbILFPdQYvj5UjbdrsDPChwgJixljIGTNJnVYomYMYIqRitqeslJFr+5yscaHZMfSbZpQlYbCZMJFTqMXPmwAaYUC0xu7p/JuVerEP9+cDu12HTn6Q72ftEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167863; c=relaxed/simple;
	bh=JHxOz5XES+roxl6f5P5mNC10y9yUVQHxPPdjZL1VsCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=WLfF5DK7uppyCj1l/nFr0njcxBGIs1V2FKcjcyrPiGXxBYwnmWZE+FGdtbLpcXJaSv6yBMCJdOyHHnCJLQzq8nh5iN38JHr7/OL8AdpfWcmUZOhK4xirN8NjB7+hpoLcsQomNn2HvYiWNiL/88ATtU1LtYvh4hSWwmorC1XFbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UB6qERCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pb50BYVf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UB6qERCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pb50BYVf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A20CE1140113
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jan 2025 11:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738167860;
	 x=1738254260; bh=MbJseAJZtw+KRuqd2VsklT/4I4JsPGhiKUUwOAN9qw0=; b=
	UB6qERCxZXk4z3xP2iW6c9s31W1oi9h+iIBgtjnGVckvozSeJEC9BO5d/Pypgm/L
	PiSR0dnB3/Vgxnf9OtTw7yzShkLB1Rs4TpT2jEfyEdb82ZvsWB8CsogALUaFFiid
	HANmx91W6xiPsUWyUuNO3ramm0MIYQnuTZMBFnZn9ocZ4ZGQloDLofXttSatFbt+
	xzN6VsUgI+aZaawDHIkW9JUo+OMdUMVZlZEBFIK/3mmB7/jGPPR6nPRDiQiYzawo
	4ScnyquU21Pk/Ei+REhjD/qiGbhlLn2Tx0vXd2i1JLlU0UOstpH3dLPiLFY/uPz0
	5UJjy3FTtHv6XLs2DGLkgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738167860; x=1738254260; bh=M
	bJseAJZtw+KRuqd2VsklT/4I4JsPGhiKUUwOAN9qw0=; b=pb50BYVf2IM6ngVzU
	95kljJ6c8jXklqhXY3jl8cLDg1Lb5F7tvWxseixNBJ+SUkHVPUVSDR1LBYGzNvvH
	ZuTzw9BkGGSTdwO7RpU34jIitDsq4e7ofS/nxAnIj+lRKptCLmuw+KR4BUPFiG/U
	O01RVI+PoZIm8NKNoPoJDydLCpEbcRTGc1SqXcqxMxbsRw1cDBevLBf7rxeD1c03
	9l8HpG7J3xj0stdYLGx+vtdnDzEEGZRzYwaU+VBBGOMYE/a61B/AlIUA1DCH2Kaz
	O+mWN0JMV9J9+O0ormGk6+CAcuQ9wU3350LXPc3UIELzvU3sFnXn2Yj5xocMHd0L
	tFfRg==
X-ME-Sender: <xms:NFaaZ3iMHx_kudQuQjCFdZk8pDKs65eFR4oFSiYXvh5GAv5muLVoMg>
    <xme:NFaaZ0C7OG8l7wN-6YQyMoWqYvCczxdU5TsqhVjApc_ba8kDYdFR1GgSXO9f-uTY8
    JqUV0eqblUuKN6OGQ>
X-ME-Received: <xmr:NFaaZ3GSw2lNnhKU264KRIqBP_nnYKTPPD7ciRmbQD6wEZ0Doby0FnczCEET45LNDRAuDswYnzKSr-zZplotDJCFX09tPBXD966K9lz-EoBUiYb_MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeelueduueelje
    elhfejueeffefgtedtvedtfeeffeevleelueetffegteduffegleenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NFaaZ0RM5gDlurxPWijw8Rmm9zbfVN4kJtsW6c_leci6FoJf_aH4IA>
    <xmx:NFaaZ0xVh83Btgh2-0k-auWKnYKJSoYD3sBZLwwN1tkAQXAYgvZO1g>
    <xmx:NFaaZ641OCRRD57qHXAeEuSyx5qjX94EkAWc44rcz06NZj2I6KfRJQ>
    <xmx:NFaaZ5zALr-HKArBHaFXG1EUdLTAOi20dYaPwrCJuUPIaIRomwzxIg>
    <xmx:NFaaZxocOYSxwH3SXSbWD8sSDKsGknR81Fx8fFX9CRoUSQYJeN-tEdIA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d04ba36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 16:24:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 17:24:15 +0100
Subject: [PATCH 2/2] scalar: free result of `remote_default_branch()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-memory-leaks-v1-2-79e41299eb0c@pks.im>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
In-Reply-To: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
To: git@vger.kernel.org
X-Mailer: b4 0.14.2

We don't free the result of `remote_default_branch()`, leading to a
memory leak. This leak is exposed by t9211, but only when run with Meson
via `meson setup -Dsanitize=leak`:

    Direct leak of 5 byte(s) in 1 object(s) allocated from:
        #0 0x5555555cfb93 in malloc (scalar+0x7bb93)
        #1 0x5555556b05c2 in do_xmalloc ../wrapper.c:55:8
        #2 0x5555556b06c4 in do_xmallocz ../wrapper.c:89:8
        #3 0x5555556b0656 in xmallocz ../wrapper.c:97:9
        #4 0x5555556b0728 in xmemdupz ../wrapper.c:113:16
        #5 0x5555556b07a7 in xstrndup ../wrapper.c:119:9
        #6 0x5555555d3a4b in remote_default_branch ../scalar.c:338:14
        #7 0x5555555d20e6 in cmd_clone ../scalar.c:493:28
        #8 0x5555555d196b in cmd_main ../scalar.c:992:14
        #9 0x5555557c4059 in main ../common-main.c:64:11
        #10 0x7ffff7a2a1fb in __libc_start_call_main (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a1fb) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
        #11 0x7ffff7a2a2b8 in __libc_start_main@GLIBC_2.2.5 (/nix/store/h7zcxabfxa7v5xdna45y2hplj31ncf8a-glibc-2.40-36/lib/libc.so.6+0x2a2b8) (BuildId: 0a855678aa0cb573cecbb2bcc73ab8239ec472d0)
        #12 0x555555592054 in _start (scalar+0x3e054)

    DEDUP_TOKEN: __interceptor_malloc--do_xmalloc--do_xmallocz--xmallocz--xmemdupz--xstrndup--remote_default_branch--cmd_clone--cmd_main--main--__libc_start_call_main--__libc_start_main@GLIBC_2.2.5--_start
    SUMMARY: LeakSanitizer: 5 byte(s) leaked in 1 allocation(s).

As the `branch` variable may contain a string constant obtained from
parsing command line arguments we cannot free the leaking variable
directly. Instead, introduce a new `branch_to_free` variable that only
ever gets assigned the allocated string and free that one to plug the
leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 scalar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scalar.c b/scalar.c
index f24bcd0169..da42b4be0c 100644
--- a/scalar.c
+++ b/scalar.c
@@ -409,6 +409,7 @@ void load_builtin_commands(const char *prefix UNUSED,
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
+	char *branch_to_free = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
 	int src = 1, tags = 1;
 	struct option clone_options[] = {
@@ -490,7 +491,7 @@ static int cmd_clone(int argc, const char **argv)
 	/* common-main already logs `argv` */
 	trace2_def_repo(the_repository);
 
-	if (!branch && !(branch = remote_default_branch(url))) {
+	if (!branch && !(branch = branch_to_free = remote_default_branch(url))) {
 		res = error(_("failed to get default branch for '%s'"), url);
 		goto cleanup;
 	}
@@ -552,6 +553,7 @@ static int cmd_clone(int argc, const char **argv)
 	res = register_dir();
 
 cleanup:
+	free(branch_to_free);
 	free(enlistment);
 	free(dir);
 	strbuf_release(&buf);

-- 
2.48.1.362.g079036d154.dirty


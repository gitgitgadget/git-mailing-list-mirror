Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51513AA2A
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217871; cv=none; b=uGotSljokIeob4xudKBbUG9vPVAzM8UzzT/KwN/7V1erqZFRfW2DIGn/7CIPIzClqfyOWJBQ6Jz+niZTI+lpg0hXy6WiScFd5WY1JMRVVWRsmiIjUvQXEk7lGT9e9zJEYf+L/8SbJDuGNfuRNHjreUyDv+EKVFDGkQC6Y7p4xQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217871; c=relaxed/simple;
	bh=sX6lAKfDteBbCIIfzW6BxnK+dETiYTSnSB5qz+qu37o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6ETyXqc2i7iV1N0TJWnoI4clj6fs/Nq6R5YbxRaOjDITObGz2mGqJbZDCS7UnGq3xFpdYkmSs6+sCKLvW2ubIR1vlNIID1uLjlWye+AkvkK5oWywu6KMK/W8Ho824CqZnaj+9VWEqA5w92qh+BxpduHLNECpGvBZu8tPSiW8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=du81yMB7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=umQHc5KN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="du81yMB7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="umQHc5KN"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E70A11140144;
	Thu, 30 Jan 2025 01:17:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Jan 2025 01:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738217868;
	 x=1738304268; bh=7CudHCCqhI/gjIkBeoPVZnDNHo7wg7oya58iwVmcNrg=; b=
	du81yMB7Qwuo99ffTCAmBWsJ7Pn7TwoikqD7GlBHjYa1Db4D9QpbQIX3NviRiLyt
	gM+8+hAPYPCzjgRfzqR98aJxQgpQuT6DBYywxrIg/KyamvdTvaQeSRA6RKSRmBmj
	dMGevXc0q7mFsvu1KWzNLO6TuZSkCBHNfHLeEtJqb3FVgrYErRs3721bZ6yrGbcx
	NXYpmRmTsG/7P5RoJ9NLNkbG1uPDz3vyXn+mlnEZcOJWEu7frF1iWIs7qL6dOeh4
	ygnLNOWcfeh+K/zABFHL8G9xXaHwjiViGonpYB1fAxqpxG4wWGe+trqy63pmaw0S
	dJtgkRnUv0zjXzpEJh925w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738217868; x=
	1738304268; bh=7CudHCCqhI/gjIkBeoPVZnDNHo7wg7oya58iwVmcNrg=; b=u
	mQHc5KNKCSKlS1OF+zMXFZS+CW4z1uiogeQuly7nQXgciuyBPyi8ISbyoAWEWB27
	u9biN8g0K1AItlE1oq4R6qd4xCex9ObcM0Sz/oGEH4i9uI6UGSlhCAMQIZ4SVkbl
	Euki+m8ZvQsEMtBr/qxoa4X4DcRBTkBiM2Hsb8iR8VwOusGiycNXHvTd0EEEFBBx
	3EO7zWZlIvQJKlYY5iDxTr7BIxHJTIhLxYHwvFT3ZaWzi6rGHhdNUfo8irSXtci8
	IqAZ6yJcH88OTvngSLZbn8tOY7wtVuGjza8+BxwAIXDkmGHI/ztYH1chRDIK+bUQ
	JDT9GmPllcmjj1wUYU68w==
X-ME-Sender: <xms:jBmbZ-hLtE999BdV6BGf6MevStuRgv2Dno-KWaeRuljNqfOnJy4STg>
    <xme:jBmbZ_DdzF26sLe1BcQ8jNlWGQ3FNkaThbELDu1TnSsF6xmiG-qcqdYwRDgPcgI-v
    jhYUk05dzZ1r5HgbA>
X-ME-Received: <xmr:jBmbZ2F3QLC_GklQL0oSop7RpDWsGw6RXNi7-0FMxFz_E0zvbGopP9dnMRDd21S8vkw0K1HN-vJLVrq06wKHf2JCDquR5VPgLnZqlcvxLR8q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:jBmbZ3RmA2cLzKfnCcdjTE02SZW3Hm5lq0AhYX7wkrCyIuxbAxx-4w>
    <xmx:jBmbZ7ybsjEPEgbgcpfTO3EdFHyIi3Wt59fHW_Duo47Ncq1SKWtykw>
    <xmx:jBmbZ17TLbvSfkDDrwYFiqsnnZC97ubklaGpadTkcJ47r8jhpzZxww>
    <xmx:jBmbZ4wEr685_l5dDhsv4KYzSlncDTjq8yfkxdFdUXsITnlqxZzchw>
    <xmx:jBmbZ2_ktlnBzRUJb2MAdBtmMoyWOTlzXhid4iLx9wxmz0ongWj_cZJn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 01:17:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0be4e2e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 06:17:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 07:17:39 +0100
Subject: [PATCH v2 2/2] scalar: free result of `remote_default_branch()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-memory-leaks-v2-2-fc29dc7d4b19@pks.im>
References: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
In-Reply-To: <20250130-b4-pks-memory-leaks-v2-0-fc29dc7d4b19@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We don't free the result of `remote_default_branch()`, leading to a
memory leak. This leak is exposed by t9211, but only when run with Meson
with the `-Db_sanitize=leak` option:

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

It is unclear why the leak isn't flagged when running the test via our
Makefile.

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
2.48.1.468.gbf5f394be8.dirty


Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EE1F2373
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296444; cv=none; b=J0p+k6Ky223h+EVwZGasiiKrHaq2F6kZVWRs0n87SMV98W7qF4xXmVk/ht2GKHC9NI5aayGLo5N3n5Mx4reCD+GaWaIbPwAeBEHBrF36+AvRXOBiL9PHf8+Mq8VPQ3hpuii1up6hph2HwYwqcJmyKHQqw6Y9Xyjt9VcG7XhwYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296444; c=relaxed/simple;
	bh=k3O4KP1LZ2WQgWEnVxU7CVhX/pooq+KmWp7vQc3s52U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IutKqcm5Hao6cjaAdZG4nQPAqxh2AN3qvKsOn0OJo2oY0CadpOM+O4yQOjnubAnDZHVIQFigMXB9M0VrqvLPAGIiWHYt5Pkc39c+i3VBi/mI+ydiMC6E98HcspyXCHnR6nBaNEZiiZhFKC2dGnILemhZnmKccaWeK/myGvlGRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bcm1hdvF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uIDod3fZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bcm1hdvF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uIDod3fZ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id DC15513801C5;
	Fri, 27 Dec 2024 05:47:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 27 Dec 2024 05:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735296441;
	 x=1735382841; bh=bzfII0eNrJq61Ponqi2eLztRVNnjc0dGan5XAEiw3UI=; b=
	bcm1hdvFAMmE/hw2YoYuzOZMYunObn+/Pgls+9WKHDivqbULJno0gk6yOvBK1Rs5
	9pezYHR1fJhG/0XLFWdk7HDrDCdcUylBrlH5zOtzVczIECybWpAhTeMUj4/Ia+5i
	6ElyrlOOJxDjhHh+uLaWK9r+Eh6Nj6en78HrivxG2bzKWGc+FXwhg/HUA0bQmk1o
	dYK2K+1th9dFx1u6duzwf1ECTprchawGL4Zm2XC/Ia6mQw6cd01Iz7nZ2qAT3kCz
	LPQCguDKaxFd4hoP16zz9439u/ADokXKb09HbKxIxW4JL+tz5MyKyCmxYqs3OLUq
	7Z+lFNoHrqDlDmL5EwBZ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735296441; x=
	1735382841; bh=bzfII0eNrJq61Ponqi2eLztRVNnjc0dGan5XAEiw3UI=; b=u
	IDod3fZZl4bXzWQ9wbOrLkmo3fBakFhX/GEbAL+1vVICBJWcKYkVC5D/4pNWIARb
	xPwLnvGPTT96/u1xizb65eZFTaCCCuaLkS9FmYlvkC/HrBdGtqkRF/DdlIw8DH9I
	1FPJj2faFqthb051fbXd9gQGVrPbncK59bAeXGhudYxW+XhVv9gdQecdEZTxLOhe
	xbF1HRLsmYrcgSjuFIPuyQ/DJq5FwawSwb9ILFM4xmQnbcmFE/84N2b95qyR50y1
	IHXxNKcP6fvDkYSTmCgEYR5ML3x3rt5EHH4NpIacScBbNWbI/1IFT7qUHQI9N6pV
	HI6FWqlsG91yc2yuEn1hA==
X-ME-Sender: <xms:uYVuZ0NtJk6x-f8YN3V4YVn5v_RC14ZbD3021xwlDjWp_4J-Z5un8A>
    <xme:uYVuZ6_TQOgGy0WRIvDuR12W1-0WjEVhoeX1OIjfmCxS5rIUDoFhc2Zu8DbEd0jcJ
    4gpcqXwkdPL7ecrAg>
X-ME-Received: <xmr:uYVuZ7SzfQAabXWwRnqp8DOHSAGHpMJOaK3MdSVKkTQTzQxp2WdGgNG9mjB_tuKDJM9XEncrBimyLPyElI5OKa2q1eKToCSvQXPpY3u5BFp30w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:uYVuZ8unzCsqg7QwpwsEGzArG3XysXJebhVcfMGVO6EWKyW2NPxsdQ>
    <xmx:uYVuZ8eXS3pRayFzBIKal7mrZA0UPwfKHy-e-IT4fQgZxf4D8H7Ujw>
    <xmx:uYVuZw0G5_rKC17kTyNJNI3Gmz3x3j5UiYJHPPQ4V4EZfYitUKZVCg>
    <xmx:uYVuZw_TZrBnnYihKNrKTBKhK0RVtsR22FiA0NvtiSMptuFme3McvA>
    <xmx:uYVuZ9o2kfw0RItVBuewBNS525xfm65Jh6dDCaacyf1RpPJSGKEictD9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:47:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d2a8354 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:45:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 11:46:27 +0100
Subject: [PATCH 7/9] builtin/log: fix remaining -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-commit-reach-sign-compare-v1-7-07c59c2aa632@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Fix remaining -Wsign-compare warnings in "builtin/log.c" and mark the
file as -Wsign-compare-clean. While most of the fixes are obvious, one
fix requires us to use `cast_size_t_to_int()`, which will cause us to
die in case the `size_t` cannot be represented as `int`. This should be
fine though, as the data would typically be set either via a config key
or via the command line, neither of which should ever exceed a couple of
kilobytes of data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 805b2355d964915732edf5928d54fb6d06e394d4..a4f41aafcae069541ee987dc94d245edfe9787a8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -6,7 +6,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "abspath.h"
@@ -209,7 +208,6 @@ static void cmd_log_init_defaults(struct rev_info *rev,
 
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
-	int i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude;
@@ -243,7 +241,7 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 	 * No command-line or config options were given, so
 	 * populate with sensible defaults.
 	 */
-	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
 		if (!ref_namespace[i].decoration)
 			continue;
 
@@ -717,14 +715,14 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	unsigned long size;
 	enum object_type type;
 	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
-	int offset = 0;
+	unsigned long offset = 0;
 
 	if (!buf)
 		return error(_("could not read object %s"), oid_to_hex(oid));
 
 	assert(type == OBJ_TAG);
 	while (offset < size && buf[offset] != '\n') {
-		int new_offset = offset + 1;
+		unsigned long new_offset = offset + 1;
 		const char *ident;
 		while (new_offset < size && buf[new_offset++] != '\n')
 			; /* do nothing */
@@ -1316,24 +1314,25 @@ static void print_signature(const char *signature, FILE *file)
 
 static char *find_branch_name(struct rev_info *rev)
 {
-	int i, positive = -1;
 	struct object_id branch_oid;
 	const struct object_id *tip_oid;
 	const char *ref, *v;
 	char *full_ref, *branch = NULL;
+	int interesting_found = 0;
+	size_t idx;
 
-	for (i = 0; i < rev->cmdline.nr; i++) {
+	for (size_t i = 0; i < rev->cmdline.nr; i++) {
 		if (rev->cmdline.rev[i].flags & UNINTERESTING)
 			continue;
-		if (positive < 0)
-			positive = i;
-		else
+		if (interesting_found)
 			return NULL;
+		interesting_found = 1;
+		idx = i;
 	}
-	if (positive < 0)
+	if (!interesting_found)
 		return NULL;
-	ref = rev->cmdline.rev[positive].name;
-	tip_oid = &rev->cmdline.rev[positive].item->oid;
+	ref = rev->cmdline.rev[idx].name;
+	tip_oid = &rev->cmdline.rev[idx].item->oid;
 	if (repo_dwim_ref(the_repository, ref, strlen(ref), &branch_oid,
 			  &full_ref, 0) &&
 	    skip_prefix(full_ref, "refs/heads/", &v) &&
@@ -2183,7 +2182,7 @@ int cmd_format_patch(int argc,
 		fmt_patch_suffix = cfg.fmt_patch_suffix;
 
 	/* Make sure "0000-$sub.patch" gives non-negative length for $sub */
-	if (cfg.log.fmt_patch_name_max <= strlen("0000-") + strlen(fmt_patch_suffix))
+	if (cfg.log.fmt_patch_name_max <= cast_size_t_to_int(strlen("0000-") + strlen(fmt_patch_suffix)))
 		cfg.log.fmt_patch_name_max = strlen("0000-") + strlen(fmt_patch_suffix);
 
 	if (cover_from_description_arg)

-- 
2.48.0.rc0.184.g0fc57dec57.dirty


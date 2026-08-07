Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89DB42FCDE
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099554; cv=none; b=IMMlBxZLcOuH50mtS97LiadtPoDRl1eF8m4Nz+glly6vjxkFDqmpJXVOCA2iN/rWi9LfbGdxrCj9JZOs0fTvVfz0e/0X/UKwXjlPYjojW43vC1J9kGsMyNnW9qcCFnvA6FFneb4ZW88yiYzx0wrrMwUQ+H+G/twodjgeMTELKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099554; c=relaxed/simple;
	bh=0p/k/OL8ZSNdFeU890Va1YDubQylos4h+b0yQYMY4oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNv5BSMGWAMYQAk813WdOBw38tSZVFa3whnGxoWvDZHf5ktxpudCB15T0WanNBrecCNl9bXeoV27yv9MRVXhrfoc4PFF+omItfSE0zKGdGmTndZNd0vUCy+QwyyQGCnHFHjO8tbZXAiMKjL35z4RLkbjYSyj/jfb2CgRkQRgB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I/7595LM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTACKzSw; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I/7595LM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTACKzSw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A3AA0EC0170
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:45:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 06:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786099551;
	 x=1786185951; bh=R8D7yP78Rgfh9o0BJ8r+cR8UmvgJkP6XUvCDlPGFYTY=; b=
	I/7595LMjqsuqm9AJuHyTIdkqh1xgyqkLKi3CG6NvaiKL8uIqSIb34OONnwamwY2
	ktMV/WgTOisXq5zi3Xfkcl8WgqNNhkm+BKxa56IKq+6i5HS/eBCsHujjjL3bJr6I
	fwkOIGmij8a47WunkjIEnFCKu43WhnUIYCDebCud6+75EryxPxJD5qa/fub1jKf3
	HxIQOiavEnJiX7uaYHGSUS6MiBpcvMNIA592xhdfjzbYAnoeLE0DDYGszLI1TQaF
	dewlCMg7KF6fpwKxX07fkcoZtxrc6O1ATTpGnLwPHLo5v7zw9Dt586TGSvef5niW
	jR1+QcjMGgncHMX4OLtesw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786099551; x=
	1786185951; bh=R8D7yP78Rgfh9o0BJ8r+cR8UmvgJkP6XUvCDlPGFYTY=; b=U
	TACKzSweGFeVJgHqb2Xm/NSLYUEJKmOcnihAIcBzk44UA2anf0rt2my8zknF9IHN
	PJS4iF9UunYVOZSE82NCnu5oRAR3TyRyTJOfhA8Zm89N01k3TS5Z3dzLdXEq2VoG
	L2nXy4UwFC7YyVDpeqsE7A0dmk0IE9nISwARPialRO5Sk8FDp+8dsHceRXUroBl6
	nE9FMyjZURAngvNwM9A3Blo7qHO6suMBvDKPY4GlykPGA6PyZvwAUizEe76BmVgd
	Iwys4hIZn4DTJrGRvV/SBIKjzJCkwYRdqjxkTj0l+9rgVODdXb/CaLKNMQHdL3m/
	7frYnFHve9MSXtNDD7skg==
X-ME-Sender: <xms:X7d1apOfPLwE0FWqlYy2dZqeIdZovTwVDobT70gp87-adcXXIU0Rew>
    <xme:X7d1ai4YUtkPCmwfnh5NwLArsqAq-mrimh0NT6-987Sc9LWfG2JZeF6JJ-_axG--G
    QKeGUfOJRe0_7_3OeBj3uQ5gjJER3ECA8a4A-URZW3Z9q-Go_BHRQ>
X-ME-Received: <xmr:X7d1at4KOPTpjC-nxXNfxuy7wkj6srpGb4nplzEBIThxJbMTjuY1GaaSasyZnnXCPfPkthGB7zVEgKY3ECMqJNk5NWBiebXHvHqkbrylrrDTLg>
X-ME-Proxy-Cause: dmFkZTGNsvSFSUECcu2Nh0FGOfZ19l5LxGfcGph13wKJT4TAzUBJREfYOszHqXAiQ3n7iU
    lqzIMoX63uJA32W3RBYcZ1/RyQqX26JNaPlBXTGD/ls9dTd0VZhbyytEvDxvkaEG0PK67L
    JGkzA9lNwINefEzvYZKwdjhramO6e3IPfqAJZG0u2o9u3xqlHWQV4mjs6csBpBWYeIfq6t
    8Z7hNK95Hh9RzVMFiF3lT8k+1IfFEkOfZOp6vFPBbw6UfNt0jStcDh7rvbhnMOCy09Xr8t
    YSyUhF+HhFTVABaqOv1R5YNe4ByqU5empe4W0yKQu/SyfLZzc4QHCbGw1hYoAGreUqXRA6
    M4XDTu/MAsmXyfojK+y/6OjLkH106XrckIy6jlOWHbm6pTIKkWqUCSBM5W3VVYEhbFgJEe
    od1rh9LcEAHQWrCXhXyv7L23MbXSbsL4fAi94PVv3WeUsGgqZ5n9F/FauvqKAuCe0LLiwW
    3aAwQYZX+6+S6us1xOI2RnA6zHyJ9TJy55fFFdBqBxywoqH2oI2ssfnzc2pbxxqjLlddMr
    7Xsb4hVxGjxMzVWm+A54WsWy9tZOqNEkKS6W7bAcRM6eGaikCGVLA9xNX+iR3ioQphPONj
    mfOFUTHawGSIrmuSKrXLsn7gNsZY+C0U8SgAUZlMLZM7MFABCbXFBSuySh8g
X-ME-Proxy: <xmx:X7d1aq2VvUaWN-oePW6ipv66u_rQkq-RNl6mXAG_dEwImP9eRlNpTA>
    <xmx:X7d1ahUe0xWReCWaObsxOa_pVUxzqXiXzls4dQxKOH39vA18zAzYGg>
    <xmx:X7d1at6Z8apaqzWPGakOI3jdvoG_75-xGtS45WLKJescRDiLJ0fWLw>
    <xmx:X7d1agIBw0SfeWfBpdYl2PgKd8Da6MhjrrhJ607581OmUyS5yr_uEg>
    <xmx:X7d1al-qpoWbg-f9Qw5ELJdYpYAK1VArMBAbXrIP1m6hcFcZ9v-WA-dB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:45:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97c7ce0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:45:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:45:10 +0200
Subject: [PATCH 4/5] builtin/bundle: refactor option handling for progress
 meter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-b4-pks-odb-generate-pack-v1-4-7dec431ae7cd@pks.im>
References: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
In-Reply-To: <20260807-b4-pks-odb-generate-pack-v1-0-7dec431ae7cd@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The git-bundle(1) command has a couple of command line options that
relate to whether or not progress should be reported. These options
match the options that git-pack-objects(1) expects, and consequently
they mostly get passed through to it directly.

This results in somewhat of a confusing interface: there are four
different options that relate to whether or not progress should be
displayed and how verbose it should be. But in reality, there's really
only two modes:

  - "--progress" and "--all-progress" result in the same outcome, which
    is also documented as such.

  - "--all-progress-implied" does nothing as we pass that argument to
    git-pack-objects(1) unconditionally anyway.

So in the end, the options only control whether or not progress should
be displayed at all, nothing else.

Refactor the interface to instead use a simple `progress` boolean. This
makes argument handling a lot more straight-forward and it prepares us
for the next commit, where we're migrating git-bundle(1) to the generic
interface for generating a packfile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1e170e9278..bfafadc984 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -70,35 +70,34 @@ static int parse_options_cmd_bundle(int argc,
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 			     struct repository *repo UNUSED) {
 	struct strvec pack_opts = STRVEC_INIT;
+	int progress = isatty(STDERR_FILENO);
 	int version = -1;
-	int ret;
 	struct option options[] = {
-		OPT_PASSTHRU_ARGV('q', "quiet", &pack_opts, NULL,
-				  N_("do not show progress meter"),
-				  PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "progress", &pack_opts, NULL,
-				  N_("show progress meter"),
-				  PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "all-progress", &pack_opts, NULL,
-				  N_("historical; same as --progress"),
-				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
-		OPT_PASSTHRU_ARGV(0, "all-progress-implied", &pack_opts, NULL,
-				  N_("historical; does nothing"),
-				  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN),
+		OPT_NEGBIT('q', "quiet", &progress,
+			   N_("do not show progress meter"), 1),
+		OPT_BIT(0, "progress", &progress,
+			N_("show progress meter"), 1),
+		OPT_BIT_F(0, "all-progress", &progress,
+			  N_("historical; same as --progress"), 1,
+			  PARSE_OPT_HIDDEN),
+		OPT_NOOP_NOARG(0, "all-progress-implied"),
 		OPT_INTEGER(0, "version", &version,
 			    N_("specify bundle format version")),
 		OPT_END()
 	};
 	char *bundle_file;
-
-	if (isatty(STDERR_FILENO))
-		strvec_push(&pack_opts, "--progress");
-	strvec_push(&pack_opts, "--all-progress-implied");
+	int ret;
 
 	argc = parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_create_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
 
+	if (progress)
+		strvec_push(&pack_opts, "--progress");
+	else
+		strvec_push(&pack_opts, "--quiet");
+	strvec_push(&pack_opts, "--all-progress-implied");
+
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
 	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);

-- 
2.55.0.679.g6767b8d81c.dirty


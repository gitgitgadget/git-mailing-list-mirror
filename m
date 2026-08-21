Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636184156C2
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293821; cv=none; b=VNKxCKZi5ymeoEdAphI5y0zovhK8dj03GI8APTePmOtniFY7ExQuh4ZDberSuo5WC9XZGZAQZciWloDTojMurVVneYQuQIzYch0VopVnFaItqxDka7SBI68V29MJPyuiJ4n9/cKklyPuZ60wl3hYrPuL9+AQF2eE06RUTku3Ptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293821; c=relaxed/simple;
	bh=gWUAKuISxreljwcS1nFc0hslOP805lUVZ7EgHHzyvWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSf83a5t6CFfFO2i5CCAxReluDH3pj3pfCw5AT0/kkAFL7/m+ZXR36WjhHNLBjCQ3/0LQ/Ck7dTuGrKPMCaAZJcMTYZz3rPYgiDd9X4Qttm9pEAprNdCdlHHEm0kgXJEF4aRlje2m+nSSGb+eX9hOWZP4xx2udeSNVsN9rUPXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cmiyku0d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwQUcxFW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cmiyku0d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwQUcxFW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EFA1EC02AE;
	Fri, 21 Aug 2026 02:30:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Aug 2026 02:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787293819;
	 x=1787380219; bh=KFxM4hbLPgZQ5cdv8a1NKBaxbS9EAZYPRi3rQQMJuQc=; b=
	cmiyku0dDiDp0X+PPFuEG9vhmrKavr9BZBFuelrCWcuhIa/ygaTH+xECGv6To7oK
	/qlTDazFb5L0Yo3ek0vLLrmfmq3q/1SaVBVrII6bY7GwhVoZUIeebOoeQVirMRJV
	YR6TZ1N/PkxkdeRq4mzZi/JNRvfjUz0SvbX8wURSv58PZilJBEPaJhHqKq+jRtEt
	XEsIyCr9qiv3JPOp8SrevOENlnmd9WzpJXlKrt/NC1Ld+zmdt6WpY9j9W/nKayfS
	rGvquVL2vnNyI97Bb/ddmv12no/cuoyDQeBrZ2DB5h47d/IrceKhXCQg+NoBV4pI
	xIsGe9SlbIIQ1SWNlQTpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787293819; x=
	1787380219; bh=KFxM4hbLPgZQ5cdv8a1NKBaxbS9EAZYPRi3rQQMJuQc=; b=N
	wQUcxFWFmArxRUaP02zk8oos8ce7V2wcx5ZyV4DNs91VAOmwxo2xE1L2tMUGx7tt
	2z3pZsOFkK2RAKUntGg7yTTtEUXrSMLRlTjxSJL4dCzvgX90UV5gqAwqydmPTZWH
	J4p/PTAPDV4g5WciTrtb9oZ6d+UOTbjlUuMxsgJytfv16/X0eaKlezpyZQvvvSlj
	wbsB7R6A1edqGpk5rgGYfhzblCMyP6c/oSSDbUmYjRpvvdC1XU6xD9OCFxvXlPXQ
	gKesQRt3wx2aCOla8R5wxDBc5rGdNJ1gIVv3cOsJ/KvVO6UAFcY1N3O/XHhuVYVg
	m0DzwKn6HSwa47W32LU/w==
X-ME-Sender: <xms:e_CHaiqioaf3lwFKDeeAobelimRnRg7W5J3NJZ2KNDIqRuydXO6CWg>
    <xme:e_CHaniuaJ1xjIyJz0gQbsY1jSnVhNM1TgYBY7pKAbhAV1uaJbl00uw6XCcEyz-A6
    1dlM7vz_WSifz1tMOb8ZK8SMPBD6aps6bHOVDSFlEJxSAhBxmfpGZc>
X-ME-Received: <xmr:e_CHavirBJxXB8PqWV66TzPjrh8nOi6qsS6SxXot4q8DPrz1wJN3TO2GYPI-Y0zzmeKvdgQUQLHebPKNzpqHPi-9szU5XfEq8vDEWGuSBUrw>
X-ME-Proxy-Cause: dmFkZTFOsnqZFvFAsZ6dw3BMx9gD3pe649no1Q5+pxVYg6gGo7oNkCmbJalFqc+jHFtmID
    RaRAAMqOr5Dax1kTanndHINXiDpLK04EVbTnXSqsKaaBGXopToHvuu9z0IzacuMrpv75k5
    MMyuHWpTDNY06Me9cf0/5J82v/p54IvpLd/GSqaTCDZk8uCdTOErloALOV83IQSKjUgFKk
    14TktuIkU/KgUdUpuxxoU5Ykz+e2jwx2gPQE7Pel8xmxdCa4uWa5O/de0R7BBYixLtkAPw
    cA2du4/8TogV5iZNNaAG1IZMXvbbQJe854uwOBNUTaw5DCdACl5f905fziUQb/9H1x+MOt
    jFgNWWqPyrGHJV4FcTp62N/WTNCXEAHYOsbpDgl2oI3s0DkKFI49L5QcPjdqbHF6/o29oU
    VxBIb+QaC0elbMSlOpriY6qwlbDJyujK5eNAW5lQx9pC8lWnTKiny/5GRwp0DXX0OukMeV
    gvUMeDf+SykbhB+FKrKAX+F3aJUcDfMf4vm+ZYGCa/9NnESl/PhBM5QoldxWifGATOyjTn
    3/v4cjS4LhfijgzCgOuj8krjh/xgxwV9M+jQ21eLrwwMFo1OOGGc99TLqYk2/DMkBDbJs/
    FHG2Hz/sd9r5rY+pfrOxJRphwvPSKkfrz2C9eJCwDitWUCb2wSLvTjaM46hA
X-ME-Proxy: <xmx:e_CHatgyv749lhhVvyBrlGNVjx0yzIODvkxpxS9d90xHNV-cJQKNgQ>
    <xmx:e_CHavJyTGNmYU8T-PBlCT6idzqC7NkT0i4YvurwvUfXQP8Di3Dkrg>
    <xmx:e_CHasG25s2DpM156pwbejoKT8-VW5zpj0yhCmcmmeTQYJFsQpBOdg>
    <xmx:e_CHajR-kiGCb_UVTSuUs1AveUytId25PCgOjtMeEaXuXDdia4PK2w>
    <xmx:e_CHagyT8AOFRG0ojyPMpQPVxrNB72VZ34-hxF2XjXxMR5PhJAKY_50k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 02:30:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e5bebf3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 06:30:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Aug 2026 08:30:04 +0200
Subject: [PATCH v4 4/6] builtin/bundle: refactor option handling for
 progress meter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-pks-odb-generate-pack-v4-4-074e8bd641f8@pks.im>
References: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
In-Reply-To: <20260821-b4-pks-odb-generate-pack-v4-0-074e8bd641f8@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>
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
2.55.0.822.g20453c30eb.dirty


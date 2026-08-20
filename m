Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D93D3CFF
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212548; cv=none; b=baJYsLlhp1fK83NK0jEDoQPZaZauz6GCxuV6OvWZC7+arQ5sn5luht78YmrsO2gSTIw6r7nWhqT1Pm/+w6seiIFM/p0W0+UeYZVS/YkZLGMdzaeXJrv5yvJ41pcrb8nSKmZnmnoEuLIYD6U+BEXhLsCDmu6+0xJs6lDd7ktkMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212548; c=relaxed/simple;
	bh=gWUAKuISxreljwcS1nFc0hslOP805lUVZ7EgHHzyvWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwrer8O6G5XjJkA7jl1pmVYjwgkk6XPjnqVmIAhGtKV1TR0qJpXw0IwOAg0pOgLrAIN5AaQHvqz199LKkJk1PjHo6Ww32u4UrgH/KFoXI1BR7SnU7+H5Co4X2FZCxCmX1Tx5oTJJcorYh3p38I6SHow3h6LdYis912IgrC3ztb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C9I4AB0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDODuSdl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C9I4AB0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDODuSdl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 83A36EC01A1;
	Thu, 20 Aug 2026 03:55:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 20 Aug 2026 03:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787212546;
	 x=1787298946; bh=KFxM4hbLPgZQ5cdv8a1NKBaxbS9EAZYPRi3rQQMJuQc=; b=
	C9I4AB0sbNQIO3Eil1/sdHKQtAvaNZCq+Qf22/Tf6JEBD/CRDKzI2E/MDgENY0Uh
	QFpfQ53KY8/JwhhYu5uRPiLGH3qlAX+unZzQz6Kf7EmxPp88NNeZbuDT62vQVOam
	ZrvpV3PGzV9xBxnRXER6BLORpT2U8Q5qHhBOqhJO4zrSivpfs1mPGUdfZGVbWvFW
	nFEWiwkz0AMAGaQdMlMifCj3VlTFyLyQYm/NZuxnwE6RbjexqV+aAA/QOp7vC+Tv
	wg41IqDx1GcAx/+xD4m1WjaVEOsNdrvt7wurlUKLP5oOLXR2r7q2u1H65S6xV55i
	ExEJpdF3zXZWCTYfTjheOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787212546; x=
	1787298946; bh=KFxM4hbLPgZQ5cdv8a1NKBaxbS9EAZYPRi3rQQMJuQc=; b=S
	DODuSdlup/OfYYRtAm4kGwTmSV8z94XFVkvjwHKz0O602gsULaN8l4qdsYx+3VuI
	irs7RiaOYmPIQjOORn+//FHfWgrOV0pTzlfEq7Y37cd60bLDx/g/JEYGwEyBOiGV
	5Ws+Eq5MDSv+x+6txyNv2f1+J4f+uC9HwBfnjT8meojtNFZaguhHkjEdBVlvQetC
	0Kkon8QsUMLF+qvHACotXLmfPA6xh65Afs1gJfQjU16s41G7A71k0QIg54huQxxn
	ejD269nyWL89zrNNmRAfFtQ4PHeafp4eC7ZBkJLwGg/CfHPej4In1xgM1G0yBZr4
	4MjjXSKogOCginRWNqtYA==
X-ME-Sender: <xms:ArOGakzvmWW8xf4LQeQq69p1NP14si25y5uorqZM1htpt6RsLhsWkQ>
    <xme:ArOGavTrx3R67CQabFCZXAY0M9cY3I6SpENCo4PdvoVm_ZkNBjyBdc2vGl62oH2EP
    fXeNnhXZAdkhZhNVFrUc_V0vqyyfwtwSf2MwnR64dCKXGNH26lN>
X-ME-Received: <xmr:ArOGarW89uELi0yTc0JeVkBEy3UmZlxtFgCeJUbg99HGD_A7ovmn5uPLj3VAQzOiXtY2eBRRHU2GIR4Cx_oDzf4DHgKMeJb6OUIj7OClCQ>
X-ME-Proxy-Cause: dmFkZTFf6dj8/8V1XaAc7B1kVMFZTKvMbAEygAXbbhBXRMoJE0Q/MsehWCz6Zsr3VItoGJ
    sSOYPjnsDlfrh3lzEARCv0NJnfuJQJusLASMKcwM9uC/Tbs/YIBauNX4V2AuW+yb3o66jM
    JzMl+gjCx01/1zMiYhH+kC59/ghsfTubikmfaAxgUR/millS0tlPNpkYgp4jFToJY+LVEk
    c6s4D4aztX2xzEJ3LDQqGoLTd3S6W+Hcma/glCPpKbDpT9Cmp60wceni6gyM3ckjl3Tvge
    oRcfTlFV6iALm7ps8/b3emKy+rfSopq+d7NQ4EYMi/B5tNUxYa1zjgIENCda7YAb8Hlkod
    lCRu+45zmKVBWKKS+NE5f1IfAz3YFzVTYZ+LzKRhNFvxfEz6syG8shpnDFJJudo4keWnCB
    S2fpSr62j68sh4xvRkMLYSHQ2EwKs8mdchfRhVTHOOQslNUbF2bNU2ZtLEHi1bjrunxgK3
    2Br0zgYm3nr8lXo4uNkv3qQb1z5DsEoSNQNzXq9am9q0+2M9LPwNopmlTRIYxqA5JGr7VN
    2dOwxIXKlz6IuuL3Ffsj1qeVOM9zVE2H0IMquVq8jpTufxMnDyXRnwws+ABxYqv61ARhMK
    VwlWk3KUK8iCYfaxbi4yE9qXW8+9na2PPbBp1IC8xxz0GxTs577t3Yjw0QQg
X-ME-Proxy: <xmx:ArOGahYFlams1pioAxPcmaGtXmCL37mT3CkcJ5qIC8ujTOMnpdettA>
    <xmx:ArOGah0kjoj4Be4f2EzHhKKz7rYhNziZycSwRB532uAS1grhx3Sjtw>
    <xmx:ArOGaji8SZghHwL9xosllcJJrLTpCPgxGy6tfFX4ingRpEc6jraF2w>
    <xmx:ArOGalaHCrIycoRbL0N9bAvQgqxexTqoQnkgc84BrHWcO2jftBONhA>
    <xmx:ArOGai33y9XwobXV3HXd3ZvMqAsdyIZVtPFx4UoysDGYYVeWeVSCGFq6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 03:55:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb10944c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 07:55:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Aug 2026 09:55:28 +0200
Subject: [PATCH v3 4/6] builtin/bundle: refactor option handling for
 progress meter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-pks-odb-generate-pack-v3-4-bc42252f6169@pks.im>
References: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
In-Reply-To: <20260820-b4-pks-odb-generate-pack-v3-0-bc42252f6169@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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


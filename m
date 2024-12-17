Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA1DE4E0
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417864; cv=none; b=utVuMkiJgdB75oQQgK2tvGPUwYpGYvFKakFR9PtE+baXK1ipNApGjlVFM4HcJ3/Nh+NTtibF0s48KDbjYod4RTRr7ZI+utj2g9rq0nCsPAFNHwGN0/JkxZ+9epxczAK00WlM4+vq3exTnOP64d+VYwQ/CpfNc0dZkEws7n+qcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417864; c=relaxed/simple;
	bh=47aSxVoIutZXMrcbPFA5dStludiXF4gh1oK5iqhB+AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YI7zp2pM63qxE2GfxtC8/xBxmfn1+cP73V+rq1On+W2AKqYmgfj8PQH18Vxi9SKfKazlrB7HGX0gsSug+wTl8RetLRGhgfh2l3kjDxwJkg4Ra3e4e+G87aUVFfdGwtgArqVpoFz/GYz140harAfZwEpMDWI7mDtP5rHcJ5RBhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FPc67ZZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=44YM1NM5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FPc67ZZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="44YM1NM5"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C2D9D1140225
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Dec 2024 01:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417861;
	 x=1734504261; bh=SSqfIi1TsrqjNU5KXXeQIIr2h/24e3zsqWkRRTgGI58=; b=
	FPc67ZZowZ9hEcQK+G/Qvr+MHq+8pwhYR/y9CpWX8dy2fisNG/I0IpzUzRz3mQJB
	0ZY1V8pds4cOVWSw7Zc9gqCqaO7Nh1l6XKMbf9vDQalIxwu75CU/f2TjB+GSqGOf
	uTHTL5qDQ/9Nv9WfPmrDGd+WrVjDY5zkUi08TeDnH8jMIq7hfutbhVjnGYzHwEn7
	YThLLUT4Mef3BDYFHf9pPewlYeKCZWDbGS2x7bdaHbjLSsyW0Ewjpko9hwn+HXNJ
	bJ+69zzPm5G2H9cHSEyXETwSiurTUd/nZv3SAoXl8B7G0PHeXMaNJx1FiGorQj1c
	MXgTo/OkIU0eA9aNvhafcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417861; x=
	1734504261; bh=SSqfIi1TsrqjNU5KXXeQIIr2h/24e3zsqWkRRTgGI58=; b=4
	4YM1NM5kbfUsQpwmDl5kzGWAsIKrRarVrgo+mXG86P+1yA8dLFAfWdu0tqrfOzm2
	KkWGpoc2lK1zzYywfZnHuF1KIbQZflBb+jUA/xxeL0kJxwe4xUS+oSKt4Hqkazne
	CDW+QCUfQejT3FTU2JsT0f/jecVLiaU/qed4BHWJfaxExsdQlM9FSNF9dXhhpe9V
	SsYdf3knRMaMJ4j3ynp3c6ZhYNW9nr+OOsaeZIcks4lnbw+DlL/Y0pKf5qorrMUL
	wahjE4XjHuhaH3rSIlkVhKtJl2ctxp6v3vq3V9r9kfCSQxpoJXFrlgSdFJynG4lZ
	Zgot4aL0B5Tuxi9OpHMoA==
X-ME-Sender: <xms:xR1hZ5fMvB14V0ipqi71-0e-cxYrA_cXwUxSR7EFOy0rnD-7Dsjizw>
    <xme:xR1hZ3PiXB40Dk-a9nXxegJHu2n0WFcEVjJqOracAoiGd6D7QJfxm5XNNJ2x2hdBl
    bNL1eSPZK9lHMB2Nw>
X-ME-Received: <xmr:xR1hZygVZNT6zsni-wuEztCbHq9pfjMzGpIsjGcleGFFVtjIQlULU0JcYmhgUL-hq2sU4Cagb1wmE3thSwChB9r1cQz7kY5Z6XtNahrFGDhTxbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xR1hZy9eYs8_ob-EHcNsHZTU7vV2DmOCOFa4c1FbgwFs7XVavRBWdg>
    <xmx:xR1hZ1sYGH_jM9mjeDvb9xQLqNYHj07RBJoumiSLSoxWEI43IVApFw>
    <xmx:xR1hZxG97qH0wPj0skK1_gEKQ5X_YdeV9stZCGAwGegYA7kxUBR8BA>
    <xmx:xR1hZ8NXzezlhqs9BzyKa3xAWApZrS2S6d7PJ7R8eggic9Blax4lAw>
    <xmx:xR1hZ2VgT73ytn-pQzb5QBwr5eZ8dnSFkwcsHF3lSSD4itE9Dlb96gw6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e481d75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:55 +0100
Subject: [PATCH 08/14] mailinfo: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-8-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "mailinfo" subsystem by passing in
a repository when setting up the mailinfo structure.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c       | 2 +-
 builtin/mailinfo.c | 2 +-
 mailinfo.c         | 5 ++---
 mailinfo.h         | 4 +++-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 27ccca8341feefcda5e1c4a850f14fce9e4deecb..e94d08e04b2387b6d45053e17c78c93038fa9531 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1211,7 +1211,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	int ret = 0;
 	struct mailinfo mi;
 
-	setup_mailinfo(&mi);
+	setup_mailinfo(the_repository, &mi);
 
 	if (state->utf8)
 		mi.metainfo_charset = get_commit_output_encoding();
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index e17dec27b1df69c1e2a1020f245dd99c0973eaad..8de7ba7de1d6aadc610adec11e7394f7b1f538b9 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -83,7 +83,7 @@ int cmd_mailinfo(int argc,
 		OPT_END()
 	};
 
-	setup_mailinfo(&mi);
+	setup_mailinfo(the_repository, &mi);
 	meta_charset.policy = CHARSET_DEFAULT;
 
 	argc = parse_options(argc, argv, prefix, options, mailinfo_usage, 0);
diff --git a/mailinfo.c b/mailinfo.c
index aa263bf490881daa915a03a681c00979f138d09b..7b001fa5dbd685cbe2b51c880e961e68461bef31 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -1269,7 +1268,7 @@ static int git_mailinfo_config(const char *var, const char *value,
 	return 0;
 }
 
-void setup_mailinfo(struct mailinfo *mi)
+void setup_mailinfo(struct repository *r, struct mailinfo *mi)
 {
 	memset(mi, 0, sizeof(*mi));
 	strbuf_init(&mi->name, 0);
@@ -1281,7 +1280,7 @@ void setup_mailinfo(struct mailinfo *mi)
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
-	git_config(git_mailinfo_config, mi);
+	repo_config(r, git_mailinfo_config, mi);
 }
 
 void clear_mailinfo(struct mailinfo *mi)
diff --git a/mailinfo.h b/mailinfo.h
index f2ffd0349e8007256f5b2118d41faf35a53edf0d..1f2066416578ace2fe6798e543959da43d718a5d 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -5,6 +5,8 @@
 
 #define MAX_BOUNDARIES 5
 
+struct repository;
+
 enum quoted_cr_action {
 	quoted_cr_unset = -1,
 	quoted_cr_nowarn,
@@ -49,7 +51,7 @@ struct mailinfo {
 };
 
 int mailinfo_parse_quoted_cr_action(const char *actionstr, int *action);
-void setup_mailinfo(struct mailinfo *);
+void setup_mailinfo(struct repository *r, struct mailinfo *);
 int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 void clear_mailinfo(struct mailinfo *);
 

-- 
2.48.0.rc0.184.g0fc57dec57.dirty


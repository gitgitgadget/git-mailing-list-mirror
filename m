Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7EB478E36
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184353; cv=none; b=tsrdM2B8QuHP13r8wlmpFNz4JScoHMTYtH0bOJ8tW4aHMiNnR5qUb5ZUGfPPJlz09SO80FHI/o57AJy4My/jfRYYFRn+ChqJj+ThqRSOyndoV+TVzlheJWsj6tBltRdI79kMLgcF2ueq/uwE6PAnPQiluh9lXa+c4AjzLJpB+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184353; c=relaxed/simple;
	bh=SCSwPBjEc1UPeG+yp1H4P2zzxUf7wabtyk4DOcEeCng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJK903kueDSRijXDlLZywIcGBMOcP5drcDdPaLPDQG2GBoiVDyoj+S4SgENBlHD6+2M1WvSKRWNynJYUter8PXW8t02rIuusay8fjYBcFTBbyEhjC5y34IBN9Ksz1MBodAAv/ljKGc0l1H+f7SQs1E4SXKL56eKHZuwZI1UB9KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aS5xeLG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+cQpGqI; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aS5xeLG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+cQpGqI"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 112EE1D0009E;
	Tue, 19 May 2026 05:52:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 19 May 2026 05:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184348;
	 x=1779270748; bh=5z3SlYXgqVUwWOrDysQn5x9FO+KUgyT+M2cd8n3029M=; b=
	aS5xeLG6w78/FQ4v63RXcpmk0a3bmb9ABgJ2vosxoG/YL41pG2ivPUo0PBkrs0tO
	3NYbOAAA+NhzuyRW3R/7pR4pFAzeROTp3ONO5CiHAQ+uDLnhH8pT/06UoTUsa6pt
	DkpsDnfyQ3nS/Q6ej5hTH+8Ga+88B5rIUcVrBFW2PUWR1NzvZHSjZuMKxaeELYHX
	vMW4h0SSv2vpQpv6fkGhRJWSEP5AolT03uxqIyni7WrPlY3YuFzqxqN2knjn0ynN
	dptZr0N/OysDvXWtm04NHSh0+Nav5djOUDsCbFMwEVm7Es0GR6chRlYmvSNl0DD+
	QixlB1CsV8r74z3lxYbmcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184348; x=
	1779270748; bh=5z3SlYXgqVUwWOrDysQn5x9FO+KUgyT+M2cd8n3029M=; b=m
	+cQpGqIL7SWaSrn/eQmDVYfWrO9rUY1oiZRnb3OgByjJwhEwoM5IdAGIdXQmy2h1
	r89WXFtCOXoQVD8Fw81ew0jAvHnoVpAVWeQ3ZaOgJ5EiRATW6a3HohKo5MMTuaMj
	ajqKT+4VLeuxqpltUui6/GCQ2XYGCofhXzhgSDwoljrsnKvEDlmLHmKN9TvV5HOO
	aVWlEeD+6JFJrjZKMFPesFiL20+cz3ONjdgYjEbhYexQjj5JXfEzaRsLELeCxbTO
	qPLvYWYMaal/pPDS1qgVlpAEpV7Lwi49xKa3LMrk6yZ1W1MUTRaqWiSWsOYyWAsJ
	fG0oLnrw9ui3mhd/VOSvg==
X-ME-Sender: <xms:3DIMag9W58L8QPJCfDv8lHiJDxcHH6eLXQ3Q_BjipYzyX7vLxshTtA>
    <xme:3DIMavkE0kaDvb-dTITuFPV0x70WB7m2nTAHyCVe3z_xpqZh-QCrpMXlIs17vVVWa
    r5bHmOxX8BMknh5xcfHc7_RyNQMEV2xe5GTMsSQdn35yNcX3B9wEvM>
X-ME-Received: <xmr:3DIMauVmgv6tZlaNY6nwtrGQSnkkCm5WHiV18p8B2HSBJ1Mo6jysKSm1fLLvTVCRXL5I7CjmeqYU4lBJZ0it6t5XrXOPuN2gIg4RzzFvpas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3DIMasG3tHwXbbKY4wLpwXoc3_dWSv87eKBCqRMJhzrJcXbYtkEvpA>
    <xmx:3DIMaidgC2_wBSKbKpPIUvyvAIL0jl_4EUdrpfioQmTu0d5n85GrHQ>
    <xmx:3DIMalJUK_r3I84IYZHpyDJWizNgWtn2VH_2uZ0_SYwNcYaHJhC4VA>
    <xmx:3DIMavHaBaBpjOPTP6DoCVzq1X-TutSQzuaixgclfZIb6ZrYJju-xA>
    <xmx:3DIMao1Kulr3TKfwRbwJrfq07afOt20PnwCgz_IrqSXzxXGSCnuBKsK5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c228a199 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:10 +0200
Subject: [PATCH v3 06/18] setup: stop using `the_repository` in
 `verify_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-6-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `verify_filename()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c      | 2 +-
 builtin/reset.c     | 2 +-
 builtin/rev-parse.c | 4 ++--
 revision.c          | 2 +-
 setup.c             | 5 +++--
 setup.h             | 3 ++-
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index e33285e5e6..b0e350cf89 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1163,7 +1163,7 @@ int cmd_grep(int argc,
 	if (!seen_dashdash) {
 		int j;
 		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j], j == i && allow_revs);
+			verify_filename(the_repository, prefix, argv[j], j == i && allow_revs);
 	}
 
 	parse_pathspec(&pathspec, 0,
diff --git a/builtin/reset.c b/builtin/reset.c
index 3590be57a5..1ac374d31b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -285,7 +285,7 @@ static void parse_args(struct pathspec *pathspec,
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
-			verify_filename(prefix, argv[0], 1);
+			verify_filename(the_repository, prefix, argv[0], 1);
 		}
 	}
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2fcd6851d1..8fdb75413d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -749,7 +749,7 @@ int cmd_rev_parse(int argc,
 
 		if (as_is) {
 			if (show_file(arg, output_prefix) && as_is < 2)
-				verify_filename(prefix, arg, 0);
+				verify_filename(the_repository, prefix, arg, 0);
 			continue;
 		}
 
@@ -1173,7 +1173,7 @@ int cmd_rev_parse(int argc,
 		as_is = 1;
 		if (!show_file(arg, output_prefix))
 			continue;
-		verify_filename(prefix, arg, 1);
+		verify_filename(the_repository, prefix, arg, 1);
 	}
 	strbuf_release(&buf);
 	if (verify) {
diff --git a/revision.c b/revision.c
index 599b3a66c3..5d53244379 100644
--- a/revision.c
+++ b/revision.c
@@ -3067,7 +3067,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			 * but the latter we have checked in the main loop.
 			 */
 			for (j = i; j < argc; j++)
-				verify_filename(revs->prefix, argv[j], j == i);
+				verify_filename(the_repository, revs->prefix, argv[j], j == i);
 
 			strvec_pushv(&prune_data, argv + i);
 			break;
diff --git a/setup.c b/setup.c
index 4ef6216e82..e673663cab 100644
--- a/setup.c
+++ b/setup.c
@@ -280,7 +280,8 @@ static int looks_like_pathspec(const char *arg)
  * diagnose_misspelt_rev == 0 for the next ones (because we already
  * saw a filename, there's not ambiguity anymore).
  */
-void verify_filename(const char *prefix,
+void verify_filename(struct repository *repo,
+		     const char *prefix,
 		     const char *arg,
 		     int diagnose_misspelt_rev)
 {
@@ -288,7 +289,7 @@ void verify_filename(const char *prefix,
 		die(_("option '%s' must come before non-option arguments"), arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
-	die_verify_filename(the_repository, prefix, arg, diagnose_misspelt_rev);
+	die_verify_filename(repo, prefix, arg, diagnose_misspelt_rev);
 }
 
 /*
diff --git a/setup.h b/setup.h
index c3247d7fc8..24a6f66629 100644
--- a/setup.h
+++ b/setup.h
@@ -142,7 +142,8 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 char *prefix_path_gently(struct repository *repo, const char *prefix, int len, int *remaining, const char *path);
 
 int check_filename(const char *prefix, const char *name);
-void verify_filename(const char *prefix,
+void verify_filename(struct repository *repo,
+		     const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);

-- 
2.54.0.771.g3ed373ac14.dirty


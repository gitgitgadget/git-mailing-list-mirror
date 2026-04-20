Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86A388E42
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673384; cv=none; b=WM/REcK5mPD0aiccAXnqzrIlCucGN8GgUBv1F5Ovb1yAqzAQvcTsH4+KGDKRCb76CDJFGpvbenK0DjHpgEp7+tDgff6QdJt9Esh06MWr4ZKDpow131Xc4Zwo3aabyfZC3mr3+JPl7pPLKUoj+e/zN+Fnu6CNcFO82tn31l59Uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673384; c=relaxed/simple;
	bh=yYzTaDTIieL04U+GIlzpJuFpxws7kJYkUPgL1nJjPzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxkVqpKLKqa+8VZorzekcT0gQJBQZKwGaRASgzrYU2wUAMCTJ5Z6RJ6+gVE4LQpsTmMkL93gj4SOvygzKIvY/kokjysQ38AeomZuUhn0G6Ctpd/Mj+YXeX9PnXJCPdRrK8ocRgV5ebMe7vAw7HpwHzF8Ti/EkwwEsUPaJm2GWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t6lWmxL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ulnQxdVh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t6lWmxL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ulnQxdVh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A4AC1140011C;
	Mon, 20 Apr 2026 04:23:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 04:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673381;
	 x=1776759781; bh=LJIEAtE22ZdumHdEC3GZspG6P04VKmGz+WYMAAAQNxY=; b=
	t6lWmxL7G0+V8aAO9KavD4m7g5AE/xgiICI9OdOLdkJeYPPRNmk6K0mGx+30Rgwz
	csyVfu+YoAdT1LZlkaWR9b72TJceuG3eyis2BWye/tbHB5roat3TXrI2egqFqTid
	YlZI59y9BObsRBVMh/AGV/gq4q/mjh3PW7CMI5dVYGXoWd5/5Z3JqmcSuvoFxAfA
	+1QhycTWexavJPtGpu04gwh9tUeXmViXN5YUWJGrQtnuJmqwYaX5NTuL5VQG1UTI
	G4VqDyi1oNMjej2QOHF6sikAPARqWKnAEfvnJAVqsubzp+YgeQh0UBQVdsiV0htQ
	5KqL2beSQn9axfXVqWWOzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673381; x=
	1776759781; bh=LJIEAtE22ZdumHdEC3GZspG6P04VKmGz+WYMAAAQNxY=; b=u
	lnQxdVh6b3Qi6cclzVNQCibyaTCb6MBV7jvEWxHhzTFyCIxjL2BiBhEhBUjZuZmZ
	mXuxtlq0S3S148/gl6rN1berUymFcZQNF5/0S7qMNhuqfd8LmsB4OigiP9X91Bmq
	LpYhGkfVQGkJjlxANVa5V35uvBGA4xd096XfDIYjiy2hTbOHvS5dimyFVCAroa2b
	75h73Ztyhm2alp8U8/2bFJSuNcAum+vDIsWFxxuU7No4TmOG8HuJE+fMfKXRZ6S2
	sqsbNCXF2TIIkyg9pRbYovFGCXDSEot+eg9j4I7VUZXRAtPkpKRzJthO7SxUlk+Q
	hT1ArLMW1Ma2EFUAOsHMw==
X-ME-Sender: <xms:ZeLlaWSqnbxUhu_GmyttrBdyQJEaV8wM194hDgMnvpO-HDB8kDS2Wg>
    <xme:ZeLlaSwlliWSDU0IB920NMeTSbPrZ6MHek2VzrtwYZyWi_NIB2BaTLH2TN3qKEppE
    pGkQHdvrHrPBw3AsYiPwWlE4n4ximuf0K6-2-6xXHE1xl5Jv71uVDg>
X-ME-Received: <xmr:ZeLlaY1pzcAZw8U7thmSrxX5GAEVt_-qv385V8xGbzUOxTZkkDtOOnPHzXEJiWaInQtX_0e7bfRkhkMUzGFOFHt95PJOLhhPtKTICG3-022r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZeLlaQ6tZhF-u_FS4FMjDtt5F3SB8YmPu_ABp_RaS5K9S0zOGSyEqw>
    <xmx:ZeLlabV4WwK0x7GVpaL2S_p3SppWUHVw6a44EslzV073LLlfrXpdOQ>
    <xmx:ZeLlafBQ17ofeQZIITtJBzSokMain6kGFTmgpNG9wP96UrMgu_H0lg>
    <xmx:ZeLlaa4pkEVcrh7Lf3ORTF6hQdYexOSiIjV5WpkrCwMti347fSfU7w>
    <xmx:ZeLlaQUiEr-ktfC_E2gHm2kDyL06w0ku6TfZixE2VjY4CTf-3K7lxg-P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d6fe52a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:36 +0200
Subject: [PATCH 06/18] setup: stop using `the_repository` in
 `verify_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-6-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 6dd49ae3f4..d7c6400ddc 100644
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
index 31808e3df0..57cf00ae6b 100644
--- a/revision.c
+++ b/revision.c
@@ -3066,7 +3066,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			 * but the latter we have checked in the main loop.
 			 */
 			for (j = i; j < argc; j++)
-				verify_filename(revs->prefix, argv[j], j == i);
+				verify_filename(the_repository, revs->prefix, argv[j], j == i);
 
 			strvec_pushv(&prune_data, argv + i);
 			break;
diff --git a/setup.c b/setup.c
index 6cfb05c527..736f950bd0 100644
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
2.54.0.rc2.529.gd9106f7525.dirty


Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7283D3CEF
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876684; cv=none; b=a04uEp/nryWE7kiRkCyWEclcHJGKREga7vn/Gc2kVtjylYwb9hWx6knq6i4DZJfV4dSzFP3NKo6GB4AbE2TqrlD6CRTL/GKATXK5vPCFeaQiNQsU8hwqxCijcT4t/xFCYiiUFwvnL/7TPxyit3qh9lMyyXOUebQTxd5D5UxhaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876684; c=relaxed/simple;
	bh=Qr+LNHnlPGYUnQ3prE4eezwE6ub1rYLw/qCWM7KIlgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTrqW4ziyG741cr05+5meKNUBpoLn1hYXku8YXbirJGsv1NWlsyx07LrF4a8S3Q2zNntq0QMy9TTJM0eF/G0GdtpjRvzuemU2viJU08heruzzLBM2/TlY9hVehkzRMSRSn/p8b8AC35YI7mJifkb17nxXRkkZ6dq0Tceqqen5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DquFajKX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oIcFuKBf; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DquFajKX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oIcFuKBf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C07847A00CC
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 09:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876680;
	 x=1774963080; bh=acE4wbRJyJ22b7ESFQPrHB1a+FBCUhgGpCzZkCc5SFo=; b=
	DquFajKXoVbDTgoUfXeE7bYFTnzD9xoL358VBXwSh+F/+I/2tOmVzOnLxGaqWzHs
	XVJn1ja64OgUTULRsHGtO23p7UljnmgCv7Dl99uZXJh67UIp1W5fTQ6/+l1FGP6D
	/59DqTNQO1ZwORKVP9+tm+7jruwGr0jm3UmmecPMDyauuiPrIemaIBqc2ZTOPmAJ
	5ZlgyQ3Z2kXG7xQmNYsh8CqfoQYIXb5OOmOC9A+rKUozUTm5hFR9PL0QhKo33jSG
	DBQcGtJSOQtU2Phx/wWyH9CPrjbfYzyV4RRi9PG0Oil9ps2xoYnS4rxZuhS7eiZi
	w47hOg6AtOxCqaLYVl6NRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876680; x=
	1774963080; bh=acE4wbRJyJ22b7ESFQPrHB1a+FBCUhgGpCzZkCc5SFo=; b=o
	IcFuKBf3hkzoo69KAODRBNEEh+VEuFRvqq4zsKe/cF/j+HAuYsYk8yI+yYykysEw
	+CRTN6IgpWijX5m8Vl3r6u2lAWP83bifByuuL3qguAISPWFanTa2v/wf6+pxnyzn
	NnYiDf2tHt4NBSe3W99pqLJJtRMbiLu+pZqehNTkiF6kcrq4mmTM1o74HQofciJU
	igdLOkU7w7LpuUJ9GQCxCWL7ZIXvXbj2IzXUUYUVlSa2MctzYkc6erXS+AP5Je72
	tOc7Ern00zo7Gt7z9QUWprW94AY5hBImscYaJ7fv+F8AzgnV2qczwjoB9utzRNd0
	rrK0Iky7MOyMVm/b1nKqQ==
X-ME-Sender: <xms:CHjKaWxICqEnn_OzyrMaKePp-gxKRDfC_QigbZxAl18dRU2QqJwVUw>
    <xme:CHjKaZPyoeBkEjFHMGAI6dRAukRIw5khEF3F0tMCMT5AzgOGC-YaAFXdH-TgRnrtr
    -ZOONxYqHTwgw6d62V4gFDoCo23c7Hup5KZwvNTzU5OWjJs1HcR>
X-ME-Received: <xmr:CHjKad_FirruA7G_4ggeVrlTh8h356Mbbt8SN-2sSp6BJtxlkEDOY8QlH3S33UAkehixrG_i3_tWYNAUedlHwm5V1nMerTyqSwBJVL9sr--UKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:CHjKaRob5k4ttaIlO5cpT-gJuOnyMMqZVJTx0cSlHmieLvqoKe1NRQ>
    <xmx:CHjKaX7bb32Fus3BtPw80s5ehKWTYUxzOU00vCxnlkxwF5j8rn02Cw>
    <xmx:CHjKaZOVpkV-WIZfrml3vqqpBEYZ13mBbbenoynRUd50gRvOJaWrqg>
    <xmx:CHjKaRPL0r6mLxyVlt22izDFr-czN4LIAKJKgEeVgDLa-wVzZE23eQ>
    <xmx:CHjKaQxlXz68l8gjvfkk0gAg56sXs6JLdxz7QjrgrwnoPIR4ORqtB8Vv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6684db06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:28 +0200
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
Message-Id: <20260330-pks-setup-wo-the-repository-v1-6-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
2.53.0.1185.g05d4b7b318.dirty


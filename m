Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4A183CAD
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540439; cv=none; b=AZJ6fSHCWSl9CNejAPy/E88O0i23bx5tnjf/onYnnU1ZwjXLaPHjkmkxF5BsVY4/kvVRmtS5dcHPqktxJKv6tz+WyoKhTVC60vt8XHF8ppB7NlVmlCZX1HCZbmHs3QlLXSKpEtvSKGwQVW84lTL5x/LnPopkFm+Eiwplzpj4mOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540439; c=relaxed/simple;
	bh=zlvUGAPy4oWq3QSNpYQEr4743u+yqfkCgaAkMkPOXrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbxq6sdg1frwrBHtL09cc2k88C8DpiOdohhGS+drDZb9jqYkI5SsrEzHrFUGHAO2P8ctBFJWafOrn+yxappXoeUp6yHA0XVzuZ9nOpJXuBunHDyCA5InIFY46QwKOjGvgQYYS22LiX3VlRPMs41uw5pVO3w1pWvUwllWb5Zjjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pqg8Ctee; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pAzVU3gP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pqg8Ctee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pAzVU3gP"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0049B11519D0;
	Tue, 13 Aug 2024 05:13:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540436; x=1723626836; bh=51DSmygbhj
	1ayYq5ZCeWnbo0x7D+1+5hY2Qnjpph0oo=; b=Pqg8CteezqA98nHfOB9bk8t+mW
	LaTJIHA3IN4X+T55uxRxoKAzaG2TmSZv4Dtcig+5tEbgXEjyUl/rr2bMAp9yoNic
	D2BjxuPg9AVLGxNzr7ri+eYtSuvppoDviC0IqllJ9q27BTRlM3aHBIfY5sqDFSQE
	uRpl4xNhXW9it7Lz41BO5HxjX8X9rAdGIiUWmbzlbJKWNxWXpl40/xVI8Y9Lo2Wr
	l0zJtnUNWnyBFUCwZxYroP0TPIX+EsSGKJsfpuN7sLSXdYPY3vd8qTWu0bDdhCfe
	/WP/BsszVWEIlxmI65uK/7OGPaWrA7Cau7Ba1tidxoDnnql21E5EJ0qQka0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540436; x=1723626836; bh=51DSmygbhj1ayYq5ZCeWnbo0x7D+
	1+5hY2Qnjpph0oo=; b=pAzVU3gPH5jkgekC4sxUBrkCkEPmdB3itxbOSFbzFZnK
	57Z+9viu7UQbLqZ2k43CAVUBgL12fVohmHQxHY63dmm/YAQ7cBe79DK0RnL5IunV
	NzgzRNoCKu6fCyMwKp8tsQPkel/KnFJ5eYLqfzF1eqTtrXwU2flEd+qzJbktlxUQ
	yoLjXAjzyf6mpUMgTWqj3BCSG+An+PCJmTcns7GxlxdiTey5WQ/3yCspDpC133G9
	urbLJ/O/e5mD2DDcpgZei9mAXafXOB8FlGdGJsxDxG5COZp/I4LBRC6T1zhLVtbN
	poRXJV+mWkan5y3bO8N//YlcL1WQsT8+XItPhHhWAg==
X-ME-Sender: <xms:1CO7ZpdQ3xXs6-vb-BCbdWBaqKW_vP03gbfbOnbPjBMhj0dcKXvUVA>
    <xme:1CO7ZnMWp3c1j677qyux5X9zlmTQC2g4s2xd6-2FdWt7QTdihgpR9hOjwKRAa0OEw
    XZKhqbiuJNIH9cWog>
X-ME-Received: <xmr:1CO7Zig5tHMWg4w-yJJOzK0sSaGAF5ygGVT-ZKBAXTqo4ViK7X_kSoyB_6Jc3Z-l3K1fLu7i9dUO-ZNzG4gIbMBS2wy9GltllZspt5q2gDoeQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1CO7Zi-y2dQd15owXL_UEl6-5e6fLY2snBteKG-PTRmDnUtT1pFgxw>
    <xmx:1CO7ZlvcXnhmpvbzwggo1ckYJC2pFpZVgZ3NYLB-loiopKg5mtAK6w>
    <xmx:1CO7ZhExKAn5jTZKqZ7n9lSPheDNdLLlQeDvyk_-vuKTMqy1VjiA_A>
    <xmx:1CO7ZsO7e24h6QgQSge5blBfrSnAVf6SKH9C3Ld8ijhF0OYRNJL-hQ>
    <xmx:1CO7ZtJHxbCf-wCN3dm0OCyc9yRIxMKAW6rpuOyFaevE46s69L9N2-nf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0bea408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:39 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/20] config: pass repo to `git_config_get_split_index()`
Message-ID: <a88ed83b970eff7dedc55862f59ee4cbfccd623e.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

Refactor `git_config_get_split_index()` to accept a `struct repository`
such that we can get rid of the implicit dependency on `the_repository`.
Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-index.c | 4 ++--
 config.c               | 4 ++--
 config.h               | 2 +-
 read-cache.c           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d343416ae2..35a1f957ad 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1156,7 +1156,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	end_odb_transaction();
 
 	if (split_index > 0) {
-		if (git_config_get_split_index() == 0)
+		if (repo_config_get_split_index(the_repository) == 0)
 			warning(_("core.splitIndex is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable split index"));
@@ -1165,7 +1165,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		else
 			add_split_index(the_repository->index);
 	} else if (!split_index) {
-		if (git_config_get_split_index() == 1)
+		if (repo_config_get_split_index(the_repository) == 1)
 			warning(_("core.splitIndex is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable split index"));
diff --git a/config.c b/config.c
index 387c7282e9..89fb7ce6b1 100644
--- a/config.c
+++ b/config.c
@@ -2801,11 +2801,11 @@ int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestam
 	return -1; /* thing exists but cannot be parsed */
 }
 
-int git_config_get_split_index(void)
+int repo_config_get_split_index(struct repository *r)
 {
 	int val;
 
-	if (!git_config_get_maybe_bool("core.splitindex", &val))
+	if (!repo_config_get_maybe_bool(r, "core.splitindex", &val))
 		return val;
 
 	return -1; /* default value */
diff --git a/config.h b/config.h
index 3f68b30047..35cee9d4ca 100644
--- a/config.h
+++ b/config.h
@@ -711,7 +711,7 @@ int git_config_get_maybe_bool(const char *key, int *dest);
 int git_config_get_pathname(const char *key, char **dest);
 
 int repo_config_get_index_threads(struct repository *r, int *dest);
-int git_config_get_split_index(void);
+int repo_config_get_split_index(struct repository *r);
 int git_config_get_max_percent_split_change(void);
 
 /* This dies if the configured or default date is in the future */
diff --git a/read-cache.c b/read-cache.c
index ad09950153..12c2da5a8b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1945,7 +1945,7 @@ static void tweak_untracked_cache(struct index_state *istate)
 
 static void tweak_split_index(struct index_state *istate)
 {
-	switch (git_config_get_split_index()) {
+	switch (repo_config_get_split_index(the_repository)) {
 	case -1: /* unset: do nothing */
 		break;
 	case 0: /* false */
-- 
2.46.0.46.g406f326d27.dirty


Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D5186E5C
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540454; cv=none; b=dNXndTp4H5aDHCOxVW+U1wTdcCKy2gl1t63/MRU6lQFuVGjiXnm25gRON8AcHiCBuUC6B9JtZpUwjg02siwQHYzV8XPvC1dmoTEggbtTwMZt4Vdz/Z93DGEZ7h/YKd02LzBX7zRGRIBho80XCrBsW48pD5uM41jYzPuqjzAZDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540454; c=relaxed/simple;
	bh=CjJmXta6OcMagX60QqVuqo4FuxM4yGhTJYWk8W1ppfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/THdwN2vEbUnUUXZtTK1jf9jnAJv33pFYrsiClevFxKdjw1zMnBRDBc/XKXTCJVx1yVZX4f7SqTLP+t9nY+LlO1FCMyago2IlQlcaUdZJHb5P1a+j5fDfs1zTgkm3DYj6G2dBTSsLGjxMpyZMLoPd3TX57qS7zg6Thbt89drOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVj3LapI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SnvHn8UD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVj3LapI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SnvHn8UD"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9A356138F115;
	Tue, 13 Aug 2024 05:14:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540452; x=1723626852; bh=Dkzd5jsWtW
	K9l3CPcatWP9VXihDnz1pzbC4nawMZKdE=; b=iVj3LapIUimkfqc04aFr/gPaln
	9z+4MGXjD0lbweyheNGUD9jYMK+xLu8WWULqWxWadCBmxOODfs0s0kfaY4ea+0PI
	fYVpLIp5jgpMjSsnJMdkt85tMyJ/Jh3QZ62Yq2ZQg3Bj6FqP/jhbEXUBahQtqPxm
	UinI26Y8pzd55yHGDiVdfW1q3FYEikEwP0Z9lxQQNGYReqeVO61k3xENXCEMeVkM
	TTIWDrSogOcZCdbOHNYMqNTlSADb6mdfTp2ej0kofJiMQMXHdSy0EZ/FOziWWa6x
	4RsyhYFk5WxLg787s9VTXtMvBEJuLhIZCbTpUIfrbiWYd21tI7AI1oTIGWNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540452; x=1723626852; bh=Dkzd5jsWtWK9l3CPcatWP9VXihDn
	z1pzbC4nawMZKdE=; b=SnvHn8UDaIPr4W/DHyRQeMqCo+apVt/aW6x6SGD2G3D2
	nKXQ9Q2NK0TR1Ak70965jITazo+iMHCHs0Rwv3bj2OFHO6Wvk/yhgHWWHhGTMTp5
	jx0AaGewHg7D3fttvpAL8W27Z7e/2e89Ja3sYxw4SZKafXmKy4NJAPkww6J+ugPK
	jyPSOXoQW50yyW6RMfmHS448DyrBFvvk+Y9erJ/Zq9FoNyd4YIVnapW5+PCAHjD9
	+0387v53oye/WBHWtn9hA4TdsYfBCLZLzHFYeaRQ3/2F74luWlvlyd74+u9Auqjr
	2DI7wHa5TITfB4+sIeC0wHl6zZbX3UZCiAxpq9Q9Ew==
X-ME-Sender: <xms:5CO7ZoHOdRWbTZ9MHjGjJ2BHagtpwZmcb2JJSu-xhl0f-E8n3HB3SQ>
    <xme:5CO7ZhXvkn_dUigqFYA3Rh8qnx-ehTLV62aBcwTyw3WqNH9YJvOztUUYocTPkvYat
    bX5qKThk_vfsaMadA>
X-ME-Received: <xmr:5CO7ZiICGekI03YRoqpaghjnr4zV9_BClmTiXdrklBD1bDEerZ9hHPHFQECnwAZnoaRhP40KQYiAo1m6Nd_SQEZ7fFFjRK0owXKgXr_9cF6xQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5CO7ZqHgy28Q94tzXxhSiQ3eBsalXLCcNipQV9SSV9u_gOXDV9NCBg>
    <xmx:5CO7ZuUOT7QKIAGSB9o_14TEMG-ZHepSuYdcijmaqxoGBSsjxhaSlw>
    <xmx:5CO7ZtOxDZ8Cmi3o5FSajnx606Gexke84A_m-FQ1EDJB-7pgamOZVQ>
    <xmx:5CO7Zl3auWFOwFjPypnkM4wFl6ZeisLn3DP3qEWMiyjNDCYjBR4X9w>
    <xmx:5CO7ZtReXaj-10of-nVHV8X2YrWVVgOBgEgAOVNUuEQUhAyDvAw--3Us>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 858ad1d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:54 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/20] config: pass repo to `git_die_config()`
Message-ID: <6adee5633a7093f62c7b3041ae23afb528bb9452.1723540226.git.ps@pks.im>
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

Refactor `git_die_config()` to accept a `struct repository` such that we
can get rid of the implicit dependency on `the_repository`. Rename the
function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 ++--
 builtin/notes.c       |  2 +-
 config.c              | 12 ++++++------
 config.h              |  3 ++-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index d21c4053a7..0249503c70 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3481,8 +3481,8 @@ static void git_pack_config(void)
 	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
 		pack_idx_opts.version = indexversion_value;
 		if (pack_idx_opts.version > 2)
-			git_die_config("pack.indexversion",
-					"bad pack.indexVersion=%"PRIu32, pack_idx_opts.version);
+			git_die_config(the_repository, "pack.indexversion",
+				       "bad pack.indexVersion=%"PRIu32, pack_idx_opts.version);
 	}
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
diff --git a/builtin/notes.c b/builtin/notes.c
index d9c356e354..c0fa86d847 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -868,7 +868,7 @@ static int git_config_get_notes_strategy(const char *key,
 	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
-		git_die_config(key, _("unknown notes merge strategy %s"), value);
+		git_die_config(the_repository, key, _("unknown notes merge strategy %s"), value);
 
 	free(value);
 	return 0;
diff --git a/config.c b/config.c
index 33d9af29c8..e35fc90238 100644
--- a/config.c
+++ b/config.c
@@ -2611,7 +2611,7 @@ int repo_config_get_string(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_string(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
 
@@ -2622,7 +2622,7 @@ int repo_config_get_string_tmp(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_string_tmp(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
 
@@ -2668,7 +2668,7 @@ int repo_config_get_pathname(struct repository *repo,
 	git_config_check_init(repo);
 	ret = git_configset_get_pathname(repo->config, key, dest);
 	if (ret < 0)
-		git_die_config(key, NULL);
+		git_die_config(repo, key, NULL);
 	return ret;
 }
 
@@ -2774,7 +2774,7 @@ int repo_config_get_expiry(struct repository *r, const char *key, const char **o
 	if (strcmp(*output, "now")) {
 		timestamp_t now = approxidate("now");
 		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+			git_die_config(r, key, _("Invalid %s: '%s'"), key, *output);
 	}
 	return ret;
 }
@@ -2858,7 +2858,7 @@ void git_die_config_linenr(const char *key, const char *filename, int linenr)
 		    key, filename, linenr);
 }
 
-void git_die_config(const char *key, const char *err, ...)
+void git_die_config(struct repository *r, const char *key, const char *err, ...)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
@@ -2870,7 +2870,7 @@ void git_die_config(const char *key, const char *err, ...)
 		error_fn(err, params);
 		va_end(params);
 	}
-	if (git_config_get_value_multi(key, &values))
+	if (repo_config_get_value_multi(r, key, &values))
 		BUG("for key '%s' we must have a value to report on", key);
 	kv_info = values->items[values->nr - 1].util;
 	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
diff --git a/config.h b/config.h
index 3a5016afea..947307c591 100644
--- a/config.h
+++ b/config.h
@@ -726,7 +726,8 @@ int repo_config_get_expiry_in_days(struct repository *r, const char *key,
  * dies printing the line number and the file name of the highest priority
  * value for the configuration variable `key`.
  */
-NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+NORETURN void git_die_config(struct repository *r, const char *key, const char *err, ...)
+	__attribute__((format(printf, 3, 4)));
 
 /**
  * Helper function which formats the die error message according to the
-- 
2.46.0.46.g406f326d27.dirty


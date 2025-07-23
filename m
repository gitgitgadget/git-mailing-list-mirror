Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172A2F6F82
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279769; cv=none; b=i90bovs9MvGAsvrImr+B/RGZSKa+/xbUq5uh2bOZ6kCX/ODKlw8+GDkAdoUfaMR1x43qirORMaBDHzhelMG0AH2hO+7tTgmxOfrEsWSRJH7ygV4osLri2LMMu3uHbR9doNHvpuNkQjK26i0HzNpHGT+V6ijJUgrP/ec1gFKSn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279769; c=relaxed/simple;
	bh=L+aQeQckZOO79RJDry1xjg6vDAabpoD0s5niSLLnx/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9zIArEgNEdAHcDuwIFPaBzUbmvU1HE11hX+pIuQV+P7DrEWkIuxiH2rwydGWu9nb8fnWpVmjV+qv4KHLVxldTzTZn/98mWUoUoOj/ticBGpnC2xEK6STYqPhRYntisqYFLik/qKHitdWG8XoxfVAxyL7PAfng9wN5yHW2lFg8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ED+jn79d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ig+EYnUJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ED+jn79d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ig+EYnUJ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DDA87EC189E;
	Wed, 23 Jul 2025 10:09:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 10:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279766;
	 x=1753366166; bh=DtSzKojoe+XI0KshOJ8Qb15aQtaQodCVO/cEXfBIqik=; b=
	ED+jn79dxooIVupTMH3p/dNslop1ZPFvnMGTAA3l3yD5R8w47qAZ+46jUhR59gpw
	Rw3f6iS1KZeiEm574mvwVOvPMmZng77UVGqkX3nle3w/pIBwl6nyZUmR1cmsA9Jz
	AXLLL7kP7Q3Ij0VyKeeXTON6zkSbclSwOcF/YB6mamDkG/Lq06befsYuEUELJ8Kt
	CuWGNHgCJRMM4Dqi6KypvSKOXSFd9uEtw4m3HUhwCv6N06ctOpoxxDE5x5iuktvJ
	tjjXsb/d7QFxKrr5wTWXKMfXKMmBFTd0rCVNTWlYQjG/zI8Pi8+wHMQ6i/WWI4h2
	Gntm6qwlVgbFR1t0ESLijw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279766; x=
	1753366166; bh=DtSzKojoe+XI0KshOJ8Qb15aQtaQodCVO/cEXfBIqik=; b=I
	g+EYnUJrc87yjMOZAXGoq4gC9QO5J8THZJ3X5HtsoFj4zHbOAKtNzmOmAVgTOLjG
	NMxYTp9367K8ks/r/DGBImYPZu0RT0/npQsYuvwb+lq5EdPcZHaM7lcArQdsdF3R
	IBdZGmqDJ+3lIksWAPnnwrUcJx8BBNA3Tb9BAEK9OyJ054DSq4bjYt1gPSn5Sayg
	4qCCi/0M0O5YigrVMALI56U3ZtS3CcMzCw1mLY/jOs6MXGwkU8B1BAfn0gQ4vsMO
	IatfERQ8qZpCuV5X7qRFZD5jOxrpsb2xIL630nFfcFCfE4kz5BFqQHKLgVyzuPL8
	SgzfYPlh66LQwdi1v1gpQ==
X-ME-Sender: <xms:Fu2AaBAE6v-3cBLHrJuq0bg8VGhO9-ABWI-uUHwUhaCHsdeIA8k04Q>
    <xme:Fu2AaPsQUwlio04dcaSm7zEyrfxQWCgNbOPQe9lIeML8pppHr3Bus1C-vP4kZno5b
    eo1xhHvwQ2a8t456g>
X-ME-Received: <xmr:Fu2AaOYF3hJWVh6SFE6Z3ckEQOQZzSDuGS6fc87GzlFUu_u8j-MOPl8SW6E5hNvLZEpOhsNCmOddObObUJfsvLU0sCoOFueN6jQ95pDvalN->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Fu2AaKWko0_rFScT-guE1k9AJRR-uW-xOonl1Thz7wpUHMszNSlBJw>
    <xmx:Fu2AaK5DTWpJVHOTPjwLnlNXJ-TPfwv62DMKAgrL-4nk08g6aScMlA>
    <xmx:Fu2AaNjXsNGZcbA0t5fhuzEVphCijtCSJ5WHJ_RIhR4aXKJLrrFO3Q>
    <xmx:Fu2AaJfuKScmM87M6e2_hvMSig-Co8EgsY-SHHdkDl8RuqoqzUfFZw>
    <xmx:Fu2AaORRkGNI9UWnJRPwHbA-W2zlXeMQ2K8IqQvrXdJMUJzGPH8tq4jp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88b6aaaf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:39 +0200
Subject: [PATCH v2 18/21] config: drop `git_config_set_multivar()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-18-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_set_multivar()`.
All callsites are adjusted so that they use
`repo_config_set_multivar(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c |  4 ++--
 builtin/clone.c  |  2 +-
 builtin/remote.c | 20 ++++++++++----------
 config.h         |  7 -------
 4 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5de0691d18d..fa5ced452e5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -987,10 +987,10 @@ int cmd_branch(int argc,
 
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.merge", branch->name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_release(&buf);
 	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
 		const char *branch_name = argv[0];
diff --git a/builtin/clone.c b/builtin/clone.c
index 183297787cb..c990f398ef6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -822,7 +822,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 		/* Configure the remote */
 		if (value.len) {
 			strbuf_addf(&key, "remote.%s.fetch", remote_name);
-			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			repo_config_set_multivar(the_repository, key.buf, value.buf, "^$", 0);
 			strbuf_reset(&key);
 
 			if (option_mirror) {
diff --git a/builtin/remote.c b/builtin/remote.c
index dd340a33259..4c63a8bb576 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -132,7 +132,7 @@ static void add_branch(const char *key, const char *branchname,
 	else
 		strbuf_addf(tmp, "refs/heads/%s:refs/remotes/%s/%s",
 				branchname, remotename, branchname);
-	git_config_set_multivar(key, tmp->buf, "^$", 0);
+	repo_config_set_multivar(the_repository, key, tmp->buf, "^$", 0);
 }
 
 static const char mirror_advice[] =
@@ -634,15 +634,15 @@ static int migrate_file(struct remote *remote)
 
 	strbuf_addf(&buf, "remote.%s.url", remote->name);
 	for (i = 0; i < remote->url.nr; i++)
-		git_config_set_multivar(buf.buf, remote->url.v[i], "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->url.v[i], "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push.nr; i++)
-		git_config_set_multivar(buf.buf, remote->push.items[i].raw, "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->push.items[i].raw, "^$", 0);
 	strbuf_reset(&buf);
 	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch.nr; i++)
-		git_config_set_multivar(buf.buf, remote->fetch.items[i].raw, "^$", 0);
+		repo_config_set_multivar(the_repository, buf.buf, remote->fetch.items[i].raw, "^$", 0);
 #ifndef WITH_BREAKING_CHANGES
 	if (remote->origin == REMOTE_REMOTES)
 		unlink_or_warn(repo_git_path_replace(the_repository, &buf,
@@ -771,7 +771,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 	if (oldremote->fetch.nr) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
-		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old_name);
 		for (i = 0; i < oldremote->fetch.nr; i++) {
 			char *ptr;
@@ -791,7 +791,7 @@ static int mv(int argc, const char **argv, const char *prefix,
 					  "\tPlease update the configuration manually if necessary."),
 					buf2.buf);
 
-			git_config_set_multivar(buf.buf, buf2.buf, "^$", 0);
+			repo_config_set_multivar(the_repository, buf.buf, buf2.buf, "^$", 0);
 		}
 	}
 
@@ -1790,7 +1790,7 @@ static int set_url(int argc, const char **argv, const char *prefix,
 	/* Special cases that add new entry. */
 	if ((!oldurl && !delete_mode) || add_mode) {
 		if (add_mode)
-			git_config_set_multivar(name_buf.buf, newurl,
+			repo_config_set_multivar(the_repository, name_buf.buf, newurl,
 						       "^$", 0);
 		else
 			repo_config_set(the_repository, name_buf.buf, newurl);
@@ -1814,10 +1814,10 @@ static int set_url(int argc, const char **argv, const char *prefix,
 	regfree(&old_regex);
 
 	if (!delete_mode)
-		git_config_set_multivar(name_buf.buf, newurl, oldurl, 0);
+		repo_config_set_multivar(the_repository, name_buf.buf, newurl, oldurl, 0);
 	else
-		git_config_set_multivar(name_buf.buf, NULL, oldurl,
-					CONFIG_FLAGS_MULTI_REPLACE);
+		repo_config_set_multivar(the_repository, name_buf.buf, NULL, oldurl,
+					 CONFIG_FLAGS_MULTI_REPLACE);
 out:
 	strbuf_release(&name_buf);
 	return 0;
diff --git a/config.h b/config.h
index a90b814292c..61774f17db3 100644
--- a/config.h
+++ b/config.h
@@ -744,13 +744,6 @@ static inline void git_config_set_multivar_in_file(
 	repo_config_set_multivar_in_file(the_repository, config_filename,
 					 key, value, value_pattern, flags);
 }
-
-static inline void git_config_set_multivar(const char *key, const char *value,
-			     const char *value_pattern, unsigned flags)
-{
-	repo_config_set_multivar(the_repository, key, value,
-				 value_pattern, flags);
-}
 # endif /* USE_THE_REPOSITORY_VARIABLE */
 
 #endif /* CONFIG_H */

-- 
2.50.1.552.g942d659e1b.dirty


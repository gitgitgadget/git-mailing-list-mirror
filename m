Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D153D565D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876703; cv=none; b=aZJwHLSAxif6fYYdpfMW1Lptnc9uhRAiUQ0qjKcX6oRRtvQ+p6iuCWcMLlAL+Um2XbmWhIJlSxx8m+sK5ljxqtpD+MdutC255SUHyFmGOIshIA8mGHFJb5FVM0Y7F1YWeavC9HIq46GJUPm2SnMKhigB1mh2Tb7LlF3XAxB4L60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876703; c=relaxed/simple;
	bh=+lSrtzx/YJozA2AGciZ3JJf0Iz5FLkTFC1YYWBeMIRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALrRDkZTdCqvKEIdYA0iku98gmxYLITC2PJjgubfJZeCdSK4D9+Rw88qtWwEfwkRNrIvPfxdbDiqyDdc7+kuUGQN1AlTTkcnp/Fo3amj7swowXlIu0127QuOUlcHkVFnev+stCEvEfS+R+HnOd8UlYSNKLlJn32QVmxbBcqScN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VM9jhmdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5NLtN8Ud; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VM9jhmdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5NLtN8Ud"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 901A67A009F
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Mar 2026 09:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876701;
	 x=1774963101; bh=uOS7gxTz5rixLg+uhqqmBJdXQl+2jNRD34MLe+G9TX0=; b=
	VM9jhmdAeHiQDUs+Rqs/ZfLoL1KZzcDQ7EexFHM0vdbK5mv/SDUVyBlTdUZbJRG2
	YlFZ6sKWpC0a/nZ4rzMOLLN15oCrCioGIcSFCPO35aXErd+QGmse0OeeEkydwZi4
	mHZbTlZDoEZltc8DUKZtE+0ctf54+lkV52a7J0+xUOBsSbrzYOxZZCcMdja+z90u
	HenZemgk5u0nLnJ9HDXE6HfW5DsjQMISbBHvKA3V08LI6fwO6C6LsrtuBivJIiKP
	+pGoK1d9L6o3q3n9wY2+lRnI+m6kXpdoKLpx66UCeuv2IcXtduEKl57jIPmV3xFU
	top2dsJFwsAGURZfnstrVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876701; x=
	1774963101; bh=uOS7gxTz5rixLg+uhqqmBJdXQl+2jNRD34MLe+G9TX0=; b=5
	NLtN8UdiKBVfPUFOCZw9NBX5gfqEKS7/q/YGgMSRyBkwU9RMmFweT6+YfUB8ny5d
	G08eNoTAbwtiuSCYXToIQUyln89w+3Rd0MyVPGOmmV0o1CvudsVTcv+jrghSAlN6
	Xph9kCxC3LrqGO0Gn0jZhMqGJtGvEM/lJybvCmeUvuM8v8SAwAyTGbr2aKodtDPx
	0u9StllDgrnmmJ8017PNRSGW53sYgz5pRLVojMgMVnNphVduKvEOK/76DZCSKFEe
	HkUcZq9cJbDdEvMf0L5OnUZq5aI0WzEm5NB1lfk7FLBCHmT6xkEYkMl8WE+fHKjO
	87FPUO0yNvUDA8IuoYEJQ==
X-ME-Sender: <xms:HXjKaRco5rRycx2j89GJHaRjOc2pSH8dzTNFC7KpjsUTx_hm5Gd3CQ>
    <xme:HXjKaWLQ11vjZ0o9oE1evikhEtT4H-j7G_0qJEBykx0SmWbqx7rEZN_rC9n9nUB47
    ypPoSOF4mU4mP2ZJk6lE3_ZKArlXvPKkPDd766CpX77OwaPZ2CUXyc>
X-ME-Received: <xmr:HXjKaQIxlpKPSQ-BH1qBPoz9wVkL_VqPWlUZYrfKZ-2AR_QRsVLg9dHAX1eGK9jX8H4Sy9sV5MsN5gWh8bra4VrUEJ9BLy7stgJThlclLqX68w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:HXjKaQErSKxx39BakxcRp7m3K2Yhs3pKitQFJsbkhyECTbpJNO27CQ>
    <xmx:HXjKadkqblVgsh-1phzzneeLMfdx4Er8wMwulY9w-vmUcndag0wRdQ>
    <xmx:HXjKaVIhHsqGKYdYSmlcQWqFz8YSD63g9Eonyv3bK2puUU36P9XgGw>
    <xmx:HXjKaWblWgNiX0Xkrz7eKDcY9TWEUq-ZJY_GHsjjGj25i_RIpM78cA>
    <xmx:HXjKabM8EY0OEK_repDKcleqrgoAKu2POqRW6mI6cvhWm4Pslc6t-POw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5f7b1c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:36 +0200
Subject: [PATCH 14/18] setup: stop using `the_repository` in
 `upgrade_repository_format()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-14-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `upgrade_repository_format()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects-filter-options.c | 2 +-
 repository.h                  | 2 +-
 setup.c                       | 6 +++---
 worktree.c                    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index cef67e5919..bc5d98f9e6 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -378,7 +378,7 @@ void partial_clone_register(
 			 */
 			return;
 	} else {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
diff --git a/repository.h b/repository.h
index 7ae3d34484..bb83d03bbf 100644
--- a/repository.h
+++ b/repository.h
@@ -271,6 +271,6 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
  */
-int upgrade_repository_format(int target_version);
+int upgrade_repository_format(struct repository *repo, int target_version);
 
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index da0576d28a..6dbd096f20 100644
--- a/setup.c
+++ b/setup.c
@@ -808,7 +808,7 @@ static int check_repository_format_gently(struct repository *repo,
 	return 0;
 }
 
-int upgrade_repository_format(int target_version)
+int upgrade_repository_format(struct repository *repo, int target_version)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -816,7 +816,7 @@ int upgrade_repository_format(int target_version)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	int ret;
 
-	repo_common_path_append(the_repository, &sb, "config");
+	repo_common_path_append(repo, &sb, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -838,7 +838,7 @@ int upgrade_repository_format(int target_version)
 	}
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	repo_config_set(the_repository, "core.repositoryformatversion", repo_version.buf);
+	repo_config_set(repo, "core.repositoryformatversion", repo_version.buf);
 
 	ret = 1;
 
diff --git a/worktree.c b/worktree.c
index 56732f8f33..8ca0a172c6 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1104,7 +1104,7 @@ void write_worktree_linking_files(const char *dotgit, const char *gitdir,
 	strbuf_realpath(&repo, repo.buf, 1);
 
 	if (use_relative_paths && !the_repository->repository_format_relative_worktrees) {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support relative worktrees"));
 		if (repo_config_set_gently(the_repository, "extensions.relativeWorktrees", "true"))
 			die(_("unable to set extensions.relativeWorktrees setting"));

-- 
2.53.0.1185.g05d4b7b318.dirty


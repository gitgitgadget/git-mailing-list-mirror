Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CDE38839C
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673411; cv=none; b=elaWFYZa5j8bd3edCY2MRhv4WsJ/3u976IjrczXTJBG219qmLHOSZ1A9Yqf0HTBDwYGPmlRhVmyl8PBju7/bNbiX0PSZiHv9Bu1rZyFD/x33SHII36iMJ0wh/R0q29j7l4t+Aw9f/xErE6GkdrhgoES7s32wpD30EkT+OZwGOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673411; c=relaxed/simple;
	bh=qDl+CIzCS7lHns1dzzcNaUOYj/w+vrGmPRfR3VVfLVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bego3SVrMpJUjKYmFblxb+WX5gYbRZ5pY0hV/cWFj0V3SgvAM980uc+YqjTVKtH3VsgQosH58Gje88e8//7uP7ZZ8PENyU4VqetqiEaDNqFNt6bD4/rzWYx8RvQ92slLHLwit3ZzZauT4ELulBaYHmGjl/c+dolXsVQ6q+kCNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M2oZxLF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKLF4jRV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M2oZxLF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKLF4jRV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7FA94140008F;
	Mon, 20 Apr 2026 04:23:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 04:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673409;
	 x=1776759809; bh=edHwz3eKnajpuxvHDhglNp/pdYndiPJUMJ47VVwvVcY=; b=
	M2oZxLF139gsM3/VklrJzt7zdhp+t1RJIJh9BV4xXS/FFev6P0/5xXqWAwIMDGEb
	Pnv0Z8NrYkdt3U7feOiEn69M1E1XZ4p7nrOBs/HxTEb6UuZvYEG8yCtlUaqnt25K
	WK2Owp1xObScwjVy18HnTf2a+5roc1i9EQPlmcJJU0F4kT0w4Gxs713sSP+L2uLi
	C2sRjLxnSpbWWNilVc857/yi+q6BfzD9mVFy7ebvWfFmRW+J1mtWq52lII77oGoU
	w8bvaFOcCj1OekT0Kmg27rrWUgDkD6ooa3MOTdgzpyoP5DrDC/M6lOIBzB3D9nlM
	Hc6961InfuAQMBgmj0Xj/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673409; x=
	1776759809; bh=edHwz3eKnajpuxvHDhglNp/pdYndiPJUMJ47VVwvVcY=; b=u
	KLF4jRVGTHGBF1XdvjuGuqBIaL0xtV1p+W9rAnGmI1Va1Ta8f8MFk0e3OUnRBVea
	OrEBBsg0Nlcr/3g91F/fvyfkgLlFr7SQTO8o+DW5gTpIy4TrqV1FOyK6eucmNnf7
	b0TXKstFEgytwfDSKcMAjGpUNj4F0UPTfzuNvaRziR1muYa0KaP1cNYgzTydA9cr
	XKe+Htr221J3beS/ok2zEhf2sy3gDtvshGiU3+I9qwzSgp37byQx9GFOq6jJf9va
	WX8BqtVfXDC7VT0qH7bc8votBwta966W1DsQnsyrCWUyO++oTrocmOxRlZwzQQ+Y
	PSmg6hUvFnFoQ2Gk8mUGA==
X-ME-Sender: <xms:geLlac8fTIgkGIWji1VH3wqkMucW4NkE4fcWq0ZZFRW-mhhgVBYJsg>
    <xme:geLlabtFAKW23C9rujmxZM2OyjkWnUxTephiKQY4vFft7FYT83ht_rBpkuXXGsLk-
    yaxUn-Sp0T48-t_kZxZ4A38i2p0dshPFTtcKitsHw8iq3OWq7ynmA>
X-ME-Received: <xmr:geLlaXDAEWABDfAd1fsPCK5Et11kTqRhq_QQEcseTeTk1kEmYsIm-bmdgJ8nJBl4WYqKl5-2NLF9BYxXK9bKM0-XHwAx44bvvUupsJf68Ydy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:geLlabWd0zq4cPDTO4xWdy3dj353iBYtAT1GmicuOh6KOPLUF4-uoA>
    <xmx:geLladD55zFxjZIQ5N0-RIEnKSUZips9CJYnn8l1aB4sW95yWgkhnA>
    <xmx:geLlaW-LjKTyY7OA5B7e55dYfmi_7wX90xSeONI-mbdqHXNeGyliiA>
    <xmx:geLlacErXKlrZV0zBMzE4A8x7p14_DV2YTDQovXzFi65gHh2btxDwQ>
    <xmx:geLlaajSz_Na7zIC4hkR5-CFnuLuhfUPPjFe0d7x9j9E1KaKpZDQYpSL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6e160a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:44 +0200
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
Message-Id: <20260420-pks-setup-wo-the-repository-v1-14-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 4d4b43ab28..a4e294b096 100644
--- a/setup.c
+++ b/setup.c
@@ -802,7 +802,7 @@ static int check_repository_format_gently(struct repository *repo,
 	return 0;
 }
 
-int upgrade_repository_format(int target_version)
+int upgrade_repository_format(struct repository *repo, int target_version)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
@@ -810,7 +810,7 @@ int upgrade_repository_format(int target_version)
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 	int ret;
 
-	repo_common_path_append(the_repository, &sb, "config");
+	repo_common_path_append(repo, &sb, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -832,7 +832,7 @@ int upgrade_repository_format(int target_version)
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
2.54.0.rc2.529.gd9106f7525.dirty


Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDC3AE1A9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765686; cv=none; b=iD3ecs7xesdv+lEMRSP9Tia+cV9F6siK2t3qwUVVF0yEH+1YO9w5ktErXijFH2sbLg0gubQsCh3PpBItuLH6jzAOgPYex0VbVqgkSb8FBdcRRJiJoccLaCzJ4H1SHQYM34LU30t+kT2KiB6hGUy6tG90/a/LmFCag/P4F8lvcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765686; c=relaxed/simple;
	bh=HNu7zt7BgsH/f8S6wIAWOZ1N9A7O4LQBHPvr8dYkiiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjKohSW1bDKumguc22LTONQwT70bwPDDOC5Y0bg6MpZQfFKBDNrpDT4bAjBfJak5dxNT+nxwJamJGArTtdgYNQIxuRAqcYKWSwbte7cMyj4n1GAOJKJQvaH3FL3sDT2OoG96T+4v6e3qO5an0Z+Y32xo7pUtvDTk2Tss2qzbYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a8DpoM9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdUz12Ze; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a8DpoM9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdUz12Ze"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B31601D000EE;
	Thu, 18 Jun 2026 02:54:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765684;
	 x=1781852084; bh=4NL2pJH+6K3ZybwsIsyVG//FahB7NPQBk6IjSMFs/t0=; b=
	a8DpoM9v2KwLnUwnPvxoNPheubLXLOmY54f1cf/ZSkr4cJHwymuRC09IdOths1pQ
	3Fkp/6779N3I+fupbvp95JiCMR8OufJq+dNNeWHTBhWRlT1re4jRiIER8PWJjP+d
	PkI70O4ngaLVz2Du7eRlV+aUEY2U+XVoCk5xDjayIb3XUOgh9BXMQUUkOoHtgKP0
	9GoA40B3sTcodUc5dJzDI1iqmbcA/i6RKu3NuAzzpnLgfNXybxFGjRTkJ5i8Y4FC
	AOp6c/26KAyGkjoRyv8A/0K7Iaei+z09CEC+7+CxSS1odmQn2wi1xBlYiljtdxKe
	7ncOd0Ifkwg0k5BUcLGW7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765684; x=
	1781852084; bh=4NL2pJH+6K3ZybwsIsyVG//FahB7NPQBk6IjSMFs/t0=; b=J
	dUz12ZeGSy5bqIFZB255R6Q/LWkLg8sPK2v+gMvKC0QuO/7SxQfhVtfTxMahy2YT
	NOUBTObTW4d8jYgro3D9IQEhdSZwCGnrjO+k/UR3tkxaSR4RX+4RnH7esSwkylkZ
	jDLY5u3tEjKVuAmUAL3ikweplmbwuGSN8q3FDqAnKorYDLH0XhK+bVALTxHeqq+8
	jemS/hFehpl2SV0aAteOqcGBi5aDs1Pn4SvRpz1E1piPiutdPZYt7bOurFIuFsdv
	l8vZSnmdL40SEKAk4y8sEZothxltJ8PDor3/GqyLSQDbi1fkFIM9GgxBpG6QMlPZ
	JXcwwUTEtinmnJhEZaOnw==
X-ME-Sender: <xms:NJYzahFkqtt_dX-oj-yDhwepGV22emcpXa_T6NnX17la56EpinogQw>
    <xme:NJYzatWhTv4-JDLr121s673NraEQv7hOkF3A5agQTuK3E_UODvywCbv4nb_qMK5m9
    FPKYSvlJqIJzOz_ejt7IkokcNnjqIc6TjhMSP1Cnu9ri0lNcQuMAA>
X-ME-Received: <xmr:NJYzaoJTJkElcKBrEBVP7ZRfBSX8VCDycI1hnMlN1J9rvVF5GhVsLHwVyJgMirA5vov6dLsTL_CVHdQtTka0CFMwFqh9FSteu6olJNCm9A>
X-ME-Proxy-Cause: dmFkZTFD6dk3bOvvX0yaVMjewMZkeTdhDwFjQkN7CKbrsc6RX0hrYV0S0wDnX/SLDtagvs
    OXl/+ys6J6Ef+ualX4oOCc6rpWlLgwUd+CDYp+J4f9tlVotwnOyNo/D2Ul+hiGJ2GnOpwO
    20YD1dz+jK59WSjSeqbvZIbS7LjQbwOZCvQ25fWlXFborkKwttqiF//EPtS1SKQOJhwE9p
    V3KhMGYjicitMSxnodz6t0JekyXT6bD5QV2YO0G8PEP3srRCCjxK6NZiPsNL9hezzRVkL4
    4yQ1ZKu2ng6hTy03G2N6EA5XYfWUIQofvB/33+yVj+xfadwE0sg/Gf4tc/U+tgG/YyDiZj
    5gCDoguk4FnEf1K5Zi1gi2oDU+hFasXGtfz+uD34uwQtsDbuiCYhVFeoZsGM0Oy1Jq0tQB
    9KBGWNhu5H0+Ip8nFTGJPkVHuU2DQmfZyNaGLd103a53WA1IDo44et/xKcRxt8Eayo79Tp
    9q2n+NdbYqxKZz7OE5gizKP717vkwlGR28F4Ed0WdiVKMPusTWHgbhlhkriytr5kpRmrno
    CsD9AKEEJrvdbVnp+VVYfFyq4ZzNfidgAIB1qAwrb5IieSXtpNiRD+a3NOaUK06WkEaMkt
    WDnvbVYj5XAnztwm16ceTwvnBh3PL4EmsI39Y1C9Sfcz4UnXUo26ECi6j7oA
X-ME-Proxy: <xmx:NJYzal9oUL3W5Sh9oL_2PwypIEzUm6Xo8_sxalzC5E1GHyMv1jqRKA>
    <xmx:NJYzajIA1x_Opj5mBg3G9ODhADCBJ2AU6174qZabBHuhKXIL6yshdg>
    <xmx:NJYzailPZpFdAjcJcNXHrlBaEyB8kuBxljpoYbPpBfSQFwlhhA2FQw>
    <xmx:NJYzavOdZePNbnAhlvKfxzwFmyZNApEjwINNCsca_ei3Rlpq9zV-GQ>
    <xmx:NJYzajPGljTcK6908UvfGPMJ2VBkvhNJ2Xrl10H1qVFZwKb4tWO3k8LH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71b901b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:31 +0200
Subject: [PATCH v3 2/8] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-2-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When discovering the repository in "setup.c" we apply the final
repository format multiple times:

  - Once via `repository_format_configure()`, where we apply the hash
    algorithm and ref storage format to both `struct repository_format`
    and `struct repository`.

  - And once via `apply_repository_format()`, where we apply these two
    settings from `struct repository_format` to `struct repository`.

With the current flow both of these are in fact necessary. But this is
only because we call `repository_format_configure()` after we have
called `apply_repository_format()`. Consequently, if we only changed the
repository format in `repository_format_configure()` it would never
propagate to the repository.

Refactor the code so that we first configure the repository format
before applying it to the repository so that we can stop setting the
hash and reference storage format multiple times.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index a9db1f2c23..2748155964 100644
--- a/setup.c
+++ b/setup.c
@@ -2710,8 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 	return ret;
 }
 
-static void repository_format_configure(struct repository *repo,
-					struct repository_format *repo_fmt,
+static void repository_format_configure(struct repository_format *repo_fmt,
 					int hash, enum ref_storage_format ref_format)
 {
 	struct default_format_config cfg = {
@@ -2748,7 +2747,6 @@ static void repository_format_configure(struct repository *repo,
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
-	repo_set_hash_algo(repo, repo_fmt->hash_algo);
 
 	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
@@ -2786,9 +2784,6 @@ static void repository_format_configure(struct repository *repo,
 
 		free(backend);
 	}
-
-	repo_set_ref_storage_format(repo, repo_fmt->ref_storage_format,
-				    repo_fmt->ref_storage_payload);
 }
 
 int init_db(struct repository *repo,
@@ -2830,10 +2825,10 @@ int init_db(struct repository *repo,
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format_gently(repo_get_git_dir(repo), &repo_fmt, NULL);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 	if (apply_repository_format(repo, &repo_fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 		die("%s", err.buf);
 	startup_info->have_repository = 1;
-	repository_format_configure(repo, &repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we

-- 
2.55.0.rc0.786.g65d90a0328.dirty


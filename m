Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFD38F63D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116922; cv=none; b=bIAKMs163inOAUCq2spAnSV/EQNxgTUDhNwKXif/BO4uaZwpnACpLnpvVVF9LiNJMYMI9ocdkYWxc6jFIlsTfAQpf7gynNWyMWVYb39DPpN1qAtyYAUr49ogJPjOVKuzeEf1XqcASugAlhfBZ5Pq6q2dz9krvbrsFiCFkip81+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116922; c=relaxed/simple;
	bh=58YVJWT9UI8kFDdUXcQJJtdE7U+/Aj1ZmzZWBeydFbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAlJc3VyH41xShbOMrLnzHfB0dst9fJE6OAZ3ajxIrjcVCZ/iGtg1sEZlWSM2m3by/UsxvRIooipxDs+74Hp6gA3s5YmhWBNG9l0tHsvxZkIrKW2OPZrxona21u9QHyo5z4SDBUHwzct4nQRuuF6USDEjdqLwQwR5wcPLhikhQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b0V348A4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFFOhOiJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b0V348A4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFFOhOiJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10E2E7A007F;
	Mon, 22 Jun 2026 04:28:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 22 Jun 2026 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116914;
	 x=1782203314; bh=CTRf5nrb36Pf8fnz9MxgWTc9+bZ4tr2L/6FfBPB20Y0=; b=
	b0V348A4zix3nCP+QVpoCMhbEKZ01nrOg+euMujUVOuajIZU6jlnejPnXp9n+gMP
	MocUqkl9EFSj1bLwLYIoiOqCI8mdgaTbS+Y20DAD0+bKEz5aoiFoEzzen8+A+LGa
	ur/B4kJ9gWvzC8D0+eX69U3HX/oN9ZUVZyPosnDuislH27kmZt4Ue+rkA5FIFv0R
	PVOolE3Sg+t0C/Cf5NGh+x21U72lhJlsck5+BfNPRJzgf6ovq6u/4JazvDAUFKY+
	VnQI3BpAh9kl6XmIXXgBhlwWUQCcdIGhLW88WWgxz46Z7OW8SIbsPgr0PNFzUhRL
	AeAl+pxizMFqMdZ9P0PJKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116914; x=
	1782203314; bh=CTRf5nrb36Pf8fnz9MxgWTc9+bZ4tr2L/6FfBPB20Y0=; b=P
	FFOhOiJUcyOLkPyJV5c+7UQm5tj6cMPtfziy5E1065EdxUNcdgePBH/KQ65AMC2v
	/r+3KDfnsMXGKsXSWOco4h25aPbEUZwdi+QuoSiftYl9TbwpvPRQ6zrIYpz98I65
	+Qk35qBUGK9Sz/GJ5QXokk4cKBqlhx9HsbsC/zNG4f+BL5fiDI7S/1nJGAqK3mow
	0PWhU+zQXgGsGnbc9VLHyJn/tFwOeA+fvyg/2hQ8tVMSC9hJBu8uh76HpvNbGFe5
	N+EaJIv+0zk1cJmYDKBj9tQ+jAl4UaRD8STUKmIANouyP148FQjRep1R9owG5nLk
	daxHwzr67Dletikkno1HQ==
X-ME-Sender: <xms:MvI4ar4Dn_V33pPi6jUZe2Itn_pbPHCd08Js5bXJmE6u194Jt3H5YA>
    <xme:MvI4an4MaAz8TJvFTJqMqtR6Kcv3tkp_HOXFVQtnR1Q628sSOYYyX1VOiJUv_kW1A
    gsxyZl4RTpQXAeqEZX6gaOsXei3o6TMgllf151-oz9aV4EMG9uFgw>
X-ME-Received: <xmr:MvI4aneTmPkl8HTCXseBU1HfirdzXuH9RfA8NwAgdcpjTLJyZV0BC8zI-rAxdVeu5o1mS1SYAPRBWpldF9m16jMvCgM0VmjTedawtWrtgA>
X-ME-Proxy-Cause: dmFkZTFGuvhk19wP1nIdECGxwx3gbsw2ufEFYPW/bcryZRaeS0zP3zRO2BkgCLVXG+HRAu
    eDSJo9XC9+oh3Bg4ZRtWUyrhjPNmJp3YOJHUnxHZF9fRZrG2CDlLXQ1vIYWsZ6wE8vVEag
    zy9G92nuZEbjKcNWm4jg58++glxCpMiBCJ8FdiujUMh3AT0f9M3NX3x4YMlYXDCGdPE5Jo
    sF+G7mjGMycHN/Ao7CZBomtDY3FTUdRjzmq4savyltQeIxi4PefUj35UFTgtSExhYooKOd
    zIHDBAiAvQ1kUkDPooo/KXMo5cdMPFyZNxi4JoyhlbXctSkAgq/pHTp6e/bmoS79cQ0AE5
    Xes0lsosBJkm96BbTn/FNbY9pcj2pzDtK6KxoJcUfHydpaMGyvAzQzL/HRzYcpxdOsqWQ+
    VsxifJ4Etjm5b9zzvKZ5C0+fkuIY8QcG6TwIDCtEEblf/GLS1QdUdkL8MV5hWVN41fZfUa
    Dt7ZJUYJhUp8hgt142QKpx6ZOst2TRijObXEU+L7rJ5kjQnZEQJjiv+NpIIv8zePBbIagu
    B2FM3X9MXzpF45vjPU/CP2U0SFHXnp/a4/Ltyrrm1hLKZFKXVdTN5NfUfXvFJgCuBGbIRg
    OHc8xUNLEmM1AGM2jW/tpgCHPgV9XJQx5L4L4Da+0+hWBjqm/g6XZ1u75noA
X-ME-Proxy: <xmx:MvI4arDBR1dnEGE4-aHtKofzcBPQ3X5n32YG80qSYe3ursP5scHVKA>
    <xmx:MvI4aq_NEn216QbyyMsnCmo8Eof0fHQUNAbZ7ATQeysOglbaqCQJJg>
    <xmx:MvI4amIbt9NDO7AmfPPGYWIYKgGBrgDFcZ0JOzOdUlg8F8rCkJIRcw>
    <xmx:MvI4ajjI02kzi934AUq6ooFeJUq6utDIwdV7RGbop3UbZ0AZz3_ACQ>
    <xmx:MvI4ahgBrVO5DLr94NI8nVnt-qMCQmrN8WmysmJgbqcE8jzYlA21pcD3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f49e82f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:24 +0200
Subject: [PATCH v5 02/11] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-2-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
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
2.55.0.rc1.745.g43192e7977.dirty


Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258537B03E
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868489; cv=none; b=ZmYMM4NWMmpvqr+dM7mpbYlBYkvRsH0ZFt8kgDcpWkV8SHqMXq5cIZ2AVEdYuNlWlbfoQcWDIm2gNPsEfv2TqWHTmbGzJ5UOibuvqNZpHW9ZMkAzXN4urPPrHgN9ELizcDpK6T6R3Ic2y/uC/1GcMe7aaRyKy9zGEuQ24B8t1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868489; c=relaxed/simple;
	bh=vY8AyBitws/UJl0F2Kr/A7oTVar3SEqOSZu4AvncRfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jD3CJpgrLVLFbY2sIoBZd+ZlWPctb3o7SRDnRgNcpddrrVC+dcGwm9rLxVCALVnjw7WljRmjT4UgAJSqHgn2ho92XDAGRYA0y43F+/jrFJ006I7zZDxSJAWraS4znZbMTu5skUknFJws69BGr01q1yTvAQLX/wG8Q5iwtx2XUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AgYrS//5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNJnosMY; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AgYrS//5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNJnosMY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 183471D00158;
	Fri, 19 Jun 2026 07:28:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 19 Jun 2026 07:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868487;
	 x=1781954887; bh=vYj4S4lxPNNuH6M5Vo8W4PortrXa8ShWMXtik3UjhR8=; b=
	AgYrS//5sNP85/FqZvhaOf63nWj/sYonzns/jGlE1zVdDm2OThKuJUvmHMm+N4lD
	/BFJcfZHODUxgLoB89kxo508kleVBA5RO4ffCmxVRygMBr45UlpSZbQZBrCH6ny9
	MfdX9uMjdUuVsyu/48XK9Qh0eC2MQ5QiT7QALG83Z3+uTX+AGLM1TJ9QGYhA2PBE
	e8SgtNeUGLMVEr7bz+hKexHhqMEWJA1LgyjxWQii1pZKdzUDVUbLBXEAeK5r+082
	EEf0IARdyNHOmlTL9dpQBvSyVcVMq9s/W27bKrHjaUUKUAtQ4JPtbApBncQVB+a8
	XXoAUxPoVU8pde19AxrStA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868487; x=
	1781954887; bh=vYj4S4lxPNNuH6M5Vo8W4PortrXa8ShWMXtik3UjhR8=; b=R
	NJnosMYDEX+Leqn9UdsWE6i6FJC9uf4tDxPOWerPBWtj5nKg/4/bNJhAZou7cO2Y
	wbZD8BF04j4ggB1OD6K3OtkypKbhEVHOdL+OP9rS1/L/LxKBmgFil7wp6sHxfr+M
	BNTDY6qyLUKDetauo2KRoOtEgSvd1+q3M052ajUbG4z0wNIIo7jRx0Qcs+IMYvUB
	FixoRW1fFG5xRrLBbKiooy0Us1WBBHB2aMEZRULyMsUL4IAH9jTfFajzNdkrDeQi
	KGVuJ5nRSh0w723b6w4SOTXapwBw5W+ubUiJEQ7muUtb8KW4EtzA6zOZKdRIndoQ
	avJ7P424H5crz2yXY8G0A==
X-ME-Sender: <xms:xyc1am92NczlkUyYrqeTbaxYXBDG50_S_HibeaLKpbXIR64Xc91w5w>
    <xme:xyc1atvnrc7R_VeRTNQr0konJYF7t0tWO5X5SL8fjSrwy3bgkj-V_wOgwZqTdSKaH
    22K0v7oXd4NxI-9yIso3WJdwN9a_cqMobk3oE-UHrglUfNbz9BZx2A>
X-ME-Received: <xmr:xyc1ahCIKFT7A35CZjga7cxtjXAe6b5Mcud2R3WWYedvrgsuHt6pwnQu2V5pYB4eU3zcu3M2L4Wmi7_0J-0uejkhpUgFX_DRXKt_wSoDRdA>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAsK
    oUSfF4XEli/FqFLQSSqh8322ZTvi1lMlRes27uCnPj/6GdFUXIK6wNfRAHTSpc/ad52MyH
    5cW1fY7e9LW91ceBZ+LKxqnDZ8ex4hOZKHszyXU+JlUKk+gOiO/aTnDgQa0tRb+yeeDHuF
    c5QwHeovyCOIb9mZZCroWjWa/Hkx1GHS2UZGJJixrV1KuWRiTLTFDzjlKoE78lx4NxftdC
    kmAkBiW0LldpD0Uc/jmD2amGGsb68OtLw72G/f33G8lNDShAvhcWfEo4aFv0CrcQBH5I1L
    bUMhzQZURfGZPXB1vy5TOiMMc2ckHSLa6jhfTrozGlz/7ilzafrB0wnpdTdw
X-ME-Proxy: <xmx:xyc1atVcYGe7o_YeQmqauicMZTHQ0pBNr2gDfTa6SqRjOi9ruTMbvQ>
    <xmx:xyc1anAaDI_DwF2BUuUy9YCAf5VC_wOs4dNOP-hsu-AFUHLN8mz1yQ>
    <xmx:xyc1ao8vvpXLnQuE_k6zvsBCVMu1nJMjWn2DlUpsgHy9V5ACpmuuFw>
    <xmx:xyc1amHNcwJQONe6XZfhd-Z8yjnjy3Sq_mC-ITL2zGxtWEpjFKveuA>
    <xmx:xyc1amETBIcOUvFJt7HcG9BmpqvTCkkQuZqq9SFuplzFwkq2chCpI6iW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6d279fcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:50 +0200
Subject: [PATCH v4 02/10] setup: stop applying repository format twice
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-2-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
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
2.55.0.rc1.722.g2b3ac350e6.dirty


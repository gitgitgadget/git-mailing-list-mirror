Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43E405C57
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820097; cv=none; b=nLORnIs0kAf43DOOjC4CHOunSWbpxA4m80T6XGulG16y/V8pvaxvcyKnrtcuroJh+nG4cvjkfKCRtlG3xvKUtrqVwk4gWpFbfHMKnVp97/Xod4X1UOgWz0CW1PHUhNRLEsZCBxqTNdY5LyXpWWIld+oQG8gCAbLOleThqrS1eIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820097; c=relaxed/simple;
	bh=3ZwJ6btlqpUigbsmlwFJmKWZxZgfaAJvDAC7g/mb+ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omDpBBwLAf5pFCxo4nxP90DcAwoFpG39jNThh7T0WrMXxUVtkWeefBdpgrYe4feDUr2PGtRPJuA9jjeESBoxJ1+0EG9lEwyo2RMM94z1SOXLy/pFXWhIWBnvISkvbP3H4HqbRfFCoEHdjq9DPv2ZEB8WadPXMklzqlgkNOewDoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJURVXtc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amdm3Hoi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJURVXtc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amdm3Hoi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 037F27A00A4
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 30 Jun 2026 07:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820095;
	 x=1782906495; bh=ORiectyD25z78mv8snV4lmWyQlhoJFLUU3my5MUCpVY=; b=
	jJURVXtc61oO/lbq700ziBQWftUQl1V7C449Yp7p7HtzRFIBamEKPXeRVGvia3es
	GWp4jxmSQ4db7tNTsTU+YldBzbCXZzE0KF+KZ1A9PU99znYiI3QfXIGWcAdkQq5L
	4scFvPVkNeNeJMQ2EDLk/NJAm4Vmk3w+eFxJ+TufEx1drfDIu7UP7oZYSXx85AB4
	cVZ15bRv2uWCD2mIf7l7MBUHb4KX/rxiQrXTPNVpHRn4/FOahpPmRtyEY6gUfzDG
	sFVPq5btDgDnY+Ma47ZKTgh8UQEM6jO0pEus4gQrcvllmX0ZJEzqvMG7X7/eR/zL
	sB8Oj6RKNRDpvGXKciXvVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820095; x=
	1782906495; bh=ORiectyD25z78mv8snV4lmWyQlhoJFLUU3my5MUCpVY=; b=a
	mdm3HoiMJUVvF3J7q+sKAyVyyHEJ+5SvgLfsehiv/xRdR2zAre51iy5JLKPaTTvW
	dG6YKxVy9qYJGIjdPX1FAtkpz+QO/EP0tqamcSKtoUxVVBdkblJTpMmLM+3HzYaS
	Z/ijou+/6Q3Ute1lg7MPngpV5tt3xmtXcdd+Rqgz+Uawd4xxz70l0uw9tHaXu5Mn
	cXhkPba8Q0Z4kiKrty4Jzg9bOWV+GjyMMre+O34b2VYi+T89o+9L4UhWnHils2yN
	e7DuRv57XrX4ij5ajr9JhdnJNrVZqqagxbGIU7SvREDAjGGQDOyPgMNlucPHceBj
	LmFKe0iljsSSJamScUzKA==
X-ME-Sender: <xms:_6xDanWihwb_ZmUnTic-KGpnfpCQcjkGCFxmjeDZlywzLy75tolgjw>
    <xme:_6xDamheMYT-92DpjBvVg9YuyjSneviV8wIvVOmMQ2kHPcUtHLk-BUkULdQNFVE79
    dIPkiKhRmRG6kzKkzvkNfgKQE0NfsHSvnt3aYUcdm0n1GfUfW_hDQ>
X-ME-Received: <xmr:_6xDapAN2VeOW2l3kwbCtjSg5f9CaGQRDc6usV6EuTt7cULzJHVycjPze-mjM-sMKHYw5ZGS3GZGLzemgMckPv6SswoIHsHleJGdnRPjBLOUVA>
X-ME-Proxy-Cause: dmFkZTFDZ8EBIRkLTKt14TuSGr1p9PVZekTad1c/wqf+J4rUdU57yUeNCpU56+znu8nsjb
    fYDR646+CJ3TGFv8kQTHR4VNBrT/tkMeSXjzT67aaHpKiIdg7Ex7ASQFMr3pvovOMeWRc2
    b+Hb+9BEYhuDH+pmqgJy7oGhS1oPcxj3Hy28pR4Uz81T3ewRUNKEnbf7HExREqmx77S7CO
    8q4+s9ohDmUs11CzmmSQpKP0fvZO9hDzS3HZYuZIL2rRpsr/my7MnY/OfRKNFc3m22a8aE
    0HfNWlTaLhp/UB/uVY+/uRI7kUgfffb/QcAn+DT1zAl/2aW3MU8z9wRoF8TwRTtj2JqpEy
    RQX6QeUMX63/zUyw8qa6/Z5Dy9ABOjPSlY/V1DlRkP0HbNfKqgGfu/Q7Ld42QMd0yU6agi
    xAYPcN4ze32tQSsVPNh56x2QOX/ShplPwdHCnisvJ9+RBu3+E/bW9E6GQyy9582dY9kJpx
    oqesxFpvnIPWtF91/O1PhoP1nDlvNPoh6D4+byhH8LjHTKu/3lLdYYMhgt9vAHtDOkeMlu
    maBpDiFfr7YEecFo3LxPrGzlCcZX2FlfXaSKp4aKmDubPD9RF+KtQTNJH5fynyyd/PLLs3
    PFSJC9mvzu9PDQjhVWtBgH6o0E6N3jn2F2ozMtvxVtUPLvhLiJouoA50Wg9A
X-ME-Proxy: <xmx:_6xDanenzzIPftmqYXxG22488rkgWfdFkFcgE5jTD5pr0-I-xoj8TQ>
    <xmx:_6xDahctuGeFIecrxPO9KXYNK-DHVxppD_e2y66JTM_o8jKjI2b4Xw>
    <xmx:_6xDarjJzObOubY3Z4e6peOvdStRKT8e9KWxgjv4bRBbJItZ1n3pbw>
    <xmx:_6xDatQ8DNfW5E5P5j1xUTwOHkG0HoyMr7LS0xhXI7vqK3--IAmeoA>
    <xmx:_6xDaqnC6GmKt5wwy8bt_dIH7m4eFak-EGT6THpNK38OZHKZ3YvDpkHW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d257ea09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:47 +0200
Subject: [PATCH 08/13] setup: drop static `cwd` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-8-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The current working directory is stored as part of a static strbuf
variable. This variable had to have a lifetime longer than its
containing function because the value we return typically points into
that buffer.

In the preceding commit we have moved the prefix into the repository
though. Consequently, we can now return the repository's prefix instead
of the local one and thus properly manage the lifecycle of this local
variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index fc88ea2dbd..971024e5a6 100644
--- a/setup.c
+++ b/setup.c
@@ -1933,7 +1933,7 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 
 const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
-	static struct strbuf cwd = STRBUF_INIT;
+	struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	struct repo_discovery discovery = REPO_DISCOVERY_INIT;
 	const char *prefix = NULL;
@@ -2116,9 +2116,10 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 	repo_discovery_release(&discovery);
 	strbuf_release(&dir);
+	strbuf_release(&cwd);
 	strbuf_release(&gitdir);
 	strbuf_release(&report);
-	return prefix;
+	return repo->prefix;
 }
 
 int git_config_perm(const char *var, const char *value)

-- 
2.55.0.795.g602f6c329a.dirty


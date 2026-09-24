Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF6445ADB
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241584; cv=none; b=epnN0fZVjMRW++IKQL4XScHRrBiB0fy7Lytlhj0ec5biimGhEns/8ZV4xcJwN8rCEXzuY+wp3/c1DE5O/Edsb95tpiIV61pjKa3QnYS9iyPhQRFXZEc7L0rl7XiJIf8kvaFDhu3BqxTZyGx/sSX7R8m7ZLfVi5rOwhz1vQq3YWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241584; c=relaxed/simple;
	bh=AKUNx7emKiDIFvrzH+0T0YLndt6JFCtVlNkr4K4kadw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOHhhDGCQokDG9CrAlNXExZDKNDbM8F+BH8zD91clOoXviSGjLBPQabwNZskEA+XcBYPqNluIkJPrNptKL4Oaj5ON1EZdugYwGH9YF3sPHrQGPmhP2duySS+OzKM2wWHWUuI6sVRB5tjvbqLGDyf+TYxkSF+P7vVYGYRB1R0gMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKEj8zib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiMYwt4e; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKEj8zib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiMYwt4e"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D124CEC00B8
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 05:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241579;
	 x=1790327979; bh=dst9bdx/zs9ejdmEH/fTFtu9ooIGPKbH4yznmdI7gM4=; b=
	bKEj8zib3E7+j9p08RVUonlLeLy5HvCSgAsQVn+ReU1k3iO5PSCH/ks8fKWs6Ene
	CKffmdiHDW8CyxmmkE5GEgZ++AxKTVNqFBdiLUZa6o0UK9Vl3G7WLySHdkhU3hpN
	B991UmUJb7nnvypo2wZJbrTHbjXyKEUNlQQxNbvj8HbKnNyIDRseAKUhaZ2E87K6
	BTVt0I9QZJKjMcPiRZY1of1zi8hGX6kup4Y8ehfcfd+C9w8n9QZJobeyCnqpL9zq
	Ezh/2zquGNWsPbfJgpjdVxLES8ofRuTHGLY4NSLNjOQYirZKw6CGjDts6IZhUBRr
	SbdFRC4pFjfte59QAQ7xrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241579; x=
	1790327979; bh=dst9bdx/zs9ejdmEH/fTFtu9ooIGPKbH4yznmdI7gM4=; b=K
	iMYwt4egl9iUus2sgTuLIJHhwNYzquucRlHJ9FLoIsonwJokA0vdtKIcoPPUQ7Bn
	XeES8vF7QGvF1cvg1nizdlmQDSzpLZBwf3aIfgqSF0WXrCkhGVe04eHawLHQn2yl
	k2duLqlETx7Fhs2JArAVZtxj9n6XskZ2C9/Im6P4SrAXDFARb2rKik8TH9wrMpPc
	CFVjmRyO1JqugcUCzjBfrXyK3n0VC58sKHz3+ks7PItGfYQ0qJrQVklWV3YdytgY
	JvYyzDlN5/MXZvM18LDQkpBIHyS8qPFt72w5996a19fW5C6BQNzmQxHTwdMs85T9
	asa754UppGjnpP4ltJRyw==
X-ME-Sender: <xms:K-u0amuOGt5G4PpK920te14ioYFY8EMRXGAqFFQnGXbTFl_r0V79WA>
    <xme:K-u0aibahigiE1VxoZiCC0rUlKgOmqB43o8uRGtcdLVOpkVWEr6hGGxs2FUEzjhUo
    GEBZrho1VpaUjliA6eoTc96BgWZDATKrzc4DsiLmGxSUYRGJLUAI3U>
X-ME-Received: <xmr:K-u0anZxk_Q9O9cycuDwvihWl3hvsn9cuVcpyrIJ5j14Fjc93RG9A6aLPBOPLD71EB1Etqo>
X-ME-Proxy-Cause: dmFkZTFPodOiLWcdqf6sGstU46dIiqXidIFd9cR4fooPG2VzhuQs4sgHwSSL0mI+zYrJki
    puKwTM6PzOLvhrOnHha7/ZqJXKFWeUZ7pL3PmhkuvlpM0SAOkWbZk3xZQvHRMhKdNhwt4b
    RD3a0i1KaVTQhiwtqarc8pf3XfoXA6W5MTyTZacFoe6F2umLNsXJ1ouYl3pIUvkblQZagq
    My5ETPa7FIKiTyNS2see97qCZqfu7GXNWEANEz90j9Xl651gCUX4FzvDgltnokz25gMaTM
    HthS5xNHFJNXlc52D+rP6WxTTQ+lRC0R4uRCl7fXgiak8N0bh0v8/Rl7rSKJ4fouMiwlCk
    9VAHnHwHGujvl7nA2vD2bCa5Ut/1vMO0lcW5BaCWl59u7Gaqlft7i9UKnKG6tE2qER2/Ja
    I2TqGAx6UG+EjRIpKOIhVWFAk6w+2wv6cbp6GfVoGKB8jbhggn9XIxYBuQYS/soYyhvD1H
    EWiINlRsfm29J1qwFALvsvuWo1eziRIDMJOv2bQ+caMwN5YyivqRiJ6ytXLBoJ8xDtAw+s
    v1HfHU099ji/a6RSfzBanWSc3asZ5z/qZOxknw3JE5jgndEVDvFl/zXu7LLQ+6KlSNIT5O
    mgsEMf/wUuYRY+wigsqkD1OWvaRdEgOaFA4WztEIBemvTFUm7tzEAGH2Qazw
X-ME-Proxy: <xmx:K-u0amXU9O8NncnVf7_dsECqxNqPdpM3u2sNCjwiTB64RNP4OrgI1A>
    <xmx:K-u0am0iUiYf8YjywP2Uke7HMPmpOKzA-RLedUMG2PalhSxXtwTMhg>
    <xmx:K-u0alaDDSCu8SU_LRHAhchekrxr0X1BdHsh9Rtz01V_fmrjh_nIYg>
    <xmx:K-u0aho5B4D3dzdVHOj2MsAwMh0t55h8XUBfj7ACMxhBo_cRkiPgVw>
    <xmx:K-u0ahcHi1bH_ey0Io7bu0MLVK6X6aHKjA0S-IZfqfDnwWtLiDNM-oF9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6f80fce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:20 +0200
Subject: [PATCH 2/7] path: introduce
 `safe_create_leading_directories_no_share_const()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-2-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `safe_create_leading_directories()` family of functions modify the
passed-in path so that we can obtain all the different segments of the
path. This is done by overwriting path separators with a NUL byte for
every component. While we ultimately restore the original string, the
consequence is that the caller needs to pass a non-constant string.

While it would be trivial to modify the function to not modify the path
in-place anymore, the intent of this whole mechanism is to save an
allocation. It's quite dubious whether this optimization really matters
in the grand scheme of things, but here we are.

In any case, we provide a `_const()` variant that handles the case where
the caller only has a string constant. But we lack such a variant for
the `safe_create_leading_directories_no_share()` function, and we're
about to add a couple of callers that would need it.

Add this helper function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 5 +++++
 path.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/path.c b/path.c
index 69b06c9464..f8f5a9dd28 100644
--- a/path.c
+++ b/path.c
@@ -889,6 +889,11 @@ enum scld_error safe_create_leading_directories_no_share(char *path)
 	return safe_create_leading_directories(NULL, path);
 }
 
+enum scld_error safe_create_leading_directories_no_share_const(const char *path)
+{
+	return safe_create_leading_directories_const(NULL, path);
+}
+
 enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path)
 {
diff --git a/path.h b/path.h
index 7e7408dd05..e2d62c4978 100644
--- a/path.h
+++ b/path.h
@@ -254,6 +254,7 @@ enum scld_error safe_create_leading_directories(struct repository *repo, char *p
 enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
+enum scld_error safe_create_leading_directories_no_share_const(const char *path);
 
 /*
  * Create a file, potentially creating its leading directories in case they

-- 
2.56.0.rc2.329.gd58861e689.dirty


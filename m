Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C931390CB2
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116925; cv=none; b=X8HshvJBQskPzGAehsRfrbBYiq7vZ/TvpnIzVoRKZ+0Trv8233MzMlRFzmiIeek4e1jijrTNopi7kjk7KSYtL+nzzvAAO/9N9vVz402hVI045Zid6Vm192osL6u4azz9VqBQvuIA88R3pkCNfQP1HjgfxS7YRJlf9TIQmHDYuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116925; c=relaxed/simple;
	bh=X2LB1y0xWiJ7Ty+tivAHzHm9RJpChefjHPp0fe0+dvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cf7CjLfvqz2mhJMJGKci/Oc2cujZQTS1kUA53mP0eIAoaKS8ySqdvBrRA0kq4ov/2tVtPnbl/mAOaR3Ruv+XMWedKfV0J7Nz69b9vGf3VtjsMhdmT84YWyiOTYNeccSYzcGbLgCtWmwwoIVfyl2YTXhwJNoi9rx93LlvXGDKsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ex7778mo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d7lLLnJf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ex7778mo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d7lLLnJf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EA697A017A;
	Mon, 22 Jun 2026 04:28:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 04:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116917;
	 x=1782203317; bh=RuwxwOm6s3bm3AscrHXxdkVHea2PwpBh9u8xx/1zYoM=; b=
	Ex7778moB5pdQarwKE0BxE/Q1hUoxn8ovkZo7HtuE4qDTVTRbFYRPWHSLsUZsV6F
	vXMnKM8Cl9DVQrKOnH5NSovQyQOZ84noDrA89Bgg5UbJQwBVGIbFVlawJOHbDcW7
	e4kPuOxIV8UHAWAEXjksTK1tzDW/pAoje4eorbGUkzP5GnCKOgLilLPfntUgvgOY
	wJ074972LO12MSPqqycEX4tapW8bjCybWARz2TiptKjaSjACcODM1tAhKH/jm0gY
	tUZedBIwxYNnzExzXAqBDR1rDn81/miOPIL5GHEPRy+9fT4Wf9JP7HDr2h5tTNFo
	ROL6SdiLjxHLqVjEqSV6Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116917; x=
	1782203317; bh=RuwxwOm6s3bm3AscrHXxdkVHea2PwpBh9u8xx/1zYoM=; b=d
	7lLLnJfqorCfFqxu338hPSi5fGVoomGuuFGZgqLiVyMlRAEu9iZSNKr0M6I4QeH7
	38Wr3PNR5Bc/9koBSrw4Yngrpix1t8zinLOmrwIDOfuPEvX+lP6CWa2D0nWj88yV
	mdLpkFFkTN0lv9zSOvzZEPM2RVYYLkIaRBjKfUZYAxuUJidWmk5svb2xFF9KLFHM
	76aZphgDFdRfUBzvOeGeELUG/R8d1AAghSn6RnRIUPwCMYJvYopLal5QwQAW9EJw
	X1evoDcfrvPzWM8UYciAVWH1Uq//DF2y9Qr86EQoQGAReO1qfTOJSCNRkiC1NaSH
	4m+jL3TNcczXpfJebO7bQ==
X-ME-Sender: <xms:NfI4ah02bbtheotP6K2nIZij6JzP9fqnNBJHWTgMpHSe-bF9Jls5hg>
    <xme:NfI4avHYCFg5NZaWdjeQQ2jirckIBOe5uvtuRQmx1dllDodaJKMmjOx6yAP8_xPlI
    mJ5sP-jYG9SmX53kQnVehRScTGFrFOAz3Xo4ROlGtYLIiMizrhj8A>
X-ME-Received: <xmr:NfI4am7ywticqFBIEp9aMVmMXq87mTLy9MAjf6v4EfJ-KSZGyqht21UQbaSjOfUTNGGwyZreCJvjcsoa3qdUZHo8MAaWRFq5-EW58IfPow>
X-ME-Proxy-Cause: dmFkZTFakfR/hQdxT8sgZGM7TQQccfc31pXTzQprwmf3UdZ0m94xtc2Ks1qiaYun/cfrqS
    kSnHJbjGphqQMxVSuxt8CLe3evU7HVZT+Jtv6Z+XaZPFlnB9XwOFE2YAsF9yem4vNYAfD8
    EaEe1QJfkstihASjSNzDJMBKnxmovCsr4/2FehJ3yq2Gb1XcsNmubyifbmvVuHHhSF9QVk
    aAY51vbmFsY9ZtFAb7XJ1a66MtOJUaomxnBZZV+kkvLhe4wLB9dlUCfVi9Y4cOq+tVJ77F
    iZMBpwDllvpNqnwIDAzfFq9r0Y6X1MT/92ZW4R0seBr1MkR3aNS1f+kud/eeT+r+ir63TS
    xZmi1khLMTumf5tbm56U5sC//Xo9MspxOwCgDZhJ5CtpA+p9hbzse7bvhLRYax2fDjodvq
    80R6sdTMcgB0UMZsaJAsY8iCnNA6LQ+wcTqG43aiSLWmnxtzVjiC2fr5uDjkxwKEqEDPz8
    N41TIBvNknGZH/OoFL3hWcuob9cR7THIsgyUpXU+z/GLpL+YXlQ126NIBwRr8az6u1N+6N
    LWyu1J06rMWBRfiotl63GqE7zA/dpVBxO69yWewdhEaGweyM/LNGO6lJ1gEofDRHKskGgC
    Vbi9+T3sa5TAFFlNXVYFuXcCwGZPNV96azAXnJuLbZktD0ZDDNU3nDCOCV/A
X-ME-Proxy: <xmx:NfI4atsaWCsk04SWOT_SxW-duHN9YwZg0SFcBawBT-qTHAbUaJOu-A>
    <xmx:NfI4av5myfWpFiBlK377P7l_R2ukqRoZ2b0oLEbJVKgwIT1cH5QdYQ>
    <xmx:NfI4agVcBx4zHAui7UkQQs_GQcjoHYAbDPJ363xAa2-CUbtA3PKRUw>
    <xmx:NfI4ap-_VRhFaEEC3DURD13_BdOXOHgy6axFeXCxHOFOwpOvf0e5og>
    <xmx:NfI4al_9rYnJ5rwN0X-PgyAnEkAN3-7po4Rj2J5-JGsz--zDoaYCwpFD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 864be93e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:25 +0200
Subject: [PATCH v5 03/11] setup: don't apply "GIT_REFERENCE_BACKEND"
 without a repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-3-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When discovering a repository we eventually also apply the
"GIT_REFERENCE_BACKEND" environment variable to the repository. There's
two problems with that:

  - We do this unconditionally, which is rather pointless: we really
    only have to configure the repository when we have found one.

  - We have already applied the repository format at that point in time,
    so we need to manually reapply it.

Move the logic around so that we only apply the environment variable
when a repository was discovered. This also allows us to drop the
explcit call to `repo_set_ref_storage_format()` because we now adjust
the format before we apply it via `apply_repository_format()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 2748155964..79125db565 100644
--- a/setup.c
+++ b/setup.c
@@ -1906,7 +1906,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
-	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -2032,6 +2031,25 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
+			const char *ref_backend_uri;
+
+			/*
+			 * The env variable should override the repository config
+			 * for 'extensions.refStorage'.
+			 */
+			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+			if (ref_backend_uri) {
+				char *format;
+
+				free(repo_fmt.ref_storage_payload);
+
+				parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
+				repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
+				if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+					die(_("unknown ref storage format: '%s'"), format);
+
+				free(format);
+			}
 
 			if (apply_repository_format(repo, &repo_fmt,
 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
@@ -2057,25 +2075,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 	}
 
-	/*
-	 * The env variable should override the repository config
-	 * for 'extensions.refStorage'.
-	 */
-	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
-	if (ref_backend_uri) {
-		char *backend, *payload;
-		enum ref_storage_format format;
-
-		parse_reference_uri(ref_backend_uri, &backend, &payload);
-		format = ref_storage_format_by_name(backend);
-		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format: '%s'"), backend);
-		repo_set_ref_storage_format(repo, format, payload);
-
-		free(backend);
-		free(payload);
-	}
-
 	setup_original_cwd(repo);
 
 	strbuf_release(&dir);

-- 
2.55.0.rc1.745.g43192e7977.dirty


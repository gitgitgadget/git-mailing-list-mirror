Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783704192FE
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103451; cv=none; b=LqGMBWD/Q8GE/hQRxpf07/dBOC2fbqka0stZngbCEJmkDp6dPKgp804kyb/GjB7Ci6LCyR9s4tca81bXLWePMLZxi97gJWk/GXG//zf5N4ElT1hq5OEsexIp/B1EH63dOY2HC634+U2a1WZel6mmoeVUn1h2IvY+GAmwjKpNjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103451; c=relaxed/simple;
	bh=Sd4SWUom/n9SecD0S/TtuRFkctaAQe4NJ3mEj+dGqYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQvIKRvp1eTdZmTtFV1dDLyiffx43xr9rcNT2vHksLe97j5lRP3TvJOkIgeVkTB5mIH25mZwk3fSSpvydcxpu9ZQbqJk/5sQJqKXJZ8xEaHK7WnTptMpH3pU3KR+A54e7Pc+FDsNNqp2aDlDXhvLSJaurCSkSqlEK1nZxGUgIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rBxonw1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAom3Pvq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rBxonw1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAom3Pvq"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CCCF4EC0073;
	Wed, 10 Jun 2026 10:57:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 10:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103449;
	 x=1781189849; bh=9QwYZaZcle4Zjsmq74QSdRauKjJsJ7wG+/77H4AtPek=; b=
	rBxonw1DgBwlNC6IgI4yS5icFH+q3uuD1roxEq0oRKqgpIiPoK81VNKnlc0LogW8
	E5peHgsriRR6CNF1tAgLid6oY0QsH/BOeMKnxlcNzEsYHaKlZsozaF9tOXQ/bn2S
	6oXYgHEibzKaOdtuf4fao3Nz3S7PwHObpi3aE7athMeV5Pbc8uSnt92CKRai37CM
	4dP4JkjlOY9tMzYRUPcjDEWpRRcVPMIJg4aFy1KHBYDaWtr9ZGPI7HUUZ46fE+m7
	AGgwPnTba1hOxLp56A9WtU+j0rGVKJYdT54L/WuTA0eBkSyWWsqzHde+k3hGiKax
	4abEaUD2xXS/VYwiVioGTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103449; x=
	1781189849; bh=9QwYZaZcle4Zjsmq74QSdRauKjJsJ7wG+/77H4AtPek=; b=i
	Aom3Pvq3mb0y5Co8YUuZB3mAIxUuqoLGfKlESv8E7mmdpVauU6CqQx+82VXnU/QL
	0ulwD7sAIiJqLCSdelbh44iv2kfB/nV5Xe2iB0CMkrImPydFJtGWxPK+t6hGflmh
	9CCcG/mIEzGHb3GZE+ArBL7k7jZcc0YLdANwcVrXN4l0Bi6n/LIxdcjEn/EJpGVV
	1m3nj9by7grUToEoIQ2aK3hCGwErOQvSERLWgQpNLJ0oiM45AN+DhTxMPDUihgRL
	K10//1DgP+/R/XPgg0DFajUN6s9hG3NaCMgWpkhMPQermfX1ni5/6P1sJ5pDi97O
	Eqg2tiSgrGtMX/LIgRuVQ==
X-ME-Sender: <xms:WXspal5KSZH1XEnBa78kkG6jOXhaL_zqyBW0UagLCwyAOJhCloxX8g>
    <xme:WXspao69QKCPD3yku8DDZIkvJuPqWlnV1d9el391E-lbv88__g2ynZlI8LE1iCQ2-
    PW4NEgIT-LqRcG6JcVg0s5jZoKEd2rEvPOj4MZg-r2lerjuzR-dIw>
X-ME-Received: <xmr:WXspaqE_D33yciWH07_fgz-MpcSS7kLO0jI6uJ16gAegO4VgoMlBXs6HXyzQ_BX3ArX7EGetWQvRasyOK84dlBy2sGPW3UXiTAwVuytySA>
X-ME-Proxy-Cause: dmFkZTEJn+HOU7rfleF8wtEqd8n463JF/vFO1XgyixYBoTlaS7cpi00RU70QgROPWwUdI8
    Y2g43EXoqSDarANLeg/qY2LquMRGd0tg55WNrjpoPOxekNmdm0CiNmfLlAe8VSeyDVX037
    1j6uyoB+HxekonkoUDl50g7yk3LRnYScK6sStb5pBzwl/bteJm6VFNzksB07RoD4dmcJZY
    VdiIKVbEs3XzVwXK7AqTzvu/5bPY1eoMkecDU5MTuqJ0bbzDKf6zfqc/3gVc1Tt/VrPF+4
    ykKleLBBcmf2l0TF3giI6aolK2tMnS7lvcFPqLcY2GjwARLogkLqndIPr0EeRum5dexwLU
    UcS4lNtxoVcug5iY0PtZN1oxj5wngl9NMZaKGuhCgrUB0qbQLwCMnktoPl+Y2HD9LT9/xM
    gLuB7DvzR59mfUaqIEoDtM8Wqgu8lc7MFs7HlndZU+0DdCEnIxhi3n9adzSrej4AsUFzU5
    WrJyUjpNAcgwODJlCOUF7hyfbgs5hDh1YDtOc4RwOKvTqDhUqT1oTPS7YzcJXpgNmilt4D
    JgejFCQyoH8Ir3qhKXu6qOvRNWHUMDIVXrEio//KoeHnBefZNCbDMB0YPPVKrCw37LBwpB
    dCqIGJImJSkc0/c6t5oqhtgauKJ/Mg9cVVt7mjuiaoyeT4z+i6EAimde7NAA
X-ME-Proxy: <xmx:WXspapQG72AUEw9EWNVQrvYRNMMtU0X8go3Xp0MeDMXUXPWSRhTCfw>
    <xmx:WXspartC5VdCGrUKMKf5ymjfP0FkwNhw5z7KQR8GKYOPFtD4-am5Lw>
    <xmx:WXspagxXjbKaghEWfgIx062b-opQq1RiZXACUQhL7L0eXZaw_QFYJw>
    <xmx:WXspat6KB4Vgn6nnX2jSOa3QMzzupxe2tGjCdiIg_SYOWVKL5mcsVg>
    <xmx:WXspajo7deQCHJ-ncgvhItkq6duKzYMaKLX4paUGssM2iZtzGMARBMUJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 130bb331 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:09 +0200
Subject: [PATCH 3/9] setup: don't apply "GIT_REFERENCE_BACKEND" without a
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-3-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
 setup.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/setup.c b/setup.c
index 2748155964..7b2e50a8c5 100644
--- a/setup.c
+++ b/setup.c
@@ -1906,7 +1906,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
 	const char *prefix = NULL;
-	const char *ref_backend_uri;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
 	/*
@@ -2023,6 +2022,8 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
+		const char *ref_backend_uri;
+
 		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
@@ -2030,6 +2031,24 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			setup_git_env_internal(repo, gitdir);
 		}
 
+		/*
+		 * The env variable should override the repository config
+		 * for 'extensions.refStorage'.
+		 */
+		ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
+		if (ref_backend_uri) {
+			char *format;
+
+			free(repo_fmt.ref_storage_payload);
+
+			parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
+			repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
+			if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+				die(_("unknown ref storage format: '%s'"), format);
+
+			free(format);
+		}
+
 		if (startup_info->have_repository) {
 			struct strbuf err = STRBUF_INIT;
 
@@ -2057,25 +2076,6 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
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
2.54.0.1189.g8c84645362.dirty


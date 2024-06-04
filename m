Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC014B095
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538514; cv=none; b=XRfHZa/gNDryL/d1rBkdBRykzu6cA/7sWBejPbqYX5/5s21U8fa8R7/hneez/Vc3vb1Aw7ZePyVeci9MGv5WFhafpBjQa+SNLWFjdR/Jvjo2p1vbBOkZTuqgXSv4XNV7wg7JngZrT/hnG98yEEQAzjqhMBYaemUxoWoDe4klI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538514; c=relaxed/simple;
	bh=D/Jv2Z4P8UN7ZLmKuIUu/zx/XbNw9miZzwfiMtmn3FQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe1Ngo24OCIuRmZ5mqzovGMuzIEu7iYnGJmI7BN0zRmkHHcXtompgvXulY/IdO/ZgUhobBzZDdFiBMLQga3o9b+5eIBqz8SQa+nhXoh1KbxR0kGZkYF2LxpVN0s7yhhJ/1bzevldZtVAdyw13HELkjQg0ga8buqjwGcFF1jJyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mWuvCUyU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mWuvCUyU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B20AF34260;
	Tue,  4 Jun 2024 18:01:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=D/Jv2Z4P8UN7ZLmKuIUu/zx/X
	bNw9miZzwfiMtmn3FQ=; b=mWuvCUyUOm53mUfMor30e44LWZYcVeM4SpN21asFs
	187KJ52L65vPb26rA5Ksjj4PVJRuWLIzGDdD78hSxo7WZsiT+2nzDt4dWxAJSjpL
	bs5u20Rp+anQ63xrs9CuD5Od1+jXPWEFYoYo0qgHQm1DroTWa9P6lniMrBdsrhc/
	IE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id ABA613425D;
	Tue,  4 Jun 2024 18:01:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CACFA3425A;
	Tue,  4 Jun 2024 18:01:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/3] refs: call branches branches
Date: Tue,  4 Jun 2024 15:01:43 -0700
Message-ID: <20240604220145.3260714-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-409-g7b0defb391
In-Reply-To: <20240604220145.3260714-1-gitster@pobox.com>
References: <20240603200539.1473345-1-gitster@pobox.com>
 <20240604220145.3260714-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 0B2D3DFE-22BE-11EF-9BD8-ACC938F0AE34-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

These things in refs/heads/ hierarchy are called "branches" in human
parlance.  Replace REF_HEADS with REF_BRANCHES to make it clearer.

No end-user visible change intended at this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-remote.c | 4 ++--
 connect.c           | 4 ++--
 remote.h            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index e8d65ebbdc..65fb22a8a2 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -68,7 +68,7 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
 			   N_("path of git-upload-pack on the remote host"),
 			   PARSE_OPT_HIDDEN },
 		OPT_BIT('t', "tags", &flags, N_("limit to tags"), REF_TAGS),
-		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_HEADS),
+		OPT_BIT('h', "heads", &flags, N_("limit to heads"), REF_BRANCHES),
 		OPT_BIT(0, "refs", &flags, N_("do not show peeled tags"), REF_NORMAL),
 		OPT_BOOL(0, "get-url", &get_url,
 			 N_("take url.<base>.insteadOf into account")),
@@ -100,7 +100,7 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
=20
 	if (flags & REF_TAGS)
 		strvec_push(&transport_options.ref_prefixes, "refs/tags/");
-	if (flags & REF_HEADS)
+	if (flags & REF_BRANCHES)
 		strvec_push(&transport_options.ref_prefixes, "refs/heads/");
=20
 	remote =3D remote_get(dest);
diff --git a/connect.c b/connect.c
index 0d77737a53..cf84e631e9 100644
--- a/connect.c
+++ b/connect.c
@@ -38,8 +38,8 @@ static int check_ref(const char *name, unsigned int fla=
gs)
 							 REFNAME_ALLOW_ONELEVEL))
 		return 0;
=20
-	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && starts_with(name, "heads/"))
+	/* REF_BRANCHES means that we want regular branch heads */
+	if ((flags & REF_BRANCHES) && starts_with(name, "heads/"))
 		return 1;
=20
 	/* REF_TAGS means that we want tags */
diff --git a/remote.h b/remote.h
index dfd4837e60..02e330f42c 100644
--- a/remote.h
+++ b/remote.h
@@ -200,7 +200,7 @@ struct ref {
 };
=20
 #define REF_NORMAL	(1u << 0)
-#define REF_HEADS	(1u << 1)
+#define REF_BRANCHES	(1u << 1)
 #define REF_TAGS	(1u << 2)
=20
 struct ref *find_ref_by_name(const struct ref *list, const char *name);
--=20
2.45.2-409-g7b0defb391


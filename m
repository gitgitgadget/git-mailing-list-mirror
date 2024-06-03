Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD213B2B6
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445149; cv=none; b=QxalXoB7kSDboFf2d7Q98sPz3Z9qHm1iyIohB/33xkACiYV6TcQNF+3saphluAbL7XgRcUhfQSMfF21L02zXw4Bwr7fQs1Le/ncrgI8voMT7dcy/K8FQ61WFwFZX5V5k0k73OG+lKfEsg/3qE0fm0moj4TwfP4Y1jOrr0o9sq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445149; c=relaxed/simple;
	bh=MUuLGx1xlPtzmMh7tDZ0kW+A9+qrRPcEs7Em3IStf5k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWY4FvFdKsrR/9H43DjtK7PffKmSAzlXoWOopJORo7Q6h6Q6e0fTaM4FR8hWSn0Rt0ZuDWkO3c+vpyygrBXUB5WO2Dk0k/S9PEp4KVBVx9NJIMp5aNFBZCL1cbvpQZ/QZMaIgN6vU1zd24d0SaZ8uPpx2T+oWkj1MvXmKE9hskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AFxIjsKt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFxIjsKt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 49D1834C9C;
	Mon,  3 Jun 2024 16:05:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=MUuLGx1xlPtzmMh7tDZ0kW+A9
	+qrRPcEs7Em3IStf5k=; b=AFxIjsKtP86XnMHPmT8xarfJRO5KebU2a1bGo7tkK
	EroVW+u2KWcgsbnRGuNT2eZkLEvhIVYvR6gXRifM81lRipSf+5Y/qnD8dpvxP206
	1Mdc3vqbElhaGTWpph6tiDG92ZdM6/JxQdm1884ZpaUu3zsVohIGkV/jl3hn8ZGP
	68=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 423B334C9B;
	Mon,  3 Jun 2024 16:05:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D7E8934C97;
	Mon,  3 Jun 2024 16:05:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/3] refs: call branches branches
Date: Mon,  3 Jun 2024 13:05:37 -0700
Message-ID: <20240603200539.1473345-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-404-g9eaef5822c
In-Reply-To: <20240603200539.1473345-1-gitster@pobox.com>
References: <xmqq8qzl3mhg.fsf@gitster.g>
 <20240603200539.1473345-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A8BCB69C-21E4-11EF-8B02-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

These things in refs/heads/ hierarchy are called "branches" in human
parlance.  Replace REF_HEADS with REF_BRANCHES to make it clearer.

No end-user visible change intended at this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-remote.c | 6 +++---
 connect.c           | 4 ++--
 remote.h            | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index e8d65ebbdc..9838de69c0 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -9,7 +9,7 @@
 #include "wildmatch.h"
=20
 static const char * const ls_remote_usage[] =3D {
-	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=3D<exec>]\=
n"
+	N_("git ls-remote [--branches] [--tags] [--refs] [--upload-pack=3D<exec=
>]\n"
 	   "              [-q | --quiet] [--exit-code] [--get-url] [--sort=3D<k=
ey>]\n"
 	   "              [--symref] [<repository> [<patterns>...]]"),
 	NULL
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
2.45.2-404-g9eaef5822c


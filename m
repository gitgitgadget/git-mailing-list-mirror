Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98814882D
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347833; cv=none; b=X6rbe1jfpmK2Sa8APLbCzk8ehvKaGK8OnLKTYVWXpulTdfIzONMROUihZSvcRU1s8MRYvBkCKKVl1d5hynCWf89WQETVH6Kp3dkMviEkz+xEwF7L635tMSh8mWuAX9Y7PehZMJ3Qk0ixAOYBnoslbllaYM5SO6Vtu14DkafT6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347833; c=relaxed/simple;
	bh=m0SWOQPidaEuBKcrf2bajJXax1VonSIaW5DAeNNMrck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rzv3GzKB9pgebhd6G7MFVHXyQ7cAotppfLeIdztxuTnD+828TrwF0gdRq1nzD6FX7uhNMNifn5m4NoIH9YofZDnd9BaJLmaVrLvGts7t1SxCpJqhIj1TCHhTtANAr7ONqCnlQQSBMGHHkg82ILlWvyNNHk3YdnsRfXg/ulFHqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DE0GVInn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iG9BEZu2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DE0GVInn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iG9BEZu2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 42E5B1140259;
	Fri, 14 Jun 2024 02:50:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 14 Jun 2024 02:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347831; x=1718434231; bh=2OrgQNZen3
	KI7PX9LifE+Df12aTN/+Yl3qYDjg+qUrg=; b=DE0GVInntwmVufEgb09OstqCau
	UckBhkcONgsf6Y7Aj3LS+NTjzt98C/XV2+RAZl+Fl6NCEtYB0LCoJbQGhWPjEPHt
	3TQRruPxMSO6EdEviloSyOHTWCgRsTirP98wReq72Peu9ggjt0r2Gy0c5dqdhUvO
	JABVu0kIW5a4jyCwz9PF+Vem7Z2xsywI5JZ9NCRqEVJ0DFgFTUzHsrZgzLk5XWfj
	mjmX+Gw6L14+o4bnjJ3NAWw+h5IJvz9nn+PJkljzSZS26eNMfhvF7Yog2b/7Uba5
	UuZUekG5rdbub5wuJivXKefCT57bOnVWGwK067LzZE35c+lXkBOXTyo1KLIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347831; x=1718434231; bh=2OrgQNZen3KI7PX9LifE+Df12aTN
	/+Yl3qYDjg+qUrg=; b=iG9BEZu2VXTW05mANbLG9Y6KEdBSgpa1QzgDvWDbc9fL
	r9B7E1Q5/yHL2FIe41HnzyMXZUHLIX0w7DWWfweyeZoStYLz2KnpWlJo6r2sj5Nx
	PZVzg0aWu2Zl+EJ3pCTO07YRgjhEkcpRs/l/A90LylnbLMfow94CkN6nzW9S2m45
	TqoZA7sQHEKDnjvk1n+Dyfj01mV9COpNYohz1VwGmx6+vXHw6fEyUKWHyLdynT0H
	TcDIVBmL7+z4dyfm2xGX69mWwamRpH6ElrkzZAE7L4d0RSRioILEBgV8krBOAC+P
	rz0tPZMcGkRLwKDFGjOzP4ZblKwZYWO5QWE8aT15iw==
X-ME-Sender: <xms:N-hrZsF1G39dPk2hHCJ59RG3FeBJ1tufYsfjoU7wHYukDtP3AxwTMg>
    <xme:N-hrZlWlXv6wv_yHdkK-D1HgGCac7TPuSKHsik5JXYVo81SiepYeiZCMNZNiGrOYZ
    8ZBvA1rh4xgyXm2fA>
X-ME-Received: <xmr:N-hrZmIbk24qqyWWppWukTA9ZcETQhz1ElIiOe9sj45QJH6R6zIHNxDXwNUtqsbOTKlm4WtzpqnNZkk5j7N608cxdXo3Kqj3oVIrzG6HhtrdTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:N-hrZuEgeL7QUltq3NVI3flATepaub3Yb5wFUYYlj28qk1zUmG1Few>
    <xmx:N-hrZiXqX7A_qW_OpYE9oYFe3tzYlP9To7PAUm_zGPneyoLrm_kOjg>
    <xmx:N-hrZhOMNrbbLEErDBilYd95EUYQ_q5OXExbiJqrOU0V5ePYYF_nSQ>
    <xmx:N-hrZp1HNKXK0Gml73jf5CkWtJ0X4ZLVsW_5-1_GhuDGLgLGahwz6Q>
    <xmx:N-hrZkeMhHKisiRjCLRBM-I8hCkWQM4JvNEC8R7VXlvdUDJiZ9gT8_Jk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:50:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7dceab95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:15 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:50:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/20] refs: avoid include cycle with "repository.h"
Message-ID: <74c88ebc39e345fef8eaf49311df89dc8d27250f.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mq7qi83If1Il1lgG"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--mq7qi83If1Il1lgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is an include cycle between "refs.h" and "repository.h" via
"commit.h", "object.h" and "hash.h". This has the effect that several
definitions of structs and enums will not be visible once we merge
"hash-ll.h" back into "hash.h" in the next commit.

The only reason that "repository.h" includes "refs.h" is the definition
of `enum ref_storage_format`. Move it into "repository.h" and have
"refs.h" include "repository.h" instead to fix the cycle.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h       | 8 +-------
 repository.h | 7 ++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs.h b/refs.h
index 76d25df4de..a9716e5d25 100644
--- a/refs.h
+++ b/refs.h
@@ -2,21 +2,15 @@
 #define REFS_H
=20
 #include "commit.h"
+#include "repository.h"
=20
 struct object_id;
 struct ref_store;
-struct repository;
 struct strbuf;
 struct string_list;
 struct string_list_item;
 struct worktree;
=20
-enum ref_storage_format {
-	REF_STORAGE_FORMAT_UNKNOWN,
-	REF_STORAGE_FORMAT_FILES,
-	REF_STORAGE_FORMAT_REFTABLE,
-};
-
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage=
_format);
=20
diff --git a/repository.h b/repository.h
index 29727edec6..6ce6826c26 100644
--- a/repository.h
+++ b/repository.h
@@ -1,7 +1,6 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
=20
-#include "refs.h"
 #include "strmap.h"
=20
 struct config_set;
@@ -27,6 +26,12 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
=20
+enum ref_storage_format {
+	REF_STORAGE_FORMAT_UNKNOWN,
+	REF_STORAGE_FORMAT_FILES,
+	REF_STORAGE_FORMAT_REFTABLE,
+};
+
 struct repo_settings {
 	int initialized;
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--mq7qi83If1Il1lgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6DMACgkQVbJhu7ck
PpRy5RAAkHtcBeHPm7IH33CklpfguYHGJ732H0M23KNeDkuuvr9RCYkv48t6zlGH
yWKDnVcvqxrDuBWDW1UDzknw0oPS62gEu1SOiGNApmd04a+vPDu7240ZOhMf6U0F
iEVydhQPD4zPp2sw3EkM2pyqh9ys2ZNoutoDGgkXQyH6I0yuuw+EvD+yA3XD2w11
EIbiZ8/090HT43aLlV5o0y8ICwQai+Okjcg0Eq94pzyYfEbV1I6WN4dR0/TlxrdR
oxEFjALnz1FDBB+LB7IHM6Y5Chon60Q2VE/KilzU0HWNYBGYlxVjosclSYvMRVNP
HNsYqmPLndvlKrUFhHa++sRuJ7a6LLG9bebgf1D5s4X1M7DyJWBWfj+66O0mhcNo
rMIpU4TJ3qBfS0UlzGlbYiyoClTJgL/HsfrBbQH+38Qjo67r3AD6x2ssOeW5b8J6
2V4VRjRN5eqxTjEy5hRqUBJl3zYuOCtGlVqQC1EG56jEetGzpYPfVZb3UjWjdZY4
YXw6nts4sJNSp4uC/qZLrO75RrI2PuUvkrswdfV88D8Cin9Aj1WjLNIdanlY5bCp
Bzh0TTfs3EKubZOtqy9hLhtrC5R4OZ1onZmladthLM8jfVCrWGXRvOOhjBrsf2OM
wBofCR0HuL6nZNlXlLPvKu28TMiVvRM2zJdu1IcNYD/VlEyserM=
=92YO
-----END PGP SIGNATURE-----

--mq7qi83If1Il1lgG--

Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334F2D7814
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946098; cv=none; b=ExbEqRyeeSSVJD5Dv3ukojmBWpgV3J4X0TrYEY9IWuNDZgJ8ionddPfooKgcxPT+UQC4/CoheBXJtDtUkmUCOYuFvYoHsFD9Q8iNCbhs9yKdYIJq8oo7YBXKfmPPeKCShktBeaczShcdDzxcEfgUgGLWS6J9gydPqFEILCsRk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946098; c=relaxed/simple;
	bh=Iq9ub/vxJzAi81yuVvWp+kG+75Q6Ou9ctVP30X3alAs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bA9fHvRmIpr7WCVXN5rRR2L7SZTtglYAMfLOAlzbjxJmdOaevTk2L0c03pIuvpij0V7sehhbv++Y0abz9Io7RQ7ixCKUkUExX3iuA4kzF9v3J4GCLPTtXtQEjHCTN0ALEQNHpSZl6xFoEmL8culPN2rSR2/OXfVswE5Zk/NlqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Cg2iHdXW; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Cg2iHdXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773946088; x=1774550888; i=l.s.r@web.de;
	bh=GCqDB7vv1KrSEZPzesoLF7D0ZVy7yabvupEdpN1Sr24=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cg2iHdXWvWExr2/PO8vN+ISlQr7EOfExXhCXtz9rUcKCNQYeyQ/k2oLhe0fcNEcp
	 5PElQAipO13OOe4RRxnwAYapqJ3M0CnJDxzfh9h1SVwrQQ5SKjPax/3FQ2iC6+zob
	 X0Uf/GsCUz6OgWSd25hQX/Y4tuLksqRoyMWmmkbVU/Uti8qfyEZvRWHg3INnWdC+g
	 rGN5czjeXkKawnrnudBbKwm1GCW3+x22sl/JsfLRodoXOBHhWCH1vBgnF3TRCJowR
	 U/aotFoUboZr2wrdxjzE2TV1/2M5JYBCbipKhzbxFPFxV2Oe9FL/ncFCaG2CZElhO
	 xe+898V0yra+8uNElA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK52q-1wI5As0554-00PlVC for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 19:48:08 +0100
Message-ID: <944c2331-4dec-4c98-9059-f41dc204ed86@web.de>
Date: Thu, 19 Mar 2026 19:48:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] split-index: stop using the_repository and the_hash_algo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Nluf7Wokcdc1meKfiNXtK/h12WPvTCnyJWh0fzQe8xc9KKm/mb
 DwTdH69kdONb7QiQANgF/2SHwbb0QhrNOXAYaiX36zVDg4xpbfnVyFLUL44sXLLryODaGsQ
 2E4wxEY6U836UEoVQtNxuENzr9qPe2jqLEqLVEMREPeQYR1C2Qp7mQMbd8Ux86rx9FdopvB
 LVqd2dujOyWEwP3JuPv9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:llnwPd3CsEc=;IF1XYtjhEBglZWZAvcJkAIChCON
 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
 XR29UPIg=

Reference the hash algorithm of the passed-in index throughout the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Low-hanging fruit..

 split-index.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/split-index.c b/split-index.c
index 4c74c4adda..6ba210738c 100644
=2D-- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
=20
 #include "git-compat-util.h"
@@ -6,6 +5,7 @@
 #include "hash.h"
 #include "mem-pool.h"
 #include "read-cache-ll.h"
+#include "repository.h"
 #include "split-index.h"
 #include "strbuf.h"
 #include "ewah/ewok.h"
@@ -25,16 +25,17 @@ struct split_index *init_split_index(struct index_stat=
e *istate)
 int read_link_extension(struct index_state *istate,
 			 const void *data_, unsigned long sz)
 {
+	const struct git_hash_algo *algo =3D istate->repo->hash_algo;
 	const unsigned char *data =3D data_;
 	struct split_index *si;
 	int ret;
=20
-	if (sz < the_hash_algo->rawsz)
+	if (sz < algo->rawsz)
 		return error("corrupt link extension (too short)");
 	si =3D init_split_index(istate);
-	oidread(&si->base_oid, data, the_repository->hash_algo);
-	data +=3D the_hash_algo->rawsz;
-	sz -=3D the_hash_algo->rawsz;
+	oidread(&si->base_oid, data, algo);
+	data +=3D algo->rawsz;
+	sz -=3D algo->rawsz;
 	if (!sz)
 		return 0;
 	si->delete_bitmap =3D ewah_new();
@@ -56,7 +57,7 @@ int write_link_extension(struct strbuf *sb,
 			 struct index_state *istate)
 {
 	struct split_index *si =3D istate->split_index;
-	strbuf_add(sb, si->base_oid.hash, the_hash_algo->rawsz);
+	strbuf_add(sb, si->base_oid.hash, istate->repo->hash_algo->rawsz);
 	if (!si->delete_bitmap && !si->replace_bitmap)
 		return 0;
 	ewah_serialize_strbuf(si->delete_bitmap, sb);
=2D-=20
2.53.0

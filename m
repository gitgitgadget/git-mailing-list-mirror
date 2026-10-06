Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414E376BF1
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307060; cv=none; b=XZOkXMtxHnOX24yyx8e4bvEOTWSy0uPuEtTSaRGxRE0I3oMqplOXrKp6GeNGSblJK7ElvXBz71D+TPmlION81cPbDMiUmqI0hfr7H+ZHxuwfNyV5j814WhzAwb3diZCOdWD0jwVk7EJIeC1EgOOGIO/iUgnu6l4+6Ioh7pC3TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307060; c=relaxed/simple;
	bh=YW56ziIct4zHuZ5bKeYRRisstWDiPaDqzgFx5SBGH/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCjbbGg2saGDYwdUwwzqVX+Fsmt95UyM/Hq0tvgKQ/XQeDAcJ6CDEYApxwk7FgHesFLL27/1VCX/LN9CqFLNR58yz6Qh/2Y/AcWNIW/JwGLBpqFE3N3MeMyuzeR7S+7IppkJPVjeGaWqeZF3EV4vuKtL9LE1utsD3gAj/iP7AbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvq+cssy; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvq+cssy"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677d35fd1d2so2503603d50.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 10:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791307058; x=1791911858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fa5LNN8hKTXTjinNxnOgIZdJMnvTLr24CqRH2lelqRk=;
        b=lvq+cssyifblWEGCpmYo13MzI6XBOMxBDytlgOwTkw9ZnAICP60dWg9Ou8yzPGKpIr
         CTaIqqBPjkG4VrxHovilMA4umo0nBVssOW7Mm5WVLLvRNk7eMz8waNhkkv6ZWLKFOWw+
         Ank7b47hm4YQPNrRHuBsduECwvkcRv3bKKoVdtNK9S8+Htgwz6Bcfy0PuP+xgJ4GSayV
         m84pq0mu60OQE0nyg+k+jazwKzWOf9QvQQ5RaF1PsiRH8t6Jz9YmPt2yy4fq6irUymVk
         +AamAs+sRn68K4yT1vKMBuiAgBITS5esYliTcp62QOc+gKwKSb7c3G8VmBfIvBnfiMTA
         ri2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791307058; x=1791911858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fa5LNN8hKTXTjinNxnOgIZdJMnvTLr24CqRH2lelqRk=;
        b=VTPz6Du/vmKIEvb7O44JNi09IV6JbZB85j4YIwOslarydEsi4jroo+2PVV2jCSvju1
         +76Qes8hZeZ2t97ivb4/mD25Ve9qS26v6OLv9WtpBVCkQIc3csiy+4lNq1JNGyuDRQrC
         DfHs5rcp27yfaIV1FdAghXswQFhPmEdZxpUwQSf2gwWrnk2gsvyzMrp7RbFXiGITIYg4
         1xzPqpp8PAaNyrHcmvvKoKXVWYD2TKpXv6jzukWn+BwexWQn2akBlJo65FoWki70asyN
         aLic3CN4I1A1gHMU8pwUyxNbQLs6w+GCmylLXlhpD1a+IyR/MZBUGOG184HLobtfIUDr
         FZJA==
X-Gm-Message-State: AFq9FYIgmwVTZJmY6FTpj8gbXkGxzLapmzYBjbEnLkw/9jjk1axSraML
	unqK3aaW7NG5rM8aGf2hkIRhLAUDT76YJcRl7Vb4ilZjejRyCdxWBbRsy2l9rw==
X-Gm-Gg: AYBFou1kWgHb4CqtJuKRCoeu5WQ/NTMHDJb/WvGY6TVxhrHszrCH6sAaqlrBYHcyDnA
	98gozz3/HEz0C/cysbiZGGCYTu6x7orLxncrYJjyk7opevW8w8Uc948Of/NJEpc0jOHEXB5qV94
	VjMjwnFvodq7YrzGAAp5QvN2LV/2C5Oda935SEqHaqM6bRNf2RFv/p3Bgt12zaaXfJI+rrJJkgP
	HjYFPSdXvf1o4o7bkUkF+c7lg7/3zkdA2I1kkCYDayXvuh5HtKx0fwDNNs4ipkjigX0d1fCj7KQ
	QM5heuDKxEVpkZGxElBSbk1wkWrAdbbtCFnECh36fN1a6nEE1rsayqzuG9qCLOjhSx7db6jMQd1
	hGd89yAEy5glmjIWuCL2uHR1+CgZdW4uSLSCb1/d3EDh8DSeLWssb01ePrdvnGTM0zZpNjU2rh4
	HVl1SkXYtoqTIrrILGjcLjoUejXf7+jPBUPQZ7gVwpAWvqHMGvP7z7zoWlM+lPBhuWZ3C92tUiQ
	ZRMuJbIqrESY4vpwQIW9XyzKjYl7zev7KCKZ3xXWFUJwPaVef67UhKzy0i/sKt+yxfQRiokWVgd
	x+RjOKVFMCq7gl+swIdhV2dWFroCpSpJtn5GxS1z/Jh7hdEkzXfAf9Yb6k1zxaWzEIFiiSTC
X-Received: by 2002:a05:690e:c4a:b0:677:a8c0:38d6 with SMTP id 956f58d0204a3-678fcc5ab60mr969667d50.2.1791307057927;
        Tue, 06 Oct 2026 10:17:37 -0700 (PDT)
Received: from macaroon.lyrebird-fence.ts.net ([2605:a601:9092:700:6d45:c6cb:359a:ad0c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b4a383sm4857189d50.7.2026.10.06.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:17:37 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Mae Eckert <mae.eckert@albellus.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: fix shattered.io link
Date: Tue,  6 Oct 2026 13:17:19 -0400
Message-ID: <89f21a129df21b115d5faded2a74a8a5921d62cf.1791307032.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <164ef290-463c-4a7a-92d4-00a56aab71be@albellus.de>
References: <164ef290-463c-4a7a-92d4-00a56aab71be@albellus.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we published this document the domain has been taken over and no
longer reflects the original content. Link to the last good Web Archive
snapshot so folks can still retrieve the SHAttered information.

Suggested-by: Mae Eckert <mae.eckert@albellus.de>
Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 Documentation/technical/hash-function-transition.adoc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/hash-function-transition.adoc b/Documentation/technical/hash-function-transition.adoc
index 241d2f763d..f6b38ddd50 100644
--- a/Documentation/technical/hash-function-transition.adoc
+++ b/Documentation/technical/hash-function-transition.adoc
@@ -29,7 +29,8 @@ advantages:
 
 Over time some flaws in SHA-1 have been discovered by security
 researchers. On 23 February 2017 the SHAttered attack
-(https://shattered.io) demonstrated a practical SHA-1 hash collision.
+(https://web.archive.org/web/20260207211148/https://shattered.io/)
+demonstrated a practical SHA-1 hash collision.
 
 Git v2.13.0 and later subsequently moved to a hardened SHA-1
 implementation by default, which isn't vulnerable to the SHAttered
-- 
2.53.0


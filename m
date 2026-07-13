Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16456425CFA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948672; cv=none; b=PwDbVUNBJkZ3JeqWlo4sSpXJqmIOAsmDeA+PSd1m1hnbHsDX5nvXEueQDEaE1l9ALymBdBrRGu/1DsN/7LEaOZMisT8QAYBaNuNYRBd74+A5g/nYCyOQNU27WeuXHw86nGZvkMNyC9NPQ/SMqn8SQqwBfXhLKWpTkeGhmf4qkDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948672; c=relaxed/simple;
	bh=v11x1F+55bSv6EwkPW4WUwHeSRDNXy4hKQCVeMjaEZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsZbjjPQQOWUi5IvSHMx9QIXvLtSSF+679T2p7BZlty7nhBtKpvzVXTOt16r70eCQJ37clPTNXTQtO6vFmcr3jJESIgu0S8PPZe/euJGihxAkbCPOs0H454mi1lqFIBFxmdHK6k9s7OSrj9rix8dJr47lMgyw1P4ZJ5QxtViOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie3Ef+RX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie3Ef+RX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f140ca8eso19832855e9.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948669; x=1784553469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lD4K7mxrHxDnK7u39v0fHd1JNSLZp80gg90eKWQy/ss=;
        b=ie3Ef+RXIrporCv+VJQeZH51FdF+9dLWiRNxPH8UvkywcQALCtjE1wb1SjoeABNRtO
         sB9UQp8YN/HdZLJwujd6+W9kxM8S64uhdDcBJKRlrsHd0fq4aSDh2lPZLJxlZaKoo3Mb
         Gol2Lh8AFFf0ocXm4zN+w4VYMM8ImDn5a1uCVC/CXjBfhUg7xcVHhDp7+XxH2XaFjQbI
         FAn+5BUXZtF8RlHyQpVG2w69dkGJhoPSt7dNbOGoI0LwAoDFScfVcuDAD7oBSexatoQu
         Bhqg7aI2BCKu+Uki1J8ZVdhWVDdCt1NlrOtLKFslGdn4hGKw+tOVl7iqfaljOijrzix2
         8tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948669; x=1784553469;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD4K7mxrHxDnK7u39v0fHd1JNSLZp80gg90eKWQy/ss=;
        b=Vh/wjcyV5trcUSsrsgtsBAfJy0XKPmuJOHM4Ykpr4WADDaLjSkyccHBLSPYGKSw19Z
         C/SdZ6iTxYeGmxpSd80F2xKYhSxOP4+AJIiy3Y4vsGXTmj6L+PWhmrnVEic7f2NyHq3e
         fY8WSG3eZY8cvl7oh9ZE8B3aqQSOiav1XWbQToehveZF7glcEJ8bGNHe+q6XYspW0EjE
         qkiugQpmIBIB4Qycb0fnRpqXGsgt0HZhhNfiQyYKaCrdI+ywX1X5VfD1863vA5aRtadH
         8yIpbqmzRDM9dVKs5UM/NU+gK6a4RoFkVezKgwtWvgBU84JwG+a8zH8qawCY8ZdZdd7V
         DIsQ==
X-Gm-Message-State: AOJu0YzMjAANLNKIkcvwWJIHyqShMVV6O9arOguegpdJdA5bnpJ4yHoT
	fO5X50iL1tuZ7eKk114kisyVSLLclrZe3iTcA9biXT0cNhbetDNt9UHE2CEtew==
X-Gm-Gg: AfdE7cng//RYyqZmHaq1TkKTQ1glxdWJLZGXw+7/l+p4Jif+MSUFfvXgC6+3FhuxmlN
	uyq4qj0H2sHFChNgOus44WEMaa12kvUo4YF9ST3hahffRUlJOhDpu8L2yWz4o1YVAu/mETUc5o+
	pV/ndt0N8Xyy1+52CsIgLpEbrIfGfNaNtcNGL2XMZ/8FwK1Ys7l/zt2jjtyr+SpBtyfzB9s3A2G
	bZmvc5HgulnW9+CAwR5h9HwJi9kwUr1aQhaf65iurv+xOCQPgRHzdCTancCy8vwh2j5ps/KDUm/
	8ghu+rTl8dwY0BGA5TUIFhheuTamglOPpzVCLtUNqOxL21SlwQCwtKp/GA6HKjZi/LGCjKQ7YlQ
	wcMffxTUdOK5S/qWb0bhKbEljDvvJRXESEbN1CKAaDANdHVD470w+m42xCmKSmSj8rNZ1BrXsN0
	kDU8xOoAskj1dMuKez
X-Received: by 2002:a05:600c:4e41:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-493f881f9d6mr91128925e9.22.1783948669330;
        Mon, 13 Jul 2026 06:17:49 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:48 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 07/10] sequencer: remove unnecessary condition in pick_one_commit()
Date: Mon, 13 Jul 2026 14:17:24 +0100
Message-ID: <71ed717d3224dbd143fe0cce8adfac65b7ea4ed6.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

item->commit holds the commit to be picked and so it must be non-NULL
otherwise pick_one_commit() would not know which commit to pick.
It is also unconditionally dereferenced in do_pick_commit() which is
called at the top of this function. Therefore the check to see if it
is non-NULL is superfluous.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index a70889a107e..5f5ff3783e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4988,7 +4988,7 @@ static int pick_one_commit(struct repository *r,
 	if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res && is_rebase_i(opts) && item->commit) {
+	} else if (res && is_rebase_i(opts)) {
 		int to_amend = 0;
 		struct object_id oid;
 
-- 
2.54.0.200.gfd8d68259e3


Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B93CB2D9
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029526; cv=none; b=P5bl+qfoEE7mbrVRNd1ohokWAhbZNTcoprYYBv4HHcUzn6nhSzLKa8lqm2XjXM3NaVPUhrGeZxT9LLInBjukRe0PxhXRchh9VhV4pSYBcGfRv/BNewYXX3NiIOwUZVqjdMwoBLc7lkSUic0b4hrae97X9RqmWS1BOSSZH88e+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029526; c=relaxed/simple;
	bh=O3ii94Nu2lk9CzI5RsmaOeG00pEjPXoFFmzPVD1ftEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gK7JAGBg2HmgzEDVVjLZ6qbpXDWWeoRy+7+2ZWneS0pQILVfVCUL3XK/eWMCclgMWKMXxivMMkwM+xDTID53dxF8sv9E3wnfp3kGqti8uDjP/pjQFMYKuhuuWl5RUWMIq30+usJ1tYJC+qYE3IcSCMU6JwBAAnTa3EUo/30S8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tG01F8Wn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG01F8Wn"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso30682325e9.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029523; x=1784634323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=tG01F8WnZpks4ZTSC/looYi1KYaBWMc7ExbxDpqxLKQ+dvsDJBE3jMyYe7m+Z+lIJC
         sq9dfUt2Yq29XeWcl9fyh2ds5bYwKEEE2JhCV7OeOU/uCIW369iHkcywJvm4OKhmHhKU
         jm4kOxJdKNaQjs+opigpAu6UZJH/7rdf1odFggynbpaG9ngloYa6VIj1f+fThzYpAH0D
         A4WkU35zgivbpEVdEI93dP98Rrb7b0zgluijc6hBYCY4JPkHegqE4tvLOEJxaGyd08CZ
         Bb028/wCl8VxALHWuN9brCR/FuPB6HCjIMUp1h494mPAHYnM3gDcMAGOY67fzrBoK5De
         j3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029523; x=1784634323;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=c37wTYZ4ROJ0ypunhNKoU+XGp6MNPa0NiYC5Q3toA4qcdNOkdQxnzm/ltfUQdo/RSZ
         E2aQ02H9aRGNoxRFpK76+/YToPDNAA+4MBUfezAnO8TgFr9jjv94sVm3Ut8RdNAnXXIU
         rxlg4M7NirPfBFpltLWJ0LqFV1kZzU23mmFAWwEcJeEgIysIJ9d39EVRXspG8drpPqK2
         FZqqdgAeAVWh9/BRnKcGXTffH4BH2iSaTHA+xqeNs8ZvWMDtEXREFLUpcTnHkMSO9TQK
         bbNf2JdpqWWIdYClLRLSeAY/vfdYepLH7e16XJYTRXew+XrK04CzqM8p/sT1oLjhHMQG
         CGgA==
X-Forwarded-Encrypted: i=1; AHgh+RoFptGvl05lL41mmuEaSGsYOxE2jxp8Bwx0Q2iGY+Pjyd2SzIirEOKYeesnZoJq5Ns6vVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDwoemS03Q/oiry98P3mVx59h90HZFC06/MnipOdUNzCWPTjL
	TaXJR+DEW7PT/Yj5fLPVPvdhXfLIPY1AaMX6QL02OxF73MFFfHJsNGdP
X-Gm-Gg: AfdE7ck/hOJxoCxtOU170M8Q+2W+Hmo8xWARKLCAwXo2BFUQh2RB/rpbSfOGsUsRyhi
	Rlfg1qHuAAZtPFD39SMj1MTDjbiN9vxxo5q1c3VDOjGgCn76gGhNF81HYoQOzmCK3fQZ6zpXWVi
	9wCZPRFITVMHXt8v7T/NE6SiAuknU97hwBJ84htBGaRMvK/nHjQ1Zfj92YIc4SumkEzQrrTRGn4
	UPTqEn0N7a2njAGRaNKFn8LHBzJh/pk6INAfCNxn2TSTwsZtAgzB5gIwNCzxy0Eg0k3+nLdIeDD
	RfF8N0TWRthO4wu1F35AxrlAT2/ZI7PboyqhPWsbizKNQE6YlpOx1rwq3jkqm4B8F/PAOL1oTvg
	airz4jzjg50n/zenWUCTknFLpHDr37nPRaW/ve2pfWoL4LHAfJ90XpKJWCPz7nOpwrdziMRYaQ8
	4AI/9b5D8BoqFA+ZeVFji+mZX4gfeu5NQhgnRsLziAb9gqG8eTcI4I+RfLQlDdXYU3/xlUsQSiL
	cf4xmrsTXM2Ft63lyxoMh+Oie4rKQ2OfnBVqsQBRbvlxn0fa/4fEdlVWKChQ88K8ioAiO4z/YQX
	ThxMz5w27u/uJxAbOVSDv2wLJRLhEYuBwKya6wpt3P9sy54mU2SL21l2M0DlE51iATd2paYaeNz
	vatK/xximsg==
X-Received: by 2002:a05:600c:c8f:b0:493:ee2d:d221 with SMTP id 5b1f17b1804b1-4951830e408mr36397925e9.31.1784029522855;
        Tue, 14 Jul 2026 04:45:22 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm179791355e9.2.2026.07.14.04.45.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 04:45:22 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: pabloosabaterr@gmail.com
Cc: chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v17 08/13] fetch-pack: move fetch initialization
Date: Tue, 14 Jul 2026 13:45:04 +0200
Message-ID: <20260714-ps-eric-work-rebase-v17-8-afabfc83260e@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
References: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
 <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized in
FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 783e3474a6..2ab5ba108b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1735,18 +1735,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);

-- 
2.54.0

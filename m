Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C0D42BE9D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109160; cv=none; b=a9SW2Tjer6AYFy2HjqQjyzjsOfnj/WHLcKRpyNqr1MxJa3aK+FBmA9pWgr3Hlzm5xoWozpXCcSFIxrTYZZl7t6NqPWizpO6Vawdc+zWrkYfEmxNOToK9ycRjkxGVog+uz+2IzgU21uIa0Mc0WbcJEz7m6hbYO+JYp87lfHHLvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109160; c=relaxed/simple;
	bh=O3ii94Nu2lk9CzI5RsmaOeG00pEjPXoFFmzPVD1ftEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiBy0pdrMFmuktgDDwAERT8VjdLSS7pl10FUb4/g6JP/AAHrp16PXDEbHQ7jpu/SPUsWj+bDnPCtUV6aFgRxQszWk1US9QVGYXSZ3vJUGZibASefgtILfH36muoI6gJUi5Df/wy7Q25YFHX8Vu8uP1Ul6UYsUUYWE4XjvRXC5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+bkUmnr; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+bkUmnr"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso4957120f8f.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784109157; x=1784713957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=c+bkUmnrOZRbRr1dInfxduiANpntB/gpP0YhEEvs2uDNfp9DkGhM7qMGkvAq2hCuHw
         WukHV+ppar5oEK30RmFLcHepTVtyOVFc51ew4m76o0evwnUKePZE9CQqxFrpd7xsn3lE
         y8ygEopjnQl9VJLUmfbEmevH+6UzJdbaig0AWYiQjqA4STKITAnGyUXb9S9cOHHFO6zc
         6r96TIfRiDwnxIh3cuNVAEuiC+/oTqJQjm9J9FqKBMFJKpDkx2TldG7JfDKycgdjAX/o
         voLG7VUNTnU/s7RIPmh+FHueLmAv4PXRLbkFcfawQvz1X0lQh+/DwxcegVb+vfR5pyji
         ysZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784109157; x=1784713957;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSZUZBdyy63NgR31jxoFmbTeSHpDPCPd/phSzVEU/7k=;
        b=Vf10HOfMB5ugfmT1R/H6AGp3VLdGI09nR0lwqwP4NhnIUHEBDYtU/+LgqUB6TGZATf
         u9k2+94QZaGVR9v2LZZLwBIVK1EnWwslt+0wROnXN9Z6XgfOHvvH1lqJPQ18M0WJ5SVT
         gkF2SvUQ7buQ8hWVvGxg6DjPalheFHMbzcvz8AxseoCLVdMt0wR3hZ9e9otfiJKcAZZi
         wNK9ty+WUIr18SvIDyK2yLw0zfIm82hvXUiHe2BztY8bQ45qaIeydN2c1V9oO72ADKwT
         KH2AGHi1di7uRNjG7/VYq72fB+eJLcZDxQKJSBcJEBBU69N6yi+5sU98B0xq+2Y6oncS
         Km3w==
X-Gm-Message-State: AOJu0YynUkPqbBfMahOV0FDlCepV8p9G+H9nG4yuw4Ip62/tlQ2RfDlu
	OTGe+4UfP4wxuVPK/vwtQQOEnZN20y6SbHK2b8Y4ITKbDcE8m37fD7LDzQqq3XkH
X-Gm-Gg: AfdE7cmM9ZpQuDsVA5Ecm03l9nIwEm1W9EcEQlptn7K4VAjZWeaRrMa5pa88rViQg+p
	fz64/09e4nCfTzzLkbERpH9psAqTH69Y/5+zjAt0hAvtAfJy5xBKC+Xw+HVcsSdOiMr3+WMMXzg
	X9ozuInKjXyXkiKYv6sLxgMjpqrjwhPmS0UNCZRLLKiammc8M4W3BD3tV8eo9wp1S/AkH7vW+PD
	aDbPiuO7IrXuCAjbAC8y5oRPkV+CgpEEdoIpdsrIiAWgvQtmEzFYYgsJgTCFX6TVHMk49Be707D
	xo0o4zyOHbIC8UtClSYcVZfGd52yEWpmjjC4YVDNqWjUgFMC4DtgkUE98uTGyTkmVMF+0+bc1Zt
	lvnBnHoQp+TNWU3EFpsnlU9QSX1GixYCJnEYBPBm+UOljvaGzDJbq2Ec5wHNoKy6Z+Yzl9ell8Z
	3m+8OWLHceLnpj4h1AWY0Y7ll6YLfl5L0ZN32UvINpGtJ1vKQ7R6Uv0nrxTetRReOwVK2kkdNan
	iMPyHUlFpPfeqPpRSzYvTHDZ3bTvZS+OdLZoLGhyQ4yo4hyOqtN0mu3jmkgFQ1D0FvRU2i2s2r9
	Uat7cWaVjwiRq/6B4qMLQBtxDIs2ufhOIafyqJHHJYM7Z8rX3DID5VvpB7oZUNwXIjOBs2Q0FFS
	GuQgQ+MQqBGOX55k84VY3
X-Received: by 2002:a05:6000:607:b0:46f:ca9:465a with SMTP id ffacd0b85a97d-47f4fcd5871mr2224309f8f.21.1784109156777;
        Wed, 15 Jul 2026 02:52:36 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm15630419f8f.35.2026.07.15.02.52.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 02:52:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH GSoC v18 08/13] fetch-pack: move fetch initialization
Date: Wed, 15 Jul 2026 11:52:16 +0200
Message-ID: <20260715-ps-eric-work-rebase-v18-8-34d7adb051bb@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
 <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
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

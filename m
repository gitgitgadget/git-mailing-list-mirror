Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9F8632B
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774327687; cv=none; b=ZEzCR2fs5Pk3ZYHCvUEEA4JRbbXtgUYAtKevZaT7TIPcnfVJmANRmrTqRhP2lL5M3kr/Yx7Zw2y8mD4D4CZZLGT5nveeuIOdBsVfGKIh+1IuwZe1gVlAC/n0ykhqUnwXLKSIbbijjjwpfBvN5mFD6u++JOdBAfYVRbD4suaOnpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774327687; c=relaxed/simple;
	bh=O/tTLHXWcxc1FI8hBYYlHAHjrUm4mn4o1s44U0K1cU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJq+eeIDgJmeZ3j/fTU/EhKqdQQast7f6zpWGIwJuxkZM45PyNVH2YMreGFKimg22dx2XqktNdslDuJhebMeIP2DdoEQFw/a6CpfM/219YaB7SaOdEV/CsoLtwJCM2g6cGOo1C5l1QbTgstOE0fK5y4Qb5rWEnJnYhMgTqAAJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa7sfPD8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa7sfPD8"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a034ca40cso502427a91.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774327685; x=1774932485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtDGSNLoe9TqJUicW2x+Y4fgaCYYp+MdhFCXfktmLAo=;
        b=Oa7sfPD8id9qcFW91eqt9BkJh+m+TXoa+dP8co+BsD3BcCM7qsvsTmUjkjkaaI94r6
         nUvBBLYZIdr1niQAli53BZ1fHIRkzkBEAMfuy5/25DI5B28BbQNdmryGZWcky7d08bZU
         MnS+M21PM5EsiuVkwcXW/VkjfvwPOMKINWP7zSAzkVN52pTLlCzVyFTriEBC2wsegWzJ
         qIzyYlDcaaBHrmZflPq0F8x/NcaSm3dpsbZEAHx9Am/iUaoT9Jt55b1PcezCOeWblDlA
         Tt3BcoqMvISogsyny983M3d0Rxee6OCLndRMMhcLOjFb91nn+dL8tYcPjKE38gWfqjjr
         o2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774327685; x=1774932485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mtDGSNLoe9TqJUicW2x+Y4fgaCYYp+MdhFCXfktmLAo=;
        b=nvIlLfdvLmumYDcj45ERUjoENz/kZNucsWBx3FXgqZQgtxV1CAiNQzUp2iWY7pLquB
         oPZmgxZWicyzww1vD2rqG3OznJwiY3JJCYmudxPR6kIWhLZq/Lsk7r4dL9MQAXFBJbvS
         mc8sReO1+X5RSMbeispJTe3ASfnLeblcyVVc/kkqc5n/xd2zfPOGCKF5XxkXBzvkBhWB
         k1ZJaizol/jAhefMox153FPmxjMGQJkxfQjfCOttOAz8ygytCqmbS5CkeVPi3c8AVP8+
         5k308KxY7Bvnb4Vf25wyuzCBRVWh39VvGwxbesfIpvdVAzBRF9lu/JZixmWTuBMgsz4O
         VT1A==
X-Gm-Message-State: AOJu0Yy43q7acR2y8Gmpdod40+FGiUgqrz+cOv28U8NZkNh/aFcLN6px
	sgblMx02fe2MyYQYULs+H9dPZRuR5/vgTFL5k1SvCNJD4IgFJHaHIhRVwxqZ9Tlx
X-Gm-Gg: ATEYQzzeMEMpjQPxhN7YjF/WjH7pqoiC+oirm8+/lkgZK8kOrqQHJE1wUgZt6iIzAVm
	Xu1cLvyDiT8lVPam2sfvmy0UqH1Y7xOsKnPPvj8SLBCJkLnefyB0vQqfnKGabZ3PzdPck3wrm4g
	LZ7VvWduqEp3kAAC+WeUILMmM9sJQB+XwZnZKlR8ZVCNYoGyvzSNFiJXK9sDlg4tVF/4d65PFf1
	h3BINd+kA01Arb+twkJlpBqd7Zzgsf/qmXcXTlyc2mJy/m35UPXOpYWdb+R/XD6auQKsTUErK0O
	79NSRje1dfcIvyucGxYRsBGCobTwr5ngo6qFK+SMDjTyc1dlmWtTwAgO4RmHBknuEbCYTWUpoTL
	rhoXmn+ab41lZbJ4sdM+1vkn/wiGkiNbec+Nu5o4t+gTP/99Y330rtV/kdIAMieKA5Bmtg2thCj
	iqEI4BlTxdNhHK3zFz/rxmHI79KgW1eYFxLHEcPCU+9jZV2dfnkJ0a20TItXXKxmsm3i7Fr/0=
X-Received: by 2002:a17:90a:e7cb:b0:35b:90e7:c450 with SMTP id 98e67ed59e1d1-35bd2b8a355mr8265541a91.1.1774327684876;
        Mon, 23 Mar 2026 21:48:04 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c031ed064sm774640a91.9.2026.03.23.21.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 21:48:04 -0700 (PDT)
From: jayesh0104 <jayeshdaga99@gmail.com>
To: git@vger.kernel.org
Cc: a3205153416@gmail.com,
	jayesh0104 <jayeshdaga99@gmail.com>
Subject: [PATCH v3] t/pack-refs-tests: use test_path_is_missing
Date: Tue, 24 Mar 2026 04:46:19 +0000
Message-ID: <20260324044619.43944-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
References: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace the raw file existence check:

    ! test -f .git/refs/heads/f

with the Git test helper:

    test_path_is_missing .git/refs/heads/f

This aligns the test with Git’s testing conventions and avoids
direct use of shell test constructs.

v3:
- Fix commit message to accurately describe the change

Signed-off-by: jayesh0104 <jayeshdaga99@gmail.com>
---
 t/pack-refs-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..4a85d96c6b 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
-- 
2.43.0


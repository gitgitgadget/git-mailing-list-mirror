Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AD376465
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368880; cv=none; b=fqv3fHtnus31Fdbf4boQOG8Qi+SKjk606WvCDe9W9lOeBp803Snx2wQoiHIs35bGI79CmF5OSBPLjf8cUf+3T5KViGjvbJGvJGXOJtOskY2nQo3aXdrfBeDUEetIcmNlvTchu9TGGoy+iqxlryKa3xnNud40sQu5hUic7mG+XGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368880; c=relaxed/simple;
	bh=3oa9y6eGdkhM5KRbxTyu5dWD2YQyJ/uffyBFXic2qfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkayHolmG9QPLRkDbzC6GtQxbNaUX7H7lQd7IjOCQdPkLxYIp0ApPbN9dz31qmyJ1fPgLUgKhsmr94rg9iRgmGNecsfLrsi4M7vENnuKNNjRGkG6Q9CLhcagwNtzCmkt8pFpotv8QcEmacM5cPfEA2DrosnoyLqucOI3n2DPN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b87V+awC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b87V+awC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea8c13d94so12207135ad.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774368878; x=1774973678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDlQJf8TVHnO1XSAHqH+hGgJcMOL6FmeuqQE0Xu2lRo=;
        b=b87V+awCkpA/gttB1cy0xiL4NhzaBtjDKsjOT2cEvpBWoqOkyjuyMDA+gwP/l++d6a
         JUoM65y1OSbvvGcGmRnTrp2XjIPELHYkVhur5HGZUvt4GyxPtVhikFL/KPSH5RO45rvq
         egQGBuj+l/tQKyPaL3roebG7kAY4Hz11bCdy/47af5H61Z0iT1N5W6hRaFvrZqH3XztQ
         ujr0TFhZxNCYoyqyH2nbCy8r0NlMa1iGH7lb7DodePEt6ApUEB9h1OxQvWIUivqHZd+a
         IacYZhMUqieOPBoPU2FZncUgJmv1Rz0UEfl3H1zN89yJM/hAgKCEJaEwpAVnsb002i6y
         nAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368878; x=1774973678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDlQJf8TVHnO1XSAHqH+hGgJcMOL6FmeuqQE0Xu2lRo=;
        b=pgK0UJMiQmZnj4p5kh9DXJd84DgILKKfKMJ6koTpKu6RLbEba1kW1WMreE+h9hV+uC
         f9d3KuMcqj0DdVY0Z2tb0ybQ5XRpAI+ePz+DG7LEE9paWbnGu/KDqYEd3AvZAe5L0mOq
         QcAXTHzz0GcHmi4M1CcCrKEsrf5ug9Ra+cBD96ynzrf64e9q55eixNI0PYOQ5Z52k74p
         jChwAWy77eV/9B/0DeHhuLkfyIR6xNUDOHhYNLtT3sqtgieBuMOVWmAXSKRABkE9y0tl
         oLuh5gnFEAJVk0VLfZOazaMRKTZSbuPxAX1zV0oDF0o0Wm3eXR5ypdxXl9bIFRo2uEhR
         AO0g==
X-Forwarded-Encrypted: i=1; AJvYcCXYRATpEiTGj9DOstnOLkJhnM/N1w6d0rS9JAaYiM8Ig8oFYq0ImlMc+QFNMiftYs6erYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTx6z+8MXVJ7mF0ThVEzzu/tmV3ZekrUhcpKIvVPaYm3hLHjL
	q26mtW/Ny7SVCUMa13ujm5AuKdRr04NyssFnJLFIx6hnIueNKgYcW/ra
X-Gm-Gg: ATEYQzxo8LFpOA2b8ewy78SFGhyZ6/NSXm/ufK5Wvg8j941fE3qEDlz7BVVMoo8bJ0p
	+3qKePv+QN5xjsOUM8iPY2BPRpRb4HqmAunhKaTNYIJtSrLXJNqHdJ44xWf1//I6VZlZsoRqz6G
	qavZxVbSIz5bqAj8Vrez+vs6gqhq4lKZm2lJcp/tImDxSXdaXf0xpN8PjzYouLHJcDumzCBcULi
	H/OOJxq1QZiyrY1D4nJnRXItm6+Tsvg/Ou6e/m7WuqRFvsAjyEkTHJ6sZUuNPQklzs8Q3ro1l3o
	HEOBXnJHAmt99VCHywGPSYCrKDVG9uC3kz0RDA1RKz4YG1kwQszQ+EHNmmCsuHK1Lf0ywzrAoIv
	r6IqSF4G8G2wzBZ3QYjt1wQ0fUBUNz2L9Y81KJzgCI4hslSlF6nzKRTXOzeTpi0Ali9v6ZLjBsg
	q1W8jYNUCaCPhxSM3TsU0u5KYuOqfGFBId8czlO1ENQV5z9Ct/0j0LbvGfK9H8xoheSlCpwbo=
X-Received: by 2002:a17:902:d506:b0:2b0:59c4:e9d7 with SMTP id d9443c01a7336-2b0b09e6468mr1832985ad.1.1774368877984;
        Tue, 24 Mar 2026 09:14:37 -0700 (PDT)
Received: from localhost.localdomain ([14.195.131.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm191142915ad.7.2026.03.24.09.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:14:37 -0700 (PDT)
From: Jayesh Daga <jayeshdaga99@gmail.com>
To: gitster@pobox.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	jayeshdaga99@gmail.com
Subject: [PATCH v4] t/pack-refs-tests: use test_path_is_missing
Date: Tue, 24 Mar 2026 16:12:44 +0000
Message-ID: <20260324161329.71047-1-jayeshdaga99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87jyv1jqb9.fsf@gitster.g>
References: <87jyv1jqb9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a raw '! test -f' check with test_path_is_missing
to use the standard test helper.

This improves consistency with other tests and provides
better diagnostics on failure.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
v4:
- Correct commit message to match actual change
- Improve rationale (diagnostics, consistency)
- Move version notes below '---'
- Fix author name to match sign-off

v3:
- Fix commit message wording
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


Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33123101C6
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691066; cv=none; b=THO60xmovJ9LyeAYxdEuF5CTBaHXKTbYfLeejXxoKzZD1XcQHMVvKU/TbtL/T0MrDt6tMp/t05KHRbTCciOg00pjnVtkwVfIBVve+m0qqvvn9FABlcHVkAbmTbJK1yLfLxbPKdH/1h3ZKtav5FN+y+Jl3Y/f2U3Y+57irhbosDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691066; c=relaxed/simple;
	bh=2hSrQhs/Gdiy8H8jb0zbC99GB7VXtxWxQtnWFj4bW/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvSh0RhRj78GMctm7DdY8soOekchOz/ey33Lh3IjpdxdYygoKedb9zu7v2QHPiBKw0tt2rKh8aeXEmW/swexrfmgxawzILeVZWvdCJHfZhI5Q33Y6aIB0bpnQYwGA5DFnVbCBPbcA+YtW03wfNJxb180uGpZG8Vi8vRugDO0Xas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf/4Xv/l; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf/4Xv/l"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso1134464a12.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691065; x=1772295865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=Kf/4Xv/lR4gYm/XnLN7PxJveRwUlzInvPAJy6n2BlS3t1IGF5b2SD8Rf0JMRZISLAR
         xlqTEvPr9QbUfYbjjGpCH7x7vc/KSmaFILZgkZAcn6knqQkSfb4UbZAgYt1fgjLiuloS
         La3zK++iXOl1KhHofn/uxi+FlACDHfPswXbEqSNeLt5siLjPqkkMK+A8nj/CL5eUsv/2
         aVS57+fopVVBuTrsF/Tz8KgCzgLQ3zXQc5jl305+2Q1wd6yOL6m1QeHh1/2x/FjklqQG
         bh9G3s1XD/JIccF04TRLpbKIg+EcajfcjCwP3fPnBNf0VirpmBBSSBhcwNeiWOqWwolp
         5fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691065; x=1772295865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xDNt/Zzqe2QM8rAhpnCYGapE0/IbHgkzT1igj6kHuQ=;
        b=ZdlZrk7SBrtoZBvTfy6bdQWJUJjyFr/pcTdMDsLOCI5UCVv/X47Nbg8dLQ9ptp3bqR
         AAulksmFDSHqC10+H/MDLbgNWK8ubPkQxDc5AmuHf4i9oksBTio7qGj95cWnmNmd2f5i
         sM2GdlxnhXqGZN0bXjN9vx5x6Zx3r2eJ2ynYFidB69xQnHOjFGw985XaTdVLa/mtrT31
         lukcvlEO9VMuNnep7EDtFWmbI1EQWPfd+8wQ4LhUX1srAhc2loULK2CEjUKV2mcjW5Mk
         9kfBaGTYK8RDDmLL+OWZkHJtCLIeMqC+PzHzPsyVWS3fxuDBTWhk49+k95dQZei8Khry
         ciAA==
X-Gm-Message-State: AOJu0YyXn4b8PxK+q2YwbZQtz9w1Vj6sBakUEb1VwtQ2Ca8zem1aMBa3
	f8Ey9oOL+4CO9DN9YpO/HeO7KI+muxiTNmAcBEoLDpWU9ppErEk4gitgSHrPAA==
X-Gm-Gg: AZuq6aIZnGXgkLFcrWX/g+IwYPrjFtWWYFp8UYf+HHqzuMEEfr71B7V7LYbHU6dXzs8
	4TErR1T9meZuFHccaRCQXb7uncWtxM/lTpsQ1YLotMFhvmiH2a+UPIZeaYq4gjVaWJobAQRh8TY
	U5DygRKYx2zGCoaEb6LZsNl0kDPJ5S+G4v6dhxtGw5i7I9XbEADQtOwb+gHICGxkiT6EYY5qJCm
	ry0u9MhbgUtc9yD8e5mrAj9WzGfGGz5E4vj3ey22Zd8zo78kkHpDcbFFquiexP9x7rn+Nv8MSE3
	Wi5ZgPoVUtAKScgK7MtVJkUiXKnA6/W2PWVaCrMFGc66YFDXzEhVxhiJCWikZtkBYPRpm+CELAQ
	qz07UZjXkIyR08zFw8pUTshF80n239xQ5cUMJYuzUOvFEbfG9eQOm+RQY/LoXZfsDYe0LHdAJO5
	CYPOJaKUP0ejj648V02G9i2x2R14zD3vGBt23aGuQ7XW7piDbt8oskbHVT1ZKho4IvIxBlPEmKp
	wmz+Q==
X-Received: by 2002:a17:902:ecd1:b0:2aa:cfee:a472 with SMTP id d9443c01a7336-2ad74574bf3mr32189675ad.45.1771691064834;
        Sat, 21 Feb 2026 08:24:24 -0800 (PST)
Received: from localhost.localdomain ([60.254.0.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75090177sm25345905ad.47.2026.02.21.08.24.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Feb 2026 08:24:24 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	avarab@gmail.com,
	Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
Subject: [PATCH v3 1/2] sparse-checkout: use string_list_sort_u
Date: Sat, 21 Feb 2026 21:53:58 +0530
Message-ID: <20260221162359.43336-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212041017.91370-1-amishhhaaaa@gmail.com>
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>

sparse_checkout_list() uses string_list_sort and
string_list_remove_duplicates instead of string_list_sort_u.

use string_list_sort_u at that place.

Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
---
 builtin/sparse-checkout.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index cccf630331..34e965bfa6 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -94,8 +94,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 			string_list_append(&sl, pe->pattern + 1);
 		}
 
-		string_list_sort(&sl);
-		string_list_remove_duplicates(&sl, 0);
+		string_list_sort_u(&sl, 0);
 
 		for (i = 0; i < sl.nr; i++) {
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
-- 
2.52.0


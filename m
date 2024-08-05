Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07816F8EF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902390; cv=none; b=eMqJFYwOyKvDqhL7HSsn50BM1ubCmfcUXk7y4/xC9KR7+aCYVHnFfN6fo9KLQZbULpiIm0MfuqTMISaP/8buQqlBerRunNZg6hzRK+qpWA3STrNncdJyz+sAbXfkmLESiO7FovvgA6qqxi3+pEE8FfSyX6aVsCiV5qteuWttG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902390; c=relaxed/simple;
	bh=dwHrW0VJ4fOb0V5dxqhfW1W96t2oxa5vzeT+WL6OEq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAVNkYpZfF/eelIWqA0ChJGVokJiWFqx6nQ56RTsJzYnux5r1W7TqmjNKPdBq6e5V6cyAVG20g4i3O/ZbMxIWAMktbPI6kjvBHIIoZljzZneUW9dJqirMkVce9ssqmY7UD5LXSlUlPdN6hW0gj9bB9JJUeGf5dUOTQHEhMaHB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG7ZNfbh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG7ZNfbh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428178fc07eso431375e9.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722902387; x=1723507187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baODQEVSKZkR4NxouhvlfP98A5JLPpRcJyRXkHbxD+s=;
        b=IG7ZNfbhpJeYJOvIeZkEYe9FLOAx/t3Pmi54VvhEpcGR0+YU4HPlePR0hqs1/rga2i
         69lecA4TqpBsKfJvmLZPNPJTwSiC/ZR1Sr5CWIzKbtTRejGfFtBeu5HsdgXByxhC0fS3
         j1ktJISmFAd6BiB4PaOdxlh6P/thLoMhaoTQiPJGbKJkd+xgu/olLkqlF+9NVir1ia5P
         R40pkOYW+LM/m+Z3lUplpyhJm3ijwrO3Tg1rnBS0+vTS1oF09Ov7sTtX0HG5PG0eiGYH
         nN0ZAPPP1eBjiDhbZ7nJSoFKi0JELO8jENRZtJzr6c8Aj3zJuhw50D9tb5cVJb7fT7uF
         nenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902387; x=1723507187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baODQEVSKZkR4NxouhvlfP98A5JLPpRcJyRXkHbxD+s=;
        b=LQDqPGgPyKC+mm1REy02y77EDN4a6HfFazq3uh49SL6gUik3nCi13AowE5hoj6JcCO
         +4Uo5GhXqnAqoYsTxJyetih62pJj1e3NofwoMRxCp0jM0twQuJ1g4AcyA1ie5rBSpJj/
         nHb7Ka/mS3tn65z9je1Yu1LYDewWE9cXJkGZL5M4WyLdZo2xyNgtasiiJKrfzgN9RfKb
         C3cVtCUFkriygp0uEVQlfNYKcr4smUoadMF29lrepWffa5tfPB4E1Ts7lM+BW3Dgh9Ac
         ejbs1IAP/6t03dahiTZHUtIfp83dER79sIIQY8XttrCbXiuyrvEd76qT31YQ8OjNgdt+
         BBKA==
X-Gm-Message-State: AOJu0Yw4iQFLh7d7Cwh64GJvF4mrlHsGuKAAbo4XT9c0TTyLqNKN844P
	XNQ1D5FGFKgTfUCdOtRDM7OJkCfSBDf0lX68U8/ciuzuHLXlMHOWRx4x19UO
X-Google-Smtp-Source: AGHT+IEPII4k9S9MfbxXTUdKPtdRUY8VO+2/fHEFHZ3OaIc1SNbi2kWHDmTFcqFV3hlpbYZcoT/eqg==
X-Received: by 2002:a05:600c:1f95:b0:426:59ad:bbb3 with SMTP id 5b1f17b1804b1-428e6b95c3fmr104009725e9.32.1722902386789;
        Mon, 05 Aug 2024 16:59:46 -0700 (PDT)
Received: from abdobngad.. ([197.40.47.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd074583sm11219065f8f.108.2024.08.05.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 16:59:46 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v4 3/8] [Newcomer] t7004: One command per line
Date: Tue,  6 Aug 2024 02:59:12 +0300
Message-ID: <20240805235917.190699-4-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805235917.190699-1-abdobngad@gmail.com>
References: <20240805235917.190699-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the tests in t7004 has multiple commands on a single line,
which is discouraged. Adapt these by splitting up these into one
line per command.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1e31f39646..cfe7653317 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -215,9 +215,11 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l >actual && test_cmp expect actual &&
+	git tag -l >actual &&
+	test_cmp expect actual &&
 	git tag -d &&
-	git tag -l >actual && test_cmp expect actual
+	git tag -l >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success \
-- 
2.43.0


Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911171CC146
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573169; cv=none; b=EZWxZh/oyW3qrlroU1enmnWJAYd3r7K6pk6BvD2AQQqqd+kGFVeDs7sHxmNAvFuqwh8hrT43F75ZliyJI2sIqKMvW2xAj3VtkPPxaev9tRzEi2tLoJNDX+mzABVTWv6BXiXOufuRv9hQIkUFHups/FCr3g/Nx1lSk4PZ5AW0L7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573169; c=relaxed/simple;
	bh=ls+clo00uu7bDwjtXvJyUCOrZGrSvlKmjtYaAtFL1Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N53OJ7lM62mj7B2mdVLlsX/cTUhZ5OAjpLGoBuIr/EL9pnLdHxl3Pqjq28MFWsNtaUoGwJghBGsBf4PhmfkddQrrfk6l/F0m1ARVEVL157GvnbJGYcmHHWK1s/DHZwhqDuqSs7Z0iOAQ5JjMQlJShAlmOXhYR1yNz7RVG9HME/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er5aowsn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er5aowsn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a995f56ea2dso167318766b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728573166; x=1729177966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaOHEsNEqTCQz7n/uP10hku19rrtFDU7/7nm/zQalxY=;
        b=er5aowsnk6ZHgqfEwNFsmhFqlYGCiwZZnfFO9gGFu2aBCbACO/lA19aouT6pNtQs3C
         Dbl9wDKlf3V/2u/ZtjOJUev8v7B7iKkEzT+5DuBuNbJK5jqSt2uY4io0QH9187C5iNNM
         tTfocxXTCMRzmhArpoF4Z31KqnEPfZzmXBfnbZFJ8X9cd1V2tfMZWZ+3/RWKT0RZShN4
         REnhp3TnD9FYYYhxjR+3y6SOrQDp8rHMNFo3GCUXrO0/O9Rvj8f1kVn6bSMmiNsIRGAx
         9xAHPwOA78VSvfAKv0DDRuCx9XDMoVvraHjcraDZvU0dHdGjhVS8GLKuKe3PEs5vXptn
         QjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573166; x=1729177966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaOHEsNEqTCQz7n/uP10hku19rrtFDU7/7nm/zQalxY=;
        b=aEP6mcH4dkGwVi1I66me7OsDUUQgFVvXErag5M6ibmZHoxrtmOHQ1tu1YRmpcCJkfe
         0+RRWW1j5z7gHTUbhCuafiU4NnugXlb3nccxGyBW2LX2zZe9zf2MHgFsgzn6oRp4snH/
         ZCs5ELrWtMvwJCrah3OONRtyi2Cl3/n2Wv7ACQKmiOb1DT1W7rSfUWdUky5LEaHex1Qr
         N8TyheblEr/5SMAFK6ZNEvOwjvTZsWACMatchKbrmBA1kJ4tzxjb7b6VdymbPgPSZnHe
         r5vqFnDp3kNuWSH4Egip/gNky1l5hlK0yj4SjN/mttpz9qKQGIQFtYeacc0prVVoyF+u
         DTNg==
X-Gm-Message-State: AOJu0YwEqu5BS+tuqx/m3UTCwV54r4p9KiGAnRIaIJZSZA/MtMM1kL79
	o7lbqLcw7k/E44zYu3MREjSWGgHeAv5U/244AM49Lhf3MBdAY7tWXNAAb03ISqA=
X-Google-Smtp-Source: AGHT+IEBCytjNqZCFeSzICD9X2TtcBXgB3u/NnOnSAmns7xuHk5cd1NumPb0M09jPO4+efypkOJoNA==
X-Received: by 2002:a17:907:9728:b0:a99:4a8f:c83f with SMTP id a640c23a62f3a-a998d10dc98mr555741366b.5.1728573165724;
        Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
Received: from ip-172-26-2-149.eu-west-1.compute.internal ([2a05:d018:458:cf00:674c:b768:6d8:37d1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80ef8c1sm100840266b.195.2024.10.10.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:12:45 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v2 6/7] t/unit-tests: fix typos
Date: Thu, 10 Oct 2024 18:11:24 +0300
Message-ID: <20241010151223.311719-7-algonell@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010151223.311719-1-algonell@gmail.com>
References: <20241010151223.311719-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/unit-tests/t-reftable-basics.c | 2 +-
 t/unit-tests/t-reftable-merged.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index e5556ebf52..a9a9f888a4 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -54,7 +54,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		}
 	}
 
-	if_test ("names_length retuns size of a NULL-terminated string array") {
+	if_test ("names_length returns size of a NULL-terminated string array") {
 		const char *a[] = { "a", "b", NULL };
 		check_int(names_length(a), ==, 2);
 	}
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 19e54bdfb8..109d3b07a7 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -459,7 +459,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
 	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
 	TEST(t_merged_seek_multiple_times(), "merged table can seek multiple times");
-	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
+	TEST(t_merged_single_record(), "ref occurring in only one record can be fetched");
 
 	return test_done();
 }
-- 
2.43.0


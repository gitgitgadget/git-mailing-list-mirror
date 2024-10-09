Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1218E343
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474598; cv=none; b=PRdRj289FYUmndMx2qPIRSnNNXAECcw8nLfNWi7ntUmC2vANBhz5av2GgnmVroPSrhaJ/rO1AC31sURU/e5HZg3rSm3RQwrchQ58yD4vKyA86eTagwlfmcywgFy8TbQNsdO6nxNNZtK1etUZvofgVFOb78XdVueMIMoDB8pxrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474598; c=relaxed/simple;
	bh=kMduaGZrlLGMBXemDKxI1f2eHXsoGtPhXatD3tmvMHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEE+cYoYKiFkuLiMQuf1Z9ooSyXg7Ne1SfuwUN+dxQYAk/tYiZUkM42FWk5r/RtykIiUmbgDY436xYZRkzmil2xv4CjutskIwsfVjfcXzWe242Ve8jmjF8zPJ1puaU23IFXGZp2R+o5XKKR25p3jx7YYtubM7upLv9k39MEL0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCQjQMPi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCQjQMPi"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9951fba3b4so491274266b.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474594; x=1729079394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VfMInZEPt4K80+btgkuCRQiXkD/+CrukcaZBdnL8uY=;
        b=FCQjQMPiIqNHHxDAiYMzoEIdm2ocYHw7fkja9vD5k3yPg3Qu2OrW73e7ahy4mCPXbM
         1BfJBhv+4pIOVdn+uQ54gdCHyQ1+PjRgXBIiZQZr8+mQGWd5q77yIeqizEaxtbNSIOpQ
         wlEor3VU9qyyTv2kW/mE51Ir4/8P8U18Si6b/znHLTfnW1uvJSSaacU3KYkFHQjNuK8u
         kKEVZOzs+4CLpMRiQrLKzvTMM/p3F7eZ495kbnrY+9RFyoMnlaygKBYluQ46unROm388
         RKVusDt2fxo7i80GXb4AX1UYmpShe0+SsRkubzWDJjCkffr47SjhF6dktRGLy6y6JV46
         n0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474594; x=1729079394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VfMInZEPt4K80+btgkuCRQiXkD/+CrukcaZBdnL8uY=;
        b=WJl4opHuBPWNqCLyeeolEtbF3+tnw2T5jkNgN+pc5CmjocMsXeK/788C3hCOG/f1iR
         nT4mUO0PbPwrSy4+VmE8PKKIMilZWafYk8JFe8zvATInbZciAoPcA7n3vndQ/8uS9M8U
         9qqUaOp7hF7qTquUzK+HRk9cqW8Ew3Ze1OeTzc1D+/VF8fpmE2BaFHBp6vYjUi538FBl
         u8Q9lw7BiFh9i2rxiNlwtZq0cR4lIbtgtbU3VlOTQ7YK+bjXtFeqgTlilVeGeKVh8yl/
         Zac6lrOJmFQXEqxAEPgxK/Ou48Dgo0kXB+aE3YCK1D8NmGNNXv70oDJMkc39jJKJ8RI6
         WN2A==
X-Gm-Message-State: AOJu0YwbrBkZyQMHjOlSvvTB4nXrW2ucEkWKTGxQAZuyXONHOOe83QUb
	8R0r+5uS+gN24raZJVYAHzmRTlb9OiCkA90kJIBn9zJ+zuaz3ATNX10ahghP
X-Google-Smtp-Source: AGHT+IHesowms7xgxqRIhlNHEz/pOy4fAacFgse8vv9kxNccafh4o5UwkYFeUhlj9AvcRHsPPqoh3g==
X-Received: by 2002:a17:907:e68e:b0:a99:4c5e:1b01 with SMTP id a640c23a62f3a-a998d313ae9mr185412066b.45.1728474594398;
        Wed, 09 Oct 2024 04:49:54 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:53 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 6/7] t/unit-tests: fix typos
Date: Wed,  9 Oct 2024 14:49:39 +0300
Message-Id: <20241009114940.520486-7-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
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
index 1fa77b6faf..a344b27fa3 100644
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
index 3c84363e98..97d28bffe4 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -467,7 +467,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
 	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
 	TEST(t_merged_seek_multiple_times(), "merged table can seek multiple times");
-	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
+	TEST(t_merged_single_record(), "ref occurring in only one record can be fetched");
 
 	return test_done();
 }
-- 
2.39.5


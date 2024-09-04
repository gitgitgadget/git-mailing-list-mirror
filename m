Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF11DCB24
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462126; cv=none; b=jtDsIxtRpOpnTaU6KDXAnGa5fllyjZwK9IpmALzVsBjEE8Zl0JZGeAy8ipX5uNOexvRYc1cuAXZPVD3a8orEqmCg0/Ng+YT/0CxdprAX49xVDAwTe0JmvUkM3V93fTfvDzCjrv29dFJEbjWRkJ1QQRQ1mEnziUb9LP9zDVVVTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462126; c=relaxed/simple;
	bh=IxEBmaCr9gKSskHj6CAUTBgOfBKs8xP8mvE2mFDGb08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkwSSM7f8M9su3vezNhEqyv1ak3aeLrwMBF0arND0Vt9ucTDdbCWfavOlYrvzORpnVWI+9hw0Ca85Tsr6rjjX+FlYwdI+hbXxpumjH4Kv6KRuFsvpggAse2/838oj1djBKVH6SOGZ2SDv4b5EAeS2+TCjR6bCc1I0MWacF8941U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjCUjV+E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjCUjV+E"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2054e22ce3fso33399575ad.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462123; x=1726066923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciIehjiLqNywTFZ3TwhvbEO/72n4+M71jO883/S1Z4k=;
        b=TjCUjV+EFGNf284jrkIe2p7bDbAqzBIqgEt7gcXtVpIs0470yi91WpUDgStvP4zjhI
         pudAyrHnEgpTRKcxwofwLS2YxbYL6tzd6NnUzP3QgcK9mywFW2Q7xAscXste2JmGni6g
         0YpF+WRJUfM/6aaG/Vt1Km3MQpzfN4j660galYtIgyzmNNaGC9JTrjac6HZWFjwNSXgb
         sSIvOH+d1ETPfgFxZ/pkx9bYjlAYcys0FDPJbuTiise73TeIGK22hPUs2C7N//wHKbJF
         7mBMAstSL/Pf1YYse2eCsFxjfcbaGzYP6ir0HBhif6xCnkinaZJjFW2K+FB4u09nkb6C
         DM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462123; x=1726066923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciIehjiLqNywTFZ3TwhvbEO/72n4+M71jO883/S1Z4k=;
        b=X4QnRZ/8xyTX+qKEEgUzbIr/cUL9Y7Pn33JuBBMPUyUyYM6dNlLgAej30D9iYCih6a
         svX1nwZz0YDPTwqv/ueoFA4NG6r36Ey4RJ4NIrnDbywGjscSDRDAmKk5H2bI/E11uZxT
         eIbjteWsqQh4Po3zmY1EUVT1SLY24rvvQtxcDsQKyLUof2lFLNx4Hnr8KAHla0x9RTGE
         sPS/2rrInYQgWtI8qSL6ZoNnAZJC+DPTPX4jWbqfEulxN0gMCvSn1IA2VgbasLcOHzGY
         QYt0UcE0PLaDnaXwvg9bwkZ60KqwtRaOJ1lANT3TmVxcwG8lfyAbQCHl3bzMrOA3pEcJ
         bX4A==
X-Gm-Message-State: AOJu0YzF59vQ3Q9AXhKXCdBiibFEaJxX7uK8+cZxOMjfjLRxx+ml/V9T
	fQI3u6bgsjLdEHD4gVMyBCRPt6P+AB46CEP1PocHCqv4jyq5itvqEVvk/4Ff
X-Google-Smtp-Source: AGHT+IHrZXvJdUqMGUB30YUlxJLoSktbRDYqdzsZlBY9pP+VgNhxJU05tlxjlHtzn+nK2grhONDIxQ==
X-Received: by 2002:a17:902:fc43:b0:205:9201:b520 with SMTP id d9443c01a7336-20699b37027mr60423675ad.58.1725462123437;
        Wed, 04 Sep 2024 08:02:03 -0700 (PDT)
Received: from Ubuntu.. ([106.194.60.213])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea65fe6sm14549395ad.257.2024.09.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:02:02 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 3/6] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Wed,  4 Sep 2024 20:08:03 +0530
Message-ID: <20240904150132.11567-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240904150132.11567-1-chandrapratap3519@gmail.com>
References: <20240826173627.4525-1-chandrapratap3519@gmail.com>
 <20240904150132.11567-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's tempfile API defined by $GIT_DIR/tempfile.{c,h} provides
a unified interface for tempfile operations. Since reftable/stack.c
uses this API for all its tempfile needs instead of raw functions
like mkstemp(), make the ported stack test strictly use Git's
tempfile API as well.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index c74660a1e2..8047e25c48 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
 static void t_read_file(void)
 {
 	char *fn = get_tmp_template(__LINE__);
-	int fd = mkstemp(fn);
+	struct tempfile *tmp = mks_tempfile(fn);
+	int fd = get_tempfile_fd(tmp);
 	char out[1024] = "line1\n\nline2\nline3";
 	int n, err;
 	char **names = NULL;
@@ -95,6 +96,7 @@ static void t_read_file(void)
 		check_str(want[i], names[i]);
 	free_names(names);
 	(void) remove(fn);
+	delete_tempfile(&tmp);
 }
 
 static int write_test_ref(struct reftable_writer *wr, void *arg)
-- 
2.45.GIT


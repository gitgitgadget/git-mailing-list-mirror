Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67400446AF
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769097; cv=none; b=gwY0DjjcQii3mmvwDMymu3+R5YvtWkXG18NLYO/C8p2stvkZ2KJeLtF4fhsr7nbndg6gTOiSnqivC28FepOFbdwhfMbR2jwbQpK3A9KU6aGk1KR1gYabsEVNjBa8iDNpBAdrQocKAWAgn0+lJbV86SE7/r0/Xv3r7sAqveq60Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769097; c=relaxed/simple;
	bh=TsMvFL4U9+5UyIyYVCImm0fS2IZ67sFAT/aKluJvfQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QzSvp3R7vUTJ3x0vAE/BFHrDdZu2EcT5MDB/w7FGJMyDzH5rEcMX02xwTeNyLxiGxu2tBF+FM/TpxBu7D4MuFanQt7t3OCJywTG3FaZCAqlXKLgcG5J4HLkHY/Pgl3JprgE0epvJM5zdAGjkVfuCC4S5k6mNDT4+nsI5KsSR764=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5/UJMNu; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5/UJMNu"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5de8b17db8dso2048989eaf.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725769095; x=1726373895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/+APfLOUfy3c0+yTvKXFD8HfIE0XAttjpIAsE8KVp0=;
        b=d5/UJMNuRc+mfcbzqD4XgNheAm5nUy6mFskypBnID3NL901WlMObejdZh5HGo7uovV
         qrG9H1xD8em/NlP+lyt7LGR66K3MVZZkOEX95UJGkpAu2ogaMaSJt1OwnnwmNcgTwqeZ
         3Bv2qOAiNX7VZy4dI61a0cs2VZ30hAZjwIMQrTjWdK2RhSgZw509siT9flen4CaPIIYs
         iKN1EzIFjpTal6R+OM8aoG4c78Xj4+VbErVbdQK/tMrqe5FyLI1kww/1yW3BBCylfE8I
         sxL8HEc5n64JoX4z3eOVx18xIvm2ROheodSexWrQ2Vmsnm8C8v41tJwYiPpek3ZPsb46
         EYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769095; x=1726373895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/+APfLOUfy3c0+yTvKXFD8HfIE0XAttjpIAsE8KVp0=;
        b=QVk1If9wBHCyLI34jXHdejvrhqLy66F7FL0zufHWjsrOfDupmnWlccGg+D8GFViH5c
         Cxb2YQO1M222VhW2GJPSoosLIpGEYywyz4mUyaJdJFBZ4fDTNhEX1kecWuKgqx5WCI7K
         2B2uNdv7sSRMmQy7FBZOw6xhrks8GtJ3VLfT1U5+JRLoPQI0SIR5GvSukKENPft2HIVi
         xJ3lAC72iPDyRBM/LgeFYsFFGvAs7iA1I6Fkp9HMY26bO9cqcf5G/z2dEFc+Zz41or2B
         yDCxUFbio4MARboYZIVXtB0akNnk7cFJXwS2JT/JfclamNMEmwGJi0jb/hYJECQ5VIOE
         KAfQ==
X-Gm-Message-State: AOJu0Yye4sfZLS8EztUVG1U3TlXIz3LB58BsXBM8VNJWSpGYHw5V4fqh
	BtlcouDMP3GiroSZZs01r3pFRO0TOSW/glyZDhtf2yXge+CJkATs7lxSDOuM2YA=
X-Google-Smtp-Source: AGHT+IEbFVVRj4i6P5vxuuyjmkNjPqTuGJaVSPRZJt04KyANR/h6LAHw21kNa8K9G17r+jGQpqVN1A==
X-Received: by 2002:a05:6871:7995:b0:277:d360:8971 with SMTP id 586e51a60fabf-27b9dcc2487mr4311635fac.43.1725769094562;
        Sat, 07 Sep 2024 21:18:14 -0700 (PDT)
Received: from Ubuntu.. ([27.59.86.31])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596883csm1533253b3a.121.2024.09.07.21.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 21:18:14 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/6] t-reftable-stack: use Git's tempfile API instead of mkstemp()
Date: Sun,  8 Sep 2024 09:35:58 +0530
Message-ID: <20240908041632.4948-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240908041632.4948-1-chandrapratap3519@gmail.com>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
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

A bigger benefit is the fact that we know to clean up the tempfile
in case the test fails because it gets registered and pruned via a
signal handler.

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


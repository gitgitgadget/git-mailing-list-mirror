Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C461CD25
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720763490; cv=none; b=tB09VVE9hHDgQDCZXmb5S8s6sYZvQFDZJYAH2sydpFmNdteWJA1UUbWuV26CXl4AZaHtQL2zMBjmB0psA38VKZROGoY62O8gr3SFmMDPPoIQyqy8JIYNczHz/vW8uBeDFo4Td5tuerY/nSfvgfQm+DfYHVOj0ekJ/59OnDVtkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720763490; c=relaxed/simple;
	bh=8uL1ovLGFPqrVvQqB4HJct0GByQ01ZuFWo3hjVSm2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSPqg+PQ3eJ5nSWMPlj/OOC4f0U3HZMpPp72ao8bFY5XNPPJdCtmXx8XlLdUbrU7+ep0Z/hC4yMlqtRqt1kTIO0j2Jqc1P8UhU6KrnbpULT9DA7NUvFBP/ddD+2PntARJZwrnJr4FXDFrYrOhtC4ddpaA/mw5wa4OIudnH5mwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7AYgbLP; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7AYgbLP"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375daa47685so6103495ab.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 22:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720763488; x=1721368288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq9cdbUeyRVisocjN7NMp4rHugUPN2WW0wNv0UDUDb8=;
        b=S7AYgbLPykX92XR4Es+4XQoJHH7hQUo6Vq5VF5bzDarIUW2HhEsxb15xxEQMSZGDie
         zcz/BLcdRvEXYD20EWXlO1V0M+imQvwB0Hi1RxaGn7+r1as90LJ/avf0ZuHWImUQJczH
         MvWnUNii4OyblUMJPwmhVSxjgEhtBC9kCR1WRqEqrgluwKrmxzpxJJICAT3qnByV3d9i
         FVJ1rQohl0S2voN0AJWAtj0U35jtUUcv+j6TATKyKbX5NT/M8lerXOusQe4G5RiWEYMm
         iUeFqDjcqNwXiUi55Cg/HxdvvPdnCXEK/gFnMcQTmNAS5MIMhfE0WjK2dLqVuOF7GUif
         GCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720763488; x=1721368288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq9cdbUeyRVisocjN7NMp4rHugUPN2WW0wNv0UDUDb8=;
        b=tvrxYhZ33X9wfdoGL6qyy9QB0LsAE5Gd1MomRtafbQ85PLRDyaZ+Knr9BFjAhSNaT9
         KsW91SCsmSTj1zHmYShCJpQZTo05dNYMIPwsIs2cSaO/6FwYmCoolE74DtFHyfXfz62v
         foO0sKWUJ69fxHOmCTWfW7TXeCZ1IEPtodve9ma1w4X3k+j/yDEq36fSSTJIb6kvqmZN
         VEZHXe/HLmh3oa7hH/XhDYUG/Kz377lsQ4tNx+NneV8z9nI+6UVPu5ObdROYOxTwmFZ0
         OVRRYwwp/hy9olYcK/h+knzmt+2FDx65I7BgXq4h/QRFYh4kA0MjqIlSBVOEnrUpThHa
         BtVQ==
X-Gm-Message-State: AOJu0YwQ1FIBmyVP+F2mSOf6HeRY3zr5GBBYAy/MZgaE1Y5Bl53hdfWL
	DqUNzrWiP2alrQko1/cUMeZWGCM8MkaWszPCYVSzP0PFkM7PUQzedJpNsw==
X-Google-Smtp-Source: AGHT+IFCAFcTxAqeKuZvWWl6+YGUDaiAJZ5QjVIQtXmFd8Y7liGJCyfZ9xEJH/+IN7FCSBQyVypuwA==
X-Received: by 2002:a05:6e02:12cd:b0:382:c731:8d0c with SMTP id e9e14a558f8ab-38a56d0c2c3mr127589855ab.5.1720763487913;
        Thu, 11 Jul 2024 22:51:27 -0700 (PDT)
Received: from Ubuntu.. ([117.96.148.106])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b4397f475sm6604651b3a.150.2024.07.11.22.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:51:27 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v4 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
Date: Fri, 12 Jul 2024 11:09:01 +0530
Message-ID: <20240712055041.6476-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240712055041.6476-1-chandrapratap3519@gmail.com>
References: <20240711040854.4602-1-chandrapratap3519@gmail.com>
 <20240712055041.6476-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_merged_table_max_update_index() as defined by reftable/
merged.{c, h} returns the maximum update index in a merged table.
Since this function is currently unexercised, add tests for it.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index ff2f448bb6..065b359200 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -236,6 +236,7 @@ static void t_merged_refs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_ref_record ref = { 0 };
@@ -365,6 +366,7 @@ static void t_merged_logs(void)
 	check(!err);
 	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
 	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
+	check_int(reftable_merged_table_max_update_index(mt), ==, 3);
 
 	while (len < 100) { /* cap loops/recursion. */
 		struct reftable_log_record log = { 0 };
-- 
2.45.GIT


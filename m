Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B309880043
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040223; cv=none; b=cZEf51YGNERlrs6cqUSDLv8AQkLS4egFSXHZXfoSqnGHCDpa5twY4FDDLh+qHPSOnD0uU37E+pahhpgH2zODMi1g/xAzSzLsuZXQIoYddDdaVv475m7Hg3+Cf6ckV517EapSkDOOkCCd5nEMOvBts68bOPG4okVldTNyTX8yPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040223; c=relaxed/simple;
	bh=rNjYv8v/nNvu5fkAterIaONp+7KgWiJuJ3zrzWZNg3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrROc+UWmlJN+ApxybvCLtRiVYQHKuAELYTOJv/+BbgMA4sQi/zDWNeoC4x8+G+81MkAKjwyQ2//Klol/lOXbJCKOduCcjpQ38x/K8/TBVc15DrVE22mClDUe5YUmK/POJ5z4EIC2sbaDaS7nvIDbaF6HCWCJ0Q5tXu3OjS/1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXfvek29; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXfvek29"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so1359065a91.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723040220; x=1723645020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxcNKp4a5xaumj3da3OqlAmj+xm5gsA3osHbMT4TyUs=;
        b=XXfvek29eo6AuEg8n498yFoWp5wL2RAQaq/cQBgC76hATBR4mcE6dWWP6Ks7suPWpi
         pG/nmGE3GqDGd4k8XogGqBQoJwWic2SmJGEBy/Cti3SfW2LxyQUMu2ympUEEBckUqmsQ
         w9g+nQU7gbA8nFcwQpnE3/Nb7XYqSMPUXYGWAPUn20CyNEmvyE/ripYzbsrykj1v3/7r
         E7U0wtJxsWlx1nEysqT/3a/swFRLeQKRZUtcS8k9DK+FAiZbfQJ8+w4XskUUUUoZeqo7
         2GKAUT81QcuooJ0QnnZBYhKthha6Gd7HFk2ILw4fvDosGFQfklCHAqAwWAWZOUqedUu3
         wx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040220; x=1723645020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxcNKp4a5xaumj3da3OqlAmj+xm5gsA3osHbMT4TyUs=;
        b=rQMsE74egZImhdz9HF3qfBPhAFntcbAaUxdPXZ+WkgmcizCd1rj80ctoxdQAa3ZKRS
         rYZ77iFHluDCd26gFtXS3ss887iDEKllp0PpeHTlFjQGcvki4VGCz2ch/aNVeTjoTiYw
         gcwu803W1nH+/3A9aLhTlx4t+66GYdFSg1KyjWykVbQlKEmbjNOo9Vc8E0lRPYRnM1E0
         moof0odO/uPsosTkN0FsYn7bDlUxMDxE/rHwOb5bTVWPB/K5JKsGYZFE0zjGBorEIimD
         5uCkdz23bxjHwAC3cX9F7I0a+nEcYje8/6phrj+Wl0YICEzSfNht8lJeWLBHUhsoYQYG
         YsLA==
X-Gm-Message-State: AOJu0Yz+avnOy1q1v+gqUZ4iCyTW0eMlntbM0gBfnnbcORsH972ZKzpe
	TiYLyKaN5U1szoP/MJ5DGthNRKAOULFKi+JgD2S4BtJREyo61ZHi6b0L3n2b
X-Google-Smtp-Source: AGHT+IF7G80YzH8uCJ8MGHTjX5r00NcOmPlUJ5CfZHo7mVYDaBv7AF2ms/iqfPeApVL8B1xpXnONUw==
X-Received: by 2002:a17:90a:c70c:b0:2c9:7803:1cf6 with SMTP id 98e67ed59e1d1-2cff94478a8mr17633121a91.20.1723040220429;
        Wed, 07 Aug 2024 07:17:00 -0700 (PDT)
Received: from Ubuntu.. ([106.205.252.196])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3cesm1635059a91.48.2024.08.07.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:17:00 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] t-reftable-readwrite: use 'for' in place of infinite 'while' loops
Date: Wed,  7 Aug 2024 19:41:59 +0530
Message-ID: <20240807141608.4524-4-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240807141608.4524-1-chandrapratap3519@gmail.com>
References: <20240807141608.4524-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a for loop with an empty conditional statement is more concise
and easier to read than an infinite 'while' loop in instances
where we need a loop variable. Hence, replace such instances of a
'while' loop with the equivalent 'for' loop.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-readwrite.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e90f2bf9de..7daf28ec6d 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -268,15 +268,13 @@ static void t_log_write_read(void)
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
-	i = 0;
-	while (1) {
+	for (i = 0; ; i++) {
 		int err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
 		check(!err);
 		check_str(names[i], log.refname);
 		check_int(i, ==, log.update_index);
-		i++;
 		reftable_log_record_release(&log);
 	}
 
@@ -374,7 +372,7 @@ static void t_table_read_write_sequential(void)
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
-	while (1) {
+	for (j = 0; ; j++) {
 		struct reftable_ref_record ref = { 0 };
 		int r = reftable_iterator_next_ref(&it, &ref);
 		check_int(r, >=, 0);
@@ -382,8 +380,6 @@ static void t_table_read_write_sequential(void)
 			break;
 		check_str(names[j], ref.refname);
 		check_int(update_index, ==, ref.update_index);
-
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, N);
@@ -589,15 +585,13 @@ static void t_table_refs_for(int indexed)
 	err = reftable_reader_refs_for(&rd, &it, want_hash);
 	check(!err);
 
-	j = 0;
-	while (1) {
+	for (j = 0; ; j++) {
 		int err = reftable_iterator_next_ref(&it, &ref);
 		check_int(err, >=, 0);
 		if (err > 0)
 			break;
 		check_int(j, <, want_names_len);
 		check_str(ref.refname, want_names[j]);
-		j++;
 		reftable_ref_record_release(&ref);
 	}
 	check_int(j, ==, want_names_len);
-- 
2.45.GIT


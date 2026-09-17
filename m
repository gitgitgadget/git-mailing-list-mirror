Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1964E36F6
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667570; cv=none; b=ah3c/7h01NgulFynL3My1eOHEuFZ6XWJuJ9EqA9j4CMb/hUEv5HnhxR++v22WH3wR6o6F8N31WJLPnyIzRPXYlnyxzBG3IWxN2jPRrsbya3l/vrtwo3PROL4nlvjrBzXztedsw8hb8ohoB13mL4sMH4GX0jFVA4cOFth7t0dQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667570; c=relaxed/simple;
	bh=xL+Bh4gaWBZcEzSLCcDVnqOi6gxWqeSkv+JLlTy4HiE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fp9XQw2/nUUMZ+b2+YvY7Nec3iYWUKZ7BmtXvuwQW6z7wvIsH8WMKYpj7DmhZEOzHvnnGKpwAlJ4LGl7VMpxCnbaBcXkrL8ZCDFCNgTOUPAw3Egupc62E8FR8qcsDUYYwiWwQAANurAPc8va99b0W4sfvplsTeV/F206aVVzkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4hcSHAE; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4hcSHAE"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1374380b3a.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667568; x=1790272368; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lfj2hALrPLGdjKy3pvwKqVTGpOcfUbbPETQZNAuWqDA=;
        b=e4hcSHAEctO376uNGigVF9YnuFfZHCe9dJM/2NYv8eoEIPI1oax48GrzyUWQAcIA4q
         8R/DQQNm4i+nt9m/VkIpr4nfFbjDTtTgp4xd2hfyp5fat7pwt2U/TtIC1/PdZmOBAaaE
         JLZkf1Gbi5L9lAXjcBhL0z58cPjTYi0bYWfNReL/uft9uDaPXSnVD9ysNG0Q4Xj63pL0
         J5qjEundnkutoyJOYJQBthS6wnXcwW0VnTaXil5hf0qTL27iySvCFBXkUHjbGQ5V/ytA
         oc777xlrYr/I/4fUDGjb7F1heLnhLFHzRFdsLZzwSCJ//AGI8yVdBIl9/1MVl1mScdpX
         BWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667568; x=1790272368;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lfj2hALrPLGdjKy3pvwKqVTGpOcfUbbPETQZNAuWqDA=;
        b=bfkjrvfuUGwjMbj8DizoDcAzycEzDLOTPQ85veUDnD8JTNxIZLg7HIjckMB9FhJk/L
         L4jNmilU8Mst9ixAZpN7dxcKD3eCFK9yHC61SDaPtigvaXlPaxTVji6VbPDPOWENL5g3
         MYxf5hzpryNW93P27J4Zh9EvCxioQAMtGQPfvMouaoIg8/N50jDzwh7cQ0SlnT875SZg
         bFrRoO9tP0CXy0s7UQC2SxQqnzgoBwb8b5g8wie+8wsU0fajTaKkGli9niy/p7jeSvOO
         /Tg49PGMODS3BMIcbcpl/7l9Vc/ms++vmr9oYd53BC0TbAUbB5SfAoTid9uzGhot7T15
         alyg==
X-Gm-Message-State: AFuF++l9hPHvjUROj5xz/+ROVpJ6T5wwSu4pKRCkotjQsN/v2pW7dK5T
	bJkcjwUiHhHM+T1ErLV/Kr+RXqMKMl+30hXx7f+JfJci3s6xSUw9syxuh0qgsA==
X-Gm-Gg: AYBFou1NNJ1Waflc1JHV5SPm3laFW936I5NJ9a53bPGl/sqfDbMn7DuwTJL/XzwZC+W
	kP8VwNvfw4ohyQC+4a3tohL9LdPTKY+c1zz56gQ1X2JNWZKKY2gNdVO/Ywl0LSSIcT1KAsfBLZP
	P06GsbQEljy6tJkwuM0hDvgdvezolAVbA6UoHSdKiXv4MGqXFhQEW5hYrkkY5ymLrydb5cH324Q
	tYNCvwtLNLLw8KIUimylXFLflT92O/1fdkt6BwQ004wXbM1Boe38GkjSN978JbRsD3q1H97BhTW
	1nN8tguMV8bCIc+HrquWjomJ3LYS9e7/rRQcmUj1ur5XP5rhXZFLk87DQlSz8g9RGWoKvgI0IxN
	e74iePJ2Ava807tGGkW6R5BUKr4W4NLBbshOQbx6f3j+gmJL/fZNzkPdARjVuTSMcuwJF6lTB3I
	OLDXd5hj8jqDN3COgA+6/ebJZXphocMzjN7i3KLNqNN+STS79M9AlNUCPt/vhDrQXD3rhL5U+U
X-Received: by 2002:a05:6a00:3926:b0:874:705d:f655 with SMTP id d2e1a72fcca58-874705dfb9dmr1716882b3a.35.1789667567492;
        Thu, 17 Sep 2026 10:52:47 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8720123e374sm3104853b3a.24.2026.09.17.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:46 -0700 (PDT)
Message-Id: <bc67ad3b05a221fce939c8a4c6071769b949599b.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:34 +0000
Subject: [PATCH 5/7] t/unit-tests: check reftable iterator initialization
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Coverity pointed out that the
`test_reftable_table__seek_invalid_log_offset()` test, which was
introduced by a1c085df8dcb (reftable/table: fix NULL pointer access when
seeking to bogus offsets, 2026-07-03), ignores the result of
`reftable_table_init_log_iterator()` and proceeds to
`reftable_iterator_seek_log()`, although initialization can return
`REFTABLE_OUT_OF_MEMORY_ERROR` without installing an ops table. Under
allocation failure, the test then dereferences a NULL function table.

Assert successful iterator initialization before seeking.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/unit-tests/u-reftable-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index bd04b477a3..1e4378b2eb 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -257,7 +257,7 @@ void test_reftable_table__seek_invalid_log_offset(void)
 	 * know that the table is corrupt, so the seek must report a format
 	 * error instead of pretending that the section is empty.
 	 */
-	reftable_table_init_log_iterator(table, &it);
+	cl_assert_equal_i(reftable_table_init_log_iterator(table, &it), 0);
 	cl_assert_equal_i(reftable_iterator_seek_log(&it, ""),
 			  REFTABLE_FORMAT_ERROR);
 
-- 
gitgitgadget


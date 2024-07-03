Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805891850A1
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026746; cv=none; b=C+6vY9D57ZGV6ZFVJcR7XA5b7B8mAMRLMyOZ+pQ3k2ha2KMiJA0YxyQ1z67YIkGX+3HVfZYTL0z90y0TtY7L04qCE+oQDiKfjKZQzwWU4R9dvaVXDT9CaLYidEduk5A30yD3GeXnoDPXKfPjtfDP7x+QCeT8CmzqxlRr5qoRiq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026746; c=relaxed/simple;
	bh=t8MIHaqZZqp5SMpRy5CTpJWnLwiteHT8A5oTaMTi/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjQOA+YK73qlJ8j8DXpX9c3BMJ4bkkqELtJjv2JjogxdWqipgI6tuqGHVGUJTtvx4mLFGux/veu9EUL7xQ8CRG4RDALnT9ey49ojZ/wCClpLp24kh9cULRRmzxSPazh1HJ/zcWWYjF7e516jlMNGX+uu5512Axs0XhPk5WUWUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP+uO55a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP+uO55a"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-706627ff48dso4229022b3a.1
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026744; x=1720631544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWRxxWZbOuEctg3Y6B6rxEiHBerHR8hEwvli43IVFzo=;
        b=VP+uO55aMtOsa6SgiWHDiKujf8+PBI1hQQahTn8WL5lEXoQwB8n+1Iw8g//AoV/vLT
         mAobwudT7apUxqKzFTqbPgK9LbyfwRwxWvbqQxDHvWdBusfMkQ8zkJROy47ZkQVo1JdI
         WuZMX6/FQ2iYxzvXig08PbKBoH53wkUX9hAUaGIkm2LG47PRqs+QPhYNr87ebNVnhruX
         alL0Yl+3x2oSjgcI88C+UzabNPc9Cz9tmz1YbY2Ygy0n+e+/YVa3RX4vvvuoGOhpbd+s
         UZS+nE9KDL+mM6fViVbZyr0urDAUgI1Wah3hD+hLMziOheULOhokuO1+EhYJQUd0Qza9
         Qbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026744; x=1720631544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWRxxWZbOuEctg3Y6B6rxEiHBerHR8hEwvli43IVFzo=;
        b=h7q3NoqiTQQ/x865Kab0syFCYn7snDFcUiYwdwJSO/MYNWvT0WEJokro6WfZHjxf6v
         U15hAIAzoMD0TWr7bEiIy3Kl9tytjEkqOhZMazbxIhOwMtCpN3tQqEdy1M8gr/0BjAcD
         HAYHNh9OW1Fu9dLOKAGfnkFytimue/ZfZl3HSIT08wtXBgcWE+Km3D5+CoFUFLJJs9Nj
         csbT7RZBGWKEcSbBtJIGPbBHp3PXpDIYM8GaJcuZfNhaLBVmfKoxt3sV2X2300f7PV1q
         UEVlLIFOTmqO5D9Mutf6mWnU2rxlh6H2+2nlSfNxUAdp9uoCXLagkfTXApYbqPM3uCit
         vAMg==
X-Gm-Message-State: AOJu0YwCOZz90UQIBCv0YDXxiRh6mJ7kIr/khaYF3K+DyZMVz2kpDMOY
	hkl7XT3XfhRYRkhRx4a/yFRsxVL7UofJXyY9fwEY9Z9aYKjdrg5RJunPmg==
X-Google-Smtp-Source: AGHT+IF6UK1D9pmKPDgpXqyGErlH2vVZD4lBYKYLrsV81ZAWWqStFIpGVno5HGRBTgm5Xpt8+WcirA==
X-Received: by 2002:a05:6a00:1915:b0:70a:f22d:caeb with SMTP id d2e1a72fcca58-70af22dccf4mr1776473b3a.4.1720026744414;
        Wed, 03 Jul 2024 10:12:24 -0700 (PDT)
Received: from Ubuntu.. ([223.176.57.184])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70803ecf966sm10678860b3a.124.2024.07.03.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:12:24 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 5/5] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
Date: Wed,  3 Jul 2024 22:31:45 +0530
Message-ID: <20240703171131.3929-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240703171131.3929-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calling reftable_new_merged_table(), if the hash ID of the
passsed reftable_table parameter doesn't match the passed hash_id
parameter, a REFTABLE_FORMAT_ERROR is thrown. This case is
currently left unexercised, so add a test for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 656193550d..a213867cf5 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -11,6 +11,7 @@ license that can be found in the LICENSE file or at
 #include "reftable/constants.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
+#include "reftable/reftable-error.h"
 #include "reftable/reftable-generic.h"
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
@@ -437,6 +438,8 @@ static void t_default_write_opts(void)
 	check_int(hash_id, ==, GIT_SHA1_FORMAT_ID);
 
 	reftable_table_from_reader(&tab[0], rd);
+	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA256_FORMAT_ID);
+	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 	err = reftable_new_merged_table(&merged, tab, 1, GIT_SHA1_FORMAT_ID);
 	check(!err);
 
-- 
2.45.2.404.g9eaef5822c


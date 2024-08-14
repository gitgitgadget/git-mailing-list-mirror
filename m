Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0B1AED37
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637550; cv=none; b=H4gnA9sfcTaevMiY9n6AgNURj+MW5aaEiY7zojHVHx4yz9SkLNR9LSnsTwTuGOHcsDPzYZtAMmeBfP+UTLynK/RDA4caygY6vyN5xfnRi5V2l7Sd/MrtexCuAW2rcAXZxus6JCNXcQKwlc76UyObh24DgAZdVRLiUzfn3n196cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637550; c=relaxed/simple;
	bh=Ql1RLguFhvUoAkW0a6q+TUK7Qjf8JMfO9d+stX6/2+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrhtED+B81B/7RwjJTz47/7qaqybZ+MvBVo5uSxLchc9pmq5lrNjL1S9KQ3V2ZNVmu0sSO7ifOezhgwY/jE/HDjZiovnwtGMfgSEnKcIdLxGhRUL0G+CfUYeR358Wfm6BAtcnN6p0aNXcNMYVAmjRFCzh6210vN1VliKFqUJs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPZ0I/38; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPZ0I/38"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-268daf61e8bso2835434fac.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637548; x=1724242348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAM1R0UwBXgNUfJHMnHJc4z2goyBuj4toSzbAz7L61s=;
        b=OPZ0I/38DqiNDT5J5QTfmixqlZ8FYLHG1ysBdjC3Pohxj2wlISO+CfYS707cMUkTAi
         Z1+CoCR5kK1ibNlGiMeVfQGXgB/rfEWpcnRqo+9Gz2ZhjM8Xm0shIo0bCKbXJlTIDmvI
         VAISI4bojwDQKVsUeWelFEqtlNt2XUoV+QHegOc7B24FsJA7r4/eWA13vteum5sING/j
         7ni0bopsaeDZHQ61+8NPd26lZg8CEDTnVE2ocuOmkq9JBw1OtGQ+eaM8LbbaB39daxVu
         m6PYv8gxtOsOulSdi8u/qxGQhkbJUBGlX9Z65CQWpMEEFhWtAR2KjCmZFSZY20wE7QlU
         3R6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637548; x=1724242348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAM1R0UwBXgNUfJHMnHJc4z2goyBuj4toSzbAz7L61s=;
        b=fhlWcX9BCvSOdbS9jK9OvogpjdsI5tDi1zFEU4VxbkZ8/uVBrkj5n9fi1H88/sZHg4
         TXTUBX6e7UhZZIWe6uBv+xg4IeENMzlqqXK7xmyAdhR3yU2aneLLH3OHZQMFHCgBXvtN
         XHtlRXH3a9SqgoBdiniYjQr9nJgJNcK0eu7D/jKTSTwZM95nr6izZMnqKONN4UlvKFIw
         jik1BPHlyyezKNwJpRmMdRhfpvQf2I5GAVb+KggfHkOhwEZslc3wld8m/crhXwWdOqn8
         swOBAmSv2Y1026Jl086B51usyvxvP9PEOSlkfJYwZExjNiyG/TaX+I4UcBC7pjZ4iDvu
         Z/RA==
X-Gm-Message-State: AOJu0YxFRYNM7sOCh+iPLoy1P4McTN+ikBr4P1jU2Ke/Ee4PoHhJo26Y
	HjCXhGpUahyZSctqCFkulHltBJe0BpI6N3k+KMmSBWHSsMGsTBfnzGzBd2VfKXk=
X-Google-Smtp-Source: AGHT+IFYJiK5ETGds0+AUOENFg0POR0oUHzjysFTNLDwHLPbCgj69AkpR1fqjZhOUpB3L6p+cY4R9Q==
X-Received: by 2002:a05:6870:d109:b0:261:1deb:f0ee with SMTP id 586e51a60fabf-26fe5a3d155mr3216160fac.13.1723637548053;
        Wed, 14 Aug 2024 05:12:28 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:27 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 07/10] t-reftable-block: remove unnecessary variable 'j'
Date: Wed, 14 Aug 2024 17:33:15 +0530
Message-ID: <20240814121122.4642-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there are two variables for array indices, 'i' and 'j'.
The variable 'j' is used only once and can be easily replaced with
'i'. Get rid of 'j' and replace its occurence with 'i'.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index d762980589..fa289e10f2 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -29,7 +29,6 @@ static void t_block_read_write(void)
 	int n;
 	struct block_reader br = { 0 };
 	struct block_iter it = BLOCK_ITER_INIT;
-	size_t j = 0;
 	struct strbuf want = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
@@ -64,13 +63,12 @@ static void t_block_read_write(void)
 
 	block_iter_seek_start(&it, &br);
 
-	while (1) {
+	for (i = 0; ; i++) {
 		int r = block_iter_next(&it, &rec);
 		check_int(r, >=, 0);
 		if (r > 0)
 			break;
-		check(reftable_record_equal(&recs[j], &rec, GIT_SHA1_RAWSZ));
-		j++;
+		check(reftable_record_equal(&recs[i], &rec, GIT_SHA1_RAWSZ));
 	}
 
 	for (i = 0; i < N; i++) {
-- 
2.45.GIT


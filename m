Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FE1C57B3
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830911; cv=none; b=ddZHxIxdi5FL45ZLxWM5CBBw+PAOSYncpgcREU/wqnpYAi/seo/1fi/owCcTJD2CA1wevQCUW9Qf3HS+oAUqhLLcahfzlPd44J2PD4oPMcNU5YLYTkCndbf1jPMbiH8VgvgOMCQK9Q85XWEhW/LsArqiS1gHbXOnLAmb0LXFWeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830911; c=relaxed/simple;
	bh=PsOooERAZjZyHL3/j9gPbuqa1tYlDESA7VjO0KeY37k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM/U/UmmvMkLv26HcztBNF1zKhWQDQINFS+cXWfzrAbzwLV/6W/+8p4N5mPqeb+zfCy9PiKKxkVh98271NMbsIcn+cyHqzanYSKaFsNC8KkfZOte0vWN4wrCPfkseMRaYb2Hoe70AxP+fX11fxxREr8XH42rezTa/jl5MTYIRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1qdApMy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1qdApMy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so1951228b3a.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830909; x=1724435709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMJHWmO4DYLCJNkhQovtJqi+UPTsbUpUjWKqfJ2dsAM=;
        b=l1qdApMymHCamrCnPu35tSuB719L+eP8doQ+qaxzHnYl8Z8YiqY14HxLxYdg3b+L5o
         ALMQePrmPF9kJsSpFcCYW5KRtprWbUmgigh+bwUX5CzwzGrNdE3Z5cxIG/n30QeKp0rO
         V1NrKeALC8xrPNp6kF4+ElR1ZjsS7mkvCpWoZYnBra1RoLe9+vILcv7Bmr5TX7wd6xTq
         wjN2/0J8L5qy3z/I0JTOJnvSDhrVoaG8C1IK4J6Zfy+weDSq58aKR5C1kCLEgaHO5AuM
         EOajiOpzIRLVpqWxX5p4ldJ+oirCUMZZN43IEWd5ZJYmF4/ySUTt14DOZxxvNEJO1JHe
         7ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830909; x=1724435709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMJHWmO4DYLCJNkhQovtJqi+UPTsbUpUjWKqfJ2dsAM=;
        b=rI+TqO8VYBJi706OKUb8TextBITzcGZicqVq07oDHoBGLWAxkKl7IxFpcyxSXxYF/j
         iVWN9UgfZwDOAolZ6YVZzDtccCQtklMqfwZSnV9bHcX6oDPwAtQj8elHSfiP+Wh9TD+R
         qbveH5yJOZ6Fw77Szrugst6tIU/uVQcmgAF8F/UZ4P74JiZ/cT+2qzcMP2l6fiWVTPTA
         arsY4f4hC8ppeEACP1RJjjfPYSbpDbgUTlIuwS3X6U1p9Mvc3hIP4HsyEryYHlq9U0bg
         US8XsDa0AWjWb+PZgcYJr6v/AYgjYIT2c8U+vhq5bC7HeOm8EKhNkvH95qfJsZv3kKay
         Q2ow==
X-Gm-Message-State: AOJu0YwHgQVVNUVRgBkb6TQ9FvKhUmNvhT9kfNEMDMGLkXP+u9aOzg6Y
	OjDwWl9dSFEphaJxHQYMs/UlkUfIsOV0Y2Yme8c+ekDc9JNfzEVpB3eXvQ==
X-Google-Smtp-Source: AGHT+IGDukUHRM/2G+sUrsfVdP9qSFC1viMdkcxsOJ6liqOGJS56IGjAda5BNDa8sUjSpbsTY9fjzQ==
X-Received: by 2002:a05:6a20:6ca9:b0:1ca:837f:f4eb with SMTP id adf61e73a8af0-1ca837ff563mr2190934637.2.1723830909247;
        Fri, 16 Aug 2024 10:55:09 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:08 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 06/11] t-reftable-block: use block_iter_reset() instead of block_iter_close()
Date: Fri, 16 Aug 2024 22:55:29 +0530
Message-ID: <20240816175414.5169-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

block_iter_reset() restores a block iterator to its state at the time
of initialization without freeing any memory while block_iter_close()
deallocates the memory for the iterator.

In the current testing setup, a block iterator is allocated and
deallocated for every iteration of a loop, which hurts performance.
Improve upon this by using block_iter_reset() at the start of each
iteration instead. This has the added benifit of testing
block_iter_reset(), which currently remains untested.

Similarly, remove reftable_record_release() for a reftable record
that is still in use.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 5887e9205d..ad3d128ea7 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -78,11 +78,8 @@ static void t_block_read_write(void)
 		j++;
 	}
 
-	reftable_record_release(&rec);
-	block_iter_close(&it);
-
 	for (i = 0; i < N; i++) {
-		struct block_iter it = BLOCK_ITER_INIT;
+		block_iter_reset(&it);
 		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &br, &want);
@@ -100,11 +97,10 @@ static void t_block_read_write(void)
 		ret = block_iter_next(&it, &rec);
 		check_int(ret, ==, 0);
 		check(reftable_record_equal(&recs[10 * (i / 10)], &rec, GIT_SHA1_RAWSZ));
-
-		block_iter_close(&it);
 	}
 
 	block_reader_release(&br);
+	block_iter_close(&it);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT


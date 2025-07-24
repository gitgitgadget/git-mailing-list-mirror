Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEE19B5A7
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395112; cv=none; b=mkyXIbZHFSDyI6lgYobbo9BWc9EisvZEAgpv0UF5iN8sEP3sf1rFWc+sjedEXqgnh2CWTmUlDUGIG/gNy+GQ630K6Fnrdx5GYJRC88/9aYQWItfRenRkXoaTq8jEHtks5hsSDOTr87aPE5M/LfbzlLYMxJ32v2iXuPU2AHCIeho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395112; c=relaxed/simple;
	bh=03NSo4/R+G+KzjfJ/hSSUNH9HJMTEfwxVhLXaO+hRd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W79pfbG2Suw19FB5d8tv+T14md6TH9tTmZ6Ow/1YCw90dusH2sh21kLe+L4e7gtIANQirardOeSpbTFAFOBA06n7ZUKqVtGndru6YX8jstHHyZSFTuzcZD8uEIazX19VlDr3SGuq+RxyGyM/FuWyQqoCsz3zAEi3TTXVrZqG+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhErlouM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhErlouM"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6129ff08877so4105545a12.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753395109; x=1753999909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRA1cFK8oHEe9sb7ASPlUHRTjFPZ6N/SAKPuQVPSGqc=;
        b=GhErlouMHkPxK5Dq0MaihIGqVOgzQs5AuiTCv4iJ/yqG/9qevb8Zq8K/8H6ajJARYl
         wAivFx4fVu92so6s6G/HkKeXhsLNJxUbYK1potFdJVVJOyijalcOa+GkwNr6PXGRJ3DY
         H+rcb0E2KnBqBzQ3XkUuGlk7ToOnfjIj8gr6bp71pvJrDDJDzlXHYcBLluo/bOUTDxwp
         y6LgMNg1bB+93DWPk1ycnVl3JBMI1oFaBwsmO4W21w3mGHD8PQ7UntrgP/r84lJaO2xc
         HsOiA3rD1L3xu7Ryeu2Rjj9v4cNKAEMsFOSgJPSzf5iBZMnyLA3VU3lptVPTQZ+OY4b3
         Cxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395109; x=1753999909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRA1cFK8oHEe9sb7ASPlUHRTjFPZ6N/SAKPuQVPSGqc=;
        b=CAL9JsjvwQTbAK+XiUZX5iUZt47ySdEoMC8oepjizCvV6upSw/BYiYEzwF2V2Ykug8
         MqtxqTIgrrDF8e5Ig0/QaKfC2I2uXCO0UlTjjPq/Nb9yqSSXz6slFby5C++DNQl92IX1
         TavzbUDrAxVMdLnvppUgAuYNxBxNyOUNskLoJr/6GYZa2m4WyYuSaYeg6wL1WgU/4dhb
         abrKBexTyuEP1tqflYS4PqsnJ26bUivHRnJ4IHmf9UkLA83ZUECpJ0zvIOs82wLSUMFZ
         CMnOfV3fHabY8pyYI2XtzsCg6UERzWVtNYlTshF6T7f7+PPArBaz2CygjrXtzARakAml
         gFRQ==
X-Gm-Message-State: AOJu0YwSJFmN/JjCUNuCE5w8zsHTHzTViLEEeyx74/HuvEcrM/LPBbUd
	j0n2n32foKTkc5CJ7vLXv0/6Mc8PckfL3ci8NAu6I5ZjajSxX9g3cBJg
X-Gm-Gg: ASbGnctCFtFEpBquif+ggqYZUapP8pk7pU/JPeh9lCcQP4QTdJYk39uMoSSQ7z/ediw
	3YqlGFromxhKyWOmXy/fPf9u2YHq7IDA1v2C+Ph5abkDIh6mrJMUj7Ll8bcjv+ybomFeOMuT4wf
	+ZnecBcAdr/fU1+aWVJfyFzZrSmInhfnspC4D8eopTnsEKcjJfmK9CdLjlbdNQ+ALnx1NfsaH0d
	AGa/8AUY9qH/PbLbZDq1nYGVipklEPWk/yrezSQG9HcUYZlDMtO1gsf5JnhjXa7ce0Dgg3223l0
	tje3Pp8KvXpXPJo4Ti9DEr858hzuC8Nrbbc2j52z0J/tDb7iL5iAWMZ8MSgvTOtBhY/k3wSGS6i
	088N1wQiavdT0qHeWFl4rEcJyGr/mJzARfxG2jXe1p9AoFjFIv0lxjRA6
X-Google-Smtp-Source: AGHT+IHARwWsxPQ3EfHc3MLiQqST+2sPVfSPkvblO+WrZoriF6nTab0Z7NWFbbnoskHetuSzYd6MHQ==
X-Received: by 2002:a17:906:478a:b0:ae0:7e95:fb with SMTP id a640c23a62f3a-af4c1e2633dmr445587566b.5.1753395108635;
        Thu, 24 Jul 2025 15:11:48 -0700 (PDT)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:9343:e58b:b077:dff9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47d53c067sm169055266b.63.2025.07.24.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 15:11:48 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	spectral@google.com,
	peff@peff.net
Subject: [PATCH] ref-cache: set prefix_state when seeking
Date: Fri, 25 Jul 2025 00:11:36 +0200
Message-ID: <20250724221136.693120-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <xmqqbjp9ikvk.fsf@gitster.g>
References: <xmqqbjp9ikvk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 090eb5336c (refs: selectively set prefix in the seek functions,
2025-07-15) we separated the seeking functionality of reference
iterators from the functionality to set prefix to an iterator. This
allows users of ref iterators to seek to a particular reference to
provide pagination support.

The files-backend, uses the ref-cache iterator to iterate over loose
refs. The iterator tracks directories and entries already processed via
a stack of levels. Each level corresponds to a directory under the files
backend. New levels are added to the stack, and when all entries from a
level is yielded, the corresponding level is popped from the stack.

To accommodate seeking, we need to populate and traverse the levels to
stop the requested seek marker at the appropriate level and its entry
index. Each level also contains a 'prefix_state' which is used for
prefix matching, this allows the iterator to skip levels/entries which
don't match a prefix. The default value of 'prefix_state' is
PREFIX_CONTAINS_DIR, which yields all entries within a level. When
purely seeking without prefix matching, we want to yield all entries.
The commit however, skips setting the value explicitly. This causes the
MemorySanitizer to issue a 'use-of-uninitialized-value' error when
running 't/t6302-for-each-ref-filter'.

Set the value explicitly to avoid to fix the issue.

Reported-by: Kyle Lippincott <spectral@google.com>
Helped-by: Kyle Lippincott <spectral@google.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---

Here is my version of the same patch!

 refs/ref-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..ceef3a2008 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -527,6 +527,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				level = &iter->levels[iter->levels_nr++];
 				level->dir = dir;
 				level->index = -1;
+				level->prefix_state = PREFIX_CONTAINS_DIR;
 			} else {
 				/* reduce the index so the leaf node is iterated over */
 				if (cmp <= 0 && !slash)
-- 
2.49.0


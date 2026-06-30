Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803E3F929C
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833367; cv=none; b=C7CkH9cg3q08+48J90xB7TPjlHgOHfqhYciv+ESZX0vQrWzbcYyWlq89ndhakgLyO9971zk4yIt4d25lMIml4zjTUIGpXHD71SqH/ltJiOmGP+3tBtph5YNs0ZFTIQQwdpmHH+VT2cyX0n3CGy9x5yW+/6hv3onF3E/ogMsG6q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833367; c=relaxed/simple;
	bh=aPqmVR65MXxoVX3g0DYG6CKuA5M7iNnOp1SJhph0RSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnc2N3nMjlK0cnjNZzjAsJ//LZMzL3O3GcII6nrp8YaJ16QwNnKDSEfefahCMjqZLV91LrvDYHPIMP7sEeEaMkMDaKUI2wKJfsAYSQ1T4kzz4zi3f8O2aP9LeoxmYiYyp6LsbU2MbzIcfcjFkwMH6Qz0ZZx6lZVCHBtyD505Ns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI0Cw75K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI0Cw75K"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47640541585so325552f8f.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782833361; x=1783438161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ezj3Q3MyCQ75MAlcDUAfx08nWFUs0vfNvbuRuQI3JJI=;
        b=hI0Cw75KsXNYXICH2gnwSn2qkr+NetPj2AWhUZhT4Rb2riZZvubyhoDzrVaZFTbddr
         vNzV5ZwL8QDFafHmogmYpTgAkM362hgI4ScLgGAjtGR0AgoLVA+lJVpVQ3jQrK1ww5eF
         S0FnozuCFs5k5/4KnrM5KMpr4IscdSuQvZguXV250rGALViJ+Fx2IlEdYn8SaSoJ4Bsi
         LXicZUZhP1Rqq1eCukuHvMNGTnonUVRjVEYP4eEWl9LRlnjTTdWJqa/YvT687+c+0jt+
         iOfJK3JpfmdPP7b+JPNjTvgVl3pznmt/fWz26IS3NZy67/2SkIlxPrAPv5iPiKHz7iB9
         x6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833361; x=1783438161;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezj3Q3MyCQ75MAlcDUAfx08nWFUs0vfNvbuRuQI3JJI=;
        b=Ek7pIPjO3imo46QQaij21LC3lAoyrGsSl9qdSxpO5UlSAppsXjb/KHS91HyUm+CF6p
         K0UgFW7ooGZFvZMvvJeSJDgo2wcVNm2jBn6IF8k1Y70iKy2tjf8COW/z/rvn8UfVGxHw
         DUfl7Bs/uBtr98xmljhbW7Kb3HH8BHjvfQTBbRklGWcRhqWqdjPi6zs1IZW24hMyJ474
         KO/7Bl0oUjMzfk6fh27cp1VGay2sDuL+KUIiaH3BtCRr1wOniobpFPZ+hVIzIzDtu/5f
         chy8LW9bb0Js/KXGd4JXqBhaXxw+iRnDFVxe5RHWwHMoLid9zFmqYowKIO5kJA4XLAg1
         6MBg==
X-Gm-Message-State: AOJu0Yz0NOvrRQfI/nZIB1FlO/FsCZGDEMzJwYW/NhjipznsaNzF9CuH
	zQTxHtsSh1TJ61J7ZgcADrzfdASwWrXW8y7irrCxqqCgNDcIlPsur0xsTRFjJA==
X-Gm-Gg: AfdE7clDOh+ZUweuO25aXPyNtKIZPtp7Jx6xl0sdpeokbyfRjV1CGeJWY8SS8OWaG3r
	zJmObfwmxIFbMXoXOsYdgmiIoLa3mSJJGnJ6vAt3CYLCYX/h/6jgdkWHj/iBOqZ1xwZJ5ozfO7i
	5s5VqyHB5V1ZtMIFKt5Web5BzGX3oFwsDhz4tId3LlavCFzEzv07wD/VOS45kNxg9Q/XEM6RduU
	OZwE8aLUcU2nfYbn7v+7e8VxI3+SCIf+idwkfSV1YC6NQOx/Gbng5QD6nnbwC1NgPC0ThlblMq8
	O0euKiOWc6zb6lLFep0SLjwbZcHZRXeY9upKRfb4qMk2kCVLGEbwkf2wrIPJrknVGlsC0GOIW8p
	htz2F4sNi2Wd3vLp9oeWjW1GkAEpHfxPdiSHG4oI9a6RlxYA1ylh63Glqhk8knICgQwUp2MOgQC
	J8nAVM1SLgzHT/MJq3
X-Received: by 2002:a05:6000:4a16:b0:46e:37a6:c762 with SMTP id ffacd0b85a97d-4765a3b80a2mr1528860f8f.32.1782833361176;
        Tue, 30 Jun 2026 08:29:21 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567979eafsm8477378f8f.34.2026.06.30.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:29:20 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 07/11] sequencer: remove unnecessary condition in pick_one_commit()
Date: Tue, 30 Jun 2026 16:28:57 +0100
Message-ID: <4386ca67d1052b15d15f62b9761f716508ce276d.1782833268.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com> <cover.1782833268.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

item->commit holds the commit to be picked and so it must be non-NULL
otherwise pick_one_commit() would not know which commit to pick.
It is also unconditionally dereferenced in do_pick_commit() which is
called at the top of this function. Therefore the check to see if it
is non-NULL is superfluous.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index bcfbda018a7..ff28873d21c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4988,7 +4988,7 @@ static int pick_one_commit(struct repository *r,
 	if (res && is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
 					   item->arg_len, arg);
-	} else if (res && is_rebase_i(opts) && item->commit) {
+	} else if (res && is_rebase_i(opts)) {
 		int to_amend = 0;
 		struct object_id oid;
 
-- 
2.54.0.200.gfd8d68259e3


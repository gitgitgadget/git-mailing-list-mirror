Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D3277C88
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734059; cv=none; b=Q0+BunBpl9zAXh3+z1S6HLSGFbx3veFxqVOiiaN1HeX0J0lOOmG77v09bm+DAS9dzgo3jHKchXK7eYvmzmPQJhM3J47SH/wwXtMFEXXsovw74N8D/M8107ChtrWQEtwhx9bjgVjL5zw6CDO7t2p3CRaiPt5r6Oc9yzNp+ryfd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734059; c=relaxed/simple;
	bh=Sbpk5cMoR7gDhwmcIfKbM3t3Np7MKg253n5JnWDvv5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKitG6ECcPJd++KJLy75ysrgC9mHKB6qn3W3OABfAvaA/1zMsByeuNf4dcN35/wc40qLatrXwtIClj4MxCN/h+w6dmZ0BcHIBUAcfXVBckS/sPbh10STABe9SmIKv2NqWa6BH/BXyFosotxlzd+nkxeAqWEhhv6mR4xp4+69Kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvuoXLMA; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvuoXLMA"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso2708773a12.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2025 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753734056; x=1754338856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsR3+6qN4W+RDWIHMvMDcdvQKRGBtdQFx9I/VDu3gKw=;
        b=ZvuoXLMAZjg082fKTR52FIcQdPbR+z8kc0nEwugR3c1qg3jWde3TAtT5XLiTIcEldn
         hesVdW5ngZelQ/2kFQ7EynRb1qVc7ecuzNsrNk7QCmUcruYdVgV/cKlrYq89jj5OARoh
         P+qVHxPhxEM2pCktfWziX/KeScbo5en6IiGSJyDZYydYMfPjCDK86coL5CFFsGoIHXqr
         crXB7X2r/L7xA778U4H6c3fmkvNxBopPqJAZraGEMOJLAWOD+LZGUGDl6LRrP4dUcq9a
         Pm2N9gRALFjD2RjDDAbB+sI0NshjG96cWBeh4U4Yqn9B5j+ivWZUJiRsziZy1jpTasWZ
         Xw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734056; x=1754338856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsR3+6qN4W+RDWIHMvMDcdvQKRGBtdQFx9I/VDu3gKw=;
        b=h2c3UF+saj/58A9UQcEe9gPWCBCRjMME+Zr1UsgaVubuqdhoMMIM1c6hdRZkuQVLjV
         4VhMFr7O85/dW8o7ZzESX321ND1iZVWoxso+xfDN3e+mJHc4pE54L5dfUUZJlAdxf7cQ
         /usNyn+oBSA6HjJipMGzFJgptzXusl+1Jc9nOeirar0JNEbnOWu4Z7WdfzjZQIuHg38T
         b4lIGnhogbi+6Vta/6dDUrlictkbTuGJadOuxwkCSVEwFmoE9e0ODoKQOi5DQ+CpANxY
         I71eMX6N07odkV0jV4RNxFm02uJOID4rHPJ8sMAoEWPcqZROOMhz4vVYpx0Hq7CBAekI
         Iczw==
X-Gm-Message-State: AOJu0YzMkxsh2EAO604yMwdvNreRFtMr0cDWNER3wJt2QMidG+7fZOVc
	UbY+3FEQ+lJAxpAYo8uOxxJ5ZyAYPikQ/ZUYVZkZLU3s96nwMwEf4UcJvZyuh2dH
X-Gm-Gg: ASbGncsQwyrIph1cIrDZWMle03C6lubo9i8nBJNpg/j5lMDcRxTjfkg+tMcl7S/PlKg
	S2PS4O6O8kDNNhTyZ3g0SplB1FhaN2kRqOHv8rVHzpcZZMD9MTN3dSdSYQ9sswt4fMmfI1dgE2S
	ic0sokmiKHrKZYsFzyhSzHtDFY54Hw8yInIyxZZb1OUw7UVReY9ezxRjCkqy4A7r9w21x2rtjdG
	bVwxUvn0yU2Qt+PV4qNaAW91M0qvHg+LL6CNMvk2SLFO86UPdgnHnPnxCV3/7hykoDDZ3FJhYaq
	J4fmx3wG2AlMRLtNPCTmG9WOU2FB2f0DURlgk3VFaSy9GklwsP2y0f/pHRQMXuFXIXL8HnJYLaY
	W4wMBGMypVVtkCk1eMABExVCLAgbWPCO7S1GSSsY=
X-Google-Smtp-Source: AGHT+IGe/ZA/aZEQkdkqE6Xwk65RRsxPtsXdOjYJ8sUzdJ6ln284sQU4cr37q+iuIHG1/WjvPRBXtw==
X-Received: by 2002:a17:907:e2c6:b0:af6:ecd1:4fd4 with SMTP id a640c23a62f3a-af6ecd150c9mr139323966b.21.1753734055580;
        Mon, 28 Jul 2025 13:20:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:9706:c2d9:b21a:2042])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635a62ab9sm475376266b.86.2025.07.28.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:20:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 28 Jul 2025 22:20:50 +0200
Subject: [PATCH v2 5/5] ref-filter: use REF_ITERATOR_SEEK_SET_PREFIX
 instead of '1'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kn-small-cleanups-v2-5-d3021c8bf471@gmail.com>
References: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
In-Reply-To: <20250728-kn-small-cleanups-v2-0-d3021c8bf471@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Sbpk5cMoR7gDhwmcIfKbM3t3Np7MKg253n5JnWDvv5M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiH26MaQgIK82iZ6OBM986T3ujhpmPGnd0g9
 DOy1IX2pj0unokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoh9ujAAoJED7VnySO
 Rox/qBoMAIZC7d7s3EKZ2/D4OkMxJv/5V+JiX4iEFNFVd+mrj0F8RBgwPBmodHm+XRJ42KMQmj0
 MYBUE5gLkk/eMtBARayroV2BG1vxfKlOmT4UIRfd6SfnmQOOVeWy/BUuPICP0Zc8wJYYSA9x6e4
 Ijn7r/8qUArvb12quWSXgzlc59HS79gtFJIJo0GDylb7hO+4sX1ZqhgJl3bhVep5I2//eH1djAi
 SsqO+dAx/yuBvLhIM/tdUbwWK1eBeKpi5Ca2PgCkqdVOa6phVM43IQTw+FJnx4g3DOCwrB/yEwJ
 NUme4wJYIld9BCUjIfae85HosACE8UAOQZlLJxfyAWKjPexlqTGtiWBX3Qodh9+LmDeIb4gAj7g
 Ekot1LjwHnC8/LTrPZF5qgOBOBZqmrM8s5cnO5aAW3m7VXPjetK8kDxNrVBTQidVaKEICwvGl70
 DNSFdFt2DQHQVYm+CUBhXa+wIXg8EcsYKOD8DMMFuBbQ1WVZLa4joqVds22jQd0BLblfHvWkap5
 7E=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the commit 51511d68f4 (for-each-ref: introduce a '--start-after'
option, 2025-07-15), for introducing the '--start-after' flag, the
`ref_iterator_seek()` was modified to also accept a flag. This was to
allow the function to also set the prefix when
'REF_ITERATOR_SEEK_SET_PREFIX' was set.

In `do_filter_refs()` instead of passing the flag, we pass in '1' which
is the value of the flag. While this works, this is definitely hard to
read and introduces inconsistency. Change it to use the flag.

While here, remove the unnecessary 'if (prefix)' clause in the 'else'
statement, since the block already checks for 'prefix'.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ref-filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d5a146de87..4edf0df4cc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3254,8 +3254,9 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 
 		if (filter->start_after)
 			ret = start_ref_iterator_after(iter, filter->start_after);
-		else if (prefix)
-			ret = ref_iterator_seek(iter, prefix, 1);
+		else
+			ret = ref_iterator_seek(iter, prefix,
+						REF_ITERATOR_SEEK_SET_PREFIX);
 
 		if (!ret)
 			ret = do_for_each_ref_iterator(iter, fn, cb_data);

-- 
2.50.0


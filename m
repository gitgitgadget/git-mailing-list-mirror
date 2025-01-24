Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0212E4A
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737727339; cv=none; b=KzSwC/jkGvkwRiDgj+Nx93JqAT/0HQpPJNzXRN3JpgeHKVI0J+NE2Hssgth2eUhp5mwpueaGWF1PCxTi5kXeCcberJ+bdOL9JIpSnhyP3qmYz8K9X2bIG9d1LhH/vu5Nhe5zGX67ujIynyRlbMSbVKpISfLABdOQGBj5EmD1bJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737727339; c=relaxed/simple;
	bh=yZdNetbpT/vqLz8RUdUlxxvvSaxXdrgzE1Js2Ub4hm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8mJ3gZt3fSAWpaJd7EFKI1w0Xxk2SLNQOoTkVUm5HerXUKkFfC1zm93RDjwoSy/LPk8zxKD3VsKmW1kaha+2A1j41UGYdUJx7C32y9FYPD+nB0ORh9lVRjvL4jbBIriYWSNSapVaEpmS6OsscUmrCk+CG82c2C+CXHQQFTSthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W787F+5e; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W787F+5e"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso3184654a91.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2025 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737727335; x=1738332135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyoDgMoYn5s7AsGT5YynjUmo2n/Dr/AZXj7vIdIBuiA=;
        b=W787F+5eKcYPQbTgNy+jRB3Bmst+eOthEQTgtmx5ULiLUdfUsuJ2YlvuYc2zcpVq56
         kJykYvEJeOCO4sQ0KF6bTueZ+13vWIk19kmJO51Yhc9MLJpVemcxZoiCZe2nPw997rJM
         OL4GYV5DoH4Jfa0jowBS8wlgWkc4xEhtxaY+mPzhfFopj6mGVXhgkjwy+pXK28S5RKiW
         kaBSXf2+onKMLH0XynEmpl3X1+ubt3dj12/bmRG7qYruK5yCULH33CfFJivNMzSCCx/F
         NirHM4nvSj26Iy64rTFP9jJJQyz+lHwCYpjHg54CJzAUmulNMtKaOZrXqYo6cM6T1Hnv
         LxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737727335; x=1738332135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyoDgMoYn5s7AsGT5YynjUmo2n/Dr/AZXj7vIdIBuiA=;
        b=EcIcU8w0jjBA17725aUnc5Ys7Xf1N1Dk+Ewo6A569AE3aXSb43xRsMTKvpoAvecbxn
         UnHGSCgr5/QKqTfr7YqlY4w9itVst6MX6BxuoPX1so5++gqtK3wKFo3PC2qJk7syPRv3
         xuGs1C44Sn34DghIL86ytpPHC1TTYesnUZSwsoT0NadsOTnQUfanPi2nO+cv9A/sRlQv
         CdZQrpZNgLB5xg0KLGBJVLtbdpHP0aDOm8lseZ4MN7rIaB7WsM44KaZINnVHLzC5IXx6
         ravWztJY11y2hg/XbmaatwFEMMPOSOyqYuAbbA6Ef9mcGp809NSvqYo6e58fNVC4/3zX
         39jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVujCuuLdsw/hVa8KQEJ5yMiZW3glAIpXlKCP8dS65JSZI9TQQ1hZH/8Bc7aJ2EyS4WsqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKGUGQ4q4aybKqnrRx3WX50nvpW+r9KvGW/GpAifNm4B0kBqr
	U/eBkfIAnDZ3VlP3kLePnC7c+A9H2NPRRebUcuy7MMCg4t9s4B8X
X-Gm-Gg: ASbGnctZnAsszO9cnGt/xOx3xplz+OZNOQEl+AQh6ZzyrTJcGMEtK6QNwA1Z8QtyzAJ
	8ZEsy8gg7B9j9Emnqtlnj6ef6T8MWJOUmMpmN2zD5K7MaUbLBxn+rGGCcZlrLZOPT06cwRC/YQ8
	HIDLPqzhupP/CQy08w2v6lbOsDOJx8KBiYwYNsBD6szwnrPPQbJvJ42lNiqWHSxLt5myTMRBfah
	WQofXZlpZo/WlOAfcY/RtTt+3Qqf8TE34tWMswxVwIKsIRWwtOLFyAhm8g8qam7jY/u3mrGJNER
	TCgYh4FYDutcHCSPPgIsDNc=
X-Google-Smtp-Source: AGHT+IEX+zv+JhEeYl+8pdlVU+VCSg+GQZtBwli+zyxveFXmgNrvUOqB5b189ZKMQGuMxrUZECW8vg==
X-Received: by 2002:a17:90a:dfcb:b0:2ef:19d0:2261 with SMTP id 98e67ed59e1d1-2f782cb509bmr49099259a91.16.1737727332909;
        Fri, 24 Jan 2025 06:02:12 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:62f9:3931:8213:7a16:3f9b:a10d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb19ac5sm1869879a91.46.2025.01.24.06.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 06:02:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: gitster@pobox.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	karthik.188@gmail.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v3] refs: fix uninitialized memory access of `max_index`
Date: Fri, 24 Jan 2025 15:02:03 +0100
Message-ID: <20250124140203.886324-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <xmqq5xm5s80e.fsf@gitster.g>
References: <xmqq5xm5s80e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When migrating reflogs between reference backends, maintaining the
original order of the reflog entries is crucial. To achieve this, an
`index` field is stored within the `ref_update` struct.

In the reftable backend, before writing any references, the writer must
be configured with the minimum and maximum update index values. The
`max_update_index` is derived from the maximum `ref_update.index` value
in a transaction . The commit bc67b4ab5f (reftable: write correct
max_update_index to header, 2025-01-15) addressed this by propagating the
`max_update_index` value from the transaction to
`write_transaction_table_arg` and, ultimately, to
`reftable_writer_set_limits()`, which sets the min and max index for the
reftable writer.

However, that commit introduced an issue:

  - In `reftable_transaction_data`, which contains an array of
  `write_transaction_table_arg`, only the first element was assigned the
  `max_index` value.

As a result, any elements beyond the first in the array contained
uninitialized `max_index`. The writer contains multiple elements of
`write_transaction_table_arg` to correspond to different worktrees being
written. This uninitialized value was later used to set the
`max_update_index` for the writer, potentially causing overflow or
undefined behavior.

Fix this by:

  - Initializing the `max_index` field to 0.
  - Moving the assignment of `max_index` in
  `reftable_be_transaction_finish()` inside the loop, ensuring all
  elements of the array are correctly initialized.

Initializing `max_index` to `0` is not strictly necessary, as all
elements of `write_transaction_table_arg.max_index` are now assigned
correctly. However, this initialization is added for consistency and to
safeguard against potential future changes that might inadvertently
introduce uninitialized memory access.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Hello,

As suggested, I've redone my patch to make this a relative patch on top of
'kn/reflog-migration-fix'. 

This is based on top of maint with 'kn/reflog-migration-fix' merged in.

Thanks
---
 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 289496058e..d39a14c5a4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1020,6 +1020,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		arg->updates_nr = 0;
 		arg->updates_alloc = 0;
 		arg->updates_expected = 0;
+		arg->max_index = 0;
 	}
 
 	arg->updates_expected++;
@@ -1628,10 +1629,9 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	struct reftable_transaction_data *tx_data = transaction->backend_data;
 	int ret = 0;
 
-	if (tx_data->args)
-		tx_data->args->max_index = transaction->max_index;
-
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
+		tx_data->args[i].max_index = transaction->max_index;
+
 		ret = reftable_addition_add(tx_data->args[i].addition,
 					    write_transaction_table, &tx_data->args[i]);
 		if (ret < 0)
-- 
2.47.0


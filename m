Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7635976
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398186; cv=none; b=YaYBgVPGI5lcTgEUM1XGIP2KQQ231QdzCBcyZHlvWghUlfxVn4bB+jlJJKi0Wo+pT3hi/szgbuhaE8RF86ZGy1XHG/Jb9z89TyovTeMdsiNZF3Yo4GdM/hDKrvKlXmkSG9Ct20Z/sPMX3XePO4Wx9SVUL8+Xn4okXusP3VsWXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398186; c=relaxed/simple;
	bh=wIgQbevd8qZwRixwtJSoZxrk2bY9OczVr2ZPMGMz2UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HbNErc0bBP8G8TEW9H/glgkiiQlv3/pUDrOLszS6Ocq5pQpFRkMst7YYzyieRJxU4YQ0Xng6wp1Frk2wKmr19dSowXreMEedtHEHRkgDmSCZfLbX3Dh/6ixnxu3jKtTYISj9R8iXi29atu2h92MN5s0fleE8AJ0/wsBVheJ+EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YID4tkup; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YID4tkup"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-225df540edcso19479985ad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742398183; x=1743002983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NVNgzFAc35IoLbJa50aNCVmZaBkJlMu+GXurSmO3cM=;
        b=YID4tkupvmVKJ9WzCVKEBAjDWKyIq3hxREQ067VwHudBFjqRQdyMagB0T81KCT05r3
         k1QSOSjPDXloT3j0YBTRNFDYGTgfj4UQyszAh0d67xIlnbebZVr6Dt1FXoisC+aOKMU3
         dHRvGszq8EwsRTX/R/Rqb4wae/DLadgBuX8lvscI+ma4z2HdOS5eJt5zDS9ID7sRi1hM
         PhU5UeYjdsQ0t07Y8diY+H/6bFgQGO1dhQGBujvcVwEaYSX5MQyu3DHcOF20YjvRPhSB
         VROn+z9h8FcuHfNQfQ4Arz3IAfGFm8bxvfUJByDV6wXnTBugMgaGc8XHPVgqk40UAQbU
         vaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742398183; x=1743002983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NVNgzFAc35IoLbJa50aNCVmZaBkJlMu+GXurSmO3cM=;
        b=HUPMY8oGhfxYtUYVD8ySMyxZQdLKVVLN0qdJNEIm3+gBbEL83AwGJ3KzDhG1igONv1
         TeSy4Z4Rk3cO+SFanWlPdrApSB9AUkUwydRFdA0DACfYgSL4TdcPMJ5a4wbaKoIpUyRb
         1zsRPDIr7fwKFbPW34xE8eToeK26JsXW8lwuMctaLUZDzBqSIyF7pphf7DXYBEPuvFzq
         NHXlVFecwyNJFsiClDaN9QArGXvojWIMz+uDhu4xnslXA5mSPJKSfeSfo8Oy93HywC4k
         AzV1fXbneN5/83+Og9QyKKHvnKrgOGX3048zqq8oqrC1BQpU4QMILTToX7PRzmm0k8e0
         47Xw==
X-Gm-Message-State: AOJu0YwownrUU1Xc8ZLdvhC1lnJSm/0wFoQkUcMjrk0VzGP9PzIgKycY
	Qa4/IWEDDyFZZyj7w0drilJQvxOqwHEPjvZdG4uOGXZzB6TG5JOGOje0RQ==
X-Gm-Gg: ASbGnctBz7i36k+XXUyJVL9nUAc1mwAT8lVfca05GvvF4iygTZB77inIM/oqKamgj7V
	NcYJinDMsVJIsEUZlu9WIf0hAQ25umtfy8y9WciyM84ZUv8VU7Dd0gTknvRIfFXObK9PIorQPx8
	2mDi0qzM6qtMgTeCHJr5AkvJNxwTK7E2AF0LRgwlvSItEdwM7qzszLRK9zCXRonL4pl/tnripYq
	+9ICdTIiH19lJT9YG9G93pVp3FQpYsJEMsO0a6vvEcVllRTkEcPVyn67DdsI4wrFFssLO6PF5SU
	Ql2BKn4fMoI/Wsb4K/06mfSMGO2DAuSRONk+Ignt
X-Google-Smtp-Source: AGHT+IEuqnW83JvOJxWhcqIpPrnUemhQTbp82pHXFJC4KEcD+9QKu+aRsMuoQYXxpqKEFj8plZUQxg==
X-Received: by 2002:a17:902:da8c:b0:21a:7e04:7021 with SMTP id d9443c01a7336-22648f0cf6fmr42884345ad.24.1742398182852;
        Wed, 19 Mar 2025 08:29:42 -0700 (PDT)
Received: from meet.. ([103.86.19.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6865sm115889305ad.75.2025.03.19.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:29:42 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC PATCH v5 0/3] reftable: return proper error codes from block_writer_add
Date: Wed, 19 Mar 2025 20:59:24 +0530
Message-Id: <20250319152927.1263033-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319075943.28904-1-meetsoni3017@gmail.com>
References: <20250319075943.28904-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series attempts to avoid making an assumption regarding error codes
returned by block_writer_add().

Changes since v4:
    - update commit message.
    - add documentation comment.


Meet Soni (3):
  reftable: propagate specific error codes in block_writer_add()
  reftable: adapt writer_add_record() to propagate block_writer_add()
    errors
  reftable: adapt write_object_record() to propagate block_writer_add()
    errors

 reftable/block.c  | 13 ++++++------
 reftable/block.h  |  2 +-
 reftable/record.c | 53 +++++++++++++++++++++--------------------------
 reftable/writer.c | 34 +++++++++++++++++++++---------
 4 files changed, 56 insertions(+), 46 deletions(-)

Range-diff against v4:
1:  6ab35d569c = 1:  6ab35d569c reftable: propagate specific error codes in block_writer_add()
2:  7f0bdc27e1 ! 2:  873a991a2c reftable: adapt writer_add_record() to propagate block_writer_add() errors
    @@ Metadata
      ## Commit message ##
         reftable: adapt writer_add_record() to propagate block_writer_add() errors
     
    -        Previously, writer_add_record() would flush the current block and
    -        retry appending the record whenever block_writer_add() returned any
    -        nonzero error. This forced an assumption that every failure meant
    -        the block was full, even when errors such as memory allocation or I/O
    -        failures occurred.
    +    Previously, writer_add_record() would flush the current block and retry
    +    appending the record whenever block_writer_add() returned any nonzero
    +    error. This forced an assumption that every failure meant the block was
    +    full, even when errors such as memory allocation or I/O failures occurred.
     
    -        Update the writer_add_record() to inspect the error code returned by
    -        block_writer_add() and only flush and reinitialize the writer when the
    -        error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    -        propagate it.
    +    Update the writer_add_record() to inspect the error code returned by
    +    block_writer_add() and only flush and reinitialize the writer when the
    +    error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    +    propagate it.
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
3:  480ac27797 ! 3:  1e2f7ff83f reftable: adapt write_object_record() to propagate block_writer_add() errors
    @@ Metadata
      ## Commit message ##
         reftable: adapt write_object_record() to propagate block_writer_add() errors
     
    -        Previously, write_object_record() would flush the current block and
    -        retry appending the record whenever block_writer_add() returned any
    -        nonzero error. This forced an assumption that every failure meant the
    -        block was full, even when errors such as memory allocation or I/O
    -        failures occurred.
    +    Previously, write_object_record() would flush the current block and retry
    +    appending the record whenever block_writer_add() returned any nonzero
    +    error. This forced an assumption that every failure meant the block was
    +    full, even when errors such as memory allocation or I/O failures occurred.
     
    -        Update the write_object_record() to inspect the error code returned by
    -        block_writer_add() and only flush and reinitialize the writer when the
    -        error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    -        propagate it.
    +    Update the write_object_record() to inspect the error code returned by
    +    block_writer_add() and flush and reinitialize the writer iff the
    +    error is REFTABLE_ENTRY_TOO_BIG_ERROR. For any other error, immediately
    +    propagate it.
     
    -        All call sites now handle various error codes returned by
    -        block_writer_add().
    +    If the flush and reinitialization still fail with
    +    REFTABLE_ENTRY_TOO_BIG_ERROR, reset the record's offset length to zero
    +    before a final attempt.
    +
    +    All call sites now handle various error codes returned by
    +    block_writer_add().
     
         Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
     
    @@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
      	arg->err = writer_flush_block(arg->w);
      	if (arg->err < 0)
      		goto done;
    +@@ reftable/writer.c: static void write_object_record(void *void_arg, void *key)
    + 	if (arg->err < 0)
    + 		goto done;
    + 
    ++	/*
    ++	 * If this still fails then we may need to reset record's offset
    ++	 * length to reduce the data size to be written.
    ++	 */
    + 	arg->err = block_writer_add(arg->w->block_writer, &rec);
    + 	if (arg->err == 0)
    + 		goto done;
    + 
    ++	if (arg->err != REFTABLE_ENTRY_TOO_BIG_ERROR)
    ++		goto done;
    ++
    + 	rec.u.obj.offset_len = 0;
    + 	arg->err = block_writer_add(arg->w->block_writer, &rec);
    + 
-- 
2.34.1


Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0131D37C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776405; cv=none; b=DFQlRu7pPyzR4L6tiA31dm0fY2UQBK50h7Rb0xzdSdQRcJ+9u45rTzmbVdZp+p4BJNTZmFEzJKprVH2ZJS3/YrbGxdi9AnkyTf4Tbv+1dO7Sb1zPtfLr22+oYo+yxuT5XRxIYIk4TPYudZQBCiYa0aHlT1ejILXbg3609H5RLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776405; c=relaxed/simple;
	bh=kaefKjxc/A4Xq0bsinAymFjb8L2A2ZsrQrRBtN98Gn4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MzZKinNtFELmKRC8atS3tZmkKdnSgOlps+uoAil9A42lrc8M9QFwWmqfILmd9PvlUSD/xnRMJXtekIGT/e8sTQJjjziEjHYagKDxRqFRp+iBA2XuxcNcSQwPZk+7iMun0BAHBbTDpAZTnRgZJVWpsi9GGN6srSYjjIgakPU8UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMqWd5Jr; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMqWd5Jr"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-938de0df471so36243339f.2
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 15:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761776402; x=1762381202; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4VGA6JT4d/3GAOaLEuwMO7fptgTSAQUEDklPonASUU=;
        b=XMqWd5JrIUsTST8RFyJ3hd9LECbOz/8ZfZMavL0AdJPkjW9fb2Q/lG1Ssd41EOkc0K
         3CSWcr0cKMVn02MbiqSPo1r9LOkrnlnDcQqetvJeC0ywPIo1UzY1XRMev5lA8n7ObwCy
         y2oVLpj7jx6QoAAYQWnzK/Hp5qlsqn62E88WqyZJwEZDDYO7ShruBPjAxPOv/mIbLMT+
         Zengz3NfRUP4HJQ237aIhO1sIsI0YSfYFByOwvFdp0Efw4oBT1m02qoeV/lazqMmLtUW
         jWVGJt1FssPPnAOZBisMs4f62tqOSJE0HcThOsR5gR7QRhp/vuPdUi5bIvLqtFMec9Jx
         M6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776402; x=1762381202;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4VGA6JT4d/3GAOaLEuwMO7fptgTSAQUEDklPonASUU=;
        b=GzqriyzEUIlzk3bf2VshDwYwAGrdx3SJ84OpkC3teck3JWdbBe/yCuDo05k0gyzne4
         5Fip0QqvL60rBw9YWcN+1sfJcBaBsR44/HmbGnrUze1v6rKTlP1ZM5MXLiXQBDDahJ1N
         HlBhWg6P1/bF3wEJkXP9RzTXX/HF+gyfu9j6TbGDnMvqD/aTYYww4GuODIv3NSGEoqDf
         97i1BtejEWLUbw8nmgRo/APft0PReBnQ9u2zT4zneSEM2xJGwLcrdT6hnu6eTKwWGOWJ
         Ng1EVGWNFZyvtcDjcLZMU04iNooQm0rS2jjGAuZW8ZjLXIJD8ix2OjrhE/ug659oUCFs
         IPAw==
X-Gm-Message-State: AOJu0YxiCvwLxlbt67Xtu7yZ61JbHHdcFJlGSap6oQ9HSmOT7zmbKvUy
	9OCn41x+hgZnxhD7YiTzHkKxgY4H7w25d0UoFrkGn+8PuCEiGgPLad0C8zI21A==
X-Gm-Gg: ASbGncunhBJrvO53S/I+HOFaZXLsBzFDukAYjTHjVJj0AcGCDvOdkxU+5RuyBfxKAvh
	MUPmGCN5xjKHJAciXeuEvQ6Pmk3vUosMnoKhzBVxpJZxk7hnPDQYRamOMPwICkja00SIm78k+dP
	ZzYKIxOTfv/m18YMU9A4ZlIhrwNKzRxRaTAU2ZuW/tfbEOc1w9Prc+LOPAjBZaIrADcyOpX+l2i
	m94PiO42MKNxjA7oFf02p0xaqWuzKgv1ez1o3ayGE+0w2OLQ4dGGyoPNHy4EygnFXtUr040z/7+
	mbKbHnkIS2lDBsonXhKzx3dvheeMECS9HFIUpFs2a8HLz2fIHOx5aNiytd5X1HGKIzMjz9fk8TR
	G5nST6YeHmcqUvuMVbPSobrXCoF3qfFYmilliF2m4003ntu4SJBoIkP0o/pOv0MVdD5UCkTnLGa
	2aFMCpsVAgUhoH
X-Google-Smtp-Source: AGHT+IGTdCQcENL6HddQHQ9eO14ZLSzQ1oCZV0mYHJ0/+OW+dHO9nw3UIvOJd30K7VwJHOX60hTMCQ==
X-Received: by 2002:a05:6602:48a:b0:940:da70:9dc1 with SMTP id ca18e2360f4ac-948151ec5bemr169089239f.8.1761776402348;
        Wed, 29 Oct 2025 15:20:02 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946ddc5sm5872824173.36.2025.10.29.15.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:20:01 -0700 (PDT)
Message-Id: <3b6054945f200def2b8ce77867f34b096bdfd0ab.1761776388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Oct 2025 22:19:47 +0000
Subject: [PATCH v2 09/10] xdiff: change rindex from long to size_t in xdfile_t
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

rindex describes a index offset which means it's an index into memory
which should use size_t.

Changing the type of rindex from long to size_t has no cascading
refactor impact because it is only ever used to directly index other
arrays.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index df4c5cab1a..3bcc0920e0 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -49,7 +49,7 @@ typedef struct s_xdfile {
 	xrecord_t *recs;
 	size_t nrec;
 	bool *changed;
-	long *rindex;
+	size_t *rindex;
 	size_t nreff;
 	ptrdiff_t dstart, dend;
 } xdfile_t;
-- 
gitgitgadget


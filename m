Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0052FB09C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392566; cv=none; b=nLGuG74kgCA1r831OBjTJ+5+UFOsKErDfr/sXKU9ttTny/tWFTbRnCV2Z5OpOg/PAQrg42MRp7hUVGGIGK5EIuOTuXCLQL7b0C4Q0NFQgTYgqu/mGsWUI2IJKXGnVfGeLBGW4Xkjjp+AOkgrQdlel4TKBQlGD3bNKpK/N4aGprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392566; c=relaxed/simple;
	bh=lJYCphmkVqqaBXdZfxNzJRxtC2ipPeRJd3wV60on7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m2kbowbjMbQcBjrQYiROhyjBXBTCl5G1nhay3whGdFmMDZuyX6EqSdihQHOGlx8cV1ap4P4/545BFZPsXhslmu36GMbBLcF2iTP5o43ThMuPV0y080QAbom+YzrvEj0QMwzelN87qFxR2OKjwcpvzzziqMu78V8CGESV9uoAHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gRSq8I/9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gRSq8I/9"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so121828539f.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760392563; x=1760997363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K78896hUe8HxdJeNsaH1wIM2F1haMlDyMjhgV675LXA=;
        b=gRSq8I/9u2uzSF/zgQlUMXGlxyZrX/z0snooqPo2aHe6lu69gV7A8qej3G78z0iav7
         3N4eQnTc9OOhzUSYVgtCYXQfriSnnU6lW+etkKRHXt9Bl3bxGrcLxDXr1m40OTiMjJ2d
         t+Ipq95ttuO9yetkTaBLtYiNzsRgZXxecOXkYJFDxHSRD7lQ8RKNGAPrOVUa6LPHhhvU
         0CbquhFyCSP4BisFtlt/7+6+7dKCHrKMkTat9ZD7oMgnjzvM5j/qFYTAZJwCwLkUfVbA
         xXb9cfse5L/h8c6T/hmzbnk7oHrmqdZj/35uQjfRkGUEzC/CqJmhpHRtfwTZYQTegKch
         DKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760392563; x=1760997363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K78896hUe8HxdJeNsaH1wIM2F1haMlDyMjhgV675LXA=;
        b=mMUq/vl999e/19zJo3DjdLQXeZU2QpFgbFOZg9v06IJvAD8Bvge9RaafkSrurRY+qk
         V4cSSXhX05UJ/L7PXfc3e14F1oQpAGfMle3LQPi/WFyB+aFtmRpUw+VgoDCxaONy6AgG
         jt0VhDpRfN8F2i72n52INeJ+pxQQNrJuOMhbYOzdbsbkNL9lvh6sJOPXA2QyObJy34/8
         U/rtD78G4WCtIRb0yXM6Xdh9mz39cXgvv/cTBc6HYM/4a5n5VjHM5GWNn6sho10+g9bK
         +v8+VmvgPwenGybvZ6pDgbfMj6XErKWPtEHsmlART5/JOEd4q9Ol7HAfNUaC9hOlrKMi
         PPmg==
X-Gm-Message-State: AOJu0Yw8VP+rs+ihOHE0/WyIiDVZd5FcM+RsfSaPVfd9NLTZOadweGoe
	EjbItQkYVMaw/3T1Ug+zw62Hn9NQVXSMmFrh/Ffv0QJACEfpA8X+NzKD5LFLUtcXkkujpL++g6e
	tig1NPAPyKQ==
X-Gm-Gg: ASbGncsIWplEG65srkuTJOb9PaH+kgFAxfCeIDP/lb159S6+1aooPkjOSGXtET78ApX
	efeyiV7VBfGYktAngkfGzyVmDRODfbEbaHnxqgyz99JIigQ6F1YuIdVKG0WXC/NYXMQrWwBNK/Z
	x272C1298MB7Gd0M88CvE+Kh7Bqtgx9tSXuHzEwa+SCUyVeA11Ul4VDygX8qXv0l2hCB+bJcm6y
	fPb8+MhOT0ab0LPTbxHv1eDpon9exDRkrHyT2rF2ZpNq6lyCZwuMMmYPBGKSA3NiTbEjz9JWV6M
	k1FQQLnqZkR2f6XjforwmcNa8Tx+3ms/Lt1O/4Bkq3g4KbPJ+wYWBR5Aj/YzwVE4NGt+g347p/x
	UJXXkzAyCrSg8hvMbTrMTc+GU9mw7h5k7GBbOV66PcDCcImtZyknKfKVPLzrg5EBZb2L+9pFlnA
	dAUkW6LHCAqtuw6UDNCkBSIeZdG/eZuLR4pTk4pSMVL98U
X-Google-Smtp-Source: AGHT+IFFy+f3PdZ3b8CEzXzejG9uqmtKQ81GFOMyGOlGsC9X9dE2wulWZbhPvK5dlWK9KP4F+7ibmg==
X-Received: by 2002:a05:6602:3425:b0:90c:8a72:cfd0 with SMTP id ca18e2360f4ac-93bd1950557mr2657285039f.18.1760392563288;
        Mon, 13 Oct 2025 14:56:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-58f6c49b522sm4209526173.1.2025.10.13.14.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 14:56:02 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:56:01 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
Subject: [PATCH] builtin/cat-file.c: simplify calling `report_object_status()`
Message-ID: <9236fa6e654a59337266430a2a8807da21210cd4.1760392502.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

In b0b910e052 (cat-file.c: add batch handling for submodules,
2025-06-02), we began handling submodule entries specially when batching
cat-file like so:

  $ echo :sha1collisiondetection | git.compile cat-file --batch-check
  855827c583bc30645ba427885caa40c5b81764d2 submodule

Commit b0b910e052 notes that submodules are handled differently than
non-existent objects, which print "<given-name> <type>", since there is
(a) no object to resolve the OID of in the first place, and as commit
b0b910e052 notes, (b) for submodules in particular, it is useful to know
what commit it points at without having to spawn another Git process.

That commit does so by calling report_object_status() and passing in
"oid_to_hex(&data->oid)" for the "obj_name" parameter. This is
unnecessary, however, since report_object_status() will do the same
automatically if given a NULL "obj_name" argument.

That behavior dates back to 6a951937ae (cat-file: add
--batch-all-objects option, 2015-06-22), so rely on that instead of
having the caller open-code that part of report_object_status().

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I noticed this while merging v2.50.1 into GitHub's private fork, and
thought it was a good opportunity for some light clean-up.

 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ee6715fa52..5ca2ca3852 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -495,7 +495,7 @@ static void batch_object_write(const char *obj_name,
 							    OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
 			if (data->mode == S_IFGITLINK)
-				report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "submodule");
+				report_object_status(opt, NULL, &data->oid, "submodule");
 			else
 				report_object_status(opt, obj_name, &data->oid, "missing");
 			return;

base-commit: 4b71b294773cc4f7fe48ec3a70079aa8783f373d
--
2.51.0.491.g4b71b294773.dirty

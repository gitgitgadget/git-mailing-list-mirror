Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1872798E6
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100385; cv=none; b=qMA5LNp5d3amnf1/+liVPhaoC8HsB5z6EH5wFJpzJMDOz+TV6vD9sDozZgxzVkkFStBQvjY3lmSBQC4mGWTaUGl0wls4lRgse7DtMDbPUKPA9/z8LGfB7Kis7NvS2haC9FqNGjIPhiimNKefkGjq9WMR4LhxcYRM9qjXdo40XR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100385; c=relaxed/simple;
	bh=5WS07mlmA2lu/Cn9FAmKCbL8pCgvIUAHkJV5ztAjmbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E/vZWuIQTkvrHGamHj9ykh97i+QDEhZhZdSAoUn15vaXL96fjU4zgtR2WsFWVo/RHkYYw2ERU072DhskdBWb6xEqvCutjXUoXaFcIL76rCjLGVKp036LfSBXAocbZGCyv1oRLd+G/KGiPR6AcQ50faLCmrkSsMkyPTBUKU3af6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWdJ9V1E; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWdJ9V1E"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so1620578a12.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100383; x=1757705183; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU19w9CNexskRVaDNoPPO+mu8E3ygj/jMD9oEf9q+Gc=;
        b=iWdJ9V1EUsIUYqxt/hf08YXCtrq8vfGabCASzvlsOWX/Vo0Zsdhq8UU9lEDTUWUa1C
         ywWT3rUISXlyz0BuYOqNvrWeCv5690LkWPdvaip5JkDtRk/uDRAYcQHuoPMNGQPRs1j5
         i6LDGLZKMHTC2Qw7trogUI2ymSklgL+Fs09bsUM0I5y+5IPxRxu6ULj9J71ZZeVnXKB9
         U6rtbDX22SV0FPH7LQ9/PyuFyXECfIDyltb7Xm6HGWGkmUJAxnq3yJN5/gjV1Ypc96vu
         o261KnXUWWtD6rL/9PMh+REzMbsywpQYnq0qukOHJs7dpxKmzRKklNCqzsR/99NxB6Rj
         l3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100383; x=1757705183;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU19w9CNexskRVaDNoPPO+mu8E3ygj/jMD9oEf9q+Gc=;
        b=oXXxYzuaOPzI+5a18sERvpBHLbf4dll01g0UVOwszUUKLGoIlJO4CJSqO70LPheIEe
         SBockgSGVix1quZUBLQ7ymY/OcU/hyCGtlGjBmHLA1uzGpfRMDZLpN/7mwulkjIALmmt
         dWOjgYgV4eHMVq184e03WRwosPTXrBTdBZoO/4+i3S4KfoPZV9iLx338ZMkuPWh8saft
         T7l9FUGTpxfmqfENx/eutwmwCCtKBjWP8N06KHYilNpDgOxVQSCtLLiKhfV5LodXF8Zk
         +N+VcHjB4Y2LAPaAmRFOf1X8a1AIjfYFICfJBImDMgMpXs3imNqpWhq0Zdm4jsvt0Ohw
         P/0Q==
X-Gm-Message-State: AOJu0Yzu52zlOEDpF19KWNHCCbnG5pShzBeSatv650/cRYpUA4OsDlL9
	BpNhSBAtNwzdtpOJwkODbJour/pPUm8rRps1YgyS92peBNhhcCRU6zYahXTwtw==
X-Gm-Gg: ASbGnctYjv/d3HvyQJ1KdCxui5JP3Yp078hs9JskJBpS0hzQgc8GvGW/p5vOhv8WlyO
	A6OFl8dOECAjxTiymrqV08rJqZgss0nUsWnsx5CP5wSAgW66Aws89Ndc42aUaoCy4S71+Kjqndo
	p4qzRxus+vwejfsgS+wL9bGXyMQLL44OfbDLzy+wL4k4Qw8mdoEq1/Au5uiP1nflJyIChH+tWYp
	Ocj6ic4JPP4cjUdIP47M/FhVComVNcKSWR+ukXmgF4fBdrWvIb/eF8yuavCNnc6JFYL2xTJp1LE
	6PR/y/cGDKMjmcM+TEoXUlj0Rajfk8e5FwZ3HK1AScEUsS2I8O1+wRU52cfvO3Fe3wHW7MOr8me
	pu/83/7RLRBM4CjWIX3hXyIfUp0uRoabXUOok
X-Google-Smtp-Source: AGHT+IGK6r+04ryIz7IuihQfv0AgZ7dEpZ0rp/wZq+hjNHTI1rz8Eg72x7Sc+Kw9/j5rF1ff4leSrg==
X-Received: by 2002:a17:903:2f0c:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-24944b1ca43mr342824435ad.38.1757100383315;
        Fri, 05 Sep 2025 12:26:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11448a5asm112043285ad.54.2025.09.05.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:22 -0700 (PDT)
Message-Id: <414ae51024ef04370180fd550b4cd51980cc7133.1757100378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:15 +0000
Subject: [PATCH v3 3/6] midx-write: use cleanup when incremental midx fails
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The incremental mode of writing a multi-pack-index has a few extra
conditions that could lead to failure, but these are currently
short-ciruiting with 'return -1' instead of setting the method's
'result' variable and going to the cleanup tag.

Replace these returns with gotos to avoid memory issues when exiting
early due to error conditions.

Unfortunately, these error conditions are difficult to reproduce with
test cases, which is perhaps one reason why the memory loss was not
caught by existing test cases in memory tracking modes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 0f1d5653ab..cb0211289d 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1327,13 +1327,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
 			error(_("unable to create temporary MIDX layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
 			error(_("unable to adjust shared permissions for '%s'"),
 			      get_tempfile_path(incr));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
@@ -1433,18 +1435,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 
 		if (!chainf) {
 			error_errno(_("unable to open multi-pack-index chain file"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
-		if (link_midx_to_chain(ctx.base_midx) < 0)
-			return -1;
+		if (link_midx_to_chain(ctx.base_midx) < 0) {
+			result = -1;
+			goto cleanup;
+		}
 
 		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
 					    object_dir, midx_hash, MIDX_EXT_MIDX);
 
 		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
 			error_errno(_("unable to rename new multi-pack-index layer"));
-			return -1;
+			result = -1;
+			goto cleanup;
 		}
 
 		strbuf_release(&final_midx_name);
-- 
gitgitgadget


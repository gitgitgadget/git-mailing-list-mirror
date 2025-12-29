Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3525DD1E
	for <git@vger.kernel.org>; Mon, 29 Dec 2025 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034667; cv=none; b=NNUivUcXupdi7FyKb4/42iIacQ0hi+bzbPFQvVvD5k+yGhvcOmUgxpWLggaOZeDT4Tzkf8afeAEPecN5FenPTIE4J6t81nYufqOcAs9bJ5eP0Icn1xy0dmO6qgUe1TAfOD4iZVCjyXJ4mM9D1RW88WzeA5nv6t54SQ0psEJTBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034667; c=relaxed/simple;
	bh=Tr/O/s+frksTGzUzY7e2MFJo+mnej3ITnZMrfrdZhjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6V7P0F9+u9r6rfn0dnkdAs/JgImiSNAYs5nGmDOaPKIyM3YfQOjGlrZqXkKfHnL1BkJRXpBiBbF01yZnBTxNy8TL5FobSfAMujO0lo+YIf+/D3ybpsKhAGbJMhJ8d9fH1V/DXsa5cJl//rX2oIVe5mxBJ8ZavWh8MWfwSqvO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPTox/WS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPTox/WS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso10901646b3a.2
        for <git@vger.kernel.org>; Mon, 29 Dec 2025 10:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767034665; x=1767639465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNtPn5bvcQti8fHdxgUuVvZj9UgDqbvM2U6MFJ8ChOg=;
        b=kPTox/WSkDUGmO+dLULxDq5duUUixRW9BvOL4o3o1OGJcPPqxQRag23kGQB6jRQy4L
         cStjNO5L0hHdOFN6XRN9PM+oU2q53HS9wwXkiw/68P+3oDfLJYY/I8keliitmlZmhOfz
         c07BoDSoqiN+RGhsSY0xl1U3i/JNxf3yjM9pOTbDbiaOwI/pPMAbQ/wNBHtenMclRPPd
         ODX+gjRHK2kxf2qUaec/CF38qk20a+kkt+yTPyzT7Z/alCPcimYdwm/t94rTkcL6gpWS
         zMhVZVY9V868tKB8Gl2mY6bhXt8Ye8+D8g/EMEwfApTHXE7/D4X5JA+hipk00OvtmiEu
         o2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767034665; x=1767639465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNtPn5bvcQti8fHdxgUuVvZj9UgDqbvM2U6MFJ8ChOg=;
        b=b5PwSxgJ3yjn2FjdrbVpRjhu0mzdVHSbm/d2rV4E0DowPsmGHYlLbXa1QhjoZcpG0h
         LW72UXQ4Mcfa9SZP0TXZ9IMIRszFbqtfEilVsUSJQ3P+Jgpx67MVEftYRcr8P3NSX/Ls
         A4cQ8tta7ZEa+fCRHV3nymWYXQ3naV/7JyJptIuLPcjt9TulQ+sOE8UKx1ucVoAp9m+L
         3Ihphq/wfT2CP1H3TrFDUEbs7gtNYnLew3pmLJlSO8cTXZYAYZTJeL3NrVVf4GptkRs5
         dRz9Sj657MGXSEv8B2kq+XP6bbqgx10EI4lLOc7NzIFw8t1EpcYyv5K6880D5JJfMMy9
         z48w==
X-Gm-Message-State: AOJu0YwiJ9ULSah+Z9VLQSYfHRaQtjM/ADzoTHVA7xd3maGxCvx0Czoe
	/hE4dAaO1Snac2vbIGxkVrpqr1gbIDiE45ChTj9riLZHEk77wwz0laeJWidShg==
X-Gm-Gg: AY/fxX5sDNK+IBUKvq0qFC9Py502Z2vzwWzpv2helzpSAupceqXv8DbY/eYIZ0rloMd
	c0mt1hIMzmtFzKx7JXFjZj0ypj3CkIfzbcfaIkmVueujsU3TvdSwH3P+RkAQoB+rXzyNLOtLNVm
	wFhI46tJhnSJBER9Klc5SabcZOF4Cxhlup9dGQL/D/6bcLF2O2jnvsxj7F931qWr0IlMYIwF5Wz
	k4LANuixkToJvWt0bORmC4/x4zyA04P2x7SxQolFoIDeSTLIImxzsWOl9wbHIUMQrbxBxF62Lia
	8ebqXXFrDAymvUBdZNpVFVvGOwbNJ7Ypx5kGWLM5KaMEM04h07J5aZZxUzbHpU2cs8PRfCDVF+W
	KAg7v5UcKKkL1vsib/PU1O63TQHoBNMDPESZ0TDGkgqyov+EU76rAx4nKFQt1mR1tMnXHkd54gX
	9GT7CZ9VxWLQKBcN5FbxwtdLYz4KyVIfcXdD9F
X-Google-Smtp-Source: AGHT+IF0U2pScRYOCJ4igJP86Ww+hmA7iL654JfVKZ4sEoYAmgTtVUdlZNy4Q/OpH5KeI/iLb/O5Aw==
X-Received: by 2002:a05:6a20:3d85:b0:366:14af:9bbc with SMTP id adf61e73a8af0-376ab2e5039mr33460075637.70.1767034664832;
        Mon, 29 Dec 2025 10:57:44 -0800 (PST)
Received: from d ([106.194.172.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c62637bsm26415788a12.30.2025.12.29.10.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:57:44 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH] [GSoC] t5403: use test_path_is_file instead of test -f
Date: Mon, 29 Dec 2025 18:57:37 +0000
Message-ID: <20251229185737.2328-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 'test -f' with the test_path_is_file in
t5403-post-checkout-hook.sh. This helper provides better error
messages when tests fail, making it easier to debug issues.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 978f240cda..1462e3365b 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -109,7 +109,7 @@ test_expect_success 'post-checkout hook is triggered by clone' '
 	echo "$@" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
-	test -f clone3/.git/post-checkout.args
+	test_path_is_file clone3/.git/post-checkout.args
 '
 
 test_done
-- 
2.52.0.230.gd8af7cadaa


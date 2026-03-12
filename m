Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7D3876B5
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336795; cv=none; b=fCxXmY106y7MLxw82laVuuq7okxGgsf9Lc2uOCkGqPSeZ00WCFPqngt7/nFkYE9tbTmSj060ekkZmtjuFwypH2GL34sm0zEln85pRQvPna7EA9isyWPQgQ+ndZg4oN1zLzH39FXmrLPNMfDhGtWE/5eVAICQEeu6Qgfpcm+7ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336795; c=relaxed/simple;
	bh=D7NY6eqWZNZaMIXi8JNKI4JPJa5NFtnxAP4VnbsikWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmV1ocAnQtTAUihoVqFsxBAEGPaEG75UcIV2f3yF5U2gF3KZW7J7L0bYYpbzQNgFQj7YAiJ/yDVQ4OSemhhksKyppldjsZwdWaJhB9YgGIj+ojRdZ86pcXwKsGtUomCvAkpPVJpaqy9B1uKa/U6UDzM7MaLmpx5PM0w6BUrQLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah4KrJCA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah4KrJCA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483487335c2so11478015e9.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 10:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773336792; x=1773941592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+L9nbsPs/oeUX2xL0FjEXPKMjXBS/GBi/caAFXrA+k=;
        b=ah4KrJCAl7FRtuglArJxQqk9a/OsnRNGh7i3l3fdFzNQbu3Hop2vFwQktJ1a+nJKcR
         CAxiRzth3C+QeY+nM60BlEjzV35jOoqXCdSx8bfXR5q+eWpk29eSLaYTngEMn65M0SPo
         xWNVUpDcfG/ALCXQOG1FFkSsYM2bGA/rJWCf5DV7iOCyAErA6bK68AfchdJlDcm+onyH
         GgZqf9vs25+chvZEY+IAlmJNhtAHBLinPynXX6EVdF1Z0viDkzDOlvWg25f89QPz/wRO
         pvfkH8DfIPWD/DIwYEHJKh8rMzeb7D9jG3qjDwE6Xq5H9DfE6uiH4Syc3VNJ6jSva1gE
         5J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336792; x=1773941592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+L9nbsPs/oeUX2xL0FjEXPKMjXBS/GBi/caAFXrA+k=;
        b=IlElEJJYJEQMXWPoQ1rEPk7uSFrj1C1KxB7/xlynBspoE46uKwAv9pgiVEPWyRY/4M
         Tce0kWR+JrhaM4I1xlskCM+POEIg/9sCsl2Er9+Y/8iedcTRq8UvoiWP9JfyPI6AUDPO
         TxH8Z8+rtZtBq6aMMUlIL2ZF99T5iumIfr5vOoYb9W478fL2SfMT2/7Mfu2ADxdj/GaF
         dL2IllKondQVoJm8NkFExmoq8Qj+D01hLo8wi/qyq20PACL8SDaDWQIrxtFpkKAVSF4R
         ReNwjbohRW6CDiOeHKC29DZF4pLoCVORzHrNGK/DyprZf7aVaEgkd3E9cZQuW8/I6R17
         SZ4w==
X-Gm-Message-State: AOJu0Yxi/tGnB7UO892vAJWb5sp2X94lVCHmbrDW3aw94ocfjqt3AePQ
	LD0LCjVBcxDXs8k3GmGHL9v6328rb7gFFFFVgxsK4Vbfg98dwD3f+UNEeFjXXyQylTI=
X-Gm-Gg: ATEYQzzuObvTbaw7zEST3ZFwSWIU7p5PONShrNp7RfQFpxy9Zv640PvaEgZOFZXSbzW
	a7WOcurnS8NgFCxBWThZSnxz8/lkOh5MFh30HzDoWzADkL/rWDloK3gQhjC4EMbfUoX9k31CfRJ
	dwTsNluUJFwy97UNRd/7fLxqf20gLNsramdv3/VU6qsQ5SGnlp/UVRQYjihB3bhkoI/kfAipwaM
	BujJKGuFPRX+9RiLMcFkppB0WRcLj3+4FKlW6nOvYKW1kno3t9ObJbQ/aTrk/R3/8AlWGRWqyVp
	hD3g8IVsR6RpmUhJ7cXfxLXVdq25pNoxYwZTNaKP3u8vm8kfeAuzk1L9tIEqIYTkrmIvkfPhoP2
	Qr6gonzP55ySsIsQbDpIY3e7h09VoDTO4SzDUi2EqyyrYmAWTQIO6f9fr1cRxnrS9hhn4UZpqSj
	gpwR8Y/vdUAK+z1ZHraacgpplUPx925B/uuLx5XPF/IQT4H8IBlh4kO0QwICflMCqZ01RZFbdKy
	xllPLNbaRSEto9Ut2IcShNzt84agOAg/5s3Gk6C1W4kcpmie6FN25zt4vzq2rRdZFnF+Q==
X-Received: by 2002:a05:600c:3489:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-485566ca8bbmr2701665e9.7.1773336791992;
        Thu, 12 Mar 2026 10:33:11 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273e8sm10979668f8f.33.2026.03.12.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:33:11 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v4] t9200: replace test -f with modern path helper
Date: Thu, 12 Mar 2026 18:33:05 +0100
Message-ID: <20260312173305.15112-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309150935.578465-1-pabloosabaterr@gmail.com>
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old style 'test -f' with helper
'test_path_is_file', which make debugging
a failing test easier by loudly reporting
what expectation was not met.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes from v3:
The first hunk was dropped from this patch, and sent as a separate patch.
https://lore.kernel.org/git/20260311194002.190195-1-pabloosabaterr@gmail.com/

 t/t9200-git-cvsexportcommit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..15a91931a2 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -303,7 +303,7 @@ test_expect_success 're-commit a removed filename which remains in CVS attic' '
 	git commit -m "Added attic_gremlin" &&
 	git cvsexportcommit -w "$CVSWORK" -c HEAD &&
 	(cd "$CVSWORK" && cvs -Q update -d) &&
-	test -f "$CVSWORK/attic_gremlin"
+	test_path_is_file "$CVSWORK/attic_gremlin"
 '
 
 # the state of the CVS sandbox may be indeterminate for ' space'
-- 
2.43.0


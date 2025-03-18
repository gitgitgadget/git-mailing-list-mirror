Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484020F097
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312181; cv=none; b=dy2HAXouN0qH3kfCbZ58KZrVhm8+wJRxRcVAI3jcz8U5DldC5Te6F35KOJ0kT+d1Q8iN8YgbBVQ3enBsn+/SxySPzCMqSD39epHzNgUhdqD/a53c6CaJZFA2400XiREGT66rGObIjnjwXJH246JdLzWGsUoEVc8qXQQ32atMr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312181; c=relaxed/simple;
	bh=95/PDi4qIIdUPvnZDk1UAF1FhsAnXfq0wMubQBKtoRo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UFscRaYgwe1O8NV7e9qHp9/lHOaOq02HZq1Ceuh4wV5KQPuKbXaYda9XkM6fqa3HCLpMtBFYDC6ETYzgFjuyZ26kbGlAsS2aEGfaHpntHOzaBOZmVgu7neZxpqYEtIcpzRHNG8JR64Ay7y1yge1cqfKNPkf7Hl6NR+4nQ6i065s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt4ofkHI; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt4ofkHI"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912baafc58so4999768f8f.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312177; x=1742916977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA1krnQtOvhSYNLE949+1YDZm25pKKjYc1RKvWAaHLA=;
        b=Gt4ofkHIM4Ats/n7NcCJWp9hpJMJXU/D3CF+af8MCUYgFDydU8KV9EEDElT9LyBABG
         5QC08ma7ka5BNxblRNnjTlzye0MFsnI+S07c9T9J9nNcPP1qA8BwwMPImSs5tthbFwwD
         znGp68rYAHkVcqka4kX/wcbd1XhF+VCElIR2oOyMNSsLqTCcKqLZ/MKnteiI0xw5CDMA
         08tv36F6/aNa6lfQGV08L3SKU4t68nuEqQWGFpPX1KB1V3ic6Z15SgSrR0sbdbBy41Vy
         Zc/24J3Rh/SHzGViV27Me9qUQbBMCdb1ScCnIvcBBikvJLwYWlBnuIj5grFHzfdfPdFI
         30tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312177; x=1742916977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA1krnQtOvhSYNLE949+1YDZm25pKKjYc1RKvWAaHLA=;
        b=LejDTou4es7Y/pE8lsVup3GFQp7JF19A7LmGiv1cDTpHwCEVeCdtSzJYAr3j8S3uBm
         240PhmuEzbahE7tqw6mS+plubDOVCaqrykZyj1OocloIUMFRO6qYIjEg6Y4/NRbTOIAk
         YMcrNJ537VvY4LVv3lNkQGYR4WHTVLSyY6oE/rJj+opDv9biocx296CJFh/DdUqcluvQ
         5BRGLXvUEZliCddh83wwe72lSZBVncI/H3Tn+IfuJfzyPiojeB3wvGemVXflCthJY2AU
         VoPs8CeLoIztmwKO6YhdwRFCbDcXdYNKCYuESA5iO8qF93ybA3auqb7SGmByhiOJ3DVM
         mZVw==
X-Gm-Message-State: AOJu0YwQ3I+MjAtP6ptzWSktxoNmUqqG1aTXsX4jdwzVGukVXworDzOH
	5+BP/ZdjkTMiIjph7qP4gPrAxy06P2My1aIsaTjzfmxZnJXxCnFxIhNlTw==
X-Gm-Gg: ASbGncsFiNsyhno2n6Fc1yULqL1CbW2/JDUnGNYzZL6GQhEw0P86xNdgBNYqhMOOSwC
	/3Org+DjmIKQr4GTE9RAlb1R/yuD70OVUznslOkv194sJjVnskiPCnhhXeTL1fuWlNFzyPTBQyJ
	YSLqjg9uskwUWtfpwMvMKIA/xdRBUqA1jZpJ9EXGYEg0dTl5/ssSMPgXmR9zm1gBjGNrrwDser0
	A+T7St53WgspJoV+IJBP/X9vKF53mNzQN0HcPye1p9IJ0fU3jNRQhbggVqfTTusb1CXv6z1rwEW
	LPTWO8ayjPpAvZll0QaUUshc769Cjc6kxrtU0F3aovEta4YJl7+1OtNk
X-Google-Smtp-Source: AGHT+IEJ6vFq10ZLI49a1FNRB0qdvr6wnlK/mNa+h0ukuJpK5GQxvvkRU1uO4Rz5DQoPk7FXTkDkwg==
X-Received: by 2002:a05:6000:1562:b0:391:4bcb:828f with SMTP id ffacd0b85a97d-3971d6171f1mr16837474f8f.14.1742312176835;
        Tue, 18 Mar 2025 08:36:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebaf8sm18882507f8f.95.2025.03.18.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:16 -0700 (PDT)
Message-Id: <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
	<pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 15:36:13 +0000
Subject: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with tags
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

The change to the bundle-uri unbundling refspec now includes tags, so this
adds a simple test to make sure that tags in a bundle are properly added to
the cloned repository and will be included in ref negotiation with the
subsequent fetch.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 t/t5558-clone-bundle-uri.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 33a7009e9a2..b1276ba295c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -107,6 +107,37 @@ test_expect_success 'clone with file:// bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create bundle with tags' '
+	git init clone-from-tags &&
+	(
+		cd clone-from-tags &&
+		git checkout -b base &&
+		git checkout -b topic &&
+
+		test_commit A &&
+		git tag tag-A &&
+		git checkout -b base &&
+		git branch -d topic &&
+		test_commit B &&
+
+		git bundle create ALL.bundle --all &&
+		git bundle verify ALL.bundle
+	)
+'
+
+test_expect_success 'clone with tags bundle' '
+	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
+		clone-from-tags clone-tags-path &&
+	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/tags/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/tags/A
+	refs/bundles/tags/B
+	refs/bundles/tags/tag-A
+	EOF
+	test_cmp expect actual
+'
+
 # To get interesting tests for bundle lists, we need to construct a
 # somewhat-interesting commit history.
 #
-- 
gitgitgadget

Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087351DDC26
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221855; cv=none; b=UJ0UfBLp0t9eL8tV4/T7u/zIiTmCPnnNwrmRmMTJkU9z0DKZzFlJX8ccMZ9EKBDL1299Rhq71BLjteTN7E4mLgjDw7ywd+PCHVY38Ijej6mPQ2Otvp4Db3WBXiaCrq/gri7b4LfN5n/k0x4NTIUuM+qZcg3Zptl+wNRX+rL2RP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221855; c=relaxed/simple;
	bh=GzQu76b2LgJX07xw51Zu0B7QVJm95jf7WslnbzvR4bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L05RUZexOFYYarArsPTAhQg8CydnhBXV2fl3F981FrKuGz+e8aJxvYFBfVOcz0MTCPIUQmrv/kN6Gn6jCKXGBBNYN3tLf6jKcyfTzJezw3Va6NWm4WI0ATg1NFeKR30wUBT8unSx7fdlrdgZCDRGPXyBW/IO7iO248Th5tRjtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj9+uG1F; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj9+uG1F"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29654932226so636628fac.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221852; x=1732826652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX4JkPWNISux9YEEGE7qMGbWBY0jlVYKJUQpCnx71ZM=;
        b=Yj9+uG1FAYzSRWd0hWubgqr7P9XgM/9vwgZLzwA89ft2WssQyN/fXmsxYVxteYBJ1d
         SQXFrk3xZ95XYPXSp0dcpuMW4zvL14OgDmfIHynunS3bIqYVGHNE5pGBH4PRe1WbhuRN
         m1MZtVcheFXHkk60nyEzeoM38ABjS9edDrqOgutEhjT1emNNdfvdZtWvzqLHS+Y58xQT
         yg2FlvAMYbSH+N6X8Y+p7cqkSbkmGN0x+QqFHk0LBjwrHoqsjUiWeG9R4nBba6KHnqPA
         bE3sHtloSTw7orlV+VMCuoCplGOKcRECn8bE7hLLp5AXLHLQR+WWyOhjXwPs6yHRaefz
         jHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221852; x=1732826652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX4JkPWNISux9YEEGE7qMGbWBY0jlVYKJUQpCnx71ZM=;
        b=BC/m7kASAE0koZHOaDwLmtQcwigubNEwKXfNEufEZIX86mwVbzqhU2NfwWpmOmn7/u
         ERrtG2uuzOqZrhVtXiwrU3p0hbLtSmWHkYG4FQvK169b+bTPSd4fM/ubOg8Z1txmH0x/
         mXnF4LJ8ixkjGakCffqUG5/HiQr9WNd6wuyO1/dDBzQZbgDtXQIKBgyw45As1IabckTl
         cjdk450rV8k9ex16Gr7GMHCrk1SdzqylVEca0hn3eZJCyuPjpM6j21fyhi6Y8IMA8G/0
         tTSKaKlHlMms/oyxm8EGvbhWkHOCQCuyVYMScdOnEjPy88pYt4Y3uVqTUJBaT4mVDRnB
         zLew==
X-Gm-Message-State: AOJu0YwzfPI0vAVrHSIqsHeay+xwYCQzOfc/iSAJIElAJxZ+SCZR0LSd
	n65NVtTkVcoXiNmn4Bf1ZJf71vH+F+rEhecNgUt0RgrWJzJrnzKkbyrOZw==
X-Gm-Gg: ASbGnctIBittetZ4al4Cxe/rPshp+h5UmkfUHyyPz8QKRAGj7MQ70w1QwPS5muwQb2s
	WIlhqedWEm1IE9B7iBLWJ+iJZemfzw2GdF6f61mPIs+9t6LR8tiAIOxbsr8Kt/JHldAbORLjGMH
	osvxGYMyNF78Cq7o76DuHfcinESGG7INOGCWvDjcgIPpaPmihuLjnx+tfeZ4kuSBWt8BPQDv+nK
	ppYvsV/XJ9V6py/yTQnhVxTVZEWyQWQ2c9vDdPf3ZSL2uroHUGaNIujkQ==
X-Google-Smtp-Source: AGHT+IFfe5lK/tlomVdpyT7PJ9rGtgKkmMr85Y7QRB+x4jkBYdgP4pz5rDmflpzv72CBRx5TuZuZpQ==
X-Received: by 2002:a05:6870:3d85:b0:277:ca34:27e9 with SMTP id 586e51a60fabf-2971e329afcmr557282fac.6.1732221852555;
        Thu, 21 Nov 2024 12:44:12 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:44:11 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 5/5] transport: propagate fsck configuration during bundle fetch
Date: Thu, 21 Nov 2024 14:41:19 -0600
Message-ID: <20241121204119.1440773-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching directly from a bundle, fsck message severity
configuration is not propagated to the underlying git-index-pack(1). It
is only capable of enabling or disabling fsck checks entirely. This does
not align with the fsck behavior for fetches through git-fetch-pack(1).

Use the message configuration from fetch-pack and wire it through to
`unbundle()` to enable the same fsck configuration as done through
fetch-pack.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t5607-clone-bundle.sh | 7 +++++++
 transport.c             | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 7ceaa8194d..c69aa88eae 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -171,6 +171,13 @@ test_expect_success 'clone bundle with different fsckObjects configurations' '
 
 	test_must_fail git -c transfer.fsckObjects=true \
 		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=ignore \
+		clone bundle-fsck/bad.bundle bundle-fsck-ignore &&
+
+	test_must_fail git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=error \
+		clone bundle-fsck/bad.bundle bundle-fsck-error 2>err &&
 	test_grep "missingEmail" err
 '
 
diff --git a/transport.c b/transport.c
index 7e0ec4adc9..a9e03c3964 100644
--- a/transport.c
+++ b/transport.c
@@ -178,6 +178,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 {
 	struct verify_bundle_opts opts = { .flags = fetch_pack_fsck_objects() ?
 							    VERIFY_BUNDLE_FSCK : 0 };
+	struct fetch_pack_options fetch_pack_options = FETCH_PACK_OPTIONS_INIT;
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
 	int ret;
@@ -188,11 +189,15 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
 
+	git_config(fetch_pack_config_cb, &fetch_pack_options);
+	opts.fsck_msg_types = fetch_pack_options.fsck_msg_types.buf;
+
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
+	strbuf_release(&fetch_pack_options.fsck_msg_types);
 	return ret;
 }
 
-- 
2.47.0


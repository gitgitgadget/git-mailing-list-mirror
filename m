Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959483EF0B4
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073808; cv=none; b=kYgxXzXoVyZ1ARK4b1jdbnX6SxRfYmSZiVK75/xOd/UxW+Ec2WOxm1DHPxBdcOv+/ElP43EHNFJGTDrvKMCqpp7d/TAugnb+ZTeeYdWgNrSeISWvfj33hfQnDLFg+ealzpGzDnVUQxVVmfu8tmjwP4kDONr17s91rdEs8NfgmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073808; c=relaxed/simple;
	bh=z4JoDK4xxSZhdkIiHJASENVYqSIqxanwmTX99SG1gjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQw9hclZZrt69HJyjNOsVd0htCfY+3PMM/eqU5xOpoenIBcBwokxgohNdTU4LkoH9p2xYxcxrsF2D2dYDRph8FNUbZoi/MbtIkEnpvsrB79y971HIze5MJi17E7rUzS5gRt6hNXLzXgW2vwYtc5jv69DwfZle6ETazZVVJ5O6OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTi5pXKb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTi5pXKb"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439c9eb5d36so4898329f8f.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773073806; x=1773678606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP9YU5nD8eszgw9rGw+oyL2sjt9csDHGBEj2kL262Ko=;
        b=OTi5pXKbrOeETcxDMgGiHaWl18cdAaueTkPeE/nzqUpv8pGbKYpkFpMd/brxxRZUSV
         MHEton05KKNbX02CeY44QnVlsd6lEvQKuNrzoVMj6AfoSajHbfudKjDRk9jLbG+mrm5/
         b/98MhGwGl/tEDwHuytGhVzrTeapgpOdr8go3cWhV/ifHHV/lsgLVCo3R6Wg+ZOQ0qTb
         PovOFUR7LuCwIVAlHqzyIARE4CnmGxKMW4segCBVshTKPa07e5xmAXM23x7PG4fDqmO3
         WfnWUyeKwP5pepOzJ6my/hG9PVeY5GkNHI8d5PtsP1juAkh635lwRBOKn1K9zmLKAbK4
         h7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073806; x=1773678606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KP9YU5nD8eszgw9rGw+oyL2sjt9csDHGBEj2kL262Ko=;
        b=Y3jUD+EMu5/fYnL8OqVpxg75AAeiGZySQ5K9j5acpk5cFWyMqzSJ1hLXk297HOvuaR
         eS5cnccUE1SfyrzuHTB6VwgOwUGjzAaNZ0+IvoU6bg5yBNBB/bBeq/SZkBt6enBndTqJ
         pY3gaDtyppKTK5cMEF+jy8gPDbZ/qM9qUJiDFZdm8dprI0ILvg5oXKuxiAqEeGOD/QRC
         Hze8OUrWhz5FglQofO4RGVjDavG5SqpE8LI8fuJw8CE0QGi5VkqtbG8dgZvi4bbsaxbr
         Qc35PvwfPcue4+2IKMTr1UtHKoWXqCkS49+Owo14epNlCw/nyifit1pAZF1jPgT6VmHa
         CImQ==
X-Gm-Message-State: AOJu0Yw+Up59f0KczkZ5KyVHxdomeq0G/86QUBHzIzr+roTuDqo0bCOY
	bKqNYXTcVkxzfPGmJOOm25agiqdSHBcVErNZJcUocD+gkzNPqoKv0RUGZgUXrzjoA0A=
X-Gm-Gg: ATEYQzzEmR25FxY3bRLrrHGz14XHFyD+ArLa/uj0HGG9P17nFSy8T6mov4dDWQGRKm6
	L2pXc2qr1czISmNiq7jAUw+pAek4UhgkrhjsAo5DvxRO069r8JmAS3z2IE7tvzQK4asJSlv5xag
	u7WOud7wCk9F+J9v7URW+rJMKsC45RrQPpsqiBPFlidKR1Fhnhu7CxsHlJnxH/LlcWNcVU93E0M
	GMRcAmY8qkrgPWGX3FhPmOxjnijCOKnQAM+eCQHTeM5+EXF9WqCrD8MQVawVyT7E7kLJv05Xw3s
	OD92pl1IVHvn3PV5E+bAy/WrV1PQ0k57gG3UPZxNkzdOjPvn9DIYXwKlX0KrG7ayCE4n9SnsY8Q
	EhjT3g5I2cQfeNClSjuyLveTpfUGz/kd65TTeRISOIjM/e9su55sF7NPJaLduQ/ijdnm36QtrpW
	Xdda8FrYjw8Uf5EU/kGRYh4tYsYzm5SLa/xItoq5CoUey2GoBntlfkZ7UUeqaG2yDXPsxXEC13Q
	3yEUCt7c6S89qD0aief9KqvY9LUYQv0e9ZICVod2YQXQ/aTcep1ftSJ+Mg=
X-Received: by 2002:a05:600c:a086:b0:483:75f1:54f with SMTP id 5b1f17b1804b1-48526982991mr191448795e9.31.1773073805390;
        Mon, 09 Mar 2026 09:30:05 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8f610sm4449375e9.7.2026.03.09.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:30:05 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH v2] t9200: replace test -f/-d with modern path helpers
Date: Mon,  9 Mar 2026 17:28:32 +0100
Message-ID: <20260309162832.605969-1-pabloosabaterr@gmail.com>
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

Replace old style 'test -f' and 'test -d' with modern helpers
'test_path_is_file' and 'test_path_is_dir' respectively.

The instances were found with:

	git grep "test -[efd]" t/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 t/t9200-git-cvsexportcommit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index a44eabf0d8..4507e8e6db 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -31,7 +31,7 @@ export CVSROOT CVSWORK GIT_DIR
 rm -rf "$CVSROOT" "$CVSWORK"
 
 cvs init &&
-test -d "$CVSROOT" &&
+test_path_is_dir "$CVSROOT" &&
 cvs -Q co -d "$CVSWORK" . &&
 echo >empty &&
 git add empty &&
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


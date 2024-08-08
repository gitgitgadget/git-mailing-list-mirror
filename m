Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A511922C9
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134847; cv=none; b=se6lFA3Gbl+pBrAp6ZX+MlQQARQirfKv1OQBZPybGjN84tPzSVFbBn4syOtXXHyhuF93A8PmlGBqfVzZiI5HetgHK0ASphrShYBw7L8I2k8LvPeKxYTOTbNpdW3eDf1znnk2DUNhNii1U+Hw3qtJfZw1i88krdffzOicpe0IpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134847; c=relaxed/simple;
	bh=82LBgI+r1uoEbXpHhpXqwtsjlfx4Tj7PQr2ZiAaFQLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5VNFyWAKrs+tA5BC16l4dvn3JrJOw2SxjxiOh/SR5ewBw4NT2Sp8IPnFLH1mFK2rHIv4x+q+fQxq7apNtk4CF1dTAzctHOYuvynn82++QNWO1h+FQLlbpBCHkjPcTllhqh2Ps9yA8HEp2hfoo+q82SkKXE28+V8DvDMwCQ4kpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3t53JXP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3t53JXP"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367940c57ddso612806f8f.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134844; x=1723739644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMSNiupLF5UrDzBeRLBNNFi69PIu7pbmJ9KBAk2lI2c=;
        b=A3t53JXPWC6xlAVGocI3xFH8xLAiMzZxyIeT5gVgDg9Qky9MsNENbyANhNBPh0G1tw
         IwvBC9lm38JUeGaVZSZK6AfnNzH+jRjhhuBqm4B04R6wWuc/Pft1sslgHNb0ShjsjSL7
         yIwKHZZ0/jYl/bnLHtpl6UxBMJy05uYs7BZAefyuDQgTtle6Oe0NRsvOGWR3uT8J4YbX
         S7TAtI8JWB+geywSx7jVTowvpGaRaBvTa9KFNAd5ymD7Nhru5fL9eaNjK99xHokZhgyr
         zTiqVVUi9q+k19mbOZRIXP4hlgQ4T0+e3xnaQUy9Tqh49telfNvwQw8EaCKwGwZmpN45
         6P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134844; x=1723739644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMSNiupLF5UrDzBeRLBNNFi69PIu7pbmJ9KBAk2lI2c=;
        b=w8rQUNkKkMgrCVqlThNQu2iZGGfTSSqdRvc8mrx5sf9USKKoueITyBBFQ93Z5hwTy3
         ICC8ORGKhL3l3X+Ovs8TkaZtUC7Jxm6Nnh7z71fTeBAHM2kOU/QmL0VXnDhxF+kvwbTV
         KSGip5zn2arnQ1+Ct3VXfnyjKP0irN0dvcyUAYqWiWHym+OfQs73TbxRZ3kmWWLfe6l5
         zuky7PFKsbIwrdC8kwL2fXICU9bW4rrjzqOvPFnEwcOoQDCCVnoFb8cASImL6GyLXcnx
         AHb1euSLCk1jv07c3R021xOb1hJllEvmwK3azUGuTKJPimyQO5Zf6JiiX8ctkxc2y9eO
         Zzjw==
X-Gm-Message-State: AOJu0YyDRhfWjfJRSU2eqgFOP9G/RKxDOSYf2rDmpr3H7F4j1I/WspBu
	Z5LjTlWxtyYa5JfPVSwSNCERZjKM1pENzfnol4MYa0fl0wf6FLf3o4KhEJFpRfM=
X-Google-Smtp-Source: AGHT+IFGP07ibp4+frePFpl0lpCLGi+pN7ubqUIdMEv/DzQyOgn0eEsqrHqqBdp90n60U/qEvqcMUA==
X-Received: by 2002:a05:6000:184e:b0:368:6ab:ba69 with SMTP id ffacd0b85a97d-36d274ef602mr1934803f8f.28.1723134844085;
        Thu, 08 Aug 2024 09:34:04 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:34:03 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 8/8] t7004: make use of write_script
Date: Thu,  8 Aug 2024 19:32:07 +0300
Message-ID: <20240808163302.17521-9-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808163302.17521-1-abdobngad@gmail.com>
References: <20240808163302.17521-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use write_script which takes care of emitting the `#!/bin/sh` line
and the `chmod +x`.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 046a5bd9bc..b1316e62f4 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -974,13 +974,11 @@ test_expect_success GPG 'sign with an unknown id (2)' '
 '
 
 test_expect_success GPG '-u implies signed tag' '
-	cat >fakeeditor <<-\EOF &&
-	#!/bin/sh
+	write_script fakeeditor <<-\EOF &&
 	test -n "$1" && exec >"$1"
 	echo A signed tag message
 	echo from a fake editor.
 	EOF
-	chmod +x fakeeditor &&
 
 	get_tag_header implied-sign $commit commit $time >expect &&
 	./fakeeditor >>expect &&
@@ -1415,11 +1413,9 @@ test_expect_success GPG,RFC1991 'creating a signed tag with rfc1991' '
 '
 
 test_expect_success GPG,RFC1991 'reediting a signed tag body omits signature' '
-	cat >fakeeditor <<-\EOF &&
-	#!/bin/sh
+	write_script fakeeditor <<-\EOF &&
 	cp "$1" actual
 	EOF
-	chmod +x fakeeditor &&
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
-- 
2.43.0


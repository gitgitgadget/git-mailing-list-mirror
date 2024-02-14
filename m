Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205F5645D
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920737; cv=none; b=M8t++YIM1rQt5qoGInoIGJNDN2I9ex0EaY2Cxf/thBLTFoQ2E7eLxvRftJpzImB0ZYSmps25KojsaA99StP/BW2XjxHO1YrB4PPXCy90tITtuhjuX+Ap4YB1ru+GZiJynX76VeBcXjaqYydB/XiWTZ4PVKNzomZvMm3loVLAR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920737; c=relaxed/simple;
	bh=dhCE+huWXteC6mmhP+7RS+wH/sY+meWZqTNaOBwgfmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLqki1u4Z/YL8obBxLu00UxzA+H2jnhAF3/Gs9QGnAaQPXHj5JRjjGLUx1/27auFSHlv2e77LnWhuJ4G09yikCUTYZTpZQF/M3Ztjlcb4Gb2+XLv0+lbvfUJ/Q7ZzKm+b7v3k1SiIVYfPxRz97Px2xKiWKOzg9ptuI2q9kgYKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHWIksq+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHWIksq+"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so7448221fa.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920733; x=1708525533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5Mbj7tfXSKjkwIrHld85eScy2JdGwyHQrBCiDIdT+E=;
        b=YHWIksq+WnK6Tk20dSGcc+A6rv/e2AOVgp3oeuwrSu4YZWFfGQB1zQdpN1lxP8HLF1
         i9fcXnemg7Bm4k7vdZSuyxsqemo1mx/LaoNa6kgS/X23TTLSZLhOMJr7jM7vRO4lq2PO
         0iuGFQiCZuONZooMYrlEKzmk+fEgYyN7Z03r0W8veDlKa/HPdNMAou9KmZpfo/AVOLyD
         r7s+EV14JXAPkgJ0jPOPKHMtTDznyyl+CHeJiopt37eevx7rBUFXnjh6OCKZ8QUfTZN4
         bbKJzOeB8xSDqUs/DGdtaKnUvmZ9zOkhdjkUOX37/svZpnHuHLQO7eCkSc+9C6aMVnoM
         lAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920733; x=1708525533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5Mbj7tfXSKjkwIrHld85eScy2JdGwyHQrBCiDIdT+E=;
        b=dK6U17St7Hld35OA87B/TKlQu5OG8T8MrfphTCRzB4R77kR7ulPumaG1BUinMchXp+
         /LgT9u4JBLnzXj0Eb9IAwSfZDAJOQ/SH//WBixlUW8oMbiZh0P+M8ueQ3D4g8XhenbuI
         HM8kgHfIJ9K3kBtStGRtf6zwHtOXJWWuEcf7xaAhFYDkcQCNH7Gf0gvoX2rVKJb2MoGF
         qHGEsuBG9Z7Pex3IcAVEYCXvkBQzdtpNcMzNlQ3Cvg7bvK8pwQFWdiiphXH6zvKEcB4r
         9o0FzM0eqKTgDo0lJwfcOvjDgwWQLa6lrWvHyAXd0aS5kqMT0NH5qxhmIFn3NtpeB/gX
         +pNQ==
X-Gm-Message-State: AOJu0YzNPEHy6UTmWd25C3mF5KZpQFS2j4KwXr53eFlt6euDMJL6egSB
	WE1XzupuMwOKd0j3/Sq5ZOaxqf7IVqEVi0Qd3nfb/RDLHs1gw6vXl+V3OgXu
X-Google-Smtp-Source: AGHT+IG4R/5xLYXmCbkp1L1oZLz3uEzqmQ+S3mySB+sCEUs1a8yC298d7pzvXsHi5VcxGOGR+OeXdQ==
X-Received: by 2002:a2e:9657:0:b0:2cf:481b:9cc5 with SMTP id z23-20020a2e9657000000b002cf481b9cc5mr2317505ljh.19.1707920732493;
        Wed, 14 Feb 2024 06:25:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVV1uugc5S6zfP8gS746CXvf5M9mpmpP083uqUvRX9hulDRiOkdPQJ1udVm5N+zXZVicwumu2Id77wrLIXgo/9795WsXVYQ4iWaiSDIV/3L9s55k7gxy05zGFWZo6nvhJ6nxLTlu038wmxlLvGRWHWIgTud4PoAOTsh1A==
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:32 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/5] t9210: do not rely on lazy fetching to fail
Date: Wed, 14 Feb 2024 15:25:09 +0100
Message-ID: <20240214142513.4002639-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

With "rev-list --missing=print $start", where "$start" is a 40-hex
object name, the object may or may not be lazily fetched from the
promisor.  Make sure it fails by forcing dereference of "$start"
at that point.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9210-scalar.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 4432a30d10..428339e342 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -154,7 +154,14 @@ test_expect_success 'scalar clone' '
 		test_cmp expect actual &&
 
 		test_path_is_missing 1/2 &&
-		test_must_fail git rev-list --missing=print $second &&
+
+		# This relies on the fact that the presence of "--missing"
+		# on the command line forces lazy fetching off before
+		# "$second^{blob}" gets parsed.  Without "^{blob}", a
+		# bare object name "$second" is taken into the queue and
+		# the command may not fail with a fixed "rev-list --missing".
+		test_must_fail git rev-list --missing=print "$second^{blob}" -- &&
+
 		git rev-list $second &&
 		git cat-file blob $second >actual &&
 		echo "second" >expect &&
-- 
2.44.0.rc0.51.gda36843b44


Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08554299AB6
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929350; cv=none; b=e56ICF7gxztL5yVsF3vZdDu2GloWXfiKD4yM/sj6yxzBxRdqBkOrxcSKqRD2vqioXOE/DtYzY0EZA4FQDQoyAgHNCBgOgIrS74D/MuslVEMN5Vi/mXIpsgvIbURLiDTwUyIN7AVjkh2hZDPPMAeZPioO9DaiXrnVvTnZsqCRKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929350; c=relaxed/simple;
	bh=ZXdcm1ZczgDivIw9rrpxsYZ/IU1kDL2V3LF8jZX+2Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMvPLGWDygepG8W0oqXZ7F3CTpsY0+NrnmF1OvyfpHN7RMYQGVUv/kGbLrFqBkIOh/EFEC2Re8DqLFVUUAU44eMFtHAVSC7sfLRVdikoR4TKhe+1WjP0xvCsg+CdP0eX3N4jfpO3djHA82BYVjeHUDSTtxaabxxRkVV4Q/I+2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoIng4o/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoIng4o/"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a363d15c64so4082410f8f.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929347; x=1748534147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5C/NgUIwC8B/7ouBtDEBHnQvllkiASvk/6WHXjQuI4U=;
        b=NoIng4o/SMmE1sL8n+dh9lKTMb1p6MW9EkjlZvAOWLenpdT7MI5y7xYBNg8K6dEyW1
         tK1XHp8kQY5psohwj641+6gVT90dhGhOwIv2nAW6NZ9BRKr0K3We7CtFqHGV9Svo4wO7
         mcPoLmm5nyYxbzVC5LFMWkIt5ZiOr1aOGJBDdEgahbjA6XAPYQtXFOuf9nIuN6XSu8I2
         EL93QhOG2yG16VvhRHbjEbthGyqoqT2lp8NGbujSc92Jd/69SCkkogu8E5NDCFV47eWd
         tKjGX/re/ux0wx5A9ReAJ93GE9bWI638m/1n/feMDOUYZkZP+flw2kmdSdvHrTgdiPdk
         Yy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929347; x=1748534147;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5C/NgUIwC8B/7ouBtDEBHnQvllkiASvk/6WHXjQuI4U=;
        b=lDRsbQ86krk99KDX0lXvCxCIUA1B4bJuNCjTInONB0Iupo6+rUajZw/wCN0kfANhRa
         pu/Wqn+q9RWuRQKPNWILRfBtbK2o+TfmOc9mLgtc6Odz4ZUK7l+Fkw+0fXIJeips62q6
         85DiNNVqysqbE96jsZr9LeeBkoAw5ShAz1qbRoaYepmagTJZBDaDUTysjTYIDSmoQEX9
         AkKS3IScpkPM3enj8/kqpwKo3Z0Pm62VurmDnEbARqoFWIX3TGUdWE6qSLoqajBl9MWP
         o3RN9KR6PlIg1+s3MABSTdactwb2pNnEOL8LieT9o82MNp22Rh62aNzEzwZCUyzfr7BH
         THXA==
X-Gm-Message-State: AOJu0YyxW4/EG909sugUjBH+p8N3Ot3dI5NqR/ViDK202+sbjdnQRsBo
	ZUqwYVca0/zpj0GZMUzhh7o0gdL44F018HPJ5UQurBPu92UMIKHhSxQcxryGwA==
X-Gm-Gg: ASbGnctykwyVwwkEWU+ishTSDPfJJT1SlYxi92K95qJ+pox3QDlTFJp2ZQvXjxgKDoY
	nVObhRUAcWHcDpVxZDNz2LEzS1GAxyySjI/PEgO8oMa+cyMAH9slsX4H5gZ4245f2Vn7Jj84GB8
	oKpQIbihGxaTGd2KyVhDI25/gXAtyHv065BUd8DTtTb+U4CT6YH7k8lzHHWnEoLmOVupk2YrRwn
	S5r28HMm0USMhOJWXwD6HQFqvkJoatx9Yrqk89OveKZg+pybZE2U+MIOA+5Enl0GEU1WSq/oN4e
	WeyCz2naq0Yrx9Y9hKZJErsMeqecbrXFRhOUVShQzAtCviA3sy4GsEwp8myMIexZp3w=
X-Google-Smtp-Source: AGHT+IF2DVoV6QHgDy1m3iCAaYcFcEK/vD73e1Xna6iF7c8efU4U5Ri/f3H3VLSVEdMqim7qvjrIHQ==
X-Received: by 2002:a05:6000:400f:b0:3a0:b587:aac3 with SMTP id ffacd0b85a97d-3a35c821a35mr22893827f8f.19.1747929347197;
        Thu, 22 May 2025 08:55:47 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a369140048sm19253599f8f.57.2025.05.22.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:55:46 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 4/4] midx docs: clarify tie breaking
Date: Thu, 22 May 2025 16:55:23 +0100
Message-ID: <a140181bd575a867801d9c410ed614b1dfc7d377.1747929225.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1747929225.git.phillip.wood@dunelm.org.uk>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk> <cover.1747929225.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Clarify what happens when an object exists in more than one pack, but
not in the preferred pack. "git multi-pack-index repack" relies on ties
for objects that are not in the preferred pack being resolved in favor
of the newest pack that contains a copy of the object. If ties were
resolved in favor of the oldest pack as the current documentation
suggests the multi-pack index would not reference any of the objects in
the pack created by "git multi-pack-index repack".

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-multi-pack-index.adoc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 631d5c7d15c..b6cd0d7f855 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -38,10 +38,13 @@ write::
 +
 --
 	--preferred-pack=<pack>::
-		Optionally specify the tie-breaking pack used when
-		multiple packs contain the same object. `<pack>` must
-		contain at least one object. If not given, ties are
-		broken in favor of the pack with the lowest mtime.
+		When specified, break ties in favor of this pack when
+		there are additional copies of its objects in other
+		packs. Ties for objects not found in the preferred
+		pack are always resolved in favor of the copy in the
+		pack with the highest mtime. If unspecified, the pack
+		with the lowest mtime is used by default. The
+		preferred pack must have at least one object.
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
-- 
2.49.0.897.gfad3eb7d210


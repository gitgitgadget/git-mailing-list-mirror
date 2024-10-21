Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950E1E47C8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504695; cv=none; b=PJYdv3x+4+EDGFpj4sOtIrxLU9e6FOlmEoh+bqPZxY19qpPPvLNmvm1pmtl/6HncLiE9p0gWG8WWC9m1NruuELLUN8HfmXjTKm/sSj39Tx05KONaKDELEez8m0OLIYH0pTNNVGSYDS6ILhiiF5+ZwaaeMsXbVfR5nT5NGPh+/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504695; c=relaxed/simple;
	bh=5bb9Vgl+jYaPxtriVllETwB8YyW+hxEScXilwl7s2RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HF+7ZB7dCWwJrTAKQm3vu3DjBTxMG1ZoZwLp7pHiIq6hgUw9mTeKGmeDCyNHahRv6sCMLF5gIDEGaQeXYHEVUuRGhnPiy9EaXHjhOCKxm0VYMz+5libaaEIIb/sYpp04RO2uuyCo8MNEZmgeBml09fcf048fWetKIR9NSmr2HpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIr9DAFm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIr9DAFm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e1543ab8so7034034e87.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504692; x=1730109492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/jiWHo1D60Uhm7L875Asb1ENurKyQUKinkttkd7R6A=;
        b=CIr9DAFmxBl+H6hpaUx7voXgbMEVjdkDS4vBzAF9X+oe34uSa3q3weyMo6xOsvlQ+B
         J4G72TEGglhz6LfOvLJ3Xl4MjtO/VNVnZedPixIo2JSiOvwRLw7TXjUZINQ7jtZfqZvC
         boqbvaEav7dPBWMTw4S569y1f/Qc3Vz3MIWcPbE0ZimEb1aago+iQSFlZ8cNTQXrTE7J
         M6aroZfY+ab1YEDQgAPTFYXiwXjmv+4WjxFNQc1hql+/ZvGL09i5nfIGlct+ohkbkN3J
         rJtOiBYau0mVebnxEwdMXbyZGl0nwsGaG4geSTV19lrlzRQ96SsS6uRwk/6CPFbi8jxx
         JrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504692; x=1730109492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/jiWHo1D60Uhm7L875Asb1ENurKyQUKinkttkd7R6A=;
        b=A7X+Jzim5LeMSG3440MssvjZwce0OfLcLJO6QgrchsRuKXIqapE2QKZvdCRhTSRGM5
         UBUmO2nNkNyfKIj4vW9f/Iq64FdC3RGWQqr6Wi5AEtAC57fU25RGiKWToJ0S6jEyTh8f
         tFvlZ7wyhlV56wppYqJfJaFp8bFRMCO7e1e/DGklK2lbbIu49FYID4Vs1zSH0L9bDAjV
         XNij3vhCrmPKW3nTi189p02N3/68M9wdZTc7TJYWUK8fzht54n+pLIoEcrWtYCzsh7a7
         UHPuDIlMlL10dvAaMJKxTMXoibZJPVGy3xGGLkee8/3TFHVHBdchFGZws+0XGnM+4jej
         JwPQ==
X-Gm-Message-State: AOJu0YyjSG+PoYiPgQNQb2+55ZyY6FxwmYfNnl2AKdqXKjBZSgxMGVmc
	schFiUdJ6oeTuwnqELwE8URTG0wqcoB8+2zVckLerdHR24rLn/C5URiA/gxf
X-Google-Smtp-Source: AGHT+IFtetdTvbRA5UHXCuAJx6qLFIVlG/9uz7hYMiOXDDbBr7EPfoaFBaqBx+nMClpmv26x361tPQ==
X-Received: by 2002:a05:6512:1091:b0:539:94f5:bf with SMTP id 2adb3069b0e04-53a154eb367mr8409081e87.59.1729504691578;
        Mon, 21 Oct 2024 02:58:11 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 07/20] packfile: use provided repository in `packed_object_info`
Date: Mon, 21 Oct 2024 11:57:50 +0200
Message-ID: <ee47c54eb763fc744667b195f4001cd67524c8c1.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `packed_object_info` receives a repository struct as an
argument. Yet, it still uses the global 'the_repository' variable
within, let's swap it with the provided repository variable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/pack-objects.c | 2 +-
 packfile.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a10eae239e..c2555d4986 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3383,7 +3383,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		struct object_info oi = OBJECT_INFO_INIT;
 
 		oi.typep = &type;
-		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
+		if (packed_object_info(revs->repo, p, ofs, &oi) < 0) {
 			die(_("could not get type of object %s in pack %s"),
 			    oid_to_hex(oid), p->pack_name);
 		} else if (type == OBJ_COMMIT) {
diff --git a/packfile.c b/packfile.c
index ee46898b35..458db59b3a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1604,7 +1604,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 				goto out;
 			}
 		} else
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+			oidclr(oi->delta_base_oid, r->hash_algo);
 	}
 
 	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
-- 
2.47.0


Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043683876D0
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420248; cv=none; b=iaMYwKJVLi54DbytzN+y4StFrEHdGJASIFXpCTk2Ymsv4L1khn/9TVACoV27GnIwMxU43zeDXLUwuAOwgoHRBGdlKd/65fpGUUmUG9jt5zUlE16getkKxhL4RbHqcMLorBzjrbdjxhp0HQ2WCXYxdsU5wMyU0N6IvCt39+TxxUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420248; c=relaxed/simple;
	bh=HR+xqHWRE5rj3BiHiXvI8UKDsR593Ww6pa4KcuuUfxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUvHVcD5+dLTAZ3GTKDicRg/xgEmtMWFBRI2ZJic6Qxn+ZzkDrXWki51kPe1/VqORzsYOMK75lJfpWUG042eixn7GTXspDPT/eiMjKFTd40YCz7Or94nnJVbENBHkdiQD8K3WNUZam1gmHR5WXKDtaACn5zCYSkK5byhZGyK4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oe4UTs29; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oe4UTs29"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso26164735e9.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780420245; x=1781025045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6prv0E/EHPtym5am2Lk9WhdrkVoL7mzT7PNTuQDEpv8=;
        b=oe4UTs29iOFCDurUmptJdzYCrkP9aSPaZzwtxEF8yGN1ml/WG1Ybo6P2CIXQQ9nbNI
         VsS4FdM/zpnNVlOm0A5zRIBMyaVDxO5XoijbsKL/v8ny5KlGiDSGA0UUWlNYSX3X8Smq
         VVqFtJu4ZPsTGZGbyf75DeCCMbdMY/t9GTdMOraKxsXPXnnlcPsNChNe7yu38DA+kwUu
         rDYuRLLVCADn+GyyhhNxljUO7026PptcLX00jwJ7k/xaidc2QYp0aJlL0f9tx826Xgd2
         PArsvEkwYV5ckerA6wZ2joo3uZUOJIMNMzj1BXvvMtmH0qG0qGZMcWzJYsb2oFywHhX7
         U9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420245; x=1781025045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6prv0E/EHPtym5am2Lk9WhdrkVoL7mzT7PNTuQDEpv8=;
        b=bLSpwvdQm/1DJBJHOy+WD1WHzZ0qZ/57dwLcHFL1sBq9ggfe7o1+DxttD9voVw8xZt
         eLADT1FRadLQHjlkq8E6i0IavKPaNYoeB3HKtRLAvrOg94qVEjGHzn50bbHZbb1QJVBC
         W/rXfZ0mFzxccXwz7sMMomNIDM5GfQjoJYY0Xj1/p5gQRsJn4NE6tUcw1tXDicncunRx
         jLWamwEbGZkp0E46ISMkmgFofgkiSV0s+qkxr+SDugIDOW+Sv3TlTz8PPMS5uckgsTs5
         yi70UW3EqFfNyKI9/4bVdH9yB5bkp9PaTO5YFAdXX4gZKKr53hKQd0z5TA5DEROW+Djo
         p1aA==
X-Gm-Message-State: AOJu0YydKWhXpkuiZy20m9QH97btBdNGIbfr53NmiFBBjqoTWYzGhSzA
	OljnI4xt5FGXQmX1vlKvC3gEE16h1WWgBeh123PFuFFRSQaidQPNujvNaYEnoOdW
X-Gm-Gg: Acq92OEx0BNXpMlvfeudZbQg+dvEWn+bxbjp1eXewHOchlwnU4dIS6DPY5BCZ1sXGYB
	0QyAM9bXF7+qyR8DMaHO29JE0WV/W6+hWinDcNJCGN97pjKHLA7jx5qj3c18JLFUkI2ZhP98KEn
	X+BrTOqM2V4rkaVH1hvqEDTBju9HCYPAV6AMWG1wnm/0rupPnGRTWOyO/VKYU5ADBCoBXf+uJ3l
	GEqbMWbFXVM+WOC43F+u3KMj3UekntWrSe1oQDLhZy1bM9YiecvohbjBz0Y8F9XDqFCFAo+Rq6/
	WV2/3DZMEIrbRYpb+0vt/Yl45Mq5TY8ErjmX2oLVcb8ruNcnS8QsmrKUz5ukK4x58o1q4tLurBS
	O2quj1A4gzaZdYEjYfXbZf9pANdOh3SFlRG12TggZd8v/hO4XTf1D3gjUVh3ZPBNW7eNS54RmIA
	Xrec94pFUtNBhOSO4F/hVLvczfSB0oUpTw2oS9oytkdr8Qea4UwDJbrEweWCU3vkJF1ZqU/dw=
X-Received: by 2002:a05:600c:5394:b0:490:548e:b854 with SMTP id 5b1f17b1804b1-490b50a9555mr10500515e9.26.1780420245154;
        Tue, 02 Jun 2026 10:10:45 -0700 (PDT)
Received: from pop-os.localdomain ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e239f4sm122904265e9.7.2026.06.02.10.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:10:44 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 0/8] repo_config_values: migrate more globals variables
Date: Tue,  2 Jun 2026 18:09:13 +0100
Message-ID: <20260602170921.35869-1-belkid98@gmail.com>
X-Mailer: git-send-email 2.53.0.155.g9f36b15afa
In-Reply-To: <20260601154211.82370-1-belkid98@gmail.com>
References: <20260601154211.82370-1-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v4:

- environment: move "precomposed_unicode" into `struct repo_config_values`:
  remove incorrect mention of changing `int` to `bool`



Olamide Caleb Bello (8):
  environment: move "trust_ctime" into `struct repo_config_values`
  environment: move "check_stat" into `struct repo_config_values`
  environment: move `zlib_compression_level` into `struct
    repo_config_values`
  environment: move "pack_compression_level" into `struct
    repo_config_values`
  environment: move "precomposed_unicode" into `struct
    repo_config_values`
  environment: move "core_sparse_checkout_cone" into `struct
    repo_config_values`
  environment: move "sparse_expect_files_outside_of_patterns" into
    `struct repo_config_values`
  environment: move "warn_on_object_refname_ambiguity" into `struct
    repo_config_values`

 builtin/cat-file.c        |  7 ++++---
 builtin/fast-import.c     |  8 +++++---
 builtin/index-pack.c      |  3 ++-
 builtin/mv.c              |  2 +-
 builtin/pack-objects.c    | 24 +++++++++++++----------
 builtin/sparse-checkout.c | 37 +++++++++++++++++++++---------------
 compat/precompose_utf8.c  | 20 +++++++++++++-------
 diff.c                    |  3 ++-
 dir.c                     |  3 ++-
 entry.c                   |  3 ++-
 environment.c             | 40 +++++++++++++++++++++------------------
 environment.h             | 19 ++++++++++---------
 http-push.c               |  3 ++-
 object-file.c             |  6 ++++--
 object-name.c             |  3 ++-
 revision.c                |  7 ++++---
 sparse-index.c            |  4 ++--
 statinfo.c                | 12 +++++++-----
 submodule.c               |  7 ++++---
 upload-pack.c             |  3 ++-
 20 files changed, 126 insertions(+), 88 deletions(-)

-- 
2.53.0.155.g9f36b15afa


Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6012F593
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983576; cv=none; b=sBOVz4kWmNjC7DulmXMb3jr01ZBttZPHxt469tFcUbqRQiJQ9d0jxLUXs9FWxZ03Y9GEd2b+4JA+YoYtRW0UjPe1wQTV6zh27oyiCLCo28mlS9VU9XkMAGN55n0SYKb06cExvHbWDkClihqGTmRgwaebQATJPyJXy0E5L1sS3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983576; c=relaxed/simple;
	bh=DnjbJn5SgHmuTQJljNZYrS5EkVANHvKGjY/CNPBUE9A=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VLSntsG6yupN+90XwrClEsV33M4IJEBGCfztUmS0V+Tax7Q61MB4ZD4BkXUo23BlpVA7GVBC+jblebbDQJLCpwI/rhAbvJgRYESV2Fjml0Sw8Kg3otY4IvkIm/99G6HUBG5gKfO2vWnzihJRLXyZPWt9EozDjBL2aGXAevuXuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz/gsmjm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz/gsmjm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso28225455e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983573; x=1709588373; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi0NPEODrtkk3ddoQg9K0JweYxe+PjhAUviQ4zCBQzw=;
        b=Xz/gsmjmDJPfdgQlBXxpAXXJ/Cr7d5BldFo/rnrxhIgdDAItUFoFDBvEiiD0UKn6C7
         HoFNDCXoU4dWjjrnTgiO9M56DnX6ElLANcfnKSB8mAUMJucmQlKvstfNMKN82lQXjLZG
         tII260VN1XFd0RM2mX091slrCWQ2NMC/etTy4dzikwibBZXIoWsQys6ONZDKw8TRbKsN
         gHZsLQSJI4bcX5KtBYN9c7jtEAHDrfVNpqh8fqmhM1n2+t20J/nYDKlURw/FhCzN857g
         N18mfs0He0dn+hA4FsbutTPnNASMs+V6oMbXZrVVdPvHIlQmszKbt99JriJrJ+i4bkFr
         vGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983573; x=1709588373;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi0NPEODrtkk3ddoQg9K0JweYxe+PjhAUviQ4zCBQzw=;
        b=VETQfPNMu3cyOiHxCX2q9yMptVolZ4GKW2cvtMsYzVzxWAIN9AVw9GGz/i59a2mjV6
         LTiS+mIqwKgfeHd7GKbHSVlWOhpNQEC6YBK8MQB8dPypLE8SNBBj6OwmCFHkbJypqJGf
         9dr/ktAoMHYPTFiOCK95DkSFQnldO00u8nQJn3Yu6lDltx2xxUVxm/f/xbDpyu+sac7f
         +3LNUUdwYq9uR9TukOZgvYJjW/GIFLWqCkd3HPWX/Uygysu6x+88istDKgew2fJs/Nqx
         LJYENxz12i3o51KyH91MJzie3/aDnx3PFgCoLlvueg0MRyzQcK5uc8zDnrfilFrG4Zj2
         FTjw==
X-Gm-Message-State: AOJu0Yx5PJMSs5EYgBZa9EFN0p1+IOVcw5q3glweLTwjC/wmxijSok+m
	zVHgrg7vldiPiIch/HXevj5b0TDLNVUgWNwswoDhJ4RCCCbAenZeE/FRpjY0
X-Google-Smtp-Source: AGHT+IG2HhPO+ZITPlqFRMAzSsDngEHFT4IxW3uryHaY00FJkkBwKFN2bcEuqJtKJw5f5JThY2XudQ==
X-Received: by 2002:a05:600c:3145:b0:412:7941:e3df with SMTP id h5-20020a05600c314500b004127941e3dfmr6224435wmo.4.1708983573445;
        Mon, 26 Feb 2024 13:39:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm6374823wmo.23.2024.02.26.13.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:32 -0800 (PST)
Message-ID: <2a43c6cbe0dd5e3d343cb40ec040b7269379e5a4.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:18 +0000
Subject: [PATCH v3 07/14] fsmonitor: refactor untracked-cache invalidation
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Update fsmonitor_refresh_callback() to use the new
untracked_cache_invalidate_trimmed_path() to invalidate
the cache using the observed pathname without needing to
modify the caller's buffer.

Previously, we modified the caller's buffer when the observed pathname
contained a trailing slash (and did not restore it).  This wasn't a
problem for the single use-case caller, but felt dirty nontheless.  In
a later commit we will want to invalidate case-corrected versions of
the pathname (using possibly borrowed pathnames from the name-hash or
dir-name-hash) and we may not want to keep the tradition of altering
the passed-in pathname.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 364198d258f..2787f7ca5d1 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -271,21 +271,16 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 
 	if (name[len - 1] == '/') {
 		handle_path_with_trailing_slash(istate, name, pos);
-
-		/*
-		 * We need to remove the traling "/" from the path
-		 * for the untracked cache.
-		 */
-		name[len - 1] = '\0';
 	} else {
 		handle_path_without_trailing_slash(istate, name, pos);
 	}
 
 	/*
 	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.
+	 * as it could be a new untracked file.  (Let the untracked cache
+	 * layer silently deal with any trailing slash.)
 	 */
-	untracked_cache_invalidate_path(istate, name, 0);
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
 }
 
 /*
-- 
gitgitgadget


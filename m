Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84641ABEA7
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722681476; cv=none; b=vBd7CSixe76oYFiMhwBO5CVLu0p+QnALcatwLk7WEK46vJDVHHk2AA+Z5FF3fx6Z+IMSj6eJGQ7aqUX6EqEzLiHIBdOuK499WlfdVYpZqjhacyAI8JSLJIJNN9TE9ulBnuw/QuGy0GXDRhQVXeosiaDhX9YfdIqZXHpFtAY8ZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722681476; c=relaxed/simple;
	bh=p59FJVN5Lp2/nhDvaq18hnobi2OXSiscEatGE23Pa2Q=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=A2ryzbULXSEMGaG4rgeXPUSI/IOm41EyKOEPcsn+sZ41j0G4WHVhiDyWgZLIQq0rPLVYSZHld5TMM24KHvq9nitCNsHxnQ2JjncqdMXz6xBM60u3cm23yC1V/K0UsjAHgB7d5gM/q0e7DydGU4yfZpfk9Qu494H2G4d98RUPOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyN+b5a0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyN+b5a0"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso54771345e9.1
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722681473; x=1723286273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DwjCM0Xh8AWeEHfhH/NiVX2MWIfTWBgK6PwGiyyNgoA=;
        b=TyN+b5a0+SLn1bNIfimjHGlnHhX/0B8aWE6VQ0mkotx73daBoKWbe8arQTj2nbRmpl
         mk8IApyP2CQPFyobwxoukmTgpmt6BU/4Ue8WUe/roo/NBMa+EBi4GEDgQGA2jL9ck1kZ
         M8xiVsAaiMyQs5iHp0HKrR3xqej/MhMi7kHeFv9ncH6H+CdNkj/vXk5WN1wKyuIz2fls
         H5UKIyxXlNtxAVjmnBkKLjmPDwDfoR+m3Iy0I/2iGkfA0Z7QNGX/ufL3gNYUvKcJEJKS
         R5iuYQV0gGZXBYRLkl0G673CyK9wtgKOg3yq+MpK8ps0PLFt8pPuJyN2gEyux7V2RFwB
         m6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722681473; x=1723286273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwjCM0Xh8AWeEHfhH/NiVX2MWIfTWBgK6PwGiyyNgoA=;
        b=CdFna+qtBhPm8xHvPk1RZjUOyiCd9uBT3BLEdIojG+0GKSiuq5MnkAkVG9wS0pEPhK
         83PTBMfDa0MN2UMbIIfPsaybt+UVS8AerSKPP1vDiKMTOOIOSScSsi+jjStiqT/5cmSc
         G9fWdBwoRaCG4Uk5TBmCtZWqoH3MbYBfXR0ik/9qs8JunuC7YfzbsCa8+7pki1p0q3Lq
         QMF2SAkfYEK62iBaMAAcnYFS9AmjgQwLyTcoNZOyibX7yisyC+aOFG3cYc1ZKZwEzSkr
         OteBUnLmY+ZB2G8b2x42kiRFzz607mEGB7IFcFWObjpQF5Q0cShSECYXNL6eZ+4tHI9k
         jCyg==
X-Gm-Message-State: AOJu0YzXfeAiZ35SSyakvNDwdzXS6Zz3cnA2BAFJoSrXSv3YRyv6vy+G
	/CUnhimQZS3jXKlOdtbTn8pH/9Scx9WlQITIvlaiGdB1CbSyFCS3U3GM3w==
X-Google-Smtp-Source: AGHT+IFyAaf03l1WprgMveuIXVJ003HZtv+cY7/ypvCBt26rUqTORYaYbWLE9ltqnq8Uzg7m512y8g==
X-Received: by 2002:a05:600c:5489:b0:428:1965:450d with SMTP id 5b1f17b1804b1-428e6b2f279mr41789675e9.17.1722681472482;
        Sat, 03 Aug 2024 03:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a862sm124236395e9.4.2024.08.03.03.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 03:37:52 -0700 (PDT)
Message-Id: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
From: "Sven Strickroth via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Aug 2024 10:37:51 +0000
Subject: [PATCH] refs/files: prevent memory leak by freeing packed_ref_store
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
    Sven Strickroth <email@cs-ware.de>,
    Sven Strickroth <email@cs-ware.de>

From: Sven Strickroth <email@cs-ware.de>

This complements "refs: implement removal of ref storages" (64a6dd8ffc2f).

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
    refs/files: prevent memory leak by freeing packed_ref_store
    
    This complements "refs: implement removal of ref storages"
    (64a6dd8ffc2f).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1757%2Fcsware%2Frefs-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1757/csware/refs-files-v1
Pull-Request: https://github.com/git/git/pull/1757

 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa52d9be7c7..11551de8f84 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -157,6 +157,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free_ref_cache(refs->loose);
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
+	free(refs->packed_ref_store);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,

base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
-- 
gitgitgadget

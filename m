Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20918158A3C
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699822; cv=none; b=COR5wnTk/b6QhUH4D4nadNUw240sHWaosHa66A+GJAeIO4wnGzsF/zcrTpwSJbDF6V9RPTj8xHn4XPrXWBEQdl84lGnF3q17A3CP21IUfo4zll2zI6Ok9Nl5RnbORvvtM0p0XRQd4a8sTwDZNB0jJmXces0RimnGtRe1t8Q1GNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699822; c=relaxed/simple;
	bh=xk57zUsLcULI4piYDwAtccyPpYcWKKlCtENISMpU5Eo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qoglhQTKBQaYzi6Wldz9P469EnfLf3UrfIrPGJYcraLVBpHCX2qnIUUxhNSCOVRbItWZjgdvC+U5xDuvq/7S1nEsunCrFAAQWr1ko8Cqzz+F6Tp4dtw0S9zD0N1l9INyBANXphr2D258rLL6OUs277TPHCq6GdopdUTJsl5bAJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUlN1exb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUlN1exb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41550858cabso42163465e9.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699819; x=1713304619; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waqH/iRrWNhiEfcSl3rSo7z9FkzRwk5MNMpC/HcssOg=;
        b=NUlN1exb+ODW04dQ9iOTXTvUNR2DusQ8AvggfoN1fgDahmf2+T/L+bBuDwVjqilq9/
         6RX9gy174BAwW1c2TU3vR320rc27mYBn0PDdtGr69afUELg4pqogClYFzfXthpZVjSUM
         jEIP1UxyrB+cX6qCjoYcsgKRWRcb+BIcL5TW6abkVIVvjgpptd0VeyVyz2eCrBoKVTfl
         oiJcKFHh6jYbVmFPH+Apt91vqq7MrnaDgIYoLaJbK23P6x3GHI0KHDPhSPty2wwULuZW
         eb8w36KxzjCggO8u0fNLN3rhYAJfWpquhOmNMVOpaZp7yXw7a6lIJ0IEalDthPaLa+7P
         F0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699819; x=1713304619;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waqH/iRrWNhiEfcSl3rSo7z9FkzRwk5MNMpC/HcssOg=;
        b=ZynjVzS1MIMzy1BSQ0/kaKFAq33caCd+UzXYsAXZY6EriQUH9A24xLbOatCT/9xJBc
         VRuzON1flSOcevRRSWAM81gLWTISJu6QmiMC7H8RVFMyt64hlfYyVfs1X0JQqKxsg/ot
         2TwyhYZKfxI5fC5nkbd5YfgSosKELO98IoW0IzkBeUzTNwB6550thNoLwFVGYTlkvXjK
         TPRyOWc2i2Dd47QjMmhnwhU5DkFhjqnjCDhcLDLlga9AVsZ9yLJw/AMyZ3ZACEowHXeS
         4Dk2sqC1W+nIkNVzpjZIU+lInxXUzw1ZjdKm0kqYwr7e74K68EKlZmEHt57WLgjoTJs2
         1B+w==
X-Gm-Message-State: AOJu0Yy/Oz68RsCwT1cSkSa0AaqGoHFnFq9w6FzxjlMU3SvBe/oeLNHD
	TIQi5QdkLZcDyruFRanWDM1a9DtDyWhqNKMalt1vHEZwmWIkL73AFHNAnMVg
X-Google-Smtp-Source: AGHT+IEIVqLLrsAPEUdvohat9W9K1f+CVA3pO5T1Pg8vwvHhPueQUt138tyMWq72mj40BkQ+i/P3Bw==
X-Received: by 2002:a5d:6802:0:b0:33e:800d:e87a with SMTP id w2-20020a5d6802000000b0033e800de87amr603554wru.34.1712699818739;
        Tue, 09 Apr 2024 14:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8-20020adfe548000000b0034335e47102sm12345864wrm.113.2024.04.09.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:56:58 -0700 (PDT)
Message-Id: <6e8b1b50ac5a59a401f73d6e3e0ebf90e1259928.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:49 +0000
Subject: [PATCH v3 2/8] SubmittingPatches: make 'git contacts' grep-friendly
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Avoid splitting up the command over two lines. This way, a command like

    $ git grep git.contacts Documentation

will return a positive hit for this location.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f17..a33fe7e11f6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -494,8 +494,8 @@ mentioned below, but should instead be sent privately to the Git
 Security mailing list{security-ml-ref}.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git
-contacts` command in `contrib/contacts/` can help to
+people who are involved in the area you are touching (the `git contacts`
+command in `contrib/contacts/` can help to
 identify them), to solicit comments and reviews.  Also, when you made
 trial merges of your topic to `next` and `seen`, you may have noticed
 work by others conflicting with your changes.  There is a good possibility
-- 
gitgitgadget


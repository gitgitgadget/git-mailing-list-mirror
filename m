Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200615749B
	for <git@vger.kernel.org>; Mon,  6 May 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019807; cv=none; b=aPDurCkI2W5x2zAgUYHI6Xbp/h5f0ch1h+qp0bCBFvWpD8IurgAQ8M9vD1YPvxSt+nKCwBR1InOagrGvMtNBqRALw8LWgl3OXJ3mfmm5VaJ7Uh/MSqQjInvdlIq3vbKLuXO+YR9HYKBdbQvfc0F8E9kU97xWdMIPvDyjG5OBDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019807; c=relaxed/simple;
	bh=I5mbgi5Lcxr0w1gNV52n7T+kuVLhQDfjubQcQNmfEog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Giy18TnFjlX/7toL1Ss5sPz5HWaK/md0d0lhtU3fTaY8AfcnF45MJg+N9JY/aC/t4yKdiMUXDduX+Db5lVGsqlA+jFo2zRgzHyyXsnsi0YhaO4/arXR3ZVan2b06lDbu3YdwPNXxDGBNmQ0n4Ov83cTwGNl6IljrPvaK60+Rpxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZMCKSJC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZMCKSJC"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso25614021fa.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715019804; x=1715624604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gD7d85Hwyu/UaV0w9+HZCsT4MxBfY/qXkRESp4VI/Nw=;
        b=GZMCKSJCV0tytDWECNjN4v+hKL6yTADMPxQ1lCXJM7NHE8USjRsqDBPaz6ZCF4H8Eq
         ZW5thPVd0ODEQcD+s8R3eTId1o5g1uvSe2rXaBVsc3hv8HkrAoQSzUobkj1jibiL1Mm8
         8mNn75mxntBC0B9H0o8VNBYV+AR/4uLR3FU+wsiKsEaqXS2TUZqgDEHY7jfdZ3Vb6bO7
         jrCPlfeaT2n+Trxd7hWcEAu8kKQlvdtEUmlEXYvwQ46mSlyrnnVi1ghQicDwYRWb0V16
         mNg3h/PyfuMprBvGcvdTsExCtSt7mKVdAlPFvSXFnlU1cEkZbRveCveCflP/yFWIav1c
         t4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715019804; x=1715624604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gD7d85Hwyu/UaV0w9+HZCsT4MxBfY/qXkRESp4VI/Nw=;
        b=aMoKGIYNTH+n5l0UvLHoXiteAlZ2smLplBToFzMkWUi8FJF1Vd3Cd1r5aoU3ug9dTo
         G+8T2UtMep/gahmuvG4M9+ICEUlOSAUqfS+R9Xk7blhQ+TZ1mBwwhEBu45M8cQeMTHZM
         f7PjPoKb0m2H34zHS5ovvRJ/SZ1wpmb6FntZX3Za2dGffHrHXOOgt1KUgZVEBgCyNQzd
         8RpPn0KgpmkQlcwfvjcHL2LkNGDWVcbUUYZVUQ8h5g+YCKAkLH0+hXUpkH4+JXF4xpeK
         RXgrEnlih8wrR7LibfXHjSVAG/sj8pIqtIbrZC3wqNRKiqjyC4G18LGd5kdgt7MY8Yqi
         Ea1g==
X-Gm-Message-State: AOJu0Yycf1qYH/6THFuI0q7T8vXidqi2Qr1QxOg6MfYKONNK0ayO9sx4
	POF45JxN6Si5aebKKhIAx2kKv2yNQIK+ax863i0UXQNL9aB/0PUTufLzQRkS
X-Google-Smtp-Source: AGHT+IHHa0O/wZPo3QwdOzW2j0PEHXBWwmGUbrC8SkDHjye/6ntHjOtima7glhWTt/DGZQw1hPx18A==
X-Received: by 2002:a05:651c:686:b0:2e1:aafb:696 with SMTP id x6-20020a05651c068600b002e1aafb0696mr5327854ljb.48.1715019803983;
        Mon, 06 May 2024 11:23:23 -0700 (PDT)
Received: from paasan.. ([2001:4641:9d1:0:d178:8e40:df7e:8f22])
        by smtp.gmail.com with ESMTPSA id b25-20020a2ebc19000000b002e308fa6439sm776909ljf.26.2024.05.06.11.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 11:23:22 -0700 (PDT)
From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH] Documentation: Mention that refspecs are explained elsewhere
Date: Mon,  6 May 2024 20:23:17 +0200
Message-Id: <20240506182317.13477-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The syntax for refspecs are explained in more detail in documention for
git-fetch and git-push. Give a hint to the user too look there more fore
information

Signed-off-by: Øystein Walle <oystwa@gmail.com>
---
 Documentation/glossary-content.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index d71b199955..1272809e13 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -576,7 +576,8 @@ The most notable example is `HEAD`.
 [[def_refspec]]refspec::
 	A "refspec" is used by <<def_fetch,fetch>> and
 	<<def_push,push>> to describe the mapping between remote
-	<<def_ref,ref>> and local ref.
+	<<def_ref,ref>> and local ref. See linkgit:git-fetch[1] or
+	linkgit:git-push[1] for details.
 
 [[def_remote]]remote repository::
 	A <<def_repository,repository>> which is used to track the same
-- 
2.40.1


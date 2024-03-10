Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3939FF2
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097838; cv=none; b=U4flyXjUR35XghO0kT2w3JnRKsg+QoCah7BaV5KVwaVnd+0xNSR8N+tFLyEFkJszu1NJwOU2ej/7LXAcxSeYClcWWLpoKIxZ9K2Q+Tq7OuPVYCHbp/SIv8BuwYZSFVKL6bfGYk9ju8QubBIwdVThjsSPPr79LWHS+VoOVpO2p2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097838; c=relaxed/simple;
	bh=90HxWsU2BCP2rylwHkJyP+rYOqNK+yV8Ax7EpdcgPiY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Jlhjvq2y0Iw8eBcApw7+4D9MB+I0n0DgLbJRNMibpKaK96vVHCzGfuQtcOMeYtb0L+femxzAAxc/L2TOCPU4K67fg7gKlhWxb2Olj8hb2Zf5IVPk4//0dCJ+SjvDROP0gxrU7eH2Qjcvb81PI55VQ4J971cs6anX/rL/7La904I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwC2mZJQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwC2mZJQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33e82c720f8so2014446f8f.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097835; x=1710702635; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiIezj2K0kuo+pWkujXGrWNl0hgKlSlWfUI73N+JpvE=;
        b=lwC2mZJQvGd4cDcU6jN0VPRbuyDEnevPdQO9lTPjLf5U9ptpn9RmobBEldCtXjJuBw
         JRav1+hkviCFy82qz5xeu5LmyKjiL2/AoTE05OrUr7wFLoA49rrHATu/rbFgM2Tmqw4I
         gXuIt92fLyb7pFYya6nCYTMxeQeo9ggi/uGOefOVZTl0R6dOJ4yV1Y47A23DuYcKfYAQ
         CNt3qWOhM8EyZ1A+g5RHic9ZwPD+VDinmOWy8dbWy4jsBFvBsiZqLGo0TNPIXNSWAN7O
         pazCvaH+Y1AmK+rGlndBMG7WdPXip80/Td24ufCA7rPgTO4dLPFJDk3F8PMDCkwZ0c9G
         ip7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097835; x=1710702635;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiIezj2K0kuo+pWkujXGrWNl0hgKlSlWfUI73N+JpvE=;
        b=vxGLR83O6s/jeLR33OdWq85HxgK2HaFwbbkXELY0Xg3wnTi0GANvARkhXbASPeWm8R
         oKK8K1eyrDGQuKyIbhH3xDySSFDetz+ZK4GouRvjKfTqbOMCyy+1qFcrE2K632TljxLj
         R/xur31t3laBAbV17Q9rdf5WfBlJrXPzUUkxWsYzvOSyfoS0Gl9BDWKBDLz6F8MB9rve
         f3s8ieKmlkFhSZ+Ymv1X1J1P7vD4szPoQ+CY+3vBJDH/rx3pT8am6oWKT5BUGGy+iwB9
         jf1ISQ2A/Qbubo0IBzzztCd7LE9KL+gveO71B3eBQLe+VY024DM9JYTZhogtX2QHYNOw
         1oZw==
X-Gm-Message-State: AOJu0Yxfl0/vsbuKvElL+eSS+BoEzfYjxTDuMjxk/sHCTtMdhKJDqcBN
	HQM4Tf4QvUMAVPRkfPuR5waV9h5BqhQsgY2u+oMXSojnuwTPiGLypEE70tI+
X-Google-Smtp-Source: AGHT+IGGlrONgWBBsNrFz+K+JKGvOeTXDIx3k/LXjyFRVVdiQnziK6fLOlsW/J3Sfr9I2suREltVUQ==
X-Received: by 2002:adf:e483:0:b0:33e:67c7:e2c0 with SMTP id i3-20020adfe483000000b0033e67c7e2c0mr2901180wrm.38.1710097834823;
        Sun, 10 Mar 2024 12:10:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020adfb613000000b0033dc931eb06sm4617743wre.0.2024.03.10.12.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:33 -0700 (PDT)
Message-ID: <4140c44a34e8c05581de14c2074945d74ecea1d4.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:27 +0000
Subject: [PATCH 3/6] doc: git-init: rework definition lists
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

In all cases of option description, each option is in its own
term. Use the same format here.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-init.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index e8fe72861dc..5fce39040f2 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -99,12 +99,14 @@ The option can have the following values, defaulting to `group` if no value
 is given:
 +
 --
-'umask' (or 'false')::
+umask::
+false::
 
 Use permissions reported by umask(2). The default, when `--shared` is not
 specified.
 
-'group' (or 'true')::
+group::
+true::
 
 Make the repository group-writable, (and g+sx, since the git group may not be
 the primary group of all users). This is used to loosen the permissions of an
@@ -113,11 +115,13 @@ permission bits (e.g. if umask is `0022`, using `group` will not remove read
 privileges from other (non-group) users). See `0xxx` for how to exactly specify
 the repository permissions.
 
-'all' (or 'world' or 'everybody')::
+all::
+world::
+everybody::
 
 Same as `group`, but make the repository readable by all users.
 
-'<perm>'::
+<perm>::
 
 _<perm>_ is a 3-digit octal number prefixed with `0` and each file
 will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
-- 
gitgitgadget


Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08655897
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820917; cv=none; b=kCo+1BYakP3uL/LNMfdFnBsEO6CK7VmPtu1SNMVTVSm8ioOh/Keyh+BDIRP4hjSGOV+0Zdl1dJxqwBsNM9x7owpOxXu96u9JnhpDrchVzIya1erJG2bN54Nf3ptZ1AdrQH+4ENuvMVq89pYAXY858Px6c4y/GOtMCWfS9ZYo6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820917; c=relaxed/simple;
	bh=D5veaIE5R2Ue0NlHNqPCh1WaBuZQmlRu/MGfgv8TsWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L+ckldVOds1xw5QU/lLPn6p1L3LKgVi1kfohvFphMVZ1PRazdvtZNaxSQM84CGbpk/gHZit09yS2jCwUaHRFX8DVKFoT9Tvq8sKHreyfdpq53sCjNaJ7MPBBAzTRa6dsyOiSkLaKyGByXmcNHNLsgFpdfgX5MCB37wSaZRXiGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItunZh/1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItunZh/1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so14278265e9.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 01:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726820914; x=1727425714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl6hKbLJ48JxBvgQYW7FR5f+Ksh/l+BlB1bcDakbWXI=;
        b=ItunZh/1Dlgda9vvzMZFfiEX7d6mTEbGVrnSY3f9IJspvyH8UVNbmpRvyNmhUhMrK2
         +X7lZbivc8DkGgrFDoIW/ZeeAiaHeDTEKMo58rf8CM4+wJ8N4/F0GSDaJHZngJdaQMM7
         uPFQIVIMO8NL49KVaVhnGROJuKy5rnLtYrw+HWppGxByvo4e0EkbtQhx3avdOwWPZ/pw
         7Wd7zc/LM2QGYIp9SA11xyuvK9n3jLtVj0cTVqt+aVGSRLfapMVrcbFK3XotdqdH9ira
         uBoOWn9ljzDXGqSqVt+odp31QHLj1mEOylzu1o0LeJykrl6LBWKh5cg3EhkVs2BOazO1
         d1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820914; x=1727425714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vl6hKbLJ48JxBvgQYW7FR5f+Ksh/l+BlB1bcDakbWXI=;
        b=WT7Wdl/sijErHc0s5+MTwj+YN4g0H2sHzUd6+cBA0DQVuT2Zktie0U0F/9xws3ytFI
         rK8Q+nYgeWEkA6R+Fonkb/m02M4qEk5NknAuPItKuEWfkcQ3LnR0RpgJ3leI7dvCWcnP
         dUBEqj6rAvHh+hX+vo/tSint1ZOA9oPkFhqiiAp5ASqTg1RdxLnBN6ef22evQGdc4+YF
         fuzIUlL+nI2Ejl1wapwCFeG0D2vQSBtUFRYACvrseHSNdw/f7KMoA5KESFu9ApoKx3Ow
         1gAkY8QE2MmWNAnQyYmovQqE0/N/UMHF2XhbCsH5nppApS8UkWns4YP3z3+KaN0BWy50
         Ie4w==
X-Gm-Message-State: AOJu0YzThv/oq7i3RuQmAz6jF0Kqs+CTMaTsLBcQFhPDAwPHNYzFNeAK
	JNDZj27Xx9hY2upf5vK1Ra75MlUb349gTrRdcetoLllBM/MnPLlqP1Cptk9Y
X-Google-Smtp-Source: AGHT+IGKQ0+5khLMSCIxXCqTN666kYfOdjAHkuUnjdRHqPSCleBkd1mbMRoEJ8QutACE0R45nwmpTQ==
X-Received: by 2002:a05:600c:1c03:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-42e7c15b33dmr10223945e9.4.1726820913829;
        Fri, 20 Sep 2024 01:28:33 -0700 (PDT)
Received: from void.void ([141.226.14.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ec6sm42514965e9.21.2024.09.20.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:28:33 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 2/3] Documentation/config: fix typos
Date: Fri, 20 Sep 2024 11:28:14 +0300
Message-Id: <20240920082815.8192-2-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240920082815.8192-1-algonell@gmail.com>
References: <20240920082815.8192-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 Documentation/config/extensions.txt | 2 +-
 Documentation/config/gc.txt         | 2 +-
 Documentation/config/remote.txt     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index 38dce3df35..f0a784447d 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -9,7 +9,7 @@ work and will produce hard-to-diagnose issues.
 
 extensions.compatObjectFormat::
 
-	Specify a compatitbility hash algorithm to use.  The acceptable values
+	Specify a compatibility hash algorithm to use.  The acceptable values
 	are `sha1` and `sha256`.  The value specified must be different from the
 	value of extensions.objectFormat.  This allows client level
 	interoperability between git repositories whose objectFormat matches
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 1d4f9470ea..21d56db279 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -163,7 +163,7 @@ gc.repackFilterTo::
 	containing the filtered out objects. **WARNING:** The
 	specified location should be accessible, using for example the
 	Git alternates mechanism, otherwise the repo could be
-	considered corrupt by Git as it migh not be able to access the
+	considered corrupt by Git as it might not be able to access the
 	objects in that packfile. See the `--filter-to=<dir>` option
 	of linkgit:git-repack[1] and the `objects/info/alternates`
 	section of linkgit:gitrepository-layout[5].
diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 36e771556c..71d1fee835 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -50,7 +50,7 @@ remote.<name>.skipFetchAll::
 	If true, this remote will be skipped when updating
 	using linkgit:git-fetch[1], the `update` subcommand of
 	linkgit:git-remote[1], and ignored by the prefetch task
-	of `git maitenance`.
+	of `git maintenance`.
 
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
-- 
2.39.5


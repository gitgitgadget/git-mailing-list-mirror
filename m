Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9645245020
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471865; cv=none; b=b2w/vau4xog7USaD0QXdvZO3u2KUgofIzLtQFsKLuA626YKv6xiaNteD7rNBhx3D9y7F6UQG7PwD2bi0YiEinL57D882mja3bPvBamLlm6BReIcqUJ+pGDHu5C20onYIkDAIqmG/lBvfErVnEPE6N8+k8EeW92kxkbwCYUm45mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471865; c=relaxed/simple;
	bh=rqX3G8h+kI3qBrqXqX28qQxIsjB8IjstEALgc4+xldQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qRtNM364+7J6wJXtcdB3AYrGAdnyvj2uq/EGGI653zZijdhqqpN7fdS4RJTMuYphidmgB5H1wR/2XcRJK7XEkIEx1DdwnoNrOZtZD2Vm9W7t9udwZ6m3jfdIOFrZqTDqSc+3tyxdnn6y1ijgiCkOP7BDqFxydgBHKL2XUVnTs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lliZRzwo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lliZRzwo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so726843f8f.2
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 10:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739471862; x=1740076662; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SlLjt522Bgidbtlf+R991veESZeqTtmr1DvmmL+/ao=;
        b=lliZRzwoSaPa65JljOJqpWmWlV6IEVtPDyk3WkWuTmclzjNmQrqrHj4eShBC4SSZm5
         ZUrGzNrvHdln0+ofaWRvRyi4d29ildYcwjNBzWWBPhlNS3yzTUFaRV2pA6gJg3AYbAMt
         I9hKc/szhT5+Ucbe+VxM+HSMiAOvf4Mk9xLalUKz5D6QRSYeSpY4Rd7UuZgXi4ncOJ/Y
         W1b39w0eVkHWunRsS5zQeo7mqNaN2fXcq9v68znvCFHRiGWQqiCBsmPI6/PzYuFPlADx
         m7JGwqxpYXqvOZalHFvLWhxAJwqHzrF9C0rHR9+JFWvNz6utphusvbBcc+pS9Xu3JM/y
         70ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471862; x=1740076662;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SlLjt522Bgidbtlf+R991veESZeqTtmr1DvmmL+/ao=;
        b=hHdB1Pkxffu8RoRLIsePdS1GW8BrivbmFzSVNwLY9k37Ryy8MGasFCdXQA2b6YpbIE
         FYwZHCaaASBNVi3+XApydGUKuU6cL54H3iFCIh6SXr0AoZVShPV8ypcbLne5lhWo6avF
         hR85hydsNA+46e6xxLi0rlLoWGCHS53kP9mgkc6PK2H3kYkeOiIqNKxSvyfqR3PhlY1k
         NQAFPNNuWfQ30HHC+3pEKIMsq4yl2GeRwF3Q6JIZmxWLqVsfqhtnRNbbxwParw4rRLh/
         L2tTS3hcL8vCt8UKb/ht+zeD8QAkziXmclopa7RS3HMSb6Rq5iAgIYA5e22BsWtLmrBh
         j5dA==
X-Gm-Message-State: AOJu0YxgyPLV5ciJM+G4HgeoiyacA2Yp/iHF048XL1J5fmJmT5J7JvWB
	O6n1MaH+VmKkN2Rlolo42ev2vVA7bAfjdlAW+FkJ1UEOdDHw+JYL2BU4bQ==
X-Gm-Gg: ASbGnctzzlxOIehpsO49sGFGiM8Bd3J00mxtE0JI9XjiqtQtGDnL5+Zni2fD5I2AjG/
	nCx8ZjdB0pbvWA3DRHMuSPR+n8nqSNDA+2DDQTKVqD4LYSXmvgOPdjM4ovWsSItUMe1XYZXvQf6
	7KRbiWzExdhysV2k/qzcrUpzm5s1/RtyEqA2lKUHnKleld3ogCfjSRVORL02yu2FfmD5Bqnk5dj
	odS+RWI2CmTYPQwsakexdMNPQ1NzoqTC+Np3cjmLJsVEsBjcakWJwxQQEkV7qxd8bGyjYG468GM
	w0AQ3vQsrW3LCXZV
X-Google-Smtp-Source: AGHT+IEz/yJ4c5QAFEII0dOy0NcYNNUF2riRAx/0hKUatu5Bl/ggBuUMmOmFRXmntOWuAr8YzrVOUw==
X-Received: by 2002:a05:6000:4025:b0:38d:e1b1:be9f with SMTP id ffacd0b85a97d-38dea256927mr6968069f8f.4.1739471861513;
        Thu, 13 Feb 2025 10:37:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccd3sm2545114f8f.23.2025.02.13.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:37:41 -0800 (PST)
Message-Id: <07ce068403072bf6933ddd00fdf1674dba6cb235.1739471859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
References: <pull.1859.git.1739471859.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Feb 2025 18:37:39 +0000
Subject: [PATCH 2/2] meson: wire up credential-libsecret
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
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
 contrib/credential/libsecret/meson.build | 3 +++
 contrib/credential/meson.build           | 3 +++
 meson_options.txt                        | 2 ++
 3 files changed, 8 insertions(+)
 create mode 100644 contrib/credential/libsecret/meson.build

diff --git a/contrib/credential/libsecret/meson.build b/contrib/credential/libsecret/meson.build
new file mode 100644
index 00000000000..92349be0ee8
--- /dev/null
+++ b/contrib/credential/libsecret/meson.build
@@ -0,0 +1,3 @@
+glib = dependency('glib-2.0')
+libsecret = dependency('libsecret-1')
+executable('git-credential-libsecret', 'git-credential-libsecret.c', dependencies: [glib, libsecret])
diff --git a/contrib/credential/meson.build b/contrib/credential/meson.build
index 4017ae3fa88..bedc76b96f2 100644
--- a/contrib/credential/meson.build
+++ b/contrib/credential/meson.build
@@ -1,3 +1,6 @@
 if get_option('credential_wincred')
   subdir('wincred')
 endif
+if get_option('credential_libsecret')
+  subdir('libsecret')
+endif
diff --git a/meson_options.txt b/meson_options.txt
index 7554528482a..69e386afc2a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -29,6 +29,8 @@ option('version', type: 'string', value: '',
 # Features supported by Git.
 option('contrib', type: 'array', value: [ 'completion' ], choices: [ 'completion', 'subtree' ],
   description: 'Contributed features to include.')
+option('credential_libsecret', type: 'boolean', value: false,
+  description: 'Build helper git-credential-libsecret. Requires GLib and libsecret.')
 option('credential_wincred', type: 'boolean', value: false,
   description: 'Build helper git-credential-wincred. Requires Windows SDK.')
 option('curl', type: 'feature', value: 'enabled',
-- 
gitgitgadget

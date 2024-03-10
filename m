Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1903A1C5
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097840; cv=none; b=Vfx7IYZt8/W9zSbovTavMhPD7fSQfRSyBC6n5xQQ4kzYCyiX8kI12q+V66xQSFm0hAp6d1jLrD9ccoyMaDkEIGALwWud36BpH7e6laJGTrLOITPtyR7C/H701m19ZZBgRZECEY7N1GeabYV4HgzA9CWcQpz1KwlP+W3zEwSZZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097840; c=relaxed/simple;
	bh=vOLqEJCObHpSCjeaObQdFsiOn7PnHKApodVZhe132xk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=RyFm/3y/jJyfiyv0rQgoTSa80dIRqE4ynPo0Q83QQNWlslkoBf+7RZG+2Jn0PDfr8GX9Y0uAhsRR/wCkUL3uBCCzvxJVujavxejz39a5aP85rQLrrw5ftzuny7lpbGb31TEOch9CAGxgtl6YIUiIqGEDfbFlXtYUCpvjKgyL/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcjQAi1G; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcjQAi1G"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41329a665d8so1919225e9.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097836; x=1710702636; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK45SV2ohTWRxcqILSkwK9ayI5NTetuU7nt2g3ZdZhI=;
        b=QcjQAi1GJEJ0WcsAqRqNPDIeFmRYE4yPtzPG7AReHfDgNefWwieTdMQE4FwfHefJuK
         tg17jLB3KAH936QEUZwp84dwnTa+qQurso36J8Dh+sR7YjNNiFfiS3by2oFirUvixM6M
         cDJ/4j7kaHG+UoJDRdnwwIvShRx3bGK2S3T36ASbPJwCintz34SR7cJo6Vrln/dviDv6
         EPznCfYwfoPP/XtgmJOtQTaQm5niOSCJFKOR9j/DDPvpeYlsCdcHRzq0P48KUaq71KRH
         1BfC35s5gLpAopgGRusR/g31omzTRT+o9B8AEqOIaejtHm3JYSAZs5dhgv+QTdTbCtKx
         J9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097836; x=1710702636;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK45SV2ohTWRxcqILSkwK9ayI5NTetuU7nt2g3ZdZhI=;
        b=dPS0wlwMBlWVFQH/ahRoch5dzIUE61VlySyRVUOGi2qwP8mjRCmPEPC1ZidWa6joOa
         s1lUb78xURvKek5wxv58VGlWBGb6yg1Qxy2lnQYmevSq/ErPRl7ztnFbsD5IKKc0523z
         xxXqdvISGq0pR/I9ExZBKKSvj1WtCCBIq9gYMTU9BqLxG/9HXcRJNKc+yGuQfB34mFmB
         hpOPG9DD6UixLiLMgnEgMdmR3PsonWJjZubMp1EzHSG6Iou53xeI7WHXz6FGgEqUqau7
         Ub6Z49MP8/EtXF1ICb0lNvAUBoZ9ifGsMJ+o529tTqmCGYNap71Ztr/fefK9eBTl16QQ
         6siw==
X-Gm-Message-State: AOJu0Yyzg3s9kGL4ztmoUIAXYLYth/W3Kjzmaqu/lPB+9Yw2HORivYaS
	Q9smFqEvCVDNX1lTgFGWwxQxsQqURky+6Kfqvy+4/H7LepswqDbVZDkhqJuO
X-Google-Smtp-Source: AGHT+IEMnETc8BDA733O5SSSzu76SDSgs4oZ33Kxo5Rj0bFkWvJALlA9qz+Lcz9hjsh3m5A9kIXCRg==
X-Received: by 2002:a05:600c:3b95:b0:413:166c:242e with SMTP id n21-20020a05600c3b9500b00413166c242emr3475761wms.28.1710097836436;
        Sun, 10 Mar 2024 12:10:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b004131f8b622bsm6075192wmg.14.2024.03.10.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:36 -0700 (PDT)
Message-ID: <54e5d8735c4351e5041f777f8d9da0fcadfcfef6.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:29 +0000
Subject: [PATCH 5/6] doc: git-clone: format verbatim words
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

We also apply the formatting to urls.txt which is included.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 4 ++--
 Documentation/urls.txt      | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0c07720c6f4..6bad5641151 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -156,7 +156,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --[no-]reject-shallow::
 	Fail if the source repository is a shallow repository.
-	The 'clone.rejectShallow' configuration variable can be used to
+	The `clone.rejectShallow` configuration variable can be used to
 	specify the default.
 
 --bare::
@@ -263,7 +263,7 @@ corresponding `--mirror` and `--no-tags` options instead.
 	branch remote's `HEAD` points at.
 	Further fetches into the resulting repository will only update the
 	remote-tracking branch for the branch this option was used for the
-	initial cloning.  If the HEAD at the remote did not point at any
+	initial cloning.  If the `HEAD` at the remote did not point at any
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index ce671f812d4..9af19be2075 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -44,20 +44,20 @@ syntaxes may be used:
 
 ifndef::git-clone[]
 These two syntaxes are mostly equivalent, except when cloning, when
-the former implies --local option. See linkgit:git-clone[1] for
+the former implies `--local` option. See linkgit:git-clone[1] for
 details.
 endif::git-clone[]
 
 ifdef::git-clone[]
 These two syntaxes are mostly equivalent, except the former implies
---local option.
+`--local` option.
 endif::git-clone[]
 
-'git clone', 'git fetch' and 'git pull', but not 'git push', will also
+`git clone`, `git fetch` and `git pull`, but not `git push`, will also
 accept a suitable bundle file. See linkgit:git-bundle[1].
 
 When Git doesn't know how to handle a certain transport protocol, it
-attempts to use the 'remote-<transport>' remote helper, if one
+attempts to use the `remote-<transport>` remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
 may be used:
 
-- 
gitgitgadget


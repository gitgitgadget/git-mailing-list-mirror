Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DE32C311
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534022; cv=none; b=HiJ+aY1PEfTOw9Sz85MgTxReJPgd9FoCJL7VOJbt7klDDKcPBIjNQ+5GqAz2+/331i/hGExbvAPE1PWvPqXnnqSwUtNVLAWMxfCs1vKhKCGUbWJBXeVwqPfpbXcGUj+Ds5l2o32ogdST4yADNVRztT2Rkr8MfoUmNW6TKH42oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534022; c=relaxed/simple;
	bh=63pIc3RIMmX64MyfllCOJ2DxIPVhIvCFyJ/N01f+viU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WOryioaEmd9L0wt9j+bHOG+/lbr5JP9JXUzDznoDpHDKcbtbRlBJJO3HeYJaKsUcyfwQAds4ECDrY+EWNubOiGMqI67RIXix7HNGUlQ6zKSd0vhkl5Sc1CEZ9HPX5g6TJKgexQteSxPws1a+NA78reXQcvublLCB+WHCagx/hwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfQ+mG2H; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfQ+mG2H"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7811fa91774so5678773b3a.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760534019; x=1761138819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Elrg2QGy+C+XEK5lmrIuVYJsgcnYNi5sxte5Lq4vkuA=;
        b=VfQ+mG2Hb7rD4HeBtch5G+qU8+c5RHO/JnYkKHfAeUPMzRPKsuZBCXEUBGLZeLaAud
         F3WJjXpYPfsSGODPc2DRDu0qzyIxZ/80oByyY0UsiouiV364oxeP9og/10xdchzaYprx
         ee3hi/gP8bVJGzUZ/k3lXA2sNniBnJN6hMsgizM8meFhV/4+OAAtzK7F7T2N5v9cDB9p
         TYqNqfeX3/ML5Q81lgu76hhI+wxnjmG5WyD0g4fQ+eyDijU/8m6w42n41GmZmqMZ8bf8
         MtPx+s/0eVSD1NAscDIKuZBQ+r9xsbja3+BJj9vK5S5hzgFpk3nOEZxE/IB6t3jnHUn2
         JlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534019; x=1761138819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Elrg2QGy+C+XEK5lmrIuVYJsgcnYNi5sxte5Lq4vkuA=;
        b=OQHPAQmUq1Z8lbeImj+73j4cNlGxgqvaFTsqQdP3b/I4vmKMcki+g76c5nsIAf7Fv8
         TShFSsDfC/QIFf4RS4waM/8VWcBKjZLAnEml12r2nNdvXnjI+DL/ZwAB0aTra8+9V+3F
         Ojm7ObNaRfsQHBo9VxPH7+pZIa0qllD9uT2EC4KpJFvXMT9f+lPZ+02Bt71R37m3ZNVy
         FKPXp2P4WJrYRjjRGw5navgQadyjFQu8IOg4GeUGVyRwsTqw9FwfoOW0DtWsmu4Jz4cu
         NvJc+eW6HIrMbrSaTVIp0n00HxruYj22maFm3C/7UhXUDwbJ2vemw4mngOCNV4OTWKi7
         sqLg==
X-Gm-Message-State: AOJu0YwWByiirsaEo4UUPpHmZRPXXjF1V/tcbV/Isd8dhLRm7um9cJ4t
	0CevQJEBDDq1BwT/wpTijbCDRmGv6DJsoIksN5Sg4r67cURxvZ1L/sYT2nhW5R3Z
X-Gm-Gg: ASbGncu1vum7TtSrlKyxkCyJzcevNz28Sp1X6qlRzqYQIqah2cO6B1eg7NX/IPL8E3y
	EzNr/+48N/8sulJIkO6c7qJfKTRK6ABPBRYc6zlv+BiXForkX72GURq71AKsvNm58C5oTtZ46A/
	FqRz+dlp1QFWDo2Gd/lCFH9QTzrbJfEWXDioRt02vsI7iWoohNObXmR/WBU8gmdnMenBg7TGo9W
	j/0KbWShHd7/9qaeeIRiEQro0kxH5WaacvHLwI5vL6oTrflJbbh7aqXe0CxmPEiaeCK55t9+ISB
	anP9eZg7ftEMQ7mc9s6elKAeaHMExQdsBZ68EsQF2bx/wsURdvEIhwFYZEQ3q9oWybbCcZHNn9H
	vKZennCGb/Lj56B95WuQvumvFm8cGXUXT0PAzBk3P
X-Google-Smtp-Source: AGHT+IEg8LfpcQK4isPEmVnFW0a0mCBcZGEVOV2HT2Jf8eHWRoB9Rp/W02bsgJxshNuw7nVA/bpffA==
X-Received: by 2002:a05:6a20:729d:b0:266:1f27:a024 with SMTP id adf61e73a8af0-32da8512ce6mr37708195637.41.1760534019165;
        Wed, 15 Oct 2025 06:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df24ac2sm15044896a12.22.2025.10.15.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:13:38 -0700 (PDT)
Message-Id: <2236dac4e469a82813b71e6bc67ec29fcb78752c.1760534011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
	<pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:13:31 +0000
Subject: [PATCH v3 4/4] doc: git-pull: clarify how to exit a conflicted merge
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback:

- One user is confused about why `git reset --merge`
  (why not just `git reset`?). Handle this by mentioning
  `git merge --abort` and `git reset --abort` instead, which have a
  more obvious meaning.
- 2 users want to know what "In older versions of Git" means exactly
  (in versions older than 1.7.0). Handle this by removing the warning
  since it was added 15 years ago (in 3f8fc184c0e2c)

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-pull.adoc | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
index 273172aa80..cd3bbc90e3 100644
--- a/Documentation/git-pull.adoc
+++ b/Documentation/git-pull.adoc
@@ -36,15 +36,9 @@ There are 4 main options for integrating the remote branch:
 You can also set the configuration options `pull.rebase`, `pull.squash`,
 or `pull.ff` with your preferred behaviour.
 
-In Git 1.7.0 or later, to cancel a conflicting merge, use
-`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
-with uncommitted changes is discouraged: while possible, it leaves you
-in a state that may be hard to back out of in the case of a conflict.
-
-If any of the remote changes overlap with local uncommitted changes,
-the merge will be automatically canceled and the work tree untouched.
-It is generally best to get any local changes in working order before
-pulling or stash them away with linkgit:git-stash[1].
+If there's a merge conflict during the merge or rebase that you don't
+want to handle, you can safely abort it with `git merge --abort` or `git
+--rebase abort`.
 
 OPTIONS
 -------
-- 
gitgitgadget

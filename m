Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086D748F
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834938; cv=none; b=OyYi7v8V6hzoAe5uSGiHw6XqzlbT7JDfctNgJxUAkU/weCi/256Dtqiuld01KtpPJr5HfOhnmvx+EXISO5m5+Kmoc3HxtUN3MnrZ9zQh9xWmaF0nX/CcO7EuBycu4kzdqQmiau3dhWVrNCPh20J+Jq5IckODYp7IiCOeV7yFi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834938; c=relaxed/simple;
	bh=sf+eMiMbgNoTL/ueL8lsT01PZYLnr16xtKhaFi3dr4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XzPOQSzhCWXmVZqU3yesJ429M+m7wcWMR3P1ZF9RnpK/yblcWiPtru8umapHKqljCQ2p6Tyf6EWi98zRmTiWtruh6nm1ScBvqjYQZyTRWyM7oqUg2DRqoZeuUzDDcesoRVTdMrTsDFUGbiCY1fDXEp/axujrLE1/fmV//3xIeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/JRpZYx; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/JRpZYx"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4be4d72bceaso548050137.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739834935; x=1740439735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mYS+hbne4canxxzjbEnFP0it1W7/NM+3DYkQvR1Bgqo=;
        b=V/JRpZYxQ5m+ZvgS34G6QDAtm0C4BJrzlmmnRFQ002QXkUD3/mcEn+mg2pFVbFpHWr
         ohy08MJHUg4IXwNHDDBM2Na6P/YjkskmtACUtwLLWtECEHpiY+UBP5pvtYeRD2RG3Qym
         Yhd4RnRBXmIq9I/6f06FUZMTtEgnAIl49lCsrLbC5k4HYUYpcfJbhNTpAQYMLIK0RwSc
         I5gbR1o+PwYQOebua48MEdmlogoa71u3fjjsLYrUzcPpV5gFoXDnWaVVX1xe+osDLhBm
         3U+HRVWvaMKCN4KixWVEKF9LUYdb5n5h1z7foiQDYVfs4OKQN01os3YyBBHLvWBXkKsP
         WNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834935; x=1740439735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYS+hbne4canxxzjbEnFP0it1W7/NM+3DYkQvR1Bgqo=;
        b=nlaV7Bz+cBwfNYrC7NJJmeuFv6uGsuaUsLz5d0JSkhoEEV6AjMhcInGdb2ucFzgcoG
         F4Ix0CvXfMbsMlIhvkz9coWGafuAwIiICXVL47WYcsbnCmDJI7NtvfJn7iKxalu/gqDV
         lWMuUQVVkxKJaiomtyZAEmmxt82uodQOWJscCsitQ9o7Mbdglq+FZUFDc1i2Wzk72m5M
         xOlfRvRFrzSvlOc21HnP3MJUWkvjcFciLhxvf9fpIchl9aklEi8kgxPqA2J3Zqb3t6IO
         lI8fjCVGjCQI72rYeOkQRBsqFTs/dPTgyvyPtvXf3ES+HPVfTrQApxFV4PJgX8QtmOGr
         WWDg==
X-Gm-Message-State: AOJu0Yy4yd3DvzIQ0SgUju5KFKKWVAGj0yM8iGcPfByjh3BNaajZ0LJ8
	q+9TygOEJt6cU0KXAnA2PgShkXaXfddzVBQm6GD+C5bceCS/C+iPJB4IWQ==
X-Gm-Gg: ASbGnctRUz+VN5Bv9YFDqr3ExZZgRJ+TpZ/GvqUgZYdn992mfCJljVvbGmC+ZqYAvmQ
	sHu1YNeB6dMlBGRCP04HZJVpNXI13+H5/Pg2iIF017oDFE2s8xXn4QpbuTd7ITtHPFIANNSX5mC
	aNQR6gNIRD1LAbZM/KQoGA8t6c2x/PGNFUtiVkpiJD80OXOX2uxh9hB1SxdSxt0dZtG6ddfoP3R
	U4HHhfSPTpe+ESRY4xR16e/7uJ20Xx2xkdvJ2H70vd/tC/F0PQRBVmM7FPVlj/PNQ6gkdavQxNQ
	EDzDWphKw5PqVDJ0eouSwsy69WDKS1RfmORxYuhFwBD42UyaY/Trdg==
X-Google-Smtp-Source: AGHT+IFLJBJlI4VTvh5xPx1JasV3tMLtHpmL+2xU6YysIwxT/wi8Xdxn8mYMWq4lkLbJh/eGtRhMfA==
X-Received: by 2002:a05:6102:2c05:b0:4bb:c490:7d88 with SMTP id ada2fe7eead31-4bd3fcfea26mr7219641137.12.1739834935421;
        Mon, 17 Feb 2025 15:28:55 -0800 (PST)
Received: from localhost.localdomain ([177.62.185.116])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8546d00sm2161555241.1.2025.02.17.15.28.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Feb 2025 15:28:54 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH] git-merge.adoc: detail submodule merge
Date: Mon, 17 Feb 2025 20:28:47 -0300
Message-Id: <20250217232847.8567-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submodule merges are, in general, similar to other merges based on oid
three-way-merge. When a conflict happens, however, Git has two special
cases on handling the conflict before yielding it to the user. From the
merge-ort and merge-recursive sources:

- "Case #1: a is contained in b or vice versa": both strategies try to
perform a fast-forward in the submodules if the commit referred by the
conflicted submodule is descendant of another;

- "Case #2: There are one or more merges that contain a and b in the
submodule.  If there is only one, then present it as a suggestion to the
user, but leave it marked unmerged so the user needs to confirm the
resolution."

Add a small paragraph on git-merge.adoc describing this behavior.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Hi,

This is a "scratch-my-own-itch" documentation patch. Some years ago I was
questioned why some submodule merges on GitHub lead to conflicts while locally
they didn't. I only could find a answer for that reading the merge-ort source
code, then a wrote a blog post about that, which you check here:
https://lucasoshiro.github.io/posts-en/2022-03-12-merge-submodule/

Thus, this patch adds to the official documentation what I found at the time.
I wasn't certain if this should belong to the submodule or merge documentation,
so, by now, I'm sending it as a merge documentation patch.

 Documentation/git-merge.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index 64281d6d44..7b12c0d648 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -205,6 +205,13 @@ happens:
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
 
+In the case where the path is a submodule, if the commit referred by it in HEAD
+is descendant of the one referred by it in MERGE_HEAD or vice-versa, Git
+attempts to fast-forward to the descendant, when using `ort` or `recursive`
+strategies. Otherwise, Git will treat this case as a conflict, suggesting as a
+resolution a submodule commit that is descendant of the conflicting ones, if one
+exists.
+
 If you tried a merge which resulted in complex conflicts and
 want to start over, you can recover with `git merge --abort`.
 
-- 
2.39.5 (Apple Git-154)


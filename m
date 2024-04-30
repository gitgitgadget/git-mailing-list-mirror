Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414DD1527BC
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488654; cv=none; b=aeIY29g4O5AYhQoWcB30N0hvSLAq5OjtlElu2ga9mY4T9E1kF4cz8ROl3LEnlvDQJhZEi9bFsqgpAizqHhBRauQqqwTtdfi2oGd8XJsc82Fifwr/0zW/IFHNmy5Jt81Vb3ERtrlwLO6NftQ7vli4B2EYykbWOKZNzuBMDlWN7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488654; c=relaxed/simple;
	bh=nK7UYJ5jzkIGe7oZEiG8VJP4nNW7IXx780GjGuOr5KU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BPhwfrCZxOdP0u9yVvGKpCk2NSXkG/YCT11Q5wWx9AmBWp3SbHS2AUpWP8dWHFDslUV2xEti1yiyOhecRdMIZh5c2TsJchbXj9cNvgOhovhzaI56aWov1djk3ycCxs+SLpcrf/wDjb3J7KqZBiL1VvQygkpKc3AxB0s0ZpDW+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Bc4COO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Bc4COO"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dd6c160eaaso70683741fa.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488650; x=1715093450; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H7Xbh7xvbWqnFCaBEkdEhf/rm8++L7PCvRxJAnDm5Lk=;
        b=O4Bc4COOfBNVe8z8qyjqHVlDWo3nfV+maV7a4qMhMXHy8MbFhakBX6iWxAwtA/ZAvT
         BuKjkrmEv9GQj0Wh/3zbURLudCZxBVwEWPQwmsbh52+ygtAom7bwtHmdv5DeC5YD6GRm
         TZDUy6a+AJHeAsxu9Gy9upgw7IPh+kbf4QLozA2S5Q32UKmrzxQnE7POfhTAEGOM767Q
         srMWg+tf6xkw5Pd57Ty5zK5K70yOQD/k6QvUlkOVPbH/yOtCZb8mhVcQQbPvGjm3+Emn
         MlZyzfGMbBEPZBcs6NsVWFTIJQiJq5HCsi25nVZpGbGCWMJt2BodMU9Hu3dh3uFegD0M
         axjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488650; x=1715093450;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Xbh7xvbWqnFCaBEkdEhf/rm8++L7PCvRxJAnDm5Lk=;
        b=dWTX/T+0GnOz8S6vntFtwxlMMT328Xg7joiQyUgGwJWkTo2HiLknB3ii5/t1Pmt1Wr
         P0jLB5du0H9xvUHNXUBJqlCaLuEitp06h9UrxPn6dp9SEoqxLFoldjmweD4RumAE1wG3
         vz3n0jaGEGK7ZDG79wkF7GbAQHfDhYPieoghFoHJWMZ2b2iykSLnGiePwiikZiTDBOju
         KRgjb7oT4OShhDOeGynHpC8NWXAyvTk1tjT5bkovQteRxJ5I81I2OWebJZ30PD5oEWP4
         VEmmQOpWIJJieAf6AeDLlg9oNneLQ8uWjZmZwlYiCwFT401Ad86ULz7R4Jwjbf0/g3c8
         7ZKg==
X-Gm-Message-State: AOJu0Yz8Ww6zU/fphzrzgXuAl6cZgOCSRppB4Vk4HYnlLuWGh2GBYoyy
	PG+SaB0aWy3hQanouyI6IiQu/nYdtAbBW8g9HezM/eA48RsLhsTP31yBIA==
X-Google-Smtp-Source: AGHT+IGBKszqEsAj+Pjcp6HP8ydLBTBMy+6+JfFdYOyvY2ZzGHEIFl3qq6GAo0A386GE1brxba/Vdw==
X-Received: by 2002:a2e:99ca:0:b0:2df:4870:4477 with SMTP id l10-20020a2e99ca000000b002df48704477mr11375458ljj.14.1714488649463;
        Tue, 30 Apr 2024 07:50:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm11198977wms.27.2024.04.30.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 07:50:49 -0700 (PDT)
Message-Id: <pull.1716.git.git.1714488648294.gitgitgadget@gmail.com>
From: "Ivan Tse via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Apr 2024 14:50:47 +0000
Subject: [PATCH] refs: return conflict error when checking packed refs
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
Cc: Ivan Tse <ivan.tse1@gmail.com>,
    Ivan Tse <ivan.tse1@gmail.com>

From: Ivan Tse <ivan.tse1@gmail.com>

The TRANSACTION_NAME_CONFLICT error code refers to a failure to create a
ref due to a name conflict with another ref. An example of this is a
directory/file conflict such as ref names A/B and A.

"git fetch" uses this error code to more accurately describe the error
by recommending to the user that they try running "git remote prune" to
remove any old refs that are deleted by the remote which would clear up
any directory/file conflicts.

This helpful error message is not displayed when the conflicted ref is
stored in packed refs. This change fixes this by ensuring error return
code consistency in `lock_raw_ref`.

Signed-off-by: Ivan Tse <ivan.tse1@gmail.com>
---
    refs: return conflict error when checking packed refs
    
    I wanted to provide extra context around the error message I'm referring
    to so it's clear what I'm trying to achieve.
    
    First, let's get into a directory/file conflict situation:
    
    git branch dir_file_conflict
    git push origin dir_file_conflict
    git update-ref -d refs/remotes/origin/dir_file_conflict
    git update-ref -d refs/heads/dir_file_conflict
    git update-ref refs/remotes/origin/dir_file_conflict/file master
    
    
    From above, the remote origin has a dir_file_conflict ref name and the
    local repository has a dir_file_conflict/file ref name for the remote.
    This situation can occur if dir_file_conflict/file used to exist and but
    was later deleted in the remote.
    
    Then when we git fetch:
    
    yolo10[master] $ git fetch
    error: cannot lock ref 'refs/remotes/origin/dir_file_conflict': 'refs/remotes/origin/dir_file_conflict/file' exists; cannot create 'refs/remotes/origin/dir_file_conflict'
    From github.com:ivantsepp/yolo10
     ! [new branch]      dir_file_conflict -> origin/dir_file_conflict  (unable to update local ref)
    error: some local refs could not be updated; try running
     'git remote prune origin' to remove any old, conflicting branches
    
    
    We get the helpful error message to run git remote prune origin to
    remove old, conflicting branches.
    
    However, when the ref is stored in packed refs:
    
    yolo10[master] $ git pack-refs --all
    yolo10[master] $ git fetch
    error: cannot lock ref 'refs/remotes/origin/dir_file_conflict': 'refs/remotes/origin/dir_file_conflict/file' exists; cannot create 'refs/remotes/origin/dir_file_conflict'
    From github.com:ivantsepp/yolo10
     ! [new branch]      dir_file_conflict -> origin/dir_file_conflict  (unable to update local ref)
    
    
    The helpful message is not there! I believe this error message should
    show up regardless of how the ref is stored (loose vs packed-refs). I
    attempted to track down the necessary change to make this happen and it
    seems like a straightforward change. I hope I didn't overlook anything!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1716%2Fivantsepp%2Freturn_name_conflict_error_for_packed_refs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1716/ivantsepp/return_name_conflict_error_for_packed_refs-v1
Pull-Request: https://github.com/git/git/pull/1716

 refs/files-backend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea00..97473f377d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, NULL, err))
+				    extras, NULL, err)) {
+			ret = TRANSACTION_NAME_CONFLICT;
 			goto error_return;
+		}
 	}
 
 	ret = 0;

base-commit: 786a3e4b8d754d2b14b1208b98eeb0a554ef19a8
-- 
gitgitgadget

Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159EF20E71D
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754693559; cv=none; b=MCg2ivJ9sDzMYWzzCWbXF9jTTvr0SZ0adlvs/idwveG6HarOLChwAmVXWYhgfUMy1IZgm+AD8ZK2sN8PEJLDIKpjcch59qpYSvRh1+S3kIfGO6ytHlOkU4NysEP8vciFc02uDYewnqnwgShpudaILVpn0MVZfIjodYUWgEhbJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754693559; c=relaxed/simple;
	bh=xl+dV4iFV8i4mxBtmm9C26PjL7rbvJkzoJHhCBigYys=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SJ0VYei70rhxRrr7BhtGNRzxTMb1VPxe33VJudy3qjfX1/n5fxtjdpWz0erTymTLe7FYCpiiJDT8Fk0w/LDRfm6CHUJiXc8ClR9tztuGChMND0GOYyMSXZWOwybMXd1hzQ9xGRwc9dDpSUzEdDDinzueab9Qyb2wC/2oWlx8aDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYHmAaJP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYHmAaJP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e794b331so16574855e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754693556; x=1755298356; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXHDoiIK5bO+424aEKX0ocmutw7x0EOE1OCtaoqUbDk=;
        b=eYHmAaJPPiEHhn/wuc9TvpAqCNQLnRC4jrOEuRbrzd/JQ5TLcZ1vaIYDmUHHHZj2Vo
         Ce3BSHvVtkp17YnykgYfjjdqnoVt/IN8VcOHV/K0Q+k+tlFiTo7P4wPkmzweNtkqOVTa
         eESO9eiWCxRZ9Gbt5F7YO/x49N7PjWFmtOAfTdwwpUgC3xoM7lOZwLSoKQr/qgPbTXiD
         4ZWPDjtz+It6lUDWxvoQyYiHBsyG2iA/I3966b03MJX/3bQfzBo4hbwfQfftVw54JXy8
         xf9sQ6/zHK/XQurKbQlOfnYhl3qUzkFmpDSz0OM4M9IJHsaBxURep3cdqRdztDL85Ixn
         OrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754693556; x=1755298356;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXHDoiIK5bO+424aEKX0ocmutw7x0EOE1OCtaoqUbDk=;
        b=UvN1MV6U4jVXBoymcr3jj+KlNlrXrpXz3Egr1Pb9XqxmX+DW0OTKrJ0dNtVGrZCTvk
         lZCtA1be8FHghHvrILcAsN60FsJo7na0j46Il4V6w4yDMFwN3mnJWg8XynYB5iT6FZLH
         P2JAfflpv1wXN3Y1OuO+gYxzyWUTQzKmPb8AdJCYG2ndaQ4GWUdpYfkr15bhum9q0wI2
         Zv2mbg1MTjNQIGgCEtO7hY2y0PEEwLwYA11sOwtuOEBNDG8kqJOKnBo6phDfo4nKYK7r
         fprA2bA2KLF6FGdknR1BAJ3NHwwy729952kdUX63EZ+XwndMfs83S3gV38MWF1TW76lJ
         +zGw==
X-Gm-Message-State: AOJu0YxWrJ6fd19qRN0rBs0ayHvti9k03BXiP1b6hOf1Erge6xL5KjVt
	xxJpIU/asGg+cIFfJ9KjowNavLci3sG9Mj0+PWUuZeYupY9FOK6S4n961fz6Pw==
X-Gm-Gg: ASbGncvi5mXoNdwrYycd1WgCjIE77oXhcdcRlieDuEH3F4lkM/xHXpXmDKvya2cUdCp
	rywWM6SDbWbwjkXTVJCv+U/VfVPJdCDHpY/31QHfaTLP+I4FlRE3SppL581ZKj9u4KAmyW553q9
	Ww+5666crFqo/dPFUp2OBDrZWGHLg/wK6pSDOzDRUKDJBRp4b6H8x7vzF4Xksek8BXwIq9oqQWT
	ABJ2qJAfh0AHjHnLf00xiJi8cRscbSKZNT+yxhh358Q5zRX3tSu5fAQbpx/UheORZTzfzMl2Z3G
	PYD/MY0JjHKONw6S2CgbhvYLagmONo394UqEV5dl83fkI8zat1A+x+tY8jb7aot3vMtB7e70SUb
	Zp8sOw9i8WHHLgjwuujXJ+yozCZy00S6Opg==
X-Google-Smtp-Source: AGHT+IGuJeoG1m6Bs5A29XZNL6GKEpw5MCwE+kfVRS0/ZYt2V4NU1Zkp1dJ7mx2b7inW707HYbBp3g==
X-Received: by 2002:a05:600c:35c1:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-459fc0de784mr5377505e9.0.1754693555819;
        Fri, 08 Aug 2025 15:52:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459fb43b491sm17102165e9.3.2025.08.08.15.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:52:35 -0700 (PDT)
Message-Id: <249a5127904f2d73119f3b60d70a57fe84d1b4ad.1754693552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
References: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 22:52:29 +0000
Subject: [PATCH v3 2/5] doc: git rebase: dedup merge conflict discussion
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Previously there were two explanations, this combines them both into a
single explanation.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 50 +++++++++++++++--------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6dacf693bd71..a93c616f38b1 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -39,6 +39,27 @@ short-cut for `git switch topic && git rebase master`.
     D---E---F---G master
 ------------
 
+If there is a merge conflict during this process, `git rebase` will stop at the
+first problematic commit and leave conflict markers. If this happens, you can do
+one of these things:
+
+1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
+   and make edits to resolve the conflict. For each file you edit, you need to
+   tell Git that the conflict has been resolved. You can mark the conflict as
+   resolved with  `git add <filename>`. After resolving all of the conflicts,
+   you can continue the rebasing process with
+
+   git rebase --continue
+
+2. Stop the `git rebase` and return your branch to its original state with
+
+   git rebase --abort
+
+3. Skip the commit that caused the merge conflict with
+
+   git rebase --skip
+
+
 If `<branch>` is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
@@ -74,13 +95,6 @@ any commits in `HEAD` which introduce the same textual changes as a commit
 in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
 with a different commit message or timestamp will be skipped).
 
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run `git rebase --continue`.  Another option is to bypass the commit
-that caused the merge failure with `git rebase --skip`.  To check out the
-original `<branch>` and remove the `.git/rebase-apply` working files, use
-the command `git rebase --abort` instead.
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
@@ -183,28 +197,6 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the `<upstream>`
 parameter can be any valid commit-ish.
 
-In case of conflict, `git rebase` will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use `git diff` to locate
-the markers (<<<<<<) and make edits to resolve the conflict.  For each
-file you edit, you need to tell Git that the conflict has been resolved,
-typically this would be done with
-
-
-    git add <filename>
-
-
-After resolving the conflict manually and updating the index with the
-desired resolution, you can continue the rebasing process with
-
-
-    git rebase --continue
-
-
-Alternatively, you can undo the 'git rebase' with
-
-
-    git rebase --abort
-
 MODE OPTIONS
 ------------
 
-- 
gitgitgadget


Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D813247F
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983577; cv=none; b=DdkB6bxZAxC/EPBTeUkYx9wsfkXrVaVxcZeneijkwmmCNUtA2nhPt+YEacoHbOVpTjuvz2t32QfBqvFdCPct1Rl33bEQyQhRVrdGN+ak1Q026ypShnCAwAWhoQUyDmndZzzCfaFp8QbcVNhUPeWLF2mhEiNAue9VPTX4ybsakcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983577; c=relaxed/simple;
	bh=TLO66AmtwOfz78Qj2Kmaqv4Xx+maiMtu19gsi7os7ok=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XN8vgn/sw+kdny36aYyUAzzd83bRMJN6FCPT7o04jfdJDJgKDsCyjEsOceEkpLfRP3CJVP4WfAFMJuL+wCBOlRx66tZKpr32fTp+oLRBtdNidBBlF15X6LNOa4dsPwJWwfg9Txb8difQw1CSIc5iXpmNCLkn1cizKILpALw3Zj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcwlE4gT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcwlE4gT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412a882bd4eso7092185e9.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708983574; x=1709588374; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs333r5DxvVPPz6UqCmXUFq4KneCc8JolM5Vs8rcq5A=;
        b=TcwlE4gT1g6hMOG6xwLVJP54JMeMDI9aNVjkhuYLTe3hZo+sP/GYS4i6bTdDAY5mso
         mZt/9antCqUaxCa7/PWj+C4mhJhrcQlyERZMmcdaD59ZYXy9OI2wiVzTobbX9EZSNVJU
         CS2wXOIheBKJxQjNJNVwVySf43tXHs1JO5pKWXljMt0Q7CESeko6v4AnLZYyHMZkKnrY
         6fNb4ZdzHVhelBSh0VMsrIk94jH3KsB9+Vo0ZIjylc3SvMhDtA91RjsD19tmJXVKfDzj
         6i0k0sdsLe0j8NWC4yXxBb1QC/hY0h8CmJoq/7X5SyJcND3zs0SiL/WU76xEIki3nBc7
         Spqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708983574; x=1709588374;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs333r5DxvVPPz6UqCmXUFq4KneCc8JolM5Vs8rcq5A=;
        b=shI4QRboPjOL+wSaeNOkZo1bfWkTXuWhDoJrJJS3pmhVbUAKuUmqMjD63BEEQVt7dA
         mtQ7LuYOIwr+9KFthmYn09NonGjnTVGTjtHFLfNrnLz2qIGFR3tbgpchneBVleZOevgO
         Ag1SYP9oBAdgBhgXY9s+IY+IFCRRwGLk5h0JC5MRY+IEadIpbg2QRENAG9sQ23o49/q/
         oZIK7lHhO2OzuuwTCeOSMlAly0wyZINS0XTfOIshkh01kQ4lgz3BiUYU+qryBv2vOvzu
         zGvt87ddVhukR2bISvHui5BqKy/9DslH/JWGcV03/PyTNQBtkisbiGxWYQu9RPUtE2Eg
         G7jQ==
X-Gm-Message-State: AOJu0YxiLeyj3cJmFm3MLKIrRS8xrdI/qcuoD+xkTB62enr7DGNZD391
	ffjZk+tNIctty1l7JlHYJ9cuYjVbbkrNrSc5l1uHO6bi+TkqSrcYxV9ZTx+T
X-Google-Smtp-Source: AGHT+IFtGrk8Wx7sctBhX5atSg4Cpk2IYUoVCJHmLRUuTHBzabMNAQjn8+JGLN6M36Bd19fW6rqQIA==
X-Received: by 2002:a05:600c:35d1:b0:412:a927:a646 with SMTP id r17-20020a05600c35d100b00412a927a646mr1285957wmq.24.1708983574125;
        Mon, 26 Feb 2024 13:39:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c028a00b004122aba0008sm9221155wmk.11.2024.02.26.13.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:39:33 -0800 (PST)
Message-ID: <6e87ea6deafdb5f26e66925c5869d78c967af2dc.1708983566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Feb 2024 21:39:19 +0000
Subject: [PATCH v3 08/14] fsmonitor: move untracked-cache invalidation into
 helper functions
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
    Jeff Hostetler <git@jeffhostetler.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Move the call to invalidate the untracked-cache for the FSEvent
pathname into the two helper functions.

In a later commit in this series, we will call these helpers
from other contexts and it safer to include the UC invalidation
in the helpers than to remember to also add it to each helper
call-site.

This has the side-effect of invalidating the UC *before* we
invalidate the ce_flags in the cache-entry.  These activities
are independent and do not affect each other.  Also, by doing
the UC work first, we can avoid worrying about "early returns"
or the need for the usual "goto the end" in each of the
handler functions.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 2787f7ca5d1..2f58ee2fe5a 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -188,6 +188,16 @@ static void handle_path_without_trailing_slash(
 {
 	int i;
 
+	/*
+	 * Mark the untracked cache dirty for this path (regardless of
+	 * whether or not we find an exact match for it in the index).
+	 * Since the path is unqualified (no trailing slash hint in the
+	 * FSEvent), it may refer to a file or directory. So we should
+	 * not assume one or the other and should always let the untracked
+	 * cache decide what needs to invalidated.
+	 */
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
+
 	if (pos >= 0) {
 		/*
 		 * We have an exact match for this path and can just
@@ -249,6 +259,15 @@ static void handle_path_with_trailing_slash(
 {
 	int i;
 
+	/*
+	 * Mark the untracked cache dirty for this directory path
+	 * (regardless of whether or not we find an exact match for it
+	 * in the index or find it to be proper prefix of one or more
+	 * files in the index), since the FSEvent is hinting that
+	 * there may be changes on or within the directory.
+	 */
+	untracked_cache_invalidate_trimmed_path(istate, name, 0);
+
 	if (pos < 0)
 		pos = -pos - 1;
 
@@ -274,13 +293,6 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 	} else {
 		handle_path_without_trailing_slash(istate, name, pos);
 	}
-
-	/*
-	 * Mark the untracked cache dirty even if it wasn't found in the index
-	 * as it could be a new untracked file.  (Let the untracked cache
-	 * layer silently deal with any trailing slash.)
-	 */
-	untracked_cache_invalidate_trimmed_path(istate, name, 0);
 }
 
 /*
-- 
gitgitgadget


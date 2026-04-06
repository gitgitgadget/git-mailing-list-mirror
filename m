Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A47393DDD
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498106; cv=none; b=EsrhYk9MQQKosaUYOKaIVXv7BrxfyN6W0ruTcg/NApVWKFSrpySZtqKOyFH9bEH0CVdBFzWrlGCP1wvfHSPN6Jj7pbWQVqvLDkmttocmsJN9j2XNoMo8DTCkZ9znKUNyVdKBDR613u54w56hwe6yvKgZy+ofBJPPDdqDKkVsMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498106; c=relaxed/simple;
	bh=dgzktmB3UZefBssaL2ZSgY5M3yNRYA/erR3TfVJjNYM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SS2bJ1nrRlJUxl21zcqAcu365Lay2XXMUc2OxHGRSKo9y6V/6ML6vTTxeyTWhdAycFAI5oFqP8D81PXLdHLEB2o1Dq7IbI3HAg5Zp60v09PINJnkRB5BOvQCqWDbrvzO2nsvJl6ntaTiSu8SD4H+KGJ2yJvEKEackElli9ci+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBd5SN0g; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBd5SN0g"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4514716eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498104; x=1776102904; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=FBd5SN0gISM2sSVYsm0ULAEjYdUjwXiUhE4xTQRBE6SXc0FBjAWUNTPBlUSIjch5ZD
         mVJOsclH2uuV/gpC8O0WyZjyFQsSpEAFrpEZOGj4xusNUheg5Ud3dSs832foKx8E/024
         24UjQ/17or42PzxN6yQGiPXUIQNTdoRugZILRfTaq/EUNjz6pp/6emv1hkJohd5o4HGe
         JpMH9Akv00f2jd8SZpM7Vd4TJ8L1DWgGzyEMeweswgyv7jrYgiFYdDNWMNw2b9stecg8
         BnSB5tCnl5QP8LSp2C2BB1u5e0PUvsNOBSkZQkguwjBbFO9qv45tYBKRL0QYhi1Jcb6C
         Y/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498104; x=1776102904;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yRyfUm958Q8U3QnlqMYhczOEnpYrJIU0IcFDG9fhFE=;
        b=FRN5IOZTKcv6zagzNVlnEWJPhzr3vzae0KVplijjQSP7oCFxExMVor5t37YNgjeVM0
         mH5q6i8ssLISDAOsy+bwi7RD2TFDeHhEMFSAvP6qPXPgeVRVvzwG5HRIWqREMBGkKKLh
         Cu6V/QMNurVBTQT0UZzbDBm+xIbFUEpjpbzl8IZXBINMHR+V6xjgh5zGNv7D/KNPEUzP
         j2lLTVIs/1oYDQjuEiAUZfCOYuwXS7r5DLQflKxI0obIGnZmGkE7ijPgp4G9dCARLpdD
         iDx7Jy/YRdxrSem97sd7F639D63UdLm7GdeOi4QOKaDJxgQ+EWQNaTQo3M56m6bGHqdT
         0oPQ==
X-Gm-Message-State: AOJu0YycCXi5NPX6rjWmNMkI5+b1lS7U9NYYSIbV94wZhb+abV64pIKH
	EQP9D3sARZZ6KCz8m4kJ+YjAqiou/RYsvv+yhEN7Y/d1xj3Msr7BCK+fm15/3A==
X-Gm-Gg: AeBDievqIRY1KqROZJ07QeQJsrXSXlwx4v4zPvlPy1ls3ESf6fMKIgIF5IEEMDtJmCB
	EESzlS9Qhvsqv/zpJHhfVEZCTvUvkvH+67EGXGD2Z7TjnIv5vS+6sN3i3xHFrpdocutsDHXysYU
	0Q+M3tFUocG0JiWMUTt1UsyEn/+x6cBAtcP5sTUpCfgoB61JBbJVuYWNDx5xmpn+0IV5moPfc0w
	MyZ8CyP6dOx1yQVeRknU8tj4KNo8YcSuosrIQasOrT/tx7zifG3ey6JU86kztbSfGtIuPdy4hLp
	re+DUZq3t1Nfk7ZsU0flGdzpYtbyuPnE57MffQXSmskJE5rGK4pju0TdSa6zF6qOxUWc/1UCnQx
	wQT6GU73Uuc0o3aCeJDbIlg5IloqjDlWQLW2NjJdsy2x5X5BZtmyO2NxFon35xi3/AuCYbIZk3h
	wF5AQCobm4EJ5Jl7iRIDbh/sEP0QE=
X-Received: by 2002:a05:7300:f190:b0:2c4:acef:292a with SMTP id 5a478bee46e88-2cbf9fe3614mr6848100eec.12.1775498104129;
        Mon, 06 Apr 2026 10:55:04 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d16d115c00sm39338eec.12.2026.04.06.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:03 -0700 (PDT)
Message-Id: <a4a65a6dfaf702af7db34fda6012a5fe024cb1b6.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:48 +0000
Subject: [PATCH v13 03/13] fsmonitor: fix hashmap memory leak in
 fsmonitor_run_daemon
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
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The `state.cookies` hashmap is initialized during daemon startup but
never freed during cleanup in the `done:` label of
fsmonitor_run_daemon().  The cookie entries also have names allocated
via strbuf_detach() that must be freed individually.

Iterate the hashmap to free each cookie name, then call
hashmap_clear_and_free() to release the entries and table.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index bc4571938c..d8d32b01ef 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1404,6 +1404,15 @@ static int fsmonitor_run_daemon(void)
 done:
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
+	{
+		struct hashmap_iter iter;
+		struct fsmonitor_cookie_item *cookie;
+
+		hashmap_for_each_entry(&state.cookies, &iter, cookie, entry)
+			free(cookie->name);
+		hashmap_clear_and_free(&state.cookies,
+				       struct fsmonitor_cookie_item, entry);
+	}
 	fsm_listen__dtor(&state);
 	fsm_health__dtor(&state);
 
-- 
gitgitgadget


Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B13BC68F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219041; cv=none; b=cXSfo9/HU0aar41zlhsG4nwa7JssSsjIIiPyBIi6W7XdZMF5kXsmj/Gks+U6WfAfqHM6FHeD3uSBq1/+CWjdYXWKocUTTe44qlQ9rv5gF4agEgvblx8c97fvX9Z/K3dJKbLwBWv/bX+SjLhkSEtZt0p/na/dbUSyWrTcO4Qx7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219041; c=relaxed/simple;
	bh=QaSjG5wlQGvCiy3XQPvBK8ULKqCVyPO6Bhg5M0nV9QU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kxyMdTNuMx57HQfXPHGkMF1SpSjcKen/DJ+DAo+Jm+6xxwnHRV6lV9Eykdpi2ApEMspdO7zXOOnHj+l1BkiIBhJklZdkXImK49MqiCItadLjj/hazgDfKzEOi1E2iQN22dW3b9Ug2Ih0cBgZenp2TeoEIoWDnjm/dc2//MSrxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISzVrB8Q; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISzVrB8Q"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89a1c6dd788so127873886d6.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219034; x=1773823834; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=ISzVrB8QlK0SxFUC7I66oLXH9Vvb96u59KfRl+JJxGHIpjDkDPA7buzjVFTrfYEQ84
         RdPuTptNDH0cXtFlLbiwwwtvdjbrnkGOmJlY4XJrj1m+yHryswGUeU/gZmBWavFJ75ff
         7Q5Xps+1pOYH+Q28Dnfucg2FqdhOOU6XjxlF6AbIqVj0zw3TI+VDw30aTxF55LwtFH5K
         enwKVZqQyhkexOGHgQjx1IuMTprwglilFNFJn4tgpQQ5iOkhOLyA3kfny/mo6FYoqoEa
         twTliIiddxh/Fm3WKCwneUiPtFhuakUya5LopxF4cg28UKFFaNqj6qnQ73wz+Ey3aU9c
         oC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219034; x=1773823834;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=ak7T+m91/IFWYuJkV05/qZ7DEE8UszeqHvkAr1Q1yrf+qMtDOvDVca6KkiWrgLoC1+
         7rSh15b6tLU8B1hInY4Wr/ElolsxtZANc3J8ILL5xUqj1i4B82h9VQeEeyb/R14uErbw
         4ZhX6o/fJyEFtGERPyhTBGsSdt76CFhoU+r8PzIuIFkdW9GBuRfx1EsIHV3TQ6zpGe0E
         3p6jxQUT5WQmx1quR0ffjd+/0f42QI1rI41SAhS58iiXfe4tOdrnash2zWa8Q3uaN9cg
         gqHrtFfN2gx5yA4peR3wzQo3tJzHAdSapnH1GPMzk35EIoYCarqRUki+7FWFKm5r9+TR
         Tbfg==
X-Gm-Message-State: AOJu0Yyp/zD5MecJ0ljbNN2nN0Epc5/xyMw5JuZ+phw8b+WNad0OqieE
	0PQFzrdk3XaE+XioeHEUGcI+vNks3Wz/C0xi2Ckhg+GnJG/v1vWiSCVTEVt34RZ9
X-Gm-Gg: ATEYQzzDisfxd9EeAk0yaIUz/nzKuQDDcw2z9BySo257DNZTG5y9QSnhqc+pBWWsQpY
	lJNhZPOxwEOpS2VnqWFFa+5cKTuXke0KVK/x8TlB3G+JGLJzV/Z+xaRkTn5QfgS6FDhV+Z/6auB
	L6wssUuoujPmomBQFCOebQnLEL4GHOlk/lTw6/cb2rS27dkvLidaok26GCMRm/PgvRsVqpw4DL0
	UZvg5NvreDkFod6HgThe6i+IrX2p9Tx4uNuHQhYSBlJbX9lkZ4cy0zR5u6SoZpcB7Q2V+QeKHyE
	7vl8rCzDchKjYXVJcChc92hE4k1wH1/SDsI5y4+qb80RlOYSDFQSOVa3sGt2W89tpRXFk655Lny
	RYg3jE2c2dN9hXco8RTlD2BNLPewaisWOmcbbffHRoNyTt2eoYCCkgyf9ZC3lrlm1YX1+mYfzQK
	dYXXU3CLUZsea6My5H2TD922rGVmW88Mmlhw==
X-Received: by 2002:ad4:5de5:0:b0:89a:181a:80bf with SMTP id 6a1803df08f44-89a66b672bfmr19253206d6.54.1773219034126;
        Wed, 11 Mar 2026 01:50:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bea06dsm10046316d6.12.2026.03.11.01.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:33 -0700 (PDT)
Message-Id: <e88c85170147a7c5d44640cba0c48aa686e23f17.1773219028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:25 +0000
Subject: [PATCH v4 2/5] advice: add stashBeforeCheckout advice for dirty
 branch switches [GSOC]
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

The advice suggests using "git checkout -m" to carry local changes
over to the new branch in a single step.

The advice can be silenced with:

  git config set advice.stashBeforeCheckout false

Changes:
- advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value
- advice.c: add "stashBeforeCheckout" to advice_setting[] and implement
  advise_on_checkout_dirty_files() function
- Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 advice.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/advice.c b/advice.c
index e1264f525c..ba290d3760 100644
--- a/advice.c
+++ b/advice.c
@@ -327,15 +327,8 @@ void advise_on_checkout_dirty_files(struct string_list *file_list)
 	fprintf(stderr, "\t%s\n", item->string);
 
     advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
-		      _("You can save your local changes before switching by running:\n"
+		      _("To carry your local changes over to the new branch, use:\n"
 			"\n"
-			"\tgit stash push\n"
-			"\n"
-			"Then restore them after switching with:\n"
-			"\n"
-			"\tgit stash pop\n"
-			"\n"
-			"Or to discard your local changes, use:\n"
-			"\n"
-			"\tgit checkout -- <file>"));
+			"\tgit checkout -m <branch>\n"
+			));
 }
-- 
gitgitgadget


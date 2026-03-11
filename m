Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4754C30EF8F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251376; cv=none; b=b+sj2jlQ/Uj+CPNOzmZZatf/Z0Z4Lo6Xqhsw0rzPF9WuaeN1+bWDZQnYt0E5AOzZ3DF1sPofJkPqrEGk3jBRxQcqOpBaTTQok6hev8okA+6zHDn4sUeXBLpfAlQSkR+HAQ7V8Fofl7rGPcZp/6iFqTBGdKTapZqXoLFBy4TlSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251376; c=relaxed/simple;
	bh=QaSjG5wlQGvCiy3XQPvBK8ULKqCVyPO6Bhg5M0nV9QU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pTWZxBc3lbPzOA5ftEwkTGf/vSxuLghmd+SfNdXL/zI02f2T77Fy12D7T4COIQYrdw1Atz1DB7DXxjuctMfgs+oMe7hVKD228R3kj+ebTRzQJgDPtxGgDWsQye16ImHjxH3zgtyehT/bwy33CRZS/BbGOFYgVKUCZ6ZPPd6ecv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3F/x3G9; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3F/x3G9"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso284783c88.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251374; x=1773856174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=S3F/x3G9bWE+xZg9GdwkMLlnKATGWXj7Sy+H4B/fSNO3ptsrEMwc5mTNfrf5CMdGLN
         NOqWXxlQqSvqjH9KsJmhrBnN8hP3pmXTTGWx8cWDcU/p+7ohVCQtNoGms4aFJI736Z1U
         NT4sgvyMgjC/gfFxu4SyIthZz8zTkh89uSzJv9p4M88otesu83krGBE0w8MPqPokrSuD
         V4b7d3Yt9JhhZhCDoOX0kGk1J25ziv9F4UPZxiAMgZJ4xAKBKN4617fIlkWPk7XU5wfZ
         567fwVsjIr376NILpQNAfNOxDpGgaEP9tqztMZyZLkQCo7OugEFe5i9VBfu5FljgT3zb
         2RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251374; x=1773856174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRc7mbu5XmqgvaDQuOR1X/J9MYqgqeoPrHMAK1oJUv0=;
        b=NroaL1J9WfcNZEI3oO4ogUZIk46d+jBP9uLh1ocXJYU63CkDqGQWwcu+0lwJIypEmM
         EajX3ZpBgr+EZ+d7F3UjyPpLRt5VsqeEa39alSpBoQOGCjaixDeh5tkZIwJx58R+L7Yk
         CTvMDNpKMCvyZrGLxejbDo2hFWgLvggiYpwB/gnERUW08BLrWhBVQm/xjD2ap6z/3E24
         aUKibirTLuGMDXG0Zyr4Cp+31I08sdkbSBOGg3YIK5pR4I3Yp9ZDQU1XE+3tVrd4IIGy
         0+R1JXGck/FFQo/9ajXxxIZA4DFd/+Poa+DO256G9vnCRXU/DZzcf1yzyn3TFcWWQzza
         gWiA==
X-Gm-Message-State: AOJu0YzyX/f9w992f7ImqqghCO3tmkAXEdZD4fBBruQr7C5e95f3miAh
	Rw1EuxAeydB/cDoUZ38N8iFqbX6x0sYntwMw4jBwFnj0UMx7gzit5VwX8klbQEbn
X-Gm-Gg: ATEYQzzW4KAA+xfBuYjvumEW5IP2h1ekMvmSvNdFpdDZHGYrYpbOTgoTHO/WfFJY7AZ
	uXx6wt13mxJWbEekEy81tCLcd2JSaoeP0O5VRwBVPMBkRr5Hd0IXH7TFckyo1Jqy3iux98JRqf0
	pMjr8ZoSu+1af/TUDr3+CXANb7UoHf0nP3Nb4BB5c5EMPwIHs6u82XwW3L+MUkw4SxxCP+S7Hbv
	Z/IrvRcDCvHVj7qlLTgd7nox/dKokmcy8dodVovJdLD7jt+T1kg2fz/j9TKOIwciI1hIdTx09RG
	06O9vLjocfCeInoA7+bI8eAQ1JHbm2Jh48ky2gBSKG5m0Dl5m2hMayRfW6hvWicJVP29ARqXC5e
	RYsRvGPb0f755T0qIWETF016d2aBniVJ+vVeSKfLqeZqQYHxit+C/KLVYvyMqak0xCB9mwPRdhM
	op6X3OhSPOHNCegDR5T8n+8An8St8=
X-Received: by 2002:a05:7300:a987:b0:2be:140c:bc4a with SMTP id 5a478bee46e88-2be8a25d229mr1475331eec.3.1773251373465;
        Wed, 11 Mar 2026 10:49:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.192.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa97dcfsm3240062eec.33.2026.03.11.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:49:32 -0700 (PDT)
Message-Id: <e88c85170147a7c5d44640cba0c48aa686e23f17.1773251369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
	<pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 17:49:28 +0000
Subject: [PATCH v5 2/3] advice: add stashBeforeCheckout advice for dirty
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


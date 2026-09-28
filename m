Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B44E650
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790589114; cv=none; b=Xzo6aODtITTXY2KSh3d++cOeLwT5aYz5AUd+e7VbBSsh82uDbbqN/rQEgdz5KVCkjtV/tHcV+8zUbU9Y/105d8G/YxalmjZ6h9D2ajvnmtnpIr9oTT4lAX9V8Wuz4NuMC51v7nHyBpK1kkOrC031RSVAzPsNs8VUZNn4kNdv4UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790589114; c=relaxed/simple;
	bh=aeNal+IdUz617whKfBA2PtI6Cxe3jcIa20Ir5ZNC66k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZXJ0UtK1lZ6aNr9aypb8J+Ct6GunFbKWoM98TshcJtSZioAAc+M50WO1OvNRwW2HNFH7w+u0daJt0Y73m+vlDuZ5n3Glwticf7XajfW8cu0jfIxFY1CmKNrungiZDSigVen2d2jmT9RiWEPczwNzlZOMf+GufoRt2h6BxQjMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yJfVnvnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=myZME1WD; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yJfVnvnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="myZME1WD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AFA3140005B;
	Mon, 28 Sep 2026 05:51:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 05:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790589112;
	 x=1790675512; bh=qnB7KVWtTvmnBA/Xklrq81IhEvnh0vrDUdsr6OVOYr0=; b=
	yJfVnvnM9rS3hCBnbmvZsGKa/WwbcdRX66+AGpJc5B0ScWZambj4n036wn3MZx0u
	X2yKQ8v8leLhheupg9h2XM8o6dT/iY1qbQzo+MyGfeN4JprYDYdGtOyjY1FmvJvo
	2Ck1fCOqyC48FOnAYoScbK2gb78Mqwk1QV3kq7O8WoiJg/5TPbr2lkOyQpcd37vG
	NifN28d8dmJ1ALpy0h7g1QpO9GCKHl8g2t2ahx568qDM6VZMreYxkPHmVS34GqIm
	8XLKDoOH5mA2T3yBEtWd3mRUQjXgU9mTg3fui+Qi56sR+NOpZwDG6fsW/TENEXbh
	zKUyUGkH4AuMm7/gBJyKKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790589112; x=
	1790675512; bh=qnB7KVWtTvmnBA/Xklrq81IhEvnh0vrDUdsr6OVOYr0=; b=m
	yZME1WDqzdpjsIz3tobrvyqJRmRfNvHZudF/5k3hIs9y9gCyU54+R1zwVtSknEY3
	okSFmFCZ9J/38EblbUkefGTFXD2KcNdDU8WrYkMk0fbgYp2l8k2ClCu6H+9/SMeL
	2xmNc2ZXu7jPTM7qn/CUbqqKR/CUWGj4NN2R5bB5U2QtZg9AF/9N6l+8z/o4vSgw
	IT4sJIbW7eBbiQluxBhj9oIgAj/6liuk9hgpq4CyxDvBuYoh6n1CqEHzJOkmDKy7
	uYC1E6Yy0UqW+MmC/DRS6h0SA8+7O+HV9j9BWWX57IV4JCAt9O9iAc57wFvB6+NH
	YyWE0d6fiTAaQwv/R+hCw==
X-ME-Sender: <xms:uDi6akN0aznO_JfyVUHMW8EqthhdXfdlaOk2V0hgc73F6uQt9D-lHQ>
    <xme:uDi6aiaqyva_7YByHJ6gLWPn7yFYJ4OwqkXIf9gcwt27pY9AjwmSM_YYzTKFfzyfp
    Zz6Ml_6w8Fe-ILNekJiKd_NH27-JKjkrJWbd4xoZ4Ky_gQClseNTZ0>
X-ME-Received: <xmr:uDi6aoqerix7faxJM0-A9ITRygk3FcePIIFwcFWk-mNJUkCDFxN5gw>
X-ME-Proxy-Cause: dmFkZTFf3wbZ+K2hbzfSgpgETsMz+NBy3J6MpFvFZYdyyTeL1iI2BFDj1IOSxm4OYKC0H3
    1Aperekeoh01XU/Affr9YDGewK0XTpFuAvdOqXRnkn1hAQOMt6Cmug4wAR/cLjxT0+YYyY
    V0ix31kC1wU9qb1Fc8l0wzUB6/ndZQ/KZS4bdHqUX1yu2WFUdfLdGcye3K8VFjVWdme6dj
    VB+FbRki+xZ7UJmHTn7m2FhlNqt4gn7r8JRqnyPx9S2V0Cn7eSTMCsJkqZ9Q8z0sAb/7of
    tUBRJGNrdn5okkLUJRR2FTKTF+T7dMnEgQWAA9cfkQE6WEt+aDQyOttxx4ijBJAJTShyI2
    2KGSFogf0QrP2+6ms3dwXkdTrSeIB2XTm0XVgHu4PhJMXRfm+FnRzXRoWl59rQT//6RZUb
    RYyhcC0oNtk0BisFJPLcWutNtWLSGjOqtXEqPDUfr+5cSrq3xAEahXWRn1R1IMHUaXCtox
    jl20Tup4N+oFlCpdz5lJPhKTb/YdUeudtfST1WSRkm2E0YnCghwKDF6jdQLw0z1cQyZG37
    JAjNSSWkvNyuchePT3rWZxl8lgtqd1Kor7H5F65phHVA9OiPqGniAVmp8FvB0ngMDFXhx9
    S3hKmXTEDfWkr9ibu9ZUbX+chrt4eBADmvuJN/9uQDpacT409M3bMowQndFg
X-ME-Proxy: <xmx:uDi6amYAzKTYCDG7mIWmz6KHSl27BuD56BQ7xjW5Im8oxCGmfjRhqQ>
    <xmx:uDi6agRLoa88hGBGIqD5dLkkZ3N45NLWopBRCl8lvi8I06j9QBIreQ>
    <xmx:uDi6at4JVFvwXbuQq6q3vNnU6pG6md8UMjc06iKHpNsr1aOYWR3EuA>
    <xmx:uDi6alyxIG4NU0iNNncP_9mwVu5-ARHFtnKGoE04xcXXUqMkhTjvjA>
    <xmx:uDi6as00MlnIV4kidO95OAE1W3kBPOHuRMj2Qvzd_8lD6rhW6pHZ6Kp6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:51:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5798c80a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 09:51:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Sep 2026 11:51:03 +0200
Subject: [PATCH v2 2/7] path: introduce
 `safe_create_leading_directories_no_share_const()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-pks-create-repository-stateless-v2-2-a03612f703fa@pks.im>
References: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The `safe_create_leading_directories()` family of functions modify the
passed-in path so that we can obtain all the different segments of the
path. This is done by overwriting path separators with a NUL byte for
every component. While we ultimately restore the original string, the
consequence is that the caller needs to pass a non-constant string.

While it would be trivial to modify the function to not modify the path
in-place anymore, the intent of this whole mechanism is to save an
allocation. It's quite dubious whether this optimization really matters
in the grand scheme of things, but here we are.

In any case, we provide a `_const()` variant that handles the case where
the caller only has a string constant. But we lack such a variant for
the `safe_create_leading_directories_no_share()` function, and we're
about to add a couple of callers that would need it.

Add this helper function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c |  5 +++++
 path.h | 14 ++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/path.c b/path.c
index 69b06c9464..f8f5a9dd28 100644
--- a/path.c
+++ b/path.c
@@ -889,6 +889,11 @@ enum scld_error safe_create_leading_directories_no_share(char *path)
 	return safe_create_leading_directories(NULL, path);
 }
 
+enum scld_error safe_create_leading_directories_no_share_const(const char *path)
+{
+	return safe_create_leading_directories_const(NULL, path);
+}
+
 enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path)
 {
diff --git a/path.h b/path.h
index 7e7408dd05..922bd6e377 100644
--- a/path.h
+++ b/path.h
@@ -234,14 +234,11 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
  * race, callers might want to try invoking the function again when it
  * returns SCLD_VANISHED.
  *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
+ * The default variants honor "core.sharedRepository" and temporarily modify
+ * `path`. Note that this configuration should be honored for all files in the
+ * git directory. The `no_share()` variants ignore "core.sharedRepository",
+ * and should be used for working tree files. The `const()` variants do not
+ * modify `path`.
  */
 enum scld_error {
 	SCLD_OK = 0,
@@ -254,6 +251,7 @@ enum scld_error safe_create_leading_directories(struct repository *repo, char *p
 enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
+enum scld_error safe_create_leading_directories_no_share_const(const char *path);
 
 /*
  * Create a file, potentially creating its leading directories in case they

-- 
2.56.0.rc2.329.gd58861e689.dirty


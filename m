Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E51D8DF6
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825246; cv=none; b=jc6nQjCX5uiny6mHfoE7apEBe/pRz2glBMrHfqCYODzukvgXKGmZW+XJ1I6lxZ4g5LPCONMMngGFC+oG4P6AjUN47lW2bqIVkE+wLXCXR/QdqdfapfuyTu1HCDw+juYT+vIrleaYEq2PZIIVS+SVlslCr6rN2xfhC6P2tcqgI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825246; c=relaxed/simple;
	bh=95/PDi4qIIdUPvnZDk1UAF1FhsAnXfq0wMubQBKtoRo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ajVBmcsJrp2yvZxLSCojaeiL3pIrdT1I6EZwnBnTcsMy9ij5R1jnstGmk4zVo2rxm5uI6NcMd619/TUJpKISNoXwoPQ5DHxfqI241eG8w4L1fDx2VOthkAFB+7A7nhea59miMn+pr8sGIP6V7lspWcWDV/RxayOZemourfw+ppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJib+R9G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJib+R9G"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43690d4605dso18888285e9.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740825242; x=1741430042; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA1krnQtOvhSYNLE949+1YDZm25pKKjYc1RKvWAaHLA=;
        b=FJib+R9GAtIjPo1LjiqubQH/ejQlPYicVztzNTlNPsfJ7oDLGm5UTE9PovA6ARObjA
         8kAZrs/XwjEjhnLQy0CtuDk3SzHKyyVRl17AKdvwqHrDX7EZJtDsGwVLO4BMT874wTD5
         XGUlwnB/0rIsRNrSF4YDl0X4Z4Q0t0l8Se85Zjcsqh7wFXmoIlRvwPnFCz44QogtIOsS
         /P6mszvu/886ga0ceAyGpbHi/dfsrbsY6jAmaZzZn8oap5/cnuP+weSjScgU9GWLv5wW
         5DnjF6zZYKhioUsCtQ5NlBPTpDxf5BnpUylJV0Qycy1ZucGAqK/wpwSoBpnDwDcxTVP6
         WEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740825242; x=1741430042;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA1krnQtOvhSYNLE949+1YDZm25pKKjYc1RKvWAaHLA=;
        b=Y1kcoGHPjK4KKpI/zZAQctFlrFmeSO2R1SJ3hcFspun0e2g7PKBIQcoh7IPIXg79+P
         eBB8/7f0UwWgH7yKEUeWKyCw1gTkOf0n5/8rTqF9MUWQbEm+5WSAz9qE72fRxkiftAaq
         d5HfccunpWwsE/Kc1Wtnp+vRAi6wjmSM6QGxErWj+AGi1kHarkil9p130m8itQoS013p
         l92GuWCsy7AZtm3jAY6a77BwmBbG9HDjvYX4RIIoWBTpY6Sx6DluIUva87IFv2cKLNyk
         WO4R0kp6ldfH/pgw+u+5LWdxU/LQDORLjCGWhJ0Why8IjbD4NSzO9frH65aa3xoKKTAW
         HQDA==
X-Gm-Message-State: AOJu0Yw54L5dEFSGHPzZjP6Dcknqv+32GiFERLy4yIzAubb4tQ8RJxQo
	zk/dRzB9uygy5bqzdsP59CRZRuKUvjth8mJAf3NfyIVN0O45EX1TFFPb8Q==
X-Gm-Gg: ASbGncv6H2M+PVJS/ggpt298xfYjCTg5NM7H8aIvYB8rwpiKOvS5kf8Uxcmau6urSBC
	7zyL36gW5tqjnDezsYXC8h0UyZqqr1/RW6QcjrfaoJ05XSrMm7OwRWpy7pdyq7kzNznJldSjV7F
	mwjf63Qm+ep1HLGXS+4SZbKtMF9gRiD9F4uTwMwjpEZeYukWYflU4UuIK89tOgqTxaDWqBAuIX9
	zpGWI5nfqSP0ePfS8fto6BccGfE83JFmt+7gVuNiJpPRft0vWgljzgrSZPSLe62IYQh9L3G2KND
	cDTDmdq8wriGbSNRPP2rG/GMhRAXXLwxLalbKChtlkJCqA==
X-Google-Smtp-Source: AGHT+IEl5Oylz/MtXO93Yz0Oc8ISivHakJKHU7A4icqDdXbxiZknSRoaMtHBazUO+HnVoLugofkA9Q==
X-Received: by 2002:a05:600c:1da8:b0:439:9b3f:2de1 with SMTP id 5b1f17b1804b1-43ba6702c10mr59984765e9.15.1740825242428;
        Sat, 01 Mar 2025 02:34:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703f83sm88212355e9.13.2025.03.01.02.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:34:01 -0800 (PST)
Message-Id: <ea204679cb0e6e11bb9e034baf1dbf75fea2516a.1740825238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
	<pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Mar 2025 10:33:58 +0000
Subject: [PATCH v2 3/3] bundle-uri: add test for bundle-uri clones with tags
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

The change to the bundle-uri unbundling refspec now includes tags, so this
adds a simple test to make sure that tags in a bundle are properly added to
the cloned repository and will be included in ref negotiation with the
subsequent fetch.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 t/t5558-clone-bundle-uri.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 33a7009e9a2..b1276ba295c 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -107,6 +107,37 @@ test_expect_success 'clone with file:// bundle' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create bundle with tags' '
+	git init clone-from-tags &&
+	(
+		cd clone-from-tags &&
+		git checkout -b base &&
+		git checkout -b topic &&
+
+		test_commit A &&
+		git tag tag-A &&
+		git checkout -b base &&
+		git branch -d topic &&
+		test_commit B &&
+
+		git bundle create ALL.bundle --all &&
+		git bundle verify ALL.bundle
+	)
+'
+
+test_expect_success 'clone with tags bundle' '
+	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
+		clone-from-tags clone-tags-path &&
+	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
+	grep "refs/bundles/tags/" refs >actual &&
+	cat >expect <<-\EOF &&
+	refs/bundles/tags/A
+	refs/bundles/tags/B
+	refs/bundles/tags/tag-A
+	EOF
+	test_cmp expect actual
+'
+
 # To get interesting tests for bundle lists, we need to construct a
 # somewhat-interesting commit history.
 #
-- 
gitgitgadget

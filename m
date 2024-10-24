Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8827201012
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793337; cv=none; b=X0tsfIIvawNo+DOJxsjlb1zWmxv095H/G4JlBZhOgSxy/tvHE5c5XRr6AWQ8gPG+1jm2d2ey4byxFKbDNqYnxyZ7ne10dsMTv415E9ts95s4YzffypyyJOPhIBx3NCWZrulW3OM2biJFnkCg3+iQ46UGN6doN2e1Wu5sY2l98+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793337; c=relaxed/simple;
	bh=CBY6ZRcItV8jd3RaKg0oqcyEvANKGc3oambRlLKpO88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AYQibLvPt8FffD6fk8OiWbkFokmqyBWWUnV4NidBpg306LkC2Sjq5JT1iN+wVN1HhL9ELB6S8VEyjOFbXPWG26sy+OPybipQr/PlqZaAZewIfdK1K1DK4U0A3yAhBgj65wSJ2syelFtD8khAbelPE/0vR7WuPQrGtIqjfeVhSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j1N2dYVQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1N2dYVQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so15503167b3.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729793335; x=1730398135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IenHT4ncR9jBiOFQaeJAxLJEe8uXsfg94YgBvVnmQAs=;
        b=j1N2dYVQdPij/JKyAUjch66BcXX1oaPzhuLBy08r5pqLrTIaiPRb+4KagHzxSgGPWX
         zFJWVAogI0G070KS/9xc1awqlR/OzfAzKWu3DaMOAiF9Cb+GLD2QVNf+RKcAN5lFFyyE
         xLIlA55BuhWcCO5deEGuAxtrXUO0ssteTzNzRWVASyjcMPfp5eBSz8IS+ZwVyeTfAm/b
         WC2kH8ydz+jBBqZb8j8RiwhqvEVFj2hnA4U4+t2gLY9Q85e/UHlA8+R3ru222pNcpRro
         LIBKC4Hvzivvwo8NE8hczvXGM1Kn1UygCTu2dGeT4sEKDLffJc/ulmM4nPYohlS948dR
         c7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793335; x=1730398135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IenHT4ncR9jBiOFQaeJAxLJEe8uXsfg94YgBvVnmQAs=;
        b=XHb4Ww2GmBmadKMEKIbbM6IYIc9PhGgv33ObdGkTqz/sqp0kx5yGp+JjhDPvhbOFLt
         D5nSlJFN3BjpddqsgjfXUNhNkwc8skX7Sv+dQv3xMNzoxbbLwGLD5eLswWLEeIYsftF2
         z4xMrDzDInZjtT8h9pYGD6o9MCf4LCTcX3iqAKWvDIXfPJ1VCN+DS+9nXnLtfZVtHR1H
         yDZf8v1Q1l+WzgnSs4IFB4zzy0F2tSeaEgnXnGD92ZBWWIgtDklL7J59iHgUQO88ZITJ
         PnWzIi1uw+7nne6ZPZLqAfx71VWfbSyFke/C2mGgrt0koJi0OFZGEC91E2APs6QCWvnE
         Lj/Q==
X-Gm-Message-State: AOJu0YxxFOO3vBiQ6zXLSJ7ieR9xMVcLd2C+sx+WX9UjAWP82n4vg94S
	y+Bv58Z85OnzyfpRw0Qi8++JbPLp9NwzpHHF38HV+bsOLblrLkicDPRrw0ipiy2Ww3zHYenqGvy
	+E0zE+PXU4uxGi1dYmH4T6TeUUHgRsH0aOgbLwsVh/kUqfhmgtyaKoBl1UpIbgFhhYfCxTP8Bxc
	C4EcshWqgFb71yn3rjGskN9iEQzgTBI4jwSfphOGWogzipojqecJGMqheTQoQSJYgqyg==
X-Google-Smtp-Source: AGHT+IHbfLt8oC509odXwuprq4J3IqN6Mcype+VnXhtJ5Qa9OQqAjaNFsidXVrWlm/ZadyiyEdBH02ePfq5NcABM+8ZG
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3554:17cc:309d:28c9])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:3387:b0:6dd:bb6e:ec89 with
 SMTP id 00721157ae682-6e8792879e5mr1027837b3.2.1729793334771; Thu, 24 Oct
 2024 11:08:54 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:08:42 -0700
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <08750988e0498db7de9b3c8766137592adb84194.1729792911.git.jonathantanmy@google.com>
Subject: [PATCH 3/5] t0410: use from-scratch server
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, calvinwan@google.com, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

A subsequent commit will add functionality: when fetching from a
promisor remote, existing non-promisor objects that are ancestors of any
fetched object will be repacked into promisor packs (since if a promisor
remote has an object, it also has all its ancestors).

This means that sometimes, a fetch from a promisor remote results in 2
new promisor packs (instead of the 1 that you would expect). There is a
test that fetches a descendant of a local object from a promisor remote,
but also specifically tests that there is exactly 1 promisor pack as
a result of the fetch. This means that this test will fail when the
subsequent commit is added.

Since the ancestry of the fetched object is not the concern of this
test, make the fetched objects have no ancestry in common with the
objets in the client repo. This is done by making the server from
scratch, instead of using an existing repo that has objects in common
with the client.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t0410-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index eadb69473f..e2b317db65 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -265,7 +265,7 @@ test_expect_success 'fetching from another promisor remote' '
 '
 
 test_expect_success 'fetching with --filter configures a promisor remote' '
-	git clone "file://$(pwd)/server" server3 &&
+	test_create_repo server3 &&
 	test_commit -C server3 baz &&
 	git -C server3 repack -a -d --write-bitmap-index &&
 	HASH3=$(git -C server3 rev-parse baz) &&
-- 
2.47.0.163.g1226f6d8fa-goog


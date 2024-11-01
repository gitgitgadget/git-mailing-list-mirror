Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4806E1D9A57
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491918; cv=none; b=sl6XGl2XxYKfeSo6ET3sV64iFaJub5nczIckpb86kYKR6sYSY1YDlUcGBNw7tkUGpiXp1PDHyzb8C6xT8YXLvdFicUdjuD0qDgdt26PNSkTJzfn1qIzus+mkK3Uo9l2Wlf5CSVm5WmFb5p2PogypRKI/TYlzS2JZQJyNG4NbJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491918; c=relaxed/simple;
	bh=CBY6ZRcItV8jd3RaKg0oqcyEvANKGc3oambRlLKpO88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EWRVJkP4oaIbAg+Ncez+osGczSGv7kM58oE/Z+tcRpDq4HxZ6fkG51xE8zs6zMvrEhEEaTtB0caaCSR3gTL2tWAEOTYXxuNa5EaAi+4bkddCDnzabswsNAtris2CuM0Ik77jpzg/9tC1eVPJ120LO08rwokDsgNqZuWtycz02HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EH1oQrye; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EH1oQrye"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35bdb6a31so45586287b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491916; x=1731096716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IenHT4ncR9jBiOFQaeJAxLJEe8uXsfg94YgBvVnmQAs=;
        b=EH1oQryeyylYL+Nfwd8j47apyT+gCNWsFMGIejsSbWWTtun6aADpEjiikz0nZTGI/V
         KddO3Lv/eZ8a5TSucaPyWsJSln4QkozIgyaVw0l7CXb42s5W0pJTL1KUmJoNiHM32CVP
         MHgdLuRpK/bT76hl/oL8lSh4eEKeD+zLF7NedXgzzdYUJef8TBL7PGJnEahctk5E7lfS
         oX9L14MAF1hVETK9OJiUAlgVK0gVeeLXiFo9fNZbbjpiv/lBjBeZiyeFkh1yOSt6WYwz
         jSQAvX2QK8AMckdA7NplUWzfro4LRV5+mma4ANYtrSqm3usXIgPBWT2V2xI62v9mWhAj
         WSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491916; x=1731096716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IenHT4ncR9jBiOFQaeJAxLJEe8uXsfg94YgBvVnmQAs=;
        b=lzmfob3+mOxbJKElHNhLYdgti/iNm9JGZ9NnwBwtGSIJM8RDkOJt5hCWZPSu6OsLpv
         ovgifdDjxaUzs9+BuVcEmDhYYs6vtrmMhFP4fozjyd/V+1VpGtkuvSkEfNXPqS+HYz6A
         /FlTXmwB4pgm6h32RtBMxP6ClRewG7cjB2yjcg7iGEoKE6ovQPujmoSDC+hi0903IpeB
         RE6QAlr4xDyBWTWsPgQaY3OgUhINDPCleLmC2lU+TgDwMDfEa4ilGRtTg/MuXzb2V/eE
         XOQnxl5eVkKZFfc+LC0XiDdtKpqzSUPZYASF1wzLju2usn144L3tBNf6q2WDheZ84V7W
         LXWg==
X-Gm-Message-State: AOJu0YzzfZIYbETbp857qO1C1pmPyikKblZmij5r+T6l/3cEz0tJvrKq
	I186Jd7FQCtF1vpJWLK4S6HQCBQgNdRjFLJl9YlnbO1n1ctwTTyMGQ8VAnqlwHwcXIaardGKhgS
	5h2tXhN6J6Ux76MpyIpma1KxYbMfvNWaPSVCeziXVRRK438Oc6ADShJYnUvNOBnO/lc5tZ35zI4
	DPSEC3Au0fo8tjD+i0bD/6TJ1JMabHKPNZ+cCnypkCB2uUvvmhqOhz1jR6/ido6g7mqQ==
X-Google-Smtp-Source: AGHT+IFaF2uUgZsbk1hxhbSuQ2l+k0ALUapObfU77hL1weD6gV0KOjoQbPmbnvO0a7MDdBdazalrU/cKNgAL6DB1stfd
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:630f:b0:6b0:d571:3540 with
 SMTP id 00721157ae682-6ea525367a4mr120117b3.6.1730491915469; Fri, 01 Nov 2024
 13:11:55 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:11:46 -0700
In-Reply-To: <cover.1730491845.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com> <cover.1730491845.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <ce9d5af42a50ba115fb9b11f9063f207b471b672.1730491845.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/4] t0410: use from-scratch server
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
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


Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EC1CEAAC
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491916; cv=none; b=bQIjLnfOa4fHkOSUJLPinQWAkGXGQe17lOUG8eidxiBdmT89r/S9/p6x8X4Zl/OKXS6xwZ6UFxDkQ4m1DWhAjRY/iQZszckxlVVFCcfvFjq8/ve/fkcSyZoHIz1fRT0V2wFuV10zFREHagCC/OZkFkAYDa3kXFb4uG+Zyo++UgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491916; c=relaxed/simple;
	bh=lu8JzHccqjbSGPWN5wp60tmQpAYxOLI0jgxmtQqFYFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kx1KlJJZypuejZbce78tXDIJHtaYkLiqyjN+K08gXhcEXiIobepJ407sryhI7E1YPf/3WEFa6UkYPYqStUirVNicU8yfPsiouxdImKfKIBgdt8MZCXIiCzYqFCa3OyWL+6PikOdaf+dTB/dOwPlvgfYNMP7PrqlgAhksYC69ojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8Qd0nnc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8Qd0nnc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e59dc7df64so35048827b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491914; x=1731096714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qArcyT9B1tS2X2BzAtvme6q83X0H/CDdvhzRr8ACm7k=;
        b=M8Qd0nncUXJ/1IGV4t11UPmsE+J62lhFpvLvtX39Ce3NYJY3m3CZsnxZxe7BDV401M
         MPy/2qRaAgaSYqRvBOEdsW9HaYF1NAdKSZa2EdbKRxIP9ZSJVHeFWTZDEgp2p9AzT3EJ
         bUwE8fXc0bpUxCL44cd1RALaDFSXAm0FY2ahF7PktOWr9/63dzB13w/XDdJrSj50u0gu
         JC89BclF4Hjz22CZK1ku4BUZjA7z3w2gHT3YRU9CR2Ng3ia9pTpeX4F0IMhga5yCcmfQ
         jd9wO3iA240PD46+s6xxu/NRjKQB72wP2dXRQ6gwOWSdNO1Rw3NxYYD9xO+c68LelLAC
         vYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491914; x=1731096714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qArcyT9B1tS2X2BzAtvme6q83X0H/CDdvhzRr8ACm7k=;
        b=BgsawW9nMvEGDQcVj9aWrSOw7j0plvQ37HzPrSTnshrPbPtSuBpkJRPUc3ZgqqreWH
         xy4/UWvEFLgX/m5yoqGlfGEaahHfLY/8U9tde3K9p1a4rGlO3Aursp+goDKArdRKtHhM
         KffQs7+ks94WFgHLQpp5GRLfuE3vqCxULfguVC7UoqwDyzJH3cPVj9pV2EbJdkYXqENd
         /Lr+pCsg825B88gDyKpDiXh3SIlSX2jKOqQAmSWZeg5bAk1C+MeDkwd7FcWBhriVGCnY
         EUrpE0LQstxCUsfSReiXWm6iXeonp4hvHLBQRImRGDCHB1v8Lcc6jDgaGMg45ymOZrL4
         DHNA==
X-Gm-Message-State: AOJu0Yxcew5UHk/sch0d5/koRCUKzBE5y8JPRSFf8li5V5bedp/zb/hh
	zsNmtK9supU/qV16TNzGdQSmG2VfnTbRqEM02NFXxgBDaoyrAJZVkGd0Z4lWNh23aNKMYjJpBa+
	DTvq0xYf56D2RqBIwiYZPX2nFxvYWazo6EkebjR/pBN/VuCj+il8g85txj2ZmCiK78LHmOBbmlH
	I1/0JsN53V9wcVxnNYB/diwwssbIL5UjK6Z0FLroiRCWRic7AnXoJqNkdwLePG9Ilxvw==
X-Google-Smtp-Source: AGHT+IFWbh2YsHiBL5D3gRc2B+Q8OWGyO/6TeT+gNjZ8H5dtUOEvs3OtTjyJWezEMZfXqXCeW4XbJJzV069dTVWbabJH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:6f8a:b0:6d3:e7e6:8460 with
 SMTP id 00721157ae682-6ea5576c8bdmr982317b3.1.1730491913866; Fri, 01 Nov 2024
 13:11:53 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:11:45 -0700
In-Reply-To: <cover.1730491845.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com> <cover.1730491845.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <f405c9c9aab39984d27ff31ed03186a713f79035.1730491845.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/4] t0410: make test description clearer
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, 
	hanyang.tony@bytedance.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Commit 9a4c507886 (t0410: test fetching from many promisor remotes,
2019-06-25) adds some tests that demonstrate not the automatic fetching
of missing objects, but the direct fetching from another promisor remote
(configured explicitly in one test and implicitly via --filter on the
"git fetch" CLI invocation in the other test) - thus demonstrating
support for multiple promisor remotes, as described in the commit
message.

Change the test descriptions accordingly to make this clearer.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t0410-partial-clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 818700fbec..eadb69473f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -241,7 +241,7 @@ test_expect_success 'fetching of missing objects works with ref-in-want enabled'
 	grep "fetch< fetch=.*ref-in-want" trace
 '
 
-test_expect_success 'fetching of missing objects from another promisor remote' '
+test_expect_success 'fetching from another promisor remote' '
 	git clone "file://$(pwd)/server" server2 &&
 	test_commit -C server2 bar &&
 	git -C server2 repack -a -d --write-bitmap-index &&
@@ -264,7 +264,7 @@ test_expect_success 'fetching of missing objects from another promisor remote' '
 	grep "$HASH2" out
 '
 
-test_expect_success 'fetching of missing objects configures a promisor remote' '
+test_expect_success 'fetching with --filter configures a promisor remote' '
 	git clone "file://$(pwd)/server" server3 &&
 	test_commit -C server3 baz &&
 	git -C server3 repack -a -d --write-bitmap-index &&
-- 
2.47.0.163.g1226f6d8fa-goog


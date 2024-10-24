Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B889200BBE
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793336; cv=none; b=OreHi30OT90+BFDIFP5SCCcy6yyhanxTtOgBOnWOOl2B7gdPHCCQhVa04HmBxCtGQkTs171D+62bQHYqioPakcws22DtNJUlmglTlp6t0IUoMXKaCASotQDOv80mLGz5V664aL8Nrcctcflt0DTf69tkYdag2psKA0eNjhoZdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793336; c=relaxed/simple;
	bh=lu8JzHccqjbSGPWN5wp60tmQpAYxOLI0jgxmtQqFYFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZB/eu+7isJ+6YpXk46wDkbQR9tqgChBAqHrtjo3+E9M+DW5U1txWWTepWtt+PV55nXIRPxrhPgAqcRW6R6xFkycR98QT8VhftZ3zOlKwlIAFmbU7vZTojjotzK1E+CpARKHxpeWB1w9bfgrEk9N7h94Stw0doXMHwop7XMsWGrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XmCJ6VgX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XmCJ6VgX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38562155bso19932087b3.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729793333; x=1730398133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qArcyT9B1tS2X2BzAtvme6q83X0H/CDdvhzRr8ACm7k=;
        b=XmCJ6VgXXRGM+E2zMRZPuMfZ3cxx5pZKEXA4/tzH8qm0CcVID8259u4AGQD6NdAtw2
         /vzMc/va26AQRJ0eVHjMvGfBZK4+nOPi+0gcDH0XiIuKpz1NgcAVe+qP5l+tDlxripgL
         bRPWzmEBxmEb/qSdSmOJCNWYLn6dJPabIAvLjXAz2zY4K8ff8K2/yVx4VKUms/2Ayvhi
         3F/t3ghtTCR6MjQg7LQj43o+FwfQCTTaXNrAob/CbL2vmwvDfNouFEDnJg2f4tyCyrBR
         WU/CAX8vfHym5Ct780GjwoRNHlEw4/tN3hLhLoLs4fS/gftMetyl7dCep7HbX4QsEHDM
         xFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793333; x=1730398133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qArcyT9B1tS2X2BzAtvme6q83X0H/CDdvhzRr8ACm7k=;
        b=ocbRrsoMU/kMvB949jnTxBmaSIl6ktAhNoN6w2H4sHVy9hVXWchB4dPyRykuy4AeVB
         MOxMpzevmH0N8uroPhFm9fIyav3VIxyRALmmwUmbMCbZon6FxF5EWU7GBj6HG+Rz9+b6
         pNKRoofAXOcR6kvbsdRWwQxG3BS4mmAt6pn5CDdc+iDbspRXn0Tf4R2BfBSk20R572JS
         j8dx/aDMKw7vaFTPMXrYjzp3GQJzULjvjun/I5OlL+B3GwyUD6J2rVK357ypGjceuxmC
         vNPfBfuoPMMVobfHzCYHMTkex7drfeY3UBdCgvrNAi+tIrhF6qupyYbUtfcr1y8V01lz
         A+vA==
X-Gm-Message-State: AOJu0YwoMvvtYTZR3yCJXeHkOH8NrcKpsYfUs1aMgAhCmJcCKK7ugZ2y
	v0DkqTKxYJ8QtVw4gKVAVyC6DAJnkzHf8TGSlxhtTEUva6DmbWpbp7AkJRAItzym/Tb41axpJxm
	rR3fVatCrTNMF9tuoAHx2Xen/W6lYiCPCGv+eXH0pf8L6M0RfpfjH1OESNf/Oh0UOKlE1yfC/vF
	RkSm5qRF+UzTEei5E55ZDU/DiV1+vF8QwtEj3lVlMPItCNm0VQsck1Tt86Dawz/Jmd4g==
X-Google-Smtp-Source: AGHT+IFVSLV/f8xsxbgph6Z0IKenor3WBChOCwyF7woO9CadXbVtY8BKOY3WLYNRtZaWfSUT3XhOWcTw0ZYNiaBWkP6W
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3554:17cc:309d:28c9])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d810:0:b0:e29:7479:402a with
 SMTP id 3f1490d57ef6-e2f2fc4964dmr3307276.10.1729793332977; Thu, 24 Oct 2024
 11:08:52 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:08:41 -0700
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <c220e77ccf4e0884067a27b40e862075d64f8c4b.1729792911.git.jonathantanmy@google.com>
Subject: [PATCH 2/5] t0410: make test description clearer
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, calvinwan@google.com, 
	hanyang.tony@bytedance.com
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


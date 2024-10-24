Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DF201019
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793339; cv=none; b=u20YRVh2aV5FGnlaDAWoBVzAjXghwdF2iEi/oKmankAZfubv6kRNF5z7iPLR8+OtegTrW2Frv0tUyEJ26s7T7whYViFZ57xq/p19vcWMagOtf6uk1X7/HbC13ttNxW1kkYbZz+02dOHZL7KBAZ5QcKuamz3vt/rem482w0h2Oqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793339; c=relaxed/simple;
	bh=MT35PItDqDIxgCQxfKH+QfFAmPdf1PeByGLje6WRoWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhAfSFZsSSfT6qKvVOL2dWlTkaynQULR4UDcb8bTvyfmcfhwO2x/NJ1EzCvlZYcq234S8it8MesxahGswXF+3VnWofYnNhqMCsMY4c8nYpb1kQ0b9yXnyIzaQvzEaKk7TRFfD04LPlyJx0S5cGH9wyVNLyHegqsPQhzDJw355iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoG1bQod; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoG1bQod"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso22706517b3.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729793336; x=1730398136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd80GHaUtupo/563Ne78tyyAJqH7sbFStokHjf9UPw=;
        b=IoG1bQod/6+UuGCaIpF62cfdR5qrDqqBOzHsm2oJSisiyZxRYg04H8p7bQsXEUjGwQ
         vVs115adEwxy24g/V+i+AcDz3wWb1bTJLicXHmffOvTdDFrp1IXqb1qKjj0oWdB1BOAC
         /Ic/GTlAMK3acUPfsq5Q/O+GwF/2dhDyGcDtAXj+U0EOo3YkFrLeec0UEkvxuAPptOpx
         RHwY/tFezhg75M560zwZbmgM/zXqnc8Q7XjgD28CocqSqQyVlrhO5oMbGpEglIOtLxQ/
         uePEoI+wpeXEHapQU1sJa+QVTieXrieiGWP0pBVh50X+B7YUUq7xrALw7DQkZqIOt5IU
         IeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793336; x=1730398136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsd80GHaUtupo/563Ne78tyyAJqH7sbFStokHjf9UPw=;
        b=FhaODn12pSKaOdefTkWt3a1XHTPkJbODUB0BlVkvF0ZHgr/6DkIN1TDUgG8RV0Uiog
         F/pIaKWWED0U5pQTZCJslKd2u+2SJYLrrFURjyBA7d436CQ19mYMjnNMGH48rt6p1tpB
         +0wsg/hSHKOtX/41fW8PEFwyns5xycQxy2wVeZtrSj+/U71zJNQ7c6moAtbE1ZUW9v+l
         hTP/+VWK5pf/GIzU61vz706XYEyHu/cCnZ/m0aBkn02aLF6mw0U+pWuvS5gb5KkC3Vz7
         8O5o60JTM+gY2h+RJ7Osc2Ip9ufbqAxvdF6+QvdfFBx0SjiEjyu78NyL1VwmDhkMhSdQ
         MvYQ==
X-Gm-Message-State: AOJu0YyVOOUVvGYO+mf2xqy6YJ/oFBQsdcTqX/tYKHbuBVWXAzZYpJKY
	kFbR9WhASh0V1r9RjICg47RS/ItwAWaFwnHA+ZK9ibB0U/7jq1iOY0Ff7UWNdY/RkdBA/6SAppK
	T+T0Ae4YP6cvjuuwIRfZ8ABQCmILnLdCMA/EicYst19xytPsbDOVWHs0+RB4L9ypvsjPFh+lchs
	QKg2ZtmQCadUDmMkTr3LOurYS1CMWEHOVbtVdxNA2m7eCsFQssvPxcZIjBM46Qqk5gcg==
X-Google-Smtp-Source: AGHT+IEs8Qq8jGHw2dqIqPn+UUpFXC9vcQ0PJ9GazHcDBfG4udJfkLSSu1Svq85c28nn85YnNitmLa/ViQ/CgOoXmhg/
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3554:17cc:309d:28c9])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:9c10:b0:6e3:2bc1:da17 with
 SMTP id 00721157ae682-6e8663023bbmr1897467b3.4.1729793336470; Thu, 24 Oct
 2024 11:08:56 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:08:43 -0700
In-Reply-To: <cover.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729792911.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <85fc3fa77e1df835721bc702c6e1df92e7b5b4bf.1729792911.git.jonathantanmy@google.com>
Subject: [PATCH 4/5] t5300: move --window clamp test next to unclamped
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, calvinwan@google.com, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

A subsequent commit will change the behavior of "git index-pack
--promisor", which is exercised in "build pack index for an existing
pack", causing the unclamped and clamped versions of the --window
test to exhibit different behavior. Move the clamp test closer to the
unclamped test that it references.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5300-pack-object.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..aff164ddf8 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -156,6 +156,11 @@ test_expect_success 'pack without delta' '
 	check_deltas stderr = 0
 '
 
+test_expect_success 'negative window clamps to 0' '
+	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
+	check_deltas stderr = 0
+'
+
 test_expect_success 'pack-objects with bogus arguments' '
 	test_must_fail git pack-objects --window=0 test-1 blah blah <obj-list
 '
@@ -630,11 +635,6 @@ test_expect_success 'prefetch objects' '
 	test_line_count = 1 donelines
 '
 
-test_expect_success 'negative window clamps to 0' '
-	git pack-objects --progress --window=-1 neg-window <obj-list 2>stderr &&
-	check_deltas stderr = 0
-'
-
 for hash in sha1 sha256
 do
 	test_expect_success "verify-pack with $hash packfile" '
-- 
2.47.0.163.g1226f6d8fa-goog


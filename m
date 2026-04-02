Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1D3E639D
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140427; cv=none; b=lMvDa169BTjUesIUy3O+p7zubhDbTlXZMKvg8iTxGfX+rmNcry9D9oDGf8lD6F4p6s4mLGu2c45AvpjVliIb1c5t0HUiYOOaH6wmO5kEgewDVaRh8XL3UE8zGogHjr3iZpbns17Y3+bYjE5mBYUeE4KYTR8oWZNG1Yd+ZxTxoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140427; c=relaxed/simple;
	bh=qcnyIHU7P1yEe/l74/uSE8tKgb+YfzU6iGAgFVl168c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BST1Bb0qrxSN5opOK2pEbrvFWEXuI7vwNMRJSE0TX3JMLeNCn9rgquvGbCTCRC5aPo2/8aNGeq+ZMntI0O3t5M0Qomcz27uexAHTHWWX5uvZ2Mq1Dh7o4VR8Ongpna7nZxie7GxE335O2DWN9AWCucL2GYNPnf6diRzaEdYF07w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCnLI3mk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCnLI3mk"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc137464dso130809985a.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140424; x=1775745224; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UoUOOPcjUlOza1IAtYajWPS969AxmLafRaDyxBj/6Qo=;
        b=XCnLI3mkTjjQLKn1/2HSqykdoHL3LjZ17A3lNnEzegRoJNca4GhIJqDxvd3Bu2G/aB
         fYel/jDBSkgEFNq0owDXUPRHU8qxVlwexfdaRhSSIgdT6e9gCdSB0IwFTHV1wYtC2xPZ
         vN0EMkTi/bEH1oFDLSDg7eQSezGEZBDWtHZW2wILXVUnVuN0YkWoXvYLQpnIECi8S7gJ
         7oEcpFdSubq8YtH1b6RtWQ9HB73uN2Q6oJiLkV2tl5y3ZWQQRRcDmALb9+z9bB7HiZtB
         PUkgBsONpZRzl/h8el/wRgcWLXSEr5ED7Sxnoe4osHIDOn5i/RMHaslayGpCZ1zH6LKS
         lQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140424; x=1775745224;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UoUOOPcjUlOza1IAtYajWPS969AxmLafRaDyxBj/6Qo=;
        b=Nxh3HsQXO9IrN7jGHtnKZ9M7+stm0/sJX5EAJ7Sl9RZyv6M7F37tSVeJpTZUCfIByh
         FVl3aP0k4FlafynejsAlz3G9Gz4YyZ92c2EWt7wdg6xv4rqpNtsCHaoRgZLWn5TebMlo
         zkXzFWiZb7IIoWSJ+BUXU+GWmju32r7uojZEpMWHWBSK0Rj90KdC+aG+foIXRatZziEQ
         I8wcG4D0ztlfvwQojvWTJHdjw9bjIdjt8Vi0FpUDEFAqExKCyLjdRX4wpS+Xw6TKojjO
         eAAREqDHdHvE3XmCat4pX5s+gud4ssKyel041pCvzrBG8d1lQjAE/8SelKOYcQOq1+ET
         rqJg==
X-Gm-Message-State: AOJu0YzMDXD8mBZOrF+PwD5M7O2JrZ4spG/0hZpQYnqdoLrRyHN6ajzj
	HRxFppEwkrYOr5mZ+Y0EAJPoJkbwG0Eqgn4ao4zhRY7/UIn8TIQQV6VWdUDqHQ==
X-Gm-Gg: ATEYQzxx+2qI171IZHiIU/VsJbd7dOwAa+KjBLGh/njRiWqxZ3aTPTAhCdG3Y8eFJQe
	yo0m2dj6hoV/qZCiaqVuvEmm4HISESWvz3KdYyonXPF3BBwU5GtI4/4rjd4cRREd0reJBo5REKb
	hvVyzISk8AQC29UEF2v2akzWvtrsaTQoL+HreG/ucR805kKdbXfwQpM6+wO+crxY+h5WrtJQod1
	rCIDwhWugYpm1Axa+/WxqVPRL3TlFIRN2GHSzOVzHkmcWDPP722Qg4h2IaKZ39yIFbpGhRwnPBI
	GQfw1Rd5AONv1E3wx2XstDJkFOBvwq7OXA+MARqSxp+2b2S1IAw0w+RJvEknsT1PHzmQPQ3BEGF
	ZxcTzTLU6BLVUMoWNYcZU7lZET2H0Cp4E9WTb50eIs3xB+44lfZ6qyNLCyT2m4rHQJKVKBGPKRg
	aV/FfvhvyO7OmV+E2yFg5By0Hdgdc=
X-Received: by 2002:a05:620a:199d:b0:8cd:7f2d:97bb with SMTP id af79cd13be357-8d2ad951de0mr485308885a.47.1775140424319;
        Thu, 02 Apr 2026 07:33:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5392d35sm224817785a.10.2026.04.02.07.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:43 -0700 (PDT)
Message-Id: <97f22f9e873afdce8b2afc9de2e3f118d24aefb2.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:19 +0000
Subject: [PATCH 13/17] t5619: wrap `test_commit_bulk` in `GIT_DIR` subshell
 for bare repo
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), wrap the `test_commit_bulk` call in `(GIT_DIR="$REPO" &&
export GIT_DIR && test_commit_bulk ...)` because `test_commit_bulk -C`
relies on implicit discovery which would fail once the default changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5619-clone-local-ambiguous-transport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index cce62bf78d..3e9aac9015 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 	echo "secret" >sensitive/secret &&
 
 	git init --bare "$REPO" &&
-	test_commit_bulk -C "$REPO" --ref=main 1 &&
+	(GIT_DIR="$REPO" && export GIT_DIR && test_commit_bulk --ref=main 1) &&
 
 	git -C "$REPO" update-ref HEAD main &&
 	git -C "$REPO" update-server-info &&
-- 
gitgitgadget


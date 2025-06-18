Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9C70830
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271921; cv=none; b=tZcPJiYhG+PWxGpuk6i6GPuB/4U08usF5C09oz6lf3usA4CuQJBMPv3KlvYuWKxnboxme/BYKEcLuMDE01v5R5w2SX6/wrIa3yeyiQU6Vb1fjB3t/fT++ViFuWbo3ey8y/lOcfeuDaBnLpGNRBFnPuxmeDzwyaFRuLdfalYur1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271921; c=relaxed/simple;
	bh=ipN5HkMO/lX5E48apSyLpofDxr2IqWg9Fa+jRs7oTO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnLdY/P/OZ1dX0VdZTwByTrxXKA/ePI3tWfCWcPTweUbL44wCtUrf/a82bx3RWRMJE409fHWNIQMG5EC1B4e0CdpHvZD0TdAn8EU+9aZTPgGh1vmIk+7Mc4F4yAFgzrODcI6mdEQjJmi2MauDhoynOezVaP4HkU74gbFElLJmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIbMW3fc; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIbMW3fc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31d592bbe8so5711a12.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750271920; x=1750876720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRvH74CItRRaccRZ0PEZeZk1bmgHJxUuCD1+humwFbw=;
        b=BIbMW3fcmMCYfewn1G1db0a5X/nDbOwndkyKFE9bGvpDrGA2mJPcu56dJxqm/PGoFs
         bwvaIVj5nI5dV2izeOPsnAPYKaNGumyA4ja05IGLqzjZVf67fHgnHXG6LGXea4T/oqur
         /85B4FS3yRdsQh7mBFAXCLpEeOdbTaCp68vXt5qGAvylm6nV/3hUA2xix8NJHOcMz3XN
         FlG80ZXUt7/1M5LMY0ai+qgSeFvKDTF9rVuetQF4ISeIq7vYUzpmRlIavlVWPUqOmekl
         McaxoPhzTVDJb7OJRpSf//mOfR9yWLh2Z4BYH3So/NuBIDmYTq1mNXCyZFDrddXpIrQT
         dUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750271920; x=1750876720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRvH74CItRRaccRZ0PEZeZk1bmgHJxUuCD1+humwFbw=;
        b=NouHwutTnVojTbKbpolVzN7CpEuT4M1sNXO0cl8NF4lLHmOrTNh5c0AHjfObUSOK0w
         bkgIAl25/uuGdKwcMwQPD/srbZmvEIEQvEG+f1fr87vYVhdRbXuLTmcIGZe3+2orqVNW
         IoGVIeDhf50uEna7OQi8/dv96WH6f38E8yaEibvVZVgjxZQYvYKECSCIYGtoUvwlb7cQ
         s2Xj/TUNOBRRHjzDVLykpvvxLAYG+hwgim26Fr8KObPwrSzLevDEZ/u+GKxvG64Dk8Ma
         XKaeWsxQcePYOF8NGJwx2OubQnkghlguMbjAuC7DMUGV8XudlpG+REC/AHwo4Z9J9QRJ
         /plA==
X-Forwarded-Encrypted: i=1; AJvYcCWQfipw0drfzD9roSD8DKgTQ8X4CDvUcd3Jsp2sodhwc+MBevIApP2zI/deu7HirLBF1g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QuQWetBn4wJ2bb9We9qUnVExN52t8jleVgeDPtDaPAFqGvl+
	qQoCEEZvpvJSZOOKYdtSgMceEMtfVE/ZSQ+BdwRYZLnl5WrvBQAPFVyi
X-Gm-Gg: ASbGncvmi5FuGiwTrmYbpv89mp9359qL2+FgtEb4RVMGyA2BHjntVqlS7/c1dS9Fm2I
	7qoEiTNe3rqg5ovTrvo+4mPxcdCFClDl8XLCyN6HjRIU5QluRnpXOKG2AcTrAhLph0vnl82L1TE
	bXfGKRI1O9XYCNQeLH8bh4lN5xjAQnRqGroHDOd6V+fq+fDsMt8D/NIn1wFdZYkhslAbeoVGEvA
	z+PPAnkIY9YG5xsI1sT/RcXBEMa1Ch29+iMwItulO7wlHn7M8/SHLgB8+coz70bynzb86+kEov0
	w/bww8oIYqoNKE4R3NT4I3vyrJBGel1jV0oeIMKO/g6Cqwl+fuOUkvfp8l4hRZ93KaJHHtDwUuf
	AtsFSAHXP/ewsPnX4EIrucw==
X-Google-Smtp-Source: AGHT+IFJ0TNS8C7l+ABwxOe/Be2swFBSOUMuSguaM4w/kLTSPhJvprKtKZyxgd8V37tNZSfFCKFaXg==
X-Received: by 2002:a17:90a:d60b:b0:313:283e:e87c with SMTP id 98e67ed59e1d1-313f1c77731mr25564017a91.3.1750271919635;
        Wed, 18 Jun 2025 11:38:39 -0700 (PDT)
Received: from dwmfdoom.tail99f6b6.ts.net ([177.33.100.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f3736sm297808a91.27.2025.06.18.11.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:38:39 -0700 (PDT)
From: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
To: ps@pks.im
Cc: derick.william.moraes@gmail.com,
	git@vger.kernel.org
Subject: [PATCH v2] t0200: replace 'test -d' with 'test_path_is_dir' and 'test -f' with 'test_path_is_file'
Date: Wed, 18 Jun 2025 15:31:10 -0300
Message-ID: <20250618183754.108821-1-derick.william.moraes@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.62.g658f0ae201.dirty
In-Reply-To: <aD6TJLuuaZmiFUvZ@pks.im>
References: <aD6TJLuuaZmiFUvZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your feedback Patrick. I'm resending the patch with your
suggestions.

'test_path_is_file' and 'test_path_is_dir' are modern debbuging-friendly
path checking methods in Git's development that output useful messages
when the test fails, unlike 'test -f' and 'test -d' that don't provide 
feedback.

Replace 'test -d' and 'test -f' methods with 'test_path_is_dir' and
'test_path_is_file'.

Signed-off-by: Derick W. de M. Frias <derick.william.moraes@gmail.com>
---
 t/t0200-gettext-basic.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8853d8afb9..89d0899a5b 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -31,12 +31,12 @@ test_expect_success 'xgettext sanity: Comment extraction with --add-comments sto
 '
 
 test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=YesPlease' '
-    test -d "$TEXTDOMAINDIR" &&
+    test_path_is_dir "$TEXTDOMAINDIR" &&
     test "$TEXTDOMAINDIR" = "$GIT_TEXTDOMAINDIR"
 '
 
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
-    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
 
 # TODO: When we have more locales, generalize this to test them
-- 
2.50.0.rc0.62.g658f0ae201.dirty


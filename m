Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009BFF4E2
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728697805; cv=none; b=lB9UBObzq6D55J+rrVM9gqUemFN2DaruYEYMpERuFO6RtEuobbYSMXblwiEWT9K+ouDsBxTGZ74eYtr/WCvoWr6fvGKzk3ZeXUSUNJbNgwl3qFnaxg4szcHNEjea4WCTpG1hYJW7KTSdQa3WxF+7mAjPLbYrLFARaeu4RodAeqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728697805; c=relaxed/simple;
	bh=4ERN6am89GHqeH3BGLKrFT2DEc/4Rxylkn6UoUHVhq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWn4aPTuShaYNr/GpI21ZUZ3aRmhNRVLK/j/Ms6lfNckxIFm7WBM7kRlZtZX1ihb3OOlHWtA0Glhx6mhSZzCo62HhtaTWd3Mrd24/oD1BiE/2wJ/7AbbqL/2mCgcl2nHcVBqqAt/74smzAJHvHbNzg/NQ6KlnDuvVC3aRNCB1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ7RGy67; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ7RGy67"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so3571809a12.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 18:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728697802; x=1729302602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05LnHSMb4yPosXhgCOaJwaQlNlEH8PQfessTE4QU/9c=;
        b=mQ7RGy67PlWqPVyzXarIQTzt3A8Ca2SdY0NOxLsuZ74N2183ZvdychhZw+MSAXBi4J
         fDvKx5wSYF9S6ka9zqFWgZNd3Lgm5OMjvbUYe3rFSPmDFBHhFUXr2RDHQY3qkKW69kFZ
         ITDRzt+WzQQYna8SXBWyTASbusAyw72YH6YLAHN3tnMY2+1RTukiu+vi1rhh0cGbSes7
         FlWsFXvGSknIK/PT710e4DFNBvvQrI7vjA4fjCPiVSqVyZsfE5ezolY7WD2q07u8PEfD
         N7U+ZEzMmtCG/Ltd9utBsbGUF+pSQX37tJNsDIlQ+HRNK6NLpqPIDaLsr5zkatbvdz9G
         Z5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728697802; x=1729302602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05LnHSMb4yPosXhgCOaJwaQlNlEH8PQfessTE4QU/9c=;
        b=YONeaxU/WTIrNzXpCtagQ5BaxxscfKsZOTcTK4PKYII/y37IWSqFVBQ3W3EtRqAKOs
         PEG6PnzyZRwuglFSLlLeGclmN42hnX9ff/Eg0eFkDal3+H8U4lxVR7DP0Fyq2UHvj+vy
         HGBMbzgk+/jnWvzdd0WNT2uWFehCOBTlM9No7fPJUuBUbFHkom2KRg+HpQHiuXSA/T3U
         SzghsygGpHqiH/q5sMYMhUZPocYFzn2HIG7iUTAXcnTQurloVRdW+c5pvLa4eRSPKXTI
         GsyHHHwhiOS/ZGoH2iOszcSPx6Jm52gpajVKDEA1C6jaacs+3B+6S8mwB+PUyho1NLg1
         RzIg==
X-Gm-Message-State: AOJu0YykFPwd/xe5zKVhHj2xgFk6uA0leL8tiwLkq9RrPHiKSy8PkSiN
	L+eoge6EVMuV4WxlFoL4KI1wO+DxUjLT9fRJ/QeDDJbpddIHPCKc
X-Google-Smtp-Source: AGHT+IGuYesEqCoj2OYYMFDq3Zg+/jociNiRRypF0rc/lj2HZ3kGTOfX9FZiLu7YonYG1bFMuFDUbA==
X-Received: by 2002:a17:907:3da3:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a99e32fa49amr150160166b.0.1728697802003;
        Fri, 11 Oct 2024 18:50:02 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80bfc5esm273122266b.142.2024.10.11.18.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 18:50:01 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johannes.schindelin@gmx.de,
	spectral@google.com
Subject: [PATCH v3 2/3] clang-format: align consecutive macro definitions
Date: Sat, 12 Oct 2024 03:49:52 +0200
Message-ID: <1586d5376915a4662c92b8c0881596952c4500bb.1728697428.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728697428.git.karthik.188@gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We generally align consecutive macro definitions for better readability:

  #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
  #define OUTPUT_PORCELAIN            (1U<<3)

over

  #define OUTPUT_ANNOTATE_COMPAT (1U<<0)
  #define OUTPUT_LONG_OBJECT_NAME (1U<<1)
  #define OUTPUT_RAW_TIMESTAMP (1U<<2)
  #define OUTPUT_PORCELAIN (1U<<3)

So let's add the rule in clang-format to follow this.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index 66a2360ae5..9547fe1b77 100644
--- a/.clang-format
+++ b/.clang-format
@@ -32,6 +32,9 @@ AlignConsecutiveAssignments: false
 # double b = 3.14;
 AlignConsecutiveDeclarations: false
 
+# Align consecutive macro definitions.
+AlignConsecutiveMacros: true
+
 # Align escaped newlines as far left as possible
 # #define A   \
 #   int aaaa; \
-- 
2.47.0


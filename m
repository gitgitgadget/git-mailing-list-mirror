Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9B110A
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290572; cv=none; b=VR3HAk4wFDWvq30nfI9zQx8wB7DK865Q7S+Mxe6buzQtMBCaeafPtjHlsj6lMuxXVUgtLo4nQaltW0zGGSKwXzpUFIxd4M2DTL/7iQiwek6bgE5Jg3hRFTftHDftbXPITWXYtJUcjVYn+vtiWhXEnGmlotxZMoRyLhsoN8EVb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290572; c=relaxed/simple;
	bh=fXYkwyyNJCLwx/1+LXMILAXgVK2bnFuuMMrPjySB8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWoARwvKmTVvbR6B3hksvj7gPTKmGTo7qzukCEnV6MYcQ2u4WRp8tuHsWHc6ZldvqTxGsjJ6cUxhJik+8UHiFVrYzxBCnV7jPC3QAeBDdp1r2VpwOjM6hCZVLqmg3CexyKDf0fbzY9CAS2x8xrnK92HrL1xt5HRiJV28XhFN9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmRNVTNF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmRNVTNF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42795086628so215755e9.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290569; x=1721895369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=EmRNVTNFmGOvWYjgngvIdW+E+D2Fk0hKUJC6cpRXTLGrvOLoIfDvV2lbibCICAZEpt
         0Yf1onVRGLq5O7vdRJi5yCwwn93oRkYTBRKgNmcxDH48IVPmKwMpQSe30hECFxFdaUy7
         oquXUYAwIwt/l8HHjDVQztVNsM69qinqdFHbULE3sjY8QEsHix+uK+01sECNXgGJ+EfP
         skM9KwvKWIqWN4iPqbnj39oHi856tx+kWRwoY7ph/UtevwONAfpBj35MKnuOFLGOZn0p
         5iI44hq7GgiepluwiOWAnZtHo6Yf/JfHaVsZEQo72riZIZjB2PVqWOO1HhsXOEzN3bDV
         //Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290569; x=1721895369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXE3MYu8CxgvrX1p6ggHUE0kt8dF7SAUpXUFx2O4fgw=;
        b=t2A2xOs3hI1SmhNU5yo0+d9klFvFP9PjXN0XJaC5PVFT5Zueh0AcAigfdWHeh6qMgN
         NWGCsY+HLddLOIIPk8kTNH32Vp7Fp0u4KKk9KJ1P+9FNlnPFajXBgZHihwIgF/RICWBC
         NCwXkc1I3hH2dF/f9QEg4Xme49ocJCFQe1+Cw5ovpSQhi4xSSvFtkBUZfGCwjnIHL3Vr
         tRGBT+fiy+5bUVWEl7/dg+Zd6pM5DuIxbN6Nm1vH+QJ0Aeh6MMrEs5FSVvLTbvbw2KK8
         +ipZL0V4gxFZ/q5O/aATnhMGuJ0/NfErIS84nQo6Ge2mXeqXU+j5gzQbCQNEZ541hwDj
         RZuA==
X-Forwarded-Encrypted: i=1; AJvYcCVuMYfAj93t08/EZF8LHhiD7eOzQRzxqsIp8pY/N/+kDnv2bnpZpTuSFDcSuOa2o7COqlZ11Jmq0vlsjEmXFmpTUwBX
X-Gm-Message-State: AOJu0Yy4FS3wucCEu2EhKANJmsVy+4ij2C7bjWrHenqktc2lt6rYyI9t
	z2shAVVn39fuZbNOnWpvGkWLnxtHlXnSw4sMQy4asqMm9tm+ckVk
X-Google-Smtp-Source: AGHT+IEJ8pRvb0rHyikUuD9q60lmFBA6ioXoEGqtRIM23eNPdjCbb8nex+8xZ/+Y6W4FPXsACUIAmQ==
X-Received: by 2002:a05:600c:5249:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-427c2ca7a3amr26562595e9.7.1721290569024;
        Thu, 18 Jul 2024 01:16:09 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 1/6] clang-format: indent preprocessor directives after hash
Date: Thu, 18 Jul 2024 10:16:00 +0200
Message-ID: <20240718081605.452366-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
 <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not have a rule around the indentation of preprocessor directives.
This was also discussed on the list [1], noting how there is often
inconsistency in the styling. While there was discussion, there was no
conclusion around what is the preferred style here. One style being
indenting after the hash:

    #if FOO
    #  if BAR
    #    include <foo>
    #  endif
    #endif

The other being before the hash:

    #if FOO
      #if BAR
        #include <foo>
      #endif
    #endif

Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
our '.clang-format'. There is no clear reason to pick one over the
other, but it would definitely be nicer to be consistent.

[1]: https://lore.kernel.org/r/xmqqwmmm1bw6.fsf@gitster.g

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.clang-format b/.clang-format
index 3ed4fac753..5e128519bf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -96,6 +96,12 @@ BreakStringLiterals: false
 # Switch statement body is always indented one level more than case labels.
 IndentCaseLabels: false
 
+# Indents directives before the hash.
+# #if FOO
+# #  include <foo>
+# #endif
+IndentPPDirectives: AfterHash
+
 # Don't indent a function definition or declaration if it is wrapped after the
 # type
 IndentWrappedFunctionNames: false
-- 
2.45.2


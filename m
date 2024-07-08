Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481D433CA
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430613; cv=none; b=nx0oSB/L0XiWxhYQHhtowpRXIeUmuLkqvSr4XYZlpQGx7dyuGViWpztUUXA3p52/Fd7sFbNNOvmUyFFr9xR6A/adWe/gKDytoWpyZ448bGcKb0EOWXKdZ9Ld1C3K/aKrtUAMe0Uutb9wXMXxuJc9cPy3pkfDDIhUGvWlJpeOjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430613; c=relaxed/simple;
	bh=Gqs0VQwsfgRA2lK8SCn/i68gVXoNG+1qWEpW07/D61k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU8uUcZZYcZt615OhZsLSEViP5Txdh19g+s5a8qWlQuYNYEfUyLvAPXNU7KoRjE5fzfiSw8RDCNa335B2xX6xm8Qi9VyW1WgJlJAWiGKc7URSSbDqhaaCdu+EDmLD/CyVW138hjoHKMG+4WV/GKbuYtF5/0Dt5mlp8aEOIxtqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be1M7XPN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be1M7XPN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265ff0c964so11792425e9.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430609; x=1721035409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGcMb6BAXpBImfiOAFXGemoJ0A4QULj+Nih/JoSKkps=;
        b=be1M7XPNkC1zb3q2/Tv0LcRrwWam+WVPerXcAV4Q09FC/1hYOXdsenjL3dHlayE4X3
         d7ZifqwgS2i50T2HXvuq3eoeWrWfOUWhkcBIqm0S01Nq/1YZCp0qogVGO/wRXrjf2/r5
         LqkYxIWvEMDmKoeI6sGYmIepzshauC8DcymF8AzMC9ksC7Kf7Nbi26vEIphaPmfkZ5+k
         81LKd5Uoo83p58c5QSZVbvGvdSudexZY61rRDwYNUfyN39vATz3t9Hv33GhDOimJLFgQ
         Kaq5UdfYveeux2mKlQqMQ2oNl03rDy4SVflctc32Wnu47h3a2+rXZckyO1DfvQxSJyiv
         KZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430609; x=1721035409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGcMb6BAXpBImfiOAFXGemoJ0A4QULj+Nih/JoSKkps=;
        b=tqdRGAChw5dS1ykyWWSu0S5rRn8t3qkI5WA5SE9IvfR5KjFQNrgei6/QPiNEGAB35K
         eGUwMrV6OxsiFyilPomYWhYb4DmfOT7oeZdykkpUB2sXy2E6FxizcL+vXonom+a7DbBm
         yeVud7zTCIMUITRBZ0wTQHdAlqqAXUoMeaJ/q2tjM6Dalu2qolrv0QQ7DsOx12WoC1Df
         P1UTOR2AzMBPP446/OCRNnn97Pc9+TOkoCDBOd64GicrMzE+afH60Azv7LW21l0jlrzU
         B7cg5IkeI0l2RZXDjLPm35xEuj2SJOga96Wi1L2+aimWDTJfclRYdyTHx4SiEdoqfaXJ
         1quw==
X-Gm-Message-State: AOJu0Yy8FhGBuWyGPx2BSqZoTbAzGMy4kOY2eZhRmAqyYGILk/r1uwwE
	mJOtVFGG511Bo1P4cSoGZe6pkA1SjZT4ts7iveI6dZdUGoeKi8o3
X-Google-Smtp-Source: AGHT+IEbGlCqy29merhADgD1ybhUsPL3ef5chsoWoctSd5kSgZiL6Pn/ddLALJ2k26q3YFQcF/1xXw==
X-Received: by 2002:a05:600c:3592:b0:426:632b:c2aa with SMTP id 5b1f17b1804b1-426632bc350mr28390295e9.16.1720430609472;
        Mon, 08 Jul 2024 02:23:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 1/8] clang-format: indent preprocessor directives after hash
Date: Mon,  8 Jul 2024 11:23:09 +0200
Message-ID: <20240708092317.267915-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
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
2.45.1


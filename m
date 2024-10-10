Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5201C9DF7
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583160; cv=none; b=D2hnWvk9l1QVUKZx/19sn03xBYGKvaehHc9ELZHqIeViFeoERlCDX/X8kziRX9AxwTvy02tGl4acw48317r980gimMrm4Z8CH1bJd2oygGLjkud1VWMXzT8i9+RDNjy9v2SSH1zPdtQAUVgdScFFc7Qx7m1Kt+4J4B/QxZEjw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583160; c=relaxed/simple;
	bh=vZYfxemH7dVb5XGbvjQlwOvlocskwDxUMBgufGVgV3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eISWWu9diLLa9Tv2f1fhkdVA4tl9oTZ2b/GWZlw9ZSKzicqL9S2GqU2ewNkADOSxzdf243SCViZuSKVgksbw3Tn7ecnPyGDNVcZpNRVq/e3qiqcYZmQ9ohZ0WY4d3XMzbOGZXtC0AcDDekPjb/38MtXQzh28So5zmv/jPZscbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdOvluuI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdOvluuI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad75b46a3so12652241fa.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583157; x=1729187957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXLJNjjeat/lCLMwnHSv8+tzE0k8FFTu+ZaWN+R7ofw=;
        b=MdOvluuIzxccM34FMmqbjKcK1RzwWkwK8T923F/ygvjVGmAN1Qa0DWSqcmiR/RrtLh
         CShxYM1GG9w6K/EiJ5SoVY2m91ug8KHTWFrJvkYo+9/jTsW9sW4uofhlRbd52eBdwK/I
         hirHhREGFs6qf172V6nvgNdMKpeoiK4tfWuWWExCckiehKMsOy8mKoqLNrTIw6lpo7eD
         O6EfTHDbiIM3D2Q3jSAaZC/wnyfOc/qsoe3paYhHitGhuzvXcEBRqTEkAB9z8rfor8d2
         sZGKdhgwwFtYJjpO3v13TwM7xJ/cAOBk76tu70OSsYMGBwO83NnT1xT15kFmOWd6ddup
         QhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583157; x=1729187957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXLJNjjeat/lCLMwnHSv8+tzE0k8FFTu+ZaWN+R7ofw=;
        b=lJbUVFyG67MDQnZUds4TmDxNk0fFLn6TBrJHV6GKacGoRaJvaIo5CD9iC5Tc6gCcM5
         aszD7Qve2VxLNemkEUhht9K6Xy5JfrTfIdBC/iUQBqoevKA2x9wlP+8K5UC9T4I+Q3kP
         g1ll4mj370WMwdsqTpqrRdX2yTCw3qxeY1n/DcMfCgFc1yt/1Zeo/tUZPvoVnfqDl3m0
         yx2I9yhF1MI1Y2sQXe2kJS7/IhmKAmLY+AleP4zlMMYYUHz1LYjEYmPHeKjlnCe/OHQG
         7R4czJsf9wU0Ng07al8ojZNJ0JdB/ZXAZn5p6PXJZDHDVZDfQBFra21CySoLyyp7otX3
         yFSw==
X-Gm-Message-State: AOJu0YzUu3V3KkeQIk+v3V2Qs7QWwM1Byb6SibS2BYftytdc3MtrMIMp
	5Wy48Utmpnv0l4TLrc+QHNRwKwgciu+GIdPXp96P1QKvm1Maq8ma
X-Google-Smtp-Source: AGHT+IHR0BRDjKGS/eyIgCGo+TMtTTtmvhVmOVUExhB3FK2BQBC04cha829h2NU1h9NPZBHOAFRkHw==
X-Received: by 2002:a05:6512:1116:b0:533:4b70:8722 with SMTP id 2adb3069b0e04-539d49ca397mr235947e87.15.1728583156780;
        Thu, 10 Oct 2024 10:59:16 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372608f4sm1059995a12.70.2024.10.10.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com
Subject: [PATCH v2 2/3] clang-format: don't align expressions after linebreaks
Date: Thu, 10 Oct 2024 19:59:10 +0200
Message-ID: <b55d5d2c14142fddad0b5bb84f41dd1c4eb6397a.1728582927.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728582927.git.karthik.188@gmail.com>
References: <cover.1728582927.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We enforce alignment of expressions after linebreaks. Which means for
code such as

    return a || b;

it will expect:

   return a ||
          b;

we instead want 'b' to be indent with tabs, which is already done by the
'ContinuationIndentWidth' variable. So let's explicitly set
'AlignOperands' to false.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index 684ab32d28..d655b08ff6 100644
--- a/.clang-format
+++ b/.clang-format
@@ -42,10 +42,9 @@ AlignConsecutiveDeclarations: false
 #   int cccccccc;
 AlignEscapedNewlines: Left
 
-# Align operands of binary and ternary expressions
-# int aaa = bbbbbbbbbbb +
-#           cccccc;
-AlignOperands: true
+# Don't enforce alignment after linebreaks and instead
+# rely on the ContinuationIndentWidth value.
+AlignOperands: false
 
 # Don't align trailing comments
 # int a; // Comment a
-- 
2.47.0


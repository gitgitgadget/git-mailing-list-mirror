Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19D1F61C
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237443; cv=none; b=VxUrdejxfPv3PbvYY9m4HrWjWsxh7cxXU6xOE1C51/ioVw+GCPTJYyComVieYTChBd9AX7uJ8/9p1nEA2Mt4TJcWZf6/HFmlAL3TkB08sHb2gVZ0y8su10q50HEQ8DxieRBWDcoS4ybEQho/k6fYh03WT1dthk2WwNPQlq/y158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237443; c=relaxed/simple;
	bh=cpT9Qju0MHDUFqvnGo5/H8rK0QyMW8nUgx+JnhutY7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cw1+0vxsId9W/pTHflaPbG7zLgIdndk5+FHwJhxHsVYKaTq0LX6FuSn5w0TymUmzMeFZu8sPDdkVR5rEqa6s9izVPPQSm4jdO+BdqsxjJU6vq+kwLkbICTDfH8yBe+kb22TeO8h53/rD8FKc63oeqJvTD07HsiXNcBHxPQDTBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkAgkoRb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkAgkoRb"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e740a09eae0so3329220276.1
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754237440; x=1754842240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGG806Cl+kvldpUMUfYXqs+Ylm9ghxVbNu+y4hlhLws=;
        b=AkAgkoRb/U6ascA+mjexLPveYFF5DcXf+N9IweaM1myFtwmxOeKPvm9wbjCb40dLLe
         zU/gZqjIH4jcfLj65nfF1S7+m/9PZkUh7iwY97yQuuAQNtqXe7v8GOxXgzq8VGL7Gp9P
         lHwXBv/qh/3Vs8kyhQ1BJc2AOzBUOwFjgVGHOXSoqwNRwf650//vkJQ5bdF0+TucKxnu
         XBpwM1Ub9+I3lpRr69pJo1JhIZS9IOnSgVk3+Y2XRbPHOq9TpBO37RNPecqrH2JNUSpm
         axAaKRM+6CzAuaBLpIi43049h6nbR+1ghtqAn1KQ69XhzjNL7+0J4uNuPpfBVyVE6rDb
         CWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237440; x=1754842240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGG806Cl+kvldpUMUfYXqs+Ylm9ghxVbNu+y4hlhLws=;
        b=Ck/8Sm14iSDvzWxt+Q07uQKNw1qrXExKqVogZP4uKSOz5UYvlUNLce7JVj5ju/tq/F
         ZvdGHfMco7X8kfB9iXESyanYzEGuqFWkXaOwxaTFVvXvlD7gnd3BpW1p7C6P6YL4eavI
         UPbWY+PuTiRHSxPHwPbCx7Hgls0XCQ8J5XPQoXXEOV5nNG4CvY3a47JiRyRlcR5r22TI
         tVbbU7Y83Io85DlD39veD3Kjj7lzxDlmcSTxcfjUdoEWgYzN6r8DtH+WcanGvu2G3HgV
         L9gU6PG8CYfz1sjWTgES56oBmSZjMmY1GHd9ADao5IPhmlOy6NuVcUpUQBFbxY6x+2sh
         Jerg==
X-Gm-Message-State: AOJu0YxFOgDei1elVfMy7P7s7rD4D4ZgOnXG3GMCH/+5mhBLCJV0Dmbb
	rO7nFuft3LXQhwb5PGASqIdZqSIcLMx876CH7S8GKpXOTlA1cXjtzXtXUJWpl0NV
X-Gm-Gg: ASbGncvvtYUZByngIpdw3QFFrYRJWkZJEh9AghBauVZFhu/PcRKUtrHuxXJWS41FhU0
	Xuxrg6PCjy4iQLJ/VpGZKyMSvdpIIn1vYl9clSUrVNwC2Rvs7Uznib56PS88jXwUz3o0mHqtTCm
	TCk0ZEuQg/Kl0ek0OVgTowpR2dDJayptd5IJN44NOhVN/WHKwBRxK2G7PGJpyQ8Q0yHD/YOH4kL
	B2IEqzScaKfo32u/XrDNkLFRAH/FMerJ2Xsaw4RakbG1U62ofuZ61LMn627DM5540xkSlgsla0U
	s2E8KFCG69v42QpeuiQxAI6ao4Gd8/2T+RdXdY8DFc1VWx6vQ/0kaqOopCUr/sFWsXGGPVpCU47
	Gl6dAkOruvMa1+oFfbZEPRv5IXHBuJaIqFZn0U9EmU4h3TE5dXA57uWYJ7cV2YvGuuQWYDVQ=
X-Google-Smtp-Source: AGHT+IH0R83FwDD3qLMnX+mq3gvIXRQwvVmA+shDlOqALEqq8AL1ZqpOiiUupIKG7fhwkFXgWe2Inw==
X-Received: by 2002:a05:6902:725:b0:e89:86a2:59ef with SMTP id 3f1490d57ef6-e8fedd8e668mr7231479276.3.1754237440354;
        Sun, 03 Aug 2025 09:10:40 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:a173:55da:e3b1:53f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm3100175276.5.2025.08.03.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 09:10:40 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/3] t1517: fixup for ua/t1517-short-help-tests
Date: Sun,  3 Aug 2025 12:10:25 -0400
Message-ID: <20250803161033.77696-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803012613.54086-1-ben.knoble+github@gmail.com>
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- fix instaweb test prereqs

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t1517-outside-repo.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 8a417af47a..3dc602872a 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -123,7 +123,13 @@
 	*)
 		expect_outcome=expect_success ;;
 	esac
-	test_$expect_outcome "'git $cmd -h' outside a repository" '
+	case "$cmd" in
+	instaweb)
+		prereq=PERL ;;
+	*)
+		prereq= ;;
+	esac
+	test_$expect_outcome $prereq "'git $cmd -h' outside a repository" '
 		test_expect_code 129 nongit git $cmd -h >usage &&
 		test_grep "[Uu]sage: git $cmd " usage
 	'
-- 
2.48.1


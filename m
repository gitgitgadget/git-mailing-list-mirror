Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303C2652BD
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873182; cv=none; b=SwCpDIHLsDOpkrYn76niwq+s3Jj125QE4IU7v8f0KQ9zevQpQNE1MldIeQUrit/Kd/yh3WacSaEa7X7ZNgIxQ6hBNmldo21sC+oGz8H6Xf1g9GjKBshniRNsoGofOFT+qvnfL1v8wjpSIqFK+BzBAS4tUi0lNESvXluKkBlIiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873182; c=relaxed/simple;
	bh=wZjAnRu60SKzyLVeTJ8w1JAUjDSmYgk/09lS3hiCxH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3sI7yjvh9kyq06ERN9MCJirSKLJBxyUj1CCEf0fFXl4yTBhnDRZpwfmOl5IyQFR2O2dnGma2DYYCct/InYRCRmZlYVmChRFS7L56kvii3JztYboJU6ZR9ddbDxl7ypn2742c83baGoKHb/1oCMY9SuJue55CTRt6xjhG7M2nXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gOzBaW3n; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gOzBaW3n"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-91122373653so285933939f.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759873180; x=1760477980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOPJQVqbaJWxQv4BL6yRjtQGbpyoSpefi7ApaqBhsLw=;
        b=gOzBaW3n38Bk8E+WWRig+b9SstokOlLBHVNaJ/jxswfVqLxhG2g2T09EV9k9ctjaw3
         4HAzNpqGG/dqR51j+JC4Fa0aEJnX/hWHBdIOZYc6FeztlSq/RmJh3GhcKEYEz4QNKTl0
         jxr9XiRMLt1dOGH85ibHIYhKqK0UJgtHxdLsTHGKkXL4qLOBdEhMEyEuc4HJhOCad39K
         5S8otWNDpy3ev9fWuTinzo2GiyznX4buoqRVe5Sh7Gsn0QfeCydT1sqYZlyZJfsnAOIf
         pCoNaycj40W7IVOL3p110Hfw7RO7Oxp3J27Pcs5vn9M54cxPJXDphFkqs7UXxXbSUVOK
         kBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873180; x=1760477980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOPJQVqbaJWxQv4BL6yRjtQGbpyoSpefi7ApaqBhsLw=;
        b=pDo3rLJDJmjS3nPhiz+y7tP3oRUEtyUc25F0C8qrbOZ1FPtZTckbIAaiMnqWjz54u+
         cgdiCeNRRbHaS5SQnkPqTvIeXVk1VvFrtvTj2xoIT3q/N38Gp7ZZnbChEQ7q41QMo9wT
         ZPq+bMFTB9WmZvSJJAqPk+NohgopLg8KYulBDdhryWjBMlYep04UbGhUTbEOnPcExywY
         D2aPI7/yctq9X/GX0dL8aKczpLeInwwzVSV0rGop2DoJ+ugtrPhB6XBFffHdxR+uKUj0
         AYx8YA88si4XELIIb9LrMRpNgP5HYgLQAkqsEB+WpEL0KwICtk/UlugwGLhigHuyMUS+
         fMoQ==
X-Gm-Message-State: AOJu0Yz+tZaHvGHfy9atPoipX6tUKgW1fYGm9sXewU1bKRBp79kyi7yU
	YFGpx50bqJphtJHso1vef5muWupdW+KGNkfjDBCXwVDmmtjPbIOUWh5QAc0HKYJozmIT9TbN2OS
	zB1DS0/vMLQ==
X-Gm-Gg: ASbGncs82wt5cbVDsrFX8N98FE5KKUQNMa+3ubNm+AxHz9j7aFhoOVjxmspWv25u/2f
	+qbfCKXgV8AaXgpYLcoELx1pTdJMHZCzWRYaNpo2cX/NYtaeAvhBjzS6vykO5LjoAaNk4I9chEY
	/63KB++yfCGbSRu4fGW83jfRuk8ewKprxU4kqboEBUDys9+oomJ2yo6me8sNUL8g+tpdPfxTeWG
	V4kuMtIG2YqrY3rQuVw4k7bY+NQvlWUMOg8sgP3p7SlFdQ6XwNkE0eWjVSRrB8TOXhMXAhz3Sem
	itZtNSwWWLF3Jm+fA/LrSNjR+m9Lx5C5EDQmwA3g9o3Qb9cPF42pD3SHQWK+MNTu09fRCHL22ZQ
	vtblhBG347owh1alLDBqkQfGgpDBB7lC/x+I7W9eGCNWMbAPjwSFGqsYlTV2rengLkZSTTSofkY
	zog5P97Kr9hj32xZQp26hKN58zhwELeGIhohPHdPpujMYV+mrddA==
X-Google-Smtp-Source: AGHT+IGhHc2jQIm9lafCksXsDakdFbayQs9QKbkgN+xXyGk7MY7pHTiZjAgXGvjn7o77om1NK2gGvg==
X-Received: by 2002:a05:6602:3412:b0:92f:4e37:2f29 with SMTP id ca18e2360f4ac-93bd197730dmr93506439f.15.1759873179623;
        Tue, 07 Oct 2025 14:39:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a87bb84b4sm613035339f.18.2025.10.07.14.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:39:39 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:39:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] SubmittingPatches: extend release-notes experiment to
 topic names
Message-ID: <d7931dcc4380757cfd4c6f24b5d746da2294f40b.1759873165.git.me@ttaylorr.com>
References: <cover.1759873165.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759873165.git.me@ttaylorr.com>

In d255105c99 (SubmittingPatches: release-notes entry experiment,
2024-03-25), we began an experiment to have contributors suggest a topic
description to appear in our RelNotes and "What's cooking?" reports.
Extend that experiment to also welcome suggested topic branch names in
addition to descriptions.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/SubmittingPatches | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 86ca7f6a78a..f48688e3700 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -579,14 +579,19 @@ line via `git format-patch --notes`.
 [[the-topic-summary]]
 *This is EXPERIMENTAL*.
 
-When sending a topic, you can propose a one-paragraph summary that
-should appear in the "What's cooking" report when it is picked up to
-explain the topic.  If you choose to do so, please write a 2-5 line
-paragraph that will fit well in our release notes (see many bulleted
-entries in the Documentation/RelNotes/* files for examples), and make
-it the first paragraph of the cover letter.  For a single-patch
-series, use the space between the three-dash line and the diffstat, as
-described earlier.
+When sending a topic, you can optionally propose a topic name and/or a
+one-paragraph summary that should appear in the "What's cooking"
+report when it is picked up to explain the topic.  If you choose to do
+so, please write a 2-5 line paragraph that will fit well in our
+release notes (see many bulleted entries in the
+Documentation/RelNotes/* files for examples), and make it the first
+(or second, if including a suggested topic name) paragraph of the
+cover letter.  If suggesting a topic name, use the format
+"XX/your-topic-name", where "XX" is a stand-in for the primary
+author's initials, and "your-topic-name" is a brief, dash-delimited
+description of what your topic does.  For a single-patch series, use
+the space between the three-dash line and the diffstat, as described
+earlier.
 
 [[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
-- 
2.51.0.435.gf7a65e208c7


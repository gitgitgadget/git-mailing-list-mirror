Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E742FC880
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280471; cv=none; b=iIiT+OD/Q62VjDvu6m+BwtxgDK7waVhrILFUEMxb+X7Hwm/6mb8oijDR7frV4tkLaHW6GXAFCkS6Xq36anl9POt8qm6ssXgvJYNS2REcv5JNLFMdp8K117nKhKIYiKvI/Z7Vzo0qpHcrrwH4/nU/wSiKctk+X4/TG7F7pdSVAnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280471; c=relaxed/simple;
	bh=jR6EpnvhHnggM6QPlNOhc6kp6AuSqFW92f6Os83kS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wi3446tPGbeh12keDIsEAPgpBD3OSG/pbZJxmr66Dw90ljbAovRNLhcGZUYqbk8peMednKcWv5UZ2dLCpFu+Caj43ULrIOSEPYnKdzGVs9Bphuw5qAJBMEHGPXh4NJS1sts4zlbPGCSCj+/SRag7OuvSKLXkqaLzwgBVC/zaS1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POxMGvsI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POxMGvsI"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-784966ad073so70211777b3.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762280467; x=1762885267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D2t/F7hXRARJbSFVakoQpqu9GzDVexkkRbuuj/e7xZ0=;
        b=POxMGvsIMUOCmNNkoSE5SBzO9FD6eCxYqko0YeDK4pq2fEnUcYLbTNOuE0ADUT93Y7
         rBVpm7CYbrtNtmonYxxcUI7ybwRatgwLaw/i/Pg6zWvY/XnyuyDnXjMxiHQ1E0MKtuot
         7IBFVMTJTkPEF+voeA2Qt3/l6+HSFGpK+Hlc2T4b+vWT5PNF2rZui43IY6E6I8jggDwV
         Xc+YsSjPtr+DNLJ3czz3Pys+tfaCLZjtpqHt7iO0hgVHJCNcDfLnqB1MDfHGASX5AdXu
         v1Czxr0KMGdDanR41H/rU2EwA7RflS1W5Cu1W5Rsp4Y0keqcx8wrtdEaUWGOv9BoHshW
         vdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762280467; x=1762885267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2t/F7hXRARJbSFVakoQpqu9GzDVexkkRbuuj/e7xZ0=;
        b=nBmZGXxuTNrd9uv0qDVXWV0/ktB1jHCAaga3modss8cctGWntwVm8eNBRqRW7P/aHY
         dSeD+UxB/utPA/9iQgRBqKSIfHuEyM89eS/mBv92N+CABSoHl6kdPk/sPQSf6gnLya71
         CgnwoIUnUTdmRDeWMX+l/Yyphaae4sOBACJJ3ijGdQZkwapihODCKQxEJ73cBdhb6ROM
         IcCzjiQN0o/6wwrmB5F/QNppZoxPDaZ/js7Y6sajDdoE2Tt2p34ds9WvCIb550GTbcyb
         TN+bDbLCujMw0wY620dM4rMk5fn98eC8UQ584BGizPhoWLpzCSmLpNJ0eezY7LqYc43M
         WUEA==
X-Gm-Message-State: AOJu0YzeNYOdUlprovs6OMDS4/qVuYCf+xkOMROp6QGqHHqgAfFFEDZI
	8KzdIVo1ARwM3KwY/oVlFdoaGed8uI7GPx1OcQWThP1taOiNA0Y5DCJpX8GRElgj
X-Gm-Gg: ASbGncs7l/8yfnOjzPe75bAUVmIQ0BujlSGYZBx8R1NGuzTTHEj+fJdaGMCVCs+d5VX
	97RN9yQsRhqu08RRTTyYw91OOJh4iu/LugtHV5w3GRPk+aRMyyWPkItj5UI6A+ozt5wD9pzCpGP
	N3I/MyGm/wT+5l3lIhnoeJwsKCUr4/Qj1vTm+LoO0h6s5KsGC/k7d7ysJFHRHIfHipH73ycCRga
	DCbxQHp8Ms6W9i+ZWXH20XRW4k+ppWlHtjvxfb2g+N+iUn7qxPwpup8yYJu7lwrzKFoC9gO6LeA
	HyEfiiq/H9NMLTXHpeyBnblbJtYUOyCn795VP9PqPhCTyj/BhLQOe5EJ4dW7u/USikFpUy6KsF3
	VcILhx4y28/ot4baPJ3BLnE0I8bYIZDvpVyTRHDVstSbgIUy5KzFa+u144l6rrgC32oTfpa6OFx
	NHuj6EG3vCOF4Dz6vLQXLEFqikptQ8oz3kXeq6gw==
X-Google-Smtp-Source: AGHT+IH68uU3afTTj2Di1Ml74W8laSJha6RW/JVE6xPKghdw8NeZGHbbbCdL4ou37+spikU3tbNsAA==
X-Received: by 2002:a05:690e:1551:20b0:63f:a87b:2066 with SMTP id 956f58d0204a3-63fd34c4f47mr395530d50.16.1762280466592;
        Tue, 04 Nov 2025 10:21:06 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90a8:8b00:2dc0:ec5b:d324:2217])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc96086c3sm938008d50.25.2025.11.04.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:21:06 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] perl: also mark git-contacts executable
Date: Tue,  4 Nov 2025 13:14:57 -0500
Message-ID: <7fbb341e8f05fcde3a1543e3bb4e5a3ec1101692.1762280097.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When install git-contacts with Meson via -Dcontrib=contacts, the default
Perl generation fails to mark it executable. As a result, "git contacts"
reports "'contacts' is not a git command."

Unlike generate-script.sh, we aren't testing the basename here; so, glob
the script name in the case arm to match wherever the input comes from.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Tested like [1]. I was surprised to find my packager didn't have contacts
installed, despite it being requested. But the issue is upstream (here): the
installer doesn't mark the program as executable. I wrote this on top of the
patch in [1], but it should be independent. A quick test says the
prerequisite-patch-id shouldn't bother application?

[1]: https://lore.kernel.org/git/0423F0C4-D0AD-471D-9315-FB208A8171B4@gmail.com/T/#t

 generate-perl.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/generate-perl.sh b/generate-perl.sh
index 65f122ebfc..796d835932 100755
--- a/generate-perl.sh
+++ b/generate-perl.sh
@@ -30,7 +30,7 @@
     "$INPUT" >"$OUTPUT"
 
 case "$INPUT" in
-*.perl)
+*.perl|*git-contacts)
 	chmod a+x "$OUTPUT";;
 *)
 	;;

base-commit: 7f278e958afbf9b7e0727631b4c26dcfa1c63d6e
prerequisite-patch-id: 664e4667d11a226a89da52814505a0c8d31b9fba
-- 
2.48.1


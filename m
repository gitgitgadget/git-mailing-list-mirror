Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BE28EA72
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759262326; cv=none; b=l98xj5iPuKqOv7wfGJS/1OFeoPcXtHXAHcCRLurdpeJT2LWkVyGpNSJO9awECvrr2K8dAMBFQt32Gkh2hM++/xoif1JYtG7ZW1Ejax+etigQJ/3p7QN3lKpG+KYB7HxS4lYOpPN0WGmQw76+j2deIFyH33bwQR3+BqUTh+rW8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759262326; c=relaxed/simple;
	bh=6W62+P2mSWaEndvLGwjeHaLI4EIgutPw/7kxBxgVY+4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MwavrAZQ2ZWAfWXAOoSGXUbXy7e3RtMYZiToYYJi9TP2vVZRNoyTTWaocVAQGRzOu4/GEmXUdPOm975qBQ102fn1Ho9+BEQqD7AkoM6UbNpMxV+0UqXXTOc5MxsxbcfKcBahkViZPhsI6rVPW3APwfKMx+zH2NoQOBqcQ5qw4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJLDgWi+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJLDgWi+"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so8138017b3a.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759262323; x=1759867123; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxQjw4vWKgnQO+MSiJVgHUBtvL0z9oqQhUKtxvEzq1M=;
        b=IJLDgWi+WNt8Fp/3kay4qElT8fXc0kPkoHxvWbUqLR9fBTa4Z4/esttFwxfoPNQutl
         0GUSvUOi/PdR2Hd85FzMvJ+sju6450efDbyzK5/Ud0Nq0IUyf1Ex/HW4Zst7m2pPVemk
         YxGYmPxQqAVnH78yQfD49xdKEsO4a5UBMHsoQwwTu9J8F9HBQsP8Qkhxhx+WM0kEGgza
         dLspNBOU7EC3jALZOVZhzxKYtBC7RF+kLB3P5TUM9bJmtQi/vFkAnx1nGkPl8D/9JZL8
         CwoO0ypDC8UYtQCLXU8vLt+GT+6hRTh+zcz31LU59IZZunCJr3+f8jVDQ228Z+lr2DBB
         VFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759262323; x=1759867123;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxQjw4vWKgnQO+MSiJVgHUBtvL0z9oqQhUKtxvEzq1M=;
        b=NxwO5p8nuxUa0OtdpKHmn8e+zWo+t4fzvBa84oWGxf7e46+tpjIkqtSHJiwJ98ScEL
         9vzmXFR+qQVvXQUFi1vnHgV7vtwEd+uXALiWS3rOPtD8TFpn7yYIHLZELYvVp0s03bUV
         FmU1lHwYUy0FDFyKqLuyOnMOe/BqHGg6r3049GA5Iv7TEy9x/iU/6ZSCM848Ut2OzYOW
         VUkKd/Ewilourf7yWbRbLV6AaZYSsCzaLTAisWu2P0qV+xpI/pm1Wt+SkORS8O/rTgkQ
         Z4jC+LuUCa7evi1j3T5CCRUt19l0KP/AF/ptvwZ+gOV4squswM6Qb1ZWCvOsv4JxdVS+
         Aj9w==
X-Gm-Message-State: AOJu0Yx2Vqpw05SQhmifbfKF5bJJmh8y/WsUmEB+TNmNDW2mSMzunWyw
	5X1I98p9USPXJWMYW3/vw24sZBfJ3JKOQmI6SDb+gvALcs0L6jv88Flyhjwgp1YU
X-Gm-Gg: ASbGncvKC0KJ/njSGVjqvJO/jg7bh8S3NCApZjJwS216zSyUOI/GLrgU8lUtSf86phf
	bONPyOSiGOFBbLp7bEsU/D2x/oJS1e6GBvAF3D6eCMoZmu7yiMFhwpf926ZXBK5c2bYVwAqI4lx
	J5kbBMIJhutTz4vezunhaP3hyMFAcEQDbn9Bk/VtCzPuFB8NRcQPqF3FV/ksTHszJVSfRUgQeKP
	RmFmzb9pbDmFw/IrWvaBmaAKE6ch4zbaL2Yb0qd1vI/Y5OpVXvi7MxAleiTbjsyeFJa05izLXLk
	WFq7Sga6bnMH+m5uSS4Y7i0qywI4hr4W9dBXMImWudXJks/F4dUK7Cje18CljzkxdKRlXS/3RuS
	0TyyNYp2tQ3rsImtwpfMcvGsxTydyPj4JmSYGHTUSGXl2022qQVUoFuxC5KtP
X-Google-Smtp-Source: AGHT+IFk6nMSVINMIEXB82Bn9zUrNNocFk7oiuP5UWfANRjjkccC3cqvTvtcoWyC14IE2t14WKq+gw==
X-Received: by 2002:a05:6a00:14cf:b0:781:19fc:abf with SMTP id d2e1a72fcca58-78af41ef502mr713248b3a.21.1759262323405;
        Tue, 30 Sep 2025 12:58:43 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.210.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78127b4c3e4sm9249900b3a.85.2025.09.30.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:58:42 -0700 (PDT)
Message-Id: <9435f0ce8db946b6b3462ef9923503ed359b3379.1759262314.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<pull.1964.v4.git.1759262314.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 30 Sep 2025 19:58:34 +0000
Subject: [PATCH v4 5/5] doc: git-push: Add explanation of `git push origin
 main`
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

What happens if you run `git push` without any arguments is actually
extremely complex to explain, as discussed in the previous commit.

But it's very easy to explain what `git push <remote> <branch>` does, so
start the man page by explaining what that does.

The hope is that someone could just stop reading the man page here and
never learn anything else about `git push`, and that would be fine.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 2848cf2e1f..c0e743d4a8 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -23,6 +23,10 @@ Updates one or more branches, tags, or other references in a remote
 repository from your local repository, and sends all necessary data
 that isn't already on the remote.
 
+The simplest way to push is `git push <remote> <branch>`.
+`git push origin main` will push the local `main` branch to the `main`
+branch on the remote named `origin`.
+
 The `<repository>` argument defaults to the upstream for the current branch,
 or `origin` if there's no configured upstream.
 
-- 
gitgitgadget

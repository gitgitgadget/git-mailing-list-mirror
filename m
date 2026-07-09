Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14613A2E28
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615803; cv=none; b=FI70aokutqYOpSIoyctCGBH6PanyFzO4ewRjfM7KiHBNrvNGfrwmBLlo+b91zin5AhT64vtBelronTMga1ankRSjcJ5QMWjnnERcIJ2cRMRGpCR5WWAme6YLe9m1CnKEJ3kFFV3jWFG0T+HHzjtXZtz0QiiWLV82AB+r9Abw0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615803; c=relaxed/simple;
	bh=pPekW9qOM7pyIwpgoPniszzSviuHflUCmCoxTFYvpb8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OK2CqjtLrSXVOnRqnK044JzuTe9UX0nTftdP2QA5QCXHmYHBDvRPFMK5fB86jaVeWOhlQGrU+uNWXMQ9lxal/u71gjJoGxdFupdppls2QCo+xEZlh8gp5gCnHJNitSRD4yIR0O8PFWtVh2/xsYjlziPiltPqt6I/8tLeD8MFN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q97Hz+Go; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q97Hz+Go"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37df72c9984so141571a91.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615801; x=1784220601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+JAFo4XaUb8UM465OfTu6TRpdGNlhdf1+NJ6YJkRsEg=;
        b=Q97Hz+GoB50Bkvq1q5gKYdcNmaQzy+KRkbcbfh7+1mRe8jEksOouTNQguZqtkF/zBg
         jmKrp/0EDDqUcm8jG2YIjgdEKj/80DIdusWitZUYHYefCbRpXi6gYktRycg/X5kol5TE
         XnaQWY9xDEz4mzqQ/w6PlBhB8AQVRqCu5F4nV9eUi3396irWCm+kmEi53CvQ6kO1A5K2
         wTn0FzcVcTnDBkE2BulWdvNst2v/AaIScrTH1loeZs28liBTrtkc5l0+3/3xvIP9l4LH
         vr0CXyPmFCMi3ZDduPkrvrYozOSeNwVmbcpyA9dbxW///AwjUX5N7mmpFGFJsoP9WlsP
         8Zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615801; x=1784220601;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JAFo4XaUb8UM465OfTu6TRpdGNlhdf1+NJ6YJkRsEg=;
        b=KTCmUab12VuLfKdvGzF81Q9JSg//2UvRLNCljkWtkERN3bbh00roG+TwN3vxYQ786H
         +wNpa8AXM34P9U9D7nGXCIyGFBbdk59kSUXULjlXS9NBl5pXH/Qc7dscwv8iFcVcJs8x
         CSvj2SiZ156cGf4ZUBSiMgKu9Eac1Y4z91NP1/TtjtyEaG3zYO2NbZE1awTDLfXGz5Ke
         jTrV8aLeidM6w64rSODofWEHv9Oq6Qdkj/om3r21Zajo8IGWDB39zM91FqKXiZeT1pw1
         fd7K3iGC5hehaUfCd/WdkvKKw7cvSuHn1ljpq2M3MVkKPb7z+esDkX6m/cwr+nK8xiXP
         ZAFg==
X-Gm-Message-State: AOJu0YzKklYTGfRu+1XkFe6PX4XMtyACKpeTFQ80VryQ4CvfY+lVeWxB
	qyNmAPaHXGO+nIqilfKHCUOVcJ1Jk8BISVDChm22fHwnZn5g2Oc+YlolRHKrIw==
X-Gm-Gg: AfdE7cmOH1LvSaFvosvG02Hc+xuPzOXE1ELv/sdzrJaTmNOYHo7TKAQsl9W8dQ/u6S/
	MhX444pgLh6W7R4R7wvF9NXZy+nCKVASOw7ffTl7sDRSCSNLiFaXq9+adMoXgpztFqaT3/3hCtj
	xA9IRxp/jP9S0vc96B5bw4YRwdZ+Yci5ezy0sPI8LukIUmXcwhaSNC7PcodG/DO8sTqZvYLKT3Y
	O/oohbBYqFyt1wKt7MxustOJ8d42S3Y0RUTOovui1ITTkG58kt6L83+JMF5CPoVKjHmR31WULYG
	gd2gZw9hKZoL7dSRZiDqvBbExCtexea2K+gcqd+puRkpPap/GvX2eMvGjX6FGtSPmvZJgjg0Qyb
	LzO40SLxs5klAYFkXfGn31s3Iv+DDwlQ2hCW2HJQC63ZXYimnaZl1qPBoxculzUIexbXZ2/BeGY
	vDgVuThvWLkY1HotM=
X-Received: by 2002:a17:90b:4d8d:b0:381:f7a:2e0d with SMTP id 98e67ed59e1d1-3894249935cmr7065241a91.33.1783615801290;
        Thu, 09 Jul 2026 09:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm10419646eec.22.2026.07.09.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:50:00 -0700 (PDT)
Message-Id: <ab911cf55647ed335042f5ac3a6490c36c3ef1d7.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:39 +0000
Subject: [PATCH 12/12] git-zlib: widen `git_deflate_bound()` to `size_t`
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

All four `unsigned long`/`int`/`ssize_t` receivers across archive-zip,
diff, http-push and t/helper/test-pack-deltas were widened to `size_t`
in the prior commits, and remote-curl and fast-import were already
there. With every caller prepared, both the parameter and the return
type can now move without introducing any silent narrowing.

For inputs above zlib's `uLong` range (i.e. >4 GiB on platforms where
`uLong` is 32-bit, notably 64-bit Windows), defer to zlib's stored-block
formula (the same fallback it would itself use for an unknown stream
state) plus the worst-case wrapper overhead. The existing path through
`deflateBound()` is unchanged for inputs that fit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-zlib.c | 16 ++++++++++++++--
 git-zlib.h |  2 +-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-zlib.c b/git-zlib.c
index d21adb3bf5..ebbbcc6d1a 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -167,9 +167,21 @@ int git_inflate(git_zstream *strm, int flush)
 	return status;
 }
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
-	return deflateBound(&strm->z, size);
+#if SIZE_MAX > ULONG_MAX
+	if (size > maximum_unsigned_value_of_type(uLong))
+		/*
+		 * deflateBound() takes uLong, which is 32-bit on
+		 * Windows. For inputs above that range, return zlib's
+		 * stored-block formula (the conservative path it would
+		 * itself use for an unknown stream state) plus the
+		 * worst-case wrapper overhead.
+		 */
+		return size + (size >> 5) + (size >> 7) + (size >> 11)
+			+ 7 + 18;
+#endif
+	return deflateBound(&strm->z, (uLong)size);
 }
 
 void git_deflate_init(git_zstream *strm, int level)
diff --git a/git-zlib.h b/git-zlib.h
index 0b24b15bd0..9248d11ca9 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -25,6 +25,6 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 #endif /* GIT_ZLIB_H */
-- 
gitgitgadget

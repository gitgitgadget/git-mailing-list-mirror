Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD044EAC7
	for <git@vger.kernel.org>; Sat, 10 May 2025 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746849035; cv=none; b=dTdQZ8ZJWm2V/fM54t17h03oxUY9mTdgpjqnfkQ8gATMSbKDHWbgY7SLg1Xj+NkxDI4koslAF92TL2P/33PkKzXAtHImkNmfRrVKEccq6L1A9Mt0+dzFYEmLxPdAR/cn2rC+OqWRGZwe8XbllLOUxV/10/PD2KrnnsB7xqRsKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746849035; c=relaxed/simple;
	bh=5Z5bOCqyD1sBuL0tGVJmF7llGc6vKT8FPPWoXwxB8S4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qOsmPOeS9gJ3s6M04ltv51Hr1c4vXnirfhytHmN0DTFgsLTHuFzwPIxkptU3xcWKgQoLh+ZMJkzKDi+J+wyiqfPIhr3W7r2mUGAHGRzT3itGa0E5flIp1eQj0iynsy0fmnq9lyfCCdf4YSpF4Ws+rTQj9ArJxhShOMFeSk1zd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWjXzKut; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWjXzKut"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso1565984f8f.2
        for <git@vger.kernel.org>; Fri, 09 May 2025 20:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746849032; x=1747453832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rO8VCTLiPwQ+omdD7gvKSHczSXCXVVL9TJ0DInHhsoo=;
        b=eWjXzKutzTHVLbG/cAeWmDRgVyMjqRcdcQDVhRTb5ZYr+Dgsp/cvEdA6lDe7HAObDP
         tqwd0SbYkeKoKkxBG4Uh6jhzYdwiO64ko3hyPLodD5iZcZmRsBtUaX3P+v6nbDwCKnyV
         jpCqw3UhNqNmyegzxhoBFMx1PgqJQQ80IodH2JmpN601LA+zAp2Ua4x9Rq3apay6uX1D
         KkwaMmlR4VAXB3cdrlwlpN4oMKdTkVCJOiJw69P2XtEJo8UJoMklUeMoKfUJAA6kfaxU
         jL46V+7a7/P1QS8FmMatLudH9oOn7qTrEu0ZzO5SIEadbbx1qZZiauAyFeYJikemkJRs
         hpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746849032; x=1747453832;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO8VCTLiPwQ+omdD7gvKSHczSXCXVVL9TJ0DInHhsoo=;
        b=Ras/EKfAMnbSngp1OfaNi7GxNQFFdEog/IwcF6xnne0FYKFjpbv2EFI9JpyvTMkdd+
         mVxrpeHselsq0oakA0AyGq0ldhAJEcea1vfqGwUMDkYN5iq8MBORPzrm4F9wTvjxuG0H
         s73qgskdrzwBd3r359J4xySV3EPSbs+BpgHjgUkEhbfztDp1H0/kBTPppi7wHdIuuHOc
         bI5PljTW7KtQeizN3H9qZzRq8kaJ5a1SAR/JShcSBMM/pn3jn+BWPgm2x48hWAg2sx4x
         kOBu9bHmseO3+GJ1jEGCNNOnkwXYLXVL6w2mjvgHlx2KtVCAqJQc0EQQhHFXTLNJOGFf
         U3Xg==
X-Gm-Message-State: AOJu0YzHtcxtnOrouQkEvik8Z2Ex8Tqf+th5LqHGt0iPAwqVmrEkhuP0
	IwfLqEDnP8rGPpY7ksp7DrRKm9RyKWyjl0AbDuDXmocIqJw9LCq96//j4Q==
X-Gm-Gg: ASbGncvVGuejTAGVRCBYczxvrPWDxMQ2vrEkvYDLhWkDW5pci2Jaw5Bd4B6/sH4ii8Q
	Tl/3eFuaatmU7SN0e9t9VDRY+HRw4P700fEEluYEvBaQMDYRJGh4ZCYS0TgolJRfuo9zR642mlJ
	bHh6+tVJ8ebMsTw4s2crR7QLfziqXN47bTA6L2drsJ/RqAaz4jGsBYVMu8UpBLow13XiHSYJlPh
	SRJVzq11pBMMvYi8uMCKpkoyLibFFs7InuhxAkWaGs53gTvTArUBmU5ha3h3WxZSUT0wVafb5VT
	SezFyltpeVpyZVZBruWEtsRkbkyYfkktVr59T21nUhdD1y0kcCL0
X-Google-Smtp-Source: AGHT+IGeEoTweJbJJQC2g5uIFU6v7i+c/beY0apfrKc8An8leXJSCotCp1cCDrRonEZgKRLo9zDRfg==
X-Received: by 2002:a5d:6489:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-3a1f6431452mr4040658f8f.16.1746849031622;
        Fri, 09 May 2025 20:50:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5c5sm5208012f8f.96.2025.05.09.20.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 20:50:31 -0700 (PDT)
Message-Id: <pull.1958.git.git.1746849030749.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 03:50:30 +0000
Subject: [PATCH] reftable/writer: fix memory leak when `padded_write()` fails
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In reftable/writer.c:padded_write(), if w->writer failed, zeroed
allocated in `reftable_calloc` will leak. w->writer could be
`reftable_write_data` in reftable/stack.c, and could fail due to
some write error. Simply add reftable_free(zeroed) will solve this
problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    reftable/writer: fix memory leak when padded_write() fails
    
    In reftable/writer.c:padded_write(), if w->writer failed, zeroed
    allocated in reftable_calloc will leak. w->writer could be
    reftable_write_data in reftable/stack.c, and could fail due to some
    write error. Simply add reftable_free(zeroed) will solve this problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1958%2Fbrandb97%2Ffix-reftable-padded-write-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1958/brandb97/fix-reftable-padded-write-leak-v1
Pull-Request: https://github.com/git/git/pull/1958

 reftable/writer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index cb16f71be49..3ceb3742888 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -57,8 +57,10 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
 			return -1;
 
 		n = w->write(w->write_arg, zeroed, w->pending_padding);
-		if (n < 0)
+		if (n < 0) {
+			reftable_free(zeroed);
 			return n;
+		}
 
 		w->pending_padding = 0;
 		reftable_free(zeroed);

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget

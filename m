Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC7224B12
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914420; cv=none; b=ZRJDJ+uqh8+WMCC67Ewz7EX4NDdQw1GO+ydfbFTfNMkk65hlykFF2VkQm0goMnsWQXRq6j4d0/1JIWx3drzd3hcbWg9PRBd4YLfllg5tl3bS+wP8db4ddAydLr99YN9pUL8egNDGeUwtS19XjczEaTaQ1KDJKOphZUKKX5m4gIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914420; c=relaxed/simple;
	bh=Ci0IGeiSXqE8gxO2e8sFSaFghb7UqO3Bu8LFuDieZDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=sxV+O3xXSS2T01yjWc69FYprJ98boADDhBIrQaAy28lxoLcSr+HmqzvX9FDvyHauopbPWjIJ0G/iaeJV021hOm5oRym0JrfRrcHx6b0EQ5sxd6obLDg0aEn2FmjQBGyfARDKxbdEuS1pano2SczkiiA+qAFYxM9WoZdj/7Qag6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy26szEI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy26szEI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so2830957f8f.2
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751914417; x=1752519217; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=Uy26szEI2eei+iPKvfSa6tOlEXxH0MOEcn58ItmsSuGEe/CzcyxWNdO8Vo4+N4UoV8
         09H9rEbCQWdsSBtXfFx2+O5Vx1zWJj1axvQ1zRkJAbfNS+riAGkFClA8wE8NEeKttG84
         ysCxsoAHnD8Itk+jlBZP5VPU9tsMTsP4yLVoIkQodCs+9/pTb94Q+Df3QP4gBNYzSk1Q
         tjoMqvNp1Lbw8Bw03wia1zjaKCKARxouLpwcUKmmwcSQzJPy6qOGW/w99mAQviMbozfv
         vTHMr/Rdv6o75N6NH6vDMvuBHI4c4cZavFkCpLCsqpQBhqIUj9dSPewi1Vg9+S5ctiwK
         I6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751914417; x=1752519217;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIuc7HQDmJphmTaGbeQ7G5D/RpNeCF1tIJ26RTyrN1Q=;
        b=wi2w0t6AXg9vrlJx9YRzBjKk3w4gTxIezT0hD0MwBpMTTOYIgce3n6aa/TI1J6wTv8
         Wb5SDQZDdS1kionAiUx4Qyjpxk3qaTiCJ4lo/87GKrXvuxcHPr9jI6GE0ohfdZjwUfKD
         0sqzz7odcjznUd4djs1XEQ1LqkJhRi424lKb1OAKAT0fyQ5wmrPmYbJuVLlIUC6Lmxr1
         hIl93i6x3AbEkOJcL8DCNsh3LICvNIf2ASHNZfsVZQmAvjuUrJ52oO1RaZuUgN3tKp3W
         Xk6gUUW0XRx5ahAKlHtmq4Ax/a8T9LId4bA2VtTLcQ6pYXXnc3U/FBU4bpG5deFp62Ne
         JIyA==
X-Gm-Message-State: AOJu0YwyCb7qgXup4EfEsOFbRRaF0nc2Yjieb3BrsB9a+Z60BDz7G31I
	EVZ5o130v8+KGAh2NHCY29InkyyoglL8eQMC3Dh0otVGlyeDSkzIbSEgZFWM5Q==
X-Gm-Gg: ASbGncsA9rji31H5ugqPnStE9G6KiNh0ljTNY3IrLnx8ajxzznN0zNqKBO8ni0V79xY
	IQX0Vl1fxuCSEzSL28rUnDf0v+xEQ7DQUH9gf782kaw400UlCeMZboHXCUyK+tkIlSPTzsW4MNj
	/jaiqxfilFNR9A/Lnk8APNJnaOK9YyCjgbMD4MuwVFbZaOG96EY9K/nF/PDxhGXLyR9Cwr9JJBN
	QKYV3Xybj8Rt+//lDkWR6mK88nAK5CbF9gjSQJUV1dd86SgKTacQJaArnLNLJfHasSqr5GsXtRF
	MugN1IJucy/u07FyDboL+2eON9Ei9RoP8/dYJw3xQOdtHDKaxmu76rgILRXPW/E=
X-Google-Smtp-Source: AGHT+IHzfATKgDinEJkjt8ELOU3RWTlsi0+NPiLKSejvtUNui8hW0OaGXFoAiYPOBWtgzGtmz9m21Q==
X-Received: by 2002:a05:6000:26cc:b0:3a5:2ef8:3512 with SMTP id ffacd0b85a97d-3b4964f9e56mr11619202f8f.14.1751914416859;
        Mon, 07 Jul 2025 11:53:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd42sm10783249f8f.5.2025.07.07.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:53:36 -0700 (PDT)
Message-Id: <9b52a62204ca7296da51c6f3bed25f35feaeb9d7.1751914412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
References: <pull.1933.v2.git.1751203241.gitgitgadget@gmail.com>
	<pull.1933.v3.git.1751914412.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Jul 2025 18:53:25 +0000
Subject: [PATCH v3 2/9] doc: git-log convert rev-list-description  to new doc
 format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Use `backticks` for commit ranges. The new rendering engine will apply
synopsis rules to these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/rev-list-description.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-description.adoc b/Documentation/rev-list-description.adoc
index a9efa7fa2722..82c680e57013 100644
--- a/Documentation/rev-list-description.adoc
+++ b/Documentation/rev-list-description.adoc
@@ -26,8 +26,8 @@ endif::git-log[]
 means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
 
-A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "^'<commit1>' '<commit2>'". For example, either of
+A special notation "`<commit1>..<commit2>`" can be used as a
+short-hand for "`^<commit1> <commit2>`". For example, either of
 the following may be used interchangeably:
 
 ifdef::git-rev-list[]
@@ -43,7 +43,7 @@ $ git log HEAD ^origin
 -----------------------------------------------------------------------
 endif::git-log[]
 
-Another special notation is "'<commit1>'...'<commit2>'" which is useful
+Another special notation is "`<commit1>...<commit2>`" which is useful
 for merges.  The resulting set of commits is the symmetric difference
 between the two operands.  The following two commands are equivalent:
 
-- 
gitgitgadget


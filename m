Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BF158DA9
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699826; cv=none; b=a3Ow74HXAQ7vzpplGE3KlhFqc0hHtBXr9+DVWlEQPFj0t1bIjPs3mTyB5VZe+pmYT239KbX5ymo2xY2rkQJ0dHtvQ1WviJETVHZ0rp+bGahONKc/wPFMCUzTi9HLOi+aY3xulH7+IfYv/IIJdZr2WcXVghaea4+w6PgUIj8uVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699826; c=relaxed/simple;
	bh=2iPz4dlX8jpzRpeElSksbzrkIa+iQJpCgQuiEceurxU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PjSInXkPwO1easA+TjeQ1U0ezeEyjEcsfz3doje/dD2FOYcpEDvtuu1ZjQXDpiuh7eP0spxpGWjm3n8FaIFWEruDs3398n7LYa+KyZxoHsMYLigTr7xkxjYRlv7IzRajSnWZQBP4w5r7u/t694tUIoEO2L0n1gCyHPraMsZbbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8lSB5sp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8lSB5sp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso4433343f8f.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699823; x=1713304623; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SFXfkxojmDlP+99gjHbt/LwyX0Yxr8umiMvLxJswPU=;
        b=a8lSB5sp6pfIvdVzFpGlGlOzYGpMjww2Jv4JOJ2PmW9vknLI6X21vQh6RAm1Web+cN
         WRDpfXJf2Sy8XSq3oiBywTvYogVfdmb2D857iAm6hE91W2et8Rc8LZ4hf5NE+iNb7sFY
         HkMhoqvugowa4LXuSdAH1QVSP0eqBYVvAzMdB3zAdnbaBWjSKeP6JZOiX/Ak+GfUAPaH
         2Sev89ltAxHwcQL1q2RXCSWh9ErQooqHi6O8PSZBDCSb8/+ALAPAWRX3uuNwGskWHH27
         rbYb9uUKzf8INfa2nkiXmBwg/zyKXI2lhm8j71RkfBUlciq+Ua5sZMsKuDh/dyTGgZOP
         KUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699823; x=1713304623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SFXfkxojmDlP+99gjHbt/LwyX0Yxr8umiMvLxJswPU=;
        b=ISZetU9lz4kCN1BgHjeYSr5AGXfzM14yFkhYJKSkNA8vV18uWQ3mP205hjUeNqqF0o
         qG3can/0ererGQc6tZ7cJ/OYbtcXsx7eZXdZh/O47yf/D31D2Gx8cYk6sfIS6dbpQx+g
         QuU8y3/XWEf6M9Nm4E7ZcZlumV5ZzFbYTR0QSeU7G8PkOUD+RcN04R030nQCb2eodRok
         wbdIIsyYEC+61Jyn6fzhgNZ9L+9U6eix4cQ30BihD3d0wji8MTApxauqQ2tNFWLSVuW7
         sKvFCh3SHNNyV13GR6GXFzRF8Knd8LsrHH6Yge31aH7eJVHR4totuFabuUaiz4Flncda
         tgOw==
X-Gm-Message-State: AOJu0Yyqjq/IZFv7Egg3OrRx0UHEJs5Xd6lQSttwK/g5f2Pe9/P7pERr
	8AVM1wfuVJHcaqvlDEr6R7geHRgmB1vObKav/Su6wGDosTxgkpo7ibMQ6XbZ
X-Google-Smtp-Source: AGHT+IHB+8TUa+KNcxr1aMA4skNCZVL3audpIIcng08XeF2/Ff3acNGQy2R5CstqnK/HFcuhFQcihA==
X-Received: by 2002:adf:e488:0:b0:33e:bc7e:cadb with SMTP id i8-20020adfe488000000b0033ebc7ecadbmr583419wrm.41.1712699822960;
        Tue, 09 Apr 2024 14:57:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b00343b252b096sm12363262wrx.23.2024.04.09.14.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:57:02 -0700 (PDT)
Message-Id: <f5e44f69941df50938d436bc0fc726aa4ca49264.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:53 +0000
Subject: [PATCH v3 6/8] SubmittingPatches: dedupe discussion of security
 patches
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 392bbccc452..98ec8170aeb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -399,12 +399,11 @@ letter.
 
 ==== Choosing your reviewers
 
-:security-ml-ref: footnoteref:[security-ml]
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
+NOTE: Patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the `git contacts`
@@ -427,12 +426,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
-
-Before sending any patches, please note that patches that may be
-security relevant should be submitted privately to the Git Security
-mailing list{security-ml}, instead of the public mailing list.
-
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget


Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AB1E00A7
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396742; cv=none; b=vA0NFNbq+UEgkK0xPXeX7rEQ5doYzPDi8d1mtQk5AGvIuwXmQvl74RDMq7phFF3+uadaYlAM58KYenrU3XAxz8/5TqJ3XRt8C1GeYd8Ej/1XaUJBm5k/8X+a8vcT4QtpQLGSl8RhGR+jSx/P3qpJiZSw2d9f1EQ4l8hF6KURB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396742; c=relaxed/simple;
	bh=BcMziYdYqQFne/OUXTQSV8fKkubc7U3OipYPc7gvCpk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tzG6vajEUs90rgUl4ZhqHvU3rjyNEotdWJROcqOCyZqCtnIvQyYRj4j/PaoNHsmTN63hSrchPzrdThf0vp5ALHPEfeMKBXP1dgXS1gS9pECsgaoy3SjJKXadXTv3D85Iato8CRv/l6LPaMwEQGq/puHExNYrfNGGsRmsxuh03WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWmjEWxt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWmjEWxt"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539885dd4bcso7094497e87.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396738; x=1729001538; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgUR2ck/i3GZslElBugVDp0SmafcUzu1XycdkEaxCYc=;
        b=TWmjEWxt7zzaFjO1xvObfOUHxHceaz8Npcqq5CG8TXaIETLazy5z0IqpCaUvPqCxKs
         3LKPGsIPKWyp5khYrcUCX/w/GLj/nmfi7xVu6H66Tgb7ajZXUHLLYSUGRX5YVJihLT/M
         pE7Ys9qCN3wIwVPMGDX3M39N/aYl/w1/2q0omBd6QWH6AfsrUt0qtuohD5jX9tlshfvK
         60o54RPqE4okmI5MU7Z1T6yqN8sdQhy274hGO0mCxqbklQFd4xTjGszsp34mwUUve9+N
         q0dXsRSLxMUJuxgGlxEK5WDFKyrElXzaYUj5KSFJHoMue9iRgh7Wp9Y8H0nKtgIIzagE
         X84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396738; x=1729001538;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgUR2ck/i3GZslElBugVDp0SmafcUzu1XycdkEaxCYc=;
        b=B5aASSefOwg51QCuYXOu4IukEdz2xJ/1Y7eQ3rgJVlbtbv28mAoZLWMmEwYHeHv5KT
         GfR6sAQgCxcX/HIEIburkn6KLISXgxsZrfsHjks8gNQfsaecj2AN0pX//QXIhVA2Q4TB
         bIIfT4RAyKzQVgfF7dw8QVbaKX463PXz6X9kqWJDoTvvY19+MW9FmwFGKdfZBYTHP/u4
         j/KwyrbGMXmRZsl+4WmeDyHf6tJPlbDcEA6lLjcGEfub9QLIglydyX9U6Z428iAIL1lj
         TuLlfVotMIowtpgORC629TDA3HI9LeJsy3GJol97XdX2hiCn+ZSg5lxJUNZFXOQsxHSc
         gfYg==
X-Gm-Message-State: AOJu0YxvLDcGA3tALZhMTfjLViP9Dv3lQuXbuMXwT1lEaCwEk4/jpqzF
	gUEe+15mEUluifyPYQiKPKWowX+eT5uhqy4D4FQlpV2/Gns7k75UewodiQ==
X-Google-Smtp-Source: AGHT+IF5S5DvclaQ7r471mtHLhkn7GTKEIw2N6fBA1lZVs+aaUmwSTGybbgRQ2ixtLx93lklwxe/YA==
X-Received: by 2002:a05:6512:3a91:b0:539:94c4:d9cb with SMTP id 2adb3069b0e04-539ab88c4d6mr7686356e87.31.1728396738231;
        Tue, 08 Oct 2024 07:12:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995babdbe0sm221357166b.172.2024.10.08.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:17 -0700 (PDT)
Message-Id: <adcb316780959c02fb32a17fc51088e6599f787d.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:12:01 +0000
Subject: [PATCH 15/17] scalar: enable path-walk during push via config
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index 73b79a5d4c9..7db9c5bbfe0 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "push.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget


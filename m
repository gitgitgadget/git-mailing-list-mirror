Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E98003D
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324702; cv=none; b=V4/uWIWCb2OxTBfPw+h89XLHqqjtr7F6x95cLBuC6P2a2bxf2uhtv4HQg9qVc8pt8jmq3eRCGeNL4UKM6XiLf3xl6fe6t1DnC+UK70zCtIKhA1EAX6DB/SZcPJ2AlypbGe+w0eQz1cc8m6yzDBExwOQ+Ij4CUv89pioge3/K3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324702; c=relaxed/simple;
	bh=f2x95PlG0LGBKhXE5/Mh5WXqUNtWIcWu+FKnE8Zlzl8=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rFl1Qdi+uoGYkW0TY/eZyerIf7MGawkaykVlTWM5eTc0ACCQ7vpC8QkYbHYlTvv/AOeAh3huZWwXyMqKlBYpdqd0zG2ukPYNi/PgjJiPMfTjP118hOmXjEQ6XhhpzeHFgN0ToO0KjPSPx6G2LsQZtCimdjdNkuyxmdQh0YrOcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIHaf/oi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIHaf/oi"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511234430a4so1674317e87.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324698; x=1707929498; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2H5G6A5LeELZu9jDWCz3zegfaOy/2DetQJCWx0aLgQM=;
        b=ZIHaf/oiSqPU+U5YPg9W5tq1Jk48Irp5ZOShlmiPpgMoixAxDDiHNIb8T9FfKNmKPU
         K6ccdJOmsSYH7cpmS8RvLHwCTj/koUG6/zEa8InFWopd6OdVz1QoQH855GFD1iggJt7a
         pz3JdjGkJr5NdTV58YG5dMMnECCNiTr2kzPen0EoHRmxekORAdsxfSOx4fAe7WHnnu1Y
         Dess4DaxdJbfNBRCXgdDNN0Xt7Yh63vYmAilfwdN8Mi0/ajTkLL389YMivKsGLV+I6oK
         Miz31a2xgYZyGjGbn7yb98esxnrmSLCmzrS920FPbnfxMjm91oQt96wCcFoH5MbelGEz
         ZmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324698; x=1707929498;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H5G6A5LeELZu9jDWCz3zegfaOy/2DetQJCWx0aLgQM=;
        b=JU2OlukpUsY6tedlWw9Yzvroaf0RZwv6urzcYpRB0GNh8Egk/Ap3yWVePc5qWqfZ2S
         Ya4JTyxurSgEV3JHKrMfRZiLc6YWa/3yFwjHQfFIlPLcltijUhgejBbUVWKEyFGPHW9c
         5uWafw7SZ3Wo+ZltVs0aSnTKCeOgD7RPEY8HiQMdVbsjb2OyQbDWhi5s8f2EiyD5EfKF
         gI3OVp5MFFBim5G40KsOmbnomydVmqr/B24SvBoZFcgsh6yfRMbc2ol3RPyS8nlMT4r6
         g4hQqginjiezpqYGWpEfcBYhkVWxIxRR3h1+Lyc3hgknNvVIVfjKxRd2E5b2vTSGJ0LV
         ua+w==
X-Gm-Message-State: AOJu0YzF4KkjBHgXeKOTGl5R7/BfMMP7n2gZ+mDL7BaN0/075e7J/E7E
	kn1JTvC28adq0YZg7S4TYgWXwxrK07iyNdtpbkGYHzsfhorNtGLZFJSNuSde
X-Google-Smtp-Source: AGHT+IG7XpCO/MN2708No1CrTJ80RS2yuaqlp0211LNiBYowwDLTGNVPgZCAA2Qn4LSAGUorWzeE7w==
X-Received: by 2002:a05:600c:3516:b0:410:273:c662 with SMTP id h22-20020a05600c351600b004100273c662mr2270499wmq.17.1707324278131;
        Wed, 07 Feb 2024 08:44:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfYwCaghHFwQgq4nBH3/S1dbFBiDk2KToKknmYwFL5PR+ZG3kcHZqn5WvECNMJoNoAu9Cw47UtMsnQDYWLlCeiMYTwGJXceZnHQA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl16-20020a05600c0b9000b004101f27737asm1089884wmb.29.2024.02.07.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:44:37 -0800 (PST)
Message-ID: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:44:34 +0000
Subject: [PATCH 0/2] show-ref --verify: accept psuedorefs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

Running

git show-ref --verify CHERRY_PICK_HEAD


will always result in

fatal: 'CHERRY_PICK_HEAD' - not a valid ref


even when CHERRY_PICK_HEAD exists. The first patch in this series fixes that
and the second patch then replaces some instances of "git rev-parse " with
"git show-ref --verify " in our test suite.

Phillip Wood (2):
  show-ref --verify: accept pseudorefs
  t1400: use show-ref to check pseudorefs

 builtin/show-ref.c    |  2 +-
 t/t1400-update-ref.sh | 18 +++++++++---------
 t/t1403-show-ref.sh   |  8 ++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)


base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1654%2Fphillipwood%2Fshow-ref-pseudorefs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1654/phillipwood/show-ref-pseudorefs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1654
-- 
gitgitgadget

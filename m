Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD5196D98
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478577; cv=none; b=TUROowwUKPmIPoGfo6i+usPSAtJgwX8KrwDhoQJEvHq58dvXj9E63F7k5EQtNZ9L9djjhqrH6w8INiQwv4lCE03PuiYEbRJzYA5YVCDLSDGvJCZeiX0qN8pClvxLjVwKW7vvSMLX6tybrMxRkEPDujf3tUE6dBrQ251jNpMD2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478577; c=relaxed/simple;
	bh=7H6H2WJq95PlEYs4xT0Aq7UCHKfjU35zThUp99oGF5Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVGS6qyhs/ArYnqnYrHzhHzjXWhYCWov7h3o/1uJpWjTo0uXnqhHXVVNLil+ScoxZhJ1mh2gFDGs2LsEBb7a7RCfnwS2oO19lBASxQgXCBoFW2lcpFe96NzlQdPGBYPxups1gdAzV1hej1GObL6lA9AwwPDtx1WdFUaAbLFNfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KresE3Cj; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KresE3Cj"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a3be8c420cso1903619137.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478574; x=1729083374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJzS7R+JABhISt7uoW21mfVLFsm2XYnW3McdYwIps3k=;
        b=KresE3Cj41gDJBzO6f91qqTVL6hVh/FtZ+0/wynYnlVJfQUUS/fK7QPHkEetSvjNSQ
         wTqa2zBhGhycF9rBnYBRQpQ4b333o6g4Owjd5YFcKt7OsSWK2WnysA6RzmbbOiODS05Y
         CJ6gH2UVhFgn0qabg/u6NVpqfLViV/11QAV3Sv0N3EzdZowfuPv+fnVF3SjdOAWj0F1J
         eG/kUiAwOMgbuSKwYquCH4qykchT/p3J7ZsVZLIzpmA+tgVb2OklEp42a3ReattVlKqG
         jbdlfkQ3z3v5KnX7GALIcFBZu9C9jWD9j7ZrXItiAKM1WZzOl5UCMgsL5bOYYHgpVcyA
         e8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478574; x=1729083374;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJzS7R+JABhISt7uoW21mfVLFsm2XYnW3McdYwIps3k=;
        b=HWJqpAVn/jp2X0I0HwAnJU+JktAJ1k0k2aAb7clFgEIwwDCiANLPdi9pt64IGcNQAM
         f4dXjuzXj3NVEghtrMmiZrK4MKmN7DfoxWg7yVvJ/Sqqcdm29CH6K7Txo+ltGig2tZCt
         qKC6WgvabF+ryjy9i7JmQrpFspl5dPzWNKyBDvY2yrhgx4sSmKZycRgJiKxg2VnvXwch
         LtYHHVtodAjp2J010opAk18ZDbKtbn4WXzYBlE9ALVlagahxgcXzBSqq02pu+HHGFEp4
         l4RD0I5R7m9xkQDnzmYrx7Rqb4ABJxp/ViOsuh9iLg3zsgb/VTFZ3wlUatGCbkZZwuiJ
         9+Ww==
X-Gm-Message-State: AOJu0YzUJP+paVwwI9wkgKH2/GI+t5qhDKa5O9w9aB4kH2B2aNSKAifz
	7VECEQ5DNcMAwaTmp7Lr2iN1+WP0s3fQDe5YXd+01M1Wo3oDOkYGre2qkP5Nvm1oj/jCSmpIHUC
	sfTZyGwmyMFnlzXDpCqWESrrGQpsoryGB
X-Google-Smtp-Source: AGHT+IEF4ys4ZYBHrfMKNu00qhxsBQoE5SjVWDLiefZQUgWPd6K+QiD1OU+tdiCtjch9VDOjsrDdPHSP5pGyctb9B2U=
X-Received: by 2002:a05:6102:945:b0:4a3:bd34:11bb with SMTP id
 ada2fe7eead31-4a448d82248mr1719245137.14.1728478574355; Wed, 09 Oct 2024
 05:56:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 05:56:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
References: <CAOLa=ZRvFBhageS65uE5enzLBz7H_CAvvnEcPsi_QAi0exRx2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 05:56:14 -0700
Message-ID: <CAOLa=ZTAgaOK3KzsncTq1ZydXFbiG8M7MSsC9S9zUK4gdPPdOQ@mail.gmail.com>
Subject: [PATCH 3/3] clang-format: align consecutive macro definitions
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We generally align consecutive macro definitions for better readability.
So let's add the rule in clang-format to follow this.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.clang-format b/.clang-format
index af12a038f7..d76d5f1e6a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -36,6 +36,9 @@ AlignConsecutiveAssignments: false
 # double b = 3.14;
 AlignConsecutiveDeclarations: false

+# Align consecutive macro definitions.
+AlignConsecutiveMacros: true
+
 # Align escaped newlines as far left as possible
 # #define A   \
 #   int aaaa; \
-- 
2.46.2

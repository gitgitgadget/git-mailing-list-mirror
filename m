Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CF14D6ED
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670234; cv=none; b=aIpwFjg6GrTftjTnmKoIL6xXM/wu1VHHNsJ95cAmRD5KZXmfT+7Fl8gDvx6BApgDrr9Mt1+jIUEEx1sEUG00zre3BjDSBqNTae46Gjxu9dQ+yZq4+IFC2JaghayRtRvC1eD332U6hL9EVwOp5ddgXHzKpcGOYhBCLhiz5yIJuJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670234; c=relaxed/simple;
	bh=RosFX4kDn6/+n/eul7IfqL4bOCd9d1h7ZN5O3RXYl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUBuytTOuyMCDb3F+z6+GkCuqxOwPDoN1O8EwPxbEj2kRNvQG3dyvfHyevMwQFL634S+aiWVJHF8qAlAKRG4Ka9vpsV9GIWq3XMgUgm5SuO55MWEUqaA9Ak3PI5K7cPAXL4ZLw7N4AvuChO0uo0a1e2bO8cPqHn7j2Bg1ZTofLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pps8xOkB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pps8xOkB"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so64926681fa.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729670231; x=1730275031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDtuybacQMneCJc06GIioGymEOeeKMRrDlS8v97+T+c=;
        b=Pps8xOkB2eii3og0DICyUeELNdQ+/85UVWMJH5ZaHS3fWC+iF4+kmWz1tRg3yaDuU0
         SYOOzvBSZZ+CO4Ru/53OE+qnQ+6a0NXJ4sYH5cl7qt9IGQmcKHT9AOd0zVngw/TQ+Oef
         vVFuNPaWx6X49vg6TaS4YZRQ+1i7kevH/RPR3lfIG2XTEepzBS3np6kWVbSHAR/k+sh3
         miDUOf5My2ZQf7dVrdLh6Avbb/0Ir4jd+Oolr9p3W+y/GbZCxfZRIFrbM4TROxWmJKRF
         5myXOUfPuG5d3RjOWSSQd2QVk58IhmMRzc9SH2B+o+uCQWrPbQlwK2qtzlsTZ0ziIgQO
         sPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729670231; x=1730275031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MDtuybacQMneCJc06GIioGymEOeeKMRrDlS8v97+T+c=;
        b=CGdv32VAPwBrg0fDe4+MeHCsoyjmUOOwYPTVqtZ5LdmNNcaB0iS9UeV5AFwC77hOiZ
         u0p3LDAPL1Zg0LISPBHYZJBE2U0McIQzdKX3q3pdIFBnWxnGd/gTeXPQWg3AWUX4QMXN
         qBd6LmdseFf+NZf7NpXEbKeBjGhaqKgMehCqhDU83YsnG72l98qNZi419kM6QOP4XI5E
         DDzFjyezk+szG7Vq/8Gv3xUj1tuj0A36uP+YDlIvKrxnb5NphPpKYxK7TqssO+PGy0Tp
         YX/uqjDOEINxjtTR4YtmgMxG914j+D1tcV6T1VkSJKRxP4R3eOi03Xi98qL71gSnskqh
         oT6w==
X-Gm-Message-State: AOJu0YzlhgiaGXshJ6Du8fGjkdmULFkVLKLoNvYJFX5+vrL2K/B+E3kP
	aGHG5cALAO9clquWTb9n5LQE06957bJjyxRDkApnR3Ig3tzAZ+3k/4YneMqd
X-Google-Smtp-Source: AGHT+IEN4kibGAddE/myCE13DTgF50Ztwck2erJHTjcTnkw2sJsys8KDqMomeKQE5Tyl50pzj5G5QQ==
X-Received: by 2002:a05:651c:2223:b0:2fb:266b:e3b2 with SMTP id 38308e7fff4ca-2fc9d5e394emr7517331fa.36.1729670230404;
        Wed, 23 Oct 2024 00:57:10 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a653f5sm4068803a12.26.2024.10.23.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:57:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	ps@pks.im,
	me@ttaylorr.com,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH v2] CodingGuidelines: discourage arbitrary suffixes in function names
Date: Wed, 23 Oct 2024 09:57:06 +0200
Message-ID: <20241023075706.1393147-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021124145.636561-1-karthik.188@gmail.com>
References: <20241021124145.636561-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We often name functions with arbitrary suffixes like `_1` as an
extension of another existing function. This creates confusion and
doesn't provide good clarity into the functions purpose. Let's document
good function naming etiquette in our CodingGuidelines.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/CodingGuidelines | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 30fda4142c..635d6f3a27 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -621,6 +621,24 @@ For C programs:
     - `S_free()` releases a structure's contents and frees the
       structure.
 
+ - Function names should be self-explanatory, clearly reflecting their
+   purpose or behavior.
+
+   The '_1' suffix for function names has historically indicated:
+
+    - functions processing one of several elements that all need to be
+      handled similarly.
+
+    - recursive functions that need to be separated from a setup stage.
+
+   To maintain clarity and avoid confusion, such arbitrary suffixes are
+   discouraged, as they provide no meaningful insight into the function's
+   role.
+
+To maintain clarity and avoid confusion,
+   arbitrary suffixes such as _1 are discouraged, as they provide no
+   meaningful insight into the function's role.
+
 For Perl programs:
 
  - Most of the C guidelines above apply.

Range-diff against v1:
1:  0acdf6902c ! 1:  dd556a8029 CodingGuidelines: discourage arbitrary suffixes in function names
    @@ Commit message
         CodingGuidelines: discourage arbitrary suffixes in function names
     
         We often name functions with arbitrary suffixes like `_1` as an
    -    extension of another existing function. This created confusion and
    +    extension of another existing function. This creates confusion and
         doesn't provide good clarity into the functions purpose. Let's document
         good function naming etiquette in our CodingGuidelines.
     
    @@ Documentation/CodingGuidelines: For C programs:
            structure.
      
     + - Function names should be self-explanatory, clearly reflecting their
    -+   purpose or behavior. To maintain clarity and avoid confusion,
    ++   purpose or behavior.
    ++
    ++   The '_1' suffix for function names has historically indicated:
    ++
    ++    - functions processing one of several elements that all need to be
    ++      handled similarly.
    ++
    ++    - recursive functions that need to be separated from a setup stage.
    ++
    ++   To maintain clarity and avoid confusion, such arbitrary suffixes are
    ++   discouraged, as they provide no meaningful insight into the function's
    ++   role.
    ++
    ++To maintain clarity and avoid confusion,
     +   arbitrary suffixes such as _1 are discouraged, as they provide no
     +   meaningful insight into the function's role.
     +
-- 
2.47.0


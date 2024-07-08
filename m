Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8D7347E
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430617; cv=none; b=B3Pa0LXvlvH15bpXZbe5HmGsAjomVN6B1kUZ96MaksbVgBb6mMEEesYadfdbNBan/eh0T5CiOB7z+kMwGnWztVS6kmLXIb9KKjMlhiv6UoESZU0Y6WqwpRspZEpmV7n664WFqwStPgEFvUAZRPjiZDXjlyn3PaYqzN07FwmXPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430617; c=relaxed/simple;
	bh=z8m6nQw9Cqs3TGJOX9K8BOwQi4cggyNslh0bZrnppEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flY3mEMTX6MUoPrbWhq74giyzMZsTDJIIr/WXXn132ru08oWFWxkT+5QYOvk54yToeDB73xGvNma82Z6lhBosOAglMtvgxo0Ag8xUdQrBQELbMm5QWR3KdSw35w6vt/9qrXC+Q/Z+lwfVQx76O0ivt9S8vI141Uyj5o0RV9s8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5L/ri0Z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5L/ri0Z"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1051360so685281fa.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430614; x=1721035414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ukjiI8tND/nPwf0O8/p4MeqDzu4bWts+8pfWc649w8=;
        b=d5L/ri0ZZtYl8ESDs8tHofwve/OKZPN7hIg51ORscYaSR7W+cNBRCcbz7u4rM5GgAh
         PaPQNug+73JcXc4XbOlcBP2xF1UhePKObwMawxux49nXtkZNWzcnrIGXZJoL/eFGBU/Z
         74GQ+NUhysTruSUZpffTxA52TULcys04ZpCC+mftsQQmdsCukMpWpDTPVS3tAxR7LpBA
         fMvBV8z1HiN0NsHaVCVyiciP6IMvktLBJhRzHvvUgQqKRh4iFhFWat94gCLZIgj1SAFQ
         l9SfsVwv1aw7rDtS5JhgiD+kMTs7cpCVjz6pAgqC5Mm/GV7qAk1q/aLCWswjyIWZy3H6
         j4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430614; x=1721035414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ukjiI8tND/nPwf0O8/p4MeqDzu4bWts+8pfWc649w8=;
        b=mbp0CFzrW4XF4roQnP4Q/N6RYHJgPP0SP7U/Xm90OuFEcGRQbMjt6jW4VwaBMoOPyZ
         kHi9vdh+eZO02BlAnmjhumWCCaopPqWXG03jmUgXiaK2NVLmaNRjXAnixr4Vz/SaqN3l
         p2Xm/X380o03tPYl9n+jM0A2KxEPziLr8JAOAlflXJb4AYAlBzchoWmLwxUBViG3cpz2
         e3ktovrTdvQAPXJoDpbJJkbss8Ty7ZUjbV/Tj8/Jdo+oI0vjUb6Aayqg2h23sg/UOvja
         Zp/ONpfm1xPdQ+O7jlw9H2N9UQ9+29hUegFJWspvKVlwQRa4GqGBR/mF8t1UlSy/sU6i
         cM1g==
X-Gm-Message-State: AOJu0YyvwxLsPP09ttwQL13qRMg1Fj3iUydJk/E1zmEZcFq/VnoQLTP+
	8ffsvJqojV9GpsEREavfQiqLIK6OptLUt6sqHIUqhTC5BCJ9/vsh
X-Google-Smtp-Source: AGHT+IEeNhZUqCuqWNTKBcvdTNd9Bjclr2U3qh/EDR6jhuKZ8jwItXzMydXBLiC3pQHlkh8FCatcvA==
X-Received: by 2002:a19:ca13:0:b0:52e:9423:867f with SMTP id 2adb3069b0e04-52ea063a4fdmr8082114e87.36.1720430614124;
        Mon, 08 Jul 2024 02:23:34 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:33 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 6/8] clang-format: formalize some of the spacing rules
Date: Mon,  8 Jul 2024 11:23:14 +0200
Message-ID: <20240708092317.267915-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some spacing rules that we follow in the project and it makes
sen to formalize them:
* Ensure there is no space inserted after the logical not '!' operator.
* Ensure there is no space before the case statement's color.
* Ensure there is no space before the first bracket '[' of an array.
* Ensure there is no space in empty blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.clang-format b/.clang-format
index 1a5f0c9046..05036f610b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -126,11 +126,18 @@ RemoveBracesLLVM: true
 # x = (int32)y;    not    x = (int32) y;
 SpaceAfterCStyleCast: false
 
+# No space is inserted after the logical not operator
+SpaceAfterLogicalNot: false
+
 # Insert spaces before and after assignment operators
 # int a = 5;    not    int a=5;
 # a += 42;             a+=42;
 SpaceBeforeAssignmentOperators: true
 
+# Spaces will be removed before case colon.
+# case 1: break;    not     case 1 : break;
+SpaceBeforeCaseColon: false
+
 # Put a space before opening parentheses only after control statement keywords.
 # void f() {
 #   if (true) {
@@ -139,6 +146,13 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
+# No space before first '[' in arrays
+# int a[5][5];     not      int a [5][5];
+SpaceBeforeSquareBrackets: false
+
+# No space will be inserted into {}
+# while (true) {}    not    while (true) { }
+SpaceInEmptyBlock: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
-- 
2.45.1


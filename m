Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B278297
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290574; cv=none; b=t+HS1pvPZOZJKga5Cj497Eezvk2kJxrhnfkK3MJ2GBFNjm2fhzF4VyqpIKyiBfcCYj0UNf8i8r+SDqV8HSypVosfOhggNjbMXUW9ZMY4kkxwBjZzwC8fj2b2Oow2q56kAdAKV4osjYexY6nRtzv/3aLj7jclCKePLZWUM5HhUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290574; c=relaxed/simple;
	bh=f+9t1NpkVoe+I5qn36ZdOhXw0efovMxsbbnwFmTI/jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHBXhCvhQnsFItjbsP7WBgmj/7Gv6PDrZajLgQJTEhvXGKiFwNTg6/4eKeRfguZisqK0zQdFCdSi/So558YqMwj7DkXmIIfwUIKakUxMDEqyrgW0S4ipaUp17Vf/r0G5PpBac/1jmPgynPKENhlRgBPuWxk4XE+Ea7hhGXRgASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCoXuuT3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCoXuuT3"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so299005e9.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290571; x=1721895371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW/pu3ynQau+YcaNh9IHKcFwebEUBcLLIFlf5rzAZnM=;
        b=PCoXuuT3COoH2/wr1gCw/4PKNcox8hXyGkpfCjPkKcIw7JE/XqePCrDfGlgB+WT03X
         dNVPxYGB2QBWJC/KMar4Rg1hSeTvRkXC6MJb4YXAIcs3z++EqpFvRIcvj3OEJsM1mFRY
         8L+yYDSYBGXqqVn+8CT1nD1hiagpYiiAtqARWFkXA9mNAkhYqQ/3T22cwE9z/9B30mHL
         5iOsYq8TFJdu0u6Lx+c+jXYuBn5YGWumANMpp22daROH1PJycJsi+Iu5GPf7QAGZpZ+O
         NqHk0k07eqg9r+RhnJutOQyYU3F1v2k6Qsfmwc0JejCQpO7hSJpvgBZqk4gZL4C6PtHW
         aDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290571; x=1721895371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kW/pu3ynQau+YcaNh9IHKcFwebEUBcLLIFlf5rzAZnM=;
        b=Mneepe92jzc8uyn0rEkh4YqjPy98iwOLjqoDnzgDceWsEpoK2JGSiFJEdAmhAxj5Gc
         8G1Gvqu5bMXDftErQv6DvPp418Q6ERITgLwoIsiO1DNdsfCtFk9x5urS4ccTKXWIpaNd
         4QSKkf/EZfMhWpReL3hrdUZHSTb0qiuTV+qIzLLy7qqxhVpNugr/1rIPDKweB7d+6V1j
         VqQU7k085pn/xfXpVaO/vABxL2qMXg2LceBk/c+fA05POnzmO3GtVjUp9MRJRq7Qz12y
         rmBqjl4kj4DFYh5hkD18/q0aESPABgExkr+fsP1rMXYG7Gw4O4If7tguTeldkEwbYVvm
         wH7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbrZNc20c1Uws3AG0qw942d6m41TKcOfjOSsrLby/LERdiEa2KyFML1U9Gp/YP2l5glYMa8tIj3472rrfDCSIEp4m7
X-Gm-Message-State: AOJu0Yy0hchWYy1LFnO1ETl8TFSTk5SWTxpJVECGpEGhovUfRQ58vB0m
	o7XvEAfXpHlhvsjdadyl/PkGZl6rWBW+w3G01tUsPbuef1bDqHiT
X-Google-Smtp-Source: AGHT+IGXW74rq+If94GdfoGeQQgRyrGCxzjDu5ioyd18xJauLkPzcInNdbysHmDWyThNn1ovyOiwYw==
X-Received: by 2002:a05:600c:1f82:b0:426:5f0b:a49b with SMTP id 5b1f17b1804b1-427c2cd1533mr28663015e9.23.1721290571222;
        Thu, 18 Jul 2024 01:16:11 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 3/6] clang-format: formalize some of the spacing rules
Date: Thu, 18 Jul 2024 10:16:02 +0200
Message-ID: <20240718081605.452366-4-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
 <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some spacing rules that we follow in the project and it makes
sense to formalize them:
* Ensure there is no space inserted after the logical not '!' operator.
* Ensure there is no space before the case statement's colon.
* Ensure there is no space before the first bracket '[' of an array.
* Ensure there is no space in empty blocks.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.clang-format b/.clang-format
index 803b274dd5..3c8018a1dd 100644
--- a/.clang-format
+++ b/.clang-format
@@ -118,11 +118,18 @@ PointerAlignment: Right
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
@@ -134,6 +141,14 @@ SpaceBeforeParens: ControlStatements
 # Don't insert spaces inside empty '()'
 SpaceInEmptyParentheses: false
 
+# No space before first '[' in arrays
+# int a[5][5];     not      int a [5][5];
+SpaceBeforeSquareBrackets: false
+
+# No space will be inserted into {}
+# while (true) {}    not    while (true) { }
+SpaceInEmptyBlock: false
+
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
 SpacesBeforeTrailingComments: 1
-- 
2.45.2


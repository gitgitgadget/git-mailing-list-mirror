Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5719153BE3
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686656; cv=none; b=VMQrxa1HiY9E9Ag9j4O62gM8KuMDnxTWGaYvPexUmygHuyAvXIDS2PHrVweFFCcLmeV/1XDQAtLCHVDSSdwHQollnC6FavQpNA3Ok5GC3hr30jERWLQcMSile+IAuiJKiaBr/A+8fZHDYmjiSXN5AnARqHrQ2gfK7pkH29TOG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686656; c=relaxed/simple;
	bh=u25MHxFbUMXfobTAGFyum73U1eoSzRc74Yujbm8b2l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnB9HK0ud70h6At3ntZM1Q9Ze+iICTRNnHhGbwpvqqS4/QU+QOA+30p883+fvbS6vJLfHEN8iCtl1kUGtsiV2t/tiIUoQ/roE6v+9wBisg+AVZAc0DURW0EU+PuZmxtf5WBRnKcD7uXMG7JhThqDc0zHJeiU1EUbayOIagIwuAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJoVRK5r; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJoVRK5r"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea1a69624so658174e87.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686653; x=1721291453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1u1o+N5vSVgFYhRMq+X3dfA7azT3SjflSgKv/BgltM=;
        b=ZJoVRK5rZr22C3rOLlOU+o83/W+P4mt/pIWTpOvLQpKaeBzs+IV4IglnssJaESEIJF
         W79t/eGddvufKd51bGGFu67l4r9iPL7jQf2QRnLQHBM9CoXkv+p0iPqt8jBV08HWVwmu
         PwB4OcvSYI63Yz8l6WFxKuvDD8cd/50SJ68frZ0Krl80XpZQsbilrKiDzqA0WjsmUW1+
         FqQRAHv37+x00iuEXuI/KPHFLnxLWIDWTnq4J4nEgZHaaDBJrOa12qIAYIDFt6ccZOOQ
         7/YsB30sLBdIDlbny3FkvIt167Q2SPHdYuMlcrq/Vn7DpqotkxQgVNwxXoBHKHXU4jGE
         rh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686653; x=1721291453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1u1o+N5vSVgFYhRMq+X3dfA7azT3SjflSgKv/BgltM=;
        b=taz9nqSt+8TAS48HP3sRolJAIjRj/14EQ0At8B9M6ktdPtxXPW7KEUYmabKUqUT1go
         Z5DkzV9FvlIGgO4PNacepwJb8qsbNMw7QPtRlXtYiA/wVKacCi1pT3RhSE2XzHkOy072
         XREOT/USc9iUWF55fnHdso/hvNvTA1kldXEc+/3ENGmm3rBafpyIh8WQoZ+3luEo1pcM
         EHcizqGQjN8zpMuaLel2Hjs0GeixpYCcoFNhZs44nbkF6cgZVqYDNGpQu7Ta/GSF7T69
         6oJ4QsxGUSCg19CTJiAoGk4itipTmV6wCD7X/qHKtkd8LaCMux/zZ1sA2T1Yz481DYBO
         MRkg==
X-Forwarded-Encrypted: i=1; AJvYcCWcLjqC0nQWwBVShzC3EAGE40Yyr9R1HpZX3QOEe0xfZiH/+UfkltkqWxvmRXVFLHEGQBAxxoL79fI6+clj2ZE0TS7u
X-Gm-Message-State: AOJu0YwarNClNq//rOxHGycj+q86gXcdvBvlXsjKg/FOP0zYQpv+9x9j
	UnnzhHQV0ybZ3hEsQa7vZ7/N/O+s8jgquGkkqM7hC7UwvSlRgDbL
X-Google-Smtp-Source: AGHT+IEznOPg/60ATREFuds5h5EKUladpoqpa9I3PNZ3ONMiWYvMeSyeKZ6XvDz0Uk+LpZMfWzK3HQ==
X-Received: by 2002:a05:6512:ac9:b0:52e:a008:8f55 with SMTP id 2adb3069b0e04-52eb99a0983mr4860222e87.41.1720686652559;
        Thu, 11 Jul 2024 01:30:52 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 6/8] clang-format: formalize some of the spacing rules
Date: Thu, 11 Jul 2024 10:30:41 +0200
Message-ID: <20240711083043.1732288-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
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
 .clang-format | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.clang-format b/.clang-format
index 8b75dece80..68c10f03da 100644
--- a/.clang-format
+++ b/.clang-format
@@ -127,11 +127,18 @@ RemoveBracesLLVM: true
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
@@ -140,6 +147,13 @@ SpaceBeforeAssignmentOperators: true
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


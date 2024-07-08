Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305359167
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430615; cv=none; b=SCkbS7KV17ZqFeUleWFRKk+v5FQYfp5VYM4vpCtUwTHdn1QzxpwFYwA9sUuGwzLTCTMRC+QdgL0hu2bwaD2srSxsmbadXP8lbFXgBV6qurh1Cew8nBajpbaYeV6VBEAAlS6cvDJPqgtOVuHOvHdloeQNtZ1NIhDVxqF1w090E4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430615; c=relaxed/simple;
	bh=dsalWAx03TwmHNKuDDxxXM6DZF3G7lGrB7wXLyX6BuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFSB418aXd6hK5xP70w4MC+wFOuwhZbW6fGL7RXNlJCupO2m6xIUXDN/IUjcRALO1j/MsJdfUsgGe8xMuJ/CDY62ZCRrUwUQlFM229uvSah8unbx74BtFk4wTnr5VWExUAXLJgPE5Uru2sqB3M99bResC98ZztU8vvZcqLFxC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2halYQZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2halYQZ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42662c21289so8795715e9.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430612; x=1721035412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JHGziRgakNVZ5DwXy91iJK9uggV/+EZQns1CJL4VNw=;
        b=T2halYQZaEjksTbAuwKTZaETRsDhn+iN1gvuWa2+gql/Bj15xgVm3Z9ehwo6sNbLrT
         Dle95ku1pyKX7lDoACCW2ZnTdRGlAzThuVizMJ4yQ8qFSbzy2zyCEjB40gQ3ffHKuLwi
         kf+tbTI2113M6aY0eEnhDeTqK3ovairHrnLmr2+Stbgf2eTQsJFzMnwA1AW4bUKKBQJO
         uqw0CsXMfbB5Y0e9LsIAsyXS3SWvgiXtGG4RnZrG2iBDMe15h6LY6SzFyJ1cZD3WHKs3
         EIj9jQy3z2ObTxq4z+ic8x9GcWMKK3k9np8hVSqagI4hW/gF5PzU2pAdobAdyBjE95QV
         4uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430612; x=1721035412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JHGziRgakNVZ5DwXy91iJK9uggV/+EZQns1CJL4VNw=;
        b=bYstS3ZZARvhr1QqECsEkRSx6i+5IJYuKS1fgD8/PyqGSyY9C8qRHaZsWVZYc7EQbD
         qw5LAjAVu8oRBhdIMtVr5nZoxDaRQXwhj3rI3fZhb0aKdQt4Sv8ix4fP69jX+fC2eShQ
         HAs6+r0PhQqRAmhw6pqKMIN+t9U7CjqQlr5hZQstNWiaKddewpSIvZPco94+M6IX3/d/
         qi1Gddxm9jQKCK/a6Xwm/sTmHuQ2GhzB6NCTVHTM9TfAEIARYTs5+V2RRzBROBDq8u3T
         1TOfF2ImxG/SnrJDmqFdckHJfK1b3saLbxQjTOKY/o+lREPlHNzWEpCbV1ksKU2+/E9r
         gccA==
X-Gm-Message-State: AOJu0YxXI7B25G55yMcSRiv5uttIqRGn3UoLNu5KGS0yRE2B0TKZr6S4
	w/m80fPn4NqTRr5NdSDkbH7DpspJRUrZay1ttgiKkugu1nscM4N2
X-Google-Smtp-Source: AGHT+IGNk6T0eaQrU+VAwPI/cbYblajrGStLToZBJz+7wOW4NnCHmL/Ar8AE7q+q/kf89VEbe1ppPA==
X-Received: by 2002:a05:600c:4811:b0:426:6e95:78d6 with SMTP id 5b1f17b1804b1-4266e957ac8mr1708215e9.4.1720430612059;
        Mon, 08 Jul 2024 02:23:32 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 4/8] clang-format: replace deprecated option with 'SpacesInParens'
Date: Mon,  8 Jul 2024 11:23:12 +0200
Message-ID: <20240708092317.267915-5-karthik.188@gmail.com>
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

Replace the deprecated options 'SpacesInParentheses' and
'SpaceInEmptyParentheses' with the newer 'SpacesInParens' option. The
usage is the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.clang-format b/.clang-format
index 4c9751a9db..914254a29b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -134,8 +134,6 @@ SpaceBeforeAssignmentOperators: true
 # }
 SpaceBeforeParens: ControlStatements
 
-# Don't insert spaces inside empty '()'
-SpaceInEmptyParentheses: false
 
 # The number of spaces before trailing line comments (// - comments).
 # This does not affect trailing block comments (/* - comments).
@@ -149,9 +147,10 @@ SpacesInCStyleCastParentheses: false
 # var arr = [1, 2, 3];    not    var arr = [ 1, 2, 3 ];
 SpacesInContainerLiterals: false
 
-# Don't insert spaces after '(' or before ')'
-# f(arg);    not    f( arg );
-SpacesInParentheses: false
+SpacesInParens: Custom
+SpacesInParensOptions:
+  # Don't insert spaces inside empty '()'
+  InEmptyParentheses: false
 
 # Don't insert spaces after '[' or before ']'
 # int a[5];    not    int a[ 5 ];
-- 
2.45.1


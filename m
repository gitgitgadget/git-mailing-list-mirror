Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F5196D98
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478571; cv=none; b=RDOz0CRxj/0BQvwnMKHX3i7iE3F2SFze3WAG6FvbZ5D8NQ4SPJxIH1O/nDKOC/bZRYaHO0fwmLgHcp4P6qGYIDj8rjh9aV5BLuDOd8Kaa+HHPZt5Tfp9/jrdwQzXly9dZhrOXAVcGFem3rDoZ8pcE9DUUkbW+OmkAynNzZ7k7l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478571; c=relaxed/simple;
	bh=4rSDABI0v1KaG4Qb0/Rx6P9AcCOBAaOOMgrUbDnCYgA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQhszA0hDD7fBUFJQ450nFqkYC2UyKUkL70aOoMZDHGAfIkgYoaE/XkIwkocQEdnGVsYlDmgPkR9wLhJlqPFrStxEU+RyJHU1f8omvXT8vf32yxUlxHhgjCJIHzkgVagBEvAWEQcPEitSiSRQXPP1d1tJz5WJSgCxnRcxP2o9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0wV6pSS; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0wV6pSS"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84ea658b647so2325920241.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728478568; x=1729083368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0p4hikNOHVCj2ttRmpxSvyhwJWT2kuvnY0RoITqCPM=;
        b=h0wV6pSSHEUy6jSuQLDYag0htoMcQTM4WSomteNCfXucvAlsLRkFQZzeHznAuwOXoB
         Pe5tqGO6denQTRliuS4fWI6lvSIY1NvahZmVNWBDlhJNmev9XL8Nsf0bu6UEmK30xkOF
         9+Sj+pd9Z88qNHZZmbwCXKgBoYjIhdNcxgLsEPU3rLCzuMuJrA9aInAY8JyET2k8x83g
         YDnzMGxVvLsMQrv9aA9gTGBU5DDSiWwv3tMDuSTIynoan7uYFoZ9tQWlU+K7x+be2T1W
         Ozd2+qJ1D0NT82p4m+qosohI9QIrNEjLy+Y2A5XP4BfXV+LdONHlQ12UkKzh6vZpshdI
         NBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728478568; x=1729083368;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0p4hikNOHVCj2ttRmpxSvyhwJWT2kuvnY0RoITqCPM=;
        b=HqgcaZJiPngtw7kbFsTkmcGqThcQuMpnknnL0PnICUAXMFV+vuxs4rRb5EoB5bOhLj
         3SQqLxcXJ4A+pRhLGAQs/CpRpEVsyfYJVj1sm+oSBNFP0WLhHGsFZnIx8XlFvvH7EQib
         vombINGg/v/vKfQ9jLYPDRtSAQFJB2pieCHrHiaPRnnSftihLIab74L41EgLdoIOXXB3
         xIW1dHsg4NjMCR67LxV2SMReBZ2rHocQxPXG2FdqbN2eJvfGADeoZ3Qjj8NnuLZ7KrpZ
         eZGnnHVo6yOZPG3dFA6nYPjID/zE+/owN2qajyXtjql8bFZqtDkC+yjZ/v2tGWWoKmF2
         vCcw==
X-Gm-Message-State: AOJu0YyLC4fp5kXSnNttCDgZ44JydyUkNISFt/b3gVpvCwcWMl9c35Rt
	OPw9c2+IGm8rR4QOXS9N+7H9O2eKMJNIj7hNep/WSiVxngv8eHRDarWXqOxQ1nVbvzO7pNdDbiR
	KFce//npsaziiInfgxjh6KvGvMc4=
X-Google-Smtp-Source: AGHT+IErFmGsdMdigxgxN6k1+zNX+lCJuXbfdgN0HwCmMa+UpB6Sh9eT/RM+taXJKLU9i8QctFU+wb0bB7J0/vQgb0U=
X-Received: by 2002:a05:6102:c93:b0:4a3:a3c6:c674 with SMTP id
 ada2fe7eead31-4a448d1566amr2928838137.4.1728478568598; Wed, 09 Oct 2024
 05:56:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 05:56:08 -0700
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
Date: Wed, 9 Oct 2024 05:56:08 -0700
Message-ID: <CAOLa=ZQOyio__8a5=h=65kkENhxPC4tTAFczioeOTvU2iSSkJQ@mail.gmail.com>
Subject: [PATCH 2/3] clang-format: don't align expressions after linebreaks
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We enforce alignment of expressions after linebreaks. Which means for
code such as

    return a || b;

it will expect:

   return a ||
          b;

we instead want 'b' to be indent with tabs, which is already done by the
'ContinuationIndentWidth' variable. So let's explicitly set
'AlignOperands' to false.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.clang-format b/.clang-format
index 38910a3a53..af12a038f7 100644
--- a/.clang-format
+++ b/.clang-format
@@ -43,10 +43,9 @@ AlignConsecutiveDeclarations: false
 #   int cccccccc;
 AlignEscapedNewlines: Left

-# Align operands of binary and ternary expressions
-# int aaa = bbbbbbbbbbb +
-#           cccccc;
-AlignOperands: true
+# Don't enforce alignment after linebreaks and instead
+# rely on the ContinuationIndentWidth value.
+AlignOperands: false

 # Don't align trailing comments
 # int a; // Comment a
-- 
2.46.2

Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CB2DC334
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839098; cv=none; b=PYsJGBK3QKYPStXrMVuHfTTrsniiEslusOAMmFBwFNcAunuF1i2wA5U74EuaGVivM7OJDgs81JRmcmvcyMQbffRBpkkx6EALWkxUVm+gFHJkbHjOiCCc3nHcF0xr42TJfp84weyJjZLqsXqpiQ/bAWFv4+za4f6Lj9bfvkw0bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839098; c=relaxed/simple;
	bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbGHfMs5gNC1Q7RFEpXbNfKzLdwnLtTbBGtD/noWcSYgeBLhtmoX2aooHjOTzkLuSfiD4um10ceSCA5r4rPcJ34EQLDzxDJLF4mZL/JMqoqCHoZ8wYOu5Gnh+50iEZaWd6kE1fKjP5s3IP1VChK6sgwpUJ72GCpT/f4aftAUZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi40DqOx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi40DqOx"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1173136066b.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839095; x=1760443895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=Pi40DqOxolG+vC2JKcF2oiyYUtE+qYBb3McJzSuOgf4pEAWtqbx/+73vrxGnChmnA4
         POfeb1QO9/l0XTUR+ppAWMmljZD3ky/Ht9sqT7FxrB5Fp3H875+EawYrilDnYfBKYD5B
         6fBSfvqzXjFAGrrWR7xDYU89WDt+tlUoavOz925/FQtjNJEpUfYkH5aTlddMGXVjDOZr
         UPRz1+G2AAA2WCz3XtY/2euMokuwQmpHVF1vt688L6DmB4NjGnn2GaTodQOjFFcdhjfZ
         kXev/Xx5XFQMfUtt7BDA0qygvAufBJfH1uZkkQPDNcH3lKVvl/b0cUzjVWZnP4XNBMyz
         CtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839095; x=1760443895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYfDe4BgEwoLeRMRSq+TFdffhHPG7+HnprKnPi5I8Bk=;
        b=VTDvjsGCGDn7sWqbzRGIEvFNtppafJwiJG0Fj6Ygq3uvWWiZuw7E0//tnRQ7UKiRkj
         1uaug/Z530qSaHZrFthfeLYJzpoxejcX7NjvR2kgXqjt6jr+vc5EgukZi9RKikMvZTZ6
         zUqr4WjiTUC0wnOLk3cobWmkP23+mxxLoGBbQ8wZd5PKBPWbGvfpoTGu6T4iY2SGTsQb
         ZCmRX3TLzTyjyNx+LNSSxCX1tmAy/DPQE0Uu2wjXiCIE7QgXReOMxUFf3gw05WQava6i
         Ox1yWRW6wenCVnqYcWhobgTtRyhXdb5vXbQfH2lcNv1oPAFkdQaldmVADtSHmftLl13r
         2iKA==
X-Gm-Message-State: AOJu0YwsvFALaJtJvZ9koEl53YMYephLgFWo1nY+FZpTUOip/7A83Kvn
	f6XLHkJ3Y4lAQN6jmUPWOIP7QQlUxE+p+IRf5JS9y1RJiSL6jnTluG5G
X-Gm-Gg: ASbGncuXhfpmXYRbfQu7YnjvL7SlZEok5GJAqO1y9l73WkAGF81e3/PR5oZccsXTBCG
	fhkoJoHYXg4FtxYENVrg0hlwEg6g5M0LiIgtwYSfAASYhgAhvgRMcYdF6JSSd3gsy5p0IlNU7J+
	dHV63yKJG54hpdZPENjqRg0vAr3HvQEH/S1EN3ANT5/DBGwXml+/XuFDpEkgasBeeSXh2LPExYX
	Ezp7GtSigU+iB89OvJ04FSFUOM/6gMFm0cwkPX4oo2VQaV/QNlYag96Eq5BRT0yvXlDzhPFbnjd
	aAySQAKxCN+QFX1HkgPh53M/Litvd8lpqM6A7+cg2lbov1I/hQhYlnjD9v9OyYfTrOmUbv4lIDn
	xaSjMf1gakJLjbb56xi1zzryr9q1nyMPi7dSt7+t0Ttv18TyL
X-Google-Smtp-Source: AGHT+IGHEfNmIkkaikoIECqrga3VmSiqOSR2QnOCBIoLTPJgO9xz20I4uefXLEZ7CWXR0hdt+L6jug==
X-Received: by 2002:a17:907:868c:b0:b47:de64:df1e with SMTP id a640c23a62f3a-b49c1275fb4mr2033264366b.4.1759839094972;
        Tue, 07 Oct 2025 05:11:34 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:25 +0200
Subject: [PATCH v6 1/7] refs: remove unused headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-1-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TeIPUDS+vHz5/TMx+yGjf8YtEH83rc8jg7WK7iZfgrA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3Qbv2Cyeufe+Ya5unkzgGp4vqhihsasQ
 9TB3eZTg9SNV4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN0AAoJED7VnySO
 Rox/e3cL/iQr4uzWJs98Kkatq7ZcUZbECNgzAY4550nnMBdBLOc5EmLddjqAfAr/zJ+ugkjopVk
 InTS2FH4DMFq6rmJAuPPoUuC4tX2QTQ50cCWTjp2ezTWHFw9LPl9SeQNo2ny+JNo68XNckURRSn
 BPmx2VsEucU1gh0/mj0NnOqq1BoSgi20jNNV4DWRhkqUCeYLIp4M7BNOmEZzoUhLrJlre7fQuxk
 tic4pkmNWVdHqvkOU8ZERUWtbeQvmSHlxqDizrgSnf844bsbHlMYajvlnfRhzRUvZp67+KGyZ0E
 jTCQZkT2xID/dF0nKXMAjWZBrN64U+soyAaqarr0ytxDQbUt31+DeN+5jWnZjdvn+U81qcEC4ur
 JIUpjpTkgf/F7HVpR1VFJcIpk/7XJkblxSxSGujsBMfflANDDeXjqmgEwxqwdtJCeSy8iB/xTOQ
 M7rK1K/6fuSn9cUAmzMads/nXEVZO78ywOkrMlMLyqCWU70PFSXoHuFIBzTL+ldcK7KaBySInA6
 jg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the 'refs/' namespace, some of the included header files are not
needed, let's remove them.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/debug.c            | 1 -
 refs/files-backend.c    | 1 -
 refs/reftable-backend.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index 1cb955961e..697adbd0dc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
-#include "string-list.h"
 #include "trace.h"
 
 static struct trace_key trace_refs = TRACE_KEY_INIT(REFS);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1b3bf26add..d4fb033417 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -20,7 +20,6 @@
 #include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
-#include "../object-file.h"
 #include "../path.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 9e889da2ff..2152349cb9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -11,7 +11,6 @@
 #include "../hex.h"
 #include "../iterator.h"
 #include "../ident.h"
-#include "../lockfile.h"
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"

-- 
2.51.0


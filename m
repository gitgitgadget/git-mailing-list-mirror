Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB75A18DB24
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057087; cv=none; b=nC5VxlcZMrbhKztT2YD3PdQ1UNFhAkg1oYTVvgb7RxWyyiY4vXLCPLlX6+tn6X6B4Gqj/elyYspmgz/nuUy2pEH/XtZriaBVzgrfWub5gjmrysU5Z+BwZvXPbZ4envy3ijzHmkczo07j3HJ3vSR/8CWo+nvzizLRPDq7id4qUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057087; c=relaxed/simple;
	bh=j2pJu/0cLXVoHpi4LuzwUFNvqT6KEOt+6afZbz0e38s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qhkBrW9Gx7CWDdB+ke/RBu99SuJNES5EaaRx4sKAWtYa+R0vAV9BAfeWcMhSFITIhHxwx0A5IoUmmtQf1Ms4U8wkMO0nOGl8OJg3En6e+o1eoRqSqVAt9d7SXmRHjVMvBqTbYeks4i/Pn3RiwYTsbF+vNljF9lM0Cu69JeTiVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1deJD5r; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1deJD5r"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso28210f8f.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749057084; x=1749661884; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGU13a8hi5xxhscAjI3S1Im+huIQhHJTcmk0sEUizpA=;
        b=a1deJD5rEZzuSOCEuF1T3RIH9bu8Snd67kInbbDxA1p1aIEXlnLHWBtu4PFWKF9JZv
         3EdsbIVeYjVdrdVqXDn7oYiZi4UA/TyA0yDoZ+M/moeDtINyzhG9tPuoEDQtp+J3aSMw
         mj6QFh3QJpFEU/MeWTZxacVHXKlT54X051D9JB2KJmF7KmMvoYGCzZ7Xe/eF4kR2Xq34
         Ww+nI75UMtCS/DGmXAYCy2ru0OJ43qxLIE/4LPHqCrWJpCMDeqp1Lx9DppLv0T904Vrj
         zRRSVxf+wfOxy+6LgJEXPdemhV9vWshYn9t/ts2YS6C6Q9LiI6ftF8CN7dQlqsMjHyK2
         I1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057084; x=1749661884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGU13a8hi5xxhscAjI3S1Im+huIQhHJTcmk0sEUizpA=;
        b=ITAwajbnx6PV6xDYN1pxJuR6jKunDJ7YFUrP+L9XdkyIolHLubx4r/4ele8K2CmMGz
         Fbd4pLoaP3GpM67v6JO4st9c9SF+OKYNBB8/PASk968nvfQOPiFd0hmznSsHF6d2+kzr
         bG/5xAZ9HZj74m2qphY1Yapt5PxsWXJz38qBs+rFcAERod4SvXbA2PmVHECCU+0qhyOD
         5KIDTwwxAThcdBeH231o45KkHSrvvC34SmwDw4VtGzHVxHpqBY9TZ+lehXRPQMe9GMmH
         8dLEizq0eO6KZ71v83kNOHqWnlocnMS2MjH1O7j7drbQ0KdZR+fMUVXtT+spwB4yeOaz
         ePGA==
X-Gm-Message-State: AOJu0Yy9gLNSPB+uK15Koke8DpyTf2QMzq3hEn0E+V0mH9E92GC8LpdM
	RFFwRZuyy/jo4MMVwIv7IhwCuZvkMSqaKv/75fxZpPR4bnI0cpIU1nF6hrCu0Q==
X-Gm-Gg: ASbGnctIrt02pWNYQO2MRpzIjj4ZGhHxv1CqAJwSDgRfm4jRhvJexC8nGruU/snWmtc
	z3mGZM/QLAO6ARW9hZcu5vyQ1zlFkvgpW8gAwRepYQE+v1o/dQCJ8IJPUgz4rKGZ1bQwmvrEyyZ
	lP2ZATZIWyOLP7mcDXsa+Vh9JJgj+/z7uLPVnRs5EAaDJccTCQZsfhczCWY8EvIGqAXlQ8dOW2v
	O6xd7rhCFwMBs1thYWrDVYP/IVBKl6hMvl0mFTAoP8YsOQceluTawx8p5VmYXvHCbe33kNdRZaj
	sacr9AIK50Z34kDgNYl1aGbLRzRunIWvkAmCrfy+/iLf+RTdOFVpadVhwEhuogw=
X-Google-Smtp-Source: AGHT+IGXTlxhxoCir0GnEJjgHu7DRRRawsOIyE6DYTqQY3qgupGfPdrOJlYvTQ62rw105p5DOJvaZg==
X-Received: by 2002:a05:6000:2082:b0:3a3:71c2:f753 with SMTP id ffacd0b85a97d-3a51d96cc21mr3314523f8f.34.1749057083451;
        Wed, 04 Jun 2025 10:11:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009748fsm21999854f8f.80.2025.06.04.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:11:22 -0700 (PDT)
Message-Id: <pull.1985.v2.git.git.1749057081918.gitgitgadget@gmail.com>
In-Reply-To: <pull.1985.git.git.1749023960409.gitgitgadget@gmail.com>
References: <pull.1985.git.git.1749023960409.gitgitgadget@gmail.com>
From: "Jan Mazur via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Jun 2025 17:11:21 +0000
Subject: [PATCH v2] bundle-uri: send debug output to given FILE * stream
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
Cc: "Derrick Stolee [ ]" <stolee@gmail.com>,
    Jan Mazur <mzr@meta.com>,
    Jan Mazur <mzr@fb.com>

From: Jan Mazur <mzr@fb.com>

d796cedb (bundle-uri: unit test "key=value" parsing, 2022-10-12)
introduced the print_bundle_list() function, which takes a "FILE
*fp" to write the output to.  Later with c93c3d2f (bundle-uri:
parse bundle.heuristic=creationToken, 2023-01-31) the function
started showing additional information, which is always written
to the standard output stream.

It does not look like a deliberate decision to do so, and it
does not hurt, as all callers of the function passes stdout to
it.

We could change the function not to take fp and always write to
the standard output to simplify, but let's use the FILE *fp
provided by the caller consistently to write out output.

Signed-off-by: Jan Mazur <mzr@meta.com>
---
    bundle-uri: send debug output to given FILE * stream
    
    Small fix to bundle-uri convenience debug function.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1985%2Fmzr%2Fbundle_uri__print_bundle_list_fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1985/mzr/bundle_uri__print_bundle_list_fix-v2
Pull-Request: https://github.com/git/git/pull/1985

Range-diff vs v1:

 1:  83cbf182253 ! 1:  38f05164811 bundle-uri: replace printf with fprintf in print_bundle_uri function
     @@ Metadata
      Author: Jan Mazur <mzr@fb.com>
      
       ## Commit message ##
     -    bundle-uri: replace printf with fprintf in print_bundle_uri function
     +    bundle-uri: send debug output to given FILE * stream
     +
     +    d796cedb (bundle-uri: unit test "key=value" parsing, 2022-10-12)
     +    introduced the print_bundle_list() function, which takes a "FILE
     +    *fp" to write the output to.  Later with c93c3d2f (bundle-uri:
     +    parse bundle.heuristic=creationToken, 2023-01-31) the function
     +    started showing additional information, which is always written
     +    to the standard output stream.
     +
     +    It does not look like a deliberate decision to do so, and it
     +    does not hurt, as all callers of the function passes stdout to
     +    it.
     +
     +    We could change the function not to take fp and always write to
     +    the standard output to simplify, but let's use the FILE *fp
     +    provided by the caller consistently to write out output.
      
          Signed-off-by: Jan Mazur <mzr@meta.com>
      


 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 9accf157b44..c9d65aa0ce8 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -122,7 +122,7 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 		int i;
 		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
 			if (heuristics[i].heuristic == list->heuristic) {
-				printf("\theuristic = %s\n",
+				fprintf(fp, "\theuristic = %s\n",
 				       heuristics[list->heuristic].name);
 				break;
 			}

base-commit: b07857f7dcffee4d3b428df8dce6c9b49a57c9c1
-- 
gitgitgadget

Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE122E3E0
	for <git@vger.kernel.org>; Wed, 21 May 2025 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747813507; cv=none; b=nWCxRnjPTotf7PzmJpscI5EPgSJe9Ur/oSGDubPQF4oU/a8Wvmwcv+Uxox/o7zWXLDgFGRE9qslks3AyvT6xQeN3Co+xsYeumjY230jShaRRP7acPXV4KwNPotXItfhMLx58nIJwGiK5MUDFCMUXDuQBg7Jhe/HuZ9krbHV5V8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747813507; c=relaxed/simple;
	bh=lfymz/wgRuxMY9FOzCwkFU3m5Rj8Y2D2vWer3OmY5T0=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=H1Jfitl7seQ8WgR/Oo9zDUEdJHnSki9obbFKlr8Cbo3beyk/mZRVf6ZeZKbf9Y8cfTxvyTzqCslnTMzDI/SD7Wdp5PAvtkmooK8OH61R26G2Ewibw2CKU5BqScHGOdJrxYkuk5QyH8OiXxDF8mnfwrGCOVb3RbX771C9CCJm4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqIaeZcc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqIaeZcc"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a361b8a66cso2977655f8f.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747813503; x=1748418303; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n7cIUVPddaiZRl4ZRyf/biyLkyKLzTfro1nhfxDR+KQ=;
        b=SqIaeZcchkPNKr1GTyxE6/0GhbQftmP/mKYMu9keXq9dx3YjzLLi4et9VzaXxtL7nn
         WDhFi44wiRdlnKmULQhL9S7OYQpdA1DJFSmB9gucsO3WJRaqo56lyERC4/+HP+Ojghwg
         UqXlnTclMOLGUIdE0JgkcgS2IUjJAe6T4m8mzmWzD8lA1tPL5WySsVlJWFqVs4RJeUHk
         tTk5h40uYRSOK+yaqintM+hZYYg8mHvblMhEmzxqEDEAlbIcJsV5qp8GoBpyz1MUjqjb
         LvHrE7BpaSFzo0nOFWGA/ogOHcy2vMbfUURGGUa5KdiVxANR6bL7/K3SC5zTb+IAZ9Fr
         +EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747813503; x=1748418303;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7cIUVPddaiZRl4ZRyf/biyLkyKLzTfro1nhfxDR+KQ=;
        b=ZgrF8Y1eypMsSmPW/O8ifR2TWLoJKMwsApENZcbm9eHtN85KPMlASSymP5YE+H75TU
         gk7q7fC51Yw0ycVzTnKRr4ftvtgbvN+GxaxPsaki5qes2Pm8qIYyXYqoQfcWmAjNM6o7
         unqAk8Nd0od+84tMH67y+fXzZc2tVrgL0L4HaezWpeHxfcyX0YiWz1QK7XIRXu8Hw2vY
         w92OlJK15SU0pU5eP+u+WniGKBE4wW4xVexicmXPVEXoEDqcHpDeqy1wKzQwmA1u+uP1
         WvdbZvgBjwSl66588z9wjHA1du+GowpqH7RJ7IMYTvj0Iv635lzoXsI31PotPIDQ8+qK
         K+vg==
X-Gm-Message-State: AOJu0Yy9cIpRVxIqHFOkA3Up5xS517KSWb6U0OSkslu4xUUcKInnw6cx
	ujT8MhMCF0x6faN2JPAiV1QpFV2SqnzUUz5+fJ1lOPt8yIqFziN5MzAoSeMtPw==
X-Gm-Gg: ASbGncs+sd9lZlRHHbnZsbEE0Y8kEyEs7ZgEqKUBIXY95VEkTsu363tpnpeizTAlGcI
	GxN7Kcoj5ghm1VBsmNGF1ZPBQUWO96NQvOcjb1QyFU/2YnLA84karrJLx59SG/S/VgfZdtMP0/S
	sNFCbS1Y2oDjxfmm5xb+NR0CngzchviHsww8TR+1k3qyYLBXbotEBWqnlDVt5I/6SgPXY+Vz1WN
	BXo1DgZNw0zhwB65un17hJkvl3NRDDNWB9+m+HbL5lw30NKED68ZlUiEKR4Zjl7MtDxRO9TIGsl
	N5Csb1oVNCzC4FZdXR6HAKwM/RLIeNVmMohcAxEU1dRooLVG2xwk
X-Google-Smtp-Source: AGHT+IFPDl4C5rG2CNgabUkjxD3X9QVpLI0PjCh73+y5vT2CJlsdEln5xhBTdAb52a7PUoR+ICLN3A==
X-Received: by 2002:a05:6000:40ca:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3a3738731c1mr7904997f8f.4.1747813503259;
        Wed, 21 May 2025 00:45:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88978sm19216880f8f.65.2025.05.21.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 00:45:02 -0700 (PDT)
Message-Id: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 07:45:02 +0000
Subject: [PATCH] cvsserver: avoid precedence problem between ! and %s
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>,
    =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

With perl-5.41.4 and newer, git-cvsserver fails to build because of
possible precedence problem[0]

Added parentheses avoid this issue.

Full credit for finding the issue and coming up with the fix goes to
Jitka Plesnikova (jplesnik@redhat.com)

[0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings

Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
---
    cvsserver: avoid precedence problem between ! and %s

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1925%2Fopohorel%2Fcvsserver_parentheses-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1925/opohorel/cvsserver_parentheses-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1925

 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4e1bad33ca..076c10cb2c2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -5009,7 +5009,7 @@ sub escapeRefName
     #   = "_-xx-" Where "xx" is the hexadecimal representation of the
     #     desired ASCII character byte. (for anything else)
 
-    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
+    if(! ($refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
     {
         $refName=~s/_-/_-u--/g;
         $refName=~s/\./_-p-/g;

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
gitgitgadget

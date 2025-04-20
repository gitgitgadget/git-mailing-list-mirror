Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01491E571B
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155180; cv=none; b=IXlSCXGlmb5ElhILU7FU6CYn7ac/SQhXzajol+7TEK4QoAX1K472iSCmKfPe4L2T5iexiqEcga+AWBH7YZa3rQ02xAfz+J1eNdb+BQwRSe2D2gx2Uvl9XowiKaXm6zjfLxvn/jB4xW7OmC6QxjCjhleRk0WXwcFJ5c6c7HHSrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155180; c=relaxed/simple;
	bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jH98OW49XnpiyPufxBTTGbHcsvLJCewwD8u3g6llkPBzP32846hegVs1w9gcoXGryXcCq5nGWZ/lOE4JZGWDN48cg6ZcjrAGt1z/p3JlnpMXA6YS4d8/e0Vi1cfxYopk8ZstxcdhMtoebOADc9FbXrLW8QRtx1naZXdqVAgTloo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRFf4TPN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRFf4TPN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f620c5f7b9so3134378a12.2
        for <git@vger.kernel.org>; Sun, 20 Apr 2025 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745155177; x=1745759977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=NRFf4TPNp8b1v/K8AwwCjn5A4O+mbFCvXOq/edvGX6SrsSswEc1YRIHa04/qseuACq
         r1MmnF4gkmtJ0YrGFHcHEUervuVkTHcf46GaIFcxFWD2GfyiSvb0CWm6yzH4MctBY0/U
         h3OvYjmEoP/EiP3bp8N2nDc4WUE1oUdcz07tj8dcrfvxxcB/YcDvXv6MaavS0QdtI+P3
         ttDfCc9uNo4IAM8+X8t4WI53WJv3U9ZiKyP5MBJpcL12GAh4cpbfTnDYtjEm7UBTkZzA
         mPr+lTkSweLdlHZfguV+6YMpR2fT4WykjYMEAyu3v0RKpgmJbtNFfV+LBQMImDvtREm1
         vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745155177; x=1745759977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=jp1IVJBGOasDXH4vJsJM9WehB7833r02+1vCiwA6+Y8VXfDSujv3HGuzL6z5RIk6Rk
         3+aDp5BiGE54pxy2uEciWiPYweM856bQUZkxXveVwnKUDWsvfmy39tX9OgKmCZy8ODCI
         urSS4UsThioC4cn0LzkoXQpvwNUe57AGsdbh883OH49ER+ohyO36kfWdAb26y7vnIfMQ
         WWx1314fQGInq4572nvDsN0kl03jXc+s4qNQJsi121bHqULyjd4B5AUg+zgCA+FYCcqp
         eVJRnByUg/QISdgL496O23eiz3U3dIkd26kDRl2bFJd3oCERJN4syWkYt1duzZhLeNee
         qAgg==
X-Gm-Message-State: AOJu0YyZjI13JFg57c5OT//73whRFG3yR69Iz/1BUu4EFZ+HvFVVIczE
	afnH1pmvd8gQMj6Zb+jRaJ3KHH5ow6VzLpDkM5r/EHcjZso3iTxk3ImKsw==
X-Gm-Gg: ASbGncsIr7aRwF9OXE0oxCY2eIqS3hGozLszfCI38r59uiGhPmvLjP9/aRr/1n1y6Xc
	vao2+dn+QhtP3QAGw+dKNWW3PUR/k143HbZyQDvqsxT4i9iy+lLfv7yg9xYBtL4FJdQ/wgeyt8+
	0lNkmKGKFkA1G0eBLrFKeDetLCnAw/z3LskVdLwxAndE860PnX5IBDArQrtPCbwDCmBKEmgWse/
	MLw0pLu7xltdJCCg6NHoLKYVEMM5fmtE4d+6Zr3wdTrokMdk4NkLdhnG83Axh31ts4U6Ruc6pkt
	FOxEza+pVOEx+S6f9UiKvqJb3uswLkHzzfN6d1GnNkWNkfQ=
X-Google-Smtp-Source: AGHT+IFyd4QpwlbvyzbGXUOf2XVyixbMmmZpot81nflBzpVBuGl20G2EoVUj7LYguNHaWJ/HAt3ppA==
X-Received: by 2002:a17:907:3e9f:b0:ac7:e6bb:a0a1 with SMTP id a640c23a62f3a-acb74d655cemr800405966b.38.1745155176933;
        Sun, 20 Apr 2025 06:19:36 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:7cb7:e0fd:4535:dd46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6eefc703sm397872566b.94.2025.04.20.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:19:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 20 Apr 2025 14:21:33 +0200
Subject: [PATCH v4 1/5] coccinelle: meson: rename variables to be more
 specific
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-505-wire-up-sparse-via-meson-v4-1-66e14134e822@gmail.com>
References: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
In-Reply-To: <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgE9Ga4wMowcXVpCS7l284Kl9LPb+M0rPnkI
 mGsfFrmgFlIzYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoBPRmAAoJED7VnySO
 Rox/0qEL/AifVSye/ZzNWfaeThNxLANjzmhBVB3mackgJb5sR0KrCj0FlFP4Sqq6xmpy0n0MycW
 HLtu3oQYGu6qjHvbsorJTXhIdCsaBL6ep9DPoXa5gq/H4wXBN/HAbYWxKnMadypjUSs4/Azk37j
 mAhWQJ5ePSukVHPnPKUwsCEDkt3LCB4IF8ZrSlsqEjAvzuVRt9xDJ4vp94wy5D/HfxJow5fRQTL
 BMOtnKKvc5gdOym7VBZdoTYBW5rGIFl5HrmiLpx8lw2o8veE46/w/T55fFNTbnpzrsw+wiz9Yog
 jgSJZ3ExSdD+KxM9/ysFrdZ6K4BWQyyoHYdP2ViVkyVETrCTkD6MpAiweCube3khIICyXbMPRo8
 lo8UiqbxkfbAQttZbHv4NJH+hMsihbzPLREJ1Gh7iXxXIvIHCMBeOdFyZTLSn8+NYauQPiATvF4
 2ImpomFqAeUFurD+9oGkEDVTtCQswGqzdY4ws5FDxL2ZXtZiqwQLVrjNg4fgGbx6e0iMwyU3T84
 sg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Meson, included subdirs export their variables to top level Meson
builds. In 'contrib/coccinelle/meson.build', we define two such
variables `sources` and `headers`. While these variables are specific to
the checks in the 'contrib/coccinelle/' directory, they also pollute the
top level 'meson.build'.

Rename them to be more specific, this ensures that they aren't
mistakenly used in the upper levels and avoid variable name collisions.

While here, change the empty list denotation to be consistent with other
places.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index ea054c924f..03ce52d752 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -55,18 +55,18 @@ concatenated_rules = custom_target(
   capture: true,
 )
 
-sources = [ ]
+coccinelle_sources = []
 foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
-  sources += source
+  coccinelle_sources += source
 endforeach
 
-headers = [ ]
+coccinelle_headers = []
 foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
-  headers += meson.project_source_root() / header
+  coccinelle_headers += meson.project_source_root() / header
 endforeach
 
 patches = [ ]
-foreach source : sources
+foreach source : coccinelle_sources
   patches += custom_target(
     command: [
       spatch,
@@ -78,7 +78,7 @@ foreach source : sources
     input: meson.project_source_root() / source,
     output: source.underscorify() + '.patch',
     capture: true,
-    depend_files: headers,
+    depend_files: coccinelle_headers,
   )
 endforeach
 

-- 
2.48.1


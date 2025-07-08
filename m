Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21F21D018
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000474; cv=none; b=D7q+hH3PuPFTM20Vp3dPnw/UJkh2oC1y/pE0Y9iEu40Rb8P5O+y4TqIS6N032H82SvOgizbJo32BNWEk5zuQEEmiZgG62TdyjNIXGHZ+ep30cPPc/LRMlEvTZLdZsGeMtO86hR7XT5rfBT6Ju7G0M+eXyCaSR7lzhLLHLZx1dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000474; c=relaxed/simple;
	bh=6BwsRcm2lPFHWUH5Cgk6cz20C8r3R0MUO96JSm62O9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDPBwy/DjxBrYImQHSnQySNnRhjPbhSR05jjQSa8/kfB96YlHk/3YY4SgZ6k50U9hYRL3z1LFXBelWhpWaYkT1VrLIqWr4lgfTqscyYFjpbM5JqMRgBpmY3fd4Qto1N6kAajWx4PAwsHYJjwOzt7GcF1+r/+fjoX6nVLmWUFKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=YRKbKYZJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="YRKbKYZJ"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e812fc35985so4047361276.0
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752000472; x=1752605272; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdMIywRD2WWUppIH8DpJah0zl9E1OGs7eIDaLvhT3zY=;
        b=YRKbKYZJN5J5XsV/22HGejD9dHD8oOpaqIdhx50KlbH2xhDGTPto+rkw49ce4jiajx
         TLPxzVeyRiMmUULBHTfazv7fGQm0/pas+lO5hZFDQG3S499uALAds8GDuypVmzchvzLn
         9LaynJZezMmeWL+oX6gxOvgaRL34JlRe2rzph7ftofF9GI1sx/TFzcnbC1DMyLgv0CgX
         RJTdR9Z7VCb+DJBvdCtiRraFdvSsZ3/sdehZ1e9Sddv6dLyK2fiptYIP4X8rcBFHNAhL
         xNDzhn7GWPh2KyDuEIgJkM5H3s9elG4ymIpTWM6/fG4DBkCQDFNzKEXsR2jJjv9xHCyZ
         i4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000472; x=1752605272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdMIywRD2WWUppIH8DpJah0zl9E1OGs7eIDaLvhT3zY=;
        b=R3lHdGDZeNiNs51HQ29ZNseV232qSQjEXEbXsZsTZLmipm5bDKHQHw7CjfrXO92wwy
         eMqTwB7GcSwNfHFzj+5bB1uX/I7B4dlQjIT+7h7OEsLzYigdPxtIBy9DBw8PinxkhtI2
         BBpdqNuna30Rt38ZjdAT4tB7as1rHVAGOXYVoWI2Y649VzulTsJ1650em00m0obZjHT9
         qD3il3k0TBKp9/qs4JEAlFCnQE0vYW7fvFpOvLI0io7JkrpesYxJsOECCr1De5TyAEve
         IgQAx+4krfhnrrgj6TmzEVNq5JpAAqnKyFli2+540q2rb6A7fikJ011+zaVGgpzHRykS
         yvTg==
X-Gm-Message-State: AOJu0Ywtcwy7suDhBbaGksyFdFQoGwyUSb8OzLb8Iqq5YGzwGB15p4y2
	oOLETGfttdUrMqo0iDoKecrGsdLD4kTnodKa2SXJd39hF4Z+Kna0XAW7UAIbS0sPCUWv4q+A+6E
	Es+JD5H8=
X-Gm-Gg: ASbGncvMCiRy7W/fmOOucJ9Vp3DuJvx8VTsepzYUtRo+Z5tjZj0tEV4Xq5RfdqkPSYj
	xHcNCimHPgjV3ZwlEPtv3eMaCJW4A3F2Wn/DfhgoKeWSe8IkYWYI2HvMpz4IN9U3zfXazho1qdk
	ZwXf99GjsIaKJmwdPoASG2dIogspYhfh3yFH/TIC5rBMMu+p4GNA91pXD+7ZXYUMAOc+Wz8jMR0
	uJnFGZBpuPPBUPb5IF9az2fZn554nYu7cTZGAbyg3IK//B/MR7o5krDSD1tsahJ/Lkm8zLd4Wey
	eZI+d4LpexPKGoXKfv8nySaRPCQsxGiIlVDMZ9WNtKtn38pUWqo/qoOeUUtDU7GMmg2uGlW0h6x
	ds8xEciknLLfRXTeaupwAdjc7LMxQTtoC/g==
X-Google-Smtp-Source: AGHT+IGJlJkagh8qNKV0Jj2DfhSO/KibA1BxVRfEv7RbsG9bak2g+y4Czy3mnosDJ53N5YQL/4564g==
X-Received: by 2002:a05:6902:6012:b0:e81:7acd:f77e with SMTP id 3f1490d57ef6-e8b6c44b518mr987901276.6.1752000471682;
        Tue, 08 Jul 2025 11:47:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e899c340aa3sm3468350276.21.2025.07.08.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:47:51 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:47:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/RelNotes: use .adoc extension for new security
 releases
Message-ID: <d45d881536585ebaaf21ad5089afcd45523df783.1752000456.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When preparing the latest round of security fixes, we wrote release
notes in v2.43.7, and then successively merged those up through to the
various 'maint' branches.

However, the 2.49 release series is the first to have commit 1f010d6bdf
(doc: use .adoc extension for AsciiDoc files, 2025-01-20). This means
that we should have renamed the new-but-historical release notes from
*.txt to *.adoc during the merge into the 'maint-2.49' branch, but
neglected to do so.

Rename them accordingly to match the convention introduced by
1f010d6bdf. Since the release materials in question here were prepared
before v2.50.0 was tagged, the 'maint' track for that release series is
OK as is.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/RelNotes/{2.43.7.txt => 2.43.7.adoc} | 0
 Documentation/RelNotes/{2.44.4.txt => 2.44.4.adoc} | 0
 Documentation/RelNotes/{2.45.4.txt => 2.45.4.adoc} | 0
 Documentation/RelNotes/{2.46.4.txt => 2.46.4.adoc} | 0
 Documentation/RelNotes/{2.47.3.txt => 2.47.3.adoc} | 0
 Documentation/RelNotes/{2.48.2.txt => 2.48.2.adoc} | 0
 Documentation/RelNotes/{2.49.1.txt => 2.49.1.adoc} | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/RelNotes/{2.43.7.txt => 2.43.7.adoc} (100%)
 rename Documentation/RelNotes/{2.44.4.txt => 2.44.4.adoc} (100%)
 rename Documentation/RelNotes/{2.45.4.txt => 2.45.4.adoc} (100%)
 rename Documentation/RelNotes/{2.46.4.txt => 2.46.4.adoc} (100%)
 rename Documentation/RelNotes/{2.47.3.txt => 2.47.3.adoc} (100%)
 rename Documentation/RelNotes/{2.48.2.txt => 2.48.2.adoc} (100%)
 rename Documentation/RelNotes/{2.49.1.txt => 2.49.1.adoc} (100%)

diff --git a/Documentation/RelNotes/2.43.7.txt b/Documentation/RelNotes/2.43.7.adoc
similarity index 100%
rename from Documentation/RelNotes/2.43.7.txt
rename to Documentation/RelNotes/2.43.7.adoc
diff --git a/Documentation/RelNotes/2.44.4.txt b/Documentation/RelNotes/2.44.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.44.4.txt
rename to Documentation/RelNotes/2.44.4.adoc
diff --git a/Documentation/RelNotes/2.45.4.txt b/Documentation/RelNotes/2.45.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.45.4.txt
rename to Documentation/RelNotes/2.45.4.adoc
diff --git a/Documentation/RelNotes/2.46.4.txt b/Documentation/RelNotes/2.46.4.adoc
similarity index 100%
rename from Documentation/RelNotes/2.46.4.txt
rename to Documentation/RelNotes/2.46.4.adoc
diff --git a/Documentation/RelNotes/2.47.3.txt b/Documentation/RelNotes/2.47.3.adoc
similarity index 100%
rename from Documentation/RelNotes/2.47.3.txt
rename to Documentation/RelNotes/2.47.3.adoc
diff --git a/Documentation/RelNotes/2.48.2.txt b/Documentation/RelNotes/2.48.2.adoc
similarity index 100%
rename from Documentation/RelNotes/2.48.2.txt
rename to Documentation/RelNotes/2.48.2.adoc
diff --git a/Documentation/RelNotes/2.49.1.txt b/Documentation/RelNotes/2.49.1.adoc
similarity index 100%
rename from Documentation/RelNotes/2.49.1.txt
rename to Documentation/RelNotes/2.49.1.adoc

base-commit: aadf8ae518afd80b73d49eff8aff475161aa5157
-- 
2.49.0.dirty

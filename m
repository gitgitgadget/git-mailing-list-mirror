Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122FB3876A7
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998425; cv=none; b=BEWjzTSGME591jBYlNCkWbd/PXRh5wZFZLaQYj5od/cIue8fiRFCvCYy0EXmBoiJ8hnsmVIWWfsMoAw97slTLPYnXJfpUuAgm/XTdHYw1rsUrJ+Yt0zZ7MUcji6T2d4p8pGzkMwFQ6cNSF4DiWkxtaG+OK2+mLQYgUNd9vAOryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998425; c=relaxed/simple;
	bh=EsSk6FuJ9BYy4VvVUNxe0+URBTuDnnzWVHjXRxhcu+c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GTDKERM67Hl4B04VgrLzrGYOOkXTMfe0xkoqvvy8zODqRpAFRdSK525c0qLKh9N3DtZ3JWobFMQ2iFBflKxMUCeruXWpHlU/x17irzem1YO21zldhFN4crQlaBBrUefC8ihT7TgKekO6P3G50y0FDos2PY7lWyDnbEma2T7JFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y87GCkBj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y87GCkBj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso741047a34.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785998423; x=1786603223; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+oxKeIJJ+6BGoKmtsMKk5DVJZ2DmcpYX6dRVuWYSlZ8=;
        b=Y87GCkBjL7/G59xHPbsYdxEXqVEzxoWxaj/UaBSsrB5HrCzSxQTt3d2imbEZTdb/2p
         CVk+0+6kSiwhU8Ncbcl/mZyywF43RN7SWBH2kkTCiT2q55afl0M0kdhG/EvQu7rhHzTX
         V3og5YK4Nlg+9TvRcW9baCxXPfDMLU/Y5uMyySo9IoeM0vh7uD++xR2bY02jUwH3+EU6
         gO92iVY5hhrt7KTV9zwdHUtPEtk8PcmF42Zb4ZefqK6ySyhUEB3TAa2QYVEdsekmLp4w
         RHEPswMPU/3wo3/E8cHRKtJSa6j1tUCL0VKUQeqcxDxHHTFKCUl4GCaI83xCRPYlw5ep
         9iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998423; x=1786603223;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+oxKeIJJ+6BGoKmtsMKk5DVJZ2DmcpYX6dRVuWYSlZ8=;
        b=pblWlx2wxNeEjkoETG86/70RmjMuxcuOS3li+ice41NhQ8bhGNXeHnEAWJNgHHNnro
         iFWpzmGoBgg5hK1CeriHHuIudzUKOGKWK7x7vtTin7p/2DBiVQK1OIYp1NLQZspwUy8D
         9UxdBRabqDOA9ixRHKxRCA/L/M6u4heJnSrmzOnpBhPUye/xFtZDOWyUQtSKN1KsSUNH
         UE2aotTs7EYfH/DWze3E5BTrbjGFaN1mYe4kYr1LY6wXSvO75i+eLZaIVGbbi9IqyOEJ
         lTIcaedhUP7Y96mzZzFHS74MFV1LUzQHB98q0vP6NVj1ib/smoWkbqi0Q4H1LMJRa69B
         QYlQ==
X-Gm-Message-State: AOJu0Yy1yxWPLjdbXoBeogLlFTgrk0S56Qr1+VMXmqE48/reQvATa4VG
	/uikcAs9PNED76SUu1Er8Lb6xrOPpkEOAzfYABxDgFVThNYJgJF1qFR4aGddUdB/
X-Gm-Gg: AR+sD13n1Mk8ub8uSjQf3b/Ga1BDpTt/LqKiVVw9eDoSAdEF5GNFK34iSKDuEteXRpC
	K/o+9hEDGm71wvSw+Z8tASg1RIPLcgFSUWQT79RmA9LxOXF8NEmgz7OlnODMYaem4IK23/EWppx
	cqnGPDjYOFlBh3c4PI2p8OUZY60M5sD9baASZ5RkHke/21APnOyiOCPx1hJxs506Nb4XsYtCspr
	UaFW86KDjCLfr9xgjymlB5MojVZrfjrZ5gr2Dgri23QUnwB6Sm1/6w3L3TPwF1jWJvKrlzVnQjS
	j5hC1whvfBvFnvUMvgarub4W3VAMDvJznPTHPNsjdaqPo/mdVPwrFh6M/g7dH1cVZfIDhsMKHE0
	/x3+k3mVHF5aoVjxZ8NPBYkRcldeUhXwEkavLwdGwe2Rf0lbQXqfQBMECdRwcjMgmXJtFqyXG62
	yV8uVJnjXDW0STah71dYovI2G23PnNKWe4G7nPQWdmjuQrwoUJAfoo2//OoGQ3m1XE
X-Received: by 2002:a05:6830:6105:b0:7d7:ea9f:c0f9 with SMTP id 46e09a7af769-7f1e5996ca2mr7497579a34.0.1785998422770;
        Wed, 05 Aug 2026 23:40:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.80])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df5a664dsm4301550a34.24.2026.08.05.23.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:21 -0700 (PDT)
Message-Id: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 06:40:13 +0000
Subject: [PATCH 0/5] gitk: make color preferences visually more pleasing and better usable
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
Cc: Johannes Sixt <j6t@kdbg.org>

I find the user interface to set the color preferences a bit ugly for these
reasons:

 * The color samples are not clickable as one would expect who enters the
   dialog. Instead, the description is the button that must be clicked.

 * Since the descriptive texts are different for the preferences, the width
   of the buttons are different, too.

 * The descriptions themselves are not always natural language (read: they
   are nerdy) and use abbreviations.

This series makes the descriptions static text and turns the color samples
into the clickable buttons. It also makes the descriptions and dialog titles
more natural language.

This is the dialog before the change: Screenshot_color_buttons_before
[https://github.com/user-attachments/assets/910a647f-4e56-47b0-b4c4-e6e7bc966e9c]
And this is the dialog after the change: Screenshot_color_buttons_after
[https://github.com/user-attachments/assets/d985d837-1b1e-4b43-8bcd-76bca8d060ce]

Johannes Sixt (5):
  gitk: set intitial colors of swatches using the available helper
  gitk: condense repetitive code around color buttons into foreach loops
  gitk: show color preferences on the button instead of the label
  gitk: use more natural language for labels of color preferences
  gitk: avoid constructing dialog titles from text pieces

 gitk-git/gitk | 123 ++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 64 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2194%2Fj6t%2Fgitk-prefs-color-buttons-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2194/j6t/gitk-prefs-color-buttons-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2194
-- 
gitgitgadget

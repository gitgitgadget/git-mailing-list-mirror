Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B91662E7
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698708; cv=none; b=IxtwXyqeRD3jTp8HVzhRBJeeessOspOCliPurWWfpsG7o9g5Q/qan4mOzvsf/UrNqfieUcMlQBigHTEYU5HdziiVWd+KYMQu9kGppvdsFn0h5yNe6ttlO/x4lgcHRd/eOoQnThWtUYR5g/zUej/lzKeuSXLixpP1+v7HX2ZIqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698708; c=relaxed/simple;
	bh=w6EvcgwySvGUGJZnnhJg7GpzrDssGYm44lgU6O/7ZmI=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=NQCcoKXbOmX3G1ED2yNRyg5eo7OXFPd+uNe92VYshHHS41afpXyTGLh1TUbcneF/LnDKcLzTWBcDhm1ZLydvfLT2V0eTf+iKPhhLSJT/5JOOaVehUDN584P83QRlyuoxRc5QjcwpN2olxjFckH3KfR0M+Q1eJUUE6ZVQuKckAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL8sXN8J; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL8sXN8J"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-91179e3fe34so210345839f.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759698705; x=1760303505; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zFNQ9lN6KUTS5Gp0tVGt1/lL1i5V2RSH0BL8Y4j+UlY=;
        b=UL8sXN8JoACbF0KZPfF2DHIjMFDPNncoaMdthDZ+jS2fqI/1HDgPXo5WM25Bb47yDR
         whocPSrtsTMq/K7dVBHgVN0kd3Hys2ciCXivZjquqhVBbDehO3SdHpzgpynErgcM+OfI
         qSYOxlA9s6RHvo4eduLnX9JNVTKvuKwnWdOPLk/j71tDGRjc3RTY865oz+Z+0mXFgaV/
         Rs+lgM4eeGM/iGYm613XHeNgr9Brn058xI/lRhXr2xoH1YBuN0IF35SXth25vH27eCNt
         NKBCIXnOdnczHjq4Hvk+2FmAu3V5t6MTQUyfvDk3ved2HkTJJw3Ly1x4yCB0WXOX/m+c
         V3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759698705; x=1760303505;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFNQ9lN6KUTS5Gp0tVGt1/lL1i5V2RSH0BL8Y4j+UlY=;
        b=LZr8atmy+S8R8/TAYs71lKTn+Z8OtpuDccsXdMu3EdXYx2BTIefELAQRZxf7wevG+F
         g8AtfPqQDlThUnZFmIZ8+HKSyN+KQ/2QCrwoqZiqYW4pdO1dACCav8s29FFEUvDKEN1w
         juviGfBXhC/fPvijqS7pVgvgPfF/PjkEnpwNQ2tuYJGi6lnpAZsyK6h78v+rY0PKZK1x
         mClIA/jAEETRnilJrJ8YS4f/t5XQEtH8R6VsVerFcLCNByf0WTEzVmQs3oHw66IjTgGJ
         9l2TBUzcq7wVpN6nGUBv2kn4E6y+IUF67bnTPJYC/mtwvOnBSoFAerMPjcE2t3I7wHoA
         qNGA==
X-Gm-Message-State: AOJu0Yyn2xaNcz+5uEltZiMsAmF5omYVGbmNf1RyHC//pnPyKggmQhke
	c7MfziasMfZLnddVqRDjSOmnwyHhM7OXDCNsRCPkGwv1JdPE9R0Zde01Efq9Uw==
X-Gm-Gg: ASbGnctyc2qeHldxRY1hwGj+Ujrygu+mxZf4hAqcdYC3htQI9LGMdlql6D/h/GkC++J
	cW/cDNTOeWLnUNiicoDES5np4vip0iIEAf+QI0H6b8ytL4NXV4clP4QGXFkcyJNWttwEha3n3Oj
	5j4qEPc3vVZiqIMULj44Xyxm344P2l5OrCNfT7pJouwhnsHdMUxwdcpT94XyU3PbtaKI+53VUlC
	cdUIPnzOywXjFRNXrzKKMej0YoXzgNvACqnb1XHb2DFRazPDC//5tiWSZxjxc3KVZYxLr2KwDTw
	NysBNuSoRjkrGjFZHJOqqaRtcwy5nQFtY0mHGP6NdWQZqLuWMIVd7+7fcpIMuw4Vxlcb/WQ1ibI
	7e7bH2BOZHkw6y7HCOAXbDCw7iEf415zKvFDZtaBlEXFVz8f2MHGQAe8NDs28E18pKuTvEg==
X-Google-Smtp-Source: AGHT+IGwCYXbPTlD56piJet6p5bJ0ifG26WjtCcD3bnn2ou4riMaYgNdUtsFrpoAMO1jnEM8UX60sw==
X-Received: by 2002:a5d:81d4:0:b0:8a9:4e94:704 with SMTP id ca18e2360f4ac-93a666de022mr1499906539f.3.1759698705246;
        Sun, 05 Oct 2025 14:11:45 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a88961d74sm421301239f.22.2025.10.05.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 14:11:43 -0700 (PDT)
Message-Id: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 21:11:39 +0000
Subject: [PATCH 0/3] doc: convert git-stash, git tag and git worktree to synopis style
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

 * Switch the synopsis to a synopsis block which will automatically format
   placeholders in italics and keywords in monospace
 * Use instead of in the description
 * Use backticks for keywords and more complex option descriptions. The new
   rendering engine will apply synopsis rules to these spans.

Also add the CONFIGURATION section when it is missing and do not refer to
the man page in the description of settings when this list is included in
the manual page.

Jean-Noël Avila (3):
  doc: convert git-stash.adoc to synopis style
  doc: convert git tag to synopsis style
  doc: convert git worktree to synopsis style

 Documentation/config/stash.adoc    |  29 +++--
 Documentation/config/tag.adoc      |  22 ++--
 Documentation/config/worktree.adoc |  14 +--
 Documentation/git-stash.adoc       | 134 +++++++++++-----------
 Documentation/git-tag.adoc         | 173 +++++++++++++++--------------
 Documentation/git-worktree.adoc    | 161 ++++++++++++++-------------
 6 files changed, 280 insertions(+), 253 deletions(-)


base-commit: 5099f64a82ccc80f3c6567589bfeb5e9a1b9fd6b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1969%2Fjnavila%2Fdoc_git_stash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1969/jnavila/doc_git_stash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1969
-- 
gitgitgadget

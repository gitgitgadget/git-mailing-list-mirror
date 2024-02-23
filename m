Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091C17564
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660119; cv=none; b=nZGctrTct7BXt9PjJDHWOHMu5LpbVSWOXXYYo52enT9TnNUQ+zuFqGbDlkOg9DAVMPCucfD0rM1YCXooQSPem/sRAi+fAbBHMbFrmPcHoBvhQ8j+PKmAIGhS5vlE2ef7kcP31eAMN/0DX3XJ42e9vSe9kIQr1OgHfiLLt7sx4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660119; c=relaxed/simple;
	bh=U9EH7/YiM/D5fBVFo+NsERguNWd+8FvX+0/P/oaMCsA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bszJekFilg6eHqZ7IFjbwLdSSQYNahUYH+0ym+ZDrGg9IrOehGfkAsKzsldmqnvG26WjD7ROuigCmuGjc5uVXDXWxfnimB2rKFtZqzVsQwhTGDYMDgDr3Hj48ecXb2l5QIaE/ARf68XIEyVvay5/gkzuBtNozQAS5K0rDkTdAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwufu/iX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwufu/iX"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d754746c3so256811f8f.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708660114; x=1709264914; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYHADYHkH1GPLpPRnhPeuD6mlBjRK20R/hij4ZwQlec=;
        b=Bwufu/iX2IyV1aQWx8rm7O/3Gr394G0RgbXT2k96YYy/GNfayDfgQXV4+SqNByE2w9
         GDfvRq5J7tP2a4fZOXt9nSZ9ZNfRy/aRbHTcgB+XP/O2ZNUBsaxodH5AzeyH0SpkCGRP
         54gt1O1EDSSCmcqlgS/Eu846KTVldLn/E6Z9MTmN3VUqZiSwx8ZN2F5exSXs2kwVbtGs
         kFp6+ikaQzrZDSILt3BDmTh22ONOrml14N3We2xQRAo6odGamA7sAlDbmRNrM7Or4ZDD
         YKdqOQIFZ0jXyu92ABc3hAHE97QAmRjILzEjunlRzNpSbu2iul3lk6QI2xKoXvsqux+0
         4/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708660114; x=1709264914;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYHADYHkH1GPLpPRnhPeuD6mlBjRK20R/hij4ZwQlec=;
        b=FIKqnh84Y9RIk2Il4yBg/m5zKpmTAmFomc3lSbOsdo1fl1MFDEOD6ODa6LvQw4yiSh
         F/IijCREJnnNkwk1TolaBRbEU3wZUbMFdI0tro9KsRyBhtLwKsoAnn2n0RNzHsk4CsBK
         2T9+Sj+1rJv2VlRxh+qhlgY61jvWeh6zCv/n9ez+AQ/eD6FCrzFEoIpaIL2OK5WPZA2a
         7J+O8G3WXPxsHFQRWZ8GfAMkbCaApN4eCt3dbQaXdqktC0RiBTvb/cOD5TJxh35XjN7o
         sRdtfpxjKZD9nCYO7S2Xhtre+5Fq1CwhvbsYNCTynMmr1xOt9PoIEkA22EySjbkq/TEc
         S2SQ==
X-Gm-Message-State: AOJu0Yyh/x3QfPpw0loSOqS5VlSZCgHhm3KvoYqKMCCELyhdcmmLP9DG
	DbuflDfFW6vVBM8rC7CdTLSFZMABGWgXBqqcW0A+BPOdUtSHaCzcjCkmvYrT
X-Google-Smtp-Source: AGHT+IFJ5mKjsGFXS4nM/zrNNv8V0LP2hnef4qlvquPmMF2Z3TRRH3dYGGmVA3MwnyCZU/90LBC9Rw==
X-Received: by 2002:a5d:4aca:0:b0:33d:731f:b74e with SMTP id y10-20020a5d4aca000000b0033d731fb74emr639177wrs.6.1708660114111;
        Thu, 22 Feb 2024 19:48:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25-20020adfa2d9000000b0033b79d385f6sm1091165wra.47.2024.02.22.19.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:48:32 -0800 (PST)
Message-ID: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
In-Reply-To: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:48:29 +0000
Subject: [PATCH v2 0/2] This PR enables a successful git build on z/OS.
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Haritha  <harithamma.d@ibm.com>

Since the z/OS linker does not support searching dynamic libraries, and the
current setting of CC_LD_DYNPATH results in a directory to be supplied to
the link step with no option as the suffix, it causes a linker error because
the z/OS LD linker does not accept directories as input. Therefore, we
workaround this by adding the -L option. And, Introduced z/OS (OS/390) as a
platform in config.mak.uname

Thanks for taking the time to contribute to Git! Please be advised that the
Git community does not use github.com for their contributions. Instead, we
use a mailing list (git@vger.kernel.org) for code submissions, code reviews,
and bug reports. Nevertheless, you can use GitGitGadget
(https://gitgitgadget.github.io/) to conveniently send your Pull Requests
commits to our mailing list.

Please read the "guidelines for contributing" linked above!

Haritha D (2):
  build: support z/OS (OS/390).
  an improvement: removed configure.ac changes

 config.mak.uname | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1663%2FHarithaIBM%2Fzos-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1663/HarithaIBM/zos-v2
Pull-Request: https://github.com/git/git/pull/1663

Range-diff vs v1:

 1:  2eddc8f8860 ! 1:  53e211d7a65 This PR enables a successful git build on z/OS.
     @@ Metadata
      Author: Haritha D <harithamma.d@ibm.com>
      
       ## Commit message ##
     -    This PR enables a successful git build on z/OS.
     +    build: support z/OS (OS/390).
      
          Since the z/OS linker does not support searching dynamic libraries,
          and the current setting of CC_LD_DYNPATH results in a directory
          to be supplied to the link step with no option as the suffix,
          it causes a linker error because the z/OS LD linker
          does not accept directories as input.
     -    Therefore, we workaround this by adding the -L option.
     -    And, Introduced z/OS (OS/390) as a platform in config.mak.uname
     +    Therefore, -L option is added.
     +    Also introduced z/OS (OS/390) as a platform in config.mak.uname
      
          Signed-off-by: Haritha D <harithamma.d@ibm.com>
      
 -:  ----------- > 2:  05df5d7e2d5 an improvement: removed configure.ac changes

-- 
gitgitgadget

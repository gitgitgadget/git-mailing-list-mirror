Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D197484
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841445; cv=none; b=CB5W/OyI8gE0wW13metObFYyDT4m/CASviTRARcaEH6wacpa/EsXwXYdnBiUWfdOgYeuZ5D2N3+jFYFRpA9nxbx62EkwTMmfWhNKP6zvattPXawa78QHFdHe4uUZbzimbiG+j8PBtLDg80bI3K7RUBrG+JbVaWgCAMOjZlBpYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841445; c=relaxed/simple;
	bh=RFyol+nf3zrwrkQNUwmC3ru4XLg0mvFbJmB9EOcPj5c=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=txJ4eH+XkfciyZXwL5E9y82BS0NjOnjqaTDhjK238BF53WnBoTdFTMwLrKkrqlBpxVBF/dd0m2E9zNcyz+Fyd+W8qV8+NxUAxIU06KB/QSXS/8VhNWxLBWHPqltCdZQ+bg1NsP2bNhDppTkph0/VVkLyp0tbMRtQRjoMgW+M8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqGL3GzA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqGL3GzA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a3716284so683855e9.1
        for <git@vger.kernel.org>; Sat, 24 Feb 2024 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708841441; x=1709446241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZL/TyrUUSKdCf72nrrg+enfXL1BZp3BAd8ieHtVpH4=;
        b=FqGL3GzAxEHkvXxDkhczyUTrM2CB8qJJF0gB0CX/oQzXqkbJGji1DSL4XhpcobjG3w
         kUV3Zq3sCuydfXfzDNtTJZjMIoDX/kqgWPT1zEwtWrjanBw02d1yriEyu0ptJOGatOOI
         MIytZt38XGBCqJgaslzQONlRAP//JLyg9OJt0YD0yjiQudefEWpioWE9lv5emKhwAT56
         si5nfUwTfru4tTpUQHtWUiAvORagT9BnRXtUFd/AKqNvG1uHCedF/sUgmxdWVXSkI8Dg
         4U09AWd6AL0b0TGxq647XYLRrlS8rgBtg4xpmOGcM19jZSK6zKYEX0RBIFGuM1Wv7u1V
         QefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708841441; x=1709446241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZL/TyrUUSKdCf72nrrg+enfXL1BZp3BAd8ieHtVpH4=;
        b=ljdpNvuAKEobxVaSPQn4VkyiGArs64bIY7ZFCUYBSjyK3z4MjHWQpyV6/K0iHoXGQA
         9DwmaZhlax8jJQuazpAyBNraN4OjJnT6nY7MuvDUtGlts0BAdvdGamYYnO6wQDB6EJg+
         yOVLQe0CF2e0IuoXZABUyrGU/I8xWNtMuqW83zVHCIKCeeSDdtWrfd6SgrqevKp+4Xon
         1zKEsJb6cQfxKLpzOi2go9wh7ilGXdhKtsgqmJgWJ1tG7ChfWVjNPNAb0b2Egn+WMvFo
         UN5chglyN0TNIRIAV8kYusqSdeBzFPebwuUmNFLlH6n4WT+/VUrtOmct/AqLymPp0Q08
         d3wA==
X-Gm-Message-State: AOJu0YxhOOpUrpIB7N9BxqggbGMVBDRdMPrFG2W4Uri37F3HRit8E54j
	cBHM8i2V4KXlZThZe8OnOgs2oWaq3OtdXlt95l7Y6KKPl7oPSLk5Bw1EBDHR
X-Google-Smtp-Source: AGHT+IGuSge/iOkiD16c2BiSyIhCHw7//T5PXwcVW4/4IApUYJyTzGSFynP48A+Qo4UB2ychV/y44Q==
X-Received: by 2002:a05:600c:1554:b0:412:9fd5:2488 with SMTP id f20-20020a05600c155400b004129fd52488mr1172720wmg.36.1708841440842;
        Sat, 24 Feb 2024 22:10:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041294d015fbsm4226185wmn.40.2024.02.24.22.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 22:10:40 -0800 (PST)
Message-ID: <pull.1663.v3.git.git.1708841439516.gitgitgadget@gmail.com>
In-Reply-To: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
References: <pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Feb 2024 06:10:39 +0000
Subject: [PATCH v3] build: support z/OS (OS/390).
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
    Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Since the z/OS linker does not support searching dynamic libraries,
and the current setting of CC_LD_DYNPATH results in a directory
to be supplied to the link step with no option as the suffix,
it causes a linker error because the z/OS LD linker
does not accept directories as input.
Therefore, -L option is added.
Also introduced z/OS (OS/390) as a platform in config.mak.uname

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
    This PR enables a successful git build on z/OS.
    
    Since the z/OS linker does not support searching dynamic libraries, and
    the current setting of CC_LD_DYNPATH results in a directory to be
    supplied to the link step with no option as the suffix, it causes a
    linker error because the z/OS LD linker does not accept directories as
    input. Therefore, we workaround this by adding the -L option. And,
    Introduced z/OS (OS/390) as a platform in config.mak.uname
    
    Thanks for taking the time to contribute to Git! Please be advised that
    the Git community does not use github.com for their contributions.
    Instead, we use a mailing list (git@vger.kernel.org) for code
    submissions, code reviews, and bug reports. Nevertheless, you can use
    GitGitGadget (https://gitgitgadget.github.io/) to conveniently send your
    Pull Requests commits to our mailing list.
    
    Please read the "guidelines for contributing" linked above!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1663%2FHarithaIBM%2Fzos-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1663/HarithaIBM/zos-v3
Pull-Request: https://github.com/git/git/pull/1663

Range-diff vs v2:

 1:  53e211d7a65 ! 1:  2f1ad41bc14 build: support z/OS (OS/390).
     @@ config.mak.uname: ifeq ($(uname_S),NONSTOP_KERNEL)
      +        NO_MEMMEM = YesPlease
      +        NO_GECOS_IN_PWENT = YesPlease
      +        HAVE_STRINGS_H = YesPlease
     -+        NEEDS_MODE_TRANSLATION = YesPlease
     ++       NEEDS_MODE_TRANSLATION = YesPlease
      +endif
       ifeq ($(uname_S),MINGW)
       	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
       		$(error "Building with MSys is no longer supported")
     -
     - ## configure.ac ##
     -@@ configure.ac: else
     -             CC_LD_DYNPATH=-Wl,+b,
     -           else
     -              CC_LD_DYNPATH=
     -+	     if test "$(uname -s)" = "OS/390"; then
     -+		     CC_LD_DYNPATH=-L
     -+	     fi
     -              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
     -           fi
     -       fi
 2:  05df5d7e2d5 < -:  ----------- an improvement: removed configure.ac changes


 config.mak.uname | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index dacc95172dc..03ee2b74525 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -638,6 +638,18 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
 	SHELL_PATH = /usr/coreutils/bin/bash
 endif
+ifeq ($(uname_S),OS/390)
+        NO_SYS_POLL_H = YesPlease
+        NO_STRCASESTR = YesPlease
+        NO_REGEX = YesPlease
+        NO_MMAP = YesPlease
+        NO_NSEC = YesPlease
+        NO_STRLCPY = YesPlease
+        NO_MEMMEM = YesPlease
+        NO_GECOS_IN_PWENT = YesPlease
+        HAVE_STRINGS_H = YesPlease
+       NEEDS_MODE_TRANSLATION = YesPlease
+endif
 ifeq ($(uname_S),MINGW)
 	ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
 		$(error "Building with MSys is no longer supported")

base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
-- 
gitgitgadget

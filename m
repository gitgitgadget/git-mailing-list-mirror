Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B546FBD
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707025724; cv=none; b=Dafh8Xi4wOOXqBsKY9hnixo/7Szs5rEJKWCuG9Z9jMkAmZLREpaqsFEV2aFsmji/BiYa5mVbgkPzRvsvsmvYl5m6XIpQsLDQRgkLAYygxpbX7YlDL+4HAWgmb235a315UrarAuWIoerqRM2B8nW5Pws5KbPtm6ryKxx50WIgtXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707025724; c=relaxed/simple;
	bh=+zzACZtjRyF+gYwxLYSivO//jjL7dlE0PjBMNESNhes=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K4xRynd2hgtDE46C2/k+kAlwHNAIwXqSuB5KI3zK9p+oubf3K1kOVbyLEIEL04+xtSCPwbEj1lJBDAIyOCmmdr9vRDQu25EM9fRoTpnkZnK26rhacdxC84z1uP1YMuBVgaW/8q185iIfNMYp4W15QGcXETYOCEBylIijffJE968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICW97AAi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICW97AAi"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso1413170f8f.3
        for <git@vger.kernel.org>; Sat, 03 Feb 2024 21:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707025720; x=1707630520; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+skceXVkeKCQhUwU1BtieueuIBSjQo/3DOEAYKQuxA=;
        b=ICW97AAi5C7W6qLFP5bHuy+WimiclJQ+FlAza4x68ub9jLnSv9ArXsf+YqK3HgP9qs
         XkkIg8ohFFAf3mZfWOQ5ZM81xdu7wp0W1LUnAg79sC3bGOub4w6HZmIXt3R6q9SkI8Z9
         fSGq9F8+Mx3S11Asy5s7yxZvVpxw0UcQlayIwvs1+XetCx8J7HoGbsQg6Cgnq176LKGh
         vappscIsGVvhVfDUTUMYhROPKByqxBxAl8zysgfYgMQr5s2Sa2GSJ9S/rGxzdOTB5YQ0
         oMxeqgVLXazcre97ZaWoNT545EHpV1S1aJeIpyC3c+uoFJRd9JWJ5rq0NfdvdZ7zsT92
         cbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025720; x=1707630520;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+skceXVkeKCQhUwU1BtieueuIBSjQo/3DOEAYKQuxA=;
        b=Lffgeu2FJBhmBsn1dlU9wtR2O9TCHFPmHHUatIlEGxBZOBf2RpwEVu3dN93aAy+xkF
         Lmd4uVXNJCxbyWGRVZSYHCw9BVSd5VvvzpC8OU9Z0+5ehacKdB1A7TzpHwk399UrNThY
         5J8IJtTav03MHDmHttZou1BE2U/I8IoovPP7hy4cxrQsTxrnSJlf5Fu5qqycwOwIBUpT
         d5ugksiGUAnVfwlapCm/4De1EFuftDCUpH1Il3xqLvNETfVvJwf+aM/eo2HfGKrlKqt3
         xyHlrJ8UliciiwZ8Ryo9pJJ4wgUQE7L8HUHECheGC7GHimC6bNFIxxC4wVRVq7MDhBP0
         /LYw==
X-Gm-Message-State: AOJu0Yz9xptMBs90a6mZF0od+W+y+jyIvJfS0YgHOLR9FBmLHkDK9df+
	xPzooZ6KHJV374lHG6A+7OFzzjpWkmrPdD4aZpFr1Q9XRGX04pGmyaG3GZR4
X-Google-Smtp-Source: AGHT+IEB/FvvmNUij7qlncyRsIsVW0wABMmL0XQwT8AlTGdQ65uoKz44IQDFe+FFDfz6iD/QKMYUng==
X-Received: by 2002:adf:f5c3:0:b0:33a:fcc2:d850 with SMTP id k3-20020adff5c3000000b0033afcc2d850mr6064934wrp.36.1707025720354;
        Sat, 03 Feb 2024 21:48:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020adfe945000000b0033921c383b2sm3591221wrn.67.2024.02.03.21.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:48:39 -0800 (PST)
Message-ID: <pull.1646.v6.git.1707025718.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
References: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 04 Feb 2024 05:48:36 +0000
Subject: [PATCH v6 0/2] Replace atoi() with strtoi_with_tail()
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
Cc: Mohit Marathe <mohitmarathe@proton.me>

Hello,

This patch series replaces atoi() with an updated version of strtol_i()
called strtoi_with_tail (Credits: Junio C Hamano). The reasoning behind this
is to improve error handling by not allowing non-numerical characters in the
hunk header (which might happen in case of a corrupt patch, although
rarely).

There is still a change to be made, as Junio says: "A corrupt patch may be
getting a nonsense patch-ID with the current code and hopefully is not
matching other patches that are not corrupt, but with such a change, a
corrupt patch may not be getting any patch-ID and a loop that computes
patch-ID for many files and try to match them up might need to be rewritten
to take the new failure case into account." I'm not sure where this change
needs to me made (maybe get_one_patchid()?). It would be great if anyone
could point me to the correct place.

Thanks, Mohit Marathe

Mohit Marathe (2):
  git-compat-util: add strtoi_with_tail()
  patch-id: replace `atoi()` with `strtoi_with_tail`

 builtin/patch-id.c | 12 ++++++++----
 git-compat-util.h  | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)


base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1646

Range-diff vs v5:

 1:  f09b0838f04 ! 1:  98e516a7be7 git-compat-util: add strtoi_with_tail()
     @@ Commit message
          Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
      
       ## git-compat-util.h ##
     -@@ git-compat-util.h: static inline int strtol_i(char const *s, int base, int *result)
     +@@ git-compat-util.h: static inline int strtoul_ui(char const *s, int base, unsigned int *result)
       	return 0;
       }
       
     +-static inline int strtol_i(char const *s, int base, int *result)
      +#define strtol_i(s,b,r) strtoi_with_tail((s), (b), (r), NULL)
      +static inline int strtoi_with_tail(char const *s, int base, int *result, char **endp)
     -+{
     -+	long ul;
     + {
     + 	long ul;
     +-	char *p;
      +	char *dummy = NULL;
     -+
     + 
      +	if (!endp)
      +		endp = &dummy;
     -+	errno = 0;
     + 	errno = 0;
     +-	ul = strtol(s, &p, base);
     +-	if (errno || *p || p == s || (int) ul != ul)
      +	ul = strtol(s, endp, base);
      +	if (errno ||
      +	    /*
     @@ git-compat-util.h: static inline int strtol_i(char const *s, int base, int *resu
      +	     */
      +	   (dummy && *dummy) ||
      +	    *endp == s || (int) ul != ul)
     -+		return -1;
     -+	*result = ul;
     -+	return 0;
     -+}
     -+
     - void git_stable_qsort(void *base, size_t nmemb, size_t size,
     - 		      int(*compar)(const void *, const void *));
     - #ifdef INTERNAL_QSORT
     + 		return -1;
     + 	*result = ul;
     + 	return 0;
 2:  ee8f4ae991d = 2:  858d6f94e79 patch-id: replace `atoi()` with `strtoi_with_tail`

-- 
gitgitgadget

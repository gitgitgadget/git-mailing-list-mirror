Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323386116
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416958; cv=none; b=snpkjEOF9VSv0zAPa4A4zfhzLAwROlDPLaBwbvRaXP6nmw/y/VyDa4VA9xCdYmmwo/hpM+PpQdbbuqFVDg00oFKmUCFMFUMt/hjKbf4U280HYdhBlW7ELEvyccu5pzfDRKWlfDuMd6jxHYzR7PhhgnEajLp5x2GwCFr7xq4CJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416958; c=relaxed/simple;
	bh=mPKja0Lmnxacpuwt8EiCWEMqJJ1iMMGcVlE2t1X7gDg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HLDFb58Sp+iUC2a9orSYduR7lnhnWuz3JxGYfjbmviU0aU0mKC1e8SRGsfNKr7JdHgQySyk5ESKiVPsvbm9uzD87wjaKvzebKux3iX0WmPJTPqnwgza6+TR3tIRZhRKPs921PXKn5ayZvbX+whEtVWBvHMk38xXsR+rICJIcjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYKksFl1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYKksFl1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ae7ae1c32so333612f8f.3
        for <git@vger.kernel.org>; Sat, 27 Jan 2024 20:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706416954; x=1707021754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc3XWJtqqr27FC4E5Vmutx0UvaxrJwGDL/5+DgETZ9U=;
        b=YYKksFl1/p70i3tgP+XAWWB7FVvsMtRwG1AFbvwcws8O7meeuhsmzyjcrUoltLHaPD
         F5DgEeLFio8MvzkVfq5DBmwtf3TcxobhPZOHMnyRDcQOuoo7lAs8SHTz0MAuynmRgLX/
         evSrOCqKGO4qXsV5s6LkStJfIKBGTf9U5oWiVTrPqdgbQIH5NLRVT/w/wcNgPYTczItd
         rdm+KREfXqmP6B3Py8qHyn33lBD1567nWWHOQOEP/xnOEl9TBfcBsYQdEtynF9OBd9cU
         l2UDpRVhIeqIq+TmQje+pRwKy/D9CWNl2FVPznDHRll9cTuN9VNE5KeCfp8NlrxcAr40
         SJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706416954; x=1707021754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc3XWJtqqr27FC4E5Vmutx0UvaxrJwGDL/5+DgETZ9U=;
        b=HrO1swOYiusTsV2/eG8ISUFk5Ma1y7Ss6nyRc5x6f2v5xu6rsCVxPv9rxtSwB6D/cg
         smjCv5LiqCIBwxaoSfhHSWWm7iJIDxCsrmUI3CSeEIyG68TR0wIi++czLxaEbTS07etl
         Qem/QRp6xbsS8DqoL5dyf1cj87u2K9xaV9DNUe0mjI3BY/O97uRqtSsCa4kMDlbi1pLD
         gDEylqykTo6FHj+F0RSD8hd8In2wmBF9eJCYv513bMUtcFTTmQ7P2sdkOUV96GBvOefx
         nGjr1aFHniR2dyFdoi1IIcKHFqMrzPvMOtnD+kV4/w63ojBhB4qTCXmWqKXiKnse7S9y
         S2UA==
X-Gm-Message-State: AOJu0Yzt+pKvEYxFNVqplmWvVLSuuyy5EbaNW+GFcIoyRXB/NNuM9zVD
	s9eRQKnDF81VypW7I1/NEN3fgGYDvPU6hVkndmADS2rEd4vOIVz5Wc8+dLGo
X-Google-Smtp-Source: AGHT+IFFXFOkx2VfYjNmo/6MrxvE9oc+c6IpFKcrK0BH+fUW8jg2xLJT4W00bD9iIPrNlSY6rtoslQ==
X-Received: by 2002:adf:ee06:0:b0:33a:e739:28bd with SMTP id y6-20020adfee06000000b0033ae73928bdmr639408wrn.59.1706416953828;
        Sat, 27 Jan 2024 20:42:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a0560001a4600b00337be1c7d2fsm4735744wry.58.2024.01.27.20.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 20:42:33 -0800 (PST)
Message-ID: <pull.1646.v5.git.1706416952.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
References: <pull.1646.v4.git.1706079304.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 04:42:30 +0000
Subject: [PATCH v5 0/2] Replace atoi() with strtoi_with_tail()
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
 git-compat-util.h  | 23 +++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)


base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1646

Range-diff vs v4:

 1:  60ea85a701a ! 1:  f09b0838f04 git-compat-util: add strtol_i_updated()
     @@ Metadata
      Author: Mohit Marathe <mohitmarathe23@gmail.com>
      
       ## Commit message ##
     -    git-compat-util: add strtol_i_updated()
     +    git-compat-util: add strtoi_with_tail()
      
          This function is an updated version of strtol_i() function. It will
          give more control to handle parsing of the characters after the
     -    integer and better error handling while parsing numbers.
     +    numbers and better error handling while parsing numbers.
      
          Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
      
     @@ git-compat-util.h: static inline int strtol_i(char const *s, int base, int *resu
       	return 0;
       }
       
     -+#define strtol_i(s,b,r) strtol_i_updated((s), (b), (r), NULL)
     -+static inline int strtol_i_updated(char const *s, int base, int *result, char **endp)
     ++#define strtol_i(s,b,r) strtoi_with_tail((s), (b), (r), NULL)
     ++static inline int strtoi_with_tail(char const *s, int base, int *result, char **endp)
      +{
      +	long ul;
      +	char *dummy = NULL;
 2:  17f2dda4907 ! 2:  ee8f4ae991d patch-id: replace `atoi()` with `strtol_i_updated()`
     @@ Metadata
      Author: Mohit Marathe <mohitmarathe23@gmail.com>
      
       ## Commit message ##
     -    patch-id: replace `atoi()` with `strtol_i_updated()`
     +    patch-id: replace `atoi()` with `strtoi_with_tail`
      
          The change is made to improve the error-handling capabilities
     -    during the conversion of string representations to integers.
     -    The `strtol_i_updated(` function offers a more robust mechanism for
     +    during the conversion of string to integers. The
     +    `strtoi_with_tail` function offers a more robust mechanism for
          converting strings to integers by providing enhanced error
     -    detection. Unlike `atoi(`, `strtol_i_updated(` allows the code to
     +    detection. Unlike `atoi`, `strtoi_with_tail` allows the code to
          differentiate between a valid conversion and an invalid one,
          offering better resilience against potential issues such as
          reading hunk header of a corrupted patch.
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
       	if (q[n] == ',') {
       		q += n + 1;
      -		*p_before = atoi(q);
     -+		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
     -+			return 0;
     - 		n = strspn(q, digits);
     -+		if (endp != q + n)
     +-		n = strspn(q, digits);
     ++		if (strtoi_with_tail(q, 10, p_before, &endp) != 0)
      +			return 0;
     ++		n = endp - q;
       	} else {
       		*p_before = 1;
       	}
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
       	if (r[n] == ',') {
       		r += n + 1;
      -		*p_after = atoi(r);
     -+		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
     -+			return 0;
     - 		n = strspn(r, digits);
     -+		if (endp != r + n)
     +-		n = strspn(r, digits);
     ++		if (strtoi_with_tail(r, 10, p_after, &endp) != 0)
      +			return 0;
     ++		n = endp - r;
       	} else {
       		*p_after = 1;
       	}

-- 
gitgitgadget

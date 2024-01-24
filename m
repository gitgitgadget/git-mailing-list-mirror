Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAE168A4
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078889; cv=none; b=OmojAYNWBr3K5x7l7QPiEl8Yufazq436+didlV6KcUBCxAc3OA8mujyWMCE1Nt0D06yYP1P6QiA9pwj5eCWTzltQm2UhR5Mm9eiHPlgpzMFB/sxJXH+KAzy3vRHMNXFFZhJhyStQgcFR4MJaOQRDqXEQBoqAWX6zukXSHgyg23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078889; c=relaxed/simple;
	bh=VxT6xKoLFM1CawOApdaDjPMG1OkIv37popJrQPAXeMA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R801Cm3FF16hrytzWBVxl5mZFmlAWYTZoam9G/Dw99vafZ90Fe7Kp2vnOkWDkMMpJjU3sLe+k6kZcql7vJYYVSfhtWnXhGnR8L+i4mgi7C74dfzdCjxDRdBxSRekW5G5k0Q5O5pCEOwS8GQNO/4rzJXS/5GYzlw5kME9p68I2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUlZMEva; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUlZMEva"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ebf373130so13697965e9.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 22:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706078886; x=1706683686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSKd7DFYRy43B6JgMm1SOpQmb7awY6pFlzz8w6SfxPY=;
        b=SUlZMEvaXqwtj6CkJ1gIq7Aj7Wh2OFoAJOp7iQHIemlt9Kd36eUySXhv9Rzg/T4yBg
         utBqEGWN+XfU0NUfUEbBHzNh8IGxF1BkkBBVWjPY03JcxoTyyOO1ucnKX8b5Gd3tdp7E
         TzZswF7q/mC7Dyy3tpfhX10lfnA5TdzXdEeFQnwPgPW3x0ow8eXJsYUHM/iEqcXBAh53
         MVEL57ZVH+V2FjlWQeFfZ1WlBA3V6eg15iMcycOcV5J+z1iXCZJfrFr1mEuoGiAIS/CG
         ovc3gL9uYNLSE59oCmxdOfXFvrvss2XXTkGBJ4f7alqOkTgY4VlxHwA7ZfiiqRgFj9sD
         svWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078886; x=1706683686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSKd7DFYRy43B6JgMm1SOpQmb7awY6pFlzz8w6SfxPY=;
        b=v3CALSZeWodoM8uX0MTdxiXcjbBQK9nW/VrMpPHRIKl+WHY4g6RIpG6eh4xARsXVgL
         0HVVmd66WojiLPQetui7k3RtpKbmHl2c86CcrmQjI37JHIX2TxoEQt3rAZEJrZBOVfdd
         E+o0BZ5MjY7KAKpvLH9ZFP3Xbbp89VZjS9y0TTizwXlKy73PpiK5DfySOVl860LIUwAy
         cXHtQEop3DM7xBtQLS3cVGr3esP0BjPNOPsKN0/ShBj3aA/aWlieTFWbSag5hJHWQtqb
         1DVQzJAqxRxkJj3fLIC0kPs4Vq7OZDRZn1K3cAYm78L15SCuG+ASWt0k8jufWKR4RZwM
         sQnQ==
X-Gm-Message-State: AOJu0YzNf3xNTmucNVXXepd8zAURUHC55S+HppgexnFqSie/aI6RYX2D
	g8C80x7AODJJrHy3O5gEhRqjAMS/ZSZFN6Fla6gK980UsnQ0A+bbWBJWzbXO
X-Google-Smtp-Source: AGHT+IEj1d1RDgN1bJuM1woN0QDaHNsXqwP/YIgbk++mgkhL+oxrJKDIhAFf0Ya+02sFYWM8x0zKAQ==
X-Received: by 2002:a05:600c:3d89:b0:40e:7560:ed44 with SMTP id bi9-20020a05600c3d8900b0040e7560ed44mr1131773wmb.92.1706078886157;
        Tue, 23 Jan 2024 22:48:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b0040e5034d8e0sm48903651wmb.43.2024.01.23.22.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 22:48:05 -0800 (PST)
Message-ID: <pull.1646.v3.git.1706078885.gitgitgadget@gmail.com>
In-Reply-To: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
References: <pull.1646.v2.git.1706077977.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jan 2024 06:48:03 +0000
Subject: [PATCH v3 0/2] Replace atoi() with strtol_i_updated()
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
called strtol_i_updated (Credits: Junio C Hamano). The reasoning behind this
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
  git-compat-util: add strtol_i_updated()
  patch-id: replace `atoi()` with `strtol_i_updated()`

 builtin/patch-id.c | 12 ++++++++++--
 git-compat-util.h  | 23 +++++++++++++++++++++++
 2 files changed, 33 insertions(+), 2 deletions(-)


base-commit: e02ecfcc534e2021aae29077a958dd11c3897e4c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1646%2Fmohit-marathe%2Fupdate-strtol_i-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1646/mohit-marathe/update-strtol_i-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1646

Range-diff vs v2:

 1:  60ea85a701a = 1:  60ea85a701a git-compat-util: add strtol_i_updated()
 2:  f3a03d68211 ! 2:  0e117198d01 patch-id: replace `atoi()` with `strtol_i_updated()`
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
      +		if (strtol_i_updated(q, 10, p_before, &endp) != 0)
      +			return 0;
       		n = strspn(q, digits);
     ++		if (endp != q + n)
     ++			return 0;
       	} else {
       		*p_before = 1;
     + 	}
      @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, int *p_after)
       	n = strspn(r, digits);
       	if (r[n] == ',') {
     @@ builtin/patch-id.c: static int scan_hunk_header(const char *p, int *p_before, in
      +		if (strtol_i_updated(r, 10, p_after, &endp) != 0)
      +			return 0;
       		n = strspn(r, digits);
     ++		if (endp != q + n)
     ++			return 0;
       	} else {
       		*p_after = 1;
     + 	}

-- 
gitgitgadget

Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC07A3D
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298226; cv=none; b=HExtE4rvpzJak27gCXK+K0sEs1vGX7izhj/IIza6PSbHW4qWbRDOiAXgN8DSBI3tmPy0ZS0IVRU6L852PzzONuSTNIULrbt/oZNUI3lrEL3Obn9T+EJa53ZHXpXoC5sSg9wtf8XJwugSmux8jTSjNjoudJ/zOfmnjlhL6p0y+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298226; c=relaxed/simple;
	bh=x7Sc141XVjVpGWs41DFzLVTvQ1HVbEEQIkErQqDHMaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAIqJsIw/C64DcT+50Wy2EPSatf93OXOrhvkQhYaqW3U6nzMsB+xxdxCeVIEaZmKxsoMl9i8NEeaCs2kt4tEjR/9ZSEXQtsOuMDEQM3B2I4QC+tOpr2xmrXWL+ElMU2FIuYZVfA9w0/i08qj83AWXwJ/f3eoItdQzPpiorEgEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRERTmYy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRERTmYy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d911c2103aso5192225ad.0
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 05:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709298223; x=1709903023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYuhyn17dLpT2x3eggw7x6MvJLqUNwKj+4A6b1LLwFE=;
        b=dRERTmYytRCdFRJ9m/ZbInDUKdEKq//Jy1V1Ax1P3oFC0GumfRtbjN5tJFhPkHD+Uv
         U71VXUckrroylZcwzXwmQXwDm5dMxA9/RPLfLqr3oJKmOEJHl0eovm/f9Xm7Y5iHYPpJ
         U07tOlC9NIbJ7/oRAXFQVXbMjk4VHX3aIY2hAvdI5T5Cn0NnyJlvKKxrzeHVJnxVMr4Q
         jrgOXyHiAwx40si3jPcaW+j3TS38V0YgGPSn3ErP0yQ24hgf1qGa3Hio4vLyRrKenVGI
         kWeqoe5rM99Iv0M1Vl+fk7cdKTAWnMGHr9mRzqG3dpBbr6c69EagKMDM0pwazxF5xgdC
         xDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298223; x=1709903023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYuhyn17dLpT2x3eggw7x6MvJLqUNwKj+4A6b1LLwFE=;
        b=nlQG27nuWX/af0IkGPKjz1kFZPtd4NvkpAsKLtae5GwZ/iIgTfEpjDaT8jDWIHOWvI
         jozkWGMIjDjBqrVPmRWE3RkmcX3Xhnbbp2LiNTCY8Xw8a0aGrbm+G5sx5EwkxiSvi6+I
         0E8GrPnRajqCrwI7cL3z+Pz4xlch7qamnzGX6/82+yMOvQ//P+1zN98awpx2O20QoKzq
         /niZJ/+0ioqhm4xd3DSBkD5AyUYDSpcuR2HeJOX80Af8wDrz+IGp0wSJjTLA81XUCOQ9
         afMBsFBaYYxOEn08XJfCK8ZZtNM3s0VUcx32pxnp/l2gVFzNj34s3AbuuDeqMEMEYm4A
         +HBg==
X-Gm-Message-State: AOJu0Yw9eFUzb6JXa0OXR0CWq1+zmK1XtNZbC3ZJ7eUXFKHqAUazlsR3
	VydDIOyqNuZ9evtGjMO+I4VGPoohoUahb3raeyJaX8QRXTHS/zDYK0KgQ8VrA8CtvQ==
X-Google-Smtp-Source: AGHT+IFFZ/iK1P58vgs5VMtVICkLjBMiu9KFlBDGgts+Wsz4xIrVlKzIOc/aYQeGE86JAevigtJQsQ==
X-Received: by 2002:a17:902:8d8b:b0:1dc:de65:623b with SMTP id v11-20020a1709028d8b00b001dcde65623bmr1300504plo.60.1709298223425;
        Fri, 01 Mar 2024 05:03:43 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001dcc7f470a0sm3384254plf.96.2024.03.01.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:03:42 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 0/1] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 21:03:33 +0800
Message-ID: <20240301130334.135773-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301034606.69673-1-shejialuo@gmail.com>
References: <20240301034606.69673-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in v2, it is improper to use ! test_path_is_dir to replace
the test ! -f. This patch reverts the code.

shejialuo (1):
  t9117: prefer test_path_* helper functions

 t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.44.0


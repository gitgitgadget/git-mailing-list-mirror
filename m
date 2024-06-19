Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD115A847
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834292; cv=none; b=cIxR9fyzNc4uLWLIPinRz474c1zTwHcl9rvbPupgP9XfQN1EbFuyUQuxjwPEYVRY8lbS6TRl5FdC5d1aXp5+TBxr3ZjmysrOC1TZCznff++3mw2YEZOuIVIKXaAQJEgdaD0EWy6JjadywufPhCZGexep0QK+qlP0WjY9/Ri0TU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834292; c=relaxed/simple;
	bh=fBat4Yp3gYivyKXamk3+/10ToBE4v9Q8CQR4fkIkCNw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZghlhrwdVJLggpm5qtDTeSzrFbSHzda2MGuiUVXzMUFDehAjkzZ7zPHYyVPALnma2rxbc/yqGs7PO/twxgUX8zKs5XvWfQL+1/bfpafdi8q3bt+PeKr4TvmllKP9OMxQ560jb682O2+CKiqzLMZ2BAbg0LTkgdOb7xZ/nXSy2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIQvj51K; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIQvj51K"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so903762f8f.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834289; x=1719439089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6phZVwBXrsTJRIGQvTlUYZADysZjBXsqztO7asPnDE=;
        b=KIQvj51KohIIVa5EGjrwZsh5v6mHrFdGPD0sYZU7L9q3QZQc05wbONWLmdXKquiO4j
         Wtr/HVQwhvceyTcE4Fh+liyxmdqR1++ojj/xmCBfLCZ32JUjVVy5hNtaAdymDTWpVHxZ
         nj027v+/EgKHICLk+iG+w1l0fKPe4wSPuVXiLK8EYKzWyIMy6lLYydxm/nuG1uhZOo6L
         6HZ9apPI2UuRdrLOXBt8J6Rehc6zjgpltHl5ijEnZoNIuY+9SrhWobMud15R6ushZSrv
         MRN1jAWxCEWJN4rCGwVEemWyqfJt3PsX02LkNoA2i0j+HyNhadR+qVMYqi7n4ENsCl2z
         PQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834289; x=1719439089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6phZVwBXrsTJRIGQvTlUYZADysZjBXsqztO7asPnDE=;
        b=eEJ3hR8WATXR8rRAMGItftGjLXDXxdbjPimg3HweYmRnemS4gWeYcPTMYUzTA/ogvE
         P6tLUnEvmFIKpY8WfgjSqggnB8P2GaSLB2ppqOm1UeOM/PMT8vZTAOIp4xQTkNSuy309
         OcmC2DVlTN47CnaqL7Wc9L0TLJ2FHScrBB5RdwbM5P/cmfhcqN4GKtZ99GC3JmaSAFFv
         0MX1zPVFQtiRQq3CjT3ih1FN8JLF1BP2LbOJ7XBXkfJ+UqtfUNpgztOibdERBKBM2wdI
         meJtvIypo1HnWtxeLE71+uxmoMgVSw4N666JRRmfNJhmMnNve8OVD15IMzXh0lvqQFbX
         qtLQ==
X-Gm-Message-State: AOJu0Yx0660uSw+mbP+BKdx9d/eZASznLhrFke46WMT1FaFD5yp2FakK
	a2gUa631nFBY1TySPTCrUWN7VSjejyNdWJrrP6QGe9kdBpM+XWP8zxTIWw==
X-Google-Smtp-Source: AGHT+IEIIUYh96ZapVyiOF6LxY2sMsN2Oe8Y46MrBedBAMLC24M3H1etPeXBNXtD5rfbG9hMiInrlQ==
X-Received: by 2002:a5d:45c7:0:b0:364:75ab:b06d with SMTP id ffacd0b85a97d-36475abb21amr707336f8f.27.1718834288961;
        Wed, 19 Jun 2024 14:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607a43eedfsm16476699f8f.78.2024.06.19.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:08 -0700 (PDT)
Message-Id: <074dc98acc79e08d07cf4f5c8105b872ec57980c.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:49 +0000
Subject: [PATCH v2 01/17] mktree: use OPT_BOOL
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Replace 'OPT_SET_INT' with 'OPT_BOOL' for the options '--missing' and
'--batch'. The use of 'OPT_SET_INT' in these options is identical to
'OPT_BOOL', but 'OPT_BOOL' provides slightly simpler syntax.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 9a22d4e2773..8b19d440747 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -162,8 +162,8 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	const struct option option[] = {
 		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
-		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
-		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
+		OPT_BOOL(0, "missing", &allow_missing, N_("allow missing objects")),
+		OPT_BOOL(0, "batch", &is_batch_mode, N_("allow creation of more than one tree")),
 		OPT_END()
 	};
 
-- 
gitgitgadget


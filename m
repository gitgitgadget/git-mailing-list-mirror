Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29781A2545
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557632; cv=none; b=I/BlK78gFcbjWsKmyY5ANPRiDFtQ6MRqy2qA6UdAToaqKjyhaNQPQ5+7U68iL6VYB25D1nnyIxBAJloYw4NFBxoxxRMgMVUppA5z2q5iWaf8/XZUoIk92uCk+IcFvJytp19y+kkdjcFNmdR0vyPxIs6L3uKC81qBTQG7SXvmhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557632; c=relaxed/simple;
	bh=tBoLLx32zd4yb1VZzwcsaClrMLZzV7Wdur69IhBLnyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpjgELhW4Q0hy8WWhtt9Ioiz8+27GPSpKLAcPmRLnO10J5V/LO1wVSsPyD5frP898+NFvhHAIlhfB/8Vne0Rwdj2qqmqPswoiOeMzbHMCfgPtBVvWUgSwXeIzk1/s+pXoljXprbPuv4T4xefEoYl+mkar1O/tBeos3sUMHj4qCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYcavtD7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYcavtD7"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59e499a40easo1368453e87.2
        for <git@vger.kernel.org>; Sun, 08 Feb 2026 05:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770557630; x=1771162430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBoLLx32zd4yb1VZzwcsaClrMLZzV7Wdur69IhBLnyc=;
        b=ZYcavtD7VtPb8EbuHsq/Zuk0RABzjgAbHMcGa+0LMwZ2HjqvuTWxFmjctSi/af4GfM
         Z2L+sjOOWpz6ef3bulGcb3CkWKNTqj2uFHRYGmyhGL4skeJt0MHJ4P/foi/1+YDMuewC
         bqUBWOJZwGrEybpRIv0DhjfHoMiy12xFqkSUH2TDkChUafmCEy0bfuWDfAx9bPdebcv8
         pFGSlazW8GneoIzIRpEd2WdUDtX1Rwe2warIqvyjViOSBYCXRe+QusAqS+0laj94Sh2t
         TjQ3iog5FSRkKFmb9LkLx6BpoyCz5ElXMbAS8BltVsPuVIXBJFw/+eLeWVte5OpVoTgt
         elaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770557630; x=1771162430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tBoLLx32zd4yb1VZzwcsaClrMLZzV7Wdur69IhBLnyc=;
        b=ahUNyrg3hwedEZSsNiOXVccCGj6pwzPSI1coh8H5DW0YDEIN5PcRHBjydw2oSNa9Zj
         cK5AjxdcKlNCeY8E/+p6rHLV8rkQ4baz3O6ol8bckxFZI+tkDxIfDZ1y4iH4thmsZMuY
         60KX12ii8FfA95fz0tbi+OEyvTOHjWGHBgvPpLcDZC1N9rIYTqki94jl8swPu8QVzBYO
         wzYwYXHuHGgGR8FGeQDo92Amg8yMTR2e7zmXr/k/LZZP/muKfGgwZudlsdAIowxxKMqL
         E3OStQJIjkUp76P1MuEJFs1O9jSY8uwn3uXPBXxLUjFXRlYe3hGuCJIk3D+W42UuKHWU
         3w7g==
X-Gm-Message-State: AOJu0Yw87bWobuuEmDlwaKOfx38MxTCzO3az88amF1MGxyBCHtoRfkKG
	OsquE4CRe60O5FhF9AwJrUOaMzLPsSyN6HSaYkBmtR/pjW7A8b2Iug42
X-Gm-Gg: AZuq6aL0YhbphG9qolBdmwJWcuM/DXKnK+9xtvri3Z3gZqO9ADzQLszN6fOuGpwcte1
	qxlnkxJPtfEg1LsY2Bu7x93U26yyVZYcMFqqyLL6KsXtF0SxeShiX0eggqU3Hx7wCgPLiNPwiYw
	e9ABCB2GizdimvZ06oetRFVachmIUJPqvc//sPm3FVvXwf8OAnEL/QiTHmSu5DM7nCdFpzoUx5g
	u5zt1LvVR8V7sFQpn0v5YYTnUwSH1GQSi3ViTPDMzQ0grq7EdkNPpbtLStxDYLmzRsgD18ZvTQg
	tipZ942Nix42YoW+uWJhK24dYatlYwN2B4ZCN6ebBd5Tew3WwzW2EPJxWElmHUwenqp61YqDM+K
	xpPzzBmKXFs68EjRElneMrZ9LCvg9ktLqRfg7RG0LFNdBQUDfz3kpKQkXytDjCMes4UxYtZjmAl
	X4GiGQwjUVkQf7d/XLJLoulcpZCwQ0qyThdD4qAkJVrhtScHmcXSciSe993Efd/R8KqOQBCQ0=
X-Received: by 2002:a05:6512:3c86:b0:59e:38c7:b377 with SMTP id 2adb3069b0e04-59e451469b1mr2428479e87.20.1770557629790;
        Sun, 08 Feb 2026 05:33:49 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cf6ff5sm1942573e87.20.2026.02.08.05.33.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Feb 2026 05:33:49 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for multiple branch comparisons
Date: Sun,  8 Feb 2026 14:33:48 +0100
Message-ID: <20260208133348.91370-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122230656.GA2125611@coredump.intra.peff.net>
References: <20260122230656.GA2125611@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jeff!

Do you think this is ready to be merged? I think you are the holdout here 🤗


Harald

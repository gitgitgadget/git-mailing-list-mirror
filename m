Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D163A6B94
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149342; cv=none; b=GvR7uU5viU4QBQ/DZjDJcmCiY9/lGgusqNR4Q5YER1OSekA9wJe20glYWcfUiEzIcvMlKCz53aNlPOyaMBXHRWUJbQtNXIpy8uQvBLMwW9I4h/KPce87Xz1AfCjh8BRCfrSL2Nbi6o4nHVKDQqihHFEdMi/XRh+qooVYpv6oXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149342; c=relaxed/simple;
	bh=mZ+p5i6DkRvEuwOGcDLNRh2sVmBWaE+fePZLSyudKa4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OyEFdkgjYfe03opIZPb+srb3vgVoP42APwcpzJwmqRAn02BYpR6SsmNWGNoBP7gJUH+qFaqKGiDsA0XBpblqONHigc7NgkRDXwGFciWNA8Im/E8JfELF18Tcc3MUoRf2e8O5kpy6NHN7m0g1y4+TNoHIf/bi1dd2P8jgpVKipPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ds3zSCbe; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ds3zSCbe"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2be06c02f66so52889eec.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773149340; x=1773754140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOVTjIk7rkX3il//wwXhzyJ6mK8Un7DWQHuTVTKlJqk=;
        b=ds3zSCbeA5G0oz9JYhvisdjbVJlPwA95zTq/bncjGFz2K/v1vz4zdioWqLcGGZDB7e
         HmiryUfnIsj15mDFdhHwc2L3F9G4MXD9H0mClnX7q4q4KI2HKNAODm3vzTuey5nHz2dc
         OHxf0ztbvDMdvrbU2ydvjHJszt2aWY8ugKLpOoMpdAgiZq22msIoVEjq3zYKfP09RY6v
         PVrsstbckft/X2J9HdxkqqeuNeMH2hqKXPu9+RD9Ce1FRLfwE3WfwyrBb7fhuhMzJ+ZK
         7wT0saH1vAU0IgYm+CNS3VvUrR6obWqOLf2K/4ehT5YdnkjHoRJoD7NqFzoPLkm3F/Ru
         L7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149340; x=1773754140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oOVTjIk7rkX3il//wwXhzyJ6mK8Un7DWQHuTVTKlJqk=;
        b=PmPoiCl+CcGTZE5RbMO3Lv17/ic5d/KytlCuTmtPqy0QS36HGGbgRuvmT6LjeEFjow
         b+r1DLiRqNIOIUYDn6Mfwi918ErSFMdzY/HzDbPwKaxy9FPZEYPJsuKJJBuV7x4ukeaG
         zWm2dyDLBdHT6eA7V0jDJDgIm+PcZLgaubA/y8jq8r1KCmbFqxVd00ojtFfeAWUZuZS8
         2X3yn3i4euKRewCDaAuQaUA/glYcpZiOfbce9syB8grhiBQBzdZ/XTZzpG4Mws19T82w
         0QnnpNjwXg1o2Y1yvwx4+LIK5i1DnGwU4of7MBTgyMZKlme4QqfkzN9lx4C8u/RQj6PC
         KPfQ==
X-Gm-Message-State: AOJu0Yy1HjWsNDPs5StIuA6jPWXO1r1t3rPFLRaQpn283fmm6iixH73R
	yfBhD1YNB3mvvG60482I7yusVdkbVIIw3rZJYICjoLiZLsiqSkNRTvidqqbw4w==
X-Gm-Gg: ATEYQzyUHVZfG/R7vh4iVFrLI8oQ2+C0Uq2iX4wC6WVBtaxvFxZVEpeMCyq/MTKEvaY
	zrLEhU/A2Un0URlYzruoI3thV0Vcb4G/3JTI1IUCHJ5fQqmUZObw6x4UPejbFwjR2pKw3Lfyk7W
	W6aKNrNOEZOtxp1RtIGSFzxJ9n/MRaGNnkqm0ZLpANLo+G1FPU6WIhINqVpgQnphX0R/fgkl/op
	dvTQlFSAch2gh0SLhdCsIPk/SqWM7GpjgDtRpXOEHD1Le4FOVNsJeEqvIzJxVfqahH965upVN3X
	ytvkeGI6a+NKQIJ/fceeJvjuvVLBLarO+R2fxfEohcEYLK5btKn4unzoQpNbuw37nQQGyF5boA5
	VBsmZXmnV4pE7GDRwWbt7udUIDBBToRJIXHgMiXO55FZgh1/mkiEeX6yPJ8DcTxFq/wQORjRPy9
	IKUSBabl7cApecGt/wJpmV0W3q5Y4=
X-Received: by 2002:a05:693c:60d0:b0:2be:6f30:f317 with SMTP id 5a478bee46e88-2be6f30fd5dmr2060907eec.34.1773149339414;
        Tue, 10 Mar 2026 06:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be6df8a348sm7317691eec.30.2026.03.10.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:28:58 -0700 (PDT)
Message-Id: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
References: <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 13:28:55 +0000
Subject: [PATCH v3 0/2] Advice on checkout dirty files
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

This is my submission for microproject [GSOC]

This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
when they attempt to switch branches with local modifications that would be
overwritten by the operation.

The new advice follows the same patterns established by existing advice
functions such as advise_on_updating_sparse_paths(). When triggered, it
lists the affected files and suggests using git stash push/pop to save and
restore local changes.

The advice can be silenced with:

git config set advice.stashBeforeCheckout false

Changes:

> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> "stashBeforeCheckout" to advice_setting[] and implement
> advise_on_checkout_dirty_files() function
> Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Arsh Srivastava (2):
  advice: add stashBeforeCheckout advice for dirty branch switches
  advice: add stashBeforeCheckout advice for dirty branch switches
    [GSOC]

 Documentation/config/advice.adoc |  5 +++++
 advice.c                         | 20 ++++++++++++++++++++
 advice.h                         |  2 ++
 3 files changed, 27 insertions(+)


base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v3
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v2:

 1:  eb5639dbc3 = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches
 -:  ---------- > 2:  e88c851701 advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]

-- 
gitgitgadget

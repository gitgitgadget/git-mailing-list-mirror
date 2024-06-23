Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEB14A90
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719124070; cv=none; b=izKJZB/HGZKy1F4SVQqWWwVGT00xggOWrAo2GaIBLyHwwoCkvx0cO+J8K1V2rrRZ2FJS+7Mdg+nLQ9fHnHO8AMAy8jYD2LMERpS54dN9pe4gKwaqwrsCNGa0jVM7+CcEpxmXUNGXDn8hfRM/e+d4cU2gigjgvF86AdzjftA8H2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719124070; c=relaxed/simple;
	bh=gOE7uB8uz5+ux+hukUoujKJ7mmpsez80citvij4Eu38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+SVy4vyg+dDq0Vk/dvRZtOLTKd6rMEl1PgTfJep48s2B086XpZ3OR0td17q7Z8Y5ZAlLs4D3X9sanFsmduvQkl/LG/dvjIk4J+/OaZXqI1lsFkcUAo7GS1++Fa8SAasxnHUMYZwI3e99/Nr68Fgr8yVCfnIM4o5yIk42id7yTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsW59SPc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsW59SPc"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so45124701fa.2
        for <git@vger.kernel.org>; Sat, 22 Jun 2024 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719124067; x=1719728867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gOE7uB8uz5+ux+hukUoujKJ7mmpsez80citvij4Eu38=;
        b=KsW59SPc8ampNpOX/syknJWja5lRJQsofBKnEmDKNch3BAktfmn27rIbvvDlIyhOf6
         rlZkei02iEoHyfBziWJIM2QfBwwNa2gGGeGAEz8MxNiCkflMpnXYeDxPrvyBWua7KUgR
         FGJUpZV8XKHGR94lT2/g9gQEVeJpDacgGBLBPOS+4xmdpC+yfr8rlSbrULNfA/JhyBnA
         DioLL3RiJwTo4+3SfMM8KN/fBkDmjMGFmAOrG6ENzdlbSN83yFU19ZKxW/kqk6Nzwf3P
         2IEGQj1efj+3+w0oMe4HmRT4SY7xPjxM8Dpc8u5rUhxEhDEcfs97MSXFN+gW1tHQaJo/
         T5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719124067; x=1719728867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOE7uB8uz5+ux+hukUoujKJ7mmpsez80citvij4Eu38=;
        b=CxyYezK1nDhjdHfV40MYTPZAlUQf3LMQKwHlryndWaSN/FROrOmk29RSryHteaFs5L
         8bco11SWLJ4aMutiIfoqCLDdLgQ2dO3ZgxahV49+gbVpFtFJ/ONw0CUJKhr6GYLtz5J9
         siGbRhY3JKJr0bvOCarXdAVI5j/rCwutUa92IUIrkqA4VUevMR/db0Wc5Bk4tYy1DBDE
         jiwoqVJPRtD/FORrSi14aItD5VVueuAGf6LS1xx6k2fYB+KHk78v8QWncfEq0oeVyXNF
         XjVyfILZY6uXOgdUl7Zrwe9+FmKBccq5LY81oA2US9RfAGDLXr8jJD0/fGnuFYv7S3Uz
         9O4A==
X-Gm-Message-State: AOJu0YyTvi58Mu6DZeX10OIbXZxgq8BgU9Op9MG3Z6oE9AgDfdSelX5X
	XkJKj0+vewoKEmAXMB4F7ec8kDH7D8Owmn20kt4R/FL5eOqmd/rHL7Wn8+9gFvF6NZBV857hzqm
	GpQjQyUE3KMf2ErnPHqfAByApc/Y6SLKDYbcRlg==
X-Google-Smtp-Source: AGHT+IHgsy70sQ8knmaq+n/5Pa+MaEvw7BLjNpsdwnpy+6IXQXDTaTdqkPCebNiig0fCKSkR/OGhqNUx0nouYI04M9w=
X-Received: by 2002:a2e:87d6:0:b0:2ec:5b10:6860 with SMTP id
 38308e7fff4ca-2ec5b2d6509mr11125381fa.22.1719124066243; Sat, 22 Jun 2024
 23:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com> <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
In-Reply-To: <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 23 Jun 2024 11:57:34 +0530
Message-ID: <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the fourth week of GSoC's
official Coding period:
https://chand-ra.github.io/2024/06/23/Coding-Period-Week-4.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/

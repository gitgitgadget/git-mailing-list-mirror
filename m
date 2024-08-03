Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA51E895
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694876; cv=none; b=CZHiE6oGSC5L3yQr1dbOcBmeqP+jOJTs5CdIDqCWTYcoJC+VohbVflclxTB4ENxku7UlPKkFnwRzKh25qa1AquRKCmZHwuwvMaFZDyZdq0q5sQrgeQEXYQ2BxpGy2KVE1cZTmFLxhSFaf/VfX1j/YG5FO0h01+cSsGJHG8fJZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694876; c=relaxed/simple;
	bh=I+Q9nfF8gKxKAKeWG0a03NcIH2iDfbQtcy1ggOO78LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0JVbmatcLy5CNXo869QktuHoaRfY2dAmz+iF+CZNpjsG99tdzdTS2g7avOm/PlccWmKa2edK8pfAJqiYzCwCRpK6Nx6PW6sAT/41/BqMq5SzBeIRbG9/v24Nv9hPycRnD96pVG5Zs8AhmCLsXLG0MK/zmRllh/C1F/IxThGXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGYgBLRD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGYgBLRD"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58f9874aeb4so11344059a12.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2024 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722694872; x=1723299672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+Q9nfF8gKxKAKeWG0a03NcIH2iDfbQtcy1ggOO78LQ=;
        b=XGYgBLRDOMsnyMHVFsTkJE0+z94G9cpn8WCASUqTAH8REa31It/1EaupRhbDTPLP4r
         5PaKmagNgof0AlDpCGPvs7dSBM0PUW6uzJ+WOnHD4JkYAfCHbNjMyCSBrqwpwFckoVvo
         ZFQiKgJJ6wjMGwUQUJCTPmPYnlt8B6qfjoTNLrCfur6obbB7Rw4pTt28vc1cePtyls6q
         jzW/UMH+s75QanYa93OyeugnotCh3y2gGwMMpmiNlri39jvqQy5gaRAzgFiNEN4gF56h
         ae4hztys2x2dCK9u5vpI5U2vN82fCYTlLiQSXIyUOU8+E1a0ThVLnacb2g05wVyAMntw
         e+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722694872; x=1723299672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+Q9nfF8gKxKAKeWG0a03NcIH2iDfbQtcy1ggOO78LQ=;
        b=kYHQZlmUOD3CKQj6jVmp0dlutXSGJURgr6TXHfxmyEi/cNAsnOTAczIJlRklRvlKYY
         xtC+ZeTuXzslwrddBsWbcm2TOcQ96c0D2fv2T5z9AHGpDtxZ9sMonM4Twcy5YHeGVpnN
         EZxzBmh6CN+AinD4SbjKPkzCS1cD0eU44KlueE44RcRq+IBVBRJDI0M+tq0sBP9Vl/eb
         7hh0JMwg6CLbH74Uuo/YASrMVIlkPIU5N8+Qq5fR7p2gq1iVo+xdrj+6UePNUB9ZP3wh
         Ix0Bb6hFZX1JocaZUk3X+9/yxq6yUFOrBlZXk36hg60kH1zTor3Sz9In+nQVA6q2mZow
         fGqg==
X-Gm-Message-State: AOJu0YxVG0mim7ac1Y+DRiubNHTgRDpZoqY37PtM541zIt97pJzRrVqh
	ex0BiH1m+xxhUT8MdHQmOAe7kcJEs5ds1BOqCSEyEtKJ/UNXokXQ38rexx7EXWIsCd6EQWiEqDb
	D2uDWJE4+ExMJ8lQZVTcNN+4rRXKMht2piUJxTg==
X-Google-Smtp-Source: AGHT+IHtZu5vsvueAtSBtk9ETYHSyY1vJcRC03DnfzjYmk0TT6MHotTy7hI7NugsTGxY8f67QQ6dHlZ8o5SYvSO89q4=
X-Received: by 2002:a05:6402:1a42:b0:5a1:21df:752d with SMTP id
 4fb4d7f45d1cf-5b7f3adaf75mr4930403a12.10.1722694872014; Sat, 03 Aug 2024
 07:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+J6zkRxnvnybM3vnPXX2YwpW1k-as03+A8kxiJoA8GrA4FSMg@mail.gmail.com>
 <CA+J6zkQaV9o7eUaD2bshH7zEmF115BbYv_uCFctySQNMgGQc+g@mail.gmail.com>
 <CA+J6zkRzM33MbMr4-U56M1SFLykx029+SzEeo8vBicBd9Xs8RQ@mail.gmail.com>
 <CA+J6zkSFCUYLRTRE0Gwug4-fF9f9-YbfRz_atArmMLLCtQDr1g@mail.gmail.com>
 <CA+J6zkSxcogPXdAdr7VL0B3MnQxQNYwOT5Kw2iK_YfPLW7CMcg@mail.gmail.com>
 <CA+J6zkTyVDJcOoZC-thRAOYNudVWB1wgye0Ezj3o1AO_5HOS6A@mail.gmail.com>
 <CA+J6zkQ7W=3+aqAHwzXzVM4-mZ9XpCkAfmP-GZ7T4i+i2Gi9aQ@mail.gmail.com> <CA+J6zkRxpnQ0E-KK8-rRDfDJar=9TwmG18ZkiA+zcxaavwPoqA@mail.gmail.com>
In-Reply-To: <CA+J6zkRxpnQ0E-KK8-rRDfDJar=9TwmG18ZkiA+zcxaavwPoqA@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sat, 3 Aug 2024 19:51:00 +0530
Message-ID: <CA+J6zkTQQoWq6MSuYArwOx7iVT0qFhFd+QOP0vvO1NVczcvEJw@mail.gmail.com>
Subject: Re: [GSoC] Blog: move and improve reftable tests in the unit testing framework
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Hello everyone, here is my blog post for the ninth and tenth week
of GSoC's official Coding period:
https://chand-ra.github.io/2024/08/03/Coding-Period-Week-9-and-10.html
Please let me know if you have any sort of feedback.
Posts for the rest of the weeks can be found here: https://chand-ra.github.io/

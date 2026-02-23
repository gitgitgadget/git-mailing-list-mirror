Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE34374759
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876764; cv=none; b=ZFQJe41g5JTaWggx96ky4BLDEWFNd9csp/VeE5FXz2dc0JCPcpfi20OZlNguECWbi4QREJfnYG72mzcXN8BLei4l8dkSDD1U5cKCiyn9vL73PIFG52rXE4hJzqJXF7sAZQYHjyhu9ZleHJM/xFSaWwXC1uK034Q0JfxVPRltjVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876764; c=relaxed/simple;
	bh=N7psWbasrCPgrB+b1nhnYEnBR/AapKRBBp539pLK9jE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNWcUn8kdeWrKwd3LRDVV0oabuQXRGPuYhh9JpkaMou7HcOdFmpQLB26UWNW62PwLLbRDy84/8WoANdz4QeamIbubyG20vUjGl56GY3TAwWlDd5wXLI4wo7uHjwm31aGicHEQX3NJZ2ndyhU80erKCAD6Hk5jVCrRlgHg4hTbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZxKblpK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZxKblpK"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-823210d1d8eso2638274b3a.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771876762; x=1772481562; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R76PsHsXZSh8cET6GZw6QMSAJQbfvJAm379UtCjIHnE=;
        b=TZxKblpKCTxv/Vyx5zpIJ0nwz3BF/UarnyKMU/WzDR8izCT6l0PGD8DVO6vMo1qhPr
         BRLso4g7FQwXCXDqPDVugKypwY+6fYTMizue2TuPP8iq6TVuP7k5hhnCvmF1MGtSeVTl
         qqcUVRkHoAOh32q/iRLqozS4VAhL/8n4LuRVscolrymdnGvqAhuy4/aeQUUX/W1lk+x0
         cG6++fvCpw6F41w6rzZkgwIfCQdx0S9Wez+o6vuMI+I7gEvMuUtsz0nFujRANd6WVJJy
         SqyMWfgr32OZCByULok9BHC0VfbpZ+DiBcFeSxyczRIklzZvAaPYvoke+0qd/DsupG0w
         Ebuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771876762; x=1772481562;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R76PsHsXZSh8cET6GZw6QMSAJQbfvJAm379UtCjIHnE=;
        b=GG9i/PRGZo9UyvdlD6r3ALYR+VnOyqkhOwKRBpFLZ4omuXV4R6ybOTSk04UmjHVL/E
         doh+SG+akOSOJUQXPCGqKlOLr9a/77p5IRi3K8GH5mSOZ0Vn760AEUwMcf1d6SClBfAx
         GPDg/TFHYqCUPzqGMUiMZ+y4HTC7/jWl86WEuNlZyQbdSW46SDGoUFqh28f1wxgo+/V+
         9/PPfFcmv8BCexjf1ZNbKYcmq8cshpM9leszkCG0iFqjV77Dzmtwgl5vuHu4NgvZs/pj
         tCqQ67Nyh2vilf/pfKFVhAWzRXtBVKJXZSdG3KEezfUnidAom/6L8tfniipxaeUGhpBz
         dFdA==
X-Forwarded-Encrypted: i=1; AJvYcCXX8O6Js6qBnYFHmU4HTrPt3Ak4Up2VAmy3koJY3qVahI3ExTvY/USwJfjEZaRbQHRjqKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwcgMtPpfrLOG8i9Y0s8arwUbLKVJHQfamkRBxek1c5UypuK5
	SiEc302/9bys4Nont7IUsoWe4FRnJqtKhnWoOhd8sBYZ6QLtghLEq0Md
X-Gm-Gg: AZuq6aJAmywuUHTzwe/G/FN99G1/UL6BcVslEVY8TCKLd7HOCPoOcZ2+0f37aERk3Su
	jkzW+ESezF6zbTkglSMy9Z/H2x1zzD5MYXvEblyVaas14K6myJuX8cssQ+srfHTgN6ec1x52faZ
	pGdj0IOpoovxMwpiSeKghT0mvYo17Ft44nt58pUohLubIvIVTvkxR45L03QKHppC9WqUKFveeQi
	k+xz+SSPBo2wwmy8pewaWf31tcFDA1jljEhK5CuZS6Ahy8RNloLzg1OfTP6DYmHzhWpc5ndbHt4
	aAff9Q1RpI7RnD2ul8b54j86EFhL2wMT06smNIOVKhYstOVuYF0OMh1ujQqY471FREHe7WkM5CB
	WO7j5gjSy9gslhGCtMhxj/ujkI1S5goOQCuoohAjfSW/y1gOKWiiJLyFmsk3XmkUxNYAd0r57WP
	1mK3zXZYg3Huvgrg9UJwZB6eM5Vu9GrzqDkrcP6vSiC/7RWw0Ax2iPAwKoShNT
X-Received: by 2002:a05:6a20:914b:b0:33f:4e3d:afed with SMTP id adf61e73a8af0-39545f7d274mr8799588637.33.1771876762113;
        Mon, 23 Feb 2026 11:59:22 -0800 (PST)
Received: from localhost (60.33.125.34.bc.googleusercontent.com. [34.125.33.60])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-826dd8baa34sm9299863b3a.51.2026.02.23.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 11:59:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Engr Md Ferdous Alam <mdferdousalam1989@yahoo.com>
Cc: Md Ferdous Alam via GitGitGadget <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: fix error and warning message formatting
In-Reply-To: <410509689.1055311.1771872851838@mail.yahoo.com> (Engr Md Ferdous
	Alam's message of "Mon, 23 Feb 2026 18:54:11 +0000 (UTC)")
References: <pull.2052.git.1771836302101.gitgitgadget@gmail.com>
	<xmqqtsv7o3p1.fsf@gitster.g>
	<410509689.1055311.1771872851838@mail.yahoo.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 23 Feb 2026 11:59:20 -0800
Message-ID: <xmqqms0zmdt3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Engr Md Ferdous Alam <mdferdousalam1989@yahoo.com> writes:

> Given the risk of silently breaking error detection in projects like
> Gitea, Gogs, Gitaly, and IntelliJ, I am not sure whether it is
> worth proceeding with patch [1/2].
> ...
> How would you like to proceed?

It is prudent to treat any and all messages from plumbing commands
like cat-file as sleeping dogs and keep them undisturbed.  Even for
human end-user facing messages from Porcelain commands, we may want
to be careful, but if I recall correctly, the commands your recent
set of patches covered were all plumbing?

Thanks.

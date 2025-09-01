Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC26338F4A
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735088; cv=none; b=jIO7slgU0H20hMwTeMc22cifeX1QqCX8g2aaabCYIfGa7vtYojNcOhvX+3W9yIYJZbXtDBLjHyjDmSwlbp2sWoZJ0J6bzMBzwCqXBJhsAyMQ3LL0E77OAZhzBt6rfA/wCvMSKrDXvk0NGvNRWrLmv3Bkt4nWPTlBKvJ4nbOZsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735088; c=relaxed/simple;
	bh=0JcYcm9G7gPZqQph3yenuOSAOxBJbWE8gRRaPKxSmVw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=R4xPnXorkf3rNXZLLQuNWvwxtpM2ZwpK/0KSDcw3UHesxhwYicyrLAYYYAo+YK5EEkMWDSFh5kVFBVF9aiEvLTbYoDUMPE4eccfTO2Q+cqOFZJ47JcUpuMnRUuvt14PZQOkZI8devkwxTtjJCBgjVcBzmzWW4aXAV/VtFeNTahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzfzcSOu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzfzcSOu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7722c8d2694so2393872b3a.3
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735086; x=1757339886; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JcYcm9G7gPZqQph3yenuOSAOxBJbWE8gRRaPKxSmVw=;
        b=CzfzcSOuF3M5MDMCfhA2brnnGjoRVjixs48NklLO+WQMuHtnk3DnK3s8ZSn8HMF9Rj
         R0B/gPMfZxB9u5hDicYSz5SCdyS9vlYk6l3poF4tdoKZwZvoegBWwfM1jczMaSdkJzRJ
         N/TqWlvtqQ+0YSMPqzDB9Ju8lN+iketpaStqtl0FQy+Sh1531B8H5E3CsK1rbRQ+b2E/
         id4s9ZHywMfNm7JJvLFmkIo+HUp/QHSLrQ0+1mQ1Qqcz5c4wfXTj/121Bj+wqhy15OhW
         8C4mWLa3EDX61WE9m80jZzv/Wv3afEyzmOhjP6/g/IwMURFY8duRUWcvq1XoU9qv/u1n
         e7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735086; x=1757339886;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0JcYcm9G7gPZqQph3yenuOSAOxBJbWE8gRRaPKxSmVw=;
        b=uvPujnPqAxERujio6oJRb1Q4/7zTbx1UVBtxgE1yxdl1hVWoICF6CnNdQoKM5ovtBW
         0IEAMaZAAhfuGjd48gRxGEpcsBJ0tCTfb7pRQCD+612JsCsJn6e8Vl+8g1nXUs1zhKYi
         XGgYZpaAZB7fL52Yp703ap/NnySE0BR9CeLdHA4N4sedZw1PpoypP5kXrEx/jukPELb2
         tAaF+PljTpUZFV0JWzIChQkk83kvnjEqjyk0N+aKh5QSmKCqFK3BIcj0tQfgd6O/N7+C
         bHQxxSd67FcYkP0e9ES0vLrayONaF+uV8HZSyYPMUbq4B6/MiaOv7/xfmjM6YlxufGfy
         jt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsUSr6jtNHKEIoN74zX2V0RpfD6IroleaBUpHpZrgiShmeNHt/rXaK2ouDkIzzgH6JUDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdQyr4EP4HdhG3tURvn7e0eA6AT6dJCApy+L3d2cTEhyys84/
	1+D91wRxRD1Kjfuc7mrvRDGB7UZEfk9grgq3KKDfdnqCSTBG/32t0OmY
X-Gm-Gg: ASbGncsJOWzZUdcIx1KF7c0p8F4O6VYg8LYvxGxHxRNlXAhvg7KD7Vg3iKKq6KUpi4I
	hGUT1mH+QDEanU0t6vV/nP22IEfqv5rEhYUOk7UQ/lbj+rh06H0DNYPvz8wUKYAXBxituZH+KRY
	knoQ/6ehOcEBcIhMazS1ffkt92KJje25rHqx9o5O019bGdoAk5Tx2xKg5uVBJnjlCVYT1573iHy
	rQUhUEUeYXW8vOQjTT0TGFKhsRbLDSOr12XXD4x3UQ2ZV4hNBMcr3/JeYsPXgbQ8MRQVtCk/d12
	W6Yll4FR8V6IiUFZZpnyOkK5jO5mxzIyojQzCDwZ8mhogx4X8kvn43P02JzBI2bzLMRx40Av+DJ
	TLyriJIC7LHJVBrevu8sELC0jAzQ=
X-Google-Smtp-Source: AGHT+IHi7f0FfnWaqjqXOyXWRJ5/3z1JdwAFjT5qBY19Jsq1Oc+zViTuuhfu/XEmfRNhQrsOy85log==
X-Received: by 2002:a17:903:1211:b0:248:79d4:93c0 with SMTP id d9443c01a7336-24944b1fc84mr109262565ad.56.1756735086150;
        Mon, 01 Sep 2025 06:58:06 -0700 (PDT)
Received: from localhost ([182.75.25.162])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24906598808sm103670435ad.116.2025.09.01.06.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 13:58:07 +0000
Message-Id: <DCHIM5YWYM7F.1DO69EZ20ONH8@gmail.com>
Subject: Re: Was "Re: [RFC] Proposed Git Workflow for Permanent History,
 Explicit Branch Status, and Developer Continuity" now "Skybuck's GitFlow"
From: "Haridas Mahato" <haridasmahato12@gmail.com>
To: "Skybuck Flying" <skybuck2000@hotmail.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <DB7PR02MB4265BF28A39C7BD3DB097E1CB359A@DB7PR02MB4265.eurprd02.prod.outlook.com> <DB7PR02MB4265499C1103242CB482B407B359A@DB7PR02MB4265.eurprd02.prod.outlook.com> <DB7PR02MB4265CDBD131FB755B0799B2FB359A@DB7PR02MB4265.eurprd02.prod.outlook.com> <DB7PR02MB42655790BB6E1EF589B7D173B359A@DB7PR02MB4265.eurprd02.prod.outlook.com> <DB7PR02MB4265DDA928244F526CF1EF4AB359A@DB7PR02MB4265.eurprd02.prod.outlook.com> <DB7PR02MB4265527016FB04A500FBE321B35BA@DB7PR02MB4265.eurprd02.prod.outlook.com> <VI1PR02MB42713B3BBD5802512B5FC9FBB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com> <VI1PR02MB4271CE7B8F32225C98A2DCBEB33AA@VI1PR02MB4271.eurprd02.prod.outlook.com> <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB42710CA61134BF19214F855AB304A@VI1PR02MB4271.eurprd02.prod.outlook.com>

On Sun Aug 31, 2025 at 9:43 PM UTC, Skybuck Flying wrote:
> Little bug fix is possible:
>
> Copy & Paste the procedure GetNextContributionNumber from git-new-contrib=
ution.dpr to git-back-to.dpr to make git-base-to use a correctly incremente=
d contribution number.
>
> Bye for now,
> =C2=A0 Skybuck.

Hello i am new to this kind of mailing (and to os contribution).

If you want to change the procedure from one place to other can you
assign this to me (if its still incomplete) and also tell me where can i
access this entire code (besides in the thread) so that i can see the
live status (like somewhere in the github).


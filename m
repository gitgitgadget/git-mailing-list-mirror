Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17681A724C
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765312828; cv=none; b=N+Y4L07Bhi9L6SvqlngMxmUJEIHWpsr/OPiKRi7nJicVliU1tYr9vVmgfCY5O3hZHrBD6bpWOgwHgki8AcTdfWrIUfpPGOVJioCb34sSJTb2GWFDv974hJ6Z6LYJrCnCHSZH8Ap7eHuKTOgidPJfjJiwkFiCa96pvVH67QzUg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765312828; c=relaxed/simple;
	bh=fYYFenSFm1YFIn0vuXbdbTcJxzvlheyk/4nxu1rJWKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmhiqyaaW+cXqbnbXc5a+ygVVuiDQteKdEkUlruqDGI6v76vKj7waH68J4ODrhF9pIHHusO8JGnFlWejqrRUIOqIJBIWVoTUvPKdyjePS47EfBNr+7zn8jzWQMW80/WZNmPbj2qq1EAVUrJKjpkFHej8lxTZj2o2C0BvLR6nSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiVIi3Ad; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiVIi3Ad"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b91680f8so67828005e9.0
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 12:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765312825; x=1765917625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SzYVBmi+mCKt9u5hVAP7yIkHdfCFlbBFq/ch16jlgQA=;
        b=MiVIi3Ad8ZpBt5ePD7XApQBUKFMd0sbw5nNkVW70QvNIaIMdox8pJ6VSpoFUHo0Gfv
         CThvSTaLw1lQFQyNeUWA1emlSFhGN8Fs1YI8+SWMIfYCu6q7ypa0IcrOM1ef74sVBG9D
         RbpF9jkK3+IB8RnU4/HGlRjsTieZyU4h/1TNB2mZYFcZsRPsEJcJwTBVoheix3QbjXO7
         JQSuUN9siJd87BszlTvKURKBCELbakbE6YkEO1hlVCqqEZM27t6eoasOyWTU25NyWqdn
         a9+l9760C3m+zahyOCesgu1fBEGFZPc5p67lBRh9fNN4KKxMIFpMcgKSbF7SU/nJxqxn
         2cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765312825; x=1765917625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzYVBmi+mCKt9u5hVAP7yIkHdfCFlbBFq/ch16jlgQA=;
        b=OXyvkz3++B9oOurlcnue/gZY8a3gTR+LhwXsTKmbEU2XLS+PJ/i1TtBd71IArvFPla
         Jp1WdNUJyWCo5mcLHeOxdV5LfKnTItB19CiQ59p1oqWWNm6pRwOhTSONpNhCSfImd21A
         wV/Be1ARukc8LXc2bEd55+Gdy0j545D0ChIzwMhCfhkbIoWPV7nLDIFJ1Jf+gWCrLzUu
         CqBztXvd0KqoHohWQenQLFIl710ai3DRjm/MqmjouBzbMgp+o+g0kOlbJy9GpAhk/6kZ
         X75ZgPIEH4H+oRBqQK8BbK0XjYbBphlhUA7mL3YdvUBuEhXyRffNIqrXse08Uww3+k7e
         g5Dg==
X-Gm-Message-State: AOJu0YwD+iHhavGvkT0wawjJz+zj3a5fVccxQChHPlpX5xDIPMp62cLV
	3jtMHQHY5i1ozs5wscKi7scvavuvXKRGBHt65gPi6pGHZaYEzDmChYEjPPUzeYA5vkPt0RCtEkg
	/ztH3C0Ed/Fr3BHE3tTeJ3X4WzLe6ayE5Zqry
X-Gm-Gg: ASbGncsIvmyTF37VQWkpkjZ0S0vsrCGu0wjbHkr/wQuUyWcE/P5YMkvjMhGNP611cP4
	e16yXuJeCF4VG+swuC3iFr+nMVpukmo+Kw+HFHkKuDl7IUJOcZgxVla7kRRiFpLAe/v2+ir5A+y
	nlmQdWpR06wMKBke6iLF4qbQArv5bqvaXi25emEQAAOqJFCs1+BmBqIafg42A35sXPrxuv/83rs
	BRImgeja8soi1zZ48X2cTMNV681SfmfjbJB6wA9yW/2Ix7y4XyOBIFaKLtemsyZLyU5FvI=
X-Google-Smtp-Source: AGHT+IG9rue2HXXuIPxoLlTrisYpZFOOU77v1QBiuVsy6qBg1B9VS4Dtl2u2V6YgY0y3HZJS6gMBLicOqFgKEt4y1Og=
X-Received: by 2002:a05:600c:458e:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-47a8374de38mr1633285e9.7.1765312824709; Tue, 09 Dec 2025
 12:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de> <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
In-Reply-To: <16efc726-34be-44f5-aa92-4e82b663ab3d@web.de>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Tue, 9 Dec 2025 15:39:48 -0500
X-Gm-Features: AQt7F2pBZrTZhn9yq4JOfq4Re3mMvPbpZKZIsIMWXONT7J55S7FTaY2n0Y1DgU8
Message-ID: <CAHTeOx-LFJVtNXrY-RfVUcAA_SjvK2310_xQ3skUEgKKQ6w57Q@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: use iconv from Homebrew on macOS
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"

> +       ifeq ($(shell test -d /usr/local/opt/libiconv/ && echo y),y)
> +               ICONVDIR ?= /usr/local/opt/libiconv
> +       endif

One thing to keep in mind is that x86-64 Homebrew (which is the one
that uses the /usr/local/ location) can be installed via Rosetta 2 on
Apple Silicon Macs for testing (I use it myself). In that case you
wouldn't really want to use the /usr/local/opt/libiconv location. It
would be a somewhat niche case (the user has to be using Apple Silicon
Mac, and somehow has Rosetta Homebrew libiconv installed but not
native Homebrew libiconv), but could happen.

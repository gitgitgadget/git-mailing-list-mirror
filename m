Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF913B7AF
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728882285; cv=none; b=S5l8GEH4ANLXKiqZEMdZ6v1T/CSd6O1Z7NpcpaRYfkJ7MnTXpEeLIjpa8Aqtw1PTp8HNFNNk1f8RMwozDPT/Tasn51aMty76VhnQRD90A/v9TOuqfE5GfzsHuvG2M0Faa4r+eK3jdSV9KL+k2EI6VGkYi/Sgb/v86YDcB48PwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728882285; c=relaxed/simple;
	bh=1A72uIThMY9w8RTORYX1CH49uzD/+phG0r6WKdicrsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwCTiMhsu2ogOuYcdjw/PwhRDWjgrVn3jddfgSxbf82/nnOQ9OCmjzE3QCShs3BU89Rhy52w3MFLMA/Ge2eIrpNKYdSvGeAv6n+xdFdSEXqGDENHLgGGoEryaGUtw3GSSwygP18k3mTzzC8YQiuHuc9wfivmyEychi5wSXZbY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=3Ejv7Cn3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="3Ejv7Cn3"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2908e8d45eso3143368276.2
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728882282; x=1729487082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRRdIpVMQvVBrzJbUzwSmPy15CSfvtp4jlkNzreYtJE=;
        b=3Ejv7Cn3UpXxbxIUhMq++4XjWh3LMIGraJJ0NtjosaimKEz8GdqR7sRxWMae/07NqI
         jF3Qp9i/rN53at1YmWsCvkLhLVeFFDPQe5/l6iEEtniBIHgA8OP4rhGJD/ynLz0g60VK
         AgybTDlCR5LEUsxZkoVqsqL0g/vzrHaxZ7DeqR8d4Ld60izRBsrHhSWtcOuI2Of8XFDD
         S0ASa4g8Tm0VwrJ3OOyXFfCqm75ggbAWx7U31azOg3J1AQsl5D1H/2nq+o8cAIGVH6H6
         L7/bos0MfXerkm4tcuMYISmBKiN6mOMHO8xAEwv18T0fkmkruyFdCdasEZfgqc62rNZo
         vCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728882282; x=1729487082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRRdIpVMQvVBrzJbUzwSmPy15CSfvtp4jlkNzreYtJE=;
        b=r9CgJ3fwd3in0LzLCqSDPCQrjlgVC1KAlYm7dmbIS4HJ15WuRAVZzEZRf5xyfWo/up
         xfCPQv8bdMeozgmjpz1BGsh+Mj03vPF4j7KLlD1SNYzJpUP2SadGluaIN6k+9auUX+88
         N8lzCejIG3mDCa+PIstxoItS3GAksyBqJdbkMQaUtpa70J401qQ7RmYLKGCPjBhH5BB3
         uuiIimhbY9N4rtvqqFRH/a3WfeKhSUxIC2imnHzgIv+VIwI7vWRnkbWTvde22adKbJCr
         z5xzy/8MX1nTK8mJsiJ+ZpWYGp/E+AFE2x7X9yhkxGGPAChMRVUT+AFXlDKbK7IrAtN5
         xnGA==
X-Gm-Message-State: AOJu0YyIaQnq75E3NRoTPtBQE6LuDgZ0sEwji+bEqAHwkRV+LrBaIMFs
	2pqxnvoq92E85TudR6mdGJFZ7QNquFHiw9uuscmvLKMFqBQTEkMHQB8XScb1reactHF1o4PFyVr
	FaMfpgsJkEWycAWsGQNYSLyhDEYCqg4ntU+VVpUua+E2JAitrWTAA7OYhzyRUBsTA6oaeDM4J3m
	euIpLrKN5l4A2AU9FsDcBo19rVm5+JsevzFhWrYHjmAK/9H/pEMo1dITVbThPsjZt7fbYsV86XC
	r4OgccjrPdoZHE3vZKm/9DDenqN/13QHpY4EBZIob5VtJTFG/bTpPDcqtuAokIktqlGHyarF8O5
	n/2T0taxeC0=
X-Google-Smtp-Source: AGHT+IGeKu/3/KvknZrTpYXJGI+rME1sGIxQav8ciZa4VVGziiJ2FGStIM/aa7T83CEaYXndiXFf3FtTUj3kbkNCysg=
X-Received: by 2002:a05:690c:5085:b0:6e3:b8f:3637 with SMTP id
 00721157ae682-6e347c629edmr46066417b3.36.1728882282245; Sun, 13 Oct 2024
 22:04:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com>
In-Reply-To: <tencent_D0324DD61B7E04E0B4686FD8761E1CDDE108@qq.com>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 14 Oct 2024 14:04:31 +0900
Message-ID: <CAOTNsDw58poRNMpKiCOTouH84ah7+jvMfM0OPj-Y02Bo2O4kXg@mail.gmail.com>
Subject: Re: Bug Report
To: =?UTF-8?B?5ZC05YWD5a6I?= <wu.yuanshou@foxmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 12:46=E2=80=AFAM =E5=90=B4=E5=85=83=E5=AE=88 <wu.yu=
anshou@foxmail.com> wrote:
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Update the git version from 2.46.2 to 2.47.0 .
> Clone any repository from Github using ssh(HTTP is not affected).
>
> What did you expect to happen? (Expected behavior)
> Clone succeed.
>
> What happened instead? (Actual behavior)
> Git clone hang for a long time during clone(Maybe hang forever).
> &gt; git clone git@github.com:ibbles/LearningUnreal.git LearningUnreal2
> Cloning into 'LearningUnreal2'...
> remote: Enumerating objects: 3416, done.
> remote: Counting objects: 100% (360/360), done.
> remote: Compressing objects: 100% (261/261), done.
> Receiving objects:   2% (69/3416)

I was able to reproduce the issue. It seems to be related to runtime
changes. If we replace "C:/Program Files/Git/usr/bin/msys-2.0.dll" with
the file comes with
https://github.com/git-for-windows/git/releases/tag/v2.46.2.windows.1,
"git clone" succeeds.

Koji Nakamaru

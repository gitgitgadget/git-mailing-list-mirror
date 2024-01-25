Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6117CF13
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200648; cv=none; b=QsQPqHP/J0/ln3GT65YmN+VF9JRfI07WSEwSfvs5iro+MFeTtphn3IBL6lQeQJ5rHrWY4bslyXEi7wVvvufwdBdh212kAJdZ2bLqbr+Ki1xD8fURmik752UN/hRxJLLpz6vVPQu0et48RsNiJxzzBHi25Hou1Zl7prtpUa52EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200648; c=relaxed/simple;
	bh=Niu/wIyVzmt2CT8gSNjUXekhDhUZYwOT44Nt0Xrb8hs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gczeYwayeJlUy+4ZwCmvop0CVoOTMg49ycb5i4Cj214qKUaeCpzatLmhoxAExEM8NQz04Acr/1/AsgR1JrrdyhBFU90LVL0MlgCdUvXOzX32yrpUZWUdphYz524vBxuoyngruQFgXUtOfRxNHWlWEqJkfzlvB0EuJyrmvuNZM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEKgu75X; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEKgu75X"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-362a0b95874so4061915ab.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 08:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706200646; x=1706805446; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Niu/wIyVzmt2CT8gSNjUXekhDhUZYwOT44Nt0Xrb8hs=;
        b=NEKgu75Xsmjp6Vo7KlgaJbcpQZiqgLDKtBgN4vhZx7PXZIIv4PTcdJwLxScRJkrmyb
         kt1lpf+dKW0lx/ga0D/y/98JWXc9tVtshKpKvHiVCbAc9TFLSx23XgbHLznA9RR9CIIP
         b7OWtK/y3/vSVf5BLyywSgG06g6ypKZ9HDZEe4/0a//CNjs0KnISe4L6H/L1QHgMoVHm
         JEEkzTAIXtRKDnKS22QGgV5rmSYmBlb5dAoWcVzvFZhc0iSpL3kqWFTwB1YepUtiKDDV
         WGO8hf3lZ09y67rY4PThgYf7/F+LPwfLkCdbyhsyzMUXf+gtiEnMIl1ZO6qSL/vfh0Dj
         FVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200646; x=1706805446;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Niu/wIyVzmt2CT8gSNjUXekhDhUZYwOT44Nt0Xrb8hs=;
        b=fzWGXcoHXOyW/vI70VBmCw+2xfHsVKI/IaYy2bN1FteeT6x3HRpaVqZdSKtY6Fz5Vm
         72j9UYGimxMRXaFHA/CUhNOf8gMJUKpOAMoH6MofpRkRcwLLFK1K9tGDG4iTw42VdQlv
         efycyXtOGCLZSC97saRgM2B5P5f5SLX7jASb8obyeSUp18USkX4UiDRweAERO3qcW0vy
         QLZ7C0s4Po356u2b9VzuzYOC9fm+/sDXnZvTI0fnZL3BaVnSM9TiG7tOWR9LL1IRm2Mc
         e7v6e92Z3Ro27nJCbRIzxwugVDwuhGlFVvZR/Wflrvy7HYtHzRDC0THHrXTQZNlTboJr
         /hDQ==
X-Gm-Message-State: AOJu0Yw8unY4E8ZPgiaHwSwJ5FCBeVqF+oeXHax9zZdAk4qwti1VDuko
	hQlxmsiSv71E2MBjmP+YuJIqvuAG3MtePEAUa4WsXr/yt/KplNKXHPqYiuJ4SiCxDkOBuhrronp
	35/vMSEq6FiLEHcW/UZAklYi5v0okLaXAO4KXww==
X-Google-Smtp-Source: AGHT+IHLT5WItIQnJdD9DgCODma7HyWCschi/UEhm37iQjTdQGCBLAr5ei4Itdqch1xooUMLp8A7iRp5ePmqiJ3Fkag=
X-Received: by 2002:a92:de0f:0:b0:361:9446:dd03 with SMTP id
 x15-20020a92de0f000000b003619446dd03mr1429025ilm.13.1706200646115; Thu, 25
 Jan 2024 08:37:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter da Silva <resuna@gmail.com>
Date: Thu, 25 Jan 2024 10:37:15 -0600
Message-ID: <CAMbH6s90tNo1Kz3xuv741LoUkN=Y3Bcw2=7yGQhEe=xrgBgQcw@mail.gmail.com>
Subject: Slightly embarassing bug in error message when RSA key doesn't match.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git version 2.20.1

I just went to clone a repo on github on a dev server that I hadn't
used since March 1 2023.

Github updated their RSA key on March 24th.

So I got this message.

Warning: the ECDSA host key for 'github.com' differs from the key for
the IP address '140.82.113.3'
Offending key for IP in /[...]/.ssh/known_hosts:8
Matching host key in /[...]/.ssh/known_hosts:18

Of course it was the RSA key that had changed, and known_hosts:8 was
an RSA key, but the error said the ECDSA key was wrong. After removing
the bogus RSA key from the file it worked fine with the matching ECDSA
key. This error should probably report the correct type for the key
that is wrong rather than the key it=E2=80=99s trying to use. :)

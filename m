Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9338C14D29B
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313401; cv=none; b=WOMdA54ZYobR5LKdu8/ipDxPY/XmYRrGXPc9xLCErTblFVcmPOhIwwYEUhSqr0z9o+0xsIt+onQU+jv6G03+VEcnUJSX68B63IlRnIva54d3zVVzgEr5pcbeYThBT3O0BLCg1rlanftf/KZxmsq9jXqk35eYHJ1ZAXvC1fvO2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313401; c=relaxed/simple;
	bh=+R/FG2/lhdqDdvNPAP2I7cOYBM0buM99I2DVn+0moCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=si8W7xwk/d6JsJ/k8FGQTLuXtP4Slw03NxKt3sKaJGVI87U/pIiqLJwMpAWNiLowaOfgYhqSYwfP1Ui0o0xlCGcDOssWWEuZdBQWcBa2vqEpURe/ZuoG8dTRl9AlMOlnLtj7L5xlOrNiLyonXZ2CbuhMo0O4vOB8P+n6vOaDb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsJv0udz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsJv0udz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so9627795e9.2
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 12:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744313398; x=1744918198; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmRMo2v2Pq3g/5ezLLJPEkpc04cHrJVhnLjk/THhOOw=;
        b=hsJv0udzkDm/a/VLQlg5PoLuQOI7dcrEcay7mIdBotrFPeUlhEtxgFV3ad7Y5cpFn3
         y18e1RxOm/xH7fgZG+l7VP1nShCmudx9HuWeXf7W1m0vNd+shiZ75sCK9S5eILG21UFH
         xRhNmDoMf3noVFrNZ5s7p/BBCY7ryh83s7VZnvXjP3IyUfhs0ceCnaQIgZdzsnRNQD4v
         3CgUhn/jS0zqFwGqA1o4t6y3kEmumv104Lt2zMMEfnY+v7TZSxfZjZkIp1+dpKB3dR3a
         Pyal9+9UzJucuK/WmRcPeev5QmD4y+XevyVtho3GduwZZ3HMkLW6OSPmtUOqav9/VFd8
         T3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744313398; x=1744918198;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmRMo2v2Pq3g/5ezLLJPEkpc04cHrJVhnLjk/THhOOw=;
        b=D+gjzvkRlLN5ZRua7+P7gFNnX/O23JJkI8QNZT9mXS6t6j2U7Kb+iQ5EcWdxXDDMN6
         G4lkNRfU8eDlbXNcwfm+ujbEBQsOotlgSlCPF/ffhCBLyrbgmOsfGllLyXItBSPz0vB5
         e/Fe0iRZEb2L/gE9wKNhmPb+03KGKCT7yOyM0eG+Dp+pIKs3N+ODsF4cQAwY0yPKFzj2
         MM+SqhmBFQWll2zeNev6L6aTqXJaP6cnebjz4haP+7CVy1VGYbEMBDqm0VfULHQObTgt
         CGbuAFLEckep+rw8yzkaHDknGSYTqOzoaP+bnQplJ7YC4cFIIrpLswaX82Cw88uZKA8i
         fvfA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ei0jnENX6YxBakMYFKal5lpeZOGfjnIfE3pCvhctXFex/hvMovBK+CpwEOmF1k9HarM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmY4P5DKcPbxZnkBWNskjnrIt3Kk2qqFY0AcJcYRkxpNuf5Kuc
	H1nSukDmFIFnVCRe4fmYcHwrnc7LMNr5nByhpyjsUTD22B78yDQScLwyWJNptGTiqgpZgUA0Adw
	xkoF9AayRB0y1HxhDjT+14m2x8EU=
X-Gm-Gg: ASbGncs9iRQOMNl3BzHTVDACFg3c+BKyssPWJ3MuChYHz3Xh9oGUYS+QW410F8aNzbw
	F0ObkIF4HxVu2GlfEPEnoTQzt8zovDcXzTDD5aCAUacxW42LS8smStIheaz+JQgJva/j9Uq5Jy2
	11Rlv4CELEe72n3aQk51pISw==
X-Google-Smtp-Source: AGHT+IGHjrv9TXGGoZJgmf+yZkQpMEnUASRfIinEpF2fq1L5DPVQQhPpn2tt0rjVhNo7aBFmivU7eFjf81sTdS93HH0=
X-Received: by 2002:a05:600c:5024:b0:43d:98e7:38dc with SMTP id
 5b1f17b1804b1-43f2fdcd11cmr36300045e9.5.1744313397637; Thu, 10 Apr 2025
 12:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAArAzAoU9qDj+yLi3pA6wFYdTAk0UvQk4omSWM1RL4D9w5fw_w@mail.gmail.com>
 <Z-29LsgDvcS0qY5a@tapette.crustytoothpaste.net> <Z-8K9ZIt4j_UMNZm@tapette.crustytoothpaste.net>
 <CAArAzAr+YPwVXJo8mjkyQG8uWv=wt89tYyp6TL-rNzvwVYm9YA@mail.gmail.com> <Z--Kz4jsRzm4VSZd@tapette.crustytoothpaste.net>
In-Reply-To: <Z--Kz4jsRzm4VSZd@tapette.crustytoothpaste.net>
From: Andrej Zhilenkov <azhilenkov@gmail.com>
Date: Fri, 11 Apr 2025 00:29:46 +0500
X-Gm-Features: ATxdqUFYiDpdZ69CESTx4ZY9cudzyVWJ_x6Gc0HJisd8i_X3Qw4ByfG7Bcb8Qao
Message-ID: <CAArAzArGWE8S2gjvueS+fQ9c56mbzrRV5=0V8SaSX1NUMSXDSg@mail.gmail.com>
Subject: Re: Update symlinks after changing core.symlinks
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Andrej Zhilenkov <azhilenkov@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Ah, there I disagree.  I think if you have privileges to create
> symlinks, you probably want them to always be enabled, and if not, you
> don't really have a choice and they'll be disabled.  My experience with
> using repositories with symbolic links is that typically they don't
> function at all (or, if the maintainer has taken great care, only with
> greatly reduced functionality) if the symlinks are missing.  I think
> Git's repository is by far the exception here.

I personally agree that everyone should just enable them globally if
they can. Still, maybe it's just me, but I don't like proposing global
changes to users when they need it just for some repo.

And also, I keep seeing Windows users having `git config --local
core.symlinks` set to `false` (God knows why - in theory Git for
Windows suppose to set `--system core.symlinks` to `false`, `--local`
shouldn't be affected by this) and just setting `--local` helps
covering those cases too.

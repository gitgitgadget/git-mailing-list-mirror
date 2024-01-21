Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1399440
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705822437; cv=none; b=MbkooPtY6rVdTfZNv5H5z/Q3+QoD/I6+Ar653gRLY0bWuvUWiTRSHNcxy1vvxst6CgttIZRs6PBiPpZJk4mcUcDk541tGIehfmKIgCL9sJ/JvZjRr2070BIxs76nz64cn8oK285Qsd5+NBJwtVY6aVv/Wg3+GyNXGan/kXAu0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705822437; c=relaxed/simple;
	bh=nAR5/KwMOSmrEY/1jiyXbGeWrZoeRAmBTfv6LxCzvrU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CTO//gpOiSmiQTC9l19zDS5URN3iwdf1i0U7T1RUG6iqUHNL3loenc+qw7tRwz/T/cQyPCV55raBa4n8w/3md7vlGGYpMCLpZy+AdKE7nngObTr5A0YrM9LT/8sjozZjtwplvl7CnD0qFiJtiPZyCDhWkzmN2m9xpCAI0iYOEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd8RiejN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd8RiejN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e80046264so27562535e9.0
        for <git@vger.kernel.org>; Sat, 20 Jan 2024 23:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705822434; x=1706427234; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nAR5/KwMOSmrEY/1jiyXbGeWrZoeRAmBTfv6LxCzvrU=;
        b=Cd8RiejNwW54TeLEDl08JUjzAONUzP6GFKJtxlZdOmxR8GZG0qfoAjTbLPXKltolbw
         O8KJTogFrK/OJgjcPJ2NmgT5ltCrpoY4gBFZEyh/CYkdDKkZfJBcArZPAmJ5u7vSts3g
         vRFgBWn/3py3/EvdGKiFmogwAx0VpbS8gW1x10+FHHLFNChvSbGpxublPTxH9ulbR387
         Ot3byUVqgPvFf5vRx3ogqrkTRClvB7xiEzN/xg2s/0OQeO49YmVh92YfJXNtTjqmuM99
         Q+rFmkFR0t2kW19UA/PgXmN8d1FbFVnTd8fqEGYfVLl8RaK+3ISE4BPb86wCpd2gf8QY
         QjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705822434; x=1706427234;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAR5/KwMOSmrEY/1jiyXbGeWrZoeRAmBTfv6LxCzvrU=;
        b=l4dwnQt0qOPao9eMbR/nPlqM425Egf3Uk6oUs3z0jUcdtww87b6YbPrCQ4d7DPKxIb
         NjUacb99J4rcv/vDs1EbAiPPOyu9on9bwvHkMzJtpYo/IMvG7kLPwL/W6ElCOtGCQhHz
         QE9RjAPy76bVYn37nos2KAfBj0mZuUi9/MVwsodNyK8Pquhc6xtFWinRF9441tTtp9ff
         HkSuqY93GOtPpsqH8Pkh4sfVU4DjYxDWVk2fvdQoyN4eqNbtxDJ8PACfho0Wr+GENT9W
         oe7dBEr6cSBktzCLZEYorzdLrGp3Us9hzwIRE1eM4b6+X1OBPeFOSQzqBM98vl+vRJKP
         0BTA==
X-Gm-Message-State: AOJu0Yx8/dd/PFP1Xt7RcQpz0UD7FSZYd5tuqfkt+aZhpd7sFcomHV/S
	oAIUaUhbM6E2mVtaxQtdTOEAgJR79bp0lgftb+Cm0xU6v7qOv2oQrwdjzjJOJ8NtmwpZEacljU/
	NFHiwYbQvM2hVMfebDAWA25stVDCNE5MW
X-Google-Smtp-Source: AGHT+IGoouq2Bwie36/wkogZDDdAvsQb2XJ/DVcjmOkUAjM8eZD2b0T2iISGPwwZXk5l0FTkRnwjpzSLm7OPxE6HFVg=
X-Received: by 2002:a05:600c:510e:b0:40e:6431:60b4 with SMTP id
 o14-20020a05600c510e00b0040e643160b4mr1251325wms.27.1705822433567; Sat, 20
 Jan 2024 23:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: LunarLambda <lunarlambda@gmail.com>
Date: Sun, 21 Jan 2024 08:33:42 +0100
Message-ID: <CAHadoA-Sps2iiL8T15fcRiL0vCUBb9sNxj5=5yrkuiex65AZHA@mail.gmail.com>
Subject: Strange and broken behaviour when GIT_WORK_TREE is direct ancestor of GIT_DIR
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

I have run into very odd behaviour with git's --work-tree option/the
GIT_WORK_TREE environment variable.
I was experimenting with a workflow that involves targeted checkouts
of subdirectories in a repository,
commands of the form `git --work-tree=<dir> checkout @:<subdir> -- .`.
This worked fine, until I tried passing the parent directory
or any directory directly up the hierarchy (../, ../../, etc.) to
--work-tree, either as a relative or absolute path.
Almost all git commands behaved strangely or ceased to work at all.
I could not find any information in the git documentation or online
about this being a restriction in git, and given the
observed behaviour I believe it to be a bug, though I'm not sure if
it's something that should work or is something git should reject.

`git ls-tree` works as usual.
`git --work-tree=../empty-dir ls-tree` also works.
`git --work-tree=../nonexistent` also works.
`git --work-tree=../ ls-tree` prints nothing at all.

`git --work-tree=.. status` seems to behave mostly as it should
(reporting all files as having been deleted since the directory is
mostly empty),
but strangely reports the current directory (./) as an untracked file.
It correctly reports any other files in the parent directory as
untracked,
though it excludes the git repository itself from the list. It also
reported the paths of the files strangely,
prefixing them with ../ (or multiple ../ segments if the passed
--work-tree was several levels up).
This never happened with any other paths.

`git --work-tree=.. checkout <branch>` seems to write out the index
and working directory correctly, but while testing it would
sometimes update HEAD and sometimes not.

`git --work-tree=.. checkout [branch/treeish] -- <files>` completely
refused to work, always saying "pathspec did not match any files",
even for dot (.) and catch-all patterns.

This happens both with regular and bare repositories, and in all
repositories that I tested with.

I am using git 2.43.0 through the Arch Linux distribution.
My git configuration doesn't change any settings related to paths and
directories.

I apologize if this email is formatted suboptimally.
Thank you for your time.

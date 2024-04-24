Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4014A0B3
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966412; cv=none; b=Q0xCy6S7RgnPy5cjFXwpBbPqxKF6RGWMjQw01FKyWjdvSNBj7vgXFszb8MZMJchC1TdYIsKjrV7WIUi4c10zBq1LIjS9vmpa9udxFnMV/NMsDuxJuvGaRYNJ8FK91Cjwx6sory5Kd+D5GpRlVcx0F2FIcaiMGuNb/tpySsIDIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966412; c=relaxed/simple;
	bh=tFGnGnTT0TvLeAFt2Ie/uYYfnqYNZ4pQ5D6KfUbhM90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rnF/msaJRrdD6v+VryR0SedMzujXZdSOWwvOWzsXScawrlVZEyGq0CqjpEakXPPLKyeROauH8VSCJ6NC5i/nQSSZ9aYZ63ZwIZMBeAGaOTOW9oY5fZkP9lBJNyCN4Fx5BDNh2sOYj2yXxR9cYyr82DMI/5g9y4ylKVvlgnfQMz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHZotbWU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHZotbWU"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a55bf737cecso342011866b.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713966409; x=1714571209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tFGnGnTT0TvLeAFt2Ie/uYYfnqYNZ4pQ5D6KfUbhM90=;
        b=SHZotbWU0+bXfnB+ySC6AKunrJ8gjh/gUQt0NSWjdk81kAqB4zVxNThraoF9qYoTOE
         BxYLSFb6lzqSZRTrB/AQ1TPk6ypOJvyI4hFT/QqYXzAdluoieam9M0toaTXqgvw6+TNW
         3zR09QeL5WVFrog0y3SDWa5UdIwEoOszZd7xK5I2y/KIvNVIxdZYIc7TVc2kiVy6lOvb
         9OpoCfvdZmXJOTL2pm2T0U0+MOM5i2/TuPv/D+28CI4cRKcv1xuG7p6UHqe26PXcFwdj
         DrhE1q7/y1gM5PwPrxd67faAqBY99jyGpGL4bI2Y0kqVA8jihLBLRv21TiHbjag3+0w6
         xlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966409; x=1714571209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFGnGnTT0TvLeAFt2Ie/uYYfnqYNZ4pQ5D6KfUbhM90=;
        b=dRatM4X3233WGNkxgXgKGCagBRbR/z2cr2nBj3JbbW9DEN5a1soHGlKKM+UOa/HuMS
         5cUKiRTCwahIFDL39VYkzc1eu+ie5DltBKmSvlkeYgX/Xc+EmyiKIKO9azztrbqkUarh
         A0NhV1g+1+kouqZ0+MBm5xeacYliXBDvQAfqPi2PJv/Sht228NN62M9XU5tA3hZ2kAtG
         wjZS534xaFluyEFklOZynXEbmO0FAY6C36sO43WzhxxvcIELoceuOLLP1qQKA1Z9GoaK
         1S6v5bvzbgcvLXRrTacZobRbB4kCfwUVrmt/oT6xREpnbXhlKd8oTsQ2HZLfxS7oJfYJ
         1mNg==
X-Gm-Message-State: AOJu0Yz58M/zvMylUOpI6UCYdJ8tpEZm+zU5N3yLF2BbJ0gOrfsnuPQt
	MMSDSDmtawTPQdhAIQyAt+53qjW3F4yQ3kwdme5w8U9a0Y+KIUYbxHpJb+93yi44Qg293QIq9Cg
	dd81bWLdE2XBfcByvN5S6sZtaDPa2P1qh
X-Google-Smtp-Source: AGHT+IGeaknWdMoeTli+WlTyJvwnRsfuyo5Ai7jCSZ0bQqcI/kCaC6/+HjgP/jF3AFJ0mBSAl61zRG3IKJHB30oYkZo=
X-Received: by 2002:a17:906:4687:b0:a52:56e8:2294 with SMTP id
 a7-20020a170906468700b00a5256e82294mr1589945ejr.52.1713966408582; Wed, 24 Apr
 2024 06:46:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 24 Apr 2024 09:46:37 -0400
Message-ID: <CALnO6CBv3+e2WL6n6Mh7ZZHCX2Ni8GpvM4a-bQYxNqjmgZdwdg@mail.gmail.com>
Subject: Zsh completion: cached __git_repo_path affects shell session, breaks completion
To: Git <git@vger.kernel.org>
Cc: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can only reproduce this in Zsh, not with Bash (using equivalent
commands), though the caching behavior comes from Bash (fad9484f0a
(completion: cache the path to the repository, 2017-02-03)).

For example (with Zsh):

mkdir a b b/c
for d (a b); git -C $d init && git -C $d commit --allow-empty -m init
cd a
git branch foo
pushd ../b/c
git branch bar
git rebase <TAB>=E2=80=A6 # completion for bar available; C-c to abort
declare -p __git_repo_path # outputs /path/to/b/.git
popd
git branch # outputs foo, main
git rebase <TAB>=E2=80=A6 # completion candidates are bar, main!

I've only been able to observe this with rebase so far (e.g., using
switch instead doesn't seem to trigger the problem).

I wonder if all callers of __git_find_repo_path should declare `local
__git_repo_path`? That might defeat some caching, but I don't think
__git_repo_path should be set globally in a shell session, and the
script is explicitly intended to be sourced=E2=80=A6 again, though, I think
Bash does the correct thing and somehow Zsh is capturing this variable
that it shouldn't be.

--=20
D. Ben Knoble

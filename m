Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69E31BC84
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313093; cv=none; b=nPLiIjiiD5FXM0XN4O84b9HOWd8w91URuwM3bzxLDOCGm14U7rrBw4DVQFpJ9ob6xG57dUv+cGCGZ/R1va0n1O/J30imUez91OblHriZcVG9u1gvce4JeRq08ODPdtlmsF27tcnCAfTULAZPAvUDMhbXsNyUgw6qxDdMUfBxlq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313093; c=relaxed/simple;
	bh=Y6j18C+XM+piByRu9zqViAHKyI0JP2Hj6DWKLlXBhlE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mfhTqwcHnCSm2KOS4ej2yxc27EBXLDDioHjQ0VF+XiLwc9AiECnW6LXKB0sq+FUyPHdhyVoiLwfg6J+8wIBmUQc7LMxcsx2JMEoSy44ouuEAc1DgRHwyDf7f9NLfdknYJjbEmnhpXF+3yGKMJTONg4DEKGRQ/utfGNs2v8YM3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIG5G41S; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIG5G41S"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290dc63fabbso20856255ad.0
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313091; x=1761917891; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6j18C+XM+piByRu9zqViAHKyI0JP2Hj6DWKLlXBhlE=;
        b=FIG5G41SkrN0Z++OvXtNP1MMtCuWLM9RNXD6kCov+5spqhkExcmtMCbbDchVz9iOLb
         U+rMjllbXVaDUC2HYkv/+4hwGP462vO+2TSRBwksJtka8n9EbaZZv3VCF/Vy9aApD0n4
         xDooJZ9NV7g+21mKuwjxS1SsvseP+gGaxU7X1Y/6drKlnaTzg8Xy/SIYF1tqeyGbgQlY
         6P477+CQRGxJzSfxL3XIEL8CZCopN/Bc46BzezdM0IaOuiJSHPsU7gRmLwjzbIr+lbqf
         wUYIVF3HlXBU5RR15OoRv+iDg42LQfbT77ApW4M2qx/dQNIscnKbuiHEfLKReSjNWKGd
         ySEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313091; x=1761917891;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6j18C+XM+piByRu9zqViAHKyI0JP2Hj6DWKLlXBhlE=;
        b=aNzan668qXxiUBO5ibD5SucLdlWhBRzHXrW1JWUp+XbYRpt2FtTvbw9CKWJXIkKw7g
         4IQTzj+ajQ2zzwPOAZf8Je7EylLtZrr2FQMpsVAvarrQZF+XQIHBsfz2z7I1Cu9ycQ09
         ETuPDrSM6ZgEiA4NE055bMU9x1XGOrhjYh5UbLiDMfyNZJCcE46eg6gqd542aZZAf4D9
         NE5Oq3TO/UZapwJE1CRR6bOk5H5b4lbLOUy8+K0Qb0jmr6f4xIiyXeDW4boiG3AJ67WM
         gbqJuXgFAEVD6Vj+C5fiAWjKSb8AMtDDZ/+U0hQ67USjSTmqVgG4iMEvj1jzYF3Ez6oZ
         FqYw==
X-Gm-Message-State: AOJu0YxC4Et7zuz9MyqnEcoEK6L6xsh1r111JgaOEFDkNSJi9+mc6ojm
	MItJw+w55r+s3s6I2HonG1+XV1Qn8UcjXFsfdV/vDPfIqYzulh7YwTP8N6/PsaApQzi2aRRsIhK
	jhxWL3Pt6HONz4J5S+i6NbjU+qLzu5DzFuqJ3
X-Gm-Gg: ASbGncvXkDr/fYLPjXVEdlu1DEpERPqr7s//SzU1Cp0tpwB+slGAzcfBMx6ZtionVpm
	DEQX7Z5ZNIpp34B6Z/xVahJBvRbF6zJ6AeAK7oIDSrvlJTEYubTwdp2asbNYpu5TazNk5eg/DLW
	M3XDDsCZ3af8BZzOJkypX+RNRx30cNpV+PkUrjH56ZjjvQL6+VTHqUF8JdHpMZgufZDzXJ5IXf0
	S3R+ZPUm2Ix0KCS66uvR9Zm61RezmDGnMZgD7hcbhV2jolJkgWo3iWcNW5C
X-Google-Smtp-Source: AGHT+IEx4TbplLptuyxy4lf/EI7OjIOVkBlZv68MGdvScpUhd57eK1k5wmTa4aIKa4bLmeJOYUJaaJ5dTL8NIaMdMNs=
X-Received: by 2002:a17:903:1112:b0:269:7c21:f3f8 with SMTP id
 d9443c01a7336-2946e117f30mr90063435ad.39.1761313091398; Fri, 24 Oct 2025
 06:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John Bevan <johnlbevan@gmail.com>
Date: Fri, 24 Oct 2025 14:37:59 +0100
X-Gm-Features: AS18NWDdrqRZkLvvc8fWtUMB_c8YZnZST1aRiYwR0KOZzsIEUthIYANR0OOfMcI
Message-ID: <CAJLdeLz0p_40vsL=Zu2sHfwD3mdUjbQRpeVZF0WM2gv449pb8Q@mail.gmail.com>
Subject: color.ui is not working as expected
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

There seems to be an issue with colour formatting on output from git;
e.g. error messages are showing in the console's default colour
instead of red, despite colour.ui being set to always.

I'm using the Windows version of git, but on submitting this issue
there I was directed to yourselves.
https://github.com/git-for-windows/git/issues/5907#issuecomment-3433888979

It seems that the issue is down to errors being sent to the error
function in usage.c
(https://github.com/git/git/blob/master/usage.c#L291), but that
function doesn't include colour based formatting.

Thanks in advance,

JB

(Apologies for not following the advice at:
http://www.chiark.greenend.org.uk/~sgtatham/bugs.html - sadly my
company blocks access to HTTP (without TLS) sites, and this site
doesn't present via HTTPS).

Additional Info

Git for Windows version
git version 2.51.1.windows.1
cpu: x86_64
built from commit: 1454f0a9c4a3a22fb3fd7cc33f76f88cd65ced41
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.16.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1

Windows version
Windows 11

Windows CPU architecture
x86_64 (64-bit)

Additional Windows version information
Microsoft Windows [Version 10.0.22631.6060] Options set during
installation Editor Option: VIM Custom Editor Path:
Default Branch Option:
Path Option: Cmd
SSH Option: OpenSSH
Tortoise Option: false
CURL Option: OpenSSL
CRLF Option: CRLFAlways
Bash Terminal Option: MinTTY
Git Pull Behavior Option: Merge
Use Credential Manager: Enabled
Performance Tweaks FSCache: Enabled
Enable Symlinks: Disabled
Enable FSMonitor: Disabled

Other interesting things
ANSI colour codes proven to work by running "e[31mREDe[0m" in pwsh/powershell.

git config --global --list gives:
core.sshcommand='C:\Windows\System32\OpenSSH\ssh.exe'
core.autocrlf=false
core.longpaths=true
core.editor=code -w -n
core.pager=less -FRX
user.name=REDACTED
user.email=REDACTED
user.signingkey=~/.ssh/id_ecdsa.pub
safe.directory=*
gpg.format=ssh
gpg.ssh.allowedsignersfile=~/.ssh/allowed_signers
commit.gpgsign=true
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process filter.lfs.required=true
diff.tool=vscode difftool.vscode.cmd=code -w -n --diff $LOCAL $REMOTE
merge.tool=vscode mergetool.vscode.cmd=code -w -n --merge $REMOTE
$LOCAL $BASE $MERGED init.defaultbranch=main color.ui=auto
color.error=red bold

Git.exe is at: %appdatalocal%\Programs\Git\cmd\git.exe

.gitconfig is at: %UserProfile\.gitconfig

Terminal/shell
PowerShell

Commands that trigger the issue
git checkout nonExistantBranch

Expected behaviour
Output error: pathspec 'nonExistantBranch' did not match any file(s)
known to git in red

Actual behaviour
Output error: pathspec 'nonExistantBranch' did not match any file(s)
known to git in white (terminal default)

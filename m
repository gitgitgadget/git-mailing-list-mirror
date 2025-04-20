Received: from mail.markus-raab.org (mail.permaplant.net [95.217.75.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47711E47CC
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.75.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155289; cv=none; b=V5FxutKiuG34OiAy5AohCOKiys2OlGM4AikZAIi3vmC7ZF773kUnyvfLAXij6ZTVFe0F7mmqX8mKH+0g3t/cxg5kJmtGz7ZPqc0piQsfmRXAwTnkAf2rmHyzVzTdiR5E9wsrkFYNj+J1SmOmKHVbWvB1TebGSYloGrR9ziq13fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155289; c=relaxed/simple;
	bh=bxMNuifIwEGabXPnWfYfkRHq6Qmkt4ixp5B/vlrhvH0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j0IcDqAwabUEaIOQePsm641Om2YHrW/PF4shQR4FY3nvpFv9pCbaTVhgacmGlEKLfY95Ypd+e5ECris9rUbLwy/lJvOteMto0H1o4UEfXUmk8RYKlKVE+KLvFbBDaBT9uC0e/2bojODoBDHnFGvnAndIUc7aEvmBY6sHRarszt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org; spf=pass smtp.mailfrom=markus-raab.org; arc=none smtp.client-ip=95.217.75.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markus-raab.org
Received: from [192.168.1.2] (h082218105086.host.wavenet.at [82.218.105.86])
	by mail.markus-raab.org (Postfix) with ESMTPSA id CA98DD7739
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 15:14:34 +0200 (CEST)
Message-ID: <d8c1df4e-a4d7-4c4c-be44-b13de3d9ffea@markus-raab.org>
Date: Sun, 20 Apr 2025 15:14:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Markus Raab <mailinglists@markus-raab.org>
Subject: unwanted interaction of git stash and cherry-pick --abort
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear git maintainers,

What did you do before the bug happened? (Steps to reproduce your issue)

git init-db
git commit --allow-empty # needed for git stash later
echo a > a
echo b > b
git add a b # some arbitrary files with content
git stash
git cherry-pick 170bbe5 # any commit that cannot be applied, e.g. the 
initial commit here
git cherry-pick --abort

What did you expect to happen? (Expected behavior)

That a and b are still there or I am somehow informed that the files a 
and b would get lost.

What happened instead? (Actual behavior)

The files a and b are lost.

What's different between what you expected and what actually happened?

Loss of data.

Anything else you want to add:

Everything fine, only the content of a and b is lost ;(


[System Info]
git version:
git version 2.39.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-32-amd64 #1 SMP Debian 5.10.223-1 (2024-08-10) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

-- 
Best regards,
Markus Raab


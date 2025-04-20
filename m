Received: from mail.markus-raab.org (mail.permaplant.net [95.217.75.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB648C147
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.75.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745155096; cv=none; b=UYt1ulcDponYvpxJ4U76d9BBKSvhndy4Gqggt9M4acYqkobWYr/82qb4CFuq1A2g4HDYLD4p+PT5Z9/9cSeaHyq0XVfKVS40x9CU0mgEYKYlEg5OT2Mk1ezUUXX87E0yzfE8PH8Swbf1v9kBsj9q5hIIcT9jX8ygrty9kHjBpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745155096; c=relaxed/simple;
	bh=7Zutnbi6Er2AiBaD6zswe0Zsqs2zwj7O/zFcX2gQlBo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=SNPTy01KIt9/lwrsJqcfMMoc2f2X+HYW0K2IRUCveVcPJjyyWyzIS3+5s+x14wVz7Ws5oeJc3MiYDr++SGRNn7+61XJ+gHVP/27gXcf3DYNLZpJDiWYPfAj2V6i4JAgQMDyiA4yHIKRKiW8GZw5o8h3RkKOnkZiHl2qc67MJCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org; spf=pass smtp.mailfrom=markus-raab.org; arc=none smtp.client-ip=95.217.75.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-raab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markus-raab.org
Received: from [192.168.1.2] (h082218105086.host.wavenet.at [82.218.105.86])
	by mail.markus-raab.org (Postfix) with ESMTPSA id 68B3AD799A
	for <git@vger.kernel.org>; Sun, 20 Apr 2025 15:18:10 +0200 (CEST)
Message-ID: <13ce78d9-9afc-4bde-8c52-bbbae80cd707@markus-raab.org>
Date: Sun, 20 Apr 2025 15:18:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Raab <mailinglists@markus-raab.org>
Subject: unwanted interaction of git stash and cherry-pick --abort
To: git@vger.kernel.org
Content-Language: en-US
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
git stash pop
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


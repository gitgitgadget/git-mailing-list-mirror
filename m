Received: from gate.home.utahime.org (gate.home.utahime.org [111.108.18.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57E4C91
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.108.18.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710468066; cv=none; b=QSQ9nH3GC11X4OOeMNkboC2xNDctkSBtFhZIFsFXpf5KhCAruc02tEMru9C/8+Q6SaNvmBxjRiL5yWgWfPCFQSL1q6h78u0+qZAizpqlbs4xnq+ww8CLon2H9rHz9Zf2H2pnSQX/2+gh2eVmk+nKC6T42vRK+749UHU2TF3+oiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710468066; c=relaxed/simple;
	bh=InwQYhApucRF75WTOor3M5acm0HsEcRaKpw5p1uuKLQ=;
	h=Date:Message-Id:To:Subject:From:Mime-Version:Content-Type; b=FRkqJZDo26EHerplHQ4QIo46wg9HcU0uw9CZKbBSpjrFmpKOR96BKFu7CovCsYAzCWsXuw0vU22e/NQVxB2UDBEwq8WWS1dt9mNpZcXgmR/HAhBS3tWyVK04ssTTRvNtz0iYMAe197YF5EaNLF5KulbpIqI+GKupT/l1mB70LBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=utahime.org; spf=pass smtp.mailfrom=utahime.org; dkim=pass (2048-bit key) header.d=utahime.org header.i=@utahime.org header.b=jG/HuQiA; arc=none smtp.client-ip=111.108.18.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=utahime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utahime.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utahime.org header.i=@utahime.org header.b="jG/HuQiA"
Received: from eastasia.home.utahime.org (eastasia.home.utahime.org [IPv6:240b:11:220:fe00::174:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by gate.home.utahime.org (Postfix) with ESMTPS id 893F31843E;
	Fri, 15 Mar 2024 10:52:18 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=utahime.org;
	s=maybe2019112701; t=1710467538;
	bh=InwQYhApucRF75WTOor3M5acm0HsEcRaKpw5p1uuKLQ=;
	h=Date:To:Subject:From;
	b=jG/HuQiAQ4cE8wc1k6D1g8WslK2dLqF4KI5XrmKP9N34C4NWhJ1vqURCjRGa+bbCy
	 UgtJs5QoqX7DkEAXqJqp/EDbCLIJpY0wnWFugQF4WBApLrn3L625NY2gYiJ/tWrWon
	 MnC5BHgIqwMxzZH+zriEA6ATvOYrTghLfoe0I6tmHEAk4z3rdeeGK293Mkmdt4fHqw
	 NletKE0KGhtVAvoGVnMlBDvB7u7jE4QAtWdK4os8euG/rG4onk8dd0Z5WkzulJXXCv
	 wiU7JITt+53TD6viWxUVKqpzfm8tkc3/TZV1Sgtc/I2RPMgAZuPAeSSSPhHx2mt+/t
	 mM54luOz8BYog==
Received: from localhost (rolling-vm-debian3.home.utahime.org [IPv6:240b:11:220:fe00::174:23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by eastasia.home.utahime.org (Postfix) with ESMTPSA id BC607A305;
	Fri, 15 Mar 2024 10:52:17 +0900 (JST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.3.0 at eastasia.home.utahime.org
Date: Fri, 15 Mar 2024 10:49:39 +0900 (JST)
Message-Id: <20240315.104939.1269594475664662053.yasu@utahime.org>
To: git@vger.kernel.org
Subject: Name for initial branch is ignored when repository is cloned
	with SSH
From: Yasuhiro Kimura <yasu@utahime.org>
X-Mailer: Mew version 6.8 on Emacs 28.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

What did you do before the bug happened? (Steps to reproduce your issue)

1. git init --bare --initial-branch=main /somewhere/test.git
2. git clone ssh://hostname/somewhere/test.git
3. cd test
4. echo foo > foo.txt
5. git add foo.txt
6. git commit -m 'Add foo.txt'
7. git branch -v

What did you expect to happen? (Expected behavior)

% git branch -v
* main 1bd6499 [gone] Add foo.txt
%

What happened instead? (Actual behavior)

% git branch -v
* master 3f0b875 [gone] Add foo.txt
% 

What's different between what you expected and what actually happened?

I expect the change is committed to 'main' branch. But actually it is
committed to 'master' branch.

Anything else you want to add:

If I change step 2 as following,

2'. git clone /somewhere/test.git

then I get expected behavior.

[System Info]
git version:
git version 2.44.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-18-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.76-1 (2024-02-01) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

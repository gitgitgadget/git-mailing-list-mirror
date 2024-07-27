Received: from out.smtp-auth.no-ip.com (smtp-auth.no-ip.com [8.23.224.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAD1D52B
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=8.23.224.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097466; cv=none; b=Z8Gxw1I70AHsxvdObpjKqOv9mgKmEU+4sPU7mgB4bdD58miTP7S6rtF9Eudf8QTOAgTK/FVe6tClWkhIdff2NDL2L5ZLPdXo1eibr3+OpUOCfj22T+/a322qLfDHXAcEuugbrpJFEoZZiTaeXPISX1ywWOS4iu9ScKO47NpLNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097466; c=relaxed/simple;
	bh=ItCbLYhGJnN2kMPo+ysdDud0zjsIx74Ui8Hi6HQwMaE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kbC6qc8eIvju6/qo+/IQHjy2h6aAUhi+YwT/mdcs/3uY1vYw+EgWxPiqIDEafNx3wdBVXkeY69jwKHkFSXnh8Jq+JjZG9OLQ961j0LcQ0DKMylIaNtRueQRWJX3IZv4k4aX/dCA2FxEchEP0DSwXs1/TR4BDiFTIUF5Nw13RutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org; spf=pass smtp.mailfrom=flyn.org; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=ZQ4gPwQS; dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b=ZQ4gPwQS; arc=none smtp.client-ip=8.23.224.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flyn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flyn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="ZQ4gPwQS";
	dkim=pass (3072-bit key) header.d=flyn.org header.i=@flyn.org header.b="ZQ4gPwQS"
X-No-IP: flyn.org@noip-smtp
X-Report-Spam-To: abuse@no-ip.com
Received: from www.flyn.org (unknown [137.26.240.243])
	(Authenticated sender: flyn.org@noip-smtp)
	by smtp-auth.no-ip.com (Postfix) with ESMTPA id 4WWV7j4zVfz7mTs
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 16:14:41 +0000 (UTC)
Received: by www.flyn.org (Postfix, from userid 1001)
	id B136D1EE002E; Sat, 27 Jul 2024 11:14:40 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722096880; bh=07nahXTDC88j6eOGOVlhBS7oC5e3CRWNFKUczO+9Zso=;
	h=Date:From:To:Subject;
	b=ZQ4gPwQSSbd1woNzRPWYPqhn8PHPBgwsqYwGNzMsTuP239ABMWr3veLqLw/J0TKjM
	 ovfvhXDbnLcTmYwGU550JDxLWZLVMG/7/+xSqrnmFqIdDqUKUXYfhdFvjokxmdHEc0
	 ueTMANerG8sgXcM4X3Ou97XSERFu0c661R0LGt4AVwu1CVMxmTMsmBdRoQuL7H63O4
	 LgaPujmqzAox+prbKqzJ1t0Cl0cywM+b0K2xXhxbhwTR1SXObLW7Ul6xerQFfcexYM
	 8mEl0KQe1UYw1C/pYqBau6cyJIyAfGOywqXb4HXjAgnz/6J2O8akzwLULFom32g1/i
	 MRwvc+ddpPfrLoXH6dLc7smLsq7dxdY7VC2aBQamJCHH3ZiKWJOWZ6pZNJCCM9P3qp
	 yJ3aEeTDWHVqv1tjytnOpmI34w4Xp9SnGrwNWM8VOfjTJc7KcnXHEjLK+Qot9U8m5R
	 8yWb1kG7S7ZIFUowYE6VLKnW2YqWOeJ+IJwdgzJHgBHedRK3Sdj
Received: from imp.flyn.org (guardian.flyn.org [137.26.240.242])
	by www.flyn.org (Postfix) with ESMTPSA id 8E46A1EE0029
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 11:14:40 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyn.org; s=mail;
	t=1722096880; bh=07nahXTDC88j6eOGOVlhBS7oC5e3CRWNFKUczO+9Zso=;
	h=Date:From:To:Subject;
	b=ZQ4gPwQSSbd1woNzRPWYPqhn8PHPBgwsqYwGNzMsTuP239ABMWr3veLqLw/J0TKjM
	 ovfvhXDbnLcTmYwGU550JDxLWZLVMG/7/+xSqrnmFqIdDqUKUXYfhdFvjokxmdHEc0
	 ueTMANerG8sgXcM4X3Ou97XSERFu0c661R0LGt4AVwu1CVMxmTMsmBdRoQuL7H63O4
	 LgaPujmqzAox+prbKqzJ1t0Cl0cywM+b0K2xXhxbhwTR1SXObLW7Ul6xerQFfcexYM
	 8mEl0KQe1UYw1C/pYqBau6cyJIyAfGOywqXb4HXjAgnz/6J2O8akzwLULFom32g1/i
	 MRwvc+ddpPfrLoXH6dLc7smLsq7dxdY7VC2aBQamJCHH3ZiKWJOWZ6pZNJCCM9P3qp
	 yJ3aEeTDWHVqv1tjytnOpmI34w4Xp9SnGrwNWM8VOfjTJc7KcnXHEjLK+Qot9U8m5R
	 8yWb1kG7S7ZIFUowYE6VLKnW2YqWOeJ+IJwdgzJHgBHedRK3Sdj
Received: by imp.flyn.org (Postfix, from userid 1101)
	id 7CB0D2D8D74D; Sat, 27 Jul 2024 11:14:40 -0500 (CDT)
Date: Sat, 27 Jul 2024 11:14:40 -0500
From: "W. Michael Petullo" <mike@flyn.org>
To: git@vger.kernel.org
Subject: Git clone reads safe.directory differently?
Message-ID: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.520000, version=1.2.5

Glen Choo's commit 6061601d modified Git so that safe.directory could
be set on the command line using "-c". It seems most sub-commands work
this way, but not "clone". Here is an example:

====================
$ whoami
mike
$ ls -ld /tmp/y | cut -d " " -f 3
root
$ /home/mike/Scratch/git/git -c safe.directory="*" -C /tmp/y log
commit 4be57d4489010047fd3ef39a633264f634a432b5 (HEAD -> master)
Author: [...]
Date:   Sat Jul 27 11:06:19 2024 -0500

    Initial commit
$ /home/mike/Scratch/git/git -c safe.directory="*" clone /tmp/y /tmp/z
Cloning into '/tmp/z'...
warning: templates not found in /home/mike/share/git-core/templates
fatal: detected dubious ownership in repository at '/tmp/y/.git'
To add an exception for this directory, call:

	git config --global --add safe.directory /tmp/y/.git
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
====================

Glen's commit 6061601d seems to indicate there is no security reason
for this:

	"As a result, `safe.directory` now respects '-c', so update the
	tests and docs accordingly. It used to ignore '-c' due to how it
	was implemented, not because of security or correctness concerns."

I added some printf statements to ensure_valid_ownership() in setup.c,
and I found that they executed in the case of running "git log" but not
"git clone".

A little more research found that "git clone" bailed after the call to
transport_get_remote_refs() many lines before the call to clone_local()
-> copy_or_link_directory() -> die_upon_dubious_ownership().
I suspect something along that earlier call path is still using
setup_git_directory_gently(), rather than git_protected_config(), to
check for dubious ownership.

[System Info]
git version:
git version 2.46.0.rc2.dirty
cpu: x86_64
built from commit: ad57f148c6b5f8735b62238dda8f571c582e0e54
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.6.0
OpenSSL: OpenSSL 3.2.1 30 Jan 2024
zlib: 1.3.1.zlib-ng
uname: Linux 6.9.8-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul  5 16:20:11 UTC 2024 x86_64
compiler info: gnuc: 14.1
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/bash

[Enabled Hooks]

-- 
Mike

:wq

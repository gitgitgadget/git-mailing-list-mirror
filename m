Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A8190075
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663662; cv=none; b=a/9wZM5ErjQEZmseFGlMx6aAPCHhrqXS1v5693NaDrn5XY/yQToiRnhXuRTdV80lmKF9uM+DYjf2+SEUitLJBWZhTCuBWcGxRVlqMADmxb/Ei9eb2zS1Rdqctil48iO7u2PYQxBD4FetQcOaPfSEKkrFk4TF0xiuiHNbwCxPbh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663662; c=relaxed/simple;
	bh=wVA583L0CiqVek8S5gYlVV3MIiN8Nyca6N8aLGU/crs=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=QsN7GF8+rU+T18gdgcvjZ4/nT930dQd51XAy8TG8N4nXPdqxqUATg6KXzTw7R/cta4o+FRMncOYCA2ExBUIp/GKbWY2idpqZPmlGCJrAPUbo5PzKZLVvMkbukbFFPGOv6oDo3vaH/fM3io2dEbj4yMc818R+ixkv1GHFls5fXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enrg8.com; spf=pass smtp.mailfrom=enrg8.com; dkim=pass (2048-bit key) header.d=enrg8.com header.i=@enrg8.com header.b=5RMA8sGJ; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enrg8.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enrg8.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enrg8.com header.i=@enrg8.com header.b="5RMA8sGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enrg8.com;
	s=protonmail2; t=1731663643; x=1731922843;
	bh=I/4yie6/ESs+G3kXczCnlLT6Z9VdLTDJEpmVPZoqrYs=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=5RMA8sGJtglZeRcAuBaJX2hAvkxzdwwewTZ2893XJGdnGi+AWhGNVYvl2dSBj8Z69
	 rF4+n523fI9U0lFRiwkZDSfDJ0mmhcsc+cu9e5TP+NHC/xyOO9vOX5/okophUCjZCd
	 4NX8/hBxypcPfBfc/ihsw9L7pyhtB3IAc1VqqvGjGNyUL0QuJHoClL2AhIsC50M9nK
	 kw2vyiznl/giu2OTlOVhk09CvvPb91fdU/aEOadI6F9l3Pm6rQ0jidcOpYbfvv6DCB
	 f5WvZH4bySOoO5IZPI3oWdPlh4c463VG1MUUQkuH/8LXvhRCAsWmlsiBQyO2K6qWiz
	 XNUjDQMVhngZQ==
Date: Fri, 15 Nov 2024 09:40:38 +0000
To: git@vger.kernel.org
From: Attila Kerekes <ak@enrg8.com>
Subject: malloc: *** error for object 0x1: pointer being freed was not allocated on MacOS with git 2.47.0
Message-ID: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
Feedback-ID: 28016050:user:proton
X-Pm-Message-ID: b95252f3c67c4f8e119b7d0bbe83e2925ca4030a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Maintainers!

See my bug report below:

What did you do before the bug happened? (Steps to reproduce your issue)

run the command:
  git maintenance start

What did you expect to happen? (Expected behavior)

git maintenance is started

What happened instead? (Actual behavior)

git(26100,0x1ffd63840) malloc: *** error for object 0x1: pointer being free=
d was not allocated

What's different between what you expected and what actually happened?

git maintenance jobs did not get set up, instead i got a malloc error

Anything else you want to add:

MacOS 15.1 (24B83) on M3 mac.

git installed with brew

the Apple provided git 2.39.5 works fine when I run git maintenance start.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
uname: Darwin 24.1.0 Darwin Kernel Version 24.1.0: Thu Oct 10 21:05:23 PDT =
2024; root:xnu-11215.41.3~2/RELEASE_ARM64_T6031 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


Best Regards
Attila

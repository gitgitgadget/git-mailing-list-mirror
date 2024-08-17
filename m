Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE58821
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861534; cv=none; b=XXseySGSfQdiW+WtrUODumtpIuwJLrrazqTpsUD1BxiQM8hIQCfdkmjGDzLW6I8Z+nvgLslaqsQOwhdNVAhJ4mUP2/2L3slUB5s7cPvU+qML/SAoHUV5mg4ptL1Xc9CwF0tAr7qtzWC63037kVCNxu6eO95x99Veg79CfHVdNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861534; c=relaxed/simple;
	bh=0/zurBqBPoxegbpfKGEXuQqljpUsvPRSPYe288bRtcg=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfJiuBLR5LS3nxylNn7/7ttYfBa/BbXZg+bn7Xpi4UbCruFGBQ8r+YCo7f3pc3oc7wo/hine27GOWdrXhBd936iZ++lmRdK8mfQ0FAclRrRk7Al/loJKaVDLKH4LSMMLWY9T14IQb6Z0+qNtQfVMmXTHV1zcz0TSnsL2adGJfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 47H2PMv22520067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Aug 2024 02:25:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Zdenek Wagner'" <zdenek.wagner@gmail.com>, <git@vger.kernel.org>
References: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
In-Reply-To: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
Subject: RE: git push does not work over https WebDAV
Date: Fri, 16 Aug 2024 22:25:17 -0400
Organization: Nexbridge Inc.
Message-ID: <011301daf04c$b6b30fe0$24192fa0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJVJytsGpA9Yoe68xPY/cF7eGjBy7E2SsUg

On Friday, August 16, 2024 9:11 PM, Zdenek Wagner wrote:
>To: git@vger.kernel.org
>What did you do before the bug happened? (Steps to reproduce your =
issue) git
>commit git push
>
>What did you expect to happen? (Expected behavior) The changes being =
pushed to
>the repo via https WebDAV
>
>What happened instead? (Actual behavior) $ git push
>error: Cannot access URL
>https://userfiles.math-gnostics.eu/git/mg-software.git/, return code
>22
>fatal: git-http-push failed
>error: failed to push some refs to
>'https://userfiles.math-gnostics.eu/git/mg-software.git'
>
>The credentials are in ~/.netrc, git clone and git pull works fine on =
all my repos on
>the same server, git push returns the same error
>
>Apache error log reports successfull access with the GET method (clone, =
pull) but
>"user not found" for the PROPFIND method
>
>What's different between what you expected and what actually happened?
>git push does not work at all
>
>Anything else you want to add:
>It is apparently an issue of git which is not OS specific, I have the =
same behaviour in
>Fedora 39 and Mac OSX, both having git 2.46.0. Everything works fine =
with git
>2.44.0 and earlier. I have
>temporarily solved my problem by downgrading git in Fedora 39. I have =
not trid
>2.45.0.
>
>Please review the rest of the bug report below.
>You can delete any lines you don't wish to share.
>
>
>[System Info]
>git version:
>git version 2.46.0
>cpu: x86_64
>no commit associated with this build
>sizeof-long: 8
>sizeof-size_t: 8
>shell-path: /bin/sh
>feature: fsmonitor--daemon
>libcurl: 8.9.1
>zlib: 1.3.1
>uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:10 =
PDT
>2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64 compiler info:
>clang: 14.0.0 (clang-1400.0.29.202) libc info: no libc information =
available $SHELL
>(typically, interactive shell): /bin/bash
>
>Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon
>Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux
>
>
>[Enabled Hooks]

Does your .curlrc specify --netrc or -n? Those appear to be required to =
specify the
Use of .netrc in curl.

--Randall


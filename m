Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE551F7598
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462013; cv=none; b=bz7sCC1+gaMgNqOnsipMoOi/FtdfmfUArXwWssE15GfAdWADEGGM7z34LDC9jT+NYIzKQmt9DIAfj69y53O/oZVf8qGe61MXZFvJczDoEp1ENMplzB0yShc1MSSdm572ew3nK/+jCYjbQiLhu4Mt1yJKoy1LnJu7AoHz46c7bSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462013; c=relaxed/simple;
	bh=JTJmOJuG9cdE7fV/dhtpkerG4IuYACi/RcrMM+pKo3o=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXBykD0dL32bt1mEz0tWLCHhR48g1C10NVSlbqhbt3qmqT0bmQSs2H8krBXVloQW8uuAQMP02yaimjwa8fv65Cp7XdS0DmFadyrVSP9wDU5zcm0pOlbmJrzHq2joXjMWzL4lXewDletE2x/qSoyNu21R8ffGbUlPKIxTuzxrhlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BHJ060C1840694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 19:00:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <rsbecker@nexbridge.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqfrmn4hr9.fsf@gitster.g> <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com> <Z2EC9rq3F0rTljff@pks.im> <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
In-Reply-To: <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc0
Date: Tue, 17 Dec 2024 14:00:01 -0500
Organization: Nexbridge Inc.
Message-ID: <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFEfEaRNrZ6uu0wI6oVXmgPkoCy2gI/zh74AaCMqnQBl78GqLPsW5dA
Content-Language: en-ca

On December 17, 2024 8:48 AM, I wrote:
>>On Mon, Dec 16, 2024 at 07:07:25PM -0500, rsbecker@nexbridge.com wrote:
>>> On December 16, 2024 1:15 PM, Junio C Hamano wrote:
>>> >An early preview release Git v2.48.0-rc0 is now available for
>>> >testing at the usual places.  It is comprised of 446 non-merge
>>> >commits since v2.47.0, contributed by 66 people, 26 of which are new
faces
>[*].
>>> >
>>> >The tarballs are found at:
>>> >
>>> >    https://www.kernel.org/pub/software/scm/git/testing/
>>> >
>>> >The following public repositories all have a copy of the
>>> >'v2.48.0-rc0' tag and the 'master' branch that the tag points at:
>>> >
>>> >  url = https://git.kernel.org/pub/scm/git/git
>>> >  url = https://kernel.googlesource.com/pub/scm/git/git
>>> >  url = git://repo.or.cz/alt-git.git  url =
>>> > https://github.com/gitster/git
>>>
>>> Did I miss something about GIT_TEST_DEFAULT_REF_FORMAT=reftable being
>>> removed from the test suite? That was available under 2.47.0 but if I
>>> supply it now, the tests crash at git init.
>>
>>Nothing should've changed here, and a local test run with that
>>environment variable works alright on my system. Could you please provide
more
>details?
>
>This is on the latest OS version of NonStop x86. The test is done via the
>following:
>With OpenSSL 3.4 The T0625 is Expat.
>
>When run as follows:
>GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true
>/usr/coreutils/bin/make -k test V=1 CFLAGS="-g -O2 -Winline -I/usr/local-
>ssl3.4/include -I/usr/coreutils/include
-I/usr/tandem/xml/T0625L01_AAE/include"
>LDFLAGS="/usr/coreutils/lib/libz.a
>-L/usr/local-ssl3.4/lib -L/usr/coreutils/lib
-L/usr/tandem/xml/T0625L01_AAE/lib"
>TEST_LINT= SHELL=/usr/coreutils/bin/bash
>
>The results are:
>*** t0000-basic.sh ***
>error: cannot run git init
>Makefile:77: recipe for target 't0000-basic.sh' failed
>make[2]: *** [t0000-basic.sh] Error 1
>*** t0001-init.sh ***
>error: cannot run git init
>Makefile:77: recipe for target 't0001-init.sh' failed
>make[2]: *** [t0001-init.sh] Error 1
>*** t0002-gitfile.sh ***
>error: cannot run git init
>Makefile:77: recipe for target 't0002-gitfile.sh' failed
>make[2]: *** [t0002-gitfile.sh] Error 1
>etc for all tests.
>
>Removing GIT_TEST_DEFAULT_REF_FORMAT=reftable allows the whole test suite
to
>pass.
>
>There are environment size limits (about 32Kb) in bash on the box, so it is
possible a
>boundary was crossed internal to the test setup.

I did find this, in t0000-basic:
not ok 69 - init with GIT_DEFAULT_REF_FORMAT=reftable
but have no more details. When should I break in gdb to get a backtrace?


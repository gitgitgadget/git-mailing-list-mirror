Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C01474A2
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734538055; cv=none; b=C/M4asFh4D23UtmoI8/Sxv+YpqYyK8KcAnrSxbC1n9rDFa1ZSFBl/C/NrZ8cn3hlFVx+joFCvGe+rkfmS/RDqQ7znvM6iBBxOhcZ5vHgYy1jxhYUMP9E8wDlMQWUc/P5mHdySdJvC25kblQipspQUvk2+NF1J3yj8vWTTT4wGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734538055; c=relaxed/simple;
	bh=othpYrY3lvGJQ+JkfL2tnsH+dkOrbCSaZmmbhRPHUuc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=I/ANAp3Cr+KhLFr4pKdZoxhPF/FZoBq6ip8tWojP/wazFZoqeA9fuU2y4x89Y28aiKOx18BYddAx1fyI9gP21UiP0D9Kuwuz+XOjeYN+Gq8kaZjgQCyubYQG0j7sIRcs1qP5G1UizthkvCzAoSbHDE+VRo1X4g7lRz4wKvGVh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BIG7MmW2033199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 16:07:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <xmqqfrmn4hr9.fsf@gitster.g> <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com> <Z2EC9rq3F0rTljff@pks.im> <010a01db508a$4544d750$cfce85f0$@nexbridge.com> <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com> <Z2JyFB3CddYM_LP4@pks.im>
In-Reply-To: <Z2JyFB3CddYM_LP4@pks.im>
Subject: RE: [ANNOUNCE] Git v2.48.0-rc0
Date: Wed, 18 Dec 2024 11:07:18 -0500
Organization: Nexbridge Inc.
Message-ID: <020701db5166$ed19b2c0$c74d1840$@nexbridge.com>
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
Thread-Index: AQFEfEaRNrZ6uu0wI6oVXmgPkoCy2gI/zh74AaCMqnQBl78GqAGqkn5VArNI4yqzyySw4A==
Content-Language: en-ca

On December 18, 2024 1:57 AM, Patrick Steinhardt wrote:
>On Tue, Dec 17, 2024 at 02:00:01PM -0500, rsbecker@nexbridge.com wrote:
>> On December 17, 2024 8:48 AM, I wrote:
>> >This is on the latest OS version of NonStop x86. The test is done via
>> >the
>> >following:
>> >With OpenSSL 3.4 The T0625 is Expat.
>> >
>> >When run as follows:
>> >GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true
>> >/usr/coreutils/bin/make -k test V=1 CFLAGS="-g -O2 -Winline
>> >-I/usr/local- ssl3.4/include -I/usr/coreutils/include
>> -I/usr/tandem/xml/T0625L01_AAE/include"
>> >LDFLAGS="/usr/coreutils/lib/libz.a
>> >-L/usr/local-ssl3.4/lib -L/usr/coreutils/lib
>> -L/usr/tandem/xml/T0625L01_AAE/lib"
>> >TEST_LINT= SHELL=/usr/coreutils/bin/bash
>> >
>> >The results are:
>> >*** t0000-basic.sh ***
>> >error: cannot run git init
>> >Makefile:77: recipe for target 't0000-basic.sh' failed
>> >make[2]: *** [t0000-basic.sh] Error 1
>> >*** t0001-init.sh ***
>> >error: cannot run git init
>> >Makefile:77: recipe for target 't0001-init.sh' failed
>> >make[2]: *** [t0001-init.sh] Error 1
>> >*** t0002-gitfile.sh ***
>> >error: cannot run git init
>> >Makefile:77: recipe for target 't0002-gitfile.sh' failed
>> >make[2]: *** [t0002-gitfile.sh] Error 1 etc for all tests.
>> >
>> >Removing GIT_TEST_DEFAULT_REF_FORMAT=reftable allows the whole test
>> >suite
>> to
>> >pass.
>> >
>> >There are environment size limits (about 32Kb) in bash on the box, so
>> >it is
>> possible a
>> >boundary was crossed internal to the test setup.
>>
>> I did find this, in t0000-basic:
>> not ok 69 - init with GIT_DEFAULT_REF_FORMAT=reftable
>
>You mean t0001-init.sh, right?
>
>> but have no more details. When should I break in gdb to get a backtrace?
>
>Can you please run that test with "-ix" and post the logs?

All tests, actually.

$ GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true sh
t0000-basic.sh --verbose -i -x
error: reftable: transaction prepare: out of memory
error: cannot run git init


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511A2375C
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3AED55
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 14:31:06 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A3LRsSe088491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Nov 2023 21:27:55 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc: "'Git List'" <git@vger.kernel.org>
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com> <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
In-Reply-To: <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
Subject: RE: Request for Help - Too many perl arguments as of 2.43.0-rc0
Date: Fri, 3 Nov 2023 17:30:59 -0400
Organization: Nexbridge Inc.
Message-ID: <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8AFPdmoJbSBrW69WyjYc4DVAhPQHKzdRFsBbiwXA=
Content-Language: en-ca

On November 3, 2023 4:52 PM, Eric Sunshine wrote:
>On Fri, Nov 3, 2023 at 3:03=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> I can no longer test git as the number of arguments (and size) sent =
to
>> perl from the make infrastructure is too big for my platform. Is it
>> possible to use xargs instead?
>
>Presumably you're talking about the invocation of chainlint.pl?
>Considering that that's quite an unimportant part of `make test` for =
those just
>running the test suite (as opposed to those authoring new tests), the =
simplest
>workaround is to disable chainlint when you run the tests by setting =
environment
>variable GIT_TEST_EXT_CHAIN_LINT to 0.

I tried both ways to specify this variable with no success:

/home/randall/git: make -C t/ all SHELL=3D/usr/coreutils/bin/bash =
GIT_TEST_EXT_CHAIN_LINT=3D0
make: Entering directory '/home/randall/git/t'
rm -f -r 'test-results'
/usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
Makefile:125: recipe for target 'test-lint-shell-syntax' failed
make: *** [test-lint-shell-syntax] Error 126
make: Leaving directory '/home/randall/git/t'
/home/randall/git: GIT_TEST_EXT_CHAIN_LINT=3D0 make -C t/ all =
SHELL=3D/usr/coreutils/bin/bash
make: Entering directory '/home/randall/git/t'
rm -f -r 'test-results'
/usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
Makefile:125: recipe for target 'test-lint-shell-syntax' failed
make: *** [test-lint-shell-syntax] Error 126
make: Leaving directory '/home/randall/git/t'



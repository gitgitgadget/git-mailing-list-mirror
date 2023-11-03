Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8624202
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069BCD55
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:04:27 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 3A3M1GEO093684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Nov 2023 22:01:16 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Eric Sunshine'" <sunshine@sunshineco.com>
Cc: "'Git List'" <git@vger.kernel.org>
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com> <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com> <00c301da0e9d$0d2cb8e0$27862aa0$@nexbridge.com> <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
In-Reply-To: <CAPig+cRG3VWgnwOPWvbW9boUooa6sD9d667wbSUe4_RkcR60vg@mail.gmail.com>
Subject: RE: Request for Help - Too many perl arguments as of 2.43.0-rc0
Date: Fri, 3 Nov 2023 18:04:21 -0400
Organization: Nexbridge Inc.
Message-ID: <00c401da0ea1$b61899c0$2249cd40$@nexbridge.com>
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
Thread-Index: AQH8AFPdmoJbSBrW69WyjYc4DVAhPQHKzdRFAXVVb+ICzGdHs6/03jVw
Content-Language: en-ca

On November 3, 2023 5:51 PM, Eric Sunshine wrote:
>On Fri, Nov 3, 2023 at 5:31=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>> On November 3, 2023 4:52 PM, Eric Sunshine wrote:
>> >On Fri, Nov 3, 2023 at 3:03=E2=80=AFPM <rsbecker@nexbridge.com> =
wrote:
>> >> I can no longer test git as the number of arguments (and size) =
sent
>> >> to perl from the make infrastructure is too big for my platform. =
Is
>> >> it possible to use xargs instead?
>> >
>> >Presumably you're talking about the invocation of chainlint.pl?
>> >Considering that that's quite an unimportant part of `make test` for
>> >those just running the test suite (as opposed to those authoring new
>> >tests), the simplest workaround is to disable chainlint when you run
>> >the tests by setting environment variable GIT_TEST_EXT_CHAIN_LINT to =
0.
>>
>> I tried both ways to specify this variable with no success:
>>
>> /usr/coreutils/bin/bash: /usr/bin/perl: Argument list too long
>> Makefile:125: recipe for target 'test-lint-shell-syntax' failed
>
>This is a separate issue from chainlint (though, it too will likely =
suffer the same
>problem). In this case, it's trying to run the =
check-non-portable-shell.pl script and
>the command-line is too long.
>Unfortunately, unlike chainlint for which there is a knob to disble it, =
there is no direct
>knob to disable `test-lint-shell-syntax`. You may be able to skip all =
the shell-script
>linting by setting TEST_LINT to an empty value.

That worked. I wonder whether it might be useful to set up a knob for =
this.


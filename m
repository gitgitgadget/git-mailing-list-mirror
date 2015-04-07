From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] t7300: add tests to document behavior of clean and
 nested git
Date: Tue, 07 Apr 2015 21:53:54 +0200
Message-ID: <552435D2.4040900@web.de>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>	<1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com> <CAPig+cQ9DD8BwG6-KDRqLzJSYh6O7c--GD0TR7-VAf_7PZx+Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?RXJpayBFbGZzdHLDtm0=?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZZW-0008Vs-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbbDGTyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 15:54:00 -0400
Received: from mout.web.de ([212.227.15.4]:50138 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbDGTx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 15:53:59 -0400
Received: from [192.168.2.107] ([79.223.100.247]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MhUcU-1Z2At71Tes-00Mffm; Tue, 07 Apr 2015 21:53:55
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cQ9DD8BwG6-KDRqLzJSYh6O7c--GD0TR7-VAf_7PZx+Zw@mail.gmail.com>
X-Provags-ID: V03:K0:6TduL90b5hqL3o2cw8BkeGp8X6YHg4mkJCo5zJHnfPlQo+LqgCR
 YeEyy9Bq+N+f8HxmpG1dzYpF3OZUoEbttoB+ld1CHqp1GlNYVbH5x/e+Ei9RDB0Ytlas+Xy
 fZwAfN5lBRWgssZxHVgLnK2ljp16pFUtVU5G3y/PJlJrL2632mORvoRVAgr3ZtsBKhsQSPi
 xBS2+BknHOZL2q404scsA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266936>

On 2015-04-07 21.40, Eric Sunshine wrote:
> On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> ---
>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index 99be5d9..cfdf6d4 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -455,6 +455,88 @@ test_expect_success 'nested git work tree' '
>> +test_expect_success 'giving path in nested git work tree will remov=
e it' '
>> +       rm -fr foo &&
>> +       mkdir foo &&
>> +       (
>> +               cd foo &&
>> +               git init &&
>> +               mkdir -p bar/baz &&
>> +               cd bar/baz &&
>> +               >hello.world
>=20
> In my earlier review, I utterly forgot to  mention the broken &&-chai=
n
> here and throughout the patch.
>=20
>> +               git add . &&
>> +               git commit -a -m nested
>> +       ) &&
Beside that, all "cd" commands should be done within an own sub-shell.
In other words, something like this:
		mkdir -p bar/baz &&
		(
               		cd bar/baz &&
               		>hello.world &&
               		git add . &&
               		git commit -a -m nested
		)
Side note:
Needed to drop Eric:
An error occurred while sending mail. The mail server responded:  Reque=
sted action not taken: mailbox unavailable
invalid DNS MX or A/AAAA resource record. Please check the message reci=
pient sunshine@sunshineco.com and try again.

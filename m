From: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 03 Jul 2014 07:56:58 +0200
Message-ID: <53B4F0AA.10809@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de> <53B46425.3030000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-15?Q?Torsten_B=F6ger?= =?ISO-8859-15?Q?shausen?= 
	<tboegi@web.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 03 07:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2a1h-0006m5-3o
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 07:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbaGCF5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 01:57:41 -0400
Received: from mout.web.de ([212.227.17.12]:62122 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbaGCF5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 01:57:40 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M57Ra-1Wi1Qy1EFC-00zC77; Thu, 03 Jul 2014 07:57:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53B46425.3030000@web.de>
X-Provags-ID: V03:K0:7xGKCsQ8NHhdRaVgaDr4owRUQoWjO2rkfJrN7iRAN9KXU2IIYWB
 IYFlmkoGFnfYct73VaR0XQdOwgMaIDRlMWsSrFvIjvHsyLiXbmfa3HQr4VqslexVlT9Iv4L
 4GjE2WexKKejLGZ6aAAnoNzltzgFAbDUOx6XTXsra6ch85MnAGqXtHGJ8pflXz7WWbFIunQ
 4EmXL4QOdJdQ/CM2AJwIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252855>

On 07/02/2014 09:57 PM, Jens Lehmann wrote:
> Am 02.07.2014 16:54, schrieb Torsten B=F6gershausen:
>> (Not sure if this is the right thread)
>> (I haven't checked if this is fixed in your latest version)
> Yes, this is the right thread and no, it isn't fixed yet.
>
>> On what I have on pu 7a0da7902cbbc9a876b90c9, Tue Jul 1 14:51:53 201=
4 -0700
>>
>> Many submodule tests are broken.
>> One problem is here:
>>
>> lib-submodule-update.sh:264: possible problem: echo -n is not portab=
le (please use printf):                     echo -n >sub1 &&
>> lib-submodule-update.sh:507: possible problem: echo -n is not portab=
le (please use printf):                     echo -n >sub1 &&
>>
>> You can remove the "empty" "echo -n" to create an empty file:
>>> sub1 &&
> Thanks for spotting and diagnosing this. Running "make lint" in the
> test directory only feeds the tests to check-non-portable-shell.pl,
> but not the *lib*.sh helper scripts, which made me miss this one.
>
> The following diff should fix it for you. Am I understanding you
> correctly that you are experiencing other failures too? I see no
> other incompatibilities when running ./check-non-portable-shell.pl
> on all the shell scripts in the repo.
The longer story is that I run the test suite once a week or so.
Most often under Mac OS, sometimes cygwin or Linux.
Whenever there is a breakage under Mac OS which I can not
debug within some minutes, I run it under Linux to see if there
is the same breakage.

The ./check-non-portable-shell.pl can sometimes give an indication
why some test fail.
You can run it from command line:
  ./check-non-portable-shell.pl *.sh
and it will find the "echo -n" which I reported.
On the longer run it could probably check all *.sh files,
not only the ones under t/
I do not have the time to test the snipped patch below, but I can check=
 pu
when the next round of your patch is in and give you some more info.

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/2] test results for v1.7.12-rc0 on cygwin
Date: Tue, 31 Jul 2012 18:38:55 +0100
Message-ID: <5018182F.5000501@ramsay1.demon.co.uk>
References: <50143379.8050500@ramsay1.demon.co.uk> <5014FAE6.7080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Jul 31 19:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwGS5-0006S7-EP
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 19:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab2GaRlo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 13:41:44 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:37788 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753547Ab2GaRln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 13:41:43 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id CB4C4128074;
	Tue, 31 Jul 2012 18:41:41 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 042BB128072;	Tue, 31 Jul 2012 18:41:41 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue, 31 Jul 2012 18:41:37 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <5014FAE6.7080009@lsrfire.ath.cx>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202661>

Ren=E9 Scharfe wrote:
> Am 28.07.2012 20:46, schrieb Ramsay Jones:
>> Unfortunately, I was unable to reproduce the final failure in t7810-=
grep.sh.
>> I tried, among other things, to provoke a failure thus:
>>
>>      $ for i in $(seq 100); do
>>      > if ! ./t7810-grep.sh -i -v; then
>>      >     break;
>>      > fi
>>      > done
>>      $
>>
>> but, apart from chewing on the cpu for about 50 minutes, it didn't r=
esult
>> in a failure. :(
>>
>> However, after looking at test 59, it seems to me to be a stale (red=
undant)
>> test. So, patch #2 removes that test! :-D [I wish I could reproduce =
the
>> failure because I don't like not knowing why it failed, but ...]
>=20
> Removing the test makes sense, since it was needed for --ext-grep onl=
y,=20
> is relatively expensive and a bit fragile (by depending on MAXARGS).

Indeed.

> I'm slightly worried about the non-reproducible failure, though.

Yep, me too.

> Perhaps a timing issue is involved and chances are higher if you leav=
e=20
> out the option -v?

Yes, one of the "among other things" I tried was to drop the -v, but th=
e
end result was the same. Also, since I have "DEFAULT_TEST_TARGET=3Dprov=
e"
in my config.mak, I tried:

    $ for i in $(seq 100); do
    > if ! prove --exec sh t7810-grep.sh; then
    >     break;
    > fi
    > done
    $

But again, it didn't provoke a failure (it did run quite a bit faster .=
=2E.).

I have now run this test file in excess of 600 times without failure in=
 the
last two evenings (taking about 5-6 hours wallclock time).
[I haven't come remotely close to running the test-suite 600 times on
cygwin in the last 6 years ...]

So, I'm out of ideas (and will stop trying to reproduce the failure).

ATB,
Ramsay Jones

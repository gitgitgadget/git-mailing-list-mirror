From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 16:37:37 +0200
Message-ID: <871tvl98we.fsf@fencepost.gnu.org>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
	<537DF7F2.8000401@web.de> <87a9aa7xxt.fsf@fencepost.gnu.org>
	<537E09AA.7030901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 22 16:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnU7v-0000Lb-LO
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 16:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbaEVOho convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2014 10:37:44 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:37612 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbaEVOhn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 May 2014 10:37:43 -0400
Received: from localhost ([127.0.0.1]:36649 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WnU7m-0005wS-DS; Thu, 22 May 2014 10:37:41 -0400
Received: by lola (Postfix, from userid 1000)
	id E5477E06C0; Thu, 22 May 2014 16:37:37 +0200 (CEST)
In-Reply-To: <537E09AA.7030901@viscovery.net> (Johannes Sixt's message of
	"Thu, 22 May 2014 16:28:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249908>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 5/22/2014 15:19, schrieb David Kastrup:
>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>=20
>>> On 2014-05-22 14.48, Elia Pinto wrote:
>>>> Found by check-non-portable-shell.pl
>>>
>>> Thanks for picking this up
>>>> -export TEST_DIRECTORY=3D$(pwd)/../../../t
>>>> +TEST_DIRECTORY=3D$(pwd)/../../../t && export TEST_DIRECTORY
>>> Minor remark:
>>> Both commands should go on their own line, like this:
>>>
>>> TEST_DIRECTORY=3D$(pwd)/../../../t &&
>>> export TEST_DIRECTORY
>>>
>>>
>>> And, unrelated to this patch,=20
>>> there seem to be a lot of && missing in git-remote-testgit.sh.
>>=20
>> I have a hard time taking the above && seriously.  pwd is a shell
>> builtin (when we are not talking about Version 3 UNIX or something) =
that
>> can hardly fail.  And when your shell does not support assignment to=
 a
>> shell variable, you'll have a hard time getting the shell script to =
run.
>
> The && after an assignment makes a big difference when the assignment=
 is
> part of an && chain. This is *very* common in our test suite, as you =
know.
>
> People tend to copy-and-paste. And then it is better to provide a mor=
e
> universally applicable precedent.

Copy-and-paste will not magically add the second && that would be
required for that usage, and the one in the line above might mislead yo=
u
into thinking that the problem "has been dealt with already".

So I'm not convinced that using && outside of a preexisting && chain
makes any sense in this context.

--=20
David Kastrup

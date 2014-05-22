From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 16:28:58 +0200
Message-ID: <537E09AA.7030901@viscovery.net>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>	<537DF7F2.8000401@web.de> <87a9aa7xxt.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu May 22 16:29:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTzZ-0006Mp-P4
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 16:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbaEVO3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 May 2014 10:29:05 -0400
Received: from so.liwest.at ([212.33.55.23]:57191 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbaEVO3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 10:29:04 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WnTzO-0001Rd-NG; Thu, 22 May 2014 16:28:58 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 66B9216613;
	Thu, 22 May 2014 16:28:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <87a9aa7xxt.fsf@fencepost.gnu.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249907>

Am 5/22/2014 15:19, schrieb David Kastrup:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>=20
>> On 2014-05-22 14.48, Elia Pinto wrote:
>>> Found by check-non-portable-shell.pl
>>
>> Thanks for picking this up
>>> -export TEST_DIRECTORY=3D$(pwd)/../../../t
>>> +TEST_DIRECTORY=3D$(pwd)/../../../t && export TEST_DIRECTORY
>> Minor remark:
>> Both commands should go on their own line, like this:
>>
>> TEST_DIRECTORY=3D$(pwd)/../../../t &&
>> export TEST_DIRECTORY
>>
>>
>> And, unrelated to this patch,=20
>> there seem to be a lot of && missing in git-remote-testgit.sh.
>=20
> I have a hard time taking the above && seriously.  pwd is a shell
> builtin (when we are not talking about Version 3 UNIX or something) t=
hat
> can hardly fail.  And when your shell does not support assignment to =
a
> shell variable, you'll have a hard time getting the shell script to r=
un.

The && after an assignment makes a big difference when the assignment i=
s
part of an && chain. This is *very* common in our test suite, as you kn=
ow.

People tend to copy-and-paste. And then it is better to provide a more
universally applicable precedent.

-- Hannes

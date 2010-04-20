From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff too slow for a file
Date: Tue, 20 Apr 2010 23:15:47 +0200
Message-ID: <4BCE1983.4020009@lsrfire.ath.cx>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx> <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx> <7vd3xuinbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 23:16:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4KnX-0007tv-TB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 23:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab0DTVPz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 17:15:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:55321 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0DTVPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 17:15:54 -0400
Received: from [10.0.1.100] (p57B7F4C7.dip.t-dialin.net [87.183.244.199])
	by india601.server4you.de (Postfix) with ESMTPSA id 8D9F52F805A;
	Tue, 20 Apr 2010 23:15:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vd3xuinbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145397>

Am 20.04.2010 09:40, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> For Linux, these 161 out of 178107 commits are affected:
>>
>>   90d49b4f  83f3c715  3b5dd52a  e97bd974  4e092d11  96b3c83d  4c96e8=
93
>>   ...
>>   22e2c507  e9edcee0  303b86d9  47b5d69c  2d7edb92  cb624029  f4f051=
eb
>>
>> I have briefly looked at a few of them.  They were big and not obvio=
us
>> with or without XDF_NEED_MINIMAL, but the flag clearly helped to cut
>> them down a bit.
>=20
> Thanks.
>=20
> I am getting the same impression after staring some output.
>=20
> Probably we should at least try to get rid of the use of MINIMAL
> immediately after 1.7.1 and if nobody finds large discrepancies, aim =
to
> ship 1.7.2 (and possibly 1.7.1.1) without even --quick/--slow options=
=2E

Turning XDF_NEED_MINIMAL off by default looks like the sane thing to do
in order to help the fringe cases without hurting the normal ones.

A --slow/--minimal/--try-harder option for git diff could come in handy
for longer patches, though.  GNU diff has it, too (-d/--minimal).

> I expect that there will also be some differences in the blame output=
=2E

I haven't looked at the impact on blame, but additionally patch IDs are
going to change (for those patches where XDF_NEED_MINIMAL makes a
difference).  Are they stored somewhere?  Do we need to worry about the=
m?

Ren=C3=A9

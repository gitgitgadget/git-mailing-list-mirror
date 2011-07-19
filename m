From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Tue, 19 Jul 2011 19:56:29 +0200
Message-ID: <4E25C54D.2070007@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <4E2477E1.5090406@gmail.com> <4E249C94.3040002@lsrfire.ath.cx> <4E24CBFD.9090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjEXM-00039C-JP
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab1GSR4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jul 2011 13:56:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:53532 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1GSR4q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:56:46 -0400
Received: from [192.168.2.106] (p4FFDA167.dip.t-dialin.net [79.253.161.103])
	by india601.server4you.de (Postfix) with ESMTPSA id DAEB22F802D;
	Tue, 19 Jul 2011 19:56:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E24CBFD.9090909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177486>

Am 19.07.2011 02:12, schrieb Neal Kreitzinger:
> On 7/18/2011 3:50 PM, Ren=C3=A9 Scharfe wrote:
>> Am 18.07.2011 20:13, schrieb Neal Kreitzinger:
>>> However, the permissions also need to change to 777 and tar --mode =
would
>>> not effect this in combination with --catenation or -x.  Is there a=
 way
>>> I can change the permissions without having to untar->chmod->retar,=
 and
>>> without having to use a non-bare repo as an intermediary?
>>
>> You can use the configuration setting tar.umask to affect the
>> permissions of the archive entries.  Set it to 0 to pass the permiss=
ion
>> bits from the repo unchanged.
>>
> The permissions in my repo are 775 and 664 and I want to change them =
to
> 777.

Git doesn't store all permission bits.  If a file is marked as
executable then you get 777, otherwise 666 -- minus the umask, which is
0002 by default.  So in order to achive rwx permissions for all in the
archive, you need to A) mark the files as executable in the repository
and B) set tar.umask to 0 to get allow the world to write.

However, what's the reason for requiring this lack of access control?
Why o+w?

Ren=C3=A9

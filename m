From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Tue, 09 Mar 2010 17:49:58 +0100
Message-ID: <4B967C36.90309@lsrfire.ath.cx>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>	 <4B9504C9.5000703@lsrfire.ath.cx> <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 17:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np2dL-0005Dq-1E
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 17:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab0CIQuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 11:50:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:48401 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab0CIQuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 11:50:07 -0500
Received: from [10.0.1.100] (p57B7E5ED.dip.t-dialin.net [87.183.229.237])
	by india601.server4you.de (Postfix) with ESMTPSA id C6FF32F80D5;
	Tue,  9 Mar 2010 17:50:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141831>

Am 08.03.2010 15:32, schrieb Nguyen Thai Ngoc Duy:
> On 3/8/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>>  I'm not so sure about the interface, though.  Does the task really
>>  warrant adding a new git command?
>=20
> Several reasons:
>  - Can be reused outside of git (I was surprised Solaris did not have=
 "column")

Granted, we have a precedent: git stripspace.  But I don't like that
one, either. ;)  If it's not specific to git, then it should not be a
git command.

Perhaps name it git-column--helper, so that it can still be used by git
commands that are implemented as scripts?

>  - Easier to test

Name it test-column?

>  - Minimum code change in modifed commands

OK, forking out is easy, but replacing printf() calls with calls to fee=
d
the columnizer shouldn't be _that_ intrusive, either.

>  - I can play with more complicated column layout, with minimum code
> change in git (ok, that's the third reason).

This is possible regardless of the way how the columnizer is invoked if
its full functionality is exposed through the command line parameter.

With "more complicated", do you perhaps mean what GNU ls does, namely
having non-uniform column widths?  I never consciously noticed that it
actually goes out of its way to cram as may columns on the screen as
possible, it just feels so natural. :)

>>  If a --column parameter is added, I think it should expose the full
>>  range of options, i.e. fill columns first (ls -C style), fill rows =
first
>>  (ls -x style) as well as off (ls -1 style) and auto.
>=20
> Maybe an env variable would be better, so you can pass abitrary
> arguments to git-column. "--column=3Dauto" should be supported, of
> course.

I don't see any benefit of an environment variable over config options.

Ren=C3=A9

From: Kevin Ballard <kevin@sb.org>
Subject: Re: What is 'git BRANCH'?
Date: Tue, 29 Jul 2008 15:32:51 -0700
Message-ID: <DEBF93FC-BA8D-4513-B4EE-A8648DA1D591@sb.org>
References: <g6o4vi$rap$1@ger.gmane.org> <7vej5cba6z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jurko_Gospodneti=C4=87?= <jurko.gospodnetic@docte.hr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 00:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNxlw-00045H-1l
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbYG2WdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2008 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbYG2WdX
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 18:33:23 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:54184 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755337AbYG2WdW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 18:33:22 -0400
Received: from [192.168.1.80] (adsl-76-199-69-6.dsl.pltn13.sbcglobal.net [76.199.69.6])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id F21E5109E8B;
	Tue, 29 Jul 2008 15:33:21 -0700 (PDT)
In-Reply-To: <7vej5cba6z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90695>

On Jul 29, 2008, at 3:24 PM, Junio C Hamano wrote:

> Jurko Gospodneti=C4=87 <jurko.gospodnetic@docte.hr> writes:
>
>>  Hi.
>>
>>  I typed in "git BRANCH" by accident and got the error message:
>> "fatal: cannot handle BRANCH internally".
>>
>>  What does that mean?
>>
>>  It is different from the usual "git: 'yada-yada' is not a
>> git-command. See 'git --help'." message you get when you type in an
>> incorrect command name.
>
> Just a guess; your git is installed on a case-challenged filesystem?

 From what I can tell, this happens when you execute one of the git-* =20
builtin binaries using a name that doesn't actually match the binary, =20
case-sensitively. When you type `git BRANCH` on OS X, git matches that =
=20
against the git-branch binary and executes it, but argv[0] contains =20
"git-BRANCH". When this is compared by the git-branch binary to the =20
list of internal commands, it comes up empty, and the fallback code =20
(to die with "fatal: cannot handle BRANCH internally") gets executed =20
instead.

In other words, this is identical to running `/usr/local/libexec/git-=20
core/git-BRANCH` or to doing something like `exec -a git-BRANCH /usr/=20
local/libexec/git-core/git-branch` (this example should work on any =20
filesystem).

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com

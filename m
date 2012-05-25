From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Fri, 25 May 2012 09:50:15 +0200
Message-ID: <87ehq8its8.fsf@thomas.inf.ethz.ch>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl> <7v4nr72bim.fsf@alter.siamese.dyndns.org>
	<CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
	<CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
	<CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
	<4FBD5CC1.3060701@tedpavlic.com> <20120524203549.GA2052@goldbirke>
	<CAOnadRFbrhrFz7Ya3Vhgsju9G723Qu0OdJnM31xFmBqQNgj6gA@mail.gmail.com>
	<20120525073506.GD2052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Dan McGee <dan@archlinux.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	<git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 25 09:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXpI2-0005V5-1l
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 09:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab2EYHuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 03:50:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25480 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab2EYHuU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 03:50:20 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 25 May
 2012 09:50:17 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 25 May
 2012 09:50:17 +0200
In-Reply-To: <20120525073506.GD2052@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of
	"Fri, 25 May 2012 09:35:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198469>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Thu, May 24, 2012 at 11:36:45PM -0400, Ted Pavlic wrote:
>> > You mean a real git command, which does the same as __gitdir()?  I
>> > don't like that, because it will always require 2 fork()s and an
>> > exec() and would be slow on Windows.
>>=20
>> Interesting. I guess I didn't realize bash completion was an issue f=
or most
>> Windows users. Is it?
>
> It is.  Emulating fork() and exec() is very expensive, so every
> subshell, external command, or especially git command in a command
> substitution costs dearly.  And the completion script uses many git
> commands and even more subshells.
>
> Case in point is __git_ps1() and __gitdir().  There are scenarios
> where displaying the git-specific bash prompt takes more than 400ms o=
n
> Windows, while displaying the same prompt takes only about 26ms on
> Linux on the same hardware.
>
>   http://thread.gmane.org/gmane.comp.version-control.git/197432

Why not make a git builtin command that figures out everything that
__git_ps1 does?  Perhaps in a format that can be eval'd and processed t=
o
the user's taste.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch

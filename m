From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 22:40:56 +0100
Message-ID: <3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801072115120.10101@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 22:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBzi6-0003OB-FS
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 22:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758812AbYAGVkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 16:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758780AbYAGVkM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 16:40:12 -0500
Received: from mailer.zib.de ([130.73.108.11]:45631 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758754AbYAGVkL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2008 16:40:11 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m07LdpZ5021264;
	Mon, 7 Jan 2008 22:39:51 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m07LdpJm019122
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 7 Jan 2008 22:39:51 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801072115120.10101@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69814>


On Jan 7, 2008, at 10:18 PM, Johannes Schindelin wrote:

> Hi,
>
> [msysGit Cc'ed, since it is massively concerned by this thread]
>
> On Mon, 7 Jan 2008, Robin Rosenberg wrote:
>
>> m=E5ndagen den 7 januari 2008 skrev du:
>>> Problem.  There is not a single "right".  It really depends on the
>>> project.
>>
>> Indeed, but the most common SCM's detect binary files automatically,
>> either by suffix or content analysis, so I think that is what user's
>> expect. It will be right for more projects than the current =20
>> behaviour.
>
> Steffen also fought for turning this on by default, but so far I =20
> resisted.
> For a good reason: the primary user of msysGit for the moment is...
> msysGit.  And this project does not need CR for obvious reasons.
>
> But I imagine that it makes sense for the Git installers.  Colour me
> no-longer-resisting.

Eventually I gave in and even voted for "Git does not modify
content unless explicitly requested otherwise".

Here's the full discussion:

http://code.google.com/p/msysgit/issues/detail?id=3D21

I believe the main question is which type of projects we would like
to support by our default.  For real cross-platform projects that will
be checked out on Windows and Unix we should choose
"core.autocrlf true" as our default.  But if our default are native
Windows projects that will never be checked out on Unix, then we
should not set core.autocrlf by default.

I once fought for "real cross-platform", because this is what I need
in my daily work.  Note, however, that this setting bears the slight
chance of git failing to correctly detect a binary file.  In this case
git would corrupt the file.  So there is a tiny chance of data loss
with "core.autocrlf true".  The safest choice is to leave core.autocrlf
unset.

	Steffen

From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 09:35:13 +0300
Message-ID: <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 08:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSmK-0000Fs-R4
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760459AbXHXGgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 02:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763569AbXHXGgM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:36:12 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:47700 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763721AbXHXGgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 02:36:11 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JN900DKEMC1VL00@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 24 Aug 2007 09:36:01 +0300 (EEST)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JN900GPBMC99C90@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 24 Aug 2007 09:36:09 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id F213A1FB3DB; Fri,
 24 Aug 2007 09:35:49 +0300 (EEST)
In-reply-to: <20070823203246.GB3516@steel.home>
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.784,
 required 5, autolearn=not spam, AWL 0.22,	BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56552>

On Aug 23, 2007, at 23:32, Alex Riesen wrote:

> V=E4in=F6 J=E4rvel=E4, Thu, Aug 23, 2007 21:58:31 +0200:
>> With this flag, the user can choose to filter untracked files from =20
>> the
>> status output. This can be used to either speed up the status =20
>> output, as
>> the untracked files are not fetched at all, or to just cleanup the
>> output without using gitignore.
>
> "git diff -r --name-status; git diff --cached -r --name-status" is =20
> not enough?

That line will result in duplicate entries, if files are staged, and =20
the output of git-status is neater (but longer) in my opinion.

"""
M       Makefile
M       Makefile
"""
vs.
"""
# On branch entity_class
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   Makefile
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   Makefile
#
# Untracked files were filtered by "--only-tracked"
"""

Sure you could remove duplicate entries with "sort|uniq", or =20
something, but just running "git status --only-tracked", is cleaner, =20
and more user friendly.

The way I see the flag used is: A user runs "git status", sees that =20
there is too much untracked files and not enough scrollback, so he =20
runs "git status --only-tracked" to filter the results.

--
V=E4in=F6

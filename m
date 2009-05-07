From: "Bevan Watkiss" <bevan.watkiss@cloakware.com>
Subject: RE:
Date: Thu, 7 May 2009 14:48:20 -0400
Message-ID: <D47BEC5B0D55467894A05B6219127126@caottdt504>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <81b0412b0905071118q46eb98b0k20f148e6a179a81f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Alex Riesen'" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M28gd-0001DM-RQ
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbZEGSvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbZEGSvD
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:51:03 -0400
Received: from mail.cloakware.com ([142.46.212.116]:33751 "EHLO
	mail.cloakware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZEGSvB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 14:51:01 -0400
Received: from caottdt504 (bwatkiss-desk.cloakware.com [172.20.201.170])
	(authenticated bits=0)
	by mail.cloakware.com (8.13.1/8.13.1) with ESMTP id n47Ip0Bf026000;
	Thu, 7 May 2009 14:51:00 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Thread-Index: AcnPQCkHH3eUtJmnT8mII5LseKbbCwAA0jtQ
In-Reply-To: <81b0412b0905071118q46eb98b0k20f148e6a179a81f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118503>

Still took 11 minutes.

The idea I've come up with today is something along the lines of
git fetch origin/master
git log --name-only ..<hash> | xargs git checkout -f --

This should work to quickly keep my files upto date, and I can then
periodically pull properly to move the HEAD.

Thanks for the info

Bevan

-----Original Message-----
=46rom: Alex Riesen [mailto:raa.lkml@gmail.com]=20
Sent: May 7, 2009 2:18 PM
To: Bevan Watkiss
Cc: git@vger.kernel.org
Subject: Re:

2009/5/7 Bevan Watkiss <bevan.watkiss@cloakware.com>:
> It's the looking for local changes I'm trying to avoid. =A0Doing a re=
set
still
> goes over the tree, which isn't helpful.

The stat(2) is slow? Then try setting core.ignoreStat (see manpage
of git config) to true: git config core.ignorestat true
and read below.

> Basically I have a copy of my tree where only git can write to it, so=
 I
know
> the files are right. =A0The NAS box I have the tree on is slow, so re=
ading
the
> tree adds about 10 minutes to the process when I only want to update =
a few
> files.

Try "git checkout origin/master". It uses index and shouldn't checkout =
files
which are uptodate with the index. And actually, git merge should
fast-forward,
in your case and will update just the changed files...

Of course, you can always compare HEAD and origin/master, and resolve
the changes yourself (see git diff -z --name-status), but it is unlikel=
y to
be
any faster.

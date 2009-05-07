From: "Bevan Watkiss" <bevan.watkiss@cloakware.com>
Subject: RE:
Date: Thu, 7 May 2009 13:26:29 -0400
Message-ID: <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "'Alex Riesen'" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27PK-0003fQ-Ez
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbZEGR3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 13:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbZEGR3K
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:29:10 -0400
Received: from mail.cloakware.com ([142.46.212.116]:60771 "EHLO
	mail.cloakware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZEGR3K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 13:29:10 -0400
Received: from caottdt504 (bwatkiss-desk.cloakware.com [172.20.201.170])
	(authenticated bits=0)
	by mail.cloakware.com (8.13.1/8.13.1) with ESMTP id n47HT9ZB005134;
	Thu, 7 May 2009 13:29:09 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Thread-Index: AcnPNzJAH6VfW9oJRUiS3+YFj3mQyAAAIm/Q
In-Reply-To: <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118497>

It's the looking for local changes I'm trying to avoid.  Doing a reset =
still
goes over the tree, which isn't helpful.

Basically I have a copy of my tree where only git can write to it, so I=
 know
the files are right.  The NAS box I have the tree on is slow, so readin=
g the
tree adds about 10 minutes to the process when I only want to update a =
few
files.

-----Original Message-----
=46rom: Alex Riesen [mailto:raa.lkml@gmail.com]=20
Sent: May 7, 2009 1:14 PM
To: Bevan Watkiss
Cc: git@vger.kernel.org
Subject: Re:

2009/5/7 Bevan Watkiss <bevan.watkiss@cloakware.com>:
> I am trying to create a working tree for people to read from and have=
 it
> update from a bare repository regularly.=A0 Right now I am using git-=
pull to
> fetch the changes, but it=92s running slow due to the size of my repo=
 and
the
> speed of the hardware as it seems to be checking the working tree for=
 any
> changes.
>
> Is there a way to make the pull ignore the local working tree and onl=
y
look
> at files that are changed in the change sets being pulled?

Assuming you didn't modify that directory you pull into,
git pull will do almost exactly what you described. Almost,
because the operation (the merge) will involve looking for local
changes (committed and not).

It should be faster to do something like this:

  git fetch && git reset --hard origin/master

Again, assuming the directory supposed to be read-only.
Otherwise, you have to merge (i.e. git pull).

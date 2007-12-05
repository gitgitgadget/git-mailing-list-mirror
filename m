From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: How to jump between two repositories ...
Date: Wed, 05 Dec 2007 08:20:18 +0200
Message-ID: <3DD4D3BA-67B3-4AFC-AD24-799384D54408@pp.inet.fi>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izncs-0007JH-Kn
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbXLEGUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 01:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbXLEGUe
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:20:34 -0500
Received: from astana.suomi.net ([82.128.152.18]:36207 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbXLEGUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 01:20:33 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JSK00362C61RJ00@astana.suomi.net> for
 git@vger.kernel.org; Wed, 05 Dec 2007 08:18:01 +0200 (EET)
Received: from spam5.suomi.net (spam5.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSK004MQCA7NF30@mailstore.suomi.net> for git@vger.kernel.org;
 Wed, 05 Dec 2007 08:20:31 +0200 (EET)
Received: from Kaalimaa.fudeco.com (unknown [213.139.166.27])
	by spam5.suomi.net (Postfix) with ESMTP id CAD722FE4F; Wed,
 05 Dec 2007 06:20:18 +0000 (UTC)
In-reply-to: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
X-Mailer: Apple Mail (2.915)
X-OPOY-MailScanner-Watermark: 1197440419.1485@mD6KTulSYDW5L4KFh23uJA
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=0.1,
	required 5, AWL -0.00, RDNS_NONE 0.10)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67106>

On Dec 5, 2007, at 07:59, g2 wrote:

> I am currently working on some code at the office that I also want =20
> to work with at home. Seems like a good candidate for git. So I =20
> created a repository at work and did a "git clone" at home. I've run =
=20
> into some strange behaviour that I don't understand and would =20
> appreciate if someone can clarify for me.
>
> Imagine this scenario. At work:
> git init
> edit test.c
> git add test.c
> git commit
>
> Then at home:
> git clone <work git url>
> edit test.c
> git commit -a
> git push
>
> At this point, I wanted to push my changes back to my work =20
> repository so I can continue work the next day. So at home, I did a =20
> git push. I expect that my work repository has the newest material, =20
> but I find that when I do "git status" at work the next day, it =20
> tells me that my test.c is "modified" and has already staged it for =20
> commit. I need to do a "git reset" followed by "git checkout" to =20
> update my work folder to the latest stuff.

Did you clone a bare repository and push to it?

Here is an excerpt from Git User's Manual:
"Note that the target of a "push" is normally a bare repository. You =20
can also push to a repository that has a checked-out working tree, but =
=20
the working tree will not be updated by the push. This may lead to =20
unexpected results if the branch you push to is the currently checked-=20
out branch!"

So to push to your work repository, you should create an intermediary =20
repository between the work and home repositories. You can create it =20
by running:
$ git clone --bare /git/work/ /git/work.git/

Then you clone normally from the bare repository and pushing to it =20
works fine. After you have pushed your changes to the bare repository, =
=20
you'll have to pull them to the work repository to get the updates, =20
just like you would do with any public repository.

Another option would be to pull from your home repository to the work =20
repository, if you can access your home computer from the work computer=
=2E

--
V=E4in=F6

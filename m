From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 10:04:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902250957260.3111@localhost.localdomain>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcO9M-0006bd-7i
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbZBYSE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZBYSE7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:04:59 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51444 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753630AbZBYSE6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 13:04:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PI4MtV006090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 25 Feb 2009 10:04:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1PI4Mrd028091;
	Wed, 25 Feb 2009 10:04:22 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.451 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111474>



On Wed, 25 Feb 2009, John Dlugosz wrote:
>
> I'm working with a group, and using git for source code.=A0 I need to=
=20
> change a couple files temporarily and just for me.=A0 I thought, "tha=
t's=20
> easy", just don't stage them when I check in changes.=A0 But, what do=
 I do=20
> when I pull changes from others?=A0 I think it will complain that I h=
ave=20
> unsaved changes.

If your changes do not touch any of the files that the "git pull" updat=
es,=20
then everything is fine. The pull will just work, and your changes will=
=20
still exists in your tree. This is not an accident - git was very much=20
designed to work that way, because it's a common usage case for me.

I often have some trivial small changes in my tree (like a pending chan=
ge=20
to the top-level Makefile for the next version number that I just haven=
't=20
committed yet - just a reminder to myself that I'm soon about to releas=
e=20
another -rc). And I still want to continue to do "git pull" to fetch=20
stuff, or even "git am -s" to apply patches.

HOWEVER. If the pull actually wants to modify a file that you have chan=
ged=20
(ie that same file was changed in the remote), then "git pull" will fai=
l=20
gracefully after having done the fetch, saying something like

	Entry 'file-name' not uptodate. Cannot merge.

and at that point you have to decide whethe you want to commit the chan=
ge,=20
"stash" it, or just undo it. Or whether you don't want to do the merge=20
yet because you're still working on your own changes, and don't want th=
e=20
distraction.

		Linus

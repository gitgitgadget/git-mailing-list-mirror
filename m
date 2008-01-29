From: Sean <seanlkml@sympatico.ca>
Subject: Re: Can git log <file> follow log of its origins?
Date: Tue, 29 Jan 2008 13:17:09 -0500
Message-ID: <BAYC1-PASMTP0711D909B278C305D7F28AAE350@CEZ.ICE>
References: <333479.13589.qm@web45901.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Max Pollard <ajaxsupremo@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJv1q-0001X0-1E
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 19:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbYA2SRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 13:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbYA2SRO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 13:17:14 -0500
Received: from bay0-omc2-s12.bay0.hotmail.com ([65.54.246.148]:7496 "EHLO
	bay0-omc2-s12.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750825AbYA2SRN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 13:17:13 -0500
Received: from BAYC1-PASMTP07 ([65.54.191.167]) by bay0-omc2-s12.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 29 Jan 2008 10:17:12 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP07.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 29 Jan 2008 10:17:11 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JJv13-0007jz-5q; Tue, 29 Jan 2008 13:17:01 -0500
In-Reply-To: <333479.13589.qm@web45901.mail.sp1.yahoo.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i686-pc-linux-gnu)
X-OriginalArrivalTime: 29 Jan 2008 18:17:11.0786 (UTC) FILETIME=[2AD51CA0:01C862A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71985>

On Tue, 29 Jan 2008 09:48:05 -0800 (PST)
Max Pollard <ajaxsupremo@yahoo.com> wrote:

> If I do the following:
> 
>      $ git init
>      $ echo "The brown fox is getting old" > a.txt
>      $ git add a.txt
>      $ git commit -m "Commit a.txt"
> 
>      $ cp a.txt b.txt
>      $ git add b.txt
>      $ git commit -m "Copy a.txt to b.txt"
> 
>      $ git log b.txt
> 
> I only see the log corresponding to the 2nd commit (v1.5.3.5).  Is it possible
> to have the above command keep going and show the history of a.txt?  Or at
> least somehow indicate that b.txt originated from a.txt?

Hi Max,

Not sure it will leave you feeling totally satisfied but the
following command will at least show you the copy which
occurred in that commit:

$ git log --full-diff -C --find-copies-harder --stat -- b.txt
commit 578ecbc516e70ce7178545233192a08369a07101
Author: xyz <x@y.z>
Date:   Tue Jan 29 13:11:16 2008 -0500

    Copy a.txt to b.txt

 a.txt => b.txt |    0 
 1 files changed, 0 insertions(+), 0 deletions(-)

If you had done a rename instead of a copy, then "git log --follow b.txt" would
have done what you're looking for, but there is no corresponding option to
follow copies.

HTH,
Sean

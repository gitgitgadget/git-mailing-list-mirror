From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: Avoid an error message in the map function.
Date: Wed, 04 Jul 2007 13:45:22 +0200
Organization: eudaptics software gmbh
Message-ID: <468B8852.CB36968@eudaptics.com>
References: <11835356473029-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0707041205250.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:45:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I63I3-0000OJ-CF
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828AbXGDLo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758753AbXGDLo4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:44:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49537 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758746AbXGDLoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:44:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I63Hu-0004aK-Qs; Wed, 04 Jul 2007 13:44:51 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2A1E86EF; Wed,  4 Jul 2007 13:44:48 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.723, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51597>

Johannes Schindelin wrote:
> 
> Hi,
> 
> On Wed, 4 Jul 2007, Johannes Sixt wrote:
> 
> > -     test -r "$workdir/../map/$1" || echo "$1"
> > -     cat "$workdir/../map/$1"
> > +     test -r "$workdir/../map/$1" &&
> > +     cat "$workdir/../map/$1" ||
> > +     echo "$1"
> 
> I think this does not do what you want. If I read it correctly, it will
> not do anything if $workdir/../map/$1 is not readable. I think you need
> this:
> 
>         (test -r "$workdir/../map/$1" &&
>         cat "$workdir/../map/$1") ||
>         echo "$1"
> 
> But that is a little too cute, so I personally would prefer an
> if-then-else-fi, because that is the idea of that code snippet.

It does do what I think it should do. I tested it. Your elaborate
version is not required. The reason is that in the shell && and || have
equal precedence; if there is ... && cmd ... then cmd is run if the most
recent result is success, and if there is ... || cmd ... then cmd is run
if the most recent result is failure; in both cases cmd is otherwise
skipped and does not count as "most recent result".

-- Hannes

From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] git-rev-list.txt: rev stands for revision, not reverse.
Date: Fri, 2 Nov 2007 19:55:10 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071102185509.GA5242@ins.uni-bonn.de>
References: <20071101084552.GA4934@ins.uni-bonn.de> <7vr6j9bv80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 19:55:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1gI-00027Z-Sg
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 19:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbXKBSzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757427AbXKBSzP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 14:55:15 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:44906 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757526AbXKBSzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 14:55:13 -0400
Received: from localhost.localdomain (xdsl-87-78-90-64.netcologne.de [87.78.90.64])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 322A84000048D;
	Fri,  2 Nov 2007 19:55:11 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Io1fi-0001Mq-5D; Fri, 02 Nov 2007 19:55:10 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6j9bv80.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63155>

Hello Junio,

* Junio C Hamano wrote on Thu, Nov 01, 2007 at 08:51:11PM CET:
> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
> 
> > Yes, believe it or not, but I stumbled over the synopsis
> >
> > | git-rev-list - Lists commit objects in reverse chronological order
> >
> > asking myself whether rev could possibly mean "reverse".
> > I hope this helps avoid this pitfall for others.
> 
> In addition to your patch,
> 
> 	git-rev-list - List commits from most recent to older
> 
> might be a good rewording?

Is the reverse chronological order the primary sorting key at all?
My clone of the git repo gives me

$ git rev-list --pretty=format:%ct master | grep -v ^commit >A
$ sort -k1nr A | diff -u - A
--- -   2007-11-02 18:06:00.115804000 +0100
+++ A   2007-11-02 18:05:37.000000000 +0100
@@ -8162,8 +8162,8 @@
 1141461106
 1141461098
 1141461088
-1141457404
 1141457396
+1141457404
 1141453772
 1141453757
 1141453684

Interestingly, --date-order shows another inconsistency:

$ git rev-list --date-order --pretty=format:%ct master | grep -v ^commit >Ad
$ sort -k1nr Ad | diff -u - Ad
--- -   2007-11-02 18:27:18.091006000 +0100
+++ Ad  2007-11-02 18:25:46.000000000 +0100
@@ -653,8 +653,8 @@
 1188812406
 1188808117
 1188770606
-1188716400
 1188716027
+1188716400
 1188677727
 1188668216
 1188644991
@@ -8162,8 +8162,8 @@
 1141461106
 1141461098
 1141461088
-1141457404
 1141457396
+1141457404
 1141453772
 1141453757
 1141453684

This is "git version 1.5.3.5.474.g3e4bb", both repo and executables.

It looks like there is either a bug or the sorting criterion is subtly
different.

> "rev-list --reverse" reverses that usual order and we end up
> explaining double reversal if we use the phrase "reverse chronological
> order" to describe the normal order.

Well, I'd say the current synopsis would be fine if the default ordering
really were the commit date.  The synopsis should be concise, it's good
enough if the Description clears potential doubts.

Cheers,
Ralf

From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Sun, 05 Aug 2007 16:46:32 +0200
Message-ID: <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhNO-0004Op-HF
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbXHEOqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbXHEOqf
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:46:35 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:35362 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbXHEOqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:46:34 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMB003W32DK45@psmtp09.wxs.nl> for git@vger.kernel.org; Sun,
 05 Aug 2007 16:46:33 +0200 (MEST)
Received: (qmail 31051 invoked by uid 500); Sun, 05 Aug 2007 14:46:32 +0000
In-reply-to: <46B4A350.9060806@tromer.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55027>

On Sat, Aug 04, 2007 at 12:03:28PM -0400, Eran Tromer wrote:
> Works here: it silences the check and allows switching branches. Still,
> leaving the working tree dirty can inadvertently affect subsequent
> commits. Consider the most ordinary of sequences:
> 
> $ git checkout experimental-death-ray
> $ git submodules update
> (return a week later, woozy from the vacation.)
> $ git checkout master

Here, it'll warn that your submodule isn't up-to-date.

> (hack hack hack)
> $ git commit -a -m "fixed typos"

And if you run "git status" first, it'll tell you that the submodule
(still) isn't up-to-date.

> $ git push
> (Oops. You've just accidentally committed the wrong submodule heads.)

You always have to be careful when doing "git commit -a".

> Another approach is for pull, checkout etc. to automatically update the
> submodule' head ref, but no more.

Then everything, including "git submodule update", would assume
that the submodule is up-to-date.

skimo

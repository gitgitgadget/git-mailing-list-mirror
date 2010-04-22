From: Johan Herland <johan@herland.net>
Subject: Re: 'git notes merge' implementation questions
Date: Thu, 22 Apr 2010 10:38:25 +0200
Message-ID: <201004221038.25487.johan@herland.net>
References: <201004210957.48138.johan@herland.net>
 <201004220208.03706.johan@herland.net>
 <7vzl0w730b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 10:38:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4rve-000881-Eq
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 10:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0DVIi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 04:38:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41407 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073Ab0DVIi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 04:38:27 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19000P7S02UT60@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 10:38:26 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L1900A2DS01CG20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 10:38:26 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.22.82715
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <7vzl0w730b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145511>

On Thursday 22 April 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Next, we will need to be somewhat careful about using "ls-tree", to
> > avoid needlessly unpacking subtrees that are identical between <ours>
> > and <theirs>.
> 
> My mentioning of "ls-tree" is only about what needs to be done at the
> conceptual level.  In practice, assuming that notes trees have mostly the
> same fan-out structure, you would run "diff-tree -r" of (base,ours) and
> (base,theirs) pair _without_ anything fancy like rename detection, and
> pick out pieces (one tree may have ab/cdx{36} while the other tree may
> have abcd/x{36} that are notes about the same object---you treat this as
> if it is a partial ls-tree output that pertains only to the different
> parts, and make canonical "list of annotated objects" by removing '/'.

Got it. Brilliant, and obvious, really, when I think about it...

> All of this is very specific to merging "notes" and normal "merge" does
> not even want to know about it; I don't think you can avoid doing this
> yourself without touching "merge" if you want to merge "notes" correctly.

Agreed. From your feedback, I now have a much clearer picture on how to 
proceed. Thanks! :)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

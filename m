From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 14:33:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net> <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain>
 <7vtz2x6mor.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBy66-0002uV-RT
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754138AbZFCVd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbZFCVd6
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:33:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53050 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753700AbZFCVd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 17:33:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53LXefk031033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Jun 2009 14:33:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n53LXdOo007902;
	Wed, 3 Jun 2009 14:33:39 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vtz2x6mor.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120646>



On Wed, 3 Jun 2009, Junio C Hamano wrote:
> 
> E.g. "git log --graph --oneline -- git-clone.sh" shows that the scripted
> version ceased to exist at 8434c2f

Btw, this example misses the whole point of the original problem.

The original problem was:

 - create new file 'x' in branch 'a'

 - merge branch 'a' into branch 'b', but because of a merge conflict and 
   confurion in the merge, the merge result doesn't contain 'x' any more.

 - try to find out what happened to 'x' after-the-fact.

Try it. Git really doesn't make it very easy, because git will notice that 
'x' didn't exist before the branch either (in branch 'b'), so there will 
be _no_ sign of 'x' actually going away.

			Linus

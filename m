From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sort of a feature proposal
Date: Wed, 7 May 2008 09:25:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805070924300.3024@woody.linux-foundation.org>
References: <86fxsutbke.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed May 07 18:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmUK-0008CU-4W
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbYEGQ0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYEGQ0i
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:26:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58437 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754172AbYEGQ0h (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 12:26:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m47GPuSg012252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2008 09:25:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m47GPtkH005529;
	Wed, 7 May 2008 09:25:56 -0700
In-Reply-To: <86fxsutbke.fsf@lola.quinscape.zz>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.428 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81462>



On Wed, 7 May 2008, David Kastrup wrote:
> 
> Hi, I have some large git repositories on a USB drive (ext3 file
> system).  That means that when replugging the drive, the recorded st_dev
> data in the index is off, meaning that the whole repo directory
> structure gets reread as the stat data of all directories has changed.
> 
> That's a nuisance.  Can't we have some heuristic or configuration option
> where we, say, record the st_dev of the _index_ file, and if that has
> changed, we propagate that change to the st_dev of its contents?  I'd
> like to see something that works more efficiently than rescanning the
> whole disk every time I hibernate my computer.

Hmm. We shouldn't even be using st_dev any more.

How did you compile your git version? By default USE_STDEV should be off, 
and it's been that way for a long time (because st_dev is also not 
reliable on NFS etc).

		Linus

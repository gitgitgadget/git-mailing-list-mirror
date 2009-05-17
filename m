From: Heikki Orsila <shdl@zakalwe.fi>
Subject: On data structures and parallelism
Date: Sun, 17 May 2009 18:23:35 +0300
Message-ID: <20090517152335.GC11543@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 17 17:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5iip-0003nT-RA
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 17:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbZEQP4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 11:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbZEQP4K
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 11:56:10 -0400
Received: from zakalwe.fi ([80.83.5.154]:52287 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZEQP4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 11:56:09 -0400
X-Greylist: delayed 1952 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2009 11:56:09 EDT
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 064952BC69; Sun, 17 May 2009 18:23:36 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119398>

There was an interesting discussion at

http://realworldtech.com/forums/index.cfm?action=detail&id=98909&threadid=98430&roomid=2

that involves DAGs and decompression in Git. The problem is achieving 
parallelism. The following comment was made:

"And is it possible to store the block pointers from one object to 
another in uncompressed form?"

Is there a case in Git where an "object" could store SHA1 in 
uncompressed format, allowing prefetching the next object in chain 
before uncompressing the current object? Prefetching could increase 
parallelism (and speedup) in some cases.

A quick glance at Git's source code showed that commit objects are 
compressed. Having even a single parent SHA1 in uncompressed format 
would allow some prefetching. All but perhaps a few objects contain at 
least one parent SHA1 :-)

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd

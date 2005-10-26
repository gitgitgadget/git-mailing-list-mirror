From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Wed, 26 Oct 2005 16:44:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261637070.26622@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net> <435F4B05.4010702@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 16:49:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUmVq-0008CV-MB
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 16:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVJZOoO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbVJZOoO
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 10:44:14 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13035 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751497AbVJZOoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 10:44:13 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 08D7313F43E; Wed, 26 Oct 2005 16:44:12 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DFF899CCA9; Wed, 26 Oct 2005 16:44:11 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CA4B29AB53; Wed, 26 Oct 2005 16:44:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4F7FC13F43C; Wed, 26 Oct 2005 16:44:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435F4B05.4010702@op5.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10668>

Hi,

On Wed, 26 Oct 2005, Andreas Ericsson wrote:

> I'd be more worried about the fact that the kilobytes count is way off 
> as it is. du (at least from coreutils-5.2.1) rounds up to nearest 
> kilobyte *for each file* when printing kb-count.

The rationale behind this: You want to know how much space it takes on 
your hard disk. Remember, git-count-objects should give you a clue whether 
to repack or not.

Actually, "du -k" in my tests rounds up to nearest block size or kilobytes 
(whichever is greater): For example, "du -k" on a very small file (53 
bytes) says "1" on an ext2fs yields "1", "4" on hfs, and 32 on a big 
FAT32. Of course, you may get different values, since the block sizes 
sometimes depend on the total size of the media.

Hth,
Dscho

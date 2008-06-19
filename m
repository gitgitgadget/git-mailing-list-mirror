From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 19 Jun 2008 10:58:58 +0200
Message-ID: <200806191058.58074.johan@herland.net>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 11:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9G0R-0000dO-Ol
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 11:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbYFSI7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYFSI7l
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 04:59:41 -0400
Received: from smtp.getmail.no ([84.208.20.33]:38776 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbYFSI7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 04:59:40 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2P00IEBCYSFH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 19 Jun 2008 10:59:16 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2P000BOCYA86C0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 19 Jun 2008 10:58:58 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2P00JRECYATY40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 19 Jun 2008 10:58:58 +0200 (CEST)
In-reply-to: <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85460>

On Wednesday 18 June 2008, Junio C Hamano wrote:
> [New Topics]
>
> * jh/clone-packed-refs (Sun Jun 15 16:06:16 2008 +0200) 4 commits
>  - Teach "git clone" to pack refs
>  - Prepare testsuite for a "git clone" that packs refs
>  - Move pack_refs() and friends into libgit
>  - Incorporate fetched packs in future object traversal
>
> Would be helpful cloning from a repository with insanely large number of
> refs.

The first 3 patches (i.e. the bottom 3 in the above list) might be 
considered general cleanup patches, and are independent of each other (i.e. 
you might want to include them on their own merit, independently of patch 
#4).

The final patch doesn't make any difference for "regular" repos (e.g. 
git.git with ~200 refs) on Linux (see below). But once the number of refs 
increase, the difference becomes obvious.

Here are some numbers to give some more context:

All tests done on 64-bit quad-core Linux, cloning locally (hard-linked):

~200 refs (git.git):
current next:    0.2s
w/above patches: 0.2s

~1000 refs (test repo):
current next:    0.16s
w/above patches: 0.05s

~11000 refs (test repo):
current next:    1.3s
w/above patches: 0.3s

~26000 refs (actual repo at $dayjob):
current next:    3.2s
w/above patches: 0.8s


Regards,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net

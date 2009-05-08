From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Fri, 8 May 2009 10:44:02 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905081038160.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
 <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain>
 <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 08 19:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2U9g-00019m-Hi
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 19:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162AbZEHRqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 13:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbZEHRqc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 13:46:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53645 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756510AbZEHRqa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 13:46:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48Hi3la029188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2009 10:44:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48Hi2VV028174;
	Fri, 8 May 2009 10:44:02 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118621>



On Fri, 8 May 2009, Brandon Casey wrote:
> 
> Something is definitely up.
> 
> I provided timing results for your original preload_cache implementation
> which affected status and diff, which was part of the justification for
> merging it in.
> 
>    http://article.gmane.org/gmane.comp.version-control.git/100998
> 
> You can see that cold cache system time for 'git status' went from 0.36 to
> 0.52 seconds.  Fine.  I just ran it again, and now I'm getting system time
> of 10 seconds!  This is the same machine.

Grr.

> OS: Centos4.7
> 
> $ cat /proc/version
> Linux version 2.6.9-78.0.17.ELsmp (mockbuild@builder16.centos.org) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-9)) #1 SMP Thu Mar 12 20:05:15 EDT 2009

Ok, if that's really the true kernel version (2.6.9), then that's some 
ancient kernel there. At the same time it's obviously been recompiled 
recently, so it got updated. At a guess, something got screwed up. But I 
have absolutely _no_ way to even guess what kernel patches centos puts in 
their ancient kernel builds.

Perhaps a centos bugzilla entry might be appropriate? Somebody there might 
know what changed.

Of course, it _could_ be an external change too, where the NFS server or 
timing changed just enough to trigger a pre-existing issue. But that would 
be pretty unlikely.

			Linus

From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] 75d8ff1 fails on SunOS 5.9 (missing hsterror) from ba505322
Date: Tue, 12 Jun 2007 09:13:40 -0700
Message-ID: <86ejkh40cr.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 18:13:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy902-0007DJ-Ts
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 18:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbXFLQNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 12:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbXFLQNl
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 12:13:41 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:1271 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXFLQNl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 12:13:41 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C54D71DE68A; Tue, 12 Jun 2007 09:13:40 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.1; tzolkin = 13 Imix; haab = 9 Zotz
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49969>


    CC fetch-pack.o
fetch-pack.c: In function `get_pack':
fetch-pack.c:532: warning: int format, pid_t arg (arg 3)
    LINK git-fetch-pack
Undefined                       first referenced
 symbol                             in file
hstrerror                           libgit.a(connect.o)
ld: fatal: Symbol referencing errors. No output written to git-fetch-pack
collect2: ld returned 1 exit status
make: *** [git-fetch-pack] Error 1

I suspect this broke in ba505322 when connect.c added hsterror().

Yes, bumping to g18bece works fine.  So it looks like we need a compat
hsterror(), or it should be removed or ifdef'ed somehow.  Paging Alex Riesen?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!

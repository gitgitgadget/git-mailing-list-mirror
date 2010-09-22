From: Seth Robertson <in-gitvger@baka.org>
Subject: ANNOUNCE git-what-branch (was Re: Find out on which branch a commit was originally made)
Date: Wed, 22 Sep 2010 12:35:49 -0400
Message-ID: <201009221635.o8MGZnLD024629@no.baka.org>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de> <4C973E5B.4090201@gmail.com> <4C9782A3.5010005@gmail.com> <201009210015.o8L0FcJt020691@no.baka.org>
        <4C981475.10404@gmail.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 18:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OySIg-0001id-5s
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 18:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab0IVQf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 12:35:58 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:45353 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab0IVQf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 12:35:57 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8MGZoUJ024916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Sep 2010 12:35:51 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8MGZnLD024629;
	Wed, 22 Sep 2010 12:35:49 -0400
In-reply-to: <4C981475.10404@gmail.com>
Comments: In reply to a message from "Artur Skawina <art.08.09@gmail.com>" dated "Tue, 21 Sep 2010 04:12:05 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156807>


In message <4C981475.10404@gmail.com>, Artur Skawina writes:

    $ time git-what-branch 1f9c381fa3e0b9b9042e310c69df87eaf9b46ea4
    1f9c381fa3e0b9b9042e310c69df87eaf9b46ea4 first merged onto v2.6.32.n using the following minimal path:
      v2.6.12-rc3-450-g1f9c381 merged up at v2.6.12-rc4-39-gad34ea2 (Fri May 20 22:27:44 2005)
      v2.6.12-rc4-39-gad34ea2 merged up at v2.6.12-rc3-590-gbfd4bda (Thu May  5 14:59:37 2005)
      v2.6.12-rc3-590-gbfd4bda merged up at v2.6.12-rc3-461-g84e48b6 (Wed May  4 00:27:24 2005)
      v2.6.12-rc3-461-g84e48b6 is on v2.6.32.n
    18m29.771s user   0m29.681s system   18m4.897s elapsed   105.03% CPU

I found two minor bugs in my script which caused it to return something
other than the most optimal path in all cases.  I then got crazy and
added a --date-order and --topo-order -- the former orders paths by
commit date and the latter orders paths by the number of merges that
took place (and then by commit date) and then path summarization if
multiple branches were obtained through the same path.

    Results are similar, that one extra merge i'll have to take a look at
    later, but the cost difference...

As we discussed privately, the cost difference is because instead of
looking at just one branch, it is looking at 150+ branches.  If you
use --reference-branch to specify the one branch you are looking at,
it takes a much more reasonable 15-20 seconds.  Likewise if you select
a commit more recent than 2005, the number of branches that it could
apply to goes down and the command runs faster.

Also in my most recent version I was able to find an even shorter path
(two merges to master).

I have cleaned everything up and made a formal release out of it.

It is available at:  http://github.com/SethRobertson/git-what-branch

					-Seth Robertson

From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsserver: avoid warning about active db handles
Date: Wed, 26 Jul 2006 00:07:54 +1200
Message-ID: <44C6099A.5010205@catalyst.net.nz>
References: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 14:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5LhZ-0002h3-85
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 14:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWGYMHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 08:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWGYMHs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 08:07:48 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:7344 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751227AbWGYMHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 08:07:47 -0400
Received: from socrates.catalyst.net.nz ([202.78.240.34] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G5LhQ-0005bY-FQ; Wed, 26 Jul 2006 00:07:44 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24172>

Johannes Schindelin wrote:

> Turns out that DBD::SQLite does not favour preparing statements which are
> never executed. So, turn all 4 statements, which were prepared _always_,
> into methods, like the other 12 prepared statements.

Can you give me a reference for that "does not favour preparing 
statements"? I have some vague recollection of timing 
prepared/unprepared inserts and getting a huge difference in 
performance. Looking at the source of SQLite.pm doesn't clarify much -- 
prepare_cached is actually implemented by DBI, the driver doesn't need 
to implement it. Anyway, I guess it has to do with the cost of preparing 
it in the lower level driver anyway.


> 	Now, the only warning left is the gzip one...

That's harder. I wonder whether using libgit's XS module we can now get 
libgit to give us a gzipped file directly. I guess it only has 
performance savings for unpacked repos.

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

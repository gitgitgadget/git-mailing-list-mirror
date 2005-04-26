From: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 15:52:23 -0400
Message-ID: <200504261552.24100.mason@suse.com>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504260939440.18901@ppc970.osdl.org> <200504261339.34680.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike Taht <mike.taht@timesys.com>, Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 21:49:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQW1f-0004MG-Nn
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDZTwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVDZTwb
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:52:31 -0400
Received: from ns1.suse.de ([195.135.220.2]:20916 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261758AbVDZTw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:52:27 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 06886160D04B;
	Tue, 26 Apr 2005 21:52:27 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <200504261339.34680.mason@suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 26 April 2005 13:39, Chris Mason wrote:

> As an example, here's the time to apply 300 patches on ext3.  This was with
> my packed patches applied, but vanilla git should show similar percentage
> differences.
>
> data=writeback  32s
> data=ordered    44s
>
> With a long enough test, data=ordered should fall into the noise, but 10-40
> second runs really show it.

I get much closer numbers if the patches directory is already in 
cache...data=ordered means more contention for the disk when trying to read 
the patches.  

If the patches are hot in the cache data=writeback and data=ordered both take 
about 30s.  You still see some writes in data=writeback, but these are mostly 
async log commits.  

The same holds true for vanilla git as well, although it needs 1m7s to apply 
from a hot cache (sorry, couldn't resist the plug ;)

-chris

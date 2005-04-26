From: Chris Mason <mason@suse.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 14:18:18 -0400
Message-ID: <200504261418.18825.mason@suse.com>
References: <20050426004111.GI21897@waste.org> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Mike Taht <mike.taht@timesys.com>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:14:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUZK-0006pN-SD
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDZSSh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZSSh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:18:37 -0400
Received: from ns.suse.de ([195.135.220.2]:53993 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261577AbVDZSSY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:18:24 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7AE0C160BCAB;
	Tue, 26 Apr 2005 20:18:21 +0200 (CEST)
To: Magnus Damm <magnus.damm@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <aec7e5c305042609231a5d3f0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 26 April 2005 12:23, Magnus Damm wrote:

> Well, maybe I misunderstood everything, but I thought you were
> applying a lot of patches and complained that it took a lot of time
> due to the data order.
>
> When I applied a lot of patches to the kernel recently the cpu load
> dropped to zero after a while and the HD worked hard a sec or two and
> then things came back again. My primitive guess is that it was because
> the ext3 journal became full. To workaround this fact I started
> hacking on this in-memory patcher.

It looks like you'll only see the commits on ext3 when the log fills, and on 
reiser3 you'll see it every 5 seconds or when the log fills.  With the 
default mount options, both ext3 and reiser will flush the data blocks at the 
same time they are writing the metadata.

The easiest way to get around this is to mount -o data=writeback on 
ext3/reiser, but you'll still have to wait for the data blocks eventually.  

-chris

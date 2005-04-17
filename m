From: Paul Jackson <pj@sgi.com>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 12:25:17 -0700
Organization: SGI
Message-ID: <20050417122517.4b12faea.pj@sgi.com>
References: <Pine.LNX.4.21.0504171108060.30848-100000@iabervon.org>
	<Pine.LNX.4.21.0504171131230.30848-100000@iabervon.org>
	<20050417174736.GA1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:24:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFMq-0002bm-PT
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVDQT1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDQT06
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:26:58 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60098 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261427AbVDQTZi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:25:38 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3HJmwnB010504;
	Sun, 17 Apr 2005 12:49:01 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3HJPLlU15479253;
	Sun, 17 Apr 2005 12:25:22 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417174736.GA1461@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr wrote:
> BTW, I'd just use access(F_OK) instead of stat() it I don't care about

That's a bad habit to get into.

access(2) checks with the process's real uid and gid, rather than with
the effective ids as is done when actually attempting an operation. 
This is to allow set-UID programs to easily determine the invoking
user's authority.

Using access(2) when it shouldn't be used is a common source of bugs.

I recommend _only_ using it when you require exactly the above real vs.
effective id behaviour.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

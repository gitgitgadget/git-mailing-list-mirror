From: Paul Jackson <pj@sgi.com>
Subject: Re: [4/5] Add option for hardlinkable cache of extracted blobs
Date: Sun, 17 Apr 2005 18:35:08 -0700
Organization: SGI
Message-ID: <20050417183508.15beb1fd.pj@sgi.com>
References: <20050417195935.GI1461@pasky.ji.cz>
	<Pine.LNX.4.21.0504171600310.30848-100000@iabervon.org>
	<20050417201856.GJ1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:32:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNL6r-0005Ut-9L
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVDRBfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDRBfV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:35:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37523 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261577AbVDRBfQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:35:16 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3I1wpf0012635;
	Sun, 17 Apr 2005 18:58:51 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3I1ZClU15551981;
	Sun, 17 Apr 2005 18:35:13 -0700 (PDT)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417201856.GJ1461@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr wrote:
> The documentation I've got says:
> 
> "R_OK,  W_OK  and  X_OK request checking whether the file exists and has
>  read, write and execute permissions, respectively.  F_OK just requests
>  checking for the existence of the file."

You don't exactly say it, but I'm guessing that you think that this
documentation is stating that F_OK checks for the existance of the file
_regardless_ of path access permissions.

No so.  Write your own little test program, and/or read the kernel source.

Even if the file exists, if its directory entry is not accessible to the
_real_ uid/gid, access F_OK will fail.  If the problem is a lack of
seach permissions on some directory in the path, the errno will be
EACCES.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

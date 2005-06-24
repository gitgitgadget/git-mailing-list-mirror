From: Christopher Li <hg@chrisli.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 08:19:25 -0400
Message-ID: <20050624121925.GB9519@64m.dyndns.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <20050624133952.GB7445@thunk.org> <4d8e3fd3050624064620a4945e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <andrea@suse.de>,
	Petr Baudis <pasky@ucw.cz>, mercurial@selenic.com,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 17:25:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlq3F-0007yX-2Y
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 17:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbVFXPbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 11:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVFXPbb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 11:31:31 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47492 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262675AbVFXPb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 11:31:27 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005062415312601200hi177e>; Fri, 24 Jun 2005 15:31:26 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id B21BC3F17F; Fri, 24 Jun 2005 08:19:25 -0400 (EDT)
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Content-Disposition: inline
In-Reply-To: <4d8e3fd3050624064620a4945e@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 24, 2005 at 03:46:21PM +0200, Paolo Ciarrocchi wrote:
> > 
> > Which do you think is going to be faster to operate from a cold start
> > using 4200 rpm laptop drives?  :-)
> > 
> >                                                - Ted
> 
> That's quite intersting, what the rational behind such a difference in
> terms of disk occupation ?
>

Let me see. Mercurial using delta or full storage for the repository.
It insert a full node when it detect that delta it need to reach
certain node is too big. It just like MPEG movies, most of the frame
is delta to the previous frame.  Once a while you have full frame to
allow you seek to.

But git has delta as well right? Another factor is that all file has
same path in mercurial using the same storage file. So in mercurial
it has far less file to store in the repository. Each file has two repository
files, the data storage file and the index file. Remember that file system
like ext3 is using blocks, if you store very small stuff on a file, it is
still going to take at least one block on disk. So that will defeat the delta
compression if the delta is always on a new file.


Chris


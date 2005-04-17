From: Paul Jackson <pj@sgi.com>
Subject: Re: Storing permissions
Date: Sun, 17 Apr 2005 01:13:01 -0700
Organization: SGI
Message-ID: <20050417011301.0b341d5d.pj@sgi.com>
References: <20050416230058.GA10983@ucw.cz>
	<118833cc05041618017fb32a2@mail.gmail.com>
	<20050416183023.0b27b3a4.pj@sgi.com>
	<Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
	<42620092.9040402@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, mwelinder@gmail.com, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 10:10:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN4r0-0000LG-Ja
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 10:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDQINw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 04:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVDQINw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 04:13:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:44957 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261280AbVDQINu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 04:13:50 -0400
Received: from omx3.sgi.com (omx3-ext.sgi.com [192.48.171.20])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j3H8DksS002262
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 01:13:47 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H8aiPO009821;
	Sun, 17 Apr 2005 01:36:47 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H8D5lU15333004;
	Sun, 17 Apr 2005 01:13:06 -0700 (PDT)
To: dwheeler@dwheeler.com
In-Reply-To: <42620092.9040402@dwheeler.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David wrote:
> There's a minor reason to write out ALL the perm bit data, but

There's always the 'configurable option' approach.

Someone, I doubt Linus will have any interest in it, could volunteer to
make the masks of st_mode, used when storing and recovering file
permissions, be configurable by some environment variable settings,
which default to whatever Linus provided.

But, in general, if you want a generalized backup system, git is not it.

Git skips all files whose name begins with the dot '.' character, and
anything that is not a regular file or directory.  Git makes no
concessions to working adequately on file systems lacking normal inode
numbers (such as smb, fat, vfat).  Git obscures the archive format a
modest amount, for pure speed and to encourage use only via appropriate
wrappers.  Git is tuned for blazing speed at the operations that Linus
needs, not for trivial recovery, using the most basic tools, under harsh
circumstances.

The basic idea of using such an 'object database' (though I dislike that
term -- too high falutin vague) of files stored by their hash is a
good one.  But a different core implementation is needed for backups.

I have one that I use for my own backups, but it is written in Python,
and uses MD5, one or the other of which likely disqualifies it from
further consideration by half the readers of this list.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

From: Andrew Morton <akpm@osdl.org>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 15:56:09 -0700
Message-ID: <20050426155609.06e3ddcf.akpm@osdl.org>
References: <20050426004111.GI21897@waste.org>
	<200504260713.26020.mason@suse.com>
	<aec7e5c305042608095731d571@mail.gmail.com>
	<200504261138.46339.mason@suse.com>
	<aec7e5c305042609231a5d3f0@mail.gmail.com>
	<20050426135606.7b21a2e2.akpm@osdl.org>
	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: magnus.damm@gmail.com, mason@suse.com, mike.taht@timesys.com,
	mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:51:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQYtF-00065Z-WC
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVDZWz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 18:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDZWz5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 18:55:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:18400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261808AbVDZWzt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 18:55:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QMtes4002324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 15:55:41 -0700
Received: from localhost.localdomain (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3QMtdr5015877;
	Tue, 26 Apr 2005 15:55:39 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 26 Apr 2005, Andrew Morton wrote:
> > 
> > Mounting as ext2 is a useful technique for determining whether the fs is
> > getting in the way.
> 
> What's the preferred way to try to convert a root filesystem to a bigger
> journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
> then the appropriate magic tune2fs? Or what?
> 

Gee, it's been ages.  umm,

- umount the fs
- tune2fs -O ^has_journal /dev/whatever
- fsck -fy                              (to clean up the now-orphaned journal inode)
- tune2fs -j -J size=nblocks    (normally 4k blocks)
- mount the fs


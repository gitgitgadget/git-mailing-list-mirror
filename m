From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 10:30:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171018410.30848-100000@iabervon.org>
References: <20050416210513.1ba26967.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dwheeler@dwheeler.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 16:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNAjh-00077t-UX
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 16:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVDQOa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVDQOa3
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 10:30:29 -0400
Received: from iabervon.org ([66.92.72.58]:32263 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261320AbVDQOaX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 10:30:23 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNAnG-0004RD-00; Sun, 17 Apr 2005 10:30:38 -0400
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050416210513.1ba26967.pj@sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Paul Jackson wrote:

> David wrote:
> > It's a trade-off, I know.
> 
> So where do you recommend we make that trade-off?

So why do we have to be consistant? It seems like we need a standard
format for these reasons:

 - We use rsync to interact with remote repositories, and rsync won't
   understand if they aren't organized the same way. But I'm working on
   having everything go through git-specific code, which could understand
   different layouts.

 - Everything that shares a local repository needs to understand the
   format of that repository. But the filesystem constraints on the local
   repository will be the same regardless of who is looking, so they'd all
   expect the same format anyway.

So my idea is, once we're using git-smart transfer code (which can verify
objects, etc.), add support for different implementations of 
sha1_file_name suitable for different filesystems, and vary based either
on a compile-time option or on a setting stored in the objects
directory. The only thing that matters is that repositories on
non-special web servers have a standard format, because they'll be serving
objects by URL, not by sha1.

	-Daniel
*This .sig left intentionally blank*


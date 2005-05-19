From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/4] Pulling refs files
Date: Wed, 18 May 2005 23:19:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505182259060.30848-100000@iabervon.org>
References: <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 19 05:20:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYbZX-0004gW-0r
	for gcvg-git@gmane.org; Thu, 19 May 2005 05:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVESDUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbVESDUU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 23:20:20 -0400
Received: from iabervon.org ([66.92.72.58]:18180 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262463AbVESDTk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 23:19:40 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DYbYr-0002HV-00; Wed, 18 May 2005 23:19:01 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0505171802570.30848-100000@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 17 May 2005, Daniel Barkalow wrote:

> I think I'll get to implementing it Wednesday night. I might be able to
> get the first step done tonight (my previous patch, except with the
> transfer applying to arbitrary files).

Upon further consideration, I think there are three things that pull
implementation needs to handle:

 1) fetching object files by hash, validating them, and writing them to
    the local objects directory
 2) fetching reference files by name, and making them available to the
    local program without writing them to disk at all.
 3) fetching other files by name and writing them to either the
    corresponding filename or a provided replacement.

I had thought that (2) could be done as a special case of (3), but I think
that it has to be separate, because (2) just returns the value, while
(3) can't just return the contents, but has to write it somewhere, since
it isn't constrained to be exactly 20 bytes.

So I think I'd like to do essentially the original series, slightly
rearranged and with a few edits, and then add (3) afterwards; this should
be easy once the rpush/rpull changes to make the protocol extensible are
in place.

I'll also do additional (independant) patches to provide an expected
starting point and lock things appropriately.

	-Daniel
*This .sig left intentionally blank*


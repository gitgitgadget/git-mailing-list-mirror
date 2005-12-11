From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow saving an object from a pipe
Date: Sat, 10 Dec 2005 18:59:13 -0800
Message-ID: <7v64pwuyny.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512101724290.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 04:00:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElHQk-0006Wb-6Q
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 03:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbVLKC7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 21:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbVLKC7P
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 21:59:15 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:25768 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932741AbVLKC7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 21:59:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211025826.SEHB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 21:58:26 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13481>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In order to support getting data into git with scripts, this adds a
> --stdin option to git-hash-object, which will make it read from stdin.

Thanks, will apply.

To be honest, though, I am still debating myself about the merit
of not having to have a temporary file.  Because we need the
size of the blob available before starting to hash (i.e. we
cannot say "atend"), index_pipe ends up keeping the whole blob
data in memory, which is not much better than the caller storing
it in a temporary file and driving the normal hash-object from
the command line anyway.

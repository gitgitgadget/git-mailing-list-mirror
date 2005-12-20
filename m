From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Tue, 20 Dec 2005 15:43:56 -0800
Message-ID: <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 21 00:45:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eor9F-00019c-Pq
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 00:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVLTXn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 18:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVLTXn6
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 18:43:58 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:972 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932204AbVLTXn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 18:43:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051220234153.BFQS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Dec 2005 18:41:53 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 21 Dec 2005 12:25:07 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13857>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Since git changed to creating the objects subdirectories "on demand",
> these are created 755 regardless of the user's umask. This is quite
> inconvenient in ("cvs style") team-shared repositories, which work
> great otherwise.

Hmph.

I have 002 as umask. .git/objects or .git/objects/[0-9a-f]{2}
directories are created 0775 for me.

Do we have hardcoded 0755 that we need to change to 0777
somewhere?  sha1_file.c::safe_create_leading_directories() is
the primary code that creates directories lazily, and we mkdir
with 0777 there.
